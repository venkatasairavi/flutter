import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moibleapi/meta/views/dashboardallappointmentsview/appointments_notifier/appoinments_notifier.dart';
import 'package:moibleapi/utils/Utils/SimpleDateFormatConverter.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../core/services/cache.service.dart';
import '../../../utils/Utils/Utils.dart';
import '../dashboardhomeview/notifier/doctornotifier.dart';

class DashboarAllAppointmentsScreen extends StatefulWidget {
  const DashboarAllAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<DashboarAllAppointmentsScreen> createState() =>
      _DashboarAllAppointmentsScreenState();
}

class _DashboarAllAppointmentsScreenState
    extends State<DashboarAllAppointmentsScreen> {
  final ScrollController controller = ScrollController();

  List<dynamic> items = [];
  List<dynamic> searchedUsers = [];
  var historyStatus = ColorConstant.redA400;
  var crossIcon = false;

  bool hasMore = true;
  bool isLoading = false;
  //var newItems;
  int page = 0;
  var pgSize = 10;
  var searchby = "";
  var prevFilter = "foo";
  var Filterby = "";
  var newItems;
  var timeZone;
  var prevSearch = "";

  late Map<String, dynamic> historyStatusParsedData = <String, dynamic>{};
  String? jwtData;
  final CacheService _cacheService = CacheService();
  var userGuId = '';
  late StompClient client;

  TextEditingController searchcontroller = TextEditingController();
  //int pgNum = 0;

  final DateFormat formatter = DateFormat('E dd MMM, yyyy');
  @override
  void initState() {
    super.initState();
    tz();
    _userDetails();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          Filterby.isEmpty &&
          searchby.isEmpty) {
        fetch();
      }
    });
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
    fetch();
  }

  void _userDetails() async {
    var userDetails = Provider.of<DoctorNotifier>(context, listen: false);
    var details = await userDetails.getUserDetails(context);

    userGuId = details['userGuId'];

    // connectStomp();
  }

  Future<void> connectStomp() async {
    jwtData = await _cacheService.readCache(key: "jwtdata");

    client = StompClient(
        config: StompConfig(
      url: 'wss://$domain/api/ws?token=' + jwtData!,
      onConnect: (StompFrame frame) {
        // print('onConnectCallback ${frame.body}');

        client.subscribe(
            destination: '/topic/getStatus/$userGuId',
            callback: upComingAppointmentStatus);

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
                sendHistoryAppointmentUserGuidToServer(item['userGuid']);
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

  List<Map<String, dynamic>> AppointmentFilters = [
    {
      "title": "All",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Follow up",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "New Patient",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
  ];

  @override
  void dispose() {
    controller.dispose(); // TODO: implement dispose
    super.dispose();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    if (Filterby.isNotEmpty) {
      items.clear();
      page = 0;
    }

    if (prevFilter.isNotEmpty && Filterby.isEmpty) {
      items.clear();
      page = 0;
      prevFilter = "";
    }
    setState(() {
      hasMore = true;
    });
    if (searchby.isEmpty && prevSearch.isNotEmpty) {
      items.clear();
      prevSearch = "";
      page = 0;
    }
    if (searchby.isNotEmpty) items.clear();

    var getpatients = Provider.of<AppointmentNotifier>(context, listen: false);
    newItems = await getpatients.getPatientList(
        pgNum: page, context: context, search: searchby, filterBy: Filterby);

    setState(() {
      page++;

      items.addAll(newItems["list"].map<dynamic>((item) {
        return {
          "firstName": item["firstName"],
          "lastName": item["lastName"],
          "appointmentStatus": item["appointmentStatus"],
          "reasonForAppointment": item["reasonForAppointment"],
          "consultationType": item["consultationType"],
          "appointmentDate": item["appointmentDate"],
          "userGuid": item["userGuid"],
          "appointmentStartTime": item["appointmentStartTime"],
          "appointmentEndTime": item["appointmentEndTime"],
        };
      }));

      isLoading = false;

      if (items.length <= newItems["count"]) {
        hasMore = false;
      }
    });

    await connectStomp();
  }

  _quaryUsers(String value) {
    // value = value.toLowerCase();

    setState(() {
      if (value.length > 0) {
        crossIcon = true;
      } else {
        crossIcon = false;
      }
    });
    prevSearch = searchby;
    searchby = value;
    fetch();
    // print(value);

    // setState(() {
    //   searchedUsers = items.where((user) {
    //     return
    //         user["firstName"].toString().toLowerCase().contains(value);
    //   }).toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.indigo800,
            body: Container(
                // height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.gray50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getHorizontalSize(0.00)),
                      topRight: Radius.circular(getHorizontalSize(0.00)),
                      bottomLeft: Radius.circular(getHorizontalSize(35.00)),
                      bottomRight: Radius.circular(getHorizontalSize(35.00))),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin:
                                EdgeInsets.only(top: getVerticalSize(30.00)),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(10),
                                    left: getHorizontalSize(26.00),
                                    right: getHorizontalSize(25.00)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: getVerticalSize(7.00),
                                              bottom: getVerticalSize(1.00)),
                                          child: Container(
                                              height: getVerticalSize(38.00),
                                              width: getHorizontalSize(35.00),
                                              child: SvgPicture.asset(
                                                  ImageConstant.imgVector6,
                                                  fit: BoxFit.fill))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: getVerticalSize(14.00),
                                              bottom: getVerticalSize(8.00)),
                                          child: Text("Appointments",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .textstylelatomedium181
                                                  .copyWith(
                                                      fontSize: getFontSize(18),
                                                      height: 1.33))),
                                      // Container(
                                      //     height: getSize(30.00),
                                      //     width: getSize(30.00),
                                      //     child: SvgPicture.asset(
                                      //         ImageConstant.imgBack,
                                      //         fit: BoxFit.fill))
                                      Align(
                                          alignment: Alignment.center,
                                          child: PopupMenuButton<String>(
                                              itemBuilder: (context) =>
                                                  AppointmentFilters.map(
                                                      (item) =>
                                                          PopupMenuItem<String>(
                                                              value:
                                                                  item['title'],
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                          margin: const EdgeInsets.only(
                                                                              left:
                                                                                  10.0),
                                                                          child: Text(
                                                                              item["title"]!,
                                                                              style: const TextStyle(color: Colors.black))),
                                                                      Container(
                                                                          child: (item["title"] == "All" && Filterby.isEmpty)
                                                                              ? item["icon"]
                                                                              : (item["title"] == "Follow up" && Filterby == "FOLLOW_UP")
                                                                                  ? item["icon"]
                                                                                  : (item["title"] == "New Patient" && Filterby == "FIRST_CONSULTATION")
                                                                                      ? item["icon"]
                                                                                      : null)
                                                                    ],
                                                                  ),
                                                                ],
                                                              ))).toList(),
                                              onSelected: (value) {
                                                setState(() {
                                                  // _selected = value;
                                                  if (value == 'All') {
                                                    prevFilter = Filterby;
                                                    Filterby = '';
                                                  }
                                                  if (value == 'Follow up') {
                                                    Filterby = 'FOLLOW_UP';
                                                  }
                                                  if (value == 'New Patient') {
                                                    Filterby =
                                                        'FIRST_CONSULTATION';
                                                  }
                                                });
                                                fetch();
                                              },
                                              child: SizedBox(
                                                  height: getSize(30.00),
                                                  width: getSize(30.00),
                                                  child: SvgPicture.asset(
                                                      ImageConstant.imgBack,
                                                      fit: BoxFit.fill))))
                                    ])),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(26.00),
                              top: getVerticalSize(24.00),
                              right: getHorizontalSize(26.00)),
                          child: Container(
                              height: getVerticalSize(46.00),
                              width: getHorizontalSize(320.00),
                              child: TextFormField(
                                  onChanged: _quaryUsers,
                                  controller: searchcontroller,
                                  decoration: InputDecoration(
                                      hintText: "Search appointments",
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
                                          child: Container(
                                              height: getSize(20.00),
                                              width: getSize(20.00),
                                              child:
                                                  SvgPicture.asset(ImageConstant.imgSearchicon1, fit: BoxFit.contain))),
                                      prefixIconConstraints: BoxConstraints(minWidth: getSize(20.00), minHeight: getSize(20.00)),
                                      filled: true,
                                      fillColor: ColorConstant.gray100,
                                      suffixIcon: Padding(
                                          padding: EdgeInsets.only(left: getHorizontalSize(14.00), right: getHorizontalSize(10.00)),
                                          child: Container(
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
                                                  //searchedUsers.clear();
                                                  // searchcontoller.clear();
                                                  setState(() {
                                                    crossIcon = false;
                                                    searchcontroller.text = '';
                                                    searchby = "";
                                                    Filterby = "";
                                                    page = 0;
                                                    items.clear();
                                                    fetch();
                                                  });
                                                },
                                              ))),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(top: getVerticalSize(18.00), bottom: getVerticalSize(18.00))),
                                  style: TextStyle(color: ColorConstant.bluegray600Af, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)))),
                      Expanded(
                        flex: 1,
                        child: items.length == 0
                            ? Center(
                                child: Text("",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: ColorConstant.black900,
                                        fontWeight: FontWeight.bold)),
                              )
                            : RefreshIndicator(
                                onRefresh: refresh,
                                child: ListView.builder(
                                  controller: controller,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: items.length + 1,
                                  itemBuilder: (BuildContext context, index) {
                                    if (index < items.length) {
                                      // print("ITEMMMM LENGTH");
                                      // print(items.length);
                                      final item = items[index];

                                      if (historyStatusParsedData.isNotEmpty) {
                                        if (historyStatusParsedData[
                                                'userGuid'] ==
                                            item['userGuid']) {
                                          if (historyStatusParsedData[
                                                  'status'] !=
                                              null) {
                                            if (historyStatusParsedData[
                                                    'status'] ==
                                                'Available') {
                                              if (SimpleDateFormatConverter.getTime(
                                                      historyStatusParsedData[
                                                          'lastActiveDate']) ==
                                                  "just now") {
                                                historyStatus =
                                                    ColorConstant.green;
                                              } else if (SimpleDateFormatConverter
                                                      .getTime(
                                                          historyStatusParsedData[
                                                              'lastActiveDate']) ==
                                                  "2 minute ago") {
                                                historyStatus =
                                                    ColorConstant.redA400;
                                              } else {
                                                historyStatus =
                                                    ColorConstant.orange;
                                              }
                                            } else if (historyStatusParsedData[
                                                    'status'] ==
                                                'Unavailable') {
                                              historyStatus =
                                                  ColorConstant.redA400;
                                            } else if (historyStatusParsedData[
                                                    'status'] ==
                                                'Busy') {
                                              historyStatus =
                                                  ColorConstant.orange;
                                            }
                                            // setState(() {});
                                          }
                                        }
                                      }
                                      // print("From API");
                                      // print(items[index]);
                                      var timediff =
                                          SimpleDateFormatConverter.getTimeDiff(
                                              item["appointmentDate"],
                                              item["appointmentStartTime"]);

                                      return Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: getVerticalSize(20),
                                                  left: getHorizontalSize(20),
                                                  right: getHorizontalSize(29)),
                                              child: Container(
                                                width: double.infinity,
                                                //height: 140,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getHorizontalSize(
                                                      8.00,
                                                    ),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorConstant
                                                          .black9001f,
                                                      spreadRadius:
                                                          getHorizontalSize(
                                                        2.00,
                                                      ),
                                                      blurRadius:
                                                          getHorizontalSize(
                                                        2.00,
                                                      ),
                                                      offset: const Offset(
                                                        0,
                                                        1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          10.00),
                                                                  top: getVerticalSize(
                                                                      10.00),
                                                                  //bottom: getVerticalSize(16.00)
                                                                ),
                                                                child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    children: [
                                                                      Container(
                                                                          height: getSize(
                                                                              50.00),
                                                                          width: getSize(
                                                                              50.00),
                                                                          child: SvgPicture.asset(
                                                                              ImageConstant.imgUseravatarp,
                                                                              fit: BoxFit.fill)),
                                                                      Positioned(
                                                                        // bottom:
                                                                        //     10,
                                                                        // right:
                                                                        //     10,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              10,
                                                                          width:
                                                                              10,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                historyStatus,
                                                                            borderRadius:
                                                                                BorderRadius.circular(getHorizontalSize(80.00)),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ])),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  //color: Colors.blueAccent,
                                                                  margin: EdgeInsets.only(
                                                                      left: getHorizontalSize(
                                                                          5)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: getHorizontalSize(5)),
                                                                        child:
                                                                            Text(
                                                                          item["firstName"] +
                                                                              " " +
                                                                              item["lastName"],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0XFF252E4B),
                                                                            fontSize:
                                                                                getFontSize(
                                                                              15,
                                                                            ),
                                                                            fontFamily:
                                                                                'Lato',
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            height:
                                                                                1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            // left:
                                                                            //     getHorizontalSize(50),
                                                                            right: getHorizontalSize(5)),
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(left: getHorizontalSize(15)),
                                                                          child:
                                                                              Text(
                                                                            item["appointmentStatus"],
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0XFF252E4B),
                                                                              fontSize: getFontSize(
                                                                                15,
                                                                              ),
                                                                              fontFamily: 'Lato',
                                                                              fontWeight: FontWeight.w700,
                                                                              height: 1.50,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: getHorizontalSize(
                                                                          10)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            Text(
                                                                          item[
                                                                              "reasonForAppointment"],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0XFF5F6989),
                                                                            fontSize:
                                                                                getFontSize(
                                                                              14,
                                                                            ),
                                                                            fontFamily:
                                                                                'Lato',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                1.50,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // const SizedBox(
                                                                      //   width:
                                                                      //       50,
                                                                      // ),
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: getVerticalSize(
                                                                                  5),
                                                                              left: getHorizontalSize(
                                                                                  15)),
                                                                          height: getSize(
                                                                              15.00),
                                                                          width: getSize(
                                                                              15.00),
                                                                          child: SvgPicture.asset(
                                                                              ImageConstant.imgRefreshalt,
                                                                              fit: BoxFit.fill)),
                                                                      Container(
                                                                        // margin: EdgeInsets.only(
                                                                        //     right: getHorizontalSize(
                                                                        //         10)),
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                getHorizontalSize(10),
                                                                            right: getHorizontalSize(10)),
                                                                        child:
                                                                            Text(
                                                                          item[
                                                                              "consultationType"],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0XFFFF9500),
                                                                            fontSize:
                                                                                getFontSize(
                                                                              14,
                                                                            ),
                                                                            fontFamily:
                                                                                'Lato',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                1.50,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                                getVerticalSize(
                                                                    20)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left:
                                                                    getHorizontalSize(
                                                                        20),
                                                                top:
                                                                    getVerticalSize(
                                                                        5),
                                                              ),
                                                              child: Text(
                                                                formatter.format(
                                                                    DateTime.parse(
                                                                        item[
                                                                            "appointmentDate"])),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0XFF252E4B),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left:
                                                                    getHorizontalSize(
                                                                        15),
                                                                top:
                                                                    getVerticalSize(
                                                                        5),
                                                              ),
                                                              child: Text(
                                                                item["appointmentStartTime"] +
                                                                    "-" +
                                                                    item[
                                                                        "appointmentEndTime"],
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0XFF252E4B),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    getVerticalSize(
                                                                        5.00),
                                                                bottom:
                                                                    getVerticalSize(
                                                                        3.00),
                                                                left:
                                                                    getVerticalSize(
                                                                        20.00),
                                                              ),
                                                              child: timediff ==
                                                                      null
                                                                  ? Container()
                                                                  : SvgPicture.asset(
                                                                      ImageConstant
                                                                          .imgStartsIn,
                                                                      fit: BoxFit
                                                                          .fill)),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    getVerticalSize(
                                                                        5.00),
                                                                bottom:
                                                                    getVerticalSize(
                                                                        3.00),
                                                                left:
                                                                    getVerticalSize(
                                                                        5.00),
                                                              ),
                                                              child: Text(
                                                                  timediff ??
                                                                      '',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .textstylelatomedium163
                                                                      .copyWith(
                                                                    fontSize:
                                                                        getFontSize(
                                                                            13),
                                                                  ))),
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32),
                                        child: Center(
                                            child: hasMore
                                                ? const CircularProgressIndicator()
                                                : const Text("")),
                                      );
                                    }
                                  },
                                ),
                              ),
                      )
                    ]))));
  }

  // _listItems(index) {
  //   return
  // }
  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });
    fetch();
  }

  Future<void> upComingAppointmentStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    historyStatusParsedData = await jsonDecode(decodedData);
    //  print('upComingAppointmentStatus ${historyStatusParsedData}');
    setState(() {});
  }

  void sendHistoryAppointmentUserGuidToServer(userGuid) {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': userGuid,
        'timeZone': timeZone,
      }),
    );
  }
}
