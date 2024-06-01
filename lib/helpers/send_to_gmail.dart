import 'package:MushMagic/providers/staff_provider.dart';
import 'package:MushMagic/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendToGmail(String title, String mailMessage, UserProvider userProvider, StaffProvider staffProvider, String? customerEmail, BuildContext context) async {
  var username = dotenv.env["GMAIL_USERNAME"];
  var password = dotenv.env["GMAIL_PASSWORD"];

  final smtpServer = gmail(username!, password!);

  final message = Message()
    ..from = Address(username, 'MushMagic')
    ..recipients.addAll([
      ...userProvider.admins.map((admin) => admin.email),
      ...staffProvider.staff.map((staff) => staff.email),
      customerEmail
    ])
    // ..ccRecipients.addAll(['example@gmail.com', 'example2@gmail.com'])
    // ..bccRecipients.add(Address('example3@gmail.com'))
    ..subject = title
    ..html = mailMessage;
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

void sendMessageAfterSignUp(String title, String mailMessage, String email, BuildContext context) async {
  var username = dotenv.env["GMAIL_USERNAME"];
  var password = dotenv.env["GMAIL_PASSWORD"];

  final smtpServer = gmail(username!, password!);

  final message = Message()
    ..from = Address(username, 'MushMagic')
    ..recipients.add(email)
    ..subject = title
    ..html = mailMessage;

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