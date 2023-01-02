import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _paymentMethod;
  bool? _payNow;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Payment method
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment method',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioListTile(
                  title: Text('Credit card'),
                  value: 'credit_card',
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Debit card'),
                  value: 'debit_card',
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text('PayPal'),
                  value: 'paypal',
                  groupValue: _paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _paymentMethod = value.toString();
                    });
                  },
                ),
              ],
            ),
          ),
          // Pay now or pay later
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pay now or pay later',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioListTile(
                  title: Text('Pay now'),
                  value: true,
                  groupValue: _payNow,
                  onChanged: (value) {
                    setState(() {
                      _payNow = value as bool;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Pay later'),
                  value: false,
                  groupValue: _payNow,
                  onChanged: (value) {
                    setState(() {
                      _payNow = value as bool;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
  padding: const EdgeInsets.all(8.0),
  child: RaisedButton(
    onPressed: () {
      // Confirm payment
      if (_paymentMethod == null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please select a payment method'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Payment successful
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Payment successful'),
              content: Text('Thank you for your payment'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    },
    child: Text(
      'Confirm',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    color: Theme.of(context).primaryColor,
  ),
)

                
        ]);}}