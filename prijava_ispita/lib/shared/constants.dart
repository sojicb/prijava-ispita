import 'package:flutter/material.dart';

const textImportDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2)
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2)
    )
);

const appBarBanner = Padding(
    padding: const EdgeInsets.all(2.0),
    child: CircleAvatar(
        backgroundImage: AssetImage('assets/banner1.png'),
    ),
);