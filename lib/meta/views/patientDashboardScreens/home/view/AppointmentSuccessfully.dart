
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../app/theme/app_style.dart';
import '../notifier/BookAppointmentNotifier.dart';

class AppointmentSuccessfully extends StatefulWidget {
  const AppointmentSuccessfully({Key? key}) : super(key: key);

  @override
  State<AppointmentSuccessfully> createState() => _AppointmentSuccessfullyState();
}

class _AppointmentSuccessfullyState extends State<AppointmentSuccessfully> {

  var firstName, degreeName, appointmentDate, appointmentTime, reasonForAppointment;

  var data;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments;
    bookAppointmentsPayment(data[0]);
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
                          Navigator.of(context).pushNamed(PatientDashboardScreen);
                        },
                        child: SizedBox(
                            child: SvgPicture.asset(ImageConstant
                                .imgBack2,
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0),
                        child: Text("Appointment Booked",
                            style: TextStyle(
                                color: ColorConstant.indigo800,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  )),
              Card(
                // clipBehavior: Clip.antiAlias,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                margin: const EdgeInsets.only(
                    left: 18.0, top: 10.0, bottom: 10.0, right: 18.0),
                color: ColorConstant.whiteA700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          10.00,
                        ))),
                child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(14.00,),
                      top: getVerticalSize(15.00,),
                      right: getHorizontalSize(14.00,),
                      bottom: getVerticalSize(14.72,),
                    ),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child:
                              SizedBox(
                                  height: getSize(41.00),
                                  width: getSize(41.00),
                                  child: SvgPicture.asset(
                                      ImageConstant.imgSuccess,
                                      fit: BoxFit.fill)),
                                flex: 2,
                              ),
                              Flexible(child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Appointment Booked Successfully!',
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium14.copyWith(fontSize: getFontSize(16), color: ColorConstant.black900)),
                                    const SizedBox(height: 5.0,),
                                    const Text(
                                        'Your payment transaction has been completed successfully',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors
                                                .grey))
                                  ]), flex: 8,)
                            ]),
                      ],
                    )
                ),
              ),
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
                            left: getHorizontalSize(14.00,),
                            top: getVerticalSize(15.00,),
                            right: getHorizontalSize(14.00,),
                            bottom: getVerticalSize(14.72,),),
                          child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                        height: getSize(41.00),
                                        width: getSize(41.00),
                                        child: SvgPicture.asset(
                                            ImageConstant.imgUseravatar,
                                            fit: BoxFit.fill)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              16.00),
                                        ),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      right:
                                                      getHorizontalSize(
                                                          10.00)),
                                                  child: Text(
                                                      firstName ?? '',
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
/*                                              Padding(
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
                                                      degreeName ??
                                                          '',
                                                      textAlign:
                                                      TextAlign
                                                          .left,
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black))),*/
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
                                                  child: Container(
                                                    width: 200,
                                                    child: Text(
                                                        reasonForAppointment ??
                                                            '',  overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign
                                                            .left,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black)),
                                                  )),
                                            ]))
                                  ]),
                              const SizedBox(height: 10,),
                              const Divider(height: 1, color: Colors.grey),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      appointmentTime ?? '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      appointmentDate ?? '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                  ]),
                            ],
                          )),
                    ),
                  ],
                ),
              ),

               Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Your Information is Secured with'),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(5.00)),
                              child: Container(
                                  height: getVerticalSize(18.00),
                                  width: getHorizontalSize(18.00),
                                  child: SvgPicture.asset(
                                      ImageConstant.imgVector6,
                                      fit: BoxFit.fill))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(5.00)),
                              child: Container(
                                  height: getVerticalSize(10.00),
                                  child: SvgPicture.asset(
                                      ImageConstant.imgTelehealth,
                                      fit: BoxFit.fill))),
                        ],

    )
//Your widget here,
                  ),
                ),
              ),


            ],
          ),
      ),
    );
  }

  Future bookAppointmentsPayment(String patientAppointmentGuId) async {

    var appints = Provider.of<BookAppointmentNotifier>(context, listen: false);

    var appointData = await appints.previewAppointment(context: context, patientAppointmentGuId : patientAppointmentGuId);
    print(appointData['firstName']);

    firstName = appointData['firstName'] + " "+ appointData['lastName'];
    degreeName = appointData['degreeName'];
    appointmentDate = appointData['appointmentDate'];
    appointmentTime = appointData['appointmentTime'];
    reasonForAppointment = appointData['reasonForAppointment'];

    setState(() {});
  }

}