import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier{
  late BuildContext _context;

  BuildContext get context => _context;

  setContext(BuildContext context){
    _context=context;
  }
}