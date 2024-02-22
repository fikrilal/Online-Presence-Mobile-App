import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_config.dart';

class UserService {
  Future<bool> updateUser({
    required int userId,
    required String nim,
    required String nama,
    required String email,
    required String telp,
    required String tanggalLahir,
    required String alamat,
    String? password, // Password adalah opsional
  }) async {
    final url = Uri.parse(ApiConfig.updateUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'nim': nim,
          'nama': nama,
          'email': email,
          'telp': telp,
          'tanggal_lahir': tanggalLahir,
          'alamat': alamat,
          if (password != null) 'password': password, // Sertakan password hanya jika tidak null
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return true; // Berhasil memperbarui data pengguna
        }
        print('Error updating user: ${data['message']}');
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
    return false; // Gagal memperbarui data pengguna
  }
}
