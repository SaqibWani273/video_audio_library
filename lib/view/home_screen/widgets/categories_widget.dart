// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/device_constraints.dart';
import '../../../repository/data_repo.dart';
import 'categories_detail.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.read<DataRepo>().categories;
    log(categories.toString());
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
                        // playListImgUrl: categories[index].imgUrl,
                        // playListName: categories[index].nameInEnglish,
                        // playListNameInArabic: categories[index].nameInArabic,
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
                          child: Image.network(
                            categories[index].imgUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Spacer(),
                    Text(
                      categories[index].nameInEnglish,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Expanded(
                      child: Text(
                        categories[index].nameInArabic,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
