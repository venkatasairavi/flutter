import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:time_machine/time_machine.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../app/theme/app_style.dart';
import '../../../../../core/services/cache.service.dart';
import '../../../../../utils/Utils/SimpleDateFormatConverter.dart';
import '../../../../../utils/Utils/Utils.dart';
import '../../dashboardhomeview/notifier/doctornotifier.dart';

import '../../patientDashboardScreens/messages/notifier/MessagesNotifier.dart';

class DoctorchattingScreen extends StatefulWidget {
  const DoctorchattingScreen({Key? key}) : super(key: key);

  @override
  State<DoctorchattingScreen> createState() => _DoctorchattingScreenState();
}

class _DoctorchattingScreenState extends State<DoctorchattingScreen> {
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  final ScrollController controller = ScrollController();
  TextEditingController msgController = TextEditingController();

  late StompClient client;
  String? jwtData;

  var pageNum = 10;

  var keypadVisibility = false, sendBtn = false, topbarVisibility = false;
  var data;
  var patientGuId = '',
      userGuId = '',
      timeZone = "",
      docPatGuId = '',
      statusValue = 'Unavailable';
  var newItems;

  List<dynamic> items = [];
  var ivDoctorStatusColor = ColorConstant.redA400;

  final CacheService _cacheService = CacheService();

  @override
  void initState() {
    super.initState();
    tz();
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
    _userDetails();
  }

  void _userDetails() async {
    var userDetails = Provider.of<DoctorNotifier>(context, listen: false);
    var details = await userDetails.getUserDetails(context);
    patientGuId = details['docPatGuId'];
    userGuId = details['userGuId'];
    docPatGuId = details['docPatGuId'];
    fetch();

    // connectStomp();
  }

  Future fetch() async {
    var msg = Provider.of<MessagesNotifier>(context, listen: false);
    newItems = await msg.getDoctorPatientMsg(
        context: context,
        pageNum: pageNum,
        pageSize: 0,
        patientGuId: data[0],
        doctorGuId: docPatGuId);

    items.addAll(newItems["messages"].map<dynamic>((item) {
      return item;
    }));

    setState(() {
      keypadVisibility = true;
      topbarVisibility = true;
    });

    connectStomp();
  }

  Future getFile(String fileName) async {
    var file = Provider.of<MessagesNotifier>(context, listen: false);

    var data = await file.getFiles(context: context, fileName: fileName);

    launchURL(data.toString());
  }

  Future updateMsgUiid(String messageThreadGuId) async {
    var file = Provider.of<MessagesNotifier>(context, listen: false);
    var data = await file.updateMsgUiid(
        context: context, messageThreadGuId: messageThreadGuId);
  }

