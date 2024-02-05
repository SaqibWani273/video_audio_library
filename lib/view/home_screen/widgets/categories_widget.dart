// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:NUHA/view/common_widgets/network_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/device_constraints.dart';
import '../../../repository/data_repo.dart';
import 'categories_detail.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.read<DataRepo>().categories;

    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
        height: DeviceConstraints.mainBodyHeight,
        width: double.infinity,
        child: GridView.builder(
                primary: true,
                padding: const EdgeInsets.only(bottom: 80.0),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  crossAxisCount: deviceWidth > 1150
                      ? 4
                      : deviceWidth > 900
                          ? 3
                          : 2,
                  childAspectRatio: deviceWidth > 600 ? 0.9 : 3 / 4,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey.shade200,
                      ),
                      // padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoriesDetail(
                              category: categories[index],
                            );
                          }));
                        },
                        child: Column(children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: NetworkImageLoader(
                                          imageUrl: categories[index].imgUrl)
                                      .animate()
                                      .fadeIn(
                                          //delay till both the texts are shown
                                          delay: 1300.ms,
                                          duration: 1000.ms)),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Spacer(),
                          Text(
                            categories[index].nameInEnglish,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                              .animate()
                              .fadeIn(
                                  //delay till grid is shown
                                  delay: 500.ms,
                                  duration: 300.ms,
                                  curve: Curves.easeOut)
                              .scale(
                                begin: const Offset(0.0, 0.0),
                              ),
                          Expanded(
                            child: Text(
                              categories[index].nameInArabic,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  //delay till english text is shown
                                  delay: 1000.ms,
                                  duration: 300.ms,
                                  curve: Curves.easeOut)
                              .scale(
                                begin: const Offset(0.0, 0.0),
                              ),
                        ]),
                      ),
                    ),
                  );
                })
            .animate()
            .slide(
                curve: Curves.easeOut,
                begin: const Offset(0.0, 1.0),
                duration: 500.ms));
  }
}
