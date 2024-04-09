// ignore_for_file: use_build_context_synchronously

import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/routes.dart';
import 'package:final_ecommerce/firebase_helper/firebase_auth_helper/firebasse_auth_helper.dart';
import 'package:final_ecommerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:final_ecommerce/widgets/primary_button/primary_button.dart';
import 'package:final_ecommerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [                                                          
            TopTitles(subtitle: "Welcome Back To Ecommerce App ", title: "Login"),

            SizedBox(
              height: 12.0,
            ),

            TextFormField(
              decoration:  InputDecoration(
                hintText: "E-mail", // cmt trong border 
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
              ),
            ), // ô nhập login
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
            obscureText: isShowPassword, // bật chế độ bảo mật cho nhập mật khẩu
              decoration:  InputDecoration(
                hintText: "Password", // cmt trong border 
                prefixIcon: Icon(
                  Icons.password_sharp,
                ),
                suffixIcon: CupertinoButton(
                  onPressed: (){
                    setState(() {
                      isShowPassword = !isShowPassword;       
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.visibility,
                  color: Colors.grey,
                  )),// tạo mắt trong password
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
               bool isVaildated =  loginVaildation(email.text, password.text);
               if(isVaildated){
                bool isLogined = await FirebaseAuthHelper.instance
                   .login(email.text, password.text, context);
                  if(isLogined){
                     Routes.instance.pushAndRemoveUntil(
                      widget: const Home(), context: context);
                   }
               }
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            Center(child: Text("Don't have an account?")),
            SizedBox(
              height: 12.0,
            ),
            CupertinoButton(
              onPressed: (){
                Routes.instance.push(widget: SignUp(), context: context);
              }, 
              child: Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}