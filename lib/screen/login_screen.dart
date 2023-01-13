// import 'dart:js';
//import 'dart:ui';
import 'package:newemesit/provider/internet_provider.dart';
import 'package:newemesit/provider/sign_in_provider.dart';
import 'package:newemesit/screen/home_screen.dart';
import 'package:newemesit/utils/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newemesit/utils/next_screen.dart';


//import 'package:connectivity_plus/connectivity_plus.dart';



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}): super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _scaffoldKey = GlobalKey <ScaffoldState>();
  final RoundedLoadingButtonController googleController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,


                        children: [

                          RoundedLoadingButton(
                            controller: googleController,
                            successColor: Colors.green,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.80,
                            elevation: 0,
                            onPressed: () {
                              handleGoogleSignIn();
                            },
                            borderRadius: 25,
                            child: Wrap
                              (
                              children: const [
                                Icon(
                                  FontAwesomeIcons.google,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Sign in With Google",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500

                                  ),
                                )

                              ],
                            ),
                            color: Colors.red,

                          ),


                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),);
  }

  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    }
    else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        }
        else {

         sp.checkUserExists().then((value) async{
           if(value == true){

           }
           else {
             sp.checkUserExists().then((value) =>sp.
             saveDataToSharedPreferences().then((value) =>
             sp.setSignIn().then((value)
             {
               googleController.success();
               handleAfterSignIn(); })));

           }



         }


         );
        }

      });
    }
  }

 // Handle after sign in
handleAfterSignIn() {
   Future.delayed(const Duration(milliseconds: 1000)).then((value) {
     nextScreenReplace(context,const HomeScreen());

   }
   );
}


}
