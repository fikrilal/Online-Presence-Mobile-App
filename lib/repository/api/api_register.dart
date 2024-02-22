import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_config.dart';

class RegistrationService {
  Future<http.Response> registerUser({
    required String nim,
    required String nama,
    required String email,
    required String telp,
    required String tanggalLahir,
    required String alamat,
    required String password,
  }) async {
    final url = Uri.parse(ApiConfig.registerUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nim': nim,
          'nama': nama,
          'email': email,
          'telp': telp,
          'tanggal_lahir': tanggalLahir,
          'alamat': alamat,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Handle response data or show a message to the user
        print("Registrasi berhasil: ${responseData['message']}");
      } else {
        // Handle error
        print("Registrasi gagal: ${responseData['message']}");
      }
      return response;
    } catch (error) {
      print("Terjadi kesalahan: $error");
      throw error;
    }
  }
}
