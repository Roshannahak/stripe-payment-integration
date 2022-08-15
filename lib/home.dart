import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Stripe Payment"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: 100,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              makePayment();
            },
            child: Text("PAY"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
          ),
        ),
      ),
    );
  }

  void makePayment() async {
    Map<String, dynamic> paymentIntentData =
        await createPaymentIntent(amount: "50");
    print(paymentIntentData);
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.light,
          merchantDisplayName: "roshan",
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          googlePay: PaymentSheetGooglePay(merchantCountryCode: "us")),
    );

    //display payment sheet
    await Stripe.instance.presentPaymentSheet();
  }

  createPaymentIntent({required String amount}) async {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': "USD",
      'payment_method_types[]': "card"
    };

    try {
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LW3BZSBstzmOfTL8N9hZAoRsWMC8e9nqGcP8monpbNYUh1LGUqWbXErBEkG3Cx1Cm9NlS34fEffkZhUtgsg9Ght0074rB9VIc',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print("error no 456: $e");
    }
    return null;
  }
}
