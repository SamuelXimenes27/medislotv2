import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/data.dart';

class PaymentPage extends StatefulWidget {
  final PaymentCheckoutModel checkout;
  const PaymentPage({
    Key? key,
    required this.checkout,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController _con;
  PaymentCheckoutModel get _checkout => widget.checkout;

  String setHTML(String id, String session) {
    return ('''
    <html>
      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://cdn.easypay.pt/checkout/2.2.0/"></script>
        
      </head>
      
        <body style="background-color:#fff;height:100vh ">

        <body>
        <center>
        <button id="easypay-checkout">Pay with easypay</button>

        </center>
        </body>


          <script>
           document.addEventListener('DOMContentLoaded', function () {
            start();
            setTimeout(function() {document.getElementById('easypay-checkout').click();}, 1000);            
            });

            function onCancelPost(){
              Print.postMessage('cancel');
            }

            function onComplete(){
              Print.postMessage('complete');
            }

          function start() {
              var manifest = {
                  "id": "$id",
                  "session": "$session",
                  "config": null
              };

              easypayCheckout.startCheckout(manifest, {
                    display: 'popup',
                    onSuccess: onComplete,
                    onClose: onCancelPost,
                    testing: true,
              });
          }

         
          </script>
        </body>
      </html>
      

    ''');
  }

  _loadHTML() async {
    _con.loadUrl(Uri.dataFromString(setHTML(_checkout.id, _checkout.session),
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  // ignore: prefer_collection_literals
                  javascriptChannels: Set.from([
                    JavascriptChannel(
                        name: 'Print',
                        onMessageReceived: (JavascriptMessage message) {
                          if (message.message == 'complete') {
                            Navigator.pop(context, true);
                          } else {
                            Navigator.pop(context, false);
                          }
                        })
                  ]),
                  onWebViewCreated: (WebViewController webViewController) {
                    // _controller.complete(webViewController);
                    _con = webViewController;
                    _loadHTML();
                  },

                  gestureNavigationEnabled: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
