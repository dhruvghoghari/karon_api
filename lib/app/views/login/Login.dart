import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/logincontroller.dart';
import 'package:karon_api/widgets/apptheme.dart';
import 'package:karon_api/widgets/widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: SafeArea(
        child: Form(
          key: loginController.loginKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: loginController.userName,
                keyboardType: TextInputType.text,
                hintText: "Enter User Name",
                iconData: Icons.person,
                obscureText: false,
               // validator: nameValidation,
              ),
              Obx(() {
                return CustomTextFormField(
                  controller: loginController.userPassword,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Enter Password",
                  iconData: Icons.lock,
                  obscureText: loginController.passwordVisible.value,
                 // validator: passwordValidation,
                );
              }),
              SubmitButton(
                title: "Submit",
                  onPressed: () async{
                  loginController.login(
                        loginController.userName.text,
                        loginController.password.text)!.then((json){
                      if(json['status']==true){
                        AppTheme.getSnackBar(message: json['message'].toString());
                        log(json["message"].toString());
                      }
                      else
                      {
                        AppTheme.getSnackBar(message: json['message']);
                        log(json["message"].toString());
                      }
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}