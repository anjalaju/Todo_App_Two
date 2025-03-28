import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/homepage.dart';
import 'package:todo_app/screens/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? name;
  String? email;
  String? uid;
  String? token;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = await _pref.getString('token');
    email = await _pref.getString('name');
    uid = await _pref.getString('uid');
    name = await _pref.getString('name');

    // setState(() {});
  }

  @override
  void initState() {
    getData();
    var d = Duration(seconds: 2);
    Future.delayed(d, () {
      checkloginstatus();
    });

    super.initState();
  }

  Future<void> checkloginstatus() async {
    if (token == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Aspire Lite ',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
