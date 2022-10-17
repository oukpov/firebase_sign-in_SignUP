import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/screen/create_people.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/assets/image/3.jpg'),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 300,left: 10),
          child: Column(
            children: [
              Center(child: Text('Gmail = '+user.email!,style: TextStyle(color: Colors.white,fontSize: 20),)),
              SizedBox(height: 30,),
              MaterialButton(onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Sign Out',style: TextStyle(color: Colors.white),),
              ),
              
              
              ),
              SizedBox(height: 30,),
              IconButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePeopleScreen(),));
              }, icon: Icon(Icons.add,color: Colors.white,size: 60,))
            ],
          ),
        ),
      ),
    
    );
  }
}