
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/history/notifier/HistoryNotifier.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../app/theme/app_style.dart';
import '../../../../../core/services/cache.service.dart';
import '../../../../../utils/Utils/SimpleDateFormatConverter.dart';
import '../../../../../utils/Utils/Utils.dart';

import '../../dashboard/model/UserDetialsModel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final controller = ScrollController();

  final DateFormat formatter = DateFormat('E dd MMM, yyyy');

  TextEditingController searchcontoller = TextEditingController();

  late Map<String, dynamic> historyStatusParsedData = <String, dynamic>{};

  var historySearchData = '';
  late StompClient client;

  var appointmentStatus = '', appointmentStatusColor;

  String? jwtData;
  final CacheService _cacheService = CacheService();

  List<dynamic> items = [];
  List<dynamic> searchedUsers = [];
  var userGuId = '';
  var crossIcon = false;

  _onTextChanged(String value) {
    setState(() {
      if (value.toLowerCase().length > 0) {
        crossIcon = true;
      } else {
        crossIcon = false;
      }
    });
    prevSearch = historySearchData;
    historySearchData = value;
    fetch();
  }

  var historyStatus = ColorConstant.redA400;

  var isFilterBy = '';
  var timeZone;
  bool hasMore = true;
  bool isLoading = false;
  var prevSearch = "";
  var prevFilter = "foo";
  var newItems;
  int page = 0;
  var pgSize = 10;

  @override
  void initState() {
    super.initState();
    tz();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent &&
          isFilterBy.isEmpty &&
          historySearchData.isEmpty) {
        fetch();
      }
    });
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    var ud = await _cacheService.readCache(key: "userDetails");

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);
      userGuId = user.userGuId!;
    }

    if (isFilterBy.isNotEmpty) {
      items.clear();
      page = 0;
    }

    if (prevFilter.isNotEmpty && isFilterBy.isEmpty) {
      items.clear();
      page = 0;
      prevFilter = "";
    }
    setState(() {
      hasMore = true;
    });
    if (historySearchData.isEmpty && prevSearch.isNotEmpty) {
      items.clear();
      prevSearch = "";
      page = 0;
    }
    if (historySearchData.isNotEmpty) items.clear();
    // try {
    //   if(items.isNotEmpty){
    //         items.clear();
    //       }
    // } catch (e) {
    //   print(e);
    // }
    var history = Provider.of<HistoryNotifier>(context, listen: false);
    newItems = await history.getPatientHistoryList(
        pgNum: page,
        pgSize: pgSize,
        context: context,
        search: historySearchData,
        filterBy: isFilterBy);

    setState(() {
      page++;
      // isLoading = false;
      // if (newItems["count"] < pgSize) {
      //   hasMore = false;
      // }
      items.addAll(newItems["list"].map<dynamic>((item) {
        return {
          "doctorName": item["doctorName"],
          "city": item["addressDTO"]["city"],
          "state": item["addressDTO"]["state"],
          "consultationType": item["consultationType"],
          "appointmentDate": item["appointmentDate"],
          "appointmentStartTime": item["appointmentStartTime"],
          "appointmentEndTime": item["appointmentEndTime"],
          "appointmentStatus": item["appointmentStatus"],
          "city": item['addressDTO']["city"],
          "state": item['addressDTO']["state"],
        };
      }));
      isLoading = false;

      if (items.length <= newItems["count"]) {
        hasMore = false;
      }
    });
    connectStomp();
  }

  List<Map> historyFilters = [
    {
      "title": "All",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Encountered Completed",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Encounter Pending",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Cancelled",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Encounter Missed",
      "icon": const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 25,
      )
    },
    {
      "title": "Confirmed",
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: ColorConstant.indigo800,
        body: Container(
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
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: getVerticalSize(30.00)),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: getVerticalSize(10),
                              left: getHorizontalSize(26.00),
                              right: getHorizontalSize(25.00)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(7.00),
                                        bottom: getVerticalSize(1.00)),
                                    child: SizedBox(
                                        height: getVerticalSize(38.00),
                                        width: getHorizontalSize(35.00),
                                        child: SvgPicture.asset(
                                            ImageConstant.imgVector6,
                                            fit: BoxFit.fill))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(14.00),
                                        bottom: getVerticalSize(8.00)),
                                    child: Text("History",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium181
                                            .copyWith(
                                                fontSize: getFontSize(18),
                                                height: 1.33))),
                                Align(
                                    alignment: Alignment.center,
                                    child: PopupMenuButton<String>(
                                        itemBuilder: (context) => historyFilters
                                            .map(
                                                (item) => PopupMenuItem<String>(
                                                    value: item['title'],
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                                child: Text(
                                                                    item[
                                                                        'title'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))),
                                                            Container(
                                                                child: (item["title"] ==
                                                                            "All" &&
                                                                        isFilterBy
                                                                            .isEmpty)
                                                                    ? item[
                                                                        "icon"]
                                                                    : (item["title"] ==
                                                                                "Encountered Completed" &&
                                                                            isFilterBy ==
                                                                                "CLOSED")
                                                                        ? item[
                                                                            "icon"]
                                                                        : (item["title"] == "Encounter Pending" &&
                                                                                isFilterBy == "PENDING_CLOSURE")
                                                                            ? item["icon"]
                                                                            : (item["title"] == "Cancelled" && isFilterBy == "CANCELLED")
                                                                                ? item["icon"]
                                                                                : (item["title"] == "Encounter Missed" && isFilterBy == "MISSED")
                                                                                    ? item["icon"]
                                                                                    : (item["title"] == "Confirmed" && isFilterBy == "CONFIRMED")
                                                                                        ? item["icon"]
                                                                                        : null)
                                                          ],
                                                        ),
                                                      ],
                                                    )))
                                            .toList(),
                                        onSelected: (value) {
                                          setState(() {
                                            if (value == 'All') {
                                              prevFilter = isFilterBy;
                                              isFilterBy = '';
                                            }
                                            if (value ==
                                                'Encountered Completed') {
                                              isFilterBy = 'CLOSED';
                                            } else if (value ==
                                                'Encounter Pending') {
                                              isFilterBy = 'PENDING_CLOSURE';
                                            } else if (value == 'Cancelled') {
                                              isFilterBy = 'CANCELLED';
                                            } else if (value ==
                                                'Encounter Missed') {
                                              isFilterBy = 'MISSED';
                                            } else if (value == 'Confirmed') {
                                              isFilterBy = 'CONFIRMED';
                                            }
                                            fetch();
                                          });
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
                        left: getHorizontalSize(16.00),
                        top: getVerticalSize(24.00),
                        right: getHorizontalSize(16.00)),
                    child: SizedBox(
                        height: getVerticalSize(46.00),
                        child: TextFormField(
                            onChanged: _onTextChanged,
                            controller: searchcontoller,
                            decoration: InputDecoration(
                                hintText: "Search history",
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
                                        child: SvgPicture.asset(
                                            ImageConstant.imgSearchicon1,
                                            fit: BoxFit.contain))),
                                prefixIconConstraints: BoxConstraints(
                                    minWidth: getSize(20.00),
                                    minHeight: getSize(20.00)),
                                filled: true,
                                fillColor: ColorConstant.gray100,
                                suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: getHorizontalSize(14.00), right: getHorizontalSize(10.00)),
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
                                            setState(() {
                                              searchcontoller.text = '';
                                              historySearchData = "";
                                              isFilterBy = "";
                                              page = 0;
                                              items.clear();
                                              fetch();
                                              // historySearchData = '';
                                              // searchcontoller.text = '';
                                              // fetch();
                                            });
                                          },
                                        ))),
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: getVerticalSize(18.00), bottom: getVerticalSize(18.00))),
                            style: TextStyle(color: ColorConstant.bluegray600Af, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)))),
                Expanded(
                    child:
                    SizedBox(
                      //  width: double.infinity,
                        // height:  MediaQuery.of(context).size.height,
                        // decoration:BoxDecoration(color: ColorConstant.black900),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child:
                            ListView.builder(
                              controller: controller,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length + 1,
                              itemBuilder: (context, index) {
                                if (index < items.length) {
                                  final item = items[index];
                                  if (item['appointmentStatus'] == 'CLOSED') {
                                    appointmentStatus = 'Encountered Completed';
                                    appointmentStatusColor =
                                        ColorConstant.black900;
                                  } else if (item['appointmentStatus'] ==
                                      'PENDING_CLOSURE') {
                                    appointmentStatus = 'Encounter Pending';
                                    appointmentStatusColor =
                                        ColorConstant.black900;
                                  } else if (item['appointmentStatus'] ==
                                      'CANCELLED') {
                                    appointmentStatus = 'Cancelled';
                                    appointmentStatusColor =
                                        ColorConstant.redA400;
                                  } else if (item['appointmentStatus'] ==
                                      'MISSED') {
                                    appointmentStatus = 'Encounter Missed';
                                    appointmentStatusColor =
                                        ColorConstant.black900;
                                  } else if (item['appointmentStatus'] ==
                                      'CONFIRMED') {
                                    appointmentStatus = 'Confirmed';
                                    appointmentStatusColor =
                                        ColorConstant.black900;
                                  }

                                  if (historyStatusParsedData.isNotEmpty) {
                                    if (historyStatusParsedData['userGuid'] ==
                                        item['doctorUserGuid']) {
                                      if (historyStatusParsedData['status'] !=
                                          null) {
                                        if (historyStatusParsedData['status'] ==
                                            'Available') {
                                          if (SimpleDateFormatConverter.getTime(
                                                  historyStatusParsedData[
                                                      'lastActiveDate']) ==
                                              "just now") {
                                            historyStatus = ColorConstant.green;
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
                                          historyStatus = ColorConstant.redA400;
                                        } else if (historyStatusParsedData[
                                                'status'] ==
                                            'Busy') {
                                          historyStatus = ColorConstant.orange;
                                        }
                                        // setState(() {});
                                      }
                                    }
                                  }
                                  return
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
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(
                                      10.00,
                                    ))),
                                    child:
                                    Stack(
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
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Stack(
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
                                                                          .cover)),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      historyStatus,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                height: 10,
                                                                width: 10,
                                                              ),
                                                            ]),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      16.00),
                                                            ),
                                                            child: Column(
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
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right: getHorizontalSize(
                                                                              10.00)),
                                                                      child:
                                                                          Text(
                                                                        item['doctorName'] ?? '',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: AppStyle.textstylelatomedium14.copyWith(
                                                                            fontSize:
                                                                                getFontSize(17),
                                                                            fontWeight: FontWeight.bold,
                                                                            color: ColorConstant.black900),
                                                                      )),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                              top: getVerticalSize(5.00),
                                                                              bottom: getVerticalSize(3.00),
                                                                            ),
                                                                            child: Text(item['doctorDegree'] ?? '',
                                                                                textAlign: TextAlign.left,
                                                                                style: const TextStyle(color: Colors.black))),
                                                                        Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                              top: getVerticalSize(5.00),
                                                                              bottom: getVerticalSize(3.00),
                                                                            //  left: getVerticalSize(5.00),
                                                                            ),
                                                                            child: Text(item['city'] + ", " + item['state'] ?? '',
                                                                                textAlign: TextAlign.left,
                                                                                style: const TextStyle(color: Colors.black))),
                                                                      ]),
                                                                ]))
                                                      ]),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                            left: 55.0,top: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgRefreshalt,
                                                                  fit: BoxFit.fill),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  item['consultationType'] ?? '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  textAlign: TextAlign.left,
                                                                  style: TextStyle(color: ColorConstant.orange)
                                                              )
                                                            ],
                                                          ),
                                                          Flexible(child: Text(
                                                              appointmentStatus ??
                                                                  '',
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              textAlign:
                                                              TextAlign
                                                                  .left,
                                                              style: TextStyle(
                                                                  color:
                                                                  appointmentStatusColor)),
                                                          )
                                                        ]),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Divider(
                                                      height: 1,
                                                      color: Colors.grey),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    getVerticalSize(
                                                                        5.00),
                                                              ),
                                                              child: Text(
                                                                  formatter.format(
                                                                          DateTime.parse(item[
                                                                              'appointmentDate'])) ??
                                                                      '',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black))),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    getVerticalSize(
                                                                        5.00),
                                                                left:
                                                                    getVerticalSize(
                                                                        5.00),
                                                              ),
                                                              child: Text(
                                                                  item['appointmentStartTime'] +
                                                                      " - " +
                                                                      item[
                                                                          'appointmentEndTime'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black))),
                                                        ]),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return  Center(
                                      child: hasMore
                                          ? const CircularProgressIndicator()
                                          : const SizedBox(
                                          child: Center(
                                              child: Text(
                                                " ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ))));
                                }
                              },
                            ),
                          ),
                        ))),
              ],
            )));
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });
    fetch();
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
            callback: historyAppStatus);

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
                sendDoctorsHistoryUserGuidToServer(item['doctorUserGuid']);
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

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    fetch();
  }

  Future<void> historyAppStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    historyStatusParsedData = await jsonDecode(decodedData);
    // print('historyAppStatus ${historyStatusParsedData}');
    setState(() {});
  }

  void sendDoctorsHistoryUserGuidToServer(docUserGuid) {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': docUserGuid,
        'timeZone': timeZone,
      }),
    );
  }
}
