


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(context,String data,int time){
  return ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(data),duration: Duration(seconds: time),));
}

class SecondColorValidator{
  static String? validate(String value){
    return value.length<4 ? "value can't be less than 4 chars" : null;
  }
}
