import 'package:flutter/material.dart';
import 'package:new_spaper/test_provider/counter.dart';
import 'package:new_spaper/test_provider/setting_provider.dart';
import 'package:provider/provider.dart';

class UserProvider extends StatefulWidget {
  const UserProvider({super.key});

  @override
  State<UserProvider> createState() => _UserProviderState();
}

class _UserProviderState extends State<UserProvider> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => 
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // watch theo doi su thay doi 
                context.watch<CounterProvider>().counter.toString(),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
              ),
    
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const SecondScreen()));
                }, 
                child: const Text('Go to Next Page')
              )
            ],
          ),
        ),
    
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read<CounterProvider>().add();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CounterProvider, SettingProvider>(
      builder: (context, conterProvider, settingProvider, child) => 
        Scaffold(
          appBar: AppBar(
            actions: [
              Switch(
                // value: context.watch<SettingProvider>().isDark,
                value: settingProvider.isDark, 
                onChanged: (value) {
                  settingProvider.setBrightness(value);
                  // Provider.of<SettingProvider>(context, listen: false).setBrightness(value);
                },
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // watch theo doi su thay doi 
                  // context.watch<CounterProvider>().counter.toString(),
                  'number ${conterProvider.counter}',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
                ),

                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Go to back Home')
                )
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: (){
              // context.read<CounterProvider>().add();
              conterProvider.add();
            },
            child: const Icon(Icons.add),
          ),
        ),
    );
  }
}