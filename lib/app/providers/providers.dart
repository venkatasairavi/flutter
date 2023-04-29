import 'package:moibleapi/meta/views/dashboardallappointmentsview/appointments_notifier/appoinments_notifier.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/notifier/doctornotifier.dart';
import 'package:moibleapi/meta/views/doctor_profile_change_password_view/changepasswordnotifier/changepasswordnotifier.dart';
import 'package:moibleapi/meta/views/messageview/messagenotifier/message_notifier.dart';
import 'package:moibleapi/meta/views/notificationview/notificationnotifier/notifier.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/history/notifier/HistoryNotifier.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/home/notifier/PatientHomeNotifier.dart';
import 'package:moibleapi/meta/views/setPassword/notifier/PasswordNotifier.dart';
import 'package:moibleapi/meta/views/user_registration_otp_view/notifier/OTPNotifier.dart';
import 'package:moibleapi/meta/views/login/notifier/LoginNotifier.dart';
import 'package:moibleapi/meta/views/userregistrationview/notifier/RegistrationNotifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../meta/views/patientDashboardScreens/dashboard/notifier/DashboardHomeNotifier.dart';
import '../../meta/views/patientDashboardScreens/home/notifier/BookAppointmentNotifier.dart';
import '../../meta/views/patientDashboardScreens/messages/notifier/MessagesNotifier.dart';

List<SingleChildWidget> providers = [...remoteProviders];

List<SingleChildWidget> remoteProviders = [
  //!Login
  ChangeNotifierProvider(create: (_) => LoginNotifier()),
  // Signup
  ChangeNotifierProvider(create: (_) => RegistrationNotifier()),
  //! Decode user data
  ChangeNotifierProvider(create: (_) => DoctorNotifier()),
  //! Otp data
  ChangeNotifierProvider(create: (_) => OTPNotifier()),
  //! Set Password data
  ChangeNotifierProvider(create: (_) => PasswordNotifier()),
  //! Notification data
  ChangeNotifierProvider(create: (_) => NotificationNotifier()),
  //! changepassword data
  ChangeNotifierProvider(create: (_) => ChangePasswordNotifier()),
  //! Appointmnets data
  ChangeNotifierProvider(create: (_) => AppointmentNotifier()),
  //!Doctor Message Notifier
  ChangeNotifierProvider(create: (_) => DocMessagesNotifier()),
  //!Dashboard Notifier
  ChangeNotifierProvider(create: (_) => DashboardNotifier()),
  //!PatientHome Notifier
  ChangeNotifierProvider(create: (_) => PatientHomeNotifier()),
  //!PatientHome Notifier
  ChangeNotifierProvider(create: (_) => BookAppointmentNotifier()),
  //!PatientHome Notifier
  ChangeNotifierProvider(create: (_) => MessagesNotifier()),
  //!Patient History Notifier
  ChangeNotifierProvider(create: (_) => HistoryNotifier()),

];
