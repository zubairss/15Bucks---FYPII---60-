import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductViewScreen extends StatefulWidget {
  final String image;
  final String price;
  final String name;
  final String productUrl;
  const ProductViewScreen(
      {Key? key, required this.image, required this.price, required this.name,
      required this.productUrl,
      })
      : super(key: key);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {

  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.image),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon:  Icon(
                          !isChecked?Icons.favorite_border:Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            isChecked = true;
                          });
                          if(isChecked){
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorite').add({
                              'image':widget.image,
                              'price':widget.price,
                              'name':widget.name,
                              'productUrl':widget.productUrl,
                              'quantity':0
                            }).whenComplete((){
                              showSnackBarSuccess(context, 'Added into favorite');
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:size.width*0.9,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.name,
                      style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: size.width * 0.04),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart').add({
                    'image':widget.image,
                    'price':widget.price,
                    'name':widget.name,
                    'productUrl':widget.productUrl,
                    'quantity':0
                  }).whenComplete((){
                    showSnackBarSuccess(context, 'Added to cart');
                    Navigator.pop(context);
                  });
                },
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.red,
                  size: size.width * 0.078,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.6,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.04,
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
