import 'dart:convert';

import 'package:ecommerce_firebase/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:http/http.dart' as http; 
import 'package:flutter_dotenv/flutter_dotenv.dart';


Map<String, dynamic>? paymentIntent; 

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': ((int.parse(amount)) * 100).toString(),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    var secretKey = dotenv.env["STRIPE_SECRET_KEY"];
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    print('Payment Intent Body: ${response.body.toString()}');
    return jsonDecode(response.body.toString());
  } catch (err) {
    print('Error charging user: ${err.toString()}');
  }
}

Future<bool> displayPaymentSheet(BuildContext context) async {
  try {
    // "Display payment sheet";
    await Stripe.instance.presentPaymentSheet();
    // Show when payment is done
    // Displaying snackbar for it
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text("Paid successfully")),
    // );
    paymentIntent = null;
    return true;
  } on StripeException catch (e) {
    // If any error comes during payment
    // so payment will be cancelled
    print('Error: $e');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: alertColor,
        duration: const Duration(milliseconds: 2500),
        content: const Text(
          'Payment cancelled',
          textAlign: TextAlign.center,
        ),
      ),
    );
    return false;
  } catch (e) {
    print("Error in displaying");
    print('$e');
    return false;
  }
}

Future<bool> makePayment(BuildContext context, String grandTotal) async {
  try {
    // Create payment intent data
    paymentIntent = await createPaymentIntent(grandTotal, 'MYR');
    // initialise the payment sheet setup
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Client secret key from payment data
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        googlePay: const PaymentSheetGooglePay(
            // Currency and country code is accourding to India
            testEnv: true,
            currencyCode: "MYR",
            merchantCountryCode: "MY"),
        // Merchant Name
        merchantDisplayName: 'MushMagic',
        // return URl if you want to add
        // returnURL: 'flutterstripe://redirect',
      ),
    );
    // Display payment sheet
    return displayPaymentSheet(context);
  } catch (e) {
    print("exception $e");

    if (e is StripeConfigException) {
      print("Stripe exception ${e.message}");
    } else {
      print("exception $e");
    }

    return false;
  }
}
