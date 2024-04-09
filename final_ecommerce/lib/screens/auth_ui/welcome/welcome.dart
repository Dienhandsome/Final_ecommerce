import 'package:final_ecommerce/constants/asset_images.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/screens/auth_ui/login/login.dart';
import 'package:final_ecommerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(subtitle: "Buy AnyItems From App", title:"Welcome"),
            Center(
              child: Image.asset(
              AssetImages.instance.welcomeImage
              ),
            ),

             const SizedBox(
              height: 12,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                 child: const Icon( Icons.facebook,
                             color: Colors.blue,
                             size: 35,
                             ),
               ),
            const SizedBox(width: 3.0,),
            CupertinoButton(
              onPressed: () {},
              child: Image.asset(
                AssetImages.instance.googleImage,
                scale: 28.0,
                ),
            ),
            ],
          ), 
          PrimaryButton(title: "Login", onPressed: (){
            Routes.instance.push(widget:  Login(),context:  context);
          },),
          const SizedBox(
           height: 17.0,
          ),
          PrimaryButton(
            title: "Sign Up",
            onPressed: (){
               Routes.instance.push(widget: const SignUp(), context: context);
            },
            ),
          ],
        ),
      ),
    );
  }
}