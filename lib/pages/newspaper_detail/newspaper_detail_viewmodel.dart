import 'package:flutter/material.dart';
import 'package:new_spaper/base/base.dart';
import 'package:new_spaper/firebase/firebase_store.dart';

class DetailsNewSpaperViewModel extends BaseViewModel{
  init(){}

  readDetailsNewSpaperViewModel(String id) => FireStore.readNewSpaperDetails(id);
}