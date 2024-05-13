import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:komi_dentist/models/pasien_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class TreatmentViewModel extends GetxController {
  final TextEditingController namapasienController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void savePatient(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      final patient = Patient(
        nama_pasien: namapasienController.text,
        umur: umurController.text,
        keluhan: keluhanController.text,
      );
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('treatment').insert(patient.toJson());
        EasyLoading.showSuccess('Data Berhasil Disimpan');
      } catch (e) {
        EasyLoading.showError('Opsssss..' + e.toString());
      }
      EasyLoading.dismiss();
    }
  }
}
