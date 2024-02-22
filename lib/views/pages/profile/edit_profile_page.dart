import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/library/library_colors.dart';
import '../../component/appbar/component_appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Desc18w700("NIM"),
            SizedBox(height: 5.h),
            EmailPassField(
              text: "NIM Kamu",
              svgIconPath: "assets/icons/icons_profile.svg",
              controller: _controllerNama,
              iconColor: ListColor.gray500,
              isPasswordType: false,
            ),
          ],
        ),
      ),
    );
  }
}
