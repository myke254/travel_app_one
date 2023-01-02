import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Mpesa {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri.parse('https://us-central1-phone-login-424b0.cloudfunctions.net'),
          accountReference: "TouristGuide",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "Tourist-Guide",
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      var result = transactionInitialisation as Map<String, dynamic>;

      if (result.keys.contains("ResponseCode")) {
        String mResponseCode = result["ResponseCode"];
        debugPrint("Resulting Code: $mResponseCode");
        if (mResponseCode == '0') {
         // updateAccount(result["CheckoutRequestID"]);
        }
      }
      debugPrint("TRANSACTION RESULT: $transactionInitialisation");

      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/

      //return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful

      debugPrint("CAUGHT EXCEPTION: $e");

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  Future<void> updateAccount(String mCheckoutRequestID) async {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };
    DocumentReference paymentsRef = FirebaseFirestore.instance
        .collection('vs_users')
        .doc(user!.uid)
        .collection('deposit')
        .doc(mCheckoutRequestID);

    await paymentsRef.set(initData);
  }
}
