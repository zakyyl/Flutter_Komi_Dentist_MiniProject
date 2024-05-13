  import 'package:flutter/material.dart';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';

  class EditScreenPage extends StatefulWidget {
    const EditScreenPage({Key? key}) : super(key: key);

    @override
    _EditScreenPageState createState() => _EditScreenPageState();
  }

  class _EditScreenPageState extends State<EditScreenPage> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      final TextEditingController _namapasienController = TextEditingController();
    final TextEditingController _umurpasienController = TextEditingController();
    final TextEditingController _keluhanController = TextEditingController();

    void _simpanForm(context, id) async {
  if (_formKey.currentState!.validate()) {
    EasyLoading.show();
    String nama = _namapasienController.text;
    String umur = _umurpasienController.text;
    String keluhan = _keluhanController.text;
    var data = {
      'nama_pasien': nama,
      'umur': umur,
      'keluhan': keluhan,
    };
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('treatment').update(data).match({'id': id});
      EasyLoading.showSuccess('Data Berhasil Diupdate');
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah sukses update
    } catch (e) {
      EasyLoading.showError('Oops .. $e');
    }
    EasyLoading.dismiss();
  }
}


    @override
    Widget build(BuildContext context) {
      final dataObt = ModalRoute.of(context)!.settings.arguments as Map;
      _namapasienController.text = dataObt['nama_pasien'] ?? '';
      _umurpasienController.text = dataObt['umur'] ?? '';
      _keluhanController.text = dataObt['keluhan'] ?? '';
      
      return Scaffold(
        appBar: AppBar(
        title: const Text(
          'EDIT TREATMENT ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(760),
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namapasienController,
                    decoration: InputDecoration(
                      labelText: 'Nama Pasien',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Pasien tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _umurpasienController,
                    decoration: InputDecoration(
                      labelText: 'Umur anda',
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
                    controller: _keluhanController,
                    decoration: InputDecoration(
                      labelText: 'Keluhan anda',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tolong isi keluhan anda';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _simpanForm(context, dataObt['id']),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                    child: Text('Simpan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
