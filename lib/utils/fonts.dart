import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  const BodyText({Key? key, required this.data, this.size, this.color})
      : super(key: key);
  final String data;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.notoSans(
        fontSize: size ?? 14,
        color: color ?? Colors.black,
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText({
    Key? key,
    required this.data,
    this.size,
    this.color,
    this.shadow,
  }) : super(key: key);
  final String data;
  final double? size;
  final Color? color;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.notoSans(
          fontSize: size ?? 20,
          color: color ?? Colors.black,
          fontWeight: FontWeight.bold,
          shadows: (shadow != null && shadow!)
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.grey,
                  )
                ]
              : []),
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText({
    Key? key,
    required this.data,
    this.size,
    this.color,
  }) : super(key: key);
  final String data;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.notoSans(
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: FontWeight.w500),
    );
  }
}
