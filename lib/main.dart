import 'package:flutter/material.dart';
import 'package:presensi_mobile_app/views/pages/auth/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presensi_mobile_app/views/pages/auth/register_page.dart';
import 'package:presensi_mobile_app/views/pages/dashboard/home_page.dart';
import 'package:presensi_mobile_app/views/pages/presensi/presensi_page.dart';
import 'package:presensi_mobile_app/views/pages/presensi/presensi_riwayat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RiwayatPresensiPage(),
      ),
    );
  }
}