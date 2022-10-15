



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page/Register_page.dart';


class LoginPage extends StatefulWidget {
 // final VoidCallback onClickedSignUp;
  const LoginPage({Key? key,}) : super(key: key);
//required this.onClickedSignUp
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final navigatorkey = GlobalKey<NavigatorState>();
  // Controller 
  final email_controller = TextEditingController();
  final passwork_controller = TextEditingController();

  Future Signin() async{
    // 1 showDailog

    showDialog(context: context,
    barrierDismissible: false,
    builder:(context) => Center(child: CircularProgressIndicator(),),
     );

    // 2 showDialog 
   
    // showDialog(context: context, builder: (context) => SimpleDialog(
    //   title: const Text('FaceBook'),
    //   contentPadding: const EdgeInsets.all(20),
    //   children: [
    //     Text('Please Enter Email and Password'),
    //     TextButton(onPressed: (){
    //       Navigator.of(context).pop();
    //     }, child: Text('Close'))
    //   ],
    // ),);

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email_controller.text.trim(), 
      password: passwork_controller.text.trim()
      );
    }on FirebaseAuthException catch(e){
      print(e);
    }
    // 3 await when loging
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
  @override
   void dispose(){
    email_controller.dispose();
    passwork_controller.dispose();
    super.dispose();
   }
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
                  // color: Colors.red
                   image: DecorationImage(image: AssetImage('lib/assets/image/1.jpg'),fit: BoxFit.cover)
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
                            hintText: 'Email'
                          ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
            const  SizedBox(height: 50,),
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
                            hintText: 'Password'
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
                onTap: () {      
              Signin();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Loging"),
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
                  //  widget.onClickedSignUp;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Registerpage();
                  },));
                 },
                child: Text('Register now',style: TextStyle(color: Color.fromARGB(255, 131, 255, 59),fontSize: 18),),
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