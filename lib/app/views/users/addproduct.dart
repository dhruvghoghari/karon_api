import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/productcontroller.dart';
import 'package:karon_api/app/views/homepage.dart';
import 'package:karon_api/app/views/productcategory.dart';
import 'package:karon_api/widgets/apptheme.dart';

import '../../../widgets/widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AddProduct"),),
      body: SafeArea(
        child: Form(
          key: productController.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: productController.standardController,
                  keyboardType: TextInputType.number,
                  hintText: "standard_discount",
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: productController.executiveController,
                  keyboardType: TextInputType.number,
                  hintText: "executive_discount",
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: productController.managerController,
                  keyboardType: TextInputType.number,
                  hintText: "manager_discount",
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: productController.projectController,
                  keyboardType: TextInputType.number,
                  hintText: "project_discount",
                  obscureText: false,
                ),
                CustomTextFormField(
                  controller: productController.specialController,
                  keyboardType: TextInputType.number,
                  hintText: "special_discount",
                  obscureText: false,
                ),
                SubmitButton(
                    title: "submit",
                onPressed: (){
                      productController.addProduct(
                        executive_discount: productController.executiveController.text,
                        manager_discount:productController.managerController.text,
                        project_discount: productController.projectController.text,
                        special_discount: productController.specialController.text,
                        standard_discount: productController.standardController.text)!.then((json){
                          if(json['status']==true){
                            AppTheme.getSnackBar(message: json["message"]);
                            Get.offAll(() => HomePage());
                          }
                          else{
                            AppTheme.getSnackBar(message: json["message"]);
                          }
                      });
                },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}