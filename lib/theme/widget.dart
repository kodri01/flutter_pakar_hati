import 'package:flutter/material.dart';
import 'package:pakar_hati/theme/color.dart';

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Oke',
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

const textDecoration = InputDecoration(
  labelStyle: TextStyle(color: backgroundColor),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: backgroundColor)),
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: backgroundColor)),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
);

const textDecorationregist = InputDecoration(
  labelStyle: TextStyle(color: secondaryTextColor),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: thirdColor)),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: thirdColor)),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
);
