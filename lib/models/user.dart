import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String phone;
  String email;
  String password;
  String image;
  User({this.id='',
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    this.image=''
  });

  Map<String, Object?> tojson() => {
    'id': id,
    'name': name, 'phone': phone,
    'email': email, 'password': password
  };

  static User fromJson(Map<String, dynamic> json)
    => User(
      id: json['id'],
      email: json['email'], 
      name: json['name'], 
      phone: json['phone'], 
      password: json['password'],
      image: json['image']
    );

  static Future<void> addUser(User user) async{
    CollectionReference users= FirebaseFirestore.instance.collection('user');
    return users.add(
      {
        'id': user.id,
        'name': user.name,
        'phone': user.phone,
        'email': user.email,
        'password': user.password,
        'image': 'image'
      }
    ).then((value) => print('user added'))
    .catchError((onError) => print('failed to add user: $onError'));
  }

  static getUser(String documentId){
    CollectionReference users= FirebaseFirestore.instance.collection('user');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['name']} ${data['id']}");
        }

        return Text("loading");
      },
    );
  }

  static namess(){
    FirebaseFirestore.instance.collection('user').get().then((query){
      query.docs.forEach((element) {
        ListTile(title: Text(element['name']));
      });
    });
  }
}
