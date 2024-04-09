import 'package:final_ecommerce/constants/theme.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/firebase_options/firebase_option.dart';
import 'package:final_ecommerce/screens/auth_ui/welcome/welcome.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          }
          return const Welcome();
        }
      ),
    );
  }
}
