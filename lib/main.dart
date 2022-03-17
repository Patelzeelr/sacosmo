import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/provider/address_provider.dart';
import 'package:cosmo_beauty/src/ui/home/provider/cart_provider.dart';
import 'package:cosmo_beauty/src/ui/home/provider/checkout_provider.dart';
import 'package:cosmo_beauty/src/ui/home/provider/favourite_provider.dart';
import 'package:cosmo_beauty/src/ui/welcome/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FavouriteProvider>(
            create: (context) => FavouriteProvider(),
          ),
          ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider()
          ),
          ChangeNotifierProvider<ReviewCartProvider>(
              create: (context) => ReviewCartProvider()
          ),
          ChangeNotifierProvider<CheckoutProvider>(
              create: (context) => CheckoutProvider()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(secondary: pink),
          ),
          home: SplashScreen(),
        ),
    );
  }
}
