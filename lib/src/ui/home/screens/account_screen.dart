import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/textstyle_constant.dart';

class UserAccount extends StatefulWidget{

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  User? user = FirebaseAuth.instance.currentUser;
  String userName = "";
  String imagePath = "";
  late File imageTemp;
  final nameController = TextEditingController();
  File? image;

  Future getCurrentUser() async {
    if (user?.displayName == null || user?.displayName == "") {
      final snapshots = await FirebaseFirestore.instance
          .collection("user")
          .doc(user?.email)
          .get();
      print(snapshots.get("name"));
      setState(() {
        userName = snapshots.get("name");
        imagePath = "";
      });
    } else {
      try {
        if (user != null) {
          userName = user!.displayName!;
          imagePath = user!.photoURL!;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      imageTemp = File(image.path);
      setState(() => this.image = imageTemp as File?);

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("images/"+DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imageTemp);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
        print("res: ${res.ref.getDownloadURL()}");
      });
      print("upload: ${uploadTask}");


    } catch (e) {print(e);}
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black,),onPressed: (){Navigator.pop(context);}),
        title: Text('User Info',style: kTextBoldStyle),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null ? CircleAvatar(
                backgroundImage: FileImage(
                  image!
                ),
                radius: 60,
              ) : CircleAvatar(
                backgroundImage: NetworkImage(imagePath),
                radius: 60,
              ),
              SizedBox(height: 30.0),
              CustomTextField(
                  userName,
                  nameController,
                      (value){
                        value = nameController.text;
                      },
                      (value){
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    return null;
                  },
                  false),
              SizedBox(height: 20.0),
              BlackButton('Update', (){
                updateUser();
              }),
              BlackButton('Pick Image', (){
                pickImage();
              })
            ],
          ),
      ),
    );
  }

  void updateUser() async{
    FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).update({'name': nameController.text, 'image': image});
  }
}
