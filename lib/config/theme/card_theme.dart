import 'package:flutter/material.dart';

class TCardTheme {
  TCardTheme._();
  static CardTheme lightCardTheme = CardTheme(
    color: Colors.white,
    shadowColor: Colors.grey[300],
    elevation: 5,
  );
  static CardTheme darkCardTheme = CardTheme(
    color: Colors.grey[900],
    shadowColor: Colors.black,
    elevation: 5,
  );
}
