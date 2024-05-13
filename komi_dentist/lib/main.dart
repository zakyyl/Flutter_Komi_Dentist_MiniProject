import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:komi_dentist/screens/detail_screen.dart';
import 'package:komi_dentist/screens/history_screen.dart';
import 'package:komi_dentist/screens/home_screen.dart';
import 'package:komi_dentist/screens/login_screen.dart';
import 'package:komi_dentist/screens/question_screen.dart';
import 'package:komi_dentist/screens/register_screen.dart';
import 'package:komi_dentist/screens/treatment_screens.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'package:komi_dentist/screens/edit_screen.dart';

// import 'package:komi_dentist/components/curved_image.dart';
// import 'package:supabase/supabase.dart';

Future<void> main() async {
  await Supabase.initialize(
    url:'https://vnpalubffatnlzrwrbbd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZucGFsdWJmZmF0bmx6cndyYmJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3NzAxMjMsImV4cCI6MjAyOTM0NjEyM30.sKEU2aT97HNOTjgVsEGB5t7SLc8FqNSkmZ-PjhpzYHw',
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
        
      ),
      home: SplashScreen(),
      routes: {
        '/home' : (context) => HomeScreen(),
        '/login' : (context) => LoginScreen(),
        '/register' : (context) => RegisterScreen(),
        '/edit' : (context) => EditScreenPage(),
        '/history' : (context) => HistoryScreen(),
        '/treatment' : (context) => TreatmentScreens(),
        '/question' : (context) => QuestionScreen(),
        '/detail' :(context) => DetailScreen(data: {},),
      },
      builder: EasyLoading.init(),
    );
  }
}
