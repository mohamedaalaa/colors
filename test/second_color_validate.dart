import 'package:corlors/widgets/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){



  test('second color returns error string', (){
    var result=SecondColorValidator.validate("");
    expect(result, "value can't be less than 4 chars");
  });
}