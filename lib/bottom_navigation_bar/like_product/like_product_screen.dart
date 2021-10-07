import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LikeProductScreen extends StatefulWidget {
  const LikeProductScreen({Key? key}) : super(key: key);

  @override
  _LikeProductScreenState createState() => _LikeProductScreenState();
}

class _LikeProductScreenState extends State<LikeProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Favorite',
          style:
              GoogleFonts.cabin(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('favorite')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: size.height * 0.14,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: size.height * 0.13,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data.docs[index]['image']),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                snapshot.data.docs[index]['name'].toString().substring(0,10),
                                style: GoogleFonts.cabin(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),

                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                snapshot.data.docs[index]['price'].toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('favorite').doc(snapshot.data.docs[index].id).delete();
                          },
                        ),
                      ],
                    ),
                  );
                });
          }else{
            return const Center(
              child:CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }
}
