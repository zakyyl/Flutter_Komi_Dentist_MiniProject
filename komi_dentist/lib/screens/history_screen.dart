import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:komi_dentist/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
    
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
    'LIST TREATMENT',
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
      body: ListView.builder(
  itemCount: Listdata.length,
  itemBuilder: (BuildContext context, int index) {  
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(data: Listdata[index]),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/splash.png'), // Gambar avatar
                radius: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Pasien: ${Listdata[index]['nama_pasien']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Umur: ${Listdata[index]['umur']}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios), // Ikutkan ikon
            ],
          ),
        ),
      ),
    );
  },
),
    );
  }
}