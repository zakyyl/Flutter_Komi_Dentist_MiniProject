import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:your_app_name/viewmodels/treatment_viewmodel.dart';
import 'package:komi_dentist/controllers/pasien_controller.dart';

import 'package:komi_dentist/models/pasien_model.dart';
class TreatmentScreens extends StatelessWidget {
  final viewModel = Get.put(TreatmentViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD TREATMENT',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(760),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await Supabase.instance.client.auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('email');
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                EasyLoading.showInfo("Ops...$e");
              }
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/treat.png', fit: BoxFit.cover),
              Center(
                child: Text(
                  'Inputkan Data Diri & Keluhan Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                color: const Color.fromARGB(255, 179, 231, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: viewModel.namapasienController,
                          decoration: InputDecoration(
                            labelText: 'Nama Pasien',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama pasien tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: viewModel.umurController,
                          decoration: InputDecoration(
                            labelText: 'Umur',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Umur tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: viewModel.keluhanController,
                          decoration: InputDecoration(
                            labelText: 'Keluhan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 50.0,
                              horizontal: 20.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Keluhan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(100, 40),
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () => viewModel.savePatient(context),
                          child: Text(
                            'Simpan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
