import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/brandviewall_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/container_list.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../widgets/custom_dior.dart';
import '../widgets/custom_kylie.dart';
import '../widgets/custom_rare.dart';

class ScreenBrand extends StatefulWidget {
  @override
  State<ScreenBrand> createState() => _ScreenBrandState();
}

class _ScreenBrandState extends State<ScreenBrand> {
  List<String> _allResult = [diorRes, kylieRes, rareRes];
  List<String> _listKey = [diorKey, kylieKey, rareKey];
  List _list = [CustomDior(), CustomKylie(), CustomRare()];

  List<String> _resultList = [];
  List _resultList2 = [];
  bool _offStage = true;

  void showProductListByBrand({required String value}) {
    List<String> list = [];
    List list2 = [];
    list.clear();
    if (value == diorRes) {
      list.add(value);
      list2.add(CustomDior());
      setState(() {
        _resultList = list;
        _resultList2 = list2;
        _offStage = false;
      });
    } else if (value == rareRes) {
      list.add(value);
      list2.add(CustomRare());
      setState(() {
        _resultList = list;
        _resultList2 = list2;
        _offStage = false;
      });
    } else if (value == kylieRes) {
      list.add(value);
      list2.add(CustomKylie());
      setState(() {
        _resultList = list;
        _resultList2 = list2;
        _offStage = false;
      });
    }
    setState(() {
      _allResult = _resultList;
      _list = _resultList2;
    });
    print(_allResult);
  }

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
                icon: const Icon(Icons.arrow_back_ios, color: white),
                onPressed: () {},
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
                      CustomAlignmnet(Alignment.topLeft,
                          const Text(brandLabel, style: kTextWhiteStyle)),
                      Row(
                        children: [
                          CustomAlignmnet(
                              Alignment.topRight,
                              Offstage(
                                offstage: _offStage,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _offStage = true;
                                    });
                                    setState(() {
                                      _list.clear();
                                      _resultList.clear();
                                      _allResult = [
                                        diorRes,
                                        kylieRes,
                                        rareRes
                                      ];
                                      _list = [
                                        CustomDior(),
                                        CustomKylie(),
                                        CustomRare()
                                      ];
                                    });
                                  },
                                  child: Text(clear,
                                      style: kTextWhiteSmallStyle),
                                ),
                              )),
                          CustomAlignmnet(
                              Alignment.topRight,
                              IconButton(
                                icon: Icon(Icons.filter_list, color: white),
                                onPressed: () async {
                                  await showMenu(
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        100, 200, 0, 100),
                                    items: [
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          showProductListByBrand(value: diorRes);
                                        },
                                        child: const Text(diorRes),
                                        value: diorRes,
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          showProductListByBrand(
                                              value: rareRes);
                                        },
                                        child: const Text(rareRes),
                                        value: rareRes,
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () {
                                          showProductListByBrand(
                                              value: kylieRes);
                                        },
                                        child: const Text(kylieRes),
                                        value: kylieRes,
                                      ),
                                    ],
                                    elevation: 8.0,
                                  );
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _allResult.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomAlignmnet(
                                  Alignment.topRight,
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                     BrandViewAllScreen(docKey: _listKey[i])));
                                      },
                                      child: const Text(view,
                                          style: kTextWhiteSmallStyle)))
                            ],
                          ),
                          CustomAlignmnet(Alignment.topLeft,
                              Text(_allResult[i], style: kTextWhiteSmallStyle)),
                          ContainerList(_list[i], 100.0, 0.35),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
