import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://baomoi-static.bmcdn.me/web-v2/prod/v0.4.18/public/images/default-skin/bm-logo.png'
        ),
        Container(
          margin: const EdgeInsets.only(top: 50),
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.green
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white, width: 0.5))
                ),
                alignment: Alignment.center,
                child: const Text('Nóng',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 60,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white, width: 0.5))
                ),
                alignment: Alignment.center,
                child: const Text('Mới',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 60,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white, width: 0.5))
                ),
                alignment: Alignment.center,
                child: const Text('Video',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.white, width: 0.5))
                  ),
                  alignment: Alignment.center,
                  child: const Text('Khác',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}