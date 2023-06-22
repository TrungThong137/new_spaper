

import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier{
  bool _dark=false;

  bool get isDark => _dark;

  void setBrightness(bool value){
    _dark=value;
    notifyListeners();
  }
}