

class Data {
  Data({
   required this.red,
   required this.groupOfColors,
  });

  String red;
  GroupOfColors groupOfColors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    red: json["red"],
    groupOfColors: GroupOfColors.fromJson(json["groupOfColors"]),
  );

  Map<String, dynamic> toJson() => {
    "red": red,
    "groupOfColors": groupOfColors.toJson(),
  };
}

class GroupOfColors {
  GroupOfColors({
   required this.asyncValidationColors,
    required this.autoSuggestionsColors,
    required this.personalFavoriteColors,
  });

  List<AsyncValidationColor> asyncValidationColors;
  List<String> autoSuggestionsColors;
  PersonalFavoriteColors personalFavoriteColors;

  factory GroupOfColors.fromJson(Map<String, dynamic> json) => GroupOfColors(
    asyncValidationColors: List<AsyncValidationColor>.from(json["asyncValidationColors"].map((x) => AsyncValidationColor.fromJson(x))),
    autoSuggestionsColors: List<String>.from(json["autoSuggestionsColors"].map((x) => x)),
    personalFavoriteColors: PersonalFavoriteColors.fromJson(json["personalFavoriteColors"]),
  );

  Map<String, dynamic> toJson() => {
    "asyncValidationColors": List<dynamic>.from(asyncValidationColors.map((x) => x.toJson())),
    "autoSuggestionsColors": List<dynamic>.from(autoSuggestionsColors.map((x) => x)),
    "personalFavoriteColors": personalFavoriteColors.toJson(),
  };
}

class AsyncValidationColor {
  AsyncValidationColor({
    required this.color,
    required this.error,
    required this.errorMessage,
  });

  String color;
  String error;
  String errorMessage;

  factory AsyncValidationColor.fromJson(Map<String, dynamic> json) => AsyncValidationColor(
    color: json["color"],
    error: json["error"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "error": error,
    "errorMessage": errorMessage,
  };
}

class PersonalFavoriteColors {
  PersonalFavoriteColors({
    required this.addToTheseColors,
  });

  List<AddToTheseColor> addToTheseColors;

  factory PersonalFavoriteColors.fromJson(Map<String, dynamic> json) => PersonalFavoriteColors(
    addToTheseColors: List<AddToTheseColor>.from(json["addToTheseColors"].map((x) => AddToTheseColor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addToTheseColors": List<dynamic>.from(addToTheseColors.map((x) => x.toJson())),
  };
}

class AddToTheseColor {
  AddToTheseColor({
    required this.myFavoriteColor,
    required this.secondFavoriteColor,
  });

  String myFavoriteColor;
  String secondFavoriteColor;

  factory AddToTheseColor.fromJson(Map<String, dynamic> json) => AddToTheseColor(
    myFavoriteColor: json["myFavoriteColor"],
    secondFavoriteColor: json["secondFavoriteColor"],
  );

  Map<String, dynamic> toJson() => {
    "myFavoriteColor": myFavoriteColor,
    "secondFavoriteColor": secondFavoriteColor,
  };
}
