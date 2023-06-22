import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_spaper/firebase/firebase_store.dart';
import 'package:new_spaper/models/user.dart';
import 'package:new_spaper/pages/home/home_viewmodel.dart';
import 'package:new_spaper/widgets/button_page.dart';
import 'package:new_spaper/widgets/text_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FireStore _fireStore = FireStore();
  final TextEditingController _imageController= TextEditingController();
  final TextEditingController _nameController= TextEditingController();
  final TextEditingController _passController= TextEditingController();
  final TextEditingController _phoneController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();
  bool isShow=false;

  Future<void> _update(documentSnapshot) async{
    if(documentSnapshot!=null){
      _nameController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];
      _phoneController.text = documentSnapshot['phone'];
      _passController.text = documentSnapshot['password'];
      _imageController.text= documentSnapshot['image'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom+20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldPage(
                  text: 'Name',
                  controller: _nameController,
                  icon: const Icon(Icons.person_outline, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  text: 'Phone Number',
                  controller: _phoneController,
                  icon: const Icon(Icons.phone_outlined, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  text: 'Email',
                  controller: _emailController,
                  icon: const Icon(Icons.mail_outline, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  controller: _passController,
                  text: 'Password',
                  isSuffixIcon: true,
                  obscureText: !isShow,
                  onTap: () {
                    setState(() {
                      isShow=!isShow;
                    });
                  },
                  icon: const Icon(Icons.lock_outlined, color: Colors.black26,),
                  
                ),
          
                TextFieldPage(
                  controller: _imageController,
                  text: 'image',
                  icon: const Icon(Icons.image, color: Colors.black26,),
                ),
          
                const SizedBox(height: 20,),
                ButtonPage(
                  text: 'Update', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: () async{
                    final String name= _nameController.text;
                    final String email= _emailController.text;
                    final String phone= _phoneController.text;
                    final String pass= _passController.text;
                    final String image= _imageController.text;
          
                    await FirebaseFirestore.instance.collection('user')
                        .doc(documentSnapshot['id'])
                        .update({
                          'name': name, 'email': email,
                          'phone': phone, 'password': pass,
                          'image': image
                        });
                    _nameController.text='';
                    _emailController.text='';
                    _phoneController.text='';
                    _passController.text='';
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

   Future<void> _addUser() async{
    
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom+20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldPage(
                  text: 'Name',
                  controller: _nameController,
                  icon: const Icon(Icons.person_outline, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  text: 'Phone Number',
                  controller: _phoneController,
                  icon: const Icon(Icons.phone_outlined, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  text: 'Email',
                  controller: _emailController,
                  icon: const Icon(Icons.mail_outline, color: Colors.black26,),
                ),
          
                TextFieldPage(
                  controller: _passController,
                  text: 'Password',
                  isSuffixIcon: true,
                  obscureText: !isShow,
                  onTap: () {
                    setState(() {
                      isShow=!isShow;
                    });
                  },
                  icon: const Icon(Icons.lock_outlined, color: Colors.black26,),
                  
                ),
          
                TextFieldPage(
                  controller: _imageController,
                  text: 'image',
                  icon: const Icon(Icons.image, color: Colors.black26,),
                ),
          
                const SizedBox(height: 20,),
                ButtonPage(
                  text: 'Add', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: () async{
                    final String name= _nameController.text;
                    final String email= _emailController.text;
                    final String phone= _phoneController.text;
                    final String pass= _passController.text;
                    final String image= _imageController.text;
          
                    final user=FirebaseFirestore.instance.collection('user').doc();
                      user
                        .set({
                          'id': user.id,
                          'name': name, 'email': email,
                          'phone': phone, 'password': pass,
                          'image': image
                        });
                    _nameController.text='';
                    _emailController.text='';
                    _phoneController.text='';
                    _passController.text='';
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleted(String userId) async{
    await FirebaseFirestore.instance.collection('user').doc(userId)
      .delete();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully deleted a user'))
    );
  }

  PlatformFile? pickFiles;

  // chon file anh
  Future _selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState(() {
      pickFiles = result.files.first;
    });
  }

  HomeViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Loading"));
                  }else if(snapshot.hasData){
                    return SizedBox(
                      height: 500,
                      child: ListView(
                        children: snapshot.data!.docs.map((doc){ 
                          final data=doc.data();
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.network(data['image']??'https://img.freepik.com/free-vector/glitch-error-404-page-background_23-2148090410.jpg?w=2000'),
                              ),
                              title: Text(data['name']),
                              subtitle: Text(data['phone']),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => _update(data), 
                                      icon: const Icon(Icons.edit)
                                    ),

                                    IconButton(
                                      onPressed: () => _deleted(data['id']), 
                                      icon: const Icon(Icons.delete)
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    );
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),

              IconButton(
                onPressed: ()async{
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);

                },
                icon: Icon(Icons.camera)
              ),

              if(pickFiles != null)
                Expanded(
                  child: Container(
                    color: Colors.blue[100],
                    child: Image.file(File(pickFiles!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
              
              ElevatedButton(
                onPressed: _addUser, 
                child: const Text('add')
              ),

              //  ElevatedButton(
              //   onPressed: _selectFile, 
              //   child: const Text('Select File')
              // ),

              //  ElevatedButton(
              //   onPressed: _uploadFile, 
              //   child: const Text('Upload File')
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
    leading: const CircleAvatar(),
    title: Text(user.name),
    subtitle: Text(user.phone),
  );

}

// Expanded(
//   child: ListView(
//     children: snapshot.data!.docs.map((doc){
//       Map<String, dynamic> data=doc.data();
//       return ListTile(
//         title: Text(data['name']??"No name"),
//         subtitle: Text(data['phone']??'not found phone user'),
//       );
//     }).toList(),
//   )
// );