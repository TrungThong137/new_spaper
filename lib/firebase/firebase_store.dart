import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_spaper/firebase/util.dart';
import 'package:new_spaper/models/newspaper.dart';
import 'package:new_spaper/models/user.dart';
import 'package:new_spaper/pages/newspaer.dart';

class FireStore{
  final userRef = FirebaseFirestore.instance.collection('user').withConverter<User>(
      fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.tojson(),
    );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createNewSpaper(String title, String imageNetword, String discription) async{
    final docNewSpaper= FirebaseFirestore.instance.collection('newspaper').doc();
    final newSpaper = NewSpaper(
      id: docNewSpaper.id,
      image: imageNetword, title: title, discription: discription).toJsonNewSpaper();
    await docNewSpaper.set(newSpaper);
  }

  

  Future createUser(String name, String email, String password, String phone) async{
    final docUser = firestore.collection('user').doc();
    final user=User(
      email: email, name: name, 
      phone: phone, password: password,
      id: docUser.id,
      image: ''
    ).tojson();
    await docUser.set(user);
  }

  static Stream<List<NewSpaper>> readNewSpaper() =>
    FirebaseFirestore.instance.collection('newspaper').snapshots()
      .transform(Util.tranformer((NewSpaper.fromJsonNewSpaper)));

  static Stream<List<NewSpaper>> readNewSpaperDetails(String id) =>
    FirebaseFirestore.instance.collection('newspaper')
      .where('id', isEqualTo: id).snapshots().transform(Util.tranformer((NewSpaper.fromJsonNewSpaper)));

  static Stream<List<User>> readUsers()=>
     FirebaseFirestore.instance.collection('user')
      .snapshots().transform(Util.tranformer((User.fromJson)));

  static Stream<List<User>> readUserDetails(String id) =>
    FirebaseFirestore.instance.collection('user')
      .where('id', isEqualTo: id.trim())
      .snapshots()
      .transform(Util.tranformer((User.fromJson)));
  
  

  Future<User?> readDataUser()async{
    final docUser = firestore.collection('user').doc();
    final snapshot= await docUser.get();

    if(snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  void updateUser(String docId, String image){
    final docUser= firestore.collection('user');
    docUser
      .doc(docId)
      .update({
        // 'name': user.name,
        // 'phone': user.phone,
        // 'password': user.password,
        // 'email': user.email,
        'image': image
      });
  }

  void deletedUser(String id)async{
    final docUser= firestore.collection('user').doc(id);
    await docUser.delete();
  }
}
