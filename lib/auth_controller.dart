import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newemesit/login.dart';
import 'package:newemesit/screen/home.dart';

class AuthController extends GetxController{
  static final AuthController instance = Get.find();
  //email ,password , name
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void  OnReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());

  }

     _initialScreen(User? user){
    if(user==null) {
      print("login page");
      Get.offAll(()=>MyLogin());
    }else{
      Get.offAll(()=>MyHomePage());
    }
  }
}