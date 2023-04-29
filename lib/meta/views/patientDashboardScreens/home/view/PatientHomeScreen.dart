import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/dashboard/notifier/DashboardHomeNotifier.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/home/view/StartConsultation.dart';
import 'package:provider/provider.dart';
import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/theme/app_decoration.dart';
import '../../../../../core/services/cache.service.dart';
import '../../../../../utils/Utils/SimpleDateFormatConverter.dart';
import '../../../../../utils/Utils/Utils.dart';
import '../notifier/PatientHomeNotifier.dart';

import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _DashboardFirstTimeOneState();
}

class _DashboardFirstTimeOneState extends State<PatientHomeScreen>
    with WidgetsBindingObserver {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController dropdown = TextEditingController();
  final CacheService _cacheService = CacheService();

  late StompClient client;

  var physicianValue = true,
      surgeonValue = false,
      adultValue = true,
      isPediatricsValue = false,
      isGeneralValue = true,
      isSpecialistValue = false;

  var username = "",
      appDocName = "",
      appTime = "",
      appReason = "",
      appDate = "",
      patientGuid = "",
      appTittle = "",
      availableDoctors = "",
      appointmentDate = '',
      appointmentTimeDiff = '',
      doctorGuid = '',
      userGuId = '',
      patientAppointmentGuid = '',
      upComingAppointmentsDoctorGuid = '',
      upcomingAppointmentsUserGuid = '';

  var availableDoctor = "", userCity = "", timeZone = "";

  var ivDoctorStatusColor = ColorConstant.redA400;
  var availableDoctorStatus = ColorConstant.redA400;

  late Map<String, dynamic> availableDoctorsStatusParsedData =
      <String, dynamic>{};

  final controller = ScrollController();
  List<dynamic> items = [];
  bool hasMore = true;
  bool isLoading = false;
  bool _isDialogShowing = false;

  String? jwtData;
  final DateFormat formatter = DateFormat('E dd MMM, yyyy');
  // late StompClient client;

  @override
  void initState() {
    super.initState();
    tz();
    // getDoctorDetails();
    userDetails();
    fetchUpcomingAppointData();
    if (_cacheService.readCache(key: "status") == null) updatePatientStatus();
    //  connectStomp();
    webViewMethod();
    WidgetsBinding.instance!.addObserver(this);
    if (isLoading) return;

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetchDoctorsData();
      }
    });
  }

  //String _selected = "";
  List<Map> itemsData = [
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

  int page = 0;
  int pgsize = 10;
  int recordCount = 0;

  String _selected = "Available";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.indigo800,
      body: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
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
                                          itemBuilder: (context) => itemsData
                                              .map((item) => PopupMenuItem<
                                                      String>(
                                                  value: item['title'],
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          item['icon'],
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0),
                                                              child: Text(
                                                                  item['title'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black))),
                                                        ],
                                                      ),
                                                      Text(
                                                        item['des'],
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )))
                                              .toList(),
                                          onSelected: (value) {
                                            setState(() {
                                              _selected = value;
                                              updatePatientStatus();
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                if (_selected ==
                                                    'Unavailable') ...[
                                                  itemsData[0]['icon']
                                                ] else if (_selected ==
                                                    'Available') ...[
                                                  itemsData[1]['icon']
                                                ] else if (_selected ==
                                                    'Busy') ...[
                                                  itemsData[2]['icon']
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
                            top: getVerticalSize(33.00),
                            right: getHorizontalSize(23.00)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: getVerticalSize(6.00),
                                  bottom: getVerticalSize(4.00)),
                              child: Text("Hello, ${username ?? ""}  ",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatobold20
                                      .copyWith(fontSize: getFontSize(20)))),
                          Image.asset(
                            ImageConstant.wave,
                            cacheWidth: 35,
                            cacheHeight: 35,
                          )
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
                        right: getHorizontalSize(10.00)),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                              controller: searchcontroller,
                              onChanged: (text) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  hintText: "Search Doctors",
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
                                  filled: true,
                                  fillColor: ColorConstant.gray100,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      top: getVerticalSize(15.00),
                                      bottom: getVerticalSize(15.00),
                                      left: getVerticalSize(15.00))),
                              style: TextStyle(
                                  color: ColorConstant.bluegray600Af,
                                  fontSize: getFontSize(14.0),
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500)),
                          flex: 8,
                        ),
                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              if (searchcontroller.text.isEmpty) {
                                _filterBottomSheet();
                              } else {
                                refresh();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstant.indigo800,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          10.00,
                                        ),
                                      )),
                                  width: 45,
                                  height: 45,
                                  child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        searchcontroller.text.isNotEmpty
                                            ? ImageConstant.imgSearch
                                            : ImageConstant.imgBack,
                                        fit: BoxFit.fill,
                                        color: ColorConstant.whiteA700,
                                      ))),
                            ),
                          ),
                        )
                      ],
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getHorizontalSize(23.00),
                          top: getVerticalSize(15.00),
                          right: getHorizontalSize(23.00)),
                      child: Text(appTittle ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black)),
                    )),
                appDocName == ""
                    ? Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: getHorizontalSize(23.00),
                                top: getVerticalSize(15.00),
                                right: getHorizontalSize(23.00)),
                            child: SvgPicture.asset(
                                ImageConstant.imgNoAppointFound,
                                fit: BoxFit.fill)))
                    : Card(
                        // clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
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
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: getSize(41.00),
                                                      width: getSize(41.00),
                                                      child: SvgPicture.asset(
                                                          ImageConstant
                                                              .imgUseravatar,
                                                          fit: BoxFit.fill)),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          ivDoctorStatusColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                ]),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(16.00),
                                                ),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  getHorizontalSize(
                                                                      10.00)),
                                                          child: Text(
                                                              appDocName,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .textstylelatomedium14
                                                                  .copyWith(
                                                                      fontSize:
                                                                          getFontSize(
                                                                              16),
                                                                      color: ColorConstant
                                                                          .black900))),
                                                      Container(
                                                        width: 200,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              top:
                                                                  getVerticalSize(
                                                                      1.97)),
                                                          child: Text(appReason,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .textstylelatomedium12
                                                                  .copyWith(
                                                                      fontSize:
                                                                          getFontSize(
                                                                              14))),
                                                        ),
                                                      )
                                                    ]))
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(15.00),
                                                  bottom: getVerticalSize(3.00),
                                                  left: getVerticalSize(5.00),
                                                ),
                                                child: Text(appointmentDate,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: ColorConstant
                                                            .indigo800,
                                                        fontSize:
                                                            getFontSize(14)))),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(15.00),
                                                  bottom: getVerticalSize(3.00),
                                                  left: getVerticalSize(5.00),
                                                ),
                                                child: Text(appTime ?? "",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            getFontSize(14)))),
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(5.00),
                                                  bottom: getVerticalSize(3.00),
                                                  left: getVerticalSize(5.00),
                                                ),
                                                child:
                                                    appointmentTimeDiff == null
                                                        ? SvgPicture.asset(
                                                            ImageConstant
                                                                .imgStartsIn,
                                                            fit: BoxFit.fill,
                                                            color: ColorConstant
                                                                .whiteA700,
                                                          )
                                                        : SvgPicture.asset(
                                                            ImageConstant
                                                                .imgStartsIn,
                                                            fit: BoxFit.fill)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(5.00),
                                                  bottom: getVerticalSize(3.00),
                                                  left: getVerticalSize(5.00),
                                                ),
                                                child: Text(
                                                    appointmentTimeDiff ?? '',
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylelatomedium163
                                                        .copyWith(
                                                      fontSize: getFontSize(13),
                                                    ))),
                                          ]),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            top: getVerticalSize(10.00),
                                            bottom: getVerticalSize(3.00),
                                            left: getVerticalSize(5.00),
                                          ),
                                          child: const Divider(
                                              height: 1, color: Colors.grey)),
                                      IntrinsicHeight(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _cancelAppointment(),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
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
                                                          child:
                                                              SvgPicture.asset(
                                                                  ImageConstant
                                                                      .imgCancel,
                                                                  fit: BoxFit
                                                                      .fill)),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: getVerticalSize(
                                                              5.00),
                                                          bottom:
                                                              getVerticalSize(
                                                                  3.00),
                                                          left: getVerticalSize(
                                                              5.00),
                                                        ),
                                                        child: const Text(
                                                            "Cancel",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                      ),
                                                    ]),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const VerticalDivider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              GestureDetector(
                                                  onTap: () =>
                                                      _reschedulePopUp(),
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
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
                                                            child: SvgPicture.asset(
                                                                ImageConstant
                                                                    .imgReschedule,
                                                                fit: BoxFit
                                                                    .fill)),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
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
                                                          child: const Text(
                                                              "Reschedule",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        ),
                                                      ])),
                                            ]),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getHorizontalSize(23.00),
                          top: getVerticalSize(15.00),
                          right: getHorizontalSize(23.00)),
                      child: Text(availableDoctors ?? "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black)),
                    )),
                Expanded(
                    child: SizedBox(
                        width: double.infinity,
                        // height:  MediaQuery.of(context).size.height,
                        // decoration:BoxDecoration(color: ColorConstant.black900),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              controller: controller,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length + 1,
                              itemBuilder: (context, index) {
                                if (index < items.length) {
                                  final item = items[index];

                                  if (availableDoctorsStatusParsedData
                                      .isNotEmpty) {
                                    if (availableDoctorsStatusParsedData[
                                            'userGuid'] ==
                                        item['userGuId']) {
                                      if (availableDoctorsStatusParsedData[
                                              'status'] !=
                                          null) {
                                        if (availableDoctorsStatusParsedData[
                                                'status'] ==
                                            'Available') {
                                          if (SimpleDateFormatConverter.getTime(
                                                  availableDoctorsStatusParsedData[
                                                      'lastActiveDate']) ==
                                              "just now") {
                                            availableDoctorStatus =
                                                ColorConstant.green;
                                          } else if (SimpleDateFormatConverter
                                                  .getTime(
                                                      availableDoctorsStatusParsedData[
                                                          'lastActiveDate']) ==
                                              "2 minute ago") {
                                            availableDoctorStatus =
                                                ColorConstant.redA400;
                                          } else {
                                            availableDoctorStatus =
                                                ColorConstant.orange;
                                          }
                                        } else if (availableDoctorsStatusParsedData[
                                                'status'] ==
                                            'Unavailable') {
                                          availableDoctorStatus =
                                              ColorConstant.redA400;
                                        } else if (availableDoctorsStatusParsedData[
                                                'status'] ==
                                            'Busy') {
                                          availableDoctorStatus =
                                              ColorConstant.orange;
                                        }
                                        // setState(() {});
                                      }
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          bookAppointment,
                                          arguments: [
                                            item["doctorGuid"],
                                            false,
                                          ]);
                                    },
                                    child: Card(
                                      // clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      color: ColorConstant.whiteA700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              getHorizontalSize(
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
                                                              children: <
                                                                  Widget>[
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
                                                                        availableDoctorStatus,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  height: 10,
                                                                  width: 10,
                                                                ),
                                                              ]),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
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
                                                                        child: Text(
                                                                            "Dr." + item["firstName"] + " " + item['lastName'] ??
                                                                                "",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign: TextAlign.left,
                                                                            style: AppStyle.textstylelatomedium14.copyWith(fontSize: getFontSize(16)))),
                                                                    Row(
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
                                                                              padding: EdgeInsets.only(
                                                                                top: getVerticalSize(5.00),
                                                                                bottom: getVerticalSize(3.00),
                                                                              ),
                                                                              child: Text(item["doctorDegree"] ?? "", textAlign: TextAlign.left, style: TextStyle(color: ColorConstant.indigo800, fontSize: getFontSize(16)))),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(
                                                                                top: getVerticalSize(5.00),
                                                                                bottom: getVerticalSize(3.00),
                                                                                left: getVerticalSize(5.00),
                                                                              ),
                                                                              child: Text(item["city"] + ", " + item['state'], textAlign: TextAlign.left, style: const TextStyle(color: Colors.black))),
                                                                        ]),
                                                                  ]))
                                                        ]),
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Text(
                                                            "\$ ${item["primaryConsultationCharges"]}",
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: AppStyle
                                                                .textstylelatomedium163
                                                                .copyWith(
                                                              fontSize:
                                                                  getFontSize(
                                                                      18),
                                                              color: Colors
                                                                  .greenAccent,
                                                            ))),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(child: Text("")),
                                  );
                                }
                              },
                            ),
                          ),
                        ))),
              ])),
    );
  }

  void _filterBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.asset(ImageConstant.imgCancel,
                              color: Colors.grey, fit: BoxFit.fill),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("All Filters",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.indigo800,
                                fontSize: getFontSize(25),
                              )))),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              physicianValue = true;
                              surgeonValue = false;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: physicianValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("Physician",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: physicianValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              physicianValue = false;
                              surgeonValue = true;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: surgeonValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("Surgeon",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: surgeonValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              adultValue = true;
                              isPediatricsValue = false;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: adultValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("Adult",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: adultValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              adultValue = false;
                              isPediatricsValue = true;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: isPediatricsValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("Pediatrics",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: isPediatricsValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isGeneralValue = true;
                              isSpecialistValue = false;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: isGeneralValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("General",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: isGeneralValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isGeneralValue = false;
                              isSpecialistValue = true;
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(35.00),
                              width: getHorizontalSize(145.00),
                              decoration: BoxDecoration(
                                color: isSpecialistValue
                                    ? ColorConstant.grayLight
                                    : ColorConstant.whiteA700,
                                border:
                                    Border.all(color: ColorConstant.grayLight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        20.0) //                 <--- border radius here
                                    ),
                              ),
                              child: Text("Specialist",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(
                                          fontSize: getFontSize(13),
                                          color: isSpecialistValue
                                              ? ColorConstant.whiteA700
                                              : ColorConstant.grayLight)))),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            height: getVerticalSize(35.00),
                            width: getHorizontalSize(145.00),
                            child: Text("Clear All",
                                textAlign: TextAlign.left,
                                style: AppStyle.textstylelatomedium161
                                    .copyWith(fontSize: getFontSize(16))),
                          )),
                      GestureDetector(
                          onTap: () {
                            refresh();
                            Navigator.pop(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(40.00),
                              width: getHorizontalSize(145.00),
                              decoration: AppDecoration.textstylelatomedium16,
                              child: Text("Apply Filters",
                                  textAlign: TextAlign.left,
                                  style: AppStyle.textstylelatomedium16
                                      .copyWith(fontSize: getFontSize(16)))))
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  Future userDetails() async {
    var userDetails = Provider.of<DashboardNotifier>(context, listen: false);
    var details = await userDetails.getUserDetails(context);
    print("name ${details['firstName']}");

    username = details['firstName'];
    userCity = details['docCity'];
    userGuId = details['userGuId'];
    _selected = details["status"];

    await connectStomp();
    await fetchDoctorsData();

/*    var ud = await _cacheService.readCache(key: "userDetails");

    if(ud != null){
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);
      print("name ${user.docCity}");

      username = user.firstName!;
      userCity = user.docCity!;
      fetchDoctorsData();
    }*/
  }

  Future<void> fetchUpcomingAppointData() async {
    var upcomingAppointData =
        Provider.of<PatientHomeNotifier>(context, listen: false);
    var upCmAppotData =
        await upcomingAppointData.getUpcomingAppointments(context: context);
    print("upCmAppotData $upCmAppotData");
    if (upCmAppotData != null) {
      appTittle = 'Upcoming Appointments';
      appDocName =
          "Dr." + upCmAppotData['firstName'] + " " + upCmAppotData['lastName'];
      appReason = upCmAppotData['reasonForAppointment'];
      patientAppointmentGuid = upCmAppotData['patientAppointmentGuid'];
      doctorGuid = upCmAppotData['doctorGuid'];
      patientGuid = upCmAppotData['patientGuid'];
      upcomingAppointmentsUserGuid = upCmAppotData['userGuid'];
      appTime = upCmAppotData['appointmentStartTime'] +
          " - " +
          upCmAppotData['appointmentEndTime'];

      appointmentDate =
          formatter.format(DateTime.parse(upCmAppotData['appointmentDate']));

      appointmentTimeDiff = SimpleDateFormatConverter.getTimeDiff(
          upCmAppotData['appointmentDate'],
          upCmAppotData['appointmentStartTime'])!;

      try {
        if (client != null) {
          if (client.connected) {
            client.deactivate();
          }
          client.activate();
        }
      } catch (e) {
        print(e);
      }
    } else {
      appTittle = 'No Upcoming Appointments Found';
      appDocName = "";
      appTime = "";
      appReason = "";
      appDate = "";
      patientGuid = "";
      patientAppointmentGuid = '';
      upcomingAppointmentsUserGuid = '';
      doctorGuid = '';
      appointmentDate = '';
    }
    setState(() {});
  }

  Future<void> updatePatientStatus() async {
    var updatePatientStatus =
        Provider.of<PatientHomeNotifier>(context, listen: false);
    var patientStatus;
    patientStatus = await updatePatientStatus.updatePatientStatus(
        context: context, status: _selected);
    print("patientStatus $patientStatus");
    if (patientStatus != null) {
      setState(() {
        _selected = patientStatus;
      });
      _cacheService.writeCache(key: "status", value: _selected);
    }
  }

  Future<void> cancelAppointment() async {
    var cancelApp = Provider.of<PatientHomeNotifier>(context, listen: false);
    var cancelAppt = await cancelApp.cancelAppointment(
        context: context, patientAppointmentGuid: patientAppointmentGuid);

    if (cancelAppt == true) {
      // fetchUpcomingAppointData();
      Navigator.of(context).pushNamed(appointmentCancelled,
          arguments: [appDocName, appReason, appTime, appointmentDate]);
    }
  }

  Future fetchDoctorsData() async {
    if (isLoading) return;
    isLoading = true;

    var availableDoctorsData =
        Provider.of<PatientHomeNotifier>(context, listen: false);

    final jsonData = jsonEncode({
      "doctorName": "",
      "search": searchcontroller.text,
      "location": userCity,
      "pageNumber": 0,
      "pageSize": pgsize,
      "insuranceCovered": true,
      "isPhysician": physicianValue,
      "isAdultGeneral": adultValue,
      "isSpecialist": isSpecialistValue,
    });

    var patientStatus = await availableDoctorsData.getDoctors(
        context: context, filters: jsonData);

    if (items.isNotEmpty) {
      items.clear();
    }

    if (patientStatus["count"] != 0) {
      setState(() {
        availableDoctors = "Available Doctors";
        page++;
        isLoading = false;
        if (patientStatus["count"] < 10) {
          hasMore = false;
        }
        items.addAll(patientStatus["list"].map<dynamic>((item) {
          return {
            "primaryConsultationCharges":
                item["primaryConsultationCharges"] ?? "",
            "firstName": item["firstName"] ?? "",
            "lastName": item["lastName"] ?? "",
            "doctorDegree": item["doctorDegree"] ?? "",
            "city": item["city"] ?? "",
            "state": item["state"] ?? "",
            "userGuId": item["userGuId"] ?? "",
            "doctorGuid": item["doctorGuid"] ?? "",
          };
        }));
      });
    } else {
      setState(() {
        availableDoctors = "";
        isLoading = false;
        hasMore = false;
      });
    }
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      if (items.isNotEmpty) {
        items.clear();
      }
    });
    fetchDoctorsData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    // client.deactivate();
  }

  void _cancelAppointment() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        height: 130.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 25.0),
                child: Text('Do you want to cancel the appointment?',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 35.0,
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.grey),
                          primary: ColorConstant.whiteA700,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )),
                Container(
                    height: 35.0,
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cancelAppointment();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstant.indigo800,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void _reschedulePopUp() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        height: 380.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(ImageConstant.imgCancel,
                        color: Colors.grey, fit: BoxFit.fill),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SvgPicture.asset(ImageConstant.imgRescheduleAppointment,
                    fit: BoxFit.fill),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Text('Reschedule an appointment',
                    style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15.0),
                child: Text(
                    'If Your scheduled appointment is within 48 hours then rescheduling fee will be Applied.',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Text(
                    'Are you sure, you want to reschedule your appointment with ${appDocName + "?"}',
                    style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 45.0,
                    width: 150.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.grey),
                          primary: ColorConstant.whiteA700,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )),
                Container(
                    height: 45.0,
                    width: 150.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(bookAppointment,
                            arguments: [
                              doctorGuid,
                              true,
                              patientAppointmentGuid
                            ]);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstant.indigo800,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void _videoCallingPopup() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SizedBox(
        height: 180.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                child: Text('Join Video Consultation',
                    style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15.0),
                child: Text(appDocName + ' is calling...',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Flexible(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        rejectCall();
                      },
                      style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.grey),
                          primary: ColorConstant.whiteA700,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "Reject",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )),
                Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        joinCall();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstant.indigo800,
                          shape: const StadiumBorder(),
                          elevation: 7,
                          onPrimary: ColorConstant.redA400),
                      child: const Text(
                        "Join Call",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }

  Future<void> connectStomp() async {
    jwtData = await _cacheService.readCache(key: "jwtdata");

    client = StompClient(
        config: StompConfig(
      url: 'wss://$domain/api/ws?token=' + jwtData!,
      onConnect: (StompFrame frame) {
        // print('onConnectCallback ${frame.body}');

        if (patientAppointmentGuid.isNotEmpty) {
          client.subscribe(
              destination: '/topic/vc/$patientAppointmentGuid/$patientGuid',
              callback: onMessageReceive);
        }

        if (patientAppointmentGuid.isNotEmpty) {
          client.subscribe(
              destination: '/topic/getStatus/$userGuId',
              callback: upComingAppointmentsStatus);
        }

        client.subscribe(
            destination: '/topic/getStatus/$userGuId',
            callback: availableDoctorsStatus);

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

            if (upcomingAppointmentsUserGuid.isNotEmpty) {
              sendUpComingAppointmentUserGuidToServer();
            }

            if (items.isNotEmpty) {
              for (int i = 0; i < items.length; i++) {
                final item = items[i];
                sendAvailableDoctorsUserGuidToServer(item['userGuId']);
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

  void sendUpComingAppointmentUserGuidToServer() {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': upcomingAppointmentsUserGuid,
        'timeZone': timeZone,
      }),
    );
  }

  void sendAvailableDoctorsUserGuidToServer(String doctorsGuid) {
    client.send(
      destination: '/app/heartBeat/request/$userGuId',
      body: json.encode({
        'userGuid': doctorsGuid,
        'timeZone': timeZone,
      }),
    );
  }

  void joinCall() {
    var conferenceLink = Baseurl +
        '/mobile-vc?patientAppointmentGuId=' +
        patientAppointmentGuid +
        '&authToken=' +
        jwtData! +
        '&userType=Patient';
    Navigator.pop(context);
    print(conferenceLink);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StartConsultation(
        passedUrl: conferenceLink,
        userType: 'PATIENT',
      );
    }));
  }

  void rejectCall() {
    client.send(
      destination: '/topic/vc/$patientAppointmentGuid/$doctorGuid',
      body: json.encode({
        'callRejected': true,
      }),
    );
    Navigator.pop(context);
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
  }

  Future webViewMethod() async {
    print('In Microphone permission method');
    //WidgetsFlutterBinding.ensureInitialized();

    await Permission.microphone.request();
    WebViewMethodForCamera();
  }

  Future WebViewMethodForCamera() async {
    print('In Camera permission method');
    //WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        print('Tag : ' + 'resumed');
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        print('Tag : ' + 'inactive');
        break;
      case AppLifecycleState.paused:
        // widget is paused
        print('Tag : ' + 'paused');
        break;
      case AppLifecycleState.detached:
        // widget is detached
        print('Tag : ' + 'detached');
        break;
    }
  }

  Future<void> onMessageReceive(StompFrame stompFrame) async {
    var jn =
        '[123, 34, 100, 111, 99, 116, 111, 114, 74, 111, 105, 110, 101, 100, 34, 58, 116, 114, 117, 101, 44, 34, 102, 111, 114, 77, 111, 98, 105, 108, 101, 34, 58, 116, 114, 117, 101, 125]';

    var join =
        '[123, 34, 100, 111, 99, 116, 111, 114, 74, 111, 105, 110, 101, 100, 34, 58, 116, 114, 117, 101, 125]';
    var reject =
        '[123, 34, 99, 97, 108, 108, 82, 101, 106, 101, 99, 116, 101, 100, 34, 58, 116, 114, 117, 101, 125]';

    var frame = stompFrame.binaryBody.toString();
    if (frame == join || frame == jn) {
      _isDialogShowing = true;
      //  setState(() {});
      _videoCallingPopup();
      print("video call popupppppppp");
    } else if (frame == reject) {
      if (_isDialogShowing) {
        print("POPPPPPPPPPPPPPPPPPPPPP");
        _isDialogShowing = false;
        // setState(() {});
        Navigator.of(context).pop();
      }
    }

    print('onMessageReceive ${stompFrame.binaryBody}');
  }

  Future<void> upComingAppointmentsStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    final Map<String, dynamic> parsedData = await jsonDecode(decodedData);

    try {
      if (parsedData['status'] != null) {
        if (parsedData['status'] == 'Available') {
          if (SimpleDateFormatConverter.getTime(parsedData['lastActiveDate']) ==
              "just now") {
            ivDoctorStatusColor = ColorConstant.green;
          } else if (SimpleDateFormatConverter.getTime(
                  parsedData['lastActiveDate']) ==
              "2 minute ago") {
            ivDoctorStatusColor = ColorConstant.redA400;
          } else {
            ivDoctorStatusColor = ColorConstant.orange;
          }
        } else if (parsedData['status'] == 'Unavailable') {
          ivDoctorStatusColor = ColorConstant.redA400;
        } else if (parsedData['status'] == 'Busy') {
          ivDoctorStatusColor = ColorConstant.orange;
        }
        // setState(() {});
      }
    } catch (e) {
      print(e);
    }

    // var userGuid = parsedData['userGuid'];
    // print('upComingAppointmentsStatus; $decodedData');
  }

  Future<void> availableDoctorsStatus(StompFrame status) async {
    var decodedData = await json.decode(json.encode(status.body));
    availableDoctorsStatusParsedData = await jsonDecode(decodedData);
    // print('availableDoctorsStatus ${availableDoctorsStatusParsedData}');
    setState(() {});
  }
}
