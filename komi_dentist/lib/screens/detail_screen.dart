import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailScreen extends StatefulWidget {
  final Map data;

  DetailScreen({required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void initState() {
    super.initState();
    getData();
  }

  void deleteData(id) async {
    EasyLoading.show();
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('treatment').delete().match({'id': id});
    } catch (e) {
      EasyLoading.showError('Ops..$e');
    }
    getData();
    EasyLoading.dismiss();
  }

  List Listdata = [];
  void getData() async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from('treatment').select();
    setState(() {
      Listdata = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    '',
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
backgroundColor: Color.fromARGB(255, 204, 239, 255),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detail Pasien',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit', arguments: widget.data);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi Hapus'),
                              content: Text('Apakah Anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteData(widget.data['id']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/splash.png'),
              radius: 40,
            ),
            SizedBox(height: 20),
            Text(
              'Nama Pasien: ${widget.data['nama_pasien']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Umur: ${widget.data['umur']}'),
            SizedBox(height: 10),
            Text('Keluhan: ${widget.data['keluhan']}'),
          ],
        ),
      ),
    );
  }
}
