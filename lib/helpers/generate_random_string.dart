import 'dart:math';

import 'package:intl/intl.dart';

String generateRandomString({int len = 10, bool isUpperCase = true}) {
  var r = Random();
  String generate = String.fromCharCodes(List.generate(len, (index) => r.nextInt(25) + 65));

  return isUpperCase ? generate.toUpperCase() : generate.toLowerCase();
}

String generateWithFormat({bool isUpperCase = true}) {
  var r = Random();
  String generate = "${String.fromCharCodes(List.generate(2, (index) => r.nextInt(25) + 65))}-${DateFormat("ddMMyyHms").format(DateTime.now())}";

  return isUpperCase ? generate.toUpperCase() : generate.toLowerCase();
}