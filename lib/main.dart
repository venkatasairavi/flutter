import 'package:flutter/material.dart';
import 'package:moibleapi/app/providers/providers.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Core());
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'telehealth',
      initialRoute:SplashScreen,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
