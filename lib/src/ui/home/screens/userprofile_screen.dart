import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/change_password_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/login_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/account_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/address_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/notification_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/icons_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../../auth/model/firebase_service.dart';

class UserProfileScreen extends StatefulWidget{

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  String userName = "";
  String email = "";
  String imagePath = "";

  Future getCurrentUser() async {
    if (user?.displayName == null || user?.displayName == "") {
      final snapshots = await FirebaseFirestore.instance
          .collection("user")
          .doc(user?.email)
          .get();
      print(snapshots.get(paramName));
      setState(() {
        userName = snapshots.get(paramName);
        email = snapshots.get(paramEmail);
        imagePath = "";
      });
    } else {
      try {
        if (user != null) {
          userName = user!.displayName!;
          email = user!.email!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
            child: RefreshIndicator(
              onRefresh: ()async{getCurrentUser();},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imagePath.isEmpty ? CircleAvatar(
                    backgroundImage: AssetImage(appAccLogo),
                    radius: 60,
                  ) :
                  CircleAvatar(
                    backgroundImage: NetworkImage(imagePath),
                    radius: 60,
                  ),
                  SizedBox(height: 10.0),
                  Text(userName,style: kTextBoldBigStyle),
                  SizedBox(height: 10.0),
                  Text(email,style: kTextGreyBoldStyle),
                  SizedBox(height: 20.0),
                  ListView(
                    shrinkWrap: true,
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          ListTile(
                            leading: Icon(iconLocation,color: lightGray),
                            title: Text(address),
                            trailing: IconButton(
                              icon: Icon(iconArrowFor,color: lightGray),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddressScreen()
                                ));
                              }
                            ),
                          ),
                          ListTile(
                            leading: Icon(iconAccount,color: lightGray),
                            title: Text(acc),
                            trailing: IconButton(
                                icon: Icon(iconArrowFor,color: lightGray),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => UserAccount()
                                  ));
                                }
                            ),
                          ),
                          ListTile(
                            leading: Icon(iconNotification,color: lightGray),
                            title: Text(notification),
                            trailing: IconButton(
                                icon: Icon(iconArrowFor,color: lightGray),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => NotificationScreen(),
                                  ));
                                }
                            ),
                          ),
                          ListTile(
                            leading: Icon(iconPassword,color: lightGray),
                            title: Text(changePassword),
                            trailing: IconButton(
                                icon: Icon(iconArrowFor,color: lightGray),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ChangePassword()
                                  ));
                                }
                            ),
                          ),
                          ListTile(
                            leading: Icon(iconLanguage,color: lightGray),
                            title: Text(language),
                            trailing: IconButton(
                                icon: Icon(iconArrowFor,color: lightGray),
                                onPressed: () {}
                            ),
                          ),
                        ]
                    ).toList(),
                  ),
                  Center(
                    child: BlackButton(btnLogout, () async{
                      FirebaseService service = new FirebaseService();
                      try {
                        await service.signOutFromGoogle();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => LoginScreen()
                        ));
                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          print(e.message!);
                        }
                      }
                    }),
                  )
                ],
              ),
            ),
          ),

    );
  }
}