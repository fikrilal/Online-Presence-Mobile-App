import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presensi_mobile_app/repository/library/library_colors.dart';
import 'package:presensi_mobile_app/views/component/snackbar/component_snackbar.dart';
import 'package:presensi_mobile_app/views/component/text/component_text.dart';
import 'package:intl/intl.dart';
import '../../../repository/api/api_addPresensi.dart';
import '../../component/appbar/component_appbar.dart';
import '../../component/button/component_button.dart';

class PresensiPage extends StatefulWidget {
  final int? id;
  final String? nama;
  final String? lokasi;

  const PresensiPage({Key? key, required this.id, required this.nama, required this.lokasi}) : super(key: key);

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  late String formattedDate;
  late String formattedTime;
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    // Format tanggal menggunakan library intl
    formattedDate = DateFormat('EEEE, dd MMMM y').format(DateTime.now());

    // Format waktu menggunakan library intl
    formattedTime = DateFormat('HH:mm').format(DateTime.now());

    // Memperbarui waktu setiap detik
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        formattedTime = DateFormat('HH:mm').format(DateTime.now());
      });
    });
  }

  void submitAbsensi() async {
    if (dropdownValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon pilih status kehadiran')),
      );
      return;
    }

    try {
      await PresensiService().submitPresensi(
        userId: widget.id.toString(),
        lokasi: widget.lokasi.toString(),
        hari: formattedDate,
        waktu: formattedTime,
        status: dropdownValue!,
      );

     CustomSnackbar.showSuccessSnackbar(context, "Absensi berhasil!");
      Navigator.pop(context);
      // Opsi untuk navigasi atau tindakan lain setelah berhasil
    } catch (e) {
      CustomSnackbar.showFailedSnackbar(context, "Gagal mengirim absensi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Absensi",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Title20Bold(widget.nama),
              Desc16w500(formattedDate),
              SizedBox(height: 20.h),
              Container(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: ListColor.red,
                ),
                child: Desc16White(formattedTime),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: ListColor.gray300),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  underline: SizedBox(),
                  hint: Text('Pilih Kehadiran'),
                  items: <String>['Hadir', 'Izin', 'Sakit'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              primaryButton(text: "Absen", onPressed: submitAbsensi),
            ],
          ),
        ),
      ),
    );
  }
}
