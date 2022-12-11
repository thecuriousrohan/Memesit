import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newemesit/login.dart';
import 'package:newemesit/register.dart';





class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);




  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:
      AppBar(
        foregroundColor: Colors.white,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Memesit"),
        elevation: 00,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(

            children: [
              Center(
                child: Container(
                  color: Colors.white,
                  height: 400,
                  width: 420,
                ),

              ),
              Center(
                child:
                Container(
                  color: Colors.black12,
                  height: 400,
                  width: 420,),
              ),
              Center(
                child: Container(
                  color: Colors.brown,
                  height: 400,
                  width: 420,
                ),

              ),
              InkWell(




                child: Center(

                  child:
                  Container(
                    color: Colors.white,

                    height: 400,
                    width: 420,),
                ),
              )


              /*Center(
                  child: Container(
                    color: Colors.green,
                    height: 400,
                    width: 420,)
              ),*/
            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: Container(
          color: Colors.grey,
          child: ListView(
            children:[
              DrawerHeader (
                  padding: EdgeInsets.zero,
                  child:UserAccountsDrawerHeader(
                    accountName: Text("name",textScaleFactor: 2,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    accountEmail: Text("@email.com",textScaleFactor: 1.2,
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    currentAccountPicture: ListTile(
                      leading: Icon(
                        CupertinoIcons.profile_circled,
                        size: 39,
                        color: Colors.white,
                      ),
                    ),
                    /* CircleAvatar(
                        backgroundColor: Colors.white,
                      ) */
                  )
              ),
              ListTile(
                  leading:InkWell(
                      onLongPress: (){
                        print("icon");
                      },
                      onTap:() {
                        print("home taped");

                      },
                      child:
                      Icon(CupertinoIcons.house,
                        color: Colors.white,
                        size: 30,)) ,
                  title:
                  InkWell(
                    onTap:() {
                      print("home taped");
                    },
                    child: Text("Home",
                      textScaleFactor: 1.8,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  )
              ),
              ListTile(
                  leading:InkWell(
                      onLongPress: (){
                        print("icon");
                      },
                      onTap: () {
                        Navigator.pushNamed(context, 'home');
                      },
                      child:
                      Icon(CupertinoIcons.person_add,
                        color: Colors.white,
                        size: 30,)) ,
                  title:
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text("Creat Account",
                      textScaleFactor: 1.8,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  )
              ),

              ListTile(
                  leading:Icon(CupertinoIcons.flame, color: Colors.white,size: 30,) ,
                  title:
                  Text("Memers",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              ListTile(
                  leading:Icon(CupertinoIcons.film, color: Colors.white,size: 30,) ,
                  title:
                  Text("Trending Meme",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),

              ListTile(
                  leading:Icon(CupertinoIcons.bell, color: Colors.white,size: 30,) ,
                  title:
                  Text("Notifications",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              ListTile(
                  leading:Icon(CupertinoIcons.person_2_alt, color: Colors.white,size: 30,) ,
                  title:
                  Text("follows",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              ListTile(
                  leading:Icon(CupertinoIcons.square_arrow_down, color: Colors.white,size: 30,) ,
                  title:
                  Text("Saved Memes",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
              ),
              ListTile(
                  leading:Icon(CupertinoIcons.gear, color: Colors.white,size: 30,) ,
                  title:
                  Text("Settings",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),
              ListTile(
                  leading:Icon(CupertinoIcons.power, color: Colors.white,size: 30,) ,
                  title:
                  Text("Logout",
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              ),

            ],
          ),

        ) ,
      ),


      //This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}







