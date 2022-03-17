import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/favourite_provider.dart';
import '../widgets/custom_alignment.dart';

class BrandViewAllScreen extends StatefulWidget{
final String docKey;

  const BrandViewAllScreen({Key? key, required this.docKey}) : super(key: key);
  @override
  State<BrandViewAllScreen> createState() => _BrandViewAllScreenState();
}

class _BrandViewAllScreenState extends State<BrandViewAllScreen> {

  void showMessage(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {

    FavouriteProvider favProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black), onPressed: () {
          Navigator.pop(context);
        },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(widget.docKey).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 240,
                    childAspectRatio: 1
                ),
                itemCount: snapshot.requireData.size,
                itemBuilder: (context, i) {
                  final data = snapshot.requireData.docs[i];
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DetailScreen(doc: data),
                                ));
                              },
                              child: Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(color: grey.withOpacity(0.2), blurRadius: 8.0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                                      Image(image: NetworkImage(data['image']),height: 100.0,width: 100.0,),
                                      SizedBox(height: 10.0),
                                      CustomAlignmnet(Alignment.bottomLeft, Text(data['productName'],style: kTextBlackBoldStyle,)),
                                      SizedBox(height: 10.0),
                                      CustomAlignmnet(Alignment.bottomLeft, Text('\$ ${data['productPrice']}',style: kTextGreyBoldStyle,))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
            );
          }
        ),
      ),
    );
  }
}