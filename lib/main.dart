
import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/providers/auth.dart';
import 'package:discorev/screens/auth/choice_account_type_screen.dart';
import 'package:discorev/screens/home_screen.dart';
import 'package:discorev/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            theme: ThemeData(
                primaryColor: CustomColors.primaryColorYellow,
                hintColor: Colors.black54,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Theme.of(context).primaryColor,
                  selectionColor:
                  Theme.of(context).primaryColor.withOpacity(0.4),
                  selectionHandleColor: Theme.of(context).primaryColor,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: CustomColors.secondaryColorBlue),
                    ),
                    focusColor: CustomColors.primaryColorBlue),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: CustomColors.secondaryColorBlue,
                      fontSize: 16.0,
                    ),
                      foregroundColor: CustomColors.primaryColorBlue
                  )
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          color: CustomColors.tertiaryColorWhite,
                        ),
                        backgroundColor: CustomColors.primaryColorBlue,
                        foregroundColor: CustomColors.tertiaryColorWhite))),
            home: _isFirstLaunch
                ? SplashScreenWrapper(
              child: ChoiceAccountTypeScreen(),
            )
                : SplashScreenWrapper(
              child: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  final Widget child;

  SplashScreenWrapper({required this.child});

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widgetWidth = screenWidth > 600 ? screenWidth * 0.5 : screenWidth * 1;

    if (_isLoading) {
      return SplashScreen();
    } else {
      return Center(
        child: SizedBox(
          width: widgetWidth,
          child: widget.child,
        ),
      );
    }
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
