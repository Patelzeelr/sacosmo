import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/ui/home/model/product_model.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/favourite_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../provider/favourite_provider.dart';
import '../widgets/custom_alignment.dart';
import '../widgets/showMessage.dart';
import 'detail_screen.dart';

class FaceCategoryScreen extends StatefulWidget{

  @override
  State<FaceCategoryScreen> createState() => _FaceCategoryScreenState();
}

class _FaceCategoryScreenState extends State<FaceCategoryScreen> {
  final searchController = TextEditingController();

  late Future resultLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = getProductDetail();
  }

  onSearchChanged() {
    searchResultsList();
    print(searchController.text);
  }

  searchResultsList() {

    var showResults = [];
    if(searchController.text != "") {
      for(var product in _allResults){
        var name = ProductModel.fromSnapshot(product).productName.toLowerCase();
        if(name.contains(searchController.text.toLowerCase())) {
          showResults.add(product);
        }
      }
    } else{
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getProductDetail() async{
    var data = await FirebaseFirestore.instance.collection('arrivalItem').get();

    setState(() {
      _allResults =  data.docs;
    });
    searchResultsList();
    return "complete";

  }

  final Stream<QuerySnapshot> popularItems = FirebaseFirestore.instance.collection('arrivalItem').snapshots();

  @override
  Widget build(BuildContext context) {
    FavouriteProvider favProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: black), onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search,color: black)
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 0,
                  mainAxisExtent: 240,
                  childAspectRatio: 1
              ),
              itemCount: _resultsList.length,
              itemBuilder: (context, i) {
                final data = _resultsList[i];
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
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
            ),
        )
    );
  }
}
