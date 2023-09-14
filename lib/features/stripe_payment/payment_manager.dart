import 'package:dio/dio.dart';
import 'package:ecommerce/features/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/* TODO: NOTE
خد بالك لازم تعرف الpublish key في ال main زي دي كده
Stripe.publishableKey=StripeApiKeys.publishableKey;
runApp(const EcommerceApp());
 */



abstract class PaymentManager{


  // first step
  static Future<void>makePayment(int amount,String currency)async {
    try {
      String clientSecret=await _getClientSecret((amount*100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
    // forth step to show payment sheet
      await Stripe.instance.presentPaymentSheet();

    }on Exception catch(error){

      throw Exception(error.toString());

    }

  }
// third step بمرر الكلاينت سيكريت كي الي البايمنت شيت
  static Future<void>_initializePaymentSheet(String clientSecret)async{
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: "Marwan Ali",
    ),);
  }
//second step to get client secret key
 static Future<String> _getClientSecret(String amount,String currency)async{
    Dio dio=Dio();
   var response= await dio.post('https://api.stripe.com/v1/payment_intents',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${StripeApiKeys.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  }
}