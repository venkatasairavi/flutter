import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/messages/notifier/MessagesNotifier.dart';
import 'package:provider/provider.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/theme/app_style.dart';
import '../../../../../core/services/cache.service.dart';
import '../../../../../utils/Utils/SimpleDateFormatConverter.dart';

import '../../../../../utils/Utils/Utils.dart';
import '../../dashboard/model/UserDetialsModel.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<dynamic> items = [];
  List<dynamic> searchedUsers = [];
  var searchcontoller = TextEditingController();
  final controller = ScrollController();
  late StompClient client;
  String? jwtData;
  var timeZone;
  var crossIcon = false;
  final CacheService _cacheService = CacheService();
  late Map<String, dynamic> msgStatusParsedData = <String, dynamic>{};

  var msgStatus = ColorConstant.redA400;
  var userGuId = '';

  _quaryUsers(String value) {
    //value = value.toLowerCase();

    setState(() {
      searchedUsers = items.where((user) {
        var usertitle = user["userFirstName"]
            .toLowerCase()
            .contains(value.toLowerCase().trim());
        print(usertitle);
        return usertitle;
      }).toList();
    });

    searchedUsers.forEach((element) {
      print(element);
    });
  }

/*  _onTextChanged(String value) {
    historySearchData = value;
    fetch();
  }
  */
  @override
  void initState() {
    super.initState();
    tz();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    var ud = await _cacheService.readCache(key: "userDetails");

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);
      userGuId = user.userGuId!;
    }

    var msg = Provider.of<MessagesNotifier>(context, listen: false);
    var newItems = await msg.getMessages(context: context);

    items.addAll(newItems.map<dynamic>((item) {
      return {
        "lastMessage": item["lastMessage"] ?? '',
        "lastMessageTime": item["lastMessageTime"] ?? '',
        "userFirstName": item["userFirstName"] ?? '',
        "userLastName": item["userLastName"] ?? '',
        "numOfUnreadMsgs": item["numOfUnreadMsgs"] ?? '',
        "docPatGuId": item["docPatGuId"] ?? '',
        "userGuId": item["userGuId"] ?? '',
        "messageGuId": item["messageGuId"] ?? '',
      };
    }));

    // print('lastMessageTime ${SimpleDateFormatConverter.timeZoneSet(items[0]['lastMessageTime'])}');
    setState(() {});
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
    fetch();
    connectStomp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.indigo800,
            body: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              width: double.infinity,
              //height:  MediaQuery.of(context).size.height,
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
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: size.width,
                              margin:
                                  EdgeInsets.only(top: getVerticalSize(30.00)),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(26.00),
                                      right: getHorizontalSize(136.00),
                                      bottom: getVerticalSize(0)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                            height: getVerticalSize(38.00),
                                            width: getHorizontalSize(35.00),
                                            child: SvgPicture.asset(
                                                ImageConstant.imgVector6,
                                                fit: BoxFit.fill)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: getVerticalSize(7.00),
                                                bottom: getVerticalSize(7.00)),
                                            child: Text("Messages",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .textstylelatomedium181
                                                    .copyWith(
                                                        fontSize:
                                                            getFontSize(18),
                                                        height: 1.33))),
                                      ])))),
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(14.00),
                              top: getVerticalSize(24.00),
                              right: getHorizontalSize(14.00)),
                          child: SizedBox(
                              height: getVerticalSize(46.00),
                              child: TextFormField(
                                  onChanged: _quaryUsers,
                                  controller: searchcontoller,
                                  decoration: InputDecoration(
                                      hintText: "Search Messages",
                                      hintStyle: AppStyle.textstylelatomedium143.copyWith(
                                          fontSize: getFontSize(14.0),
                                          color: ColorConstant.bluegray600Af),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              getHorizontalSize(6.00)),
                                          borderSide: BorderSide(
                                              color: ColorConstant.indigo200,
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              getHorizontalSize(6.00)),
                                          borderSide: BorderSide(
                                              color: ColorConstant.indigo200,
                                              width: 1)),
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: getHorizontalSize(14.00),
                                              right: getHorizontalSize(10.00)),
                                          child: SizedBox(
                                              height: getSize(20.00),
                                              width: getSize(20.00),
                                              child:
                                                  SvgPicture.asset(ImageConstant.imgSearchicon1, fit: BoxFit.contain))),
                                      prefixIconConstraints: BoxConstraints(minWidth: getSize(20.00), minHeight: getSize(20.00)),
                                      filled: true,
                                      fillColor: ColorConstant.gray100,
                                      suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: getHorizontalSize(14.00), right: getHorizontalSize(10.00)),
                                          child: SizedBox(
                                              height: getSize(20.00),
                                              width: getSize(20.00),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: crossIcon == true
                                                      ? Colors.red
                                                      : Colors.white70,
                                                ),
                                                onPressed: () {
                                                  searchedUsers.clear();
                                                  searchcontoller.clear();
                                                  setState(() {
                                                    crossIcon = false;
                                                    searchcontoller.text = '';
                                                  });
                                                },
                                              ))),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(top: getVerticalSize(18.00), bottom: getVerticalSize(18.00))),
                                  style: TextStyle(color: ColorConstant.bluegray600Af, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)))),
                      Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                controller: controller,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchcontoller.text.isNotEmpty
                                    ? searchedUsers.length
                                    : items.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < items.length) {
                                    final item = items[index];

                                    if (msgStatusParsedData.isNotEmpty) {
                                      if (msgStatusParsedData['userGuid'] ==
                                          item['userGuId']) {
                                        if (msgStatusParsedData['status'] !=
                                            null) {
                                          if (msgStatusParsedData['status'] ==
                                              'Available') {
                                            if (SimpleDateFormatConverter
                                                    .getTime(msgStatusParsedData[
                                                        'lastActiveDate']) ==
                                                "just now") {
                                              msgStatus = ColorConstant.green;
                                            } else if (SimpleDateFormatConverter
                                                    .getTime(msgStatusParsedData[
                                                        'lastActiveDate']) ==
                                                "2 minute ago") {
                                              msgStatus = ColorConstant.redA400;
                                            } else {
                                              msgStatus = ColorConstant.orange;
                                            }
                                          } else if (msgStatusParsedData[
                                                  'status'] ==
                                              'Unavailable') {
                                            msgStatus = ColorConstant.redA400;
                                          } else if (msgStatusParsedData[
                                                  'status'] ==
                                              'Busy') {
                                            msgStatus = ColorConstant.orange;
                                          }
                                          // setState(() {});
                                        }
                                      }
                                    }

                                    return GestureDetector(
                                      child: Card(
                                        elevation: 10,
                                        margin: const EdgeInsets.all(15),
                                        color: ColorConstant.whiteA700,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                getHorizontalSize(
                                          10.00,
                                        ))),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                IntrinsicHeight(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        // or exapnded
                                                        // fit: FlexFit.tight,
                                                        flex: 2,
                                                        child: Stack(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                  height:
                                                                      getSize(
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
                                                                      msgStatus,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                            ]),
                                                      ),
                                                      Flexible(
                                                        flex: 8,
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Text(
                                                                    searchcontoller
                                                                            .text
                                                                            .isNotEmpty
                                                                        ? "Dr." + searchedUsers[index]["userFirstName"] + " " + searchedUsers[index]['userLastName'] ??
                                                                            ""
                                                                        : "Dr." +
                                                                            item[
                                                                                "userFirstName"] +
                                                                            " " +
                                                                            item[
                                                                                'userLastName'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle.textstylelatomedium14.copyWith(
                                                                        fontSize:
                                                                            getFontSize(
                                                                                16),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: ColorConstant
                                                                            .black900)),
                                                                Text(
                                                                    item["lastMessage"] ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: ColorConstant
                                                                            .indigo800,
                                                                        fontSize:
                                                                            getFontSize(16)))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        // fit: FlexFit.tight,
                                                        child: Container(
                                                          color: Colors.white70,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: item["numOfUnreadMsgs"]
                                                                                .toString() ==
                                                                            '0'
                                                                        ? ColorConstant
                                                                            .whiteA700
                                                                        : ColorConstant
                                                                            .green,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: Text(
                                                                      item["numOfUnreadMsgs"]
                                                                              .toString() ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "${SimpleDateFormatConverter.timeZoneSet(item['lastMessageTime'])}",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: AppStyle
                                                            .textstylelatomedium163
                                                            .copyWith(
                                                          fontSize:
                                                              getFontSize(13),
                                                          color: Colors.grey,
                                                        )))
                                              ],
                                            )),
                                      ),
                                      onTap: () async {
                                        final result =
                                            await Navigator.of(context)
                                                .pushNamed(
                                          chattingScreen,
                                          arguments: [
                                            item['docPatGuId'],
                                            item['userFirstName'],
                                            item['userLastName'],
                                            item['userGuId'],
                                            item['messageGuId'],
                                            'PATIENT'
                                          ],
                                        );
                                        setState(() {
                                        items.clear();
                                        fetch();
                                      });
                                      },
                                    );
                                  } else {
                                    if (items.length == 0) {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 32),
                                        child: Center(child: Text("")),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                },
                              ))),
                    ],
                  )),
            )));
  }

  Future<void> connectStomp() async {
    jwtData = await _cacheService.readCache(key: "jwtdata");

    client = StompClient(
        config: StompConfig(
      url: 'wss://$domain/api/ws?token=' + jwtData!,
      onConnect: (StompFrame frame) {
        // print('onConnectCallback ${frame.body}');

        client.subscribe(
            destination: '/topic/getStatus/$userGuId', callback: messageStatus);

        if (client.isActive) {
          Timer.periodic(const Duration(seconds: 10), (_) {
            client.send(
              destination: '/app/heartBeats',
              body: json.encode({
                'userGuid': userGuId,
                'lastActiveDate': SimpleDateFormatConverter.currentDate(),
                'timeZone': timeZone,
              }),
            );

            if (items.isNotEmpty) {
              for (int i = 0; i < items.length; i++) {
                final item = items[i];
                sendMessagesUserGuidToServer(item['userGuId']);
              }
            }
          });
        }
      },
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(const Duration(milliseconds: 200));
        print('connecting...');
      },

      onWebSocketError: (dynamic error) => print(error.toString()),
      // stompConnectHeaders: {'login': 'guest'},
      // webSocketConnectHeaders: {'passcode': 'guest'},
      onStompError: (d) => print('error stomp'),
      onDisconnect: (f) => print('disconnected'),
      heartbeatOutgoing: const Duration(seconds: 1),
      heartbeatIncoming: const Duration(seconds: 1),
    ));

    client.activate();
  }

  void sendMessagesUserGuidToServer(msgUserId) {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': msgUserId,
        'timeZone': timeZone,
      }),
    );
  }

  Future<void> refresh() async {
    fetch();
  }

  Future<void> messageStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    msgStatusParsedData = await jsonDecode(decodedData);
    // print('messageStatus ${msgStatusParsedData}');
    //setState(() {});
  }

  @override
  void disposed() {
    super.dispose();
  }
}
