import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:new_spaper/diaglog.dart/loading_diaglog.dart';
import 'package:new_spaper/diaglog.dart/msg_diaglog.dart';
import 'package:new_spaper/firebase/firebase_auth.dart';
import 'package:new_spaper/firebase/firebase_store.dart';
import 'package:new_spaper/pages/login.dart';
import 'package:new_spaper/pages/newspaer.dart';
import 'package:new_spaper/widgets/button_page.dart';
import 'package:new_spaper/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _controller= TextEditingController();
  final FireStore _fireStore = FireStore();
  final FireAuth _fireAuth = FireAuth();
  final TextEditingController _nameController= TextEditingController();
  final TextEditingController _passController= TextEditingController();
  final TextEditingController _phoneController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _cnfController= TextEditingController();
  bool isName=true;
  bool isPass=true;
  bool isEmail=true;
  bool isPhone=true;
  bool isCnfPass=true;
  bool isShowPass=false;
  bool isShowPassCnf=false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Image.asset(
                  'assets/logoNewSpaper.png',
                  color: Colors.black,
                  width: 150,
              ),
              const SizedBox(height: 20,),
              const Text(
                 "Sign up Your Account", 
              ),
              const SizedBox(height: 6,),

              const SizedBox(height: 20,),
              TextFieldPage(
                text: 'Name',
                controller: _nameController,
                icon: const Icon(Icons.person_outline, color: Colors.black26,),
                errorText: isName? '' : 'Tên Không Được Để Trống',
              ),

              TextFieldPage(
                text: 'Phone Number',
                controller: _phoneController,
                icon: const Icon(Icons.phone_outlined, color: Colors.black26,),
                errorText: isPhone? '' : 'Số Điện Thoại Trên 9 số',
              ),

              TextFieldPage(
                text: 'Email',
                controller: _emailController,
                icon: const Icon(Icons.mail_outline, color: Colors.black26,),
                errorText: isEmail ? '' : 'Email Phải có @',
              ),

              TextFieldPage(
                controller: _passController,
                text: 'Password',
                obscureText: !isShowPass,
                icon: const Icon(Icons.lock_outlined, color: Colors.black26,),
                errorText: isPass ? '' : 'Password có ít nhất 7 kí tự',
                isSuffixIcon: true,
                onTap: (){
                  setState(() {
                    isShowPass=!isShowPass;
                  });
                },
              ),

              TextFieldPage(
                controller: _cnfController,
                text: 'Confirm Password',
                obscureText: !isShowPassCnf,
                icon: const Icon(Icons.lock_outlined, color: Colors.black26,),
                errorText: isCnfPass ? '' : 'Không Trùng Khớp Với Mật Khẩu',
                isSuffixIcon: true,
                onTap: (){
                  setState(() {
                    isShowPassCnf=!isShowPassCnf;
                  });
                },
              ),
        
              ButtonPage(
                onTap: _onSignUpClicked,
                text: 'Sign up',
                color: Colors.black,
                colortext: Colors.white,
                width: double.maxFinite,
                height: 50,
              ),
              
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LoginPage(),));
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpClicked(){
    if(_nameController.text.isEmpty){
      isName=false;
    }else{
      isName=true;
    }
    if(_passController.text.isEmpty || _passController.text.length<6){
      isPass=false;
    }else{
      isPass=true;
    }
    if(_cnfController.text != _passController.text){
      isCnfPass=false;
    }else{
      isCnfPass=true;
    }
    if(_emailController.text.contains('@') && _emailController.text.length>6){
      isEmail=true;
    }else{
      isEmail=false;
    }
    if(_phoneController.text.isEmpty || _phoneController.text.length<9){
      isPhone=false;
    }else{
      isPhone=true;
    }
    if(isCnfPass && isEmail && isPass && isName && isPhone){
      LoadingDiaglog.showLoadingDialog(context, 'loading...');
      _fireAuth.signUp(
        _emailController.text.toString().trim(), 
        _passController.text.toString().trim(), 
        _passController.text.toString().trim(),
        _nameController.text.toString().trim(), 
        (){
          LoadingDiaglog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) =>const NewSpaperPage(),));
        }, (msg){
          LoadingDiaglog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, 'Error Sign-Up', msg);
        });
    }
  }
}
