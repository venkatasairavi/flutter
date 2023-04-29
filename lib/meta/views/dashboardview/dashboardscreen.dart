import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';

import 'package:moibleapi/meta/views/dashboardallappointmentsview/dashboard_all_appointment_screen.dart';

import 'package:moibleapi/meta/views/dashboardhomeview/dashboard_home_screen.dart';

import 'package:moibleapi/meta/views/doctorprofileoptionsview/doctor_profile_options_screen.dart';
import 'package:moibleapi/meta/views/messageview/message_screen.dart';
import 'package:moibleapi/meta/views/notificationview/notification.dart';
import 'package:moibleapi/meta/views/notificationview/notificationnotifier/notifier.dart';

import 'package:moibleapi/utils/Utils/Utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchcontroller = TextEditingController();

  final items = [
    const DashboardFirstTimeOne(),
    const MessagesScreen(),
    const DashboarAllAppointmentsScreen(),
    const NotificationsScreen(),
    const DoctorProfileOptionsScreen()
  ];

  var home = true, msg = false, hist = false, notify = false, prof = false;
  var newItems;
  late final timeZone;
  var _notifCount = 0;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  //var data = Get.arguments;
  //var docData;
  int _selectedIndex = 0;

  // Future<Map<String, dynamic>> getDoctorDetails() async {
  //   var response = await http.get(
  //       Uri.parse("https://dev.gtcure.com/api/doctors/basic-details"),
  //       headers: {"Authorization": data[1] + " " + data[0]});
  //   var resp = jsonDecode(response.body);
  //   if (resp["success"] == true) {
  //     return jsonDecode(AES().decryptString(resp["data"]));
  //   }
  //   print("bablu");
  //   print(resp);
  //   return {};
  // }

  // _onTap(int index) {
  //   setState(() => _selectedIndex = index);
  //   switch (index) {
  //     case 0:
  //       Navigator.of(context).pushNamed(DashboardHomeRoute);
  //       // Get.to(DashboardFirstTimeOne, arguments: data);
  //       break;
  //     case 1:
  //     Navigator.of(context).pushNamed(MessageRoute);
  //       // Get.to(MessagesScreen, arguments: data);
  //       break;
  //     case 2:
  //     Navigator.of(context).pushNamed(DashboardAllAppointmentsRoute);
  //       //  Get.to(DashboarAllAppointmentsScreen, arguments: data);
  //       break;
  //     case 3:
  //     Navigator.of(context).pushNamed(NotificationRoute);
  //       // Get.to(NotificationsScreen, arguments: data);
  //       break;
  //     case 4:
  //     Navigator.of(context).pushNamed(DoctorProfileRoute);
  //       //  Get.to(DoctorProfileOptionsScreen, arguments: data);
  //       break;
  //     default:
  //       return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //print(data);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: ColorConstant.indigo800,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      _selectedIndex = 0;
                      _updateWidget(true, false, false, false, false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              ImageConstant.imgHome,
                            )),
                        Container(
                          height: getSize(9),
                          width: getSize(9),
                          decoration: BoxDecoration(
                            color: home
                                ? ColorConstant.lightGreen
                                : ColorConstant.indigo800,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      _selectedIndex = 1;
                      _updateWidget(false, true, false, false, false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              ImageConstant.imgMessages,
                            )),
                        Container(
                          height: getSize(9),
                          width: getSize(9),
                          decoration: BoxDecoration(
                            color: msg
                                ? ColorConstant.lightGreen
                                : ColorConstant.indigo800,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      _selectedIndex = 2;
                      _updateWidget(false, false, true, false, false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              ImageConstant.imgVector,
                            )),
                        Container(
                          height: getSize(9),
                          width: getSize(9),
                          decoration: BoxDecoration(
                            color: hist
                                ? ColorConstant.lightGreen
                                : ColorConstant.indigo800,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      _selectedIndex = 3;
                      _updateWidget(false, false, false, true, false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(alignment: Alignment.topRight, // Center of Top
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      _notifCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      top: 5.0,
                                      right: 10.0,
                                      bottom: 5),
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ]),
                        Container(
                          height: getSize(9),
                          width: getSize(9),
                          decoration: BoxDecoration(
                            color: notify
                                ? ColorConstant.lightGreen
                                : ColorConstant.indigo800,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      _selectedIndex = 4;
                      _updateWidget(false, false, false, false, true);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  ImageConstant.imgUseravatar,
                                ))),
                        Container(
                          height: getSize(9),
                          width: getSize(9),
                          decoration: BoxDecoration(
                            color: prof
                                ? ColorConstant.lightGreen
                                : ColorConstant.indigo800,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
      body: items[_selectedIndex],
    ));
  }

  void _updateWidget(
      bool _home, bool _msg, bool _hist, bool _notify, bool _prof) {
    home = _home;
    msg = _msg;
    hist = _hist;
    notify = _notify;
    prof = _prof;
    setState(() {});
  }

  Future<void> fetch() async {
    // String? jwtData;
    // final CacheService _cacheService = CacheService();
    // jwtData = await _cacheService.readCache(key: "jwtdata");
    // bool hasExpired = JwtDecoder.isExpired(jwtData!);
    // if (hasExpired) {
    //   _timeoutpopUP();
    //   return;
    // }

    var notifAllNotifier =
        Provider.of<NotificationNotifier>(context, listen: false);
    // try {
    newItems = await notifAllNotifier.getNotifications(
        pgNum: 0, pgSize: 1, context: context);
    // } on UnauthorisedException {
    //   // _timeoutpopUP();
    //   return;
    // }
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);

    setState(() {
      _notifCount = newItems["count"];
    });
  }
}
