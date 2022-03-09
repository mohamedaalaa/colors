

import 'dart:convert';


import 'package:corlors/model/colosModel.dart';
import 'package:corlors/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';


class ApiProvider{


    Future<void> saveDataToApi(String firstColor,String secondColor,String thirdColor,String fourthColor,BuildContext context)async {
     //if we assumed we have api we will use http package to post data to api
    await  Future.delayed(const Duration(seconds: 2),(){
        print("$firstColor  $secondColor  $thirdColor  $fourthColor");
      });
    showSnackBar(context, "data loaded successfully to api", 1);
    }

  }



