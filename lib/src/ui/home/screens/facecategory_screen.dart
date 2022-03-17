import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/icons_constant.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:cosmo_beauty/src/ui/home/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/favourite_provider.dart';
import '../widgets/custom_alignment.dart';
import '../widgets/showMessage.dart';
import 'detail_screen.dart';

class FaceCategoryScreen extends StatefulWidget{
  final String value ;

  const FaceCategoryScreen({Key? key, required this.value}) : super(key: key);

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
    print(widget.value);
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
        var name = CategoryModel.fromSnapshot(product).productName.toLowerCase();
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
    var data = await FirebaseFirestore.instance.collection(widget.value).get();

    setState(() {
      _allResults =  data.docs;
    });
    print(_allResults);
    searchResultsList();
    return "complete";

  }



  @override
  Widget build(BuildContext context) {
    FavouriteProvider favProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(icon: const Icon(iconArrow,color: black), onPressed: () {
          Navigator.pop(context);
        },
        ),
       ),
      body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _searchField(),
                  GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                                              Align(alignment: Alignment.topRight,child: IconButton(
                                                  onPressed: () {
                                                    favProvider.addFavouriteData(image: data[paramImage], productName: data[paramProductName], productPrice: data[paramProductPrice]);
                                                    showMessage(wishlistMessage);
                                                  }, icon: Icon(iconWishlist)

                                              )),
                                              Expanded(child: Image(image: NetworkImage(data[paramImage]),height: 100.0,width: 100.0,)),
                                              SizedBox(height: 10.0),
                                              CustomAlignmnet(Alignment.bottomLeft, Text(data[paramProductName],style: kTextBlackBoldStyle,)),
                                              SizedBox(height: 10.0),
                                              CustomAlignmnet(Alignment.bottomLeft, Text('\$ ${data[paramProductPrice]}',style: kTextGreyBigBoldStyle,))
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
                ],
              ),
            ),
            ),
    );
  }
  _searchField() => Container(
    width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(color: grey.withOpacity(0.2), blurRadius: 8.0),
        ],
      borderRadius: BorderRadius.circular(29),
    ),
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        icon: Icon(Icons.search,color: black),
        hintText: 'Search Here',
        border: InputBorder.none,
      ),
    ),
  );
}
