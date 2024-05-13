import 'package:flutter/material.dart';

Widget buildCurvedImage(String imagePath) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );
}
