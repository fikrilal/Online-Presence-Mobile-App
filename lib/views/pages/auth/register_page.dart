import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:presensi_mobile_app/views/pages/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../../repository/api/api_register.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/button/component_button.dart';
import '../../component/snackbar/component_snackbar.dart';
import '../../component/text/component_text.dart';
import '../../component/textfield/textfield_emailPass.dart';
import '../dashboard/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerNIM = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTelp = TextEditingController();
  final TextEditingController _controllerTanggalLahir = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  var registrationService = RegistrationService();

  @override
  void initState() {
    super.initState();
  }

  //Fungsi untuk menyimpan
  void registerUser() async {
    try {
      // Set isLoading menjadi true saat proses registrasi dimulai
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 3));
      var response = await registrationService.registerUser(
        nim: _controllerNIM.text,
        nama: _controllerNama.text,
        email: _controllerEmail.text,
        telp: _controllerTelp.text,
        tanggalLahir: _controllerTanggalLahir.text,
        alamat: _controllerAlamat.text,
        password: _controllerPassword.text,
      );
      if (response.statusCode == 200) {
        CustomSnackbar.showSuccessSnackbar(context, "Berhasil melakukan registrasi! Silahkan login");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (error) {
      CustomSnackbar.showFailedSnackbar(context, "Gagal melakukan registrasi");
    } finally {
      // Set isLoading menjadi false setelah proses registrasi selesai
      setState(() {
        isLoading = false;
      });
    }
  }

  //Funsi untuk mendapat tanggal lahir dari kalender
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
      body: SafeArea(
        child: Column(
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16.w),
                // Tambahkan padding ke bawah
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Title30Bold("Daftar Akun"),
                        Desc18w500(
                            "Masukkan data diri dan daftarkan akunmu untuk menikmati fitur lengkap kami!"),
                        SizedBox(height: 20.h),
                        Desc18w700("NIM"),
                        SizedBox(height: 5.h),
                        EmailPassField(
                          text: "NIM Kamu",
                          svgIconPath: "assets/icons/icons_profile.svg",
                          controller: _controllerNIM,
                          iconColor: ListColor.gray500,
                          isPasswordType: false,
                        ),
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
                        Desc18w700("Kata Sandi"),
                        SizedBox(height: 5.h),
                        EmailPassField(
                          text: "Kata Sandi Kamu",
                          svgIconPath: "assets/icons/icons_password.svg",
                          controller: _controllerPassword,
                          iconColor: ListColor.gray500,
                          isPasswordType: true,
                        ),
                        SizedBox(height: 20.h),
                        primaryButton(
                            text: "Daftar",
                            onPressed: () async {
                              registerUser();
                            }),
                        SizedBox(height: 60.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Desc18w500("Sudah punya akun?"),
                                  SizedBox(width: 4.w),
                                  Desc18Blue("Masuk"),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
