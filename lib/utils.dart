import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

enum CustomDateFormat {
  DD_MMM_YYYY,
  DD_MMM_YYYY_HH_MM_AM,
  DD_MM_YYYY_SLASH,
  MM_DD_YYYY_SLASH,
  DATETIME24,
  UNIX,
  hh_MM_A,
}

class Utils {
  static String generateMd5({required String input}) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static dynamic changeDateFormat(
      {required var dateTime, required CustomDateFormat customDateFormat}) {
    String format = 'dd/MM/yyyy';
    if (customDateFormat == CustomDateFormat.DATETIME24) {
      format = 'dd/MM/yyyy hh:MMa';
    } else if (customDateFormat == CustomDateFormat.DD_MMM_YYYY) {
      format = 'dd MMM ,yyyy';
    } else if (customDateFormat == CustomDateFormat.DD_MM_YYYY_SLASH) {
      format = 'dd/MM/yyyy';
    } else if (customDateFormat == CustomDateFormat.MM_DD_YYYY_SLASH) {
      format = 'MM/dd/yyyy';
    } else if (customDateFormat == CustomDateFormat.DD_MMM_YYYY_HH_MM_AM) {
      format = 'dd MMM,yyyy hh:MMa';
    } else if (customDateFormat == CustomDateFormat.hh_MM_A) {
      format = 'hh:mma';
    } else if (customDateFormat == CustomDateFormat.UNIX) {
      return new DateTime.now().millisecondsSinceEpoch;
    }

    // var now = new DateTime.now();

    var formatter = new DateFormat(format);
    if (dateTime is String) dateTime = DateTime.parse(dateTime);

    return formatter.format(dateTime);
  }

  static dynamic getCurrentDateTime({CustomDateFormat? customDateFormat}) {
    String format = 'dd/MM/yyyy';
    if (customDateFormat == CustomDateFormat.DATETIME24) {
      format = 'dd/MM/yyyy hh:MMa';
    } else if (customDateFormat == CustomDateFormat.DD_MMM_YYYY) {
      format = 'dd MMM ,yyyy';
    } else if (customDateFormat == CustomDateFormat.DD_MM_YYYY_SLASH) {
      format = 'dd/MM/yyyy';
    } else if (customDateFormat == CustomDateFormat.MM_DD_YYYY_SLASH) {
      format = 'MM/dd/yyyy';
    } else if (customDateFormat == CustomDateFormat.DD_MMM_YYYY_HH_MM_AM) {
      format = 'dd MMM,yyyy hh:MMa';
    } else if (customDateFormat == CustomDateFormat.hh_MM_A) {
      format = 'hh:mma';
    } else if (customDateFormat == CustomDateFormat.UNIX) {
      return new DateTime.now().millisecondsSinceEpoch;
    }

    var now = new DateTime.now();
    var formatter = new DateFormat(format);
    return formatter.format(now);
  }

  static String getUUID() {
    String uuid = Uuid().v4(options: {
      'mSecs': DateTime.now().millisecondsSinceEpoch,
      'nSecs': Random().nextInt(10),
      'grng': UuidUtil.cryptoRNG
    });

    return uuid;
  }


  static int getRandomNumber({required int len}) {
    var randomNo = "";
    for (var i = 0; i < len; i++) {
      randomNo = randomNo + Random.secure().nextInt(9).toString();
    }

    try {
      return int.parse(randomNo);
    } catch (e) {
      throw ('Max length can be 19');
    }
  }

  static String getRandString(
      {required int len,
      bool needDigits = false,
      bool needSpecialChar = true,
      bool needHex = false}) {
    if (needHex) needSpecialChar = false;

    var random = Random.secure();
    late var _chars;
    if (needSpecialChar)
      _chars =
          '!~@#\$%^&*()+_{}":?><,/\;AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    else if (needHex)
      _chars = '1234567890ABCDEF';
    else if (needDigits)
      _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    else
      _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';

    return List.generate(len, (index) => _chars[random.nextInt(_chars.length)])
        .join();
  }

  static String makeFirstLetterCaps({required String string}) =>
      string[0].toUpperCase() + string.substring(1);

  static String coolNumber(int num) {
    return NumberFormat.compact().format(num);
  }

  static String makeMp3Slug(String title) {
    return title.replaceAll(' ', '-') + '.mp3';
  }

  static Future<bool> hasInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  static String getStringInitials({required String string, int? limitTo}) {
    if (!string.contains(' ')) {
      return string.substring(0, 1);
    } else {
      var buffer = StringBuffer();
      var split = string.split(' ');

      for (var i = 0; i < (limitTo ?? split.length); i++) {
        buffer.write(split[i][0]);
      }

      return buffer.toString();
    }
  }

  static String sha1Converter({required String answer}) {
    answer = answer.toLowerCase().replaceAll(new RegExp(r"[^a-z0-9]"), "");
    var bytes = utf8.encode(answer); // data being hashed
    Digest digest = sha1.convert(bytes);
    return digest.toString();
  }

  static String formatBytes({required int bytes, required int decimals}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static bool validateEmail({required email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String timeAgoSinceDate(
      {required String dateString, bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static Future<bool> checkAndRequestPermission(Permission permission) {
    Completer<bool> completer = new Completer<bool>();
    permission.request().then((status) {
      if (status != PermissionStatus.granted) {
        permission.request().then((_status) {
          bool granted = _status == PermissionStatus.granted;
          completer.complete(granted);
        });
      } else {
        Fluttertoast.showToast(msg: 'Permission Already Granter');

        completer.complete(true);
      }
    });
    return completer.future;
  }
}
