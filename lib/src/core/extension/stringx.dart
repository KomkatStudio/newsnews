import 'package:intl/intl.dart';

extension StringX on String {
  String get convertToMMddyyy {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM-dd-yyyy');
    return outputFormat.format(inputDate);
  }

  String get convertToDateTime {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM-dd-yyyy hh:mm');
    return outputFormat.format(inputDate);
  }

  String get toUppercaseFirstLetter {
    return this[0].toUpperCase() + substring(1, length);
  }
  // String getImageUrlOfSource(){
  //   switch(this){
  //     case "Reuters":
  //   case"ESPN":
  //   case"CNN":
  //   case"Hollywood Reporter":
  //   case"CBS News":
  //   case"The Verge":
  //   case"CBS Sports":
  //   case"The Hill":
  //   case"KCRA Sacramento":
  //   case"Sports Illustrated":
  //   case"Associated Press":

  //   case"The Washington Post":

  //   case"Vulture":

  //   case"NBC New York":

  //   case"BBC News":
  //   case"Yahoo Entertainment":
  //   case"Daily Mail":
  //   case"The Wall Street Journal":
  //   case"WMTW Portland":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":
  //   // case"Sports Illustrated":

  //   }
  // }
}
