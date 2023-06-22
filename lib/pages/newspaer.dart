import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_spaper/pages/information_page.dart';
import 'package:new_spaper/pages/login.dart';
import 'package:new_spaper/pages/register.dart';
import 'package:new_spaper/widgets/button_page.dart';
import 'package:new_spaper/widgets/header.dart';
import 'package:new_spaper/widgets/text_field.dart';

class NewSpaperPage extends StatefulWidget {
  const NewSpaperPage({super.key});

  @override
  State<NewSpaperPage> createState() => _NewSpaperPageState();
}

class _NewSpaperPageState extends State<NewSpaperPage> {

  final TextEditingController _imageController=TextEditingController();
  final TextEditingController _lableController=TextEditingController();
  final TextEditingController _idController= TextEditingController();
  final TextEditingController _discriptionController= TextEditingController();


  Future<void> _addNewspaper() async{
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20, 
            bottom: MediaQuery.of(context).viewInsets.bottom+20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldPage(
                  text: 'Image', 
                  icon: const Icon(Icons.image), 
                  controller: _imageController
                ),
          
                TextFieldPage(
                  text: 'Lable', 
                  icon: const Icon(Icons.abc), 
                  controller: _lableController
                ),

                TextFieldPage(
                  controller: _discriptionController,
                  text: 'discription',
                  icon: const Icon(Icons.abc, color: Colors.black26,),
                  isMaxline: true,
                ),
          
                const SizedBox(height: 40,),
          
                ButtonPage(
                  text: 'Add', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: ()async{
                    final newSpaper= FirebaseFirestore.instance.collection('newspaper').doc();
                    await newSpaper.set({
                      'id': newSpaper.id,
                      'image': _imageController.text,
                      'text': _lableController.text
                    });
                    _imageController.text='';
                    _lableController.text='';
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateNewspaper() async{
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom+20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldPage(
                  text: 'IdUpdate', 
                  icon: const Icon(Icons.abc), 
                  controller: _idController
                ),
          
                const SizedBox(height: 40,),
          
                ButtonPage(
                  text: 'Next Update', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: (){
                    FirebaseFirestore.instance.collection('newspaper').doc(_idController.text)
                      .get()
                      .then((doc){
                        if(doc.exists){
                          _update(doc.data());
                        }
                      });
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _update(documentSnapshot) async{
    if(documentSnapshot!=null){
      _imageController.text= documentSnapshot['image'];
      _lableController.text= documentSnapshot['text'];
      _discriptionController.text=documentSnapshot['text'];
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
                  controller: _lableController,
                  text: 'Lable',
                  icon: const Icon(Icons.lock_outlined, color: Colors.black26,),
                  
                ),
          
                TextFieldPage(
                  controller: _imageController,
                  text: 'image',
                  icon: const Icon(Icons.image, color: Colors.black26,),
                ),

                TextFieldPage(
                  controller: _discriptionController,
                  text: 'discription',
                  icon: const Icon(Icons.abc, color: Colors.black26,),
                  isMaxline: true,
                ),
          
                const SizedBox(height: 20,),
                ButtonPage(
                  text: 'Update', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: () async{
                    await FirebaseFirestore.instance.collection('newspaper')
                        .doc(documentSnapshot['id'])
                        .update({
                          'text': _lableController.text,
                          'image': _imageController.text,
                          'discription': _discriptionController.text
                        });
                    _lableController.text='';
                    _imageController.text='';
                    _discriptionController.text='';
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteNewspaper() async{
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom+20
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldPage(
                  text: 'IdUpdate', 
                  icon: const Icon(Icons.abc), 
                  controller: _idController
                ),
          
                const SizedBox(height: 40,),
          
                ButtonPage(
                  text: 'Deleted', 
                  color: Colors.amber, 
                  colortext: Colors.white, 
                  onTap: ()async{
                    final newSpaper= FirebaseFirestore.instance.collection('newspaper');
                    if(_idController.text.isEmpty ){
                      return ;
                    }else {
                      await newSpaper
                        .doc(_idController.text).get().then((doc) {
                          if(doc.exists){
                            newSpaper.doc(doc['id']).delete();
                          }
                        });
                      _idController.text='';
                    }
                  }
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Stack(
          children:[
            Column(
              children: [
                const Header(),
                const SizedBox(height: 20,),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('newspaper').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState ==ConnectionState.waiting){
                      return const Center(child: Text('waiting'));
                    }else if(snapshot.hasData){
                      return Expanded(
                        flex: 1,
                        child: ListView(
                          children: snapshot.data!.docs.map((doc){
                            final data = doc.data();
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => InformationPage(data: data),));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20, left: 10),
                                child: ListTile(
                                  leading: Image.network(data['image']),
                                  title: Text(data['text']),
                                ),
                              ),
                            );
                          }
                          ).toList(),
                        ),
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
                
                
              ],
            ),

            Positioned(
              bottom: 10,
              left: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _deleteNewspaper,
                    child: const Icon(Icons.delete),
                  ),

                  const SizedBox(width: 20,),
                  
                  ElevatedButton(
                    onPressed: _addNewspaper,
                    child: const Icon(Icons.add),
                  ),

                  const SizedBox(width: 20,),

                  
                  ElevatedButton(
                    onPressed: _updateNewspaper,
                    child: const Icon(Icons.edit),
                  ),
                ],
              ),
            )
          ] 
        ),
      ),
    );
  }
}