
import 'package:moibleapi/meta/views/dashboardallappointmentsview/dashboard_all_appointment_screen.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/dashboard_home_screen.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/upcomingappoinmentsscreen.dart';
import 'package:moibleapi/meta/views/dashboardview/dashboardscreen.dart';
import 'package:moibleapi/meta/views/doctor_profile_change_password_view/doctor_profile_change_password.dart';
import 'package:moibleapi/meta/views/doctorprofileoptionsview/doctor_profile_options_screen.dart';
import 'package:moibleapi/meta/views/login/view/UserLoginMainScreen.dart';
import 'package:moibleapi/meta/views/messageview/chatmessagescreen.dart';
import 'package:moibleapi/meta/views/messageview/message_screen.dart';
import 'package:moibleapi/meta/views/notificationview/notification.dart';

import 'package:moibleapi/meta/views/setPassword/view/UserRegistrationProfilePasswordScreen.dart';

import 'package:moibleapi/meta/views/splashview/splashscreen.dart';
import 'package:moibleapi/meta/views/user_options_view/useroptionscreen.dart';
import 'package:moibleapi/meta/views/user_profile_view/user_profile_screen.dart';
import 'package:moibleapi/meta/views/user_registration_otp_view/view/user_registration_otp_screen.dart';
import 'package:moibleapi/meta/views/userregistrationview/view/user_patient_registration_step_2_screen.dart';
import 'package:moibleapi/meta/views/userregistrationview/view/user_registration_step_1_screen.dart';
import 'package:moibleapi/meta/views/userregistrationview/view/user_registration_step_2_screen.dart';

import '../../meta/views/messageview/messageVM/DoctorChattingScreen.dart';
import '../../meta/views/patientDashboardScreens/dashboard/view/DashboardScreen.dart';
import '../../meta/views/patientDashboardScreens/dashboard/view/PaypalBrowser.dart';
import '../../meta/views/patientDashboardScreens/home/view/AppointmentCancelled.dart';
import '../../meta/views/patientDashboardScreens/home/view/AppointmentSuccessfully.dart';
import '../../meta/views/patientDashboardScreens/home/view/BookAppointment.dart';
import '../../meta/views/patientDashboardScreens/home/view/BookAppt.dart';
import '../../meta/views/patientDashboardScreens/messages/view/ChattingScreen.dart';

const String SplashScreen = "/splashscreen";
const String LoginRoute = "/login";
const String HomeRoute = "/homeview";
const String UserOption = "/optionsview";
const String UserRegistrationscreenone = "/registrationscreenone";
const String UserRestrationscreentwo = "/registraionscreentwo";
const String UserPatientRestrationscreentwo = "/patientregistraionscreentwo";
const String UserOtpRoute = "/userotp";
const String DashboardHomeRoute = "/dashboardhomeview";
const String MessageRoute = "/messageview";
const String NotificationRoute = "/notificationview";
const String DashboardAllAppointmentsRoute = "dabhoardappointmentsview";
const String DoctorProfileRoute = "/doctorprofileview";
const String Doctorprofilepassword = "/doctorprofilepassword";
const String UserProfilechangePasswordRoute = "/userprofilechangepwdview";
const String UserProfileRoute = "/userprofile";
const String PatientDashboardScreen = "/patientDashboard";
const String bookAppointment = "/bookAppointment";
const String appointmentCancelled = "/AppointmentCancelled";
const String paypalBrowser = "/paypalBrowser";
const String appointmentSuccessfully = "/appointmentSuccess";
const String upcomingappointmentsRoute = "/upcomingappointments";
const String chattingScreen = "/chattingScreen";
const String doctorchattingScreen = "/DoctorchattingScreen";
const String sessiontimeout = "/sessiontimeout";
const String chatmessageRoute = "/doctorchatmessage";

final routes = {
  SplashScreen: (context) => const AppLoadupScreen(),
  LoginRoute: (context) => const UserLoginMainScreen(),
  HomeRoute: (context) => const Dashboard(),
  UserOption: (context) => const UserLoginOptionsScreen(),
  UserRegistrationscreenone: (context) => const UserRegistrationStep1Screen(),
  UserRestrationscreentwo: (context) => const UserRegistrationStep2Screen(),
  UserOtpRoute: (context) => UserRegistrationEmailMobileOtpVerificationScreen(),
  DashboardHomeRoute: (context) => const DashboardFirstTimeOne(),
  MessageRoute: (context) => const MessagesScreen(),
  NotificationRoute: (context) => const NotificationsScreen(),
  DashboardAllAppointmentsRoute: (context) => const DashboarAllAppointmentsScreen(),
  DoctorProfileRoute: (context) => const DoctorProfileOptionsScreen(),
  Doctorprofilepassword: (context) => const UserRegistrationProfilePasswordScreen(),
  UserProfilechangePasswordRoute: (context) => DoctorProfileChangePasswordScreen(),
  UserPatientRestrationscreentwo: (context) =>const UserPatientRegistrationStep2Screen(),
  UserProfileRoute: (context) => const UserProfileScreen(),
  PatientDashboardScreen: (context) => const DashboardScreen(),
  bookAppointment: (context) =>  const BookAppt(),
  appointmentCancelled: (context) =>  const AppointmentCancelled(),
  appointmentSuccessfully: (context) =>  const AppointmentSuccessfully(),
  paypalBrowser: (context) =>  const PaypalBrowser(passedUrl: '', appointmentGuId: '',),
  upcomingappointmentsRoute: (context) =>   UpcomingAppointmentsscreen(),
  chattingScreen: (context) =>  const ChattingScreen(),
  chatmessageRoute: (context) => const ChatMessagingScreen(),
  
  doctorchattingScreen:(context)=> const DoctorchattingScreen(),
};
