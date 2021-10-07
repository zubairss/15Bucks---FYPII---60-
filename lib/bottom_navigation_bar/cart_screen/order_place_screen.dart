import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/server_interaction/get_products.dart';
import 'package:flutter/material.dart';

class OrderPlaceScreen extends StatefulWidget {
  final String productUrl;
  final String productName;
  final String image;
  final String price;
  const OrderPlaceScreen(
      {Key? key,
      required this.productName,
      required this.productUrl,
      required this.image,
      required this.price})
      : super(key: key);

  @override
  _OrderPlaceScreenState createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order screen'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Shipping details",
                style: TextStyle(
                    fontSize: size.width * 0.06, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: TextField(
                  controller: _controllerName,
                    decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your name',
                )),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: TextField(
                  controller: _controllerAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Shipping Address',
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              InkWell(
                onTap: () async{
                bool result = await Server().sendOrder({
                    'userName': _controllerName.text,
                    'product': widget.productName,
                    'address': _controllerAddress.text,
                    'productUrl': widget.productUrl,
                    'image': widget.image,
                    'price':widget.price,
                  });
                if(result == true){
                  showSnackBarSuccess(context, 'Order is sent');
                  Navigator.pop(context);

                }else{
                  showSnackBarFailed(context, 'Something is wrong');
                }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05, vertical: size.height * 0.2),
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.red),
                  child: Text(
                    'Send order',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.04),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
