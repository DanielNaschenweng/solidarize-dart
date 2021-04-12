import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(IntesangoApp());
}

class IntesangoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Const.titleApp,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('pt', ''), // Portuguese
        const Locale('pt', 'BR'), // Brazilian Portuguese
      ],
      localeResolutionCallback: (
          Locale locale,
          Iterable<Locale> supportedLocales,
          ) {
          return locale;
        },
      locale: Locale('pt', 'BR'), // Brazilian Portuguese7
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => MyHomePage(),
      }
    );
  }
}
