
import 'package:flutter/material.dart';
import 'package:new_spaper/base/base_widget.dart';
import 'package:new_spaper/models/newspaper.dart';
import 'package:new_spaper/pages/newspaper_detail/newspaper_detail_viewmodel.dart';

class NewSpaperDetailsScreen extends StatefulWidget {
  const NewSpaperDetailsScreen({
    super.key,
    required this.id
  });

  final String id;

  @override
  State<NewSpaperDetailsScreen> createState() => _NewSpaperDetailsScreenState();
}

class _NewSpaperDetailsScreenState extends State<NewSpaperDetailsScreen> {

  DetailsNewSpaperViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: _buildDetailsScreen(),
        );
      }, 
      viewModel: DetailsNewSpaperViewModel(),
      onViewModelReady: (viewModel) {
        _viewModel= viewModel!..init();
      },
    );
  }

  Widget _buildDetailsScreen(){
    return SafeArea(
      child: StreamBuilder<List<NewSpaper>>(
        stream: _viewModel!.readDetailsNewSpaperViewModel(widget.id),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                NewSpaper spaper= snapshot.data![index];
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

                    Text(
                      spaper.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 5),
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.network(
                          spaper.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 50),
                      child: Text(
                        spaper.discription,
                        style: const TextStyle(
                          height: 1.4,
                        ),
                      ),
                    )
                    
                  ],
                );
              },
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}