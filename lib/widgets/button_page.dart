import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key, 
    required this.text, 
    this.width=200, 
    this.height=60, 
    required this.color,
    required this.colortext,
    required this.onTap
  });
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color colortext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: color
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colortext
            ),
          ),
        ),
      ),
    );
  }
}