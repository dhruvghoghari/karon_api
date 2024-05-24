import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color.dart';


class CustomTextFormField extends StatelessWidget {
  //final String? fieldName;
  final GestureTapCallback? onClick;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final IconData iconData;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    //this.fieldName,
    this.onClick,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.iconData,
    required this.obscureText,
    this.validator,
    this.maxLength,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: GestureDetector(
          onTap: onClick ?? () {},
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(iconData),
              prefixIconColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? Color(0xFF1B4C76)
                  : Colors.grey),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 10,
                borderSide: BorderSide(
                  color: validator != null ? Colors.red : borderColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gapPadding: 10,
                borderSide: BorderSide(color: borderColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                gapPadding: 10,
                borderSide: BorderSide(color: borderColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: appColor, width: 2),
              ),
              counterText: "",
            ),
            validator: validator,
            maxLength: maxLength,
          ),
        )
    );
  }
}


class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const SubmitButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 50,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 1)
      ]),
      child:ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          child: Text(title,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          )),
    );
  }
}