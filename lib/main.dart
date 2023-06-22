import 'package:flutter/material.dart';
import 'package:new_spaper/pages/login.dart';
import 'package:new_spaper/pages/newspaer.dart';
import 'package:new_spaper/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_spaper/test_provider/setting_provider.dart';
import 'package:new_spaper/test_provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home/home_screen.dart';
import 'test_provider/counter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',  
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}

// MultiProvider(
// providers: [
//   ChangeNotifierProvider(
//     create: (_) => SettingProvider()
//   ),
//   ChangeNotifierProvider(create: (_)=> CounterProvider())
// ],
// child: Consumer<SettingProvider>(
//   builder: (context, setting, child)=>
//     MaterialApp(
//     title: 'Flutter Demo',  
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//       brightness: setting.isDark ? Brightness.dark : Brightness.light 
//     ),
//     home: const UserProvider()
//   ),
// ),
// );