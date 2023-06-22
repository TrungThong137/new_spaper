
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


class Util{
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
    tranformer<T>(T Function(Map<String, dynamic> json) fromJson) => 
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
        handleData: (data, sink) {
          final snaps= data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();
          sink.add(objects);
        },
      );
}