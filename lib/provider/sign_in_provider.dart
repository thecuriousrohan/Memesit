import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';







class SignInProvider extends ChangeNotifier{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();



  bool   _isSignedIn = false;
  bool get   isSignedIn => _isSignedIn;

  // hasError , error in code , error in provider ,uid,email ,name.

  bool _hasError = false;
  bool get hasError => _hasError;

 String? _errorCode;
 String? get errorCode => _errorCode;

 String? _provider;
 String? get provider => _provider;

 String? _uid;
 String? get uid => _uid;

 String? _email;
 String? get email => _email;

 String? _name;
 String? get name => _name;

 String? _imageUrl;
 String? get imageUrl => _imageUrl;



 SignInProvider(){
    checkSignInUser();
  }


  Future checkSignInUser() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }
 Future setSignIn() async{
   final SharedPreferences s = await SharedPreferences.getInstance();
   s.setBool("sign_in", true);
   _isSignedIn = true;
   notifyListeners();
 }

  // sign in with google

    Future signInWithGoogle() async{

   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

   if (googleSignInAccount != null) {

     try {
       final GoogleSignInAuthentication googleSignInAuthentication =
                await googleSignInAccount.authentication;
           final AuthCredential credential = GoogleAuthProvider.credential(
             accessToken: googleSignInAuthentication.accessToken,
             idToken: googleSignInAuthentication.idToken,

           );
           // sign in to firebase user instance
       final User userDetails =
       ( await firebaseAuth.signInWithCredential(credential)).user!;


       // now save all the values

       _name = userDetails.displayName;
       _email = userDetails.email;
       _uid = userDetails.uid;
       _imageUrl = userDetails.photoURL;
       _provider = "GOOGLE";

       notifyListeners();


     } on FirebaseAuthException catch (e){
       switch(e.code) {
         case "account-exists-with-different-credentials":
           _errorCode = "ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIALS";
           _hasError = true;
           notifyListeners();
           break;

         case "null":
           _errorCode = "Some unexpected error while trying to sign in";
           _hasError = true;
           notifyListeners();
           break;
           default:
           _errorCode = e.toString();
           _hasError = true;
           notifyListeners();
           break;
       }

     }
     // executing authentication
   } else {
     _hasError = true;
     notifyListeners();
   }
 }

 // Entry for CloudFirestore

  Future getUserDataFromCloudFirestore(uid) async{
   await FirebaseFirestore.instance
       .collection("users")
       .doc(uid)
       .get()
       .then((DocumentSnapshot snapshot) => {
           _uid = snapshot['uid'],
           _name = snapshot['name'],
           _email = snapshot['email'],
           _imageUrl = snapshot['image_url'],
           _provider = snapshot['provider'],

   }
   );
  }

  Future saveDataToFirestore()  async{
   final DocumentReference r =
   await FirebaseFirestore.instance
       .collection("users")
       .doc(uid);
   await r.set({
     "uid": _uid,
     "name": _name,
     "email": _email,
     "image_url": _imageUrl,
     "provider": _provider,

   });
   notifyListeners();}

Future saveDataToSharedPreferences() async{
   final SharedPreferences s = await SharedPreferences.getInstance();
   await s.setString('name', _name!);
  // await s.setString('email', _email!);
   await s.setString('image_url', _imageUrl!);
   await s.setString('uid', _uid!);
   await s.setString('provider', _provider!);

   notifyListeners();
}

 // checkUser exists or not in cloudfirestore
  Future<bool>checkUserExists() async{
   DocumentSnapshot snap =
       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
   if(snap.exists) {
     print("Existing user");
     return true;
   }else{
     print("New user");
     return false;
   }
  }

 // signout

Future userSignOut() async {
   await firebaseAuth.signOut();
   await googleSignIn.signOut();
   _isSignedIn = false;
   notifyListeners();
//clear all Storage information
clearAllData();
}

//checkUser exists or not in cloud firestore


  Future clearAllData() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

}