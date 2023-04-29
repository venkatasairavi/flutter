
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:provider/provider.dart';
import '../../../../../app/routes/api.routes.dart';
import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../app/theme/app_style.dart';
import '../../../../../core/services/cache.service.dart';
import '../../../../../utils/Utils/SimpleDateFormatConverter.dart';
import '../../dashboard/model/UserDetialsModel.dart';
import '../../dashboard/view/PaypalBrowser.dart';
import '../notifier/BookAppointmentNotifier.dart';

class BookAppt extends StatefulWidget {
  const BookAppt({Key? key}) : super(key: key);

  @override
  State<BookAppt> createState() => _BookApptState();
}

class _BookApptState extends State<BookAppt> {
  var professionalServicesVisibility = false;
  var credentialsVisibility = false;
  var availableVisibility = false;
  var academicInformation = false;
  var healthcareOrgInformation = false;
  var isSelectDateEmpty = false;

  var color;

  var isTimeBefore = false, isChecked = false;

  final CacheService _cacheService = CacheService();

  var reasonController = TextEditingController();
  var dateCtl = TextEditingController();

  var doctorName = '',
      doctorDegree = '',
      doctorState = '',
      consultationCharges,
      professionalServices = '',
      primarySpeciality = '',
      secondarySpeciality = '',
      currentStates = '',
      runsClinicalTrials = '',
      compName = '';

  List<dynamic> items = [];
  List<dynamic> insuranceCompaniesItems = [];
  List<dynamic> academicInformationItems = [];
  List<dynamic> healthcareOrgInformationItems = [];
  List<dynamic> slotsAvailab = [];
  List<dynamic> decryptUserDetailsItems = [];

  var selectedSlotPosition = -5, selectedSlot = false;
  var data;

  var isAvailable,
      availableTimeSlot = '',
      docCalendarGuId,
      consultationCharge,
      slotDuration;

