import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/api/api_config.dart';
import '../../../repository/library/library_colors.dart';
import '../../component/button/component_button.dart';
import '../../component/text/component_text.dart';
import '../presensi/presensi_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userNIM;
  String? userName;
  String? userEmail;
  int? userId;
  String? userLocation;
  LatLng? userPosition;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _getCurrentLocation();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userNIM = prefs.getString('userNIM');

    if (userNIM != null) {
      final response =
          await http.get(Uri.parse('${ApiConfig.getUserUrl}?nim=$userNIM'));

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        setState(() {
          userId = int.tryParse(userData['user_id'].toString()) ?? 0;
          userName = userData['nama'];
          userEmail = userData['email'];
        });
      } else {
        print('Gagal mengambil data pengguna');
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa apakah layanan lokasi diaktifkan.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Lakukan sesuatu untuk menginformasikan pengguna
      return Future.error('Layanan lokasi dinonaktifkan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Lakukan sesuatu untuk menginformasikan pengguna
        return Future.error('Izin lokasi ditolak.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin.');
    }

    // Saat izin diberikan, mendapatkan lokasi pengguna saat ini.
    Position position = await Geolocator.getCurrentPosition();

    // Menggunakan Geocoding untuk mendapatkan alamat dari latitude dan longitude
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0]; // Mengambil Placemark pertama

      setState(() {
        userPosition = LatLng(position.latitude, position.longitude);
        // Membuat string alamat dari Placemark
        userLocation =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print("Error mendapatkan alamat: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(16.w, 46.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 46.h, 16.w, 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/blank_man_picture.png"),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title20Bold(userName),
                      Desc16w500("Selamat datang, $userId"),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title20Bold("Lokasi Kamu"),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/icons_location.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Desc16w500(
                              userLocation ?? "Mengambil lokasi...")),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // Gunakan nilai yang sama dengan Container
                      child: userPosition == null
                          ? const Center(child: CircularProgressIndicator())
                          : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: userPosition!,
                          zoom: 19,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId("userLocation"),
                            position: userPosition!, // Menentukan posisi marker
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: primaryButton(text: "Absensi", onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PresensiPage(
                        id: userId ?? 0,
                        nama: userName ?? "Nama tidak ditemukan",
                        lokasi: userLocation ?? "Lokasi tidak ditemukan",
                      )),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
