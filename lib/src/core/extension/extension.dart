import 'package:intl/intl.dart';

extension DataTimeX on DateTime {
  String formatISOTime() {
    //converts date into the following format:
// or 2019-06-04T12:08:56.235
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(this);
  }

  String getTimeAgo() {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(this);

    if ((difference.inDays / 7).floor() > 1) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() == 1) {
      return '1 week ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '${difference.inHours} hour ago';
    } else if (difference.inSeconds > 1) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inSeconds == 1) {
      return '${difference.inSeconds} second ago';
    } else {
      return 'Just now';
    }
  }
}

extension StringX on String {
  String convertToMMddyyy() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM-dd-yyyy');
    return outputFormat.format(inputDate);
  }

  String convertToDateTime() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM-dd-yyyy hh:mm');
    return outputFormat.format(inputDate);
  }

  String toUppercaseFirstLetter() {
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
