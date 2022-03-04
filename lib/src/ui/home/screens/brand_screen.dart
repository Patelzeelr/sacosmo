import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/brandviewall_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/container_list.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_brand_card.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';

class BrandScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width * 100,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage(brandMain),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,color: white),
                  onPressed: () {  },
                ),
              ),
            ),
            Container(
              width: size.width * 100,
              color: silkPink,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         CustomAlignmnet(Alignment.topLeft, const Text(brandLabel,style: kTextWhiteStyle)),
                         CustomAlignmnet(Alignment.topRight, const Icon(Icons.filter_list,color: white))
                       ],
                      ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomAlignmnet(Alignment.topLeft, const Text('Dior',style: kTextWhiteSmallWithBoldStyle)),
                          CustomAlignmnet(Alignment.topLeft, GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const BrandViewAllScreen()
                                ));
                              },
                              child: const Text('View All',style: kTextWhiteSmallStyle)
                          ))
                      ],
                    ),
                    CustomAlignmnet(Alignment.topLeft, const Text('240 popular items',style: kTextWhiteSmallStyle)),
                    ContainerList(CustomBrandCard(),100.0,0.35),
                    _row(),
                    CustomAlignmnet(Alignment.topLeft, const Text('240 popular items',style: kTextWhiteSmallStyle)),
                    ContainerList(CustomBrandCard(),100.0,0.35),
                    _row(),
                    CustomAlignmnet(Alignment.topLeft, const Text('240 popular items',style: kTextWhiteSmallStyle)),
                    ContainerList(CustomBrandCard(),100.0,0.35),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _row() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomAlignmnet(Alignment.topLeft, const Text('Dior',style: kTextWhiteSmallWithBoldStyle)),
      CustomAlignmnet(Alignment.topLeft, const Text('View All',style: kTextWhiteSmallStyle))
    ],
  );
}