  var role, instituteName, collegeAddress, yearPassing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments;
    fetchDoctorProfile(data);
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: getHorizontalSize(20.00),
                          top: getVerticalSize(56.00),
                          right: getHorizontalSize(26.00)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                                child: SvgPicture.asset(ImageConstant.imgBack2,
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text("Book an appointment",
                                style: TextStyle(
                                    color: ColorConstant.indigo800,
                                    fontSize: 18,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )),
                  Card(
                    // clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    margin: const EdgeInsets.only(
                        left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                    color: ColorConstant.whiteA700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(getHorizontalSize(
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
                                        SizedBox(
                                            height: getSize(41.00),
                                            width: getSize(41.00),
                                            child: SvgPicture.asset(
                                                ImageConstant.imgUseravatar,
                                                fit: BoxFit.cover)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(16.00),
                                            ),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right:
                                                              getHorizontalSize(
                                                                  10.00)),
                                                      child: Text(
                                                          doctorName ?? '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .textstylelatomedium14
                                                              .copyWith(
                                                                  fontSize:
                                                                      getFontSize(
                                                                          14)))),
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
                                                            padding:
                                                                EdgeInsets.only(
                                                              top:
                                                                  getVerticalSize(
                                                                      5.00),
                                                              bottom:
                                                                  getVerticalSize(
                                                                      3.00),
                                                            ),
                                                            child: Text(
                                                                doctorDegree ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black))),
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
                                                            child: Text(
                                                                doctorState ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black))),
                                                      ]),
                                                ]))
                                      ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(height: 1, color: Colors.grey),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                            child: SvgPicture.asset(
                                                ImageConstant.imgDollar,
                                                fit: BoxFit.cover)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(5.00),
                                              bottom: getVerticalSize(3.00),
                                              left: getVerticalSize(5.00),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "\$ ${consultationCharges.toString() ?? ""}",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                const Text(
                                                  "Without insurance",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ))
                                      ]),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.only(
                          left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                      color: ColorConstant.whiteA700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getHorizontalSize(
                        10.00,
                      ))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (professionalServicesVisibility) {
                                    professionalServicesVisibility = false;
                                  } else {
                                    professionalServicesVisibility = true;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      "Professional Services",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    SvgPicture.asset(ImageConstant.imgDownArrow,
                                        fit: BoxFit.cover)
                                  ],
                                )),
                            Visibility(
                                visible: professionalServicesVisibility,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Divider(
                                        height: 1, color: Colors.grey),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Primary Speciality",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        primarySpeciality ?? '--',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Secondary Speciality",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        secondarySpeciality ?? '--',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Currently Licensed States",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        currentStates ?? '',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )),
                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.only(
                          left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                      color: ColorConstant.whiteA700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getHorizontalSize(
                        10.00,
                      ))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (credentialsVisibility) {
                                    credentialsVisibility = false;
                                  } else {
                                    credentialsVisibility = true;
                                  }
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      "Credentials",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    SvgPicture.asset(ImageConstant.imgDownArrow,
                                        fit: BoxFit.cover)
                                  ],
                                )),
                            Visibility(
                                visible: credentialsVisibility,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Divider(
                                        height: 1, color: Colors.grey),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Research Publications",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      removeBottom: true,
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: items.length,
                                          itemBuilder: (context, position) {
                                            if (position < items.length) {
                                              final item = items[position];
                                              //  items.clear();
                                              print(item);
                                              return Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      item["aboutResearch"] ??
                                                          '',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              ImageConstant
                                                                  .imgInputUrl,
                                                              fit:
                                                                  BoxFit.cover),
                                                          Expanded(
                                                            child: Container(
                                                              child: Text(
                                                                item["publicationURL"] ??
                                                                    '',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    fontSize:
                                                                        14,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Clinical Trails",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        runsClinicalTrials,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Insurance Companies",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      removeBottom: true,
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              insuranceCompaniesItems.length,
                                          itemBuilder: (context, position) {
                                            if (position <
                                                insuranceCompaniesItems
                                                    .length) {
                                              final item =
                                                  insuranceCompaniesItems[
                                                      position];
                                              // insuranceCompaniesItems.clear();
                                              print(item);
                                              return Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      item["companyName"] ?? '',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Visibility(
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Academic Affiliations",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            removeBottom: true,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    academicInformationItems
                                                        .length,
                                                itemBuilder:
                                                    (context, position) {
                                                  if (position <
                                                      academicInformationItems
                                                          .length) {
                                                    final item =
                                                        academicInformationItems[
                                                            position];
                                                    // insuranceCompaniesItems.clear();
                                                    print(item);
                                                    return Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item["role"],
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          "instituteName"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Text(
                                                                      item["startDateMonth"] +
                                                                          "/" +
                                                                          item[
                                                                              "startDateMonth"] +
                                                                          " - " +
                                                                          item[
                                                                              "endDateMonth"] +
                                                                          "/" +
                                                                          item[
                                                                              "endDateYear"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Text(
                                                                      'role',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ))),
                                                      ],
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                      visible: academicInformation,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Visibility(
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Membership of state or National committee",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            removeBottom: true,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    healthcareOrgInformationItems
                                                        .length,
                                                itemBuilder: (context, position) {
                                                  if (position <
                                                      healthcareOrgInformationItems
                                                          .length) {
                                                    final item =
                                                        healthcareOrgInformationItems[
                                                            position];
                                                    // insuranceCompaniesItems.clear();
                                                    print(item);
                                                    return Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item["role"],
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      item[
                                                                          "memberOf"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Text(
                                                                      item["startDateMonth"] +
                                                                          "/" +
                                                                          item[
                                                                              "startDateMonth"] +
                                                                          " - " +
                                                                          item[
                                                                              "endDateMonth"] +
                                                                          "/" +
                                                                          item[
                                                                              "endDateYear"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Text(
                                                                      'role',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ))),
                                                      ],
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                      visible: academicInformation,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      )),
                  const Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 10.0, bottom: 3.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Reason*",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, bottom: 3.0, right: 20.0),
                      child: TextFormField(
                          controller: reasonController,
                          decoration: InputDecoration(
                              hintText: "Reason for appointment",
                              hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                  fontSize: getFontSize(14.0),
                                  color: ColorConstant.bluegray600),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3.85)),
                                  borderSide: BorderSide(
                                      color: ColorConstant.indigo80026,
                                      width: 0.77)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3.85)),
                                  borderSide: BorderSide(
                                      color: ColorConstant.indigo80026,
                                      width: 0.77)),
                              suffixIconConstraints: BoxConstraints(
                                  minWidth: getSize(18.00),
                                  minHeight: getSize(18.00)),
                              filled: true,
                              fillColor: ColorConstant.whiteA700,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))),
                          style: TextStyle(color: ColorConstant.bluegray900, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500))),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, bottom: 3.0, right: 20.0),
                      child: TextFormField(
                          controller: dateCtl,
                          // onChanged: valiDate(),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 0)),
                              lastDate: DateTime(3022),
                            ).then((selectedDate) {
                              setState(() {
                                if (selectedDate != null) {
                                  isSelectDateEmpty = true;
                                  dateCtl.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                                  // print("date ${SimpleDateFormatConverter.isDateAfter(dateCtl.text)}");
                                  fetchAvailableSlots();
                                }
                              });
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select Date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Select Date",
                              hintStyle: AppStyle.textstylelatoregular14
                                  .copyWith(
                                      fontSize: getFontSize(14.0),
                                      color: ColorConstant.bluegray600),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3.85)),
                                  borderSide: BorderSide(
                                      color: ColorConstant.indigo80026,
                                      width: 0.77)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(3.85)),
                                  borderSide: BorderSide(
                                      color: ColorConstant.indigo80026,
                                      width: 0.77)),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(10.00),
                                      right: getHorizontalSize(18.00)),
                                  child: Container(
                                      height: getSize(18.00),
                                      width: getSize(18.00),
                                      child:
                                          SvgPicture.asset(ImageConstant.imgFrame853, fit: BoxFit.contain))),
                              suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                              filled: true,
                              fillColor: ColorConstant.gray50,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                          style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))),
                  Visibility(
                    child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.only(
                            left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                        color: ColorConstant.whiteA700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(getHorizontalSize(10.00,))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (availableVisibility) {
                                      availableVisibility = false;
                                    } else {
                                      availableVisibility = true;
                                    }
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "Available Slots",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                      SvgPicture.asset(
                                          ImageConstant.imgDownArrow,
                                          fit: BoxFit.cover)
                                    ],
                                  )),
                              Visibility(
                                  visible: availableVisibility,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      const Divider(
                                          height: 1, color: Colors.grey),
                                      GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                          ),
                                          itemCount: slotsAvailab.length,
                                          itemBuilder: (context, position) {
                                            if (position <
                                                slotsAvailab.length) {
                                              final item =
                                              slotsAvailab[position];
                                              print(SimpleDateFormatConverter
                                                  .isDateAfter(dateCtl.text));
                                              if ((!SimpleDateFormatConverter.isTimeAfter(item["availableTimeSlot"]) && !SimpleDateFormatConverter.isDateAfter(dateCtl.text)) || !item["isAvailable"]) {
                                                isTimeBefore = false;
                                                color = ColorConstant.gray302;
                                              } else {
                                                if (isChecked && selectedSlotPosition == position) {
                                                  color = ColorConstant.lightGreen;
                                                  isTimeBefore = false;
                                                } else {
                                                  isTimeBefore = true;
                                                }
                                              }
                                              return Card(
                                                  elevation: 5,
                                                  shadowColor:
                                                      ColorConstant.whiteA700,
                                                  color: isTimeBefore
                                                      ? ColorConstant.whiteA700
                                                      : color,
                                                  margin:
                                                      const EdgeInsets.all(5.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                    10.00,
                                                  ))),
                                                  child: GestureDetector(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          item[
                                                              "availableTimeSlot"],
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      selectedSlotPosition = position;

                                                      if ((!SimpleDateFormatConverter
                                                                  .isTimeAfter(item[
                                                                      "availableTimeSlot"]) &&
                                                              !SimpleDateFormatConverter
                                                                  .isDateAfter(
                                                                      dateCtl
                                                                          .text)) ||
                                                          !item[
                                                              "isAvailable"]) {
                                                        consultationCharge = 0;
                                                        availableTimeSlot = '';
                                                      } else {
                                                        isAvailable =
                                                            item["isAvailable"];

                                                        availableTimeSlot = item[
                                                            "availableTimeSlot"];

                                                        docCalendarGuId = item[
                                                            "docCalendarGuId"];

                                                        consultationCharge = item[
                                                            "consultationCharges"];

                                                        slotDuration = item[
                                                            "slotDuration"];
                                                      }

                                                      if (availableTimeSlot ==
                                                          item[
                                                              "availableTimeSlot"]) {
                                                        isChecked = true;
                                                      } else {
                                                        isChecked = false;
                                                      }

                                                      setState(() {});

                                                      print(
                                                          'position $position');
                                                    },
                                                  ));
                                            } else {
                                              return Container();
                                            }
                                          })
                                    ],
                                  ))
                            ],
                          ),
                        )),
                    visible: isSelectDateEmpty,
                  ),
                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.only(
                          left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                      color: ColorConstant.gray302,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getHorizontalSize(
                        10.00,
                      ))),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${consultationCharge ?? 0}\$ Amount",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "for this consultation slot",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                    ImageConstant.imgSlotPrice,
                                    fit: BoxFit.cover),
                              )
                            ],
                          ))),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      height: 55,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (data[1]) {
                            rescheduleAppointmentsStep1();
                          } else {
                            bookAppointmentsStep1();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: ColorConstant.indigo800,
                            shape: const StadiumBorder(),
                            elevation: 7,
                            onPrimary: ColorConstant.indigo800),
                        child: const Text(
                          "Book Appointment",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ],
              ),
            )));
  }

  Future fetchDoctorProfile(data) async {
    var profileData =
        Provider.of<BookAppointmentNotifier>(context, listen: false);
    var doctorDetails = await profileData.getDoctorProfile(
        context: context, doctorGuid: data[0]);

    doctorName = doctorDetails['doctorProfile']["firstName"] +
        "" +
        doctorDetails['doctorProfile']["lastName"];
    doctorDegree = doctorDetails['doctorProfile']["degreeNames"];
    doctorState = doctorDetails['doctorProfile']["addressDTO"]['city'] +
        " " +
        doctorDetails['doctorProfile']["addressDTO"]['state'];
    consultationCharges = doctorDetails['doctorProfile']["consultationCharges"];
    professionalServices =
        doctorDetails['professionalServices']["primarySpeciality"];

    var buffer = StringBuffer();
    int i = 0;
    for (var states in doctorDetails['professionalServices']
        ["licensedStates"]) {
      i++;

      var state = states;
      buffer.write(states);
      buffer.write(', ');
    }

    var creds = doctorDetails['credentials']["runsClinicalTrials"] ?? '';

    if (creds == false) {
      runsClinicalTrials = 'No';
    } else {
      runsClinicalTrials = 'Yes';
    }

    if (doctorDetails['professionalServices']["primarySpeciality"] != null) {
      primarySpeciality =
          doctorDetails['professionalServices']["primarySpeciality"];
    }

    currentStates = buffer.toString();

    if (doctorDetails['professionalServices']["secondarySpeciality"] != null) {
      secondarySpeciality =
          doctorDetails['professionalServices']["secondarySpeciality"];
    }

    try {
      items.addAll(
          doctorDetails['credentials']["researchWorkDTOS"].map<dynamic>((item) {
        return {
          "aboutResearch": item["aboutResearch"] ?? "",
          "publicationURL": item["publicationURL"] ?? ""
        };
      }));

      insuranceCompaniesItems
          .addAll(doctorDetails['insuranceCompanies'].map<dynamic>((item) {
        return {
          "companyName": item["companyName"] ?? "",
        };
      }));

      academicInformationItems
          .addAll(doctorDetails['academicInformation'].map<dynamic>((item) {
        return {
          "role": item["role"] ?? "",
          "instituteName": item["instituteName"] ?? "",
          "startDateMonth": item["startDateMonth"] ?? "",
          "startDateYear": item["startDateYear"] ?? "",
          "endDateMonth": item["endDateMonth"] ?? "",
          "endDateYear": item["endDateYear"] ?? "",
          "collegeAddress": item["collegeAddress"] ?? "",
        };
      }));

      if (academicInformationItems.isNotEmpty) {
        academicInformation = true;
      } else {
        academicInformation = false;
      }

      healthcareOrgInformationItems.addAll(
          doctorDetails['healthcareOrgInformation'].map<dynamic>((item) {
        return {
          "role": item["role"] ?? "",
          "memberOf": item["memberOf"] ?? "",
          "startDateMonth": item["startDateMonth"] ?? "",
          "startDateYear": item["startDateYear"] ?? "",
          "endDateMonth": item["endDateMonth"] ?? "",
          "endDateYear": item["endDateYear"] ?? "",
        };
      }));
    } catch (e) {
      print(e);
    }

    if (healthcareOrgInformationItems.isNotEmpty) {
      healthcareOrgInformation = true;
    } else {
      healthcareOrgInformation = false;
    }
    setState(() {});
  }

  Future fetchAvailableSlots() async {
    var slots = Provider.of<BookAppointmentNotifier>(context, listen: false);
    var slotsAvailable = await slots.getAvailableSlots(
        context: context, doctorGuid: data[0], date: dateCtl.text);

    if (slotsAvailab.isNotEmpty) {
      slotsAvailab.clear();
    }
    slotsAvailab.addAll(slotsAvailable.map<dynamic>((item) {
      return {
        "isAvailable": item["isAvailable"] ?? "",
        "availableTimeSlot": item["availableTimeSlot"] ?? "",
        "docCalendarGuId": item["docCalendarGuId"] ?? "",
        "consultationCharges": item["consultationCharges"] ?? "",
        "slotDuration": item["slotDuration"] ?? "",
      };
    }));
  }

  Future bookAppointmentsStep1() async {
    if (reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please fill the reason', style: TextStyle(fontSize: 12))));
      return;
    }

    if (dateCtl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please select slot date', style: TextStyle(fontSize: 12))));
      return;
    }

    if (availableTimeSlot.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please choose a slot', style: TextStyle(fontSize: 12))));
      return;
    }

    var appints = Provider.of<BookAppointmentNotifier>(context, listen: false);

    var ud = await _cacheService.readCache(key: "userDetails");

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);

      final jsonData = jsonEncode({
        "appointmentDate": dateCtl.text,
        "appointmentTime": availableTimeSlot,
        "doctorGuId": data[0],
        "patientGuId": user.docPatGuId,
        "doctorCalendarGuId": docCalendarGuId,
        "appointmentTimeSlot": slotDuration,
      });

      var appointData =
          await appints.bookAppointment(docData: jsonData, context: context);

      bookAppointmentsReason(appointData['patientAppointmentGuId']);
    }
  }

  Future rescheduleAppointmentsStep1() async {
    if (reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please fill the reason', style: TextStyle(fontSize: 12))));
      return;
    }

    if (dateCtl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please select slot date', style: TextStyle(fontSize: 12))));
      return;
    }

    if (availableTimeSlot.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text('Please choose a slot', style: TextStyle(fontSize: 12))));
      return;
    }

    var appints = Provider.of<BookAppointmentNotifier>(context, listen: false);

    var ud = await _cacheService.readCache(key: "userDetails");

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);

      final jsonData = jsonEncode({
        "patientAppointmentGuId": data[2],
        "appointmentDate": dateCtl.text,
        "appointmentTime": availableTimeSlot,
        "doctorGuId": data[0],
        "patientGuId": user.docPatGuId,
        "doctorCalendarGuId": docCalendarGuId,
        "appointmentTimeSlot": slotDuration,
        "newAppointmentConsultationCharges": consultationCharges,
      });

      var appointData = await appints.rescheduleAppointment(
          docData: jsonData, context: context);

      bookAppointmentsReason(appointData['patientAppointmentGuId']);
    }
  }

  Future bookAppointmentsReason(String patientAppointmentGuId) async {
    var appints = Provider.of<BookAppointmentNotifier>(context, listen: false);

    var ud = await _cacheService.readCache(key: "userDetails");

    var token = await _cacheService.readCache(key: 'jwtdata');

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);

      final jsonData = jsonEncode({
        "appointmentReason": reasonController.text,
        "doctorGuId": data[0],
        "patientGuId": user.docPatGuId,
        "patientAppointmentGuId": patientAppointmentGuId,
      });

      var appointData = await appints.bookAppointmentReason(
          docData: jsonData, context: context);

      if (consultationCharges <= 0) {
        bookAppointmentsPayment(appointData['patientAppointmentGuId']);
      } else {
        print('payPalBrowserLink $token');
        print('consultationCharges $consultationCharges');
        print('doctorName $doctorName');
        print('availableTimeSlot $availableTimeSlot');
        print('appointmentDate ${dateCtl.text}');
        print('appointmentGuId $patientAppointmentGuId');

        var payPalBrowserLink = Baseurl +
            "/mobile-paypal?authToken=" +
            token! +
            "&consultationCharges=" +
            consultationCharges.toString() +
            "&doctorName=" +
            doctorName.trim() +
            "&appointmentTime=" +
            availableTimeSlot.toString().trim().replaceAll(' ', '') +
            "&appointmentDate=" +
            dateCtl.text +
            "&appointmentGuId=" +
            patientAppointmentGuId +
            "&isReschedule=" +
            data[1].toString();

        print('payPalBrowserLink $payPalBrowserLink');

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaypalBrowser(
            passedUrl: payPalBrowserLink,
            appointmentGuId: patientAppointmentGuId,
          );
        }));
      }
    }
  }

  Future bookAppointmentsPayment(String patientAppointmentGuId) async {
    var appints = Provider.of<BookAppointmentNotifier>(context, listen: false);

    var ud = await _cacheService.readCache(key: "userDetails");

    if (ud != null) {
      Map<String, dynamic> jsondatais = jsonDecode(ud!);

      var user = UserDetailsModel.fromJson(jsondatais);

      final jsonData = jsonEncode({
        "appointmentReason": reasonController.text,
        "doctorGuId": data[0],
        "patientGuId": user.docPatGuId,
        "patientAppointmentGuId": patientAppointmentGuId,
      });

      var appointData = await appints.bookAppointmentPayment(
          patientAppointmentGuId: patientAppointmentGuId,
          docData: jsonData,
          context: context,
          isReschedule: 'false');
    }
  }
}
