

import 'dart:convert';

import 'package:corlors/api_repository/api_provider.dart';

import 'package:corlors/bloc/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorsCubit extends Cubit<ColorsStates>{
  ColorsCubit() : super(InitialState());

  static ColorsCubit get(context)=>BlocProvider.of(context);

  List items=[];
  String color="";
  String errorMessage="";
  String errorValue="";
  String redColor="";
  String value="mohamed";

  List<dynamic> colors=[];
  Future<void> fetchData()async{
    emit(LoadingState());
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    items=data["groupOfColors"]["asyncValidationColors"];
    color=items[0]["color"];
    errorMessage=items[0]["errorMessage"];
    errorValue=items[0]["error"];
    colors=data["groupOfColors"]["autoSuggestionsColors"];
    redColor=data["red"];
    emit(LoadedState());
  }


   List<dynamic> getSuggestions(String query)=>
    colors.where((element) {
      final elementLower=element.toLowerCase();
      final queryLower=query.toLowerCase();
      return elementLower.contains(queryLower);
    }).toList();

  bool checkFirstColor(String query){
    return query=="Bluee"?true:false;
  }

  bool checkThirdColor(String color){
    return colors.contains(color)?true:false;
  }

  Future<void> sendDataToApi(String firstColor,String secondColor,String thirdColor,String fourthColor,BuildContext context)async{
   emit(LoadingData());
   await ApiProvider().saveDataToApi(firstColor, secondColor, thirdColor, fourthColor,context);
   emit(LoadedData());
  }




}