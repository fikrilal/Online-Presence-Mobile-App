import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userNIM;
  String? userName;
  String? userEmail;
  String? userPassword;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userNIM = prefs.getString('userNIM');
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userPassword = prefs.getString('userPassword');
      // Muat data lainnya sesuai kebutuhan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("NIM: $userNIM"),
            Text("Nama: $userName"),
            Text("Email: $userEmail"),
            // Tampilkan data pengguna lainnya
          ],
        ),
      ),
    );
  }
}