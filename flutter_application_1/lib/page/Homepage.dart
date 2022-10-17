import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/people_model.dart';
import 'package:flutter_application_1/service/people_service.dart';
import 'package:flutter_application_1/service/screen/create_people.dart';
import 'package:flutter_application_1/service/screen/daitai_screen.dart';
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/assets/image/22.jpg'),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 200,left: 10),
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
              }, icon: Icon(Icons.add,color: Colors.white,size: 60,)),


            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<List<PeopleModel>>(
        stream: PeopleService().getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              var data = snapshot.data![index];
              return   ListTile(
                onTap: () {
                  Get.to(DetailPeoplePage(people: data));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    data.photo ??
                        'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                  ),
                ),
               title: Text("Name = "+data.name!,style:TextStyle(color: Colors.white,fontSize: 18),),
               subtitle: Text("Gmail = "+data.email!,style:TextStyle(color: Colors.white,fontSize: 18),),
               trailing: Text("Gender"+data.gender!,style:TextStyle(color: Colors.white,fontSize: 18),),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
          );
        },
      ),
            ),
            ],
          ),
        ),
      ),
    
    );
  }
}