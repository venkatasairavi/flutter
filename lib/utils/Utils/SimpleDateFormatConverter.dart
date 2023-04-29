import 'package:intl/intl.dart';

class SimpleDateFormatConverter {
  static const int SECOND_MILLIS = 1000;
  static const int MINUTE_MILLIS = 60 * SECOND_MILLIS;
  static const int HALF_MINUTE_MILLIS = 30 * SECOND_MILLIS;
  static const int TWENTY_FIVE_MINUTE_MILLIS = 25 * SECOND_MILLIS;
  static const int HOUR_MILLIS = 60 * MINUTE_MILLIS;
  static const int DAY_MILLIS = 24 * HOUR_MILLIS;

  static bool isDateAfter(String selectedDate) {
    try {
      final DateTime now = DateTime.now();
      final DateFormat format = DateFormat('yyyy-MM-dd');
      final String currentDate = format.format(now);

      DateTime date1 = DateTime.parse(currentDate);
      DateTime date2 = DateTime.parse(selectedDate);

      if (date2 == date1) {
        return false;
      } else {
        if (date2.difference(date1).inDays > 0) {
          return true;
        } else {
          return false;
        }
      }
    } on Exception catch (e) {
      return false;
    }
  }

  static String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String currentDate = format.format(now);

    return currentDate;
  }

  static bool isTimeAfter(String selectedTime) {
    try {
      final DateTime now = DateTime.now();
      final DateFormat format = DateFormat('h:mm a');
      final String currentTime = format.format(now);

      var start = format.parse(currentTime);
      var end = format.parse(selectedTime);

      print("${start.difference(end)}");

      if (start.isAfter(end)) {
        print('start is big');
        print('difference = ${start.difference(end)}');
        return false;
      } else if (start.isBefore(end)) {
        print('end is big');
        print('difference = ${end.difference(start)}');
        return true;
      } else {
        print('difference = ${end.difference(start)}');
        return true;
      }
    } on Exception catch (e) {
      return false;
    }
  }

  static String? getTimeDiff(appointmentDate, appointmentStartTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    DateTime jsonDateTime =
        (dateFormat.parse(appointmentDate + " " + appointmentStartTime));
    // print("Difference Between " + DateTime.now().toString() + " AND " + jsonDateTime.toString());
    // print(jsonDateTime
    //     .difference(DateTime.now())
    //     .toString());
    List<String> diffSplit =
        (jsonDateTime.difference(DateTime.now()).toString().split(":"));
    //print("startin $diffSplit");

    if (jsonDateTime.difference(DateTime.now()).isNegative == false) {
      if (int.parse(diffSplit[0]) > 0) {
        return "Starts in " +
            diffSplit[0] +
            " hours" +
            ", " +
            diffSplit[1] +
            " mins";
      } else if (int.parse(diffSplit[1]) > 0) {
        return "Starts in " + diffSplit[1] + " mins";
      } else {}
    } else {
      // print("Difference is negative, ...will be ignored");
    }
    return null;
  }

  static String? timeZoneSet(String lastMessageTime) {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final dateUS = DateTime.parse(lastMessageTime).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateUS.toString().substring(0, 16));

    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    if (outputDate.toString().substring(0, 10) == currentDate) {
      outputDate = outputDate.toString().substring(11);
    }

    return outputDate;
  }

  static String? timeZoneSett(String lastMessageTime) {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final dateUS = DateTime.parse(lastMessageTime).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateUS.toString().substring(0, 16));

    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    if (outputDate.toString().substring(0, 10) == currentDate) {
      outputDate = outputDate.toString().substring(11);
    }

    return outputDate;
  }

  static String? getTime(String lastActiveDate) {
    int dateUS = DateTime.parse(lastActiveDate).millisecondsSinceEpoch;

    String? timer = getTimeAgo(dateUS.toDouble());

    return timer;
  }

  static String? getTimeAgo(double time) {
    if (time < 1000000000000) {
      // if timestamp given in seconds, convert to millis
      time *= 1000;
    }

    var now = DateTime.now().millisecondsSinceEpoch;
    if (time > now || time <= 0) {
      return null;
    }

    // TODO: localize
    final double diff = now - time;
    if (diff < MINUTE_MILLIS) {
      return "just now";
    } else if (diff < 2 * MINUTE_MILLIS) {
      return "2 minute ago";
    } else if (diff < 50 * MINUTE_MILLIS) {
      double dif = diff / MINUTE_MILLIS;
      return dif.toString() + " minutes ago";
    } else if (diff < 90 * MINUTE_MILLIS) {
      return "an hour ago";
    } else if (diff < 24 * HOUR_MILLIS) {
      double dif = diff / HOUR_MILLIS;
      return dif.toString() + " hours ago";
    } else if (diff < 48 * HOUR_MILLIS) {
      return "yesterday";
    } else {
      double dif = diff / DAY_MILLIS;
      return dif.toString() + " days ago";
    }
  }

  static String decrementMinutesBy(String time, int min) {
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('h:mm a');
    DateTime end = format.parse(time);
    return DateFormat.jm().format(end.subtract(Duration(minutes: min)));
  }
}
