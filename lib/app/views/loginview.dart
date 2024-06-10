import'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/logincontroller.dart';
import 'package:karon_api/app/views/mainpage.dart';
import 'package:karon_api/widgets/apptheme.dart';
import 'package:karon_api/widgets/widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    LoginController loginCon = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key:loginCon.formKey,
              child:Column(
                children: [
                  CustomTextFormField(
                    controller: loginCon.name,
                    keyboardType: TextInputType.text,
                    hintText: 'name',
                    iconData: Icons.person,
                    obscureText: false,
                  ),
                  SizedBox(height: 10.0),
                  CustomTextFormField(
                    controller: loginCon.password,
                    keyboardType: TextInputType.text,
                    hintText: 'Password',
                    iconData: Icons.lock,
                    obscureText: true,),
                  SizedBox(height: 20),
                  SubmitButton(
                      title: 'Login',
                    onPressed: () async{
                        if(loginCon.name.text.isEmpty || loginCon.password.text.isEmpty){
                          AppTheme.getSnackBar(message: "Enter Requiredfilds");
                          return;
                        }
                        else{
                           await loginCon.userLogin(loginCon.name.text.toString(),
                              loginCon.password.text.toString())!.then((json){
                                if(json["status"]==true)
                                  {
                                    AppTheme.getSnackBar(message: json['message']);
                                    log(json["message"].toString());
                                    Get.offAll(() => MainPage());
                                  }
                                else
                                  {
                                    AppTheme.getSnackBar(message: json['message']);
                                    log(json["message"].toString());
                                  }
                          });
                        }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}