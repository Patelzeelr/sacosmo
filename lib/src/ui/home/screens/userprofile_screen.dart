import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/change_password_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/login_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/address_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';
import '../../auth/model/firebase_service.dart';

class UserProfileScreen extends StatefulWidget{

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoURL!),
                  radius: 60,
                ),
                SizedBox(height: 10.0),
                Text(user!.displayName!,style: kTextBoldBigStyle),
                SizedBox(height: 10.0),
                Text(user!.email!,style: kTextGreyBoldStyle),
                SizedBox(height: 20.0),
                ListView(
                  shrinkWrap: true,
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          leading: Icon(Icons.location_on_rounded,color: lightGray),
                          title: Text('My Address'),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios,color: lightGray),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AddressScreen()
                              ));
                            }
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle,color: lightGray),
                          title: Text('Account'),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios,color: lightGray),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddressScreen()
                                ));
                              }
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications,color: lightGray),
                          title: Text('Notification'),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios,color: lightGray),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddressScreen()
                                ));
                              }
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.vpn_key,color: lightGray),
                          title: Text('Password'),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios,color: lightGray),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ChangePassword()
                                ));
                              }
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.message,color: lightGray),
                          title: Text('Language'),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios,color: lightGray),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddressScreen()
                                ));
                              }
                          ),
                        ),
                      ]
                  ).toList(),
                ),
                Center(
                  child: BlackButton('LOGOUT', () async{
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

    );
  }
}