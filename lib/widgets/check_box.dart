import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isChecked ? Colors.black : Colors.black,
                width: 2.5,
              ),
            ),
            child: Icon(
              Icons.check,
              size: 15,
              color: isChecked ? Colors.black : Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            ' Remember Me',
           style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
