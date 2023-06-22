
import 'package:new_spaper/base/base_viewnodel.dart';
import 'package:new_spaper/firebase/firebase_store.dart';

class HomeViewModel extends BaseViewModel{

  init(){

  }

  readNewSpaper() => FireStore.readNewSpaper();
}