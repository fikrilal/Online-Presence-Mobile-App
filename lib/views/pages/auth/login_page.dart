import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:presensi_mobile_app/views/pages/auth/register_page.dart';

import '../../../repository/library/library_colors.dart';
import '../../component/button/component_button.dart';
import '../../component/text/component_text.dart';
import '../../component/textfield/textfield_emailPass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16.w), // Tambahkan padding ke bawah
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Title30Bold("Selamat Datang Kembali!"),
                        Desc18w500("Masuk kembali ke akunmu untuk melakukan presensi"),
                        SizedBox(height: 20.h),
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
                        primaryButton(text: "Masuk", onPressed: () async {}),
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
