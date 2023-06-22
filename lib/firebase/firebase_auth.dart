import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

  void signIn(String email, String password, Function onSuccess, Function(String) onError) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
      ).then((user){
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      onError('Sign-In fall, please try again');
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }
    }
  }

  void signUp(String email, String password, String phone,String name, Function onSuccess, Function(String) onError) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password
      ).then((user){
        _createUser(user.user!.uid, email, password, name, phone, onSuccess, onError);
      });
    }on FirebaseAuthException catch (e) {
      onError('SignUp fall, please try again');
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    }catch(e){
      onError(e.toString());
    }
  }

  _createUser(String uid,String email, String password ,String name, String phone, Function onSuccess,
    Function(String) onError) async{
    var user={
      'name': name, 'email': email, 
      'phone': phone, 'password': password,
      'image': ''
    };
    var ref= FirebaseDatabase.instance.ref().child('user');
    await ref.child(uid).set(user)
      .then((user){
        onSuccess();
      })
      .catchError((err){
        return onError(err.toString());
      });
  }

  _updatePasswordUser(String uid, String newPassword)async{
    DatabaseReference ref = FirebaseDatabase.instance.ref('user');
    await ref.child(uid).update({
      'password': newPassword
    });
  }

  void signOut() async{
    await _firebaseAuth.signOut();
  }
}