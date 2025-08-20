import 'package:flutter/material.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/providers/app-language-provider.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        //AppRoutes.registerRouteName: (context) =>RegisterScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//     );
//   }
// }