  Future fetch2() async {
    var msg = Provider.of<MessagesNotifier>(context, listen: false);
    newItems = await msg.getDoctorPatientMsg(
        context: context,
        pageNum: pageNum,
        pageSize: 0,
        patientGuId: data[0],
        doctorGuId: docPatGuId);

    if (items.isNotEmpty) {
      items.clear();
    }

    items.addAll(newItems["messages"].map<dynamic>((item) {
      return item;
    }));
    setState(() {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> connectStomp() async {
    jwtData = await _cacheService.readCache(key: "jwtdata");

    client = StompClient(
        config: StompConfig(
      url: 'wss://$domain/api/ws?token=' + jwtData!,
      onConnect: (StompFrame frame) {
        // print('onConnectCallback ${frame.body}');

        client.subscribe(
            destination: '/topic/chat/$docPatGuId', callback: onMessageReceive);

        client.subscribe(
            destination: '/topic/getStatus/$userGuId', callback: messageStatus);

        if (client.isActive) {
          Timer.periodic(const Duration(seconds: 5), (_) {
            client.send(
              destination: '/app/heartBeats',
              body: json.encode({
                'userGuid': userGuId,
                'lastActiveDate': SimpleDateFormatConverter.currentDate(),
                'timeZone': timeZone,
              }),
            );

            client.send(
              destination: '/app/heartBeat/request/${data[3]}',
              body: json.encode({
                'userGuid': userGuId,
                'timeZone': timeZone,
              }),
            );
          });
        }
      },
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(const Duration(seconds: 1));
        print('connecting...');
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      onStompError: (d) => print('error stomp'),
      onDisconnect: (f) => print('disconnected'),
      heartbeatOutgoing: const Duration(seconds: 1),
      heartbeatIncoming: const Duration(seconds: 1),
      // onDebugMessage: onDebugMsg
    ));

    client.activate();
  }

  void sendMessage() {
    var now = Instant.now();
    var uuid = const Uuid();
    var messageThreadGuId = uuid.v1();

    List<Map> msgData = [
      {
        "attachmentDTO": null,
        "callDuration": null,
        "isEdited": 'false',
        "isSeen": 'false',
        "message": msgController.text,
        "messageDeliveredTime": now.toString(),
        "messageGuId": data[4],
        "messageSeenTime": null,
        "messageSentTime": now.toString(),
        "messageThreadGuId": messageThreadGuId,
        "parentMessageThreadGuId": null,
        "sender": data[5],
        "type": 'MESSAGE',
      },
    ];

    dynamic temp = msgData[0];
    temp["attachmentDTO"] = {
      "attachmentGuId": null,
      "originalName": null,
      "attachmentLocation": null,
      "attachmentType": null,
      "typeGuId": null,
      "documentType": null
    };
    temp["isSeen"] = false;
    temp["isEdited"] = false;

    var dat = json.encode({
      'doctorGuId': patientGuId,
      'messageGuId': data[4],
      'patientGuId': data[0],
      'messages': msgData,
    });

    print("appChat" + dat + " " + data[0]);

    client.send(
      destination: '/app/chat/${data[0]}',
      body: dat,
    );

    items.add(temp);

    controller.animateTo(
      controller.position.maxScrollExtent * 1.5,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    // client.deactivate();
  }

  void onMessageReceive(StompFrame msg) async {
    var decodedData = await json.decode(json.encode(msg.body));
    fetch2();

    if (controller.hasClients) {
      final position = controller.position.maxScrollExtent;
      controller.animateTo(
        position,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    }

    print('onMessageReceive $decodedData');
  }

  void sendUpComingAppointmentUserGuidToServer() {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': data[3],
        'timeZone': timeZone,
      }),
    );
  }

  Future<void> refresh() async {
    print("REFRESH Triggered");
    List<dynamic> temp = [];

    pageNum += 10;
    var msg = Provider.of<MessagesNotifier>(context, listen: false);
    newItems = await msg.getDoctorPatientMsg(
        context: context,
        pageNum: pageNum,
        pageSize: 0,
        patientGuId: data[0],
        doctorGuId: docPatGuId);

    print("newtttttttttttttttttttttttttttttimeds");
    print(newItems);

    if (newItems["messages"].length != 0) {
      // copying onto 'temp' variable
      if (items.isNotEmpty) {
        setState(() {
          items.clear(); // clearing to add-in new data
        });
        items.forEach((element) {
          temp.add(element);
        });
      }

      items.addAll(newItems["messages"].map<dynamic>((item) {
        return item;
      }));

      items.addAll(temp);
    }
    print("ITEMS NEEEEWWWWW REFRESHHHHHHHHHHHHHHHHH");
    print(items);
    setState(() {});
  }

  Future<void> messageStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    final Map<String, dynamic> parsedData = await jsonDecode(decodedData);
    try {
      if (parsedData['status'] != null) {
        if (parsedData['status'] == 'Available') {
          if (SimpleDateFormatConverter.getTime(parsedData['lastActiveDate']) ==
              "just now") {
            ivDoctorStatusColor = ColorConstant.green;
            statusValue = 'Available';
          } else if (SimpleDateFormatConverter.getTime(
                  parsedData['lastActiveDate']) ==
              "2 minute ago") {
            ivDoctorStatusColor = ColorConstant.redA400;
            statusValue = 'Unavailable';
          } else {
            statusValue = 'Busy';
            ivDoctorStatusColor = ColorConstant.orange;
          }
        } else if (parsedData['status'] == 'Unavailable') {
          statusValue = 'Unavailable';
          ivDoctorStatusColor = ColorConstant.redA400;
        } else if (parsedData['status'] == 'Busy') {
          statusValue = 'Busy';
          ivDoctorStatusColor = ColorConstant.orange;
        }
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  // void onDebugMsg(String msg) {

  //   // if (msg.contains('>>> SEND') && msg.contains('/app/chat/')) {

  //   //   // setState(() {
  //   //   //   fetch2();
  //   //   // });
  //   // }

  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: ColorConstant.indigo800,
        body: Container(
          margin: const EdgeInsets.only(bottom: 50.0),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.gray50,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getHorizontalSize(0.00)),
                topRight: Radius.circular(getHorizontalSize(0.00)),
                bottomLeft: Radius.circular(getHorizontalSize(35.00)),
                bottomRight: Radius.circular(getHorizontalSize(35.00))),
          ),
          child: RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Visibility(
                        visible: topbarVisibility,
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(20.00),
                                    right: getHorizontalSize(26.00)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                          child: SvgPicture.asset(
                                              ImageConstant.imgBack2,
                                              fit: BoxFit.fill)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 15.0),
                                      child: Flexible(
                                        flex: 2,
                                        child: Text("Messages",
                                            style: TextStyle(
                                                color: ColorConstant.indigo800,
                                                fontSize: 18,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ],
                                )),
                            Wrap(children: [
                              Card(
                                // clipBehavior: Clip.antiAlias,
                                elevation: 10,
                                margin: const EdgeInsets.only(
                                    left: 18.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                    right: 18.0),
                                color: ColorConstant.whiteA700,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(getHorizontalSize(
                                  10.00,
                                ))),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              14.00,
                                            ),
                                            top: getVerticalSize(
                                              15.00,
                                            ),
                                            right: getHorizontalSize(
                                              14.00,
                                            ),
                                            bottom: getVerticalSize(
                                              14.72,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              IntrinsicHeight(
                                                  child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Stack(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        children: <Widget>[
                                                          SizedBox(
                                                              height: getSize(
                                                                  41.00),
                                                              width: getSize(
                                                                  41.00),
                                                              child: SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgUseravatar,
                                                                  fit: BoxFit
                                                                      .fill)),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  ivDoctorStatusColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            height: 10,
                                                            width: 10,
                                                          ),
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 3.0,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          data[1] +
                                                                  " " +
                                                                  data[2] ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(statusValue ?? '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black))
                                                    ],
                                                  ),
                                                ],
                                              )),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        )),
                    Flexible(
                      flex: 7,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        // color: Colors.black,
                        child: SingleChildScrollView(
                            reverse: true,
                            child: ListView.builder(
                                controller: controller,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < items.length) {
                                    final item = items[index];

                                    if (!item['isSeen']) {
                                      updateMsgUiid(item['messageThreadGuId']);
                                    }

                                    if (item['sender'] == 'DOCTOR') {
                                      if (item['type'] == 'MESSAGE') {
                                        return Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(children: [
                                              Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .blueLighter,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child:
                                                        Text(item['message']),
                                                  ))
                                            ]));
                                      } else if (item['type'] == 'FILE') {
                                        return Align(
                                            alignment: Alignment.topRight,
                                            child: Wrap(children: [
                                              Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .blueLighter,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0))),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.00),
                                                        child: SizedBox(
                                                          height:
                                                              getVerticalSize(
                                                                  15.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  15.00),
                                                          child: const Icon(
                                                            Icons
                                                                .file_copy_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0,
                                                                bottom: 10.0,
                                                                left: 5.0,
                                                                right: 5.0),
                                                        child: Text(item[
                                                                'attachmentDTO']
                                                            ['originalName']),
                                                      )),
                                                      GestureDetector(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.00),
                                                            child: SizedBox(
                                                              child: SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgDelete,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            getFile(item[
                                                                    'attachmentDTO']
                                                                [
                                                                'attachmentLocation']);
                                                            // launchURL();
                                                          })
                                                    ],
                                                  ))
                                            ]));
                                      } else {
                                        return Container();
                                      }
                                    } else if (item['sender'] == 'PATIENT') {
                                      if (item['type'] == 'MESSAGE') {
                                        return Align(
                                            alignment: Alignment.topLeft,
                                            child: Wrap(children: [
                                              Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .blueLighter,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10.0))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child:
                                                        Text(item['message']),
                                                  ))
                                            ]));
                                      } else if (item['type'] == 'FILE') {
                                        return Align(
                                            alignment: Alignment.topLeft,
                                            child: Wrap(children: [
                                              Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .blueLighter,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      10.0))),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.00),
                                                        child: SizedBox(
                                                          height:
                                                              getVerticalSize(
                                                                  15.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  15.00),
                                                          child: const Icon(
                                                            Icons
                                                                .file_copy_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10.0,
                                                                bottom: 10.0,
                                                                left: 5.0,
                                                                right: 5.0),
                                                        child: Text(item[
                                                                'attachmentDTO']
                                                            ['originalName']),
                                                      )),
                                                      GestureDetector(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.00),
                                                            child: SizedBox(
                                                              child: SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgDelete,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            print('dsa');
                                                            getFile(item[
                                                                    'attachmentDTO']
                                                                [
                                                                'attachmentLocation']);
                                                            // launchURL();
                                                          })
                                                    ],
                                                  ))
                                            ]));
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                })),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Visibility(
                            visible: keypadVisibility,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: getHorizontalSize(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                90,
                                        child: Card(
                                          elevation: 10,
                                          color: ColorConstant.whiteA700,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                            5.00,
                                          ))),
                                          child: TextFormField(
                                              controller: msgController,
                                              // onTap: () {
                                              //   controller.animateTo(
                                              //       controller.position
                                              //           .maxScrollExtent,
                                              //       duration: const Duration(
                                              //           milliseconds: 300),
                                              //       curve: Curves.easeOut);
                                              // },
                                              onChanged: (text) {
                                                if (text.isEmpty) {
                                                  setState(() {
                                                    sendBtn = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    sendBtn = true;
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Type something here..",
                                                  hintStyle: AppStyle
                                                      .textstylelatomedium143
                                                      .copyWith(
                                                          fontSize:
                                                              getFontSize(14.0),
                                                          color: ColorConstant
                                                              .bluegray600Af),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          getHorizontalSize(
                                                              6.00)),
                                                      borderSide: BorderSide(
                                                          color: ColorConstant
                                                              .black90040,
                                                          width: 1)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          getHorizontalSize(6.00)),
                                                      borderSide: BorderSide(color: ColorConstant.black90040, width: 1)),
                                                  filled: true,
                                                  fillColor: ColorConstant.gray100,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.only(top: getVerticalSize(15.00), bottom: getVerticalSize(15.00), left: getVerticalSize(15.00))),
                                              style: TextStyle(color: ColorConstant.bluegray600Af, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Visibility(
                                              visible: sendBtn,
                                              child: GestureDetector(
                                                child: SizedBox(
                                                    width: 45,
                                                    height: 45,
                                                    child: SvgPicture.asset(
                                                      ImageConstant.imgButton,
                                                      fit: BoxFit.cover,
                                                    )),
                                                onTap: () {
                                                  if (sendBtn) {
                                                    sendMessage();
                                                    msgController.text = "";
                                                    setState(() {
                                                      sendBtn = false;
                                                    });
                                                  }
                                                },
                                              )),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  ])),
        ));
  }
}
