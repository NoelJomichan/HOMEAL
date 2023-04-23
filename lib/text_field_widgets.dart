import 'package:flutter/material.dart';

Widget homealLogoText({required double fontSize, required Color color}){
  return Center(
    child: SizedBox(
      child: Text(
        'Homeal',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ),
  );
}

Widget labelTextInput({required String label, required Color color, required bool isPassword, required Color textColor}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: color,
        style: TextStyle(
          color: textColor,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color),
          )
        ),
      )
    ],
  );
}

Widget loginButton({required Color bgColor, required String btnText, required Color textColor, required BuildContext context, required String routeName, Future<Object?>? Function()? onTap }){
  return Container(
    width: 180.0,
    height: 45.0,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: const [
        BoxShadow(
          blurRadius: 10.0,
          color: Colors.grey,
          offset: Offset(-5, 7)
      ),]
    ),
    child: TextButton(
      onPressed: (){
        if (onTap != null){
          onTap();
        }else {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Text(
        btnText,
        style: TextStyle(
          color: textColor,
          fontSize: 15.0,
        ),
      ),
    ),
  );
}

Widget signUpLabel({required String label, required Color color}){
  return Text(
    label,
    style: TextStyle(
      color: color,
      fontSize: 12,
    ),
  );
}