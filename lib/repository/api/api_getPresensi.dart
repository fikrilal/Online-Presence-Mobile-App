import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_config.dart';

class GetPresensiService {
  Future<List<dynamic>?> fetchPresensiList(int userId) async {
    final url = Uri.parse('${ApiConfig.riwayatUrl}?id_user=$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return data['data'];
        } else {
          print('Error fetching presensi list: ${data['message']}');
          return null;
        }
      } else {
        print('Error fetching presensi list: Server error with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching presensi list: $e');
      return null;
    }
  }
}
