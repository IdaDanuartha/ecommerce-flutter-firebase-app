import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendToGmail(String title, String status, String orderCode, String totalPrice, UserProvider userProvider, BuildContext context) async {
  var username = dotenv.env["GMAIL_USERNAME"];
  var password = dotenv.env["GMAIL_PASSWORD"];

  final smtpServer = gmail(username!, password!);

  final message = Message()
    ..from = Address(username, 'MushMagic')
    ..recipients.addAll([
      ...userProvider.admins.map((admin) => admin.email),
      ...userProvider.staff.map((staff) => staff.email),
    ])
    // ..ccRecipients.addAll(['example@gmail.com', 'example2@gmail.com'])
    // ..bccRecipients.add(Address('example3@gmail.com'))
    ..subject = title
    ..html =
        "Order $status with code #$orderCode with a total price of \$$totalPrice";
  // ..text = 'This is the plain text.\nThis is line 2 of the text part.';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

void sendMessageToCustomer(String title, String status, String orderCode, String email, BuildContext context) async {
  var username = dotenv.env["GMAIL_USERNAME"];
  var password = dotenv.env["GMAIL_PASSWORD"];

  final smtpServer = gmail(username!, password!);

  final message = Message()
    ..from = Address(username, 'MushMagic')
    ..recipients.add(email)
    ..subject = title
    ..html =
        "Your order with code $orderCode has arrived";
  // ..text = 'This is the plain text.\nThis is line 2 of the text part.';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}