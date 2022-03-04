import 'package:cosmo_beauty/src/ui/auth/screens/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/body.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  // You have to call it on your starting screen
  SizeConfig().init(context);
  return Scaffold(
    body: Body(),
  );
}
}