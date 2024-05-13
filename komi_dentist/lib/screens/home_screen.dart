import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:komi_dentist/screens/history_screen.dart';
import 'package:komi_dentist/screens/treatment_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0; 
  final PageController _pageController = PageController(initialPage: 0); 

  @override
  void initState() {
    super.initState();
    _getEmail();
    
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
  }
  String userEmail = ''; 
  
  _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('email') ?? ''; 
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'K O M I  D E N T I S T',
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
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        child: Text(
          'KOMI DENTIST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        title: Text('H O M E  PAGE'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home'); 
        },
      ),
      ListTile(
        title: Text('H I S T O R Y  PAGE '),
        onTap: () {
          Navigator.pop(context); 
          Navigator.pushNamed(context, '/history');
        },
      ),
      ListTile(
        title: Text('T R E A T M E N T  PAGE '),
        onTap: () {
          Navigator.pop(context); 
          Navigator.pushNamed(context, '/treatment'); 
        },
      ),
    ],
  ),
),

      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!! $userEmail',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Ask Komi',
                              style: TextStyle(
                                color: Colors.black38,
                              ),
                            ),
                            SizedBox(width: 3),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/question');
                              },
                              icon: Icon(Icons.search, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TreatmentScreens()));
                },
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add, color: Colors.white, size: 20),
                            SizedBox(width: 5), 
                            Text(
                              'A D D',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'T R E A T M E N T',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_sharp, color: Colors.white, size: 20),
                            SizedBox(width: 5), 
                            Text(
                              'L I S T',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(height: 5), 
                        Text(
                          'T R E A T M E N T',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Center(
  child: Container(
  height: 36,
  width: 420,
  decoration: BoxDecoration(
    color: Colors.lightBlue,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0), // Melengkungkan sudut atas kiri
      topRight: Radius.circular(20.0), // Melengkungkan sudut atas kanan
    ),
  ),
  padding: EdgeInsets.all(10),
  child: Center(
    child: Text(
      'About Us',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.white,
      ),
    ),
  ),
),
),
          
          Container(
            height: 200,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Image.asset('assets/images/whyy.png', fit: BoxFit.cover),
                Image.asset('assets/images/doctor.png', fit: BoxFit.cover),
                Image.asset('assets/images/locationn.png', fit: BoxFit.cover),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Color.fromARGB(255, 225, 241, 255),
  currentIndex: _currentPage,
  onTap: (int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.align_vertical_center_sharp),
      label: 'Our Motto',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_3),
      label: 'Our Doctor',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.location_on),
      label: 'Our Location',
    ),
  ],
  selectedItemColor: Colors.blue, 
  unselectedItemColor: Colors.grey, 
),

    );
  }
}
