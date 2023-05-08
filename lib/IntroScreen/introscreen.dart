import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';
import 'package:hiremymate/ScreenView/welcomeScreen.dart';
import 'package:hiremymate/buttons/CustomButton.dart';

import '../Helper/ColorClass.dart';
import '../buttons/AppButton.dart';

class IntroSlider extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<IntroSlider>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  List slideList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();

    new Future.delayed(Duration.zero, () {
      setState(() {
        slideList = [
          Slide(
              imageUrl: 'assets/sliderImages/introimage_a.png',
              title: "",
              //getTranslated(context, 'TITLE1_LBL'),
              description: ""
              // getTranslated(context, 'DISCRIPTION1'),
              ),
          Slide(
              imageUrl: 'assets/sliderImages/introimage_b.png',
              title: "",
              // getTranslated(context, 'TITLE2_LBL'),
              description: ""
              // getTranslated(context, 'DISCRIPTION2'),
              ),
          Slide(
              imageUrl: 'assets/sliderImages/introimage_c.png',
              title: "",
              // getTranslated(context, 'TITLE3_LBL'),
              description: ""
              // getTranslated(context, 'DISCRIPTION3'),
              ),
        ];
      });
    });

    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    buttonSqueezeanimation = new Tween(
      begin: 0.9,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController!,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    buttonController!.dispose();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  _onPageChanged(int index) {
    if (mounted)
      setState(() {
        _currentPage = index;
      });
  }

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget _slider() {
    return PageView.builder(
      itemCount: slideList.length,
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            slideList[index].imageUrl,
            fit: BoxFit.fill,
          ),
        );
        // Container(
        //     margin: EdgeInsetsDirectional.only(top: 20),
        //     child: Text(slideList[index].title,
        //         style: Theme.of(context).textTheme.headline5!.copyWith(
        //             color: Colors.green,
        //             fontWeight: FontWeight.bold))),
        // Container(
        //   // padding: EdgeInsetsDirectional.only(
        //   //     top: 30.0, start: 15.0, end: 15.0),
        //   child: Text(slideList[index].description,
        //       textAlign: TextAlign.center,
        //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
        //           color: Colors.green,
        //           fontWeight: FontWeight.normal)),
        // ),
      },
    );
  }

  // _btn() {
  //   return Column(
  //     children: [
  //       Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: getList()),
  //       Center(
  //           child: Padding(
  //         padding: const EdgeInsetsDirectional.only(bottom: 18.0),
  //         child: AppBtn(
  //             title: _currentPage == 0 || _currentPage == 1
  //                 ? Text("N")
  //                 : Text("GET_STARTED"),
  //             onBtnSelected: () {
  //               if (_currentPage == 2) {
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => ()),
  //                 );
  //               } else {
  //                 _currentPage = _currentPage + 1;
  //                 _pageController.animateToPage(_currentPage,
  //                     curve: Curves.decelerate,
  //                     duration: Duration(milliseconds: 300));
  //               }
  //             }),
  //       )),
  //     ],
  //   );
  // }

  List<Widget> getList() {
    List<Widget> childs = [];

    for (int i = 0; i < slideList.length; i++) {
      childs.add(Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == i ? Colors.pink : Colors.pink.withOpacity(0.5),
          )));
    }
    return childs;
  }

  skipBtn() {
    return _currentPage == 0 || _currentPage == 1
        ? Padding(
            padding: EdgeInsetsDirectional.only(top: 10.0, end: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // setPrefrenceBool(ISFIRSTTIME, true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  child: Row(children: [
                    Text('SKIP',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: CustomColors.primaryColor)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColors.primaryColor,
                      size: 12.0,
                    ),
                  ]),
                ),
              ],
            ))
        : Container(
            margin: EdgeInsetsDirectional.only(top: 50.0),
            height: 15,
          );
  }

  @override
  Widget build(BuildContext context) {
    //  heiMediaQuery.of(context).size.height;
    // deviceWidth = MediaQuery.of(context).size.width;
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _slider(),
          Positioned(
            top: 1,
            right: 1,
            child: skipBtn(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 22,bottom: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lets Find Your Dream\njob with us",
                        style: TextStyle(
                            color: CustomColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _currentPage == 0
                                    ? CustomColors.primaryColor
                                    : CustomColors.lightgray,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _currentPage == 1
                                    ? CustomColors.primaryColor
                                    : CustomColors.lightgray,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _currentPage == 2
                                    ? CustomColors.primaryColor
                                    : CustomColors.lightgray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomAppBtn(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 2,
                        onPress: () {
                          setState(() {
                            _currentPage = _currentPage + 1;
                            _pageController.animateToPage(_currentPage,
                                curve: Curves.decelerate,
                                duration: Duration(milliseconds: 500));
                          });

                          if(_currentPage == 2){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (route) => false);
                          }
                        },
                        title: _currentPage == 2 ? "GET STARTED" : "NEXT",
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //_btn(),
        ],
      )),
    );
  }
}

class Slide {
  final String imageUrl;
  final String? title;
  final String? description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
