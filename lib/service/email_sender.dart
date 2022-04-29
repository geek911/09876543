import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_donor/database.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {
  static Future<void> sendNotifications() async {
    var emails = await Database.getAllEmails();

    var username = 'bobsbony925@gmail.com';
    String password = 'futronic';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    // final message = Message()
    //   ..from = Address(username, 'Your name')
    //   ..recipients.add('destination@example.com')
    //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //   ..bccRecipients.add(Address('bccAddress@example.com'))
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    // try {
    //   final sendReport = await send(message, smtpServer);
    //   print('Message sent: ' + sendReport.toString());
    // } on MailerException catch (e) {
    //   print('Message not sent.');
    //   for (var p in e.problems) {
    //     print('Problem: ${p.code}: ${p.msg}');
    //   }
    // }
    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    final equivalentMessage = Message()
      ..from = Address(username, 'Food Donor Bot 😀')
      ..recipients.addAll(emails)
      ..subject = 'New Donation Listing :: 😀 :: ${DateTime.now()}'
      ..text = 'A new donation was posted please login to checkout';

    try {
      final sendReport2 = await send(equivalentMessage, smtpServer);

      // Sending multiple messages with the same connection
      //
      // Create a smtp client that will persist the connection
      var connection = PersistentConnection(smtpServer);

      // Send the first message
      await connection.send(equivalentMessage);

      // send the equivalent message
      await connection.send(equivalentMessage);

      // close the connection
      await connection.close();
    } catch (e) {}
  }
}
