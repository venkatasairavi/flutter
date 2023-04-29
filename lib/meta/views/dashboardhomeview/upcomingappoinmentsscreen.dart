import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/notifier/doctornotifier.dart';
import 'package:moibleapi/utils/Utils/SimpleDateFormatConverter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/api.routes.dart';
import '../../../core/services/cache.service.dart';
import '../patientDashboardScreens/home/view/StartConsultation.dart';

class UpcomingAppointmentsscreen extends StatefulWidget {
  @override
  State<UpcomingAppointmentsscreen> createState() =>
      _UpcomingAppointmentsscreenState();
}

class _UpcomingAppointmentsscreenState
    extends State<UpcomingAppointmentsscreen> {
  var data;
  int page = 0;
  int pgsize = 5;
  final DateFormat formatter = DateFormat('E dd MMM, yyyy');
  final ScrollController controller = ScrollController();
  List<dynamic> items = [];
  bool hasMore = true;
  bool isLoading = false;
  var reqData;
  final CacheService _cacheService = CacheService();

  @override
  void initState() {
    super.initState();
    webViewMethod();

    fetch();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        // print("affffffffffffffffffffffffffffffffffffff");
        fetch();
        // setState(() {
        //   isLoading = false;
        //   hasMore = false;
        // });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    // setState(() {
    //   hasMore = true;
    // });
    // print("pageeeeeeeeeeeeeeeeeeeeeeeeeeee");
    // print(page);
    // print(reqData);

    var docNotifier = Provider.of<DoctorNotifier>(context, listen: false);
    reqData = await docNotifier.getPatientHistory(
        // patientGuId: data["patientGuId"],
        pgNum: page,
        context: context);
    // print("length of objesctssssss");
    print(reqData);
    // print(reqData["count"]);
    //print(jsonEncode(reqData));

    setState(() {
      page++;

      isLoading = false;
      // if (newItems["count"] < 10) {
      if (reqData["count"] < 5) hasMore = false;

      items.addAll(reqData["list"].map<dynamic>((item) {
        return {
          "patientAppointmentGuid": item["patientAppointmentGuid"] ?? "",
          "appointmentDate": item["appointmentDate"] ?? "",
          "appointmentStartTime": item["appointmentStartTime"] ?? "",
          "appointmentEndTime": item["appointmentEndTime"] ?? "",
          "doctorName": item["doctorName"] ?? "",
          "reasonForAppointment": item["reasonForAppointment"] ?? "",
          "consultationType": item["consultationType"] ?? "",
        };
      }));

      // print(
      //     "itemssssssssssssssssssssssssssss adededddddddddddddddddddddddddddd");
      // print(items);
      // print(items.length);
      // isLoading = false;
      // if (items.length <= reqData["count"]) {
      //   hasMore = false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    var timediff = SimpleDateFormatConverter.getTimeDiff(
        data["appointmentDate"], data["appointmentStartTime"]);
    print(data["appointmentDate"] + "#" + data["appointmentStartTime"]);
    print(data['statusColor'] == ColorConstant.redA400);

    return Scaffold(
        backgroundColor: ColorConstant.indigo800,
        //resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height * .95,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.gray50,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getHorizontalSize(0.00)),
                topRight: Radius.circular(getHorizontalSize(0.00)),
                bottomLeft: Radius.circular(getHorizontalSize(30.00)),
                bottomRight: Radius.circular(getHorizontalSize(30.00))),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: getVerticalSize(40.00),
                              left: getHorizontalSize(25.0)),
                          child: Container(
                              height: getSize(46.00),
                              width: getSize(46.00),
                              child: SvgPicture.asset(ImageConstant.imgBack3,
                                  fit: BoxFit.fill))))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(12.00),
                        //     left: getHorizontalSize(25.0)
                      ),
                      child: Container(
                          // color: Colors.red,
                          height: MediaQuery.of(context).size.height * .8,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(10),
                                    left: getHorizontalSize(20),
                                    right: getHorizontalSize(29)),
                                child: Container(
                                  width: double.infinity,
                                  //height: 140,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.whiteA700,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        8.00,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstant.black9001f,
                                        spreadRadius: getHorizontalSize(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        10.00),
                                                    top: getVerticalSize(10.00),
                                                    //bottom: getVerticalSize(16.00)
                                                  ),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      children: [
                                                        Container(
                                                            height:
                                                                getSize(50.00),
                                                            width:
                                                                getSize(50.00),
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
                                                          child: Container(
                                                            height: 10,
                                                            width: 10,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: data[
                                                                  'statusColor'],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      getHorizontalSize(
                                                                          80.00)),
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                //mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            10)),
                                                    child: Text(
                                                      data["firstName"] +
                                                          " " +
                                                          data["lastName"],
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0XFF252E4B),
                                                        fontSize: getFontSize(
                                                          15,
                                                        ),
                                                        fontFamily: 'Lato',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 1.50,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            12)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          child: Text(
                                                            data[
                                                                "reasonForAppointment"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0XFF5F6989),
                                                              fontSize:
                                                                  getFontSize(
                                                                14,
                                                              ),
                                                              fontFamily:
                                                                  'Lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.50,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 50,
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              top:
                                                                  getVerticalSize(
                                                                      5),
                                                            ),
                                                            height:
                                                                getSize(15.00),
                                                            width:
                                                                getSize(15.00),
                                                            child: SvgPicture.asset(
                                                                ImageConstant
                                                                    .imgRefreshalt,
                                                                fit: BoxFit
                                                                    .fill)),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top:
                                                                  getVerticalSize(
                                                                      5.00),
                                                              left:
                                                                  getHorizontalSize(
                                                                      5)),
                                                          child: Container(
                                                            // margin: EdgeInsets.only(
                                                            //     right: getHorizontalSize(
                                                            //         10)),
                                                            child: Text(
                                                              data[
                                                                  "typeOfConsultation"],
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0XFFFF9500),
                                                                fontSize:
                                                                    getFontSize(
                                                                  14,
                                                                ),
                                                                fontFamily:
                                                                    'Lato',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 1.50,
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
                                              top: getVerticalSize(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(20),
                                                  top: getVerticalSize(5),
                                                ),
                                                child: Text(
                                                  formatter.format(
                                                      DateTime.parse(data[
                                                          "appointmentDate"])),
                                                  style: const TextStyle(
                                                      color: Color(0XFF252E4B),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(20),
                                                  top: getVerticalSize(5),
                                                ),
                                                child: Text(
                                                  data["appointmentStartTime"] +
                                                      "-" +
                                                      data[
                                                          "appointmentEndTime"],
                                                  style: const TextStyle(
                                                      color: Color(0XFF252E4B),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Divider(
                                              thickness: 1,
                                              color: ColorConstant.black90040,
                                              indent: 12,
                                              endIndent: 12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: getVerticalSize(5),
                                              left: getHorizontalSize(10),
                                              bottom: getVerticalSize(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data["gender"] +
                                                    "," +
                                                    data["age"].toString(),
                                                style: TextStyle(
                                                    color: ColorConstant
                                                        .bluegray400),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  10),
                                                          top: getVerticalSize(
                                                              10),
                                                          bottom:
                                                              getVerticalSize(
                                                                  10)),
                                                      child: timediff == null
                                                          ? Container()
                                                          : SvgPicture.asset(
                                                              ImageConstant
                                                                  .imgStartsIn,
                                                              fit:
                                                                  BoxFit.fill)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            5),
                                                        top:
                                                            getVerticalSize(10),
                                                        bottom:
                                                            getVerticalSize(10),
                                                        right:
                                                            getHorizontalSize(
                                                                12)),
                                                    child: Text(timediff ?? '',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .textstylelatomedium163
                                                            .copyWith(
                                                          fontSize:
                                                              getFontSize(13),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  // color: ColorConstant.indigo800,
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1BC8C8),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            getHorizontalSize(15.00)),
                                        topRight: Radius.circular(
                                            getHorizontalSize(15.00)),
                                        bottomLeft: Radius.circular(
                                            getHorizontalSize(15.00)),
                                        bottomRight: Radius.circular(
                                            getHorizontalSize(15.00))),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                            child: SvgPicture.asset(
                                                ImageConstant.imgGroup100687,
                                                fit: BoxFit.fill)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: getHorizontalSize(5)),
                                          child: const Text(
                                            "+1 (970) 453-9764",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Color(0XFFFFFFFF)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(20),
                                ),
                                child: const Text(
                                  "Reason *",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0XFF252E4B),
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(10),
                                    left: getHorizontalSize(25),
                                    right: getHorizontalSize(20)),
                                child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.whiteA700,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              getHorizontalSize(15.00)),
                                          topRight: Radius.circular(
                                              getHorizontalSize(15.00)),
                                          bottomLeft: Radius.circular(
                                              getHorizontalSize(15.00)),
                                          bottomRight: Radius.circular(
                                              getHorizontalSize(15.00))),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.black9001f,
                                          spreadRadius: getHorizontalSize(
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(10),
                                          left: getHorizontalSize(20)),
                                      child: Text(
                                        data["reasonForAppointment"],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: getVerticalSize(15),
                                      left: getHorizontalSize(20),
                                      right: getHorizontalSize(20)),
                                  child: Container(
                                    //color: Colors.red,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.whiteA700,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              getHorizontalSize(10.00)),
                                          topRight: Radius.circular(
                                              getHorizontalSize(10.00)),
                                          bottomLeft: Radius.circular(
                                              getHorizontalSize(10.00)),
                                          bottomRight: Radius.circular(
                                              getHorizontalSize(10.00))),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.black9001f,
                                          spreadRadius: getHorizontalSize(
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
                                    // height: 300,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(10),
                                          left: getHorizontalSize(15),
                                          right: getHorizontalSize(10)),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "Previous Consultations",
                                                style: TextStyle(
                                                    color: Color(0XFF252E4B),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                              // Icon(
                                              //   Icons
                                              //       .keyboard_arrow_down_rounded,
                                              //   size: 20,
                                              //   color: Color(0XFF252E4B),
                                              // ),
                                            ],
                                          ),
                                          Container(
                                            color: ColorConstant.black9000d,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          Flexible(
                                              flex: 1,
                                              child: ListView.builder(
                                                controller: controller,
                                                shrinkWrap: true,
                                                // physics:
                                                //     BouncingScrollPhysics(),
                                                itemCount: items.length + 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  if (index < items.length) {
                                                    final item = items[index];

                                                    return Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            // width: double
                                                            //     .infinity,
                                                            //height: 140,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  ColorConstant
                                                                      .whiteA700,
                                                              // borderRadius:
                                                              //     BorderRadius.circular(
                                                              //   getHorizontalSize(
                                                              //     8.00,
                                                              //   ),
                                                              // ),
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
                                                                  offset:
                                                                      const Offset(
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
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                              left: getHorizontalSize(5.00),
                                                                              // top: getVerticalSize(10.00),
                                                                              //bottom: getVerticalSize(16.00)
                                                                            ),
                                                                            child: Container(
                                                                                height: getSize(40.00),
                                                                                width: getSize(40.00),
                                                                                child: SvgPicture.asset(ImageConstant.imgUseravatar, fit: BoxFit.fill))),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              //color: Colors.blueAccent,
                                                                              margin: EdgeInsets.only(left: getHorizontalSize(5)),
                                                                              child: Row(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(top: getVerticalSize(10), left: getHorizontalSize(5)),
                                                                                    child: Text(
                                                                                      item["doctorName"],
                                                                                      style: TextStyle(
                                                                                        color: const Color(0XFF252E4B),
                                                                                        fontSize: getFontSize(
                                                                                          13,
                                                                                        ),
                                                                                        fontFamily: 'Lato',
                                                                                        fontWeight: FontWeight.w700,
                                                                                        height: 1.50,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(top: getVerticalSize(5), left: getHorizontalSize(80)),
                                                                                    child: Text(
                                                                                      item["patientAppointmentGuid"].substring(item["patientAppointmentGuid"].length - 6, item["patientAppointmentGuid"].length),
                                                                                      style: TextStyle(
                                                                                        decoration: TextDecoration.underline,
                                                                                        color: Colors.blueAccent,
                                                                                        fontSize: getFontSize(
                                                                                          12,
                                                                                        ),
                                                                                        fontFamily: 'Lato',
                                                                                        fontWeight: FontWeight.w700,
                                                                                        height: 1.50,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: getHorizontalSize(5)),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: getHorizontalSize(5),
                                                                                      top: getVerticalSize(5),
                                                                                    ),
                                                                                    child: Text(
                                                                                      formatter.format(DateTime.parse(item["appointmentDate"])),
                                                                                      style: const TextStyle(color: Color(0XFF252E4B), fontWeight: FontWeight.w500, fontSize: 10),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: getHorizontalSize(5),
                                                                                      top: getVerticalSize(5),
                                                                                    ),
                                                                                    child: Text(
                                                                                      item["appointmentStartTime"] + "-" + item["appointmentEndTime"],
                                                                                      style: const TextStyle(color: Color(0XFF252E4B), fontWeight: FontWeight.w500, fontSize: 10),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(left: getHorizontalSize(10)),
                                                                              child: Row(
                                                                                //mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 40,
                                                                                    child: Text(
                                                                                      item["reasonForAppointment"],
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        color: const Color(0XFF5F6989),
                                                                                        fontSize: getFontSize(
                                                                                          14,
                                                                                        ),
                                                                                        fontFamily: 'Lato',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 1.50,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(left: getHorizontalSize(40)),
                                                                                    child: Row(children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(top: getVerticalSize(5)),
                                                                                        child: Container(height: 10, width: 10, child: SvgPicture.asset(ImageConstant.imgRefreshalt, fit: BoxFit.fill)),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                          left: getHorizontalSize(5),
                                                                                          top: getVerticalSize(5.00),
                                                                                        ),
                                                                                        child: Text(
                                                                                          item["consultationType"],
                                                                                          style: TextStyle(
                                                                                            color: const Color(0XFFFF9500),
                                                                                            fontSize: getFontSize(
                                                                                              12,
                                                                                            ),
                                                                                            fontFamily: 'Lato',
                                                                                            fontWeight: FontWeight.w500,
                                                                                            height: 1.50,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ]),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ]),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 32),
                                                      child: Center(
                                                          child: hasMore
                                                              ? const CircularProgressIndicator()
                                                              : const Text("")),
                                                    );
                                                  }
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 55,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 5, right: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF252E4B),
                                      shape: const StadiumBorder(),
                                      elevation: 7,
                                      onPrimary: ColorConstant.redA400),
                                  child: const Text(
                                    "Start Consultation",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    startConsultation();
                                  },
                                ),
                              )
                            ],
                          )))),
            ],
          ),
        ));
  }

  Future<void> startConsultation() async {
    print("==================================================S");
    print(SimpleDateFormatConverter.isTimeAfter(data["appointmentStartTime"]));
    print("==================================================E");
    print(SimpleDateFormatConverter.isTimeAfter(data["appointmentEndTime"]));
    print("==================================================Done");
    print(SimpleDateFormatConverter.decrementMinutesBy(data["appointmentStartTime"], 1));

    if (!SimpleDateFormatConverter.isTimeAfter(SimpleDateFormatConverter.decrementMinutesBy(data["appointmentStartTime"], 1)) &&
        SimpleDateFormatConverter.isTimeAfter(data["appointmentEndTime"])) {
      // data["appointmentStartTime"] + "-" + data["appointmentEndTime"]
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var conferenceLink = Baseurl +
          '/mobile-vc?patientAppointmentGuId=' +
          data['patientAppointmentGuId'] +
          '&authToken=' +
          jwtData! +
          '&userType=Doctor';
      Navigator.pop(context);
      print("conferenceLink $conferenceLink");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StartConsultation(passedUrl: conferenceLink, userType: 'DOCTOR');
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Video conference will start only \n between slot time",
              style: TextStyle(fontSize: 16))));
    }
  }
}
