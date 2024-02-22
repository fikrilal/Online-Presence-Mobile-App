import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_config.dart'; // Pastikan lokasi file ini sesuai dengan struktur direktori Anda

class PresensiService {
  Future<void> submitPresensi({
    required String userId,
    required String lokasi,
    required String hari,
    required String waktu,
    required String status,
  }) async {
    final url = Uri.parse(ApiConfig.presensiUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_user': userId,
          'lokasi': lokasi,
          'hari': hari,
          'waktu': waktu,
          'status': status,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // Handle response data or show a message to the user
        print("Presensi berhasil: ${responseData['message']}");
      } else {
        // Handle error
        print("Presensi gagal: ${responseData['message']}");
      }
    } catch (error) {
      print("Terjadi kesalahan: $error");
      throw error;
    }
  }
}
