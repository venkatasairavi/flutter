import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:moibleapi/app/routes/api.routes.dart';

import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';

import 'package:moibleapi/core/services/cache.service.dart';

import 'package:moibleapi/utils/Utils/SimpleDateFormatConverter.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../utils/Utils/Utils.dart';

import 'notifier/doctornotifier.dart';

class DashboardFirstTimeOne extends StatefulWidget {
  const DashboardFirstTimeOne({Key? key}) : super(key: key);

  @override
  State<DashboardFirstTimeOne> createState() => _DashboardFirstTimeOneState();
}

class _DashboardFirstTimeOneState extends State<DashboardFirstTimeOne> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController dropdown = TextEditingController();
  final controller = ScrollController();

  var username = "", docPatGuId = '', userGuId = '', timeZone = "";
  var firstname = "";
  var lastname = "";

  List<dynamic> _items = [];
  List<dynamic> searchedUsers = [];
  var newItems;
  int page = 0;
  var pgSize = 10;
  bool hasMore = true;
  bool isLoading = false;
  var searchby = "";
  var prevSearch = "";

  var todaysAvailableStatus = ColorConstant.redA400;

  late Map<String, dynamic> todaysStatusParsedData = <String, dynamic>{};

  late StompClient client;
  String? jwtData;
  final CacheService _cacheService = CacheService();
  Utils utils = Utils();
  String _selected = "Available";

  @override
  void initState() {
    super.initState();
    funtionCalls();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        fetch();
      }
    });
  }

  void funtionCalls() async {
    await tz();
    if (await _cacheService.readCache(key: "status") == null)
      await updatedoctorStatus();
    await _getDocdetails();
    await _userDetails();
    await fetch();
  }

  @override
  void dispose() {
    controller.dispose(); // TODO: implement dispose
    super.dispose();
  }

  final DateFormat formatter = DateFormat('E dd MMM, yyyy');

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    setState(() {
      hasMore = true;
    });
    if (searchby.isEmpty && prevSearch.isNotEmpty) {
      _items.clear();
      prevSearch = "";
      page = 0;
    }
    if (searchby.isNotEmpty) _items.clear();

    //if (searchby != "") _items.clear();
    var docNotifier = Provider.of<DoctorNotifier>(context, listen: false);
    // try {
    newItems = await docNotifier.getUpcomingAppointments(
        pageNum: page, searchby: searchby, context: context);
    // } on UnauthorisedException catch (exp) {
    //   exp.printInfo();
    //   // _timeoutpopUP();
    //   return;
    // }

    if (newItems == null) {
      setState(() {
        hasMore = false;
      });
      isLoading = false;
      return;
    }

    setState(() {
      page++;
      print(page);
      _items.addAll(newItems["list"].map<dynamic>((item) {
        return {
          "firstName": item["userDetails"]["firstName"],
          "lastName": item["userDetails"]["lastName"],
          "reasonForAppointment": item["reasonForAppointment"],
          "typeOfConsultation": item["typeOfConsultation"],
          "appointmentDate": item["appointmentDetails"]["appointmentDate"],
          "appointmentStartTime": item["appointmentDetails"]
              ["appointmentStartTime"],
          "appointmentEndTime": item["appointmentDetails"]
              ["appointmentEndTime"],
          "gender": item["userDetails"]["gender"],
          "userGuId": item["userDetails"]["userGuId"],
          "age": item["userDetails"]["age"],
          "patientGuId": item["appointmentDetails"]["patientGuId"],
          "appointmentDetails": item["appointmentDetails"]
              ['patientAppointmentGuId'],
        };
      }));
    });
    isLoading = false;
    print(_items.length <= newItems["count"]);
    if (_items.length <= newItems["count"]) {
      hasMore = false;
    }
  }

  Future<void> updatedoctorStatus() async {
    var updatedoctorStatus =
        Provider.of<DoctorNotifier>(context, listen: false);
    var doctorstatus;
    // try {
    doctorstatus =
        await updatedoctorStatus.setStatus(status: _selected, context: context);
    print("doctorstatus $doctorstatus");
    if (doctorstatus != null) {
      setState(() {
        _selected = doctorstatus;
      });
      _cacheService.writeCache(key: "status", value: _selected);
    }
    // } on UnauthorisedException catch (e) {
    //   e.printInfo();
    //   // _timeoutpopUP();
    // }
  }

  Future<void> _getDocdetails() async {
    var docNotifier = Provider.of<DoctorNotifier>(context, listen: false);
    // try {
    var doctorDetails = await docNotifier.getDoctor(context: context);
    print(doctorDetails["userDetails"]);
    setState(() {
      firstname = doctorDetails["userDetails"]["firstName"];
      lastname = doctorDetails["userDetails"]["lastName"];
      _selected = doctorDetails["userDetails"]["status"];
    });
    // } on UnauthorisedException catch (e) {
    //   e.printInfo();
    //   // _timeoutpopUP();
    //   return;
    // }
  }

  _quaryUsers(String value) {
    //value = value.toLowerCase();
    prevSearch = searchby;
    searchby = value;
    //  searchby = value;
    print("searchingaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(searchby);
    fetch();
    // setState(() {
    //   searchedUsers = _items.where((user) {
    //     var usertitle =
    //     user["firstName"].toString().toLowerCase().contains(value);
    //     print("=======================================================");
    //     print(searchedUsers);
    //     print(user["firstName"]);
    //     return usertitle;
    //   }).toList();
    // });
    //  print(value);
    // setState(() {
    //   searchedUsers = items.where((user) {
    //     var usertitle =
    //         user["firstName"].toString().toLowerCase().contains(value);

    //     return usertitle;
    //   }).toList();
  }

  //print("query userrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  // searchedUsers.forEach((element) {
  //   // print(element);
  // });
  // }

  //String _selected = "";
  List<Map> dropdownitems = [
    {
      // "id": "1",
      "title": "Unavailable",
      "des": "When you are away",
      "icon": const Icon(
        Icons.circle,
        color: Colors.red,
        size: 12,
      )
    },
    {
      //"id": "2",
      "title": "Available",
      "des": "Based on activity",
      "icon": const Icon(
        Icons.circle,
        color: Colors.green,
        size: 12,
      )
    },
    {
      // "id": "3",
      "title": "Busy",
      "des": "While-In Consultation",
      "icon": const Icon(
        Icons.circle,
        color: Colors.orange,
        size: 12,
      )
    }
  ];

  @override
  Widget build(BuildContext context) {
    //final docNotifier = Provider.of<DoctorNotifier>(context, listen: false);
    // return FutureBuilder(
    //     future: docNotifier.getDoctor(context: context),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         _selected = snapshot.data["userDetails"]["status"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(top: getVerticalSize(56.00)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(26.00)),
                                  child: SizedBox(
                                      height: getVerticalSize(38.00),
                                      width: getHorizontalSize(35.00),
                                      child: SvgPicture.asset(
                                          ImageConstant.imgVector6,
                                          fit: BoxFit.fill))),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: getVerticalSize(1.00),
                                      right: getHorizontalSize(25.00),
                                      bottom: getVerticalSize(30.00)),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.whiteA700,
                                      borderRadius: BorderRadius.circular(
                                          getHorizontalSize(50.00)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorConstant.black9000d,
                                            spreadRadius:
                                                getHorizontalSize(2.00),
                                            blurRadius: getHorizontalSize(2.00),
                                            offset: const Offset(0, 0))
                                      ]),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: PopupMenuButton<String>(
                                          itemBuilder: (context) =>
                                              dropdownitems
                                                  .map(
                                                      (item) =>
                                                          PopupMenuItem<String>(
                                                              value:
                                                                  item['title'],
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      item[
                                                                          'icon'],
                                                                      Container(
                                                                          margin: const EdgeInsets.only(
                                                                              left:
                                                                                  10.0),
                                                                          child: Text(
                                                                              item['title'],
                                                                              style: const TextStyle(color: Colors.black))),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    item['des'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              )))
                                                  .toList(),
                                          onSelected: (value) {
                                            setState(() {
                                              _selected = value;
                                              updatedoctorStatus();
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                if (_selected ==
                                                    'Unavailable') ...[
                                                  dropdownitems[0]['icon']
                                                ] else if (_selected ==
                                                    'Available') ...[
                                                  dropdownitems[1]['icon']
                                                ] else if (_selected ==
                                                    'Busy') ...[
                                                  dropdownitems[2]['icon']
                                                ],
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(_selected)),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                      size: 25,
                                                    )),
                                              ],
                                            ),
                                          ))))
                            ]))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: getHorizontalSize(23.00),
                            top: getVerticalSize(10.00),
                            right: getHorizontalSize(23.00)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: getVerticalSize(6.00),
                                      bottom: getVerticalSize(4.00)),
                                  child: Text(
                                      "Good Morning Dr.${firstname + " " + lastname}",
                                      // ${snapshot.data["userDetails"]["firstName"]} ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.textstylelatobold20
                                          .copyWith(
                                              fontSize: getFontSize(20)))),
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //         left: getHorizontalSize(
                              //             11.00)),
                              //     child: Text(
                              //         "lbl6",
                              //         overflow:
                              //             TextOverflow.ellipsis,
                              //         textAlign: TextAlign.left,
                              //         style: AppStyle.textstylelatobold34.copyWith(fontSize: getFontSize(34))))
                            ]))),
                Padding(
                    padding: EdgeInsets.only(
                        left: getHorizontalSize(23.00),
                        top: getVerticalSize(7.00),
                        right: getHorizontalSize(22.00)),
                    child: Container(
                        height: getVerticalSize(46.00),
                        width: getHorizontalSize(330.00),
                        child: TextFormField(
                            controller: searchcontroller,
                            onChanged: _quaryUsers,
                            decoration: InputDecoration(
                                hintText: "Search Appointments",
                                hintStyle: AppStyle.textstylelatomedium143
                                    .copyWith(
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
                                prefixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(14.00), right: getHorizontalSize(10.00)), child: Container(height: getSize(20.00), width: getSize(20.00), child: SvgPicture.asset(ImageConstant.imgSearchicon, fit: BoxFit.contain))),
                                prefixIconConstraints: BoxConstraints(minWidth: getSize(20.00), minHeight: getSize(20.00)),
                                filled: true,
                                fillColor: ColorConstant.gray100,
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: getVerticalSize(18.00), bottom: getVerticalSize(18.00))),
                            style: TextStyle(color: ColorConstant.bluegray600Af, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)))),
                Expanded(
                  child: _items.isEmpty
                      ? Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(23.00),
                                    top: getVerticalSize(56.00),
                                    right: getHorizontalSize(23.00)),
                                child: Container(
                                    height: getVerticalSize(145.47),
                                    width: getHorizontalSize(172.00),
                                    child: SvgPicture.asset(
                                        ImageConstant.imgEmptydashboard,
                                        fit: BoxFit.fill))),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(23.00),
                                    top: getVerticalSize(46.53),
                                    right: getHorizontalSize(23.00)),
                                child: Text("No Patient Appointment Yet!",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppStyle.textstylelatobold201
                                        .copyWith(fontSize: getFontSize(20)))),
                            Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(23.00),
                                  top: getVerticalSize(4.00),
                                  right: getHorizontalSize(23.00),
                                  // bottom:
                                  //     getVerticalSize(
                                  //         174.00)
                                ),
                                child: Text(
                                    "You have no patient Patient appointment yet!",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppStyle.textstylelatomedium14
                                        .copyWith(
                                            fontSize: getFontSize(14),
                                            height: 1.71)))
                          ],
                        )
                      : Container(
                          //height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            controller: controller,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _items.length + 1,
                            itemBuilder: (BuildContext context, index) {
                              if (index < _items.length) {
                                var item = _items[index];
                                //item = searchedUsers[index];

                                // DateFormat dateFormat =
                                //     DateFormat("yyyy-MM-dd hh:mm a");
                                // DateTime jsonDateTime = (dateFormat
                                //     .parse(item["appointmentDetails"]
                                //             ["appointmentDate"] +
                                //         " " +
                                //         item["appointmentDetails"]
                                //             ["appointmentStartTime"]));
                                // print("Difference Between " +
                                //     DateTime.now().toString() +
                                //     " AND " +
                                //     jsonDateTime.toString());
                                // print(jsonDateTime
                                //     .difference(DateTime.now())
                                //     .toString());
                                // List<String> diffSplit = (jsonDateTime
                                //     .difference(DateTime.now())
                                //     .toString()
                                //     .split(":"));
                                if (todaysStatusParsedData.isNotEmpty) {
                                  if (todaysStatusParsedData['userGuid'] ==
                                      item["userGuId"]) {
                                    if (todaysStatusParsedData['status'] !=
                                        null) {
                                      if (todaysStatusParsedData['status'] ==
                                          'Available') {
                                        if (SimpleDateFormatConverter.getTime(
                                                todaysStatusParsedData[
                                                    'lastActiveDate']) ==
                                            "just now") {
                                          todaysAvailableStatus =
                                              ColorConstant.green;
                                        } else if (SimpleDateFormatConverter
                                                .getTime(todaysStatusParsedData[
                                                    'lastActiveDate']) ==
                                            "2 minute ago") {
                                          todaysAvailableStatus =
                                              ColorConstant.redA400;
                                        } else {
                                          todaysAvailableStatus =
                                              ColorConstant.orange;
                                        }
                                      } else if (todaysStatusParsedData[
                                              'status'] ==
                                          'Unavailable') {
                                        todaysAvailableStatus =
                                            ColorConstant.redA400;
                                      } else if (todaysStatusParsedData[
                                              'status'] ==
                                          'Busy') {
                                        todaysAvailableStatus =
                                            ColorConstant.orange;
                                      }
                                      // setState(() {});
                                    }
                                  }
                                }
                                var timediff =
                                    SimpleDateFormatConverter.getTimeDiff(
                                        item["appointmentDate"],
                                        item["appointmentStartTime"]);

                                return Container(
                                  //color: Colors.black,
                                  //height: 500,
                                  //  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(20),
                                            left: getHorizontalSize(20),
                                            right: getHorizontalSize(29)),
                                        child:
                                            //  InkWell(
                                            //   onTap: () {
                                            //     Navigator.of(context).pushNamed(
                                            //         upcomingappointmentsRoute);
                                            //     print("object");
                                            //   },
                                            //   child:
                                            InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                upcomingappointmentsRoute,
                                                arguments: {
                                                  "firstName":
                                                      item["firstName"],
                                                  "lastName": item["lastName"],
                                                  "reasonForAppointment": item[
                                                      "reasonForAppointment"],
                                                  "typeOfConsultation": item[
                                                      "typeOfConsultation"],
                                                  "appointmentDate":
                                                      item["appointmentDate"],
                                                  "appointmentStartTime": item[
                                                      "appointmentStartTime"],
                                                  "appointmentEndTime": item[
                                                      "appointmentEndTime"],
                                                  "gender": item["gender"],
                                                  "age": item["age"],
                                                  "patientGuId":
                                                      item["patientGuId"],
                                                  "patientAppointmentGuId":
                                                      item[
                                                          "appointmentDetails"],
                                                  "userGuId": item["userGuId"],
                                                  'statusColor':
                                                      todaysAvailableStatus
                                                });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            //height: scree,
                                            decoration: BoxDecoration(
                                              color: ColorConstant.whiteA700,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  8.00,
                                                ),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      ColorConstant.black9001f,
                                                  spreadRadius:
                                                      getHorizontalSize(
                                                    2.00,
                                                  ),
                                                  blurRadius: getHorizontalSize(
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
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      10.00),
                                                              top:
                                                                  getVerticalSize(
                                                                      10.00),
                                                              //bottom: getVerticalSize(16.00)
                                                            ),
                                                            child: Stack(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                children: [
                                                                  Container(
                                                                      height: getSize(
                                                                          50.00),
                                                                      width: getSize(
                                                                          50.00),
                                                                      child: SvgPicture.asset(
                                                                          ImageConstant
                                                                              .imgUseravatarp,
                                                                          fit: BoxFit
                                                                              .fill)),
                                                                  Positioned(
                                                                    // bottom:
                                                                    //     10,
                                                                    // right:
                                                                    //     10,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          10,
                                                                      width: 10,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            todaysAvailableStatus,
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
                                                          // mainAxisAlignment: MainAxisAlignment.end,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          10)),
                                                              child: Text(
                                                                item["firstName"] +
                                                                    " " +
                                                                    item[
                                                                        "lastName"],
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0XFF252E4B),
                                                                  fontSize:
                                                                      getFontSize(
                                                                    15,
                                                                  ),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  height: 1.50,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          10)),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    // color: Colors.black,
                                                                    width: 50,
                                                                    child: Text(
                                                                      item[
                                                                          "reasonForAppointment"],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0XFF5F6989),
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
                                                                  const SizedBox(
                                                                    width: 50,
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        top: getVerticalSize(
                                                                            5),
                                                                      ),
                                                                      height: getSize(
                                                                          15.00),
                                                                      width: getSize(
                                                                          15.00),
                                                                      child: SvgPicture.asset(
                                                                          ImageConstant
                                                                              .imgRefreshalt,
                                                                          fit: BoxFit
                                                                              .fill)),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: getVerticalSize(
                                                                            5.00),
                                                                        left: getHorizontalSize(
                                                                            10)),
                                                                    child:
                                                                        Container(
                                                                      // margin: EdgeInsets.only(
                                                                      //     right: getHorizontalSize(
                                                                      //         10)),
                                                                      child:
                                                                          Text(
                                                                        item[
                                                                            "typeOfConsultation"],
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
                                                            getVerticalSize(5)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                                    10),
                                                            top:
                                                                getVerticalSize(
                                                                    5),
                                                          ),
                                                          child: Text(
                                                            formatter.format(
                                                                DateTime.parse(item[
                                                                    "appointmentDate"])),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF252E4B),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                                    20),
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
                                                                fontSize: 14),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      20),
                                                              top:
                                                                  getVerticalSize(
                                                                      10),
                                                              bottom:
                                                                  getVerticalSize(
                                                                      10)),
                                                          child: timediff ==
                                                                  null
                                                              ? Container()
                                                              : SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgStartsIn,
                                                                  fit: BoxFit
                                                                      .fill)),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                                    10),
                                                            top:
                                                                getVerticalSize(
                                                                    10),
                                                            bottom:
                                                                getVerticalSize(
                                                                    10)),
                                                        child: Text(
                                                            timediff ?? '',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .textstylelatomedium163
                                                                .copyWith(
                                                              fontSize:
                                                                  getFontSize(
                                                                      13),
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                      child: hasMore
                                          ? const CircularProgressIndicator()
                                          : const Text("")),
                                );
                              }
                            },
                          ),
                        ),
                ),
              ])),
    );
    //   } else {
    //     return const Center(child: CircularProgressIndicator());
    //   }
    // });
  }

  Future<void> connectStomp() async {
    jwtData = await _cacheService.readCache(key: "jwtdata");

    client = StompClient(
        config: StompConfig(
      url: 'wss://$domain/api/ws?token=' + jwtData!,
      onConnect: (StompFrame frame) {
        // print('onConnectCallback ${frame.body}');

        if (_items.isNotEmpty) {
          client.subscribe(
              destination: '/topic/getStatus/$userGuId',
              callback: todaysAppointment);
        }

        if (client.isActive) {
          Timer.periodic(const Duration(seconds: 10), (_) {
            if (userGuId.isNotEmpty) {
              client.send(
                destination: '/app/heartBeats',
                body: json.encode({
                  'userGuid': userGuId,
                  'lastActiveDate': SimpleDateFormatConverter.currentDate(),
                  'timeZone': timeZone,
                }),
              );
            }

            if (_items.isNotEmpty) {
              for (int i = 0; i < _items.length; i++) {
                final item = _items[i];
                sendTodaysAppointmentUserGuidToServer(item["userGuId"]);
              }
            }
          });
        }
      },
      beforeConnect: () async {
        print("connect stomp in dashboard home vieewwwwwwww");
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

  Future<void> _userDetails() async {
    var userDetails = Provider.of<DoctorNotifier>(context, listen: false);
    var details = await userDetails.getUserDetails(context);

    print("name ${details['firstName']}");

    username = details['firstName'];
    userGuId = details['userGuId'];

    await connectStomp();
  }

  Future<void> todaysAppointment(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    todaysStatusParsedData = await jsonDecode(decodedData);
    // print('todaysAppointment ${todaysStatusParsedData}');
    setState(() {});
  }

  Future<void> tz() async {
    // final CacheService _cacheService = CacheService();
    // jwtData = await _cacheService.readCache(key: "jwtdata");
    // bool hasExpired = JwtDecoder.isExpired(jwtData!);
    // if (hasExpired) {
    //   _timeoutpopUP();
    // // DateTime expirationDate = JwtDecoder.getExpirationDate(jwtData!);
    // // print(expirationDate);
    //   return true;
    // }

    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    // return false;
  }

  void sendTodaysAppointmentUserGuidToServer(userGuid) {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': userGuid,
        'timeZone': timeZone,
      }),
    );
  }
}
