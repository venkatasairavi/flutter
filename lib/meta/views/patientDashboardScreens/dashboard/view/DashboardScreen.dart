
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/messages/view/MessagesScreen.dart';
import 'package:provider/provider.dart';
import '../../../../../app/shared/utils/color_constant.dart';
import '../../../../../app/shared/utils/image_constant.dart';
import '../../../../../app/shared/utils/math_utils.dart';
import '../../../../../utils/Utils/Utils.dart';
import '../../../doctorprofileoptionsview/doctor_profile_options_screen.dart';
import '../../../notificationview/notification.dart';
import '../../../notificationview/notificationnotifier/notifier.dart';
import '../../history/view/HistoryScreen.dart';
import '../../home/view/PatientHomeScreen.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/notifier/doctornotifier.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  var _selectedIndex = 0;
  var _notifCount = 0;

  final items = [
    const PatientHomeScreen(),
    const MessagesScreen(),
    const HistoryScreen(),
    const NotificationsScreen(),
    const DoctorProfileOptionsScreen()
  ];

  var home = true, msg = false, hist = false, notify = false, prof = false;
  late final timeZone;

  @override
  void initState() {
    super.initState();
    tz();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                              ImageConstant.filehistory,
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
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(
                                      _notifCount.toString(),
                                      style: TextStyle(
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
                            child: SvgPicture.asset(
                              ImageConstant.imgUseravatarp,
                            )),
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
    );
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
    var notifAllNotifier =
        Provider.of<NotificationNotifier>(context, listen: false);
    var newItems = await notifAllNotifier.getNotifications(
        pgNum: 0, pgSize: 1, context: context);
    setState(() {
      _notifCount = newItems["count"];
    });

    var patientNotifier = Provider.of<DoctorNotifier>(context, listen: false);
    patientNotifier.getDoctor(context: context);
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
    await fetch();
  }
}
