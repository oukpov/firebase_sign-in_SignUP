import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/people_model.dart';
import 'package:flutter_application_1/service/people_service.dart';
import 'package:flutter_application_1/wigets/dailo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class DetailPeoplePage extends StatefulWidget {
  const DetailPeoplePage({Key? key, required this.people}) : super(key: key);
  final PeopleModel people;

  @override
  State<DetailPeoplePage> createState() => _DetailPeoplePageState();
}

class _DetailPeoplePageState extends State<DetailPeoplePage> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController name;
  late TextEditingController gender;
  late TextEditingController email;

  Future<void> _onImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        imageQuality: 100,
      );
      setState(() => imageFile = pickedFile);
    } catch (e) {
      debugPrint('Image Picker error => $e');
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _onImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _onImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.people.name);
    gender = TextEditingController(text: widget.people.gender);
    email = TextEditingController(text: widget.people.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create People'),
        actions: [
          IconButton(
            onPressed: () async {
              DailogWidget.showLoading(context);
              await Future.delayed(const Duration(seconds: 2));
              if (imageFile == null) {
                var peopleModel = PeopleModel(
                  id: widget.people.id,
                  name: name.text,
                  gender: gender.text,
                  email: email.text,
                  photo: widget.people.photo,
                );
                await PeopleService().updatePeople(peopleModel);
              } else {
                String? photoUrl = await PeopleService()
                    .uploadAndDownloadPhoto(File(imageFile!.path));
                var peopleModel = PeopleModel(
                  id: widget.people.id,
                  name: name.text,
                  gender: gender.text,
                  email: email.text,
                  photo: photoUrl,
                );
                await PeopleService().updatePeople(peopleModel);
              }
              Get.back();
              Get.back();
            },
            icon: const Icon(Icons.done),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0, color: Colors.grey),
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageFile != null
                          ? Image.file(File(imageFile!.path)).image
                          : NetworkImage(
                              widget.people.photo ??
                                  'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: gender,
                decoration: const InputDecoration(
                  hintText: 'Gender',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 26.0),
              ElevatedButton.icon(
                onPressed: () {
                  PeopleService().deletePeople(widget.people.id!);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}