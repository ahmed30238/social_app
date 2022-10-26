import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  void Function(String value)? onSubmitted,
  required TextEditingController? controller,
  required String text,
  required String? Function(String? v)? validate,
  required IconData? prefix,
  IconData? suffix,
  required bool? isPass,
  TextInputType? keyType,
  int? maxLines,
  // TextAlign? textAlign,
}) =>
    TextFormField(
      // textAlign: TextAlign.center,
      onFieldSubmitted: onSubmitted,
      validator: validate,
      controller: controller,
      obscureText: isPass!,
      keyboardType: keyType,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffix: Icon(suffix),
        labelText: text,
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder(),
        
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, WARNING, ERROR }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

void navigateAndFinishTo(context, Widget widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateTo(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

PreferredSizeWidget defaultAppBar({
  required String title,
  Widget? leading,
  List<Widget>? actions,
  double? elevation,
}) =>
    AppBar(
      title: Text(
        title,
      ),
      leading: leading,
      actions: actions,
      elevation: elevation,
    );
