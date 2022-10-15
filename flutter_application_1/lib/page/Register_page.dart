
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page/Loging_page.dart';

class Registerpage extends StatefulWidget {
 // final VoidCallback onClickedSignIn;
 const  Registerpage({Key? key,}) : super(key: key);
//required this.onClickedSignIn
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
    // Controller 
  final email_controller = TextEditingController();
  final passwork_controller = TextEditingController();

  void dispose(){
    email_controller.dispose();
    passwork_controller.dispose();
    super.dispose();
   }
   Future signUP() async{ 
     showDialog(context: context,
    barrierDismissible: false,
    builder:(context) => Center(child: CircularProgressIndicator(),),
     );
   try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email_controller.text.trim(),
    password: passwork_controller.text.trim(),
  );
   } on FirebaseAuthException catch (e){
    print(e);
   }
   navigatorkey.currentState!.popUntil((route) => route.isFirst);
   } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top: 0,left: 0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                //  color: Colors.red
                   image: DecorationImage(image: AssetImage('lib/assets/image/2.jpg'),fit: BoxFit.cover)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 300,left: 10),
                      child: Container(
                        height: 45,
                        width: 290,
                       child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextField(
                            controller: email_controller,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email,color: Colors.white,),
                            hintText: 'Enter Email'
                          ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
            const  SizedBox(height: 30,),
                   Padding(
                      padding: const EdgeInsets.only(top: 0,left: 10),
                      child: Container(
                        height: 45,
                        width: 290,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextField(
                            obscureText: true,
                            controller: passwork_controller,
                          decoration: InputDecoration(
                            icon: Icon(Icons.key,color: Colors.white,),
                            hintText: 'Enter Password'
                          ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                     Padding(
                      padding: const EdgeInsets.only(top: 0,left: 10),
                      child: Container(
                        height: 45,
                        width: 290,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextField(
                            obscureText: true,
                            controller: passwork_controller,
                          decoration: InputDecoration(
                            icon: Icon(Icons.key,color: Colors.white,),
                            hintText: 'Enter Password again'
                          ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
           const   SizedBox(height: 30,),
              GestureDetector(
                onTap: signUP,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Register",style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
              ),
              SizedBox(height: 30,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not member ?',style: TextStyle(color: Colors.white,fontSize: 18),),
                SizedBox(width: 30,),
                 GestureDetector(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  },));
                   
                },
                child: Text('Sign In',style: TextStyle(color: Colors.yellow,fontSize: 18),),
              ),
              ],
             ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}