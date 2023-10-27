import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

Widget filledButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.hardMintGreen,
        Color buttonTextColor = Colors.white,
        double textSize = 20.0,
        String buttonText = "button text",
        String fontName = 'Ubuntu',
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          disabledBackgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: function,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: textSize,
            fontFamily: GoogleFonts.getFont(fontName).fontFamily,
          ),
        ),
      ),
    );

Widget filledIconButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.hardMintGreen,
        Color buttonTextColor = Colors.white,
        double textSize = 20.0,
        double corner = 20.0,
        String buttonText = "button text",
        Function()? function,
        double iconSize = 24.0,
        String fontName = 'Ubuntu',
        IconData buttonIcon = Icons.add}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(corner),
          ),
        ),
        onPressed: function,
        icon: Icon(
          buttonIcon,
          size: iconSize,
          color: buttonTextColor,
        ),
        label: Text(
          textAlign: TextAlign.center,
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: textSize,
            fontFamily: GoogleFonts.getFont(fontName).fontFamily,
          ),
        ),
      ),
    );

Widget outlineButton(
        {double width = 200.0,
        double height = 40.0,
        Color hoverColor = AppColors.lightMintGreen,
        Color buttonColor = AppColors.hardMintGreen,
        Color buttonTextColor = AppColors.hardMintGreen,
        double textSize = 20.0,
        String buttonText = "button text",
        String fontName = 'Ubuntu',
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: hoverColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: BorderSide(
                color: buttonColor, width: 2.5, style: BorderStyle.solid)),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: textSize,
            fontFamily: GoogleFonts.getFont(fontName).fontFamily,
          ),
        ),
      ),
    );

Widget outlineIconButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.hardMintGreen,
        Color buttonTextColor = AppColors.hardMintGreen,
        double textSize = 20.0,
        String buttonText = "button text",
        Function()? function,
        double iconSize = 24.0,
        String fontName = 'Ubuntu',
        IconData buttonIcon = Icons.add}) =>
    SizedBox(
      width: width,
      height: height,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: BorderSide(
                color: buttonColor, width: 1.5, style: BorderStyle.solid)),
        onPressed: function,
        icon: Icon(
          buttonIcon,
          size: iconSize,
          color: buttonTextColor,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: textSize,
            fontFamily: GoogleFonts.getFont(fontName).fontFamily,
          ),
        ),
      ),
    );
