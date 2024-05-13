
import 'package:flutter/material.dart';
// import 'package:komi_dentist/screens/home_screen.dart';
import 'package:komi_dentist/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url:'https://vnpalubffatnlzrwrbbd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZucGFsdWJmZmF0bmx6cndyYmJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3NzAxMjMsImV4cCI6MjAyOTM0NjEyM30.sKEU2aT97HNOTjgVsEGB5t7SLc8FqNSkmZ-PjhpzYHw',
  );
  runApp(const SplashScreen());
}