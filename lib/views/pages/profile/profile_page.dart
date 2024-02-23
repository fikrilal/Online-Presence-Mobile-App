import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:presensi_mobile_app/views/component/text/component_text.dart';
import 'package:presensi_mobile_app/views/pages/profile/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../repository/api/api_config.dart';
import '../../../repository/library/library_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userNIM;
  String? userName;
  String? userEmail;
  String? userTelp;
  String? userTanggalLahir;
  String? userAlamat;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _loadUserInfo());
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userNIM = prefs.getString('userNIM');

    if (userNIM != null) {
      final response =
      await http.get(Uri.parse('${ApiConfig.getUserUrl}?nim=$userNIM'));

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        setState(() {
          userId = int.tryParse(userData['user_id'].toString()) ?? 0;
          userName = userData['nama'];
          userEmail = userData['email'];
          userTelp = userData['telp'];
          userTanggalLahir = userData['tanggal_lahir'];
          userAlamat = userData['alamat'];
        });
      } else {
        print('Gagal mengambil data pengguna');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 40.w, 16.h, 16.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: const CircleAvatar(
                      backgroundImage:
                      AssetImage("assets/images/blank_man_picture.png"),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title20Bold(userName),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfilePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: ListColor.gray300,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Desc15w500("Edit Profile"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc16w500("NIM"),
                      SizedBox(height: 10.h),
                      Desc18w700(userNIM),
                      SizedBox(height: 4.h),
                      const Divider(
                        color: ListColor.gray200,
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc16w500("Email"),
                      SizedBox(height: 10.h),
                      Desc18w700(userEmail),
                      SizedBox(height: 4.h),
                      const Divider(
                        color: ListColor.gray200,
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc16w500("No. Telp"),
                      SizedBox(height: 10.h),
                      Desc18w700(userTelp),
                      SizedBox(height: 4.h),
                      const Divider(
                        color: ListColor.gray200,
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc16w500("Tanggal Lahir"),
                      SizedBox(height: 10.h),
                      Desc18w700(userTanggalLahir),
                      SizedBox(height: 4.h),
                      const Divider(
                        color: ListColor.gray200,
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Desc16w500("Alamat"),
                      SizedBox(height: 10.h),
                      Desc18w700(userAlamat),
                      SizedBox(height: 4.h),
                      const Divider(
                        color: ListColor.gray200,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', false);
                          context.go("/LoginPage");
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.red.withOpacity(0.1),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: ListColor.red,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Desc18w700BoldRed("Logout"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
