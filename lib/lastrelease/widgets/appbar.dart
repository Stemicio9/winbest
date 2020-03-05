

import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';


appbarcomune (String titolo) {
  return new AppBar(
    primary: false,
      backgroundColor: azzurroscuro,
      title: Text(titolo, style: stiletestoappbar
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),)
  );
}


