import 'package:flutter/material.dart';
import 'package:new_spaper/base/base_widget.dart';
import 'package:new_spaper/firebase/firebase_store.dart';
import 'package:new_spaper/models/newspaper.dart';
import 'package:new_spaper/models/user.dart';
import 'package:new_spaper/pages/home/home_viewmodel.dart';
import 'package:new_spaper/pages/newspaer.dart';
import 'package:new_spaper/pages/newspaper_detail/newspaper_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  HomeViewModel? _viewmodel;
  
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _buildHome(),
        );
      },
      viewModel: HomeViewModel(),
      onViewModelReady: (viewModel) {
        _viewmodel=viewModel!..init();
      },
    );
  }

  Widget _buildHome(){
    return SafeArea(
      child: StreamBuilder<List<NewSpaper>>(
        stream: FireStore.readNewSpaper(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                NewSpaper spaper = snapshot.data![index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NewSpaperDetailsScreen(id: spaper.id),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                            child: Image.network(
                              spaper.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          spaper.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return const CircularProgressIndicator();
          }
        },
      )
    );
  }
}