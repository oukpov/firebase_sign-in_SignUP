import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_page.dart';
import 'package:flutter_application_1/page/Homepage.dart';
import 'package:flutter_application_1/page/Loging_page.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
           if(snapshot.connectionState == ConnectionState.waiting){
            // if email and password right can join
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Something went wrong'),);
          }else if(snapshot.hasData){
            return HomePage();
          }else{
            return LoginPage();
          }
        },
      ),
    );
  }
}