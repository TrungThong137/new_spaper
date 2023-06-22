
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key, 
    required this.text,
    required this.icon, 
    this.obscureText=false, 
    required this.controller, 
    this.errorText='', 
    this.isSuffixIcon=false, 
    this.onTap, 
    this.isMaxline=false, 
  });
  final String text;
  final Icon icon;
  final bool obscureText;
  final TextEditingController controller;
  final String errorText;
  final bool isSuffixIcon;
  final VoidCallback? onTap;
  final bool isMaxline;
  // final IconData iconSuffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 18),
      child: TextFormField(
        maxLines: isMaxline==false? 1 : 3,
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
        decoration: InputDecoration(
          errorText: errorText==''? null : errorText,
          labelText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: isSuffixIcon ?
             InkWell(
              onTap: onTap,
               child: SizedBox(
                width: 10,
                 child: Row(
                   children: [
                    obscureText? SvgPicture.asset(
                      'assets/eye-slash.svg',
                      width: 25,
                    ):
                    const Icon(Icons.remove_red_eye_outlined, size: 30, color: Colors.black54,),
                   ],
                 ),
               ),
             ) : null
        ),
      ),
    );
  }
}