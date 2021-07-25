import 'package:flutter/material.dart';
import 'package:flutter_all_utils/utils.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Useful Utils'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text('UUID: ${Utils.getUUID()}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child:
                      Text('Random Number: ${Utils.getRandomNumber(len: 19)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'First Letter Cap: ${Utils.makeFirstLetterCaps(string: "flutterfumes")}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Current Date Formatting: ${Utils.getCurrentDateTime(customDateFormat: CustomDateFormat.DATETIME24)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Current Date Formatting: ${Utils.getCurrentDateTime(customDateFormat: CustomDateFormat.DD_MMM_YYYY)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Current Date Formatting: ${Utils.getCurrentDateTime(customDateFormat: CustomDateFormat.DD_MMM_YYYY_HH_MM_AM)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Any Date Formatting: ${Utils.changeDateFormat(dateTime: DateTime.now(), customDateFormat: CustomDateFormat.DD_MMM_YYYY_HH_MM_AM)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Hex Random String: ${Utils.getRandString(len: 10, needHex: true)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Random String with other pattern: ${Utils.getRandString(len: 10, needDigits: true, needSpecialChar: false)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Cool No (with K,M): ${Utils.coolNumber(333338383)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'MD5: ${Utils.generateMd5(input: 'This is flutterfumes.com')}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text('SHA1: ${Utils.sha1Converter(answer: 'test')}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Initials of String(Flutter Fumes): ${Utils.getStringInitials(string: 'Flutter Fumes')}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Mp3 Slug: ${Utils.makeMp3Slug('this is title song')}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Time Ago Since Date: ${Utils.timeAgoSinceDate(dateString: DateTime.now().toString(), numericDates: true)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Format Bytes: ${Utils.formatBytes(bytes: 1500, decimals: 2)}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Validate email (flutterfumes@gmail.com): ${Utils.validateEmail(email: 'flutterfumes@gmail.com')}'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                      'Validate email (flutterfumesgmail.com): ${Utils.validateEmail(email: 'flutterfumesgmail.com')}'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Linkify(
                textScaleFactor: 1,
                text:
                    "Made by https://flutterfumes.com\n\nMail: info@flutterfumes.com",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
