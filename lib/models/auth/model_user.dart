// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthProvider extends ChangeNotifier {
//   UserModel? _user;
//   UserModel? get user => _user;
//   String _message = '';
//   String get message => _message;
//
//   Future<bool> accountRegister(
//       {String? name, String? email, String? password}) async {
//     try {
//       UserModel user = await AuthService()
//           .register(name: name, email: email, password: password);
//       _user = user;
//       return true;
//     } on SocketException {
//       _message = 'no internet';
//       return false;
//     } on Exception catch (e) {
//       String error = e.toString();
//       String newError = error.replaceAll('Exception: ', "");
//       _message = newError;
//       return false;
//     }
//   }
//
//   Future<bool> accountLogin({String? email, String? password}) async {
//     try {
//       UserModel user =
//       await AuthService().login(email: email, password: password);
//       _user = user;
//       // Simpan data login ke SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('userName', user.name.toString());
//       await prefs.setString('userId', user.id.toString());
//       await prefs.setString('userEmail', user.email.toString());
//       await prefs.setString('token', user.token.toString());
//       return true;
//     } on SocketException {
//       _message = 'no internet';
//       return false;
//     } on Exception catch (e) {
//       String error = e.toString();
//       String newError = error.replaceAll('Exception: ', "");
//       _message = newError;
//       return false;
//     }
//   }
// }
