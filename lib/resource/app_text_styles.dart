import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_size.dart';

/// [AppTextStyles] contains text styles of application
/// Font using [Poppins, SFPro, Overpass, Nexa, Open Sans]
class AppTextStyles {
  AppTextStyles._();

  /// Font Style: Poppins - Weight 400 - Size 14
  static final TextStyle fontPoppinsRegular14 = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font14.fontSize,
  );

  /// Font Style: Poppins - Weight 400 - Size 15
  static final TextStyle fontPoppinsRegular15 = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font15.fontSize,
  );

  /// Font Style: Poppins - Weight 400 - Size 14
  static final TextStyle fontPoppinsBold14 = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.font14.fontSize,
  );

  /// Font Style: Poppins - Weight 400 - Size 15
  static final TextStyle fontPoppinsBold15 = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.font15.fontSize,
  );

  /// Font Style: Poppins - Weight 700 - Size 22
  static final TextStyle fontPoppinsBold22 = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.font22.fontSize,
  );

  /// Font Style: Poppins - Weight 400 - Size 14
  static final TextStyle fontPoppinsRegular22 = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font22.fontSize,
  );

  /// Font Style: SFPro - Weight 400 - Size 14
  static final TextStyle fontSFProTextRegular14 = GoogleFonts.sourceSansPro(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font14.fontSize,
  );

  /// Font Style: SFPro - Weight 400 - Size 23
  static final TextStyle fontSFProTextBold23 = GoogleFonts.sourceSansPro(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font23.fontSize,
  );

  /// Font Style: Overpass - Weight: 400 - Size 15
  static final TextStyle fontOverpassRegular15 = GoogleFonts.overpass(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font15.fontSize,
  );

  /// Font Style: OpenSans - Weight: 400 - Size 15
  static final TextStyle fontOpenSansRegular15 = GoogleFonts.openSans(
    fontWeight: FontWeight.w400,
    fontSize: FontSize.font15.fontSize,
  );

  /// Font Style: OpenSans - Weight: 400 - Size 15
  static final TextStyle fontOpenSansBold15 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    fontSize: FontSize.font15.fontSize,
  );
}
