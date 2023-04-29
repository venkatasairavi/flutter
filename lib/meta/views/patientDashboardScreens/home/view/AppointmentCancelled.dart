
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../app/routes/app.routes.dart';
import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../app/theme/app_style.dart';

/*void main() {
  runApp(
    const MaterialApp(
      home: AppointmentCancelled(),
    ),
  );
}*/

class AppointmentCancelled extends StatefulWidget {
  const AppointmentCancelled({Key? key}) : super(key: key);

  @override
  State<AppointmentCancelled> createState() => _AppointmentCancelledState();
}

class _AppointmentCancelledState extends State<AppointmentCancelled> {

  var data;

  @override
  void didChangeDependencies(){
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
                              left: getHorizontalSize(14.00,),
                              top: getVerticalSize(15.00,),
                              right: getHorizontalSize(14.00,),
                              bottom: getVerticalSize(14.72,),),
                            child: Column(
                              children: [
                              IntrinsicHeight(
                                child:   Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  // or exapnded
                                  // fit: FlexFit.tight,
                                  flex: 2,
                                  child: SizedBox(
                                      height: getSize(50.00),
                                      width: getSize(50.00),
                                      child: SvgPicture.asset(ImageConstant.imgUseravatar, fit: BoxFit.contain)),
                                ),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 3.0,),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data[0] ?? '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                             data[1] ??
                                                '',
                                            textAlign:
                                            TextAlign
                                                .left,
                                            style: const TextStyle(
                                                color: Colors
                                                    .black))

                                      ],
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 3,
                                    child:  Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Cancelled' ?? '',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.red),
                                        )
                                    )
                                  )

                              ],
                                )
                              ),

                                const SizedBox(height: 10,),
                                const Divider(height: 1, color: Colors.grey),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text(
                                          data[2] ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black),
                                      ),
                                      Text(
                                          data[3] ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
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
                    child: Card(
                      margin: const EdgeInsets.only(
                          left: 18.0, top: 10.0, bottom: 15.0, right: 18.0),
                      color: ColorConstant.whiteA700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getHorizontalSize(
                            25.00,
                          ))),
                      elevation: 10,
                      child: Row(
                   children: [

                     Padding(
                         padding: const EdgeInsets.all(15.00),
                         child: Container(
                             height: getVerticalSize(18.00),
                             width: getHorizontalSize(18.00),
                             child: SvgPicture.asset(
                                 ImageConstant.imgCalendaricon,
                                 fit: BoxFit.fill))),
                            Text(
                              'Appointment cancelled successfully',
                              style: TextStyle(color: ColorConstant.black900, fontWeight: FontWeight.bold),
                            )
                          ],
                      ),
                    )

                  ),
                ),
              ])),
    );
  }
}