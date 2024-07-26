import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/auth/login.dart';
import 'package:discorev/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Bloquer l'orientation en mode portrait uniquement
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Premier lancement
  final prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('isFirstRun') ?? true;
  if (isFirstRun) {
    await prefs.setBool('isFirstRun', false);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    if (isFirstLaunch == null || isFirstLaunch == true) {
      await prefs.setBool('isFirstLaunch', false);
      setState(() {
        _isFirstLaunch = true;
      });
    } else {
      setState(() {
        _isFirstLaunch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: CustomColors.primaryColorYellow,
          hintColor: Colors.black54,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Theme.of(context).primaryColor,
            selectionColor: Theme.of(context).primaryColor.withOpacity(0.4),
            selectionHandleColor: Theme.of(context).primaryColor,
          ),
          inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.secondaryColorBlue),
              ),
              focusColor: CustomColors.primaryColorBlue),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              color: CustomColors.tertiaryColorWhite,
            ),
            backgroundColor: CustomColors.primaryColorYellow,
                foregroundColor: CustomColors.tertiaryColorWhite
          ))),
      home: _isFirstLaunch ? const Intro() : const LoginPage(),
    );
  }
}
