import 'package:intl/intl.dart';

extension DataTimeX on DateTime {
  String get formatISOTime {
    //converts date into the following format:
// or 2019-06-04T12:08:56.235
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(this);
  }

  String get getTimeAgo {
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

