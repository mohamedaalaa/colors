

import 'package:corlors/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("second color test", (WidgetTester tester)async{
    final secondColor=find.byKey(const ValueKey("secondColorKey"));

    await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));
    await tester.enterText(secondColor, "second color test");
    await tester.pump();


    expect(find.text("second color test"), findsOneWidget);
  });
}