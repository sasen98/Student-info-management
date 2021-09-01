import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/auth/student_data.dart';
import 'package:studentsinfo/model/user.dart';

import 'screens/admin_dashboard_screen.dart';
import 'screens/student_details_screen.dart';
import 'screens/user_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationServices()),
        ChangeNotifierProvider(create: (_) => StudentData()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            secondary: Colors.yellow,
          ),
        ),
        getPages: [
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(name: '/adminDash', page: () => const AdminDashboardScreen()),
          GetPage(name: '/userDash', page: () => const UserDashboardScreen()),
          GetPage(name: '/studentDetail', page: () => StudentDetailsScreen()),
        ],
        initialRoute: '/login',
      ),
    );
  }
}
