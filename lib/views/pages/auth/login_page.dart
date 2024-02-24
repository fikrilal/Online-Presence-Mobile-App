import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:presensi_mobile_app/views/pages/auth/register_page.dart';
import 'package:presensi_mobile_app/views/pages/dashboard/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/api/api_signin.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/button/component_button.dart';
import '../../component/snackbar/component_snackbar.dart';
import '../../component/text/component_text.dart';
import '../../component/textfield/textfield_emailPass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerNIM = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // fungsi untuk login
  void _attemptLogin() async {
    final nim = _controllerNIM.text;
    final password = _controllerPassword.text;
    final loginSuccess = await _authService.loginUser(nim, password);

    if (loginSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userNIM', _controllerNIM.text);
      await prefs.setString('userPassword', _controllerPassword.text);
      CustomSnackbar.showSuccessSnackbar(context, "Berhasil login");
      context.go("/HomePage");
    } else {
      CustomSnackbar.showFailedSnackbar(context, "NIM atau Password salah");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Title30Bold("Selamat Datang Kembali!"),
                        Desc18w500(
                            "Masuk kembali ke akunmu untuk melakukan presensi"),
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
                        primaryButton(text: "Masuk", onPressed: _attemptLogin),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Desc18w500("Belum punya akun?"),
                      SizedBox(width: 4.w),
                      Desc18Blue("Daftar"),
                    ],
                  )),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
