import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/home.dart';

final stripePublishableKey =
    'pk_test_51LW3BZSBstzmOfTLzxem3nWWfU03IkSr6qW9DPmOSgFerI8Q2gtAeRaPFxb2wVYO943oGwHgad7E6pGqCw2xbzD3007gHBmysi';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  runApp(MaterialApp(
    title: "Stripe Payment",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
