import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/library/library_colors.dart';

class Title30Bold extends StatelessWidget {
  final String? text;

  Title30Bold(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 30.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Title20Bold extends StatelessWidget {
  final String? text;

  Title20Bold(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 20,
        color: ListColor.gray700,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Desc18w500 extends StatelessWidget {
  final String? text;

  Desc18w500(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.gray500,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Desc16w500 extends StatelessWidget {
  final String? text;

  Desc16w500(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16.sp,
        color: ListColor.gray500,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}

class Desc15w500 extends StatelessWidget {
  final String? text;

  Desc15w500(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14.sp,
        color: ListColor.gray600,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}

class Desc18w700Bold extends StatelessWidget {
  final String? text;

  Desc18w700Bold(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Desc18w700 extends StatelessWidget {
  final String? text;

  Desc18w700(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Desc16White extends StatelessWidget {
  final String? text;

  Desc16White(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          height: 0,
          overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}

class Desc14White extends StatelessWidget {
  final String? text;

  Desc14White(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        height: 0,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}

class Desc18Blue extends StatelessWidget {
  final String? text;

  Desc18Blue(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.primary,
        fontWeight: FontWeight.w700,
        height: 0,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 2,
    );
  }
}

class ComponentTextAppBar extends StatelessWidget {
  final String? text;

  ComponentTextAppBar(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class TextPoint extends StatelessWidget {
  final String? text;

  TextPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
