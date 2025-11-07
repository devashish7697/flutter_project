import 'package:flutter/material.dart';
import 'package:flutter_project/config/theme/app_theme.dart';
import 'package:flutter_project/data/services/service_locator.dart';
import 'package:flutter_project/presentation/screens/auth/LoginScreen.dart';
import 'package:flutter_project/router/app_router.dart';


void main() async {

  await setupServiceLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: LoginScreen(),
      navigatorKey: getIt<AppRouter>().navigatorKey,
    );
  }
}


