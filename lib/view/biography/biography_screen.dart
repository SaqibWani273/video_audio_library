import 'package:NUHA/view/common_widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NUHA/constants/biography_text.dart';

class BiographyScreen extends StatefulWidget {
  const BiographyScreen({super.key});

  @override
  State<BiographyScreen> createState() => _BiographyScreenState();
}

class _BiographyScreenState extends State<BiographyScreen>
// with SingleTickerProviderStateMixin
{
  // bool isAnimated = false;
  // late AnimationController _controller;
  // late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 2),
    // );
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    // _controller.forward();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     isAnimated = true;
    //   });
    // });
  }

  // @override
  // dispose() {
  //   _controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, index) => [
          const SliverAppBar(
            floating: true,
            title: AppBarWidget(page: "BiographyScreen"),
          )
        ],
        body: ListView(
          primary: true,
          children: [
            SheikhName(
              deviceHeight: deviceHeight,
              deviceWidth: deviceWidth,
              // isAnimated: isAnimated,
            ),
            ...getBiography().entries.map((e) {
              //set height as per the length of the text
              int aspectHeight = e.value.length > 600
                  ? 600
                  : e.value.length > 400
                      ? 400
                      : 200;
              //adjsut for wider screens
              if (deviceWidth > 950) {
                aspectHeight = e.value.length > 600
                    ? 350
                    : e.value.length > 400
                        ? 250
                        : 150;
              }

              return AspectRatio(
                aspectRatio: deviceWidth / aspectHeight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Stack(children: [
                    // AnimatedPositioned(
                    //   // left: isAnimated ? 20 : -50,
                    //   duration: const Duration(milliseconds: 300),
                    //   curve: Curves.bounceOut,
                    //   child:
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        e.key.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    // ),
                    Positioned(
                      top: 50,
                      child:
                          // FadeTransition(
                          //   opacity: _animation,
                          //   child:
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 50.0),
                              width: deviceWidth,
                              child: Text(
                                e.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontFamily:
                                            GoogleFonts.aBeeZee().fontFamily),
                              )),
                      // ),
                    ),
                  ]),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class SheikhName extends StatelessWidget {
  const SheikhName({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    // required this.isAnimated,
  });

  final double deviceHeight;
  final double deviceWidth;
  // final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.3,
      child: Stack(children: [
        Positioned(
            top: 0,
            child: Container(
              height: deviceHeight * 0.3,
              width: deviceWidth,
              color: const Color.fromRGBO(67, 75, 79, 1.0),
            )),
        // AnimatedPositioned(
        //     duration: const Duration(milliseconds: 400),
        //     curve: Curves.easeOut,
        // bottom: isAnimated ? null : deviceHeight + 100,
        // top: isAnimated ? 50 : -100,
        // left: 300,

        // child:
        Container(
          width: deviceWidth,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(
                "شيخ نورالحسن مدني حفظه  الله",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
        ),
        // )
      ]),
    );
  }
}
