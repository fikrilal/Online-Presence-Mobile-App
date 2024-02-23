import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../repository/api/api_config.dart';
import '../../../repository/api/api_updateProfile.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/appbar/component_appbar.dart';
import '../../component/button/component_button.dart';
import '../../component/text/component_text.dart';
import '../../component/textfield/textfield_emailPass.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTelp = TextEditingController();
  final TextEditingController _controllerTanggalLahir = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? userNIM;
  String? userName;
  String? userEmail;
  String? userTelp;
  String? userTanggalLahir;
  String? userAlamat;
  // String? userPassword;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
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
          // userPassword = userData['password'];

          // Set values for the TextEditingControllers
          _controllerNama.text = userName ?? '';
          _controllerEmail.text = userEmail ?? '';
          _controllerTelp.text = userTelp ?? '';
          _controllerTanggalLahir.text = userTanggalLahir ?? '';
          _controllerAlamat.text = userAlamat ?? '';
          // _controllerPassword.text = userPassword ?? '';
        });
      } else {
        print('Gagal mengambil data pengguna');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 2.w, 16.h, 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Desc18w700("Nama"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "Nama Lengkap",
                svgIconPath: "assets/icons/icons_profile.svg",
                controller: _controllerNama,
                iconColor: ListColor.gray500,
                isPasswordType: false,
              ),
              SizedBox(height: 10.h),
              Desc18w700("Email"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "Email Kamu",
                svgIconPath: "assets/icons/icons_mail.svg",
                controller: _controllerEmail,
                iconColor: ListColor.gray500,
                isPasswordType: false,
              ),
              SizedBox(height: 10.h),
              Desc18w700("No. Telp"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "08",
                svgIconPath: "assets/icons/icons_telp.svg",
                controller: _controllerTelp,
                iconColor: ListColor.gray500,
                isPasswordType: false,
              ),
              SizedBox(height: 10.h),
              Desc18w700("Tanggal Lahir"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "Contoh: 2002-08-28",
                svgIconPath: "assets/icons/icons_date.svg",
                controller: _controllerTanggalLahir,
                iconColor: ListColor.gray500,
                isPasswordType: false,
              ),
              SizedBox(height: 10.h),
              Desc18w700("Alamat"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "Alamat Lengkap",
                svgIconPath: "assets/icons/icons_location.svg",
                controller: _controllerAlamat,
                iconColor: ListColor.gray500,
                isPasswordType: false,
              ),
              // SizedBox(height: 10.h),
              // Desc18w700("Password"),
              // SizedBox(height: 5.h),
              // EmailPassField(
              //   text: "****",
              //   svgIconPath: "assets/icons/icons_password.svg",
              //   controller: _controllerPassword,
              //   iconColor: ListColor.gray500,
              //   isPasswordType: true,
              // ),
              SizedBox(height: 32.h),
              primaryButton(
                  text: "Simpan",
                  onPressed: () async {
                    bool success = await UserService().updateUser(
                      userId: userId!, // Anda perlu memastikan userId ini tersedia
                      nim: userNIM ?? '',
                      nama: _controllerNama.text,
                      email: _controllerEmail.text,
                      telp: _controllerTelp.text,
                      tanggalLahir: _controllerTanggalLahir.text,
                      alamat: _controllerAlamat.text,
                      // password: _controllerPassword.text,
                    );
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profil berhasil diperbarui')),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal memperbarui profil')),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
