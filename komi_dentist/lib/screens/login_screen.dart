import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:komi_dentist/screens/home_screen.dart';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences logindata;
  late bool newUser;

  void checkLogin() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String? email = logindata.getString('email');

    if (email != null && email.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      final supabase = Supabase.instance.client;
      try {
        await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.text);

        EasyLoading.dismiss();
        Navigator.pushNamed(context, '/home');
      } catch (e) {
        EasyLoading.showInfo("Ops... $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/komiwelcome.png', 
                width: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "Selamat Datang Di KOMI DENTIST",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Masukkan Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30), 
                            borderSide: BorderSide(color: Colors.lightBlueAccent), 
                          ),
                          fillColor: Colors.lightBlueAccent.withOpacity(0.1), 
                          filled: true, 
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 20),
                    TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Masukkan Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.lightBlueAccent), 
                            ),
                            fillColor: Colors.lightBlueAccent.withOpacity(0.1), 
                            filled: true, 
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => login(context),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.maxFinite, 50),
                          backgroundColor: Colors.lightBlueAccent),
                      child: const Text(
                        'L O G I N',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'or',
                          style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Klik Untuk Register',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
