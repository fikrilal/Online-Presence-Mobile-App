import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../repository/api/api_config.dart';
import '../../../repository/api/api_updateProfile.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/appbar/component_appbar.dart';
import '../../component/button/component_button.dart';
import '../../component/snackbar/component_snackbar.dart';
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
  String? userPassword;
  int? userId;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Ngambil data user
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
          userPassword = userData['password'];

          // Set textfield dari data database
          _controllerNama.text = userName ?? '';
          _controllerEmail.text = userEmail ?? '';
          _controllerTelp.text = userTelp ?? '';
          _controllerTanggalLahir.text = userTanggalLahir ?? '';
          _controllerAlamat.text = userAlamat ?? '';
          _controllerPassword.text = userPassword ?? '';
        });
      } else {
        print('Gagal mengambil data pengguna');
      }
    }
  }

  // Tanggal lahir pake kalender
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controllerTanggalLahir.text = DateFormat('yyyy-MM-dd').format(picked); // Mengatur format tanggal
      });
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
              Row(
                children: [
                  Expanded(
                    child: EmailPassField(
                      text: "Contoh: 2002-08-28",
                      svgIconPath: "assets/icons/icons_date.svg",
                      controller: _controllerTanggalLahir,
                      iconColor: ListColor.gray500,
                      isPasswordType: false,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ListColor.gray200),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/icons_bold_calendar.svg',
                        color: ListColor.primary,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  )
                ],
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
              SizedBox(height: 10.h),
              Desc18w700("Password"),
              SizedBox(height: 5.h),
              EmailPassField(
                text: "Biarkan kosong jika tetap",
                svgIconPath: "assets/icons/icons_password.svg",
                controller: _controllerPassword,
                iconColor: ListColor.gray500,
                isPasswordType: true,
              ),
              SizedBox(height: 32.h),
              // Fungsi untuk menyimpan data updatan ke database
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
                      password: _controllerPassword.text,
                    );
                    if (success) {
                      CustomSnackbar.showSuccessSnackbar(context, "Profil berhasil diperbarui");
                      Navigator.of(context).pop();
                    } else {
                      CustomSnackbar.showFailedSnackbar(context, "Gagal memperbarui profil");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
