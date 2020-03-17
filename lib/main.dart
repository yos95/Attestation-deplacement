import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/SplahScreen.dart';
import 'screens/StartScreen.dart';
import 'models/Data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
        ],
        debugShowCheckedModeBanner: false,
        home: Scaffold(resizeToAvoidBottomInset: false, body: SplashScreen()),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          "HomeScreen": (context) => StartScreen(),
          // "Login": (context) => loginScreen(),
        },
      ),
    );
  }
}
