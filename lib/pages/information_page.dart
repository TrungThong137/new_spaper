import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_spaper/widgets/header.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key, 
    required this.data, 
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: const Icon(Icons.arrow_back, color: Colors.black,)
              ),

              const Header(),
        
              const SizedBox(height: 20,),
        
              Text(
                data['text'],
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
      
              const SizedBox(height: 20,),
      
              Container(
                width: double.maxFinite,
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      data['image'],
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
      
              const SizedBox(height: 20,),
      
              Text(data['discription'])
            ],
          ),
        ),
      ),
    );
  }
}