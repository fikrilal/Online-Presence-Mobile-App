import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repository/library/library_colors.dart';

// ignore: must_be_immutable
class EmailPassField extends StatefulWidget {
  final String text;
  final String svgIconPath;
  final TextEditingController controller;
  final Color iconColor;
  bool isPasswordType;

  EmailPassField(
      {required this.text,
        required this.svgIconPath,
        required this.controller,
        required this.iconColor,
        required this.isPasswordType});
  @override
  State<EmailPassField> createState() => _EmailPassFieldState();
}

class _EmailPassFieldState extends State<EmailPassField> {
  bool obsText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordType == true ? obsText : false,
      enableSuggestions: !widget.isPasswordType,
      autocorrect: !widget.isPasswordType,
      cursorColor: ListColor.primary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      style: const TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: ListColor.gray700, // Warna teks dalam TextField
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ListColor.gray200,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ListColor.primary,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ListColor.primary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),
        prefixIcon: Container(
          width: 54,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: SvgPicture.asset(
              width: 25.0,
              height: 25.0,
              fit: BoxFit.fill,
              widget.svgIconPath,
              color: widget.iconColor,
            ),
          ),
        ),
        suffixIcon: widget.isPasswordType
            ? Container(
          width: 54,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    if (obsText == true) {
                      obsText = false;
                      print(obsText);
                    } else {
                      obsText = true;
                      print(obsText);
                    }
                  });
                },
                icon: Icon(obsText
                    ? Hicons.show_light_outline
                    : Hicons.hide_light_outline)),
          ),
        )
            : Container(
          width: 10,
        ),
        labelText: widget.text,
        labelStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ListColor.gray500,
        ),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

Widget EmailPassTextfield(String text, String svgIconPath, bool isPasswordType,
    TextEditingController controller, Color iconColor) {
  bool obscureText = isPasswordType;
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: ListColor.primary,
    style: const TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: ListColor.gray700, // Warna teks dalam TextField
    ),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(18.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: ListColor.gray200,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: ListColor.primary,
          width: 1,
        ),
      ),
      prefixIcon: Container(
        width: 54,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: SvgPicture.asset(
            width: 25.0,
            height: 25.0,
            fit: BoxFit.fill,
            svgIconPath,
            color: iconColor,
          ),
        ),
      ),
      suffixIcon: isPasswordType
          ? Container(
        width: 54,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
              onPressed: () {
                obscureText = !obscureText;
                print(obscureText);
              },
              icon: Icon(obscureText
                  ? Hicons.show_light_outline
                  : Hicons.hide_light_outline)),
        ),
      )
          : Container(
        width: 10,
      ),
      labelText: text,
      labelStyle: const TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: ListColor.gray500,
      ),
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
