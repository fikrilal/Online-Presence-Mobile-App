import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presensi_mobile_app/views/component/text/component_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../repository/api/api_addPresensi.dart';
import '../../../repository/api/api_config.dart';
import '../../../repository/api/api_getPresensi.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/appbar/component_appbar.dart';

class RiwayatPresensiPage extends StatefulWidget {
  const RiwayatPresensiPage({super.key});

  @override
  State<RiwayatPresensiPage> createState() => _RiwayatPresensiPageState();
}

class _RiwayatPresensiPageState extends State<RiwayatPresensiPage> {

  String? userNIM;
  String? userName;
  String? userEmail;
  int? userId;
  List<dynamic> listAbsensi = [];


  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    Timer.periodic(Duration(seconds: 1), (Timer t) => fetchAbsensi());
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userNIM = prefs.getString('userNIM');

    if (userNIM != null) {
      final response = await http.get(Uri.parse('${ApiConfig.getUserUrl}?nim=$userNIM'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        setState(() {
          userId = int.tryParse(userData['user_id'].toString()) ?? 0;
          userName = userData['nama'];
          userEmail = userData['email'];
        });
        fetchAbsensi(); // Memanggil fetchAbsensi setelah mendapatkan userId
      } else {
        print('Gagal mengambil data pengguna');
      }
    }
  }

  void fetchAbsensi() async {
    if (userId == null) {
      print('UserId tidak ditemukan');
      return;
    }
    final presensiList = await GetPresensiService().fetchPresensiList(userId!);
    if (presensiList != null) {
      setState(() {
        listAbsensi = presensiList;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Riwayat Presensi",
      ),
      body: listAbsensi.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/no_data.svg", width: 150.w), // Pastikan Anda memiliki gambar/svg yang sesuai
            SizedBox(height: 20.h),
            Text(
              "Tidak ada data riwayat presensi",
              style: TextStyle(fontSize: 18.sp, color: Colors.black54),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: listAbsensi.map((absensi) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc18w700Bold(absensi['hari']),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.w),
                          color: absensi['status'] == 'Hadir' ? ListColor.green : ListColor.red,
                        ),
                        child: Desc14White(absensi['status']),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icons_clock.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8.w),
                      Desc18w500(absensi['waktu']),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icons_location.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(child: Desc18w500(absensi['lokasi'])),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  const Divider(
                    color: ListColor.gray200,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}
