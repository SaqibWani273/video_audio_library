// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../constants/device_constraints.dart';
import '/constants/other_const.dart';
import 'categories_detail.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
      height: DeviceConstraints.mainBodyHeight,
      width: double.infinity,
      child: GridView.builder(
          primary: true,
          padding: EdgeInsets.only(bottom: 80.0),
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
                padding: EdgeInsets.only(bottom: 16.0),
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
                        playListImgUrl: categories[index].imageUrl,
                        playListName: categories[index].nameInEnglish,
                        playListNameInArabic: categories[index].nameInArabic,
                      );
                    }));
                  },
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          categories[index].imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Spacer(),
                    Text(
                      categories[index].nameInEnglish,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      categories[index].nameInArabic,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ]),
                ),
              ),
            );
          }),
    );
  }
}

final List<Category> categories = [
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
  Category(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
  ),
];

class Category {
  final String nameInEnglish;
  final String nameInArabic;
  final String imageUrl;
  Category({
    required this.nameInEnglish,
    required this.nameInArabic,
    required this.imageUrl,
  });
}
