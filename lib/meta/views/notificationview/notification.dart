// ignore_for_file: unnecessary_const

import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/meta/views/notificationview/notificationnotifier/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final controller = ScrollController();
  List<dynamic> items = [];
  bool hasMore = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetch();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        fetch();
        
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int page = 0;
  int pgsize = 10;
  

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {
      hasMore = true;
    });

    var notifAllNotifier =
        Provider.of<NotificationNotifier>(context, listen: false);
    var newItems = await notifAllNotifier.getNotifications(
        pgNum: page, pgSize: pgsize, context: context);

    setState(() {
      page++;

      if (newItems["count"] < pgsize) {
        hasMore = false;
      }

      items.addAll(newItems["list"].map<dynamic>((item) {
        return {
          "message": item["message"],
          "appointmentTime":
              item["appointmentTime"] == null ? "" : item["appointmentTime"]
        };
      }));
    });
    isLoading = false;

    if (items.length <= newItems["count"]) {
      hasMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.start,
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
                                        Container(
                                            height: getVerticalSize(38.00),
                                            width: getHorizontalSize(35.00),
                                            child: SvgPicture.asset(
                                                ImageConstant.imgVector6,
                                                fit: BoxFit.fill)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: getVerticalSize(7.00),
                                                bottom: getVerticalSize(7.00)),
                                            child: Text("Notifications",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .textstylelatomedium181
                                                    .copyWith(
                                                        fontSize:
                                                            getFontSize(18),
                                                        height: 1.33)))
                                      ])))),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          // height:  MediaQuery.of(context).size.height,
                          // decoration:BoxDecoration(color: ColorConstant.black900),
                          child:
                              // RefreshIndicator(
                              //   onRefresh: refresh,
                              // child:
                              ListView.builder(
                            controller: controller,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length + 1,
                            itemBuilder: (context, index) {
                              if (index < items.length) {
                                final item = items[index];
                                //print(item);
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(10.00),
                                    top: getVerticalSize(10.00),
                                    right: getHorizontalSize(10.00),
                                    //bottom: getVerticalSize(491.00)
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(
                                        10,
                                      ),
                                      bottom: getVerticalSize(
                                        3.50,
                                      ),
                                    ),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            height: getSize(
                                              50.00,
                                            ),
                                            width: getSize(
                                              50.00,
                                            ),
                                            margin: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                5.00,
                                              ),
                                              top: getVerticalSize(
                                                10.00,
                                              ),
                                              bottom: getVerticalSize(
                                                5.00,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.blue50,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(
                                                  25.00,
                                                ),
                                              ),
                                              border: Border.all(
                                                color: ColorConstant.gray300,
                                                width: getHorizontalSize(
                                                  1.00,
                                                ),
                                              ),
                                            ),
                                            child: Card(
                                              // clipBehavior: Clip.antiAlias,
                                              elevation: 0,
                                              margin: const EdgeInsets.all(0),
                                              color: ColorConstant.blue50,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    25.00,
                                                  ),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          14.00,
                                                        ),
                                                        top: getVerticalSize(
                                                          14.00,
                                                        ),
                                                        right:
                                                            getHorizontalSize(
                                                          14.00,
                                                        ),
                                                        bottom: getVerticalSize(
                                                          14.72,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        height: getVerticalSize(
                                                          25.0,
                                                        ),
                                                        width:
                                                            getHorizontalSize(
                                                          25.00,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          ImageConstant
                                                              .imgCalendaricon,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                5.00,
                                              ),
                                              top: getVerticalSize(
                                                10.00,
                                              ),
                                              bottom: getVerticalSize(
                                                10.00,
                                              ),
                                            ),
                                            child: Text(
                                              item["message"],
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.bluegray900,
                                                fontSize: getFontSize(
                                                  14,
                                                ),
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w500,
                                                height: 1.50,
                                              ),
                                            ),
                                          ),
                                          flex: 7,
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(
                                                10.00,
                                              ),
                                              right: getHorizontalSize(
                                                5.00,
                                              ),
                                              bottom: getVerticalSize(
                                                0.00,
                                              ),
                                            ),
                                            child: Text(
                                              item["appointmentTime"],
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.bluegray900,
                                                fontSize: getFontSize(
                                                  14,
                                                ),
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w500,
                                                height: 1.50,
                                              ),
                                            ),
                                          ),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                      child: hasMore
                                          ? const CircularProgressIndicator()
                                          : const Text("")),
                                );
                              }
                            },
                          ),
                          // ),
                        ),
                      )
                    ]))));
  }
}
