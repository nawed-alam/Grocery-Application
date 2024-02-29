import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/list.dart';
import 'package:grocery_app/consts/strings.dart';
import 'package:grocery_app/controler/home_controler.dart';
import 'package:grocery_app/views/Categories/items_details.dart';
import 'package:grocery_app/views/home_screen/components/featred_button.dart';
import 'package:grocery_app/views/home_screen/components/search_screen.dart';
import 'package:grocery_app/widget_common/home_button.dart';

import '../../services/firestore_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeControler>();
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Column(
  children: [
    // Container for App Name
    Container(
      alignment: Alignment.center,
      height: 60,
      color: lightGrey,
      child: Text(
        "Al-Abbas",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Customize the color as needed
        ),
      ),
    ),
    // Container for Search Bar
   Container(
  alignment: Alignment.center,
  height: 60,
  color: lightGrey,
  child: TextFormField(
    controller: controller.searchController,
    onFieldSubmitted: (value) {
      if (value.isNotEmptyAndNotNull) {
        Get.to(() => SerachScreen(title: value));
      }
    },
    decoration:const InputDecoration(
      suffixIcon: const Icon(Icons.search),
      border: InputBorder.none,
      filled: true,
      fillColor: whiteColor,
      hintText: "Search anything",
      hintStyle: const TextStyle(color: textfieldGrey),
    ),
  ),
),

  ],
)
,
          // swapppers Brand
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 160,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  //deals button
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       2,
                  //       (index) => homeButtons(
                  //           height: context.screenHeight * 0.15,
                  //           width: context.screenWidth / 2.5,
                  //           icon: index == 0 ? icTodaysDeal : icFlashDeal,
                  //           title: index == 0 ? todaydeal : flashsale)),
                  // ),
                  // 10.heightBox,
                  //2nd swiper
                  // VxSwiper.builder(
                  //     aspectRatio: 16 / 9,
                  //     autoPlay: true,
                  //     enlargeCenterPage: true,
                  //     height: 150,
                  //     itemCount: secondSlidersList.length,
                  //     itemBuilder: (context, index) {
                  //       return Image.asset(
                  //         secondSlidersList[index],
                  //         fit: BoxFit.fill,
                  //       )
                  //           .box
                  //           .rounded
                  //           .clip(Clip.antiAlias)
                  //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                  //           .make();
                  //     }),
                  20.heightBox,
                  //deals button

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => Row(
                            children: [
                              homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 2.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topcategories
                                    : index == 1
                                        ? brand
                                        : topsellers,
                              ),
                              // Add a SizedBox for horizontal spacing between elements
                              SizedBox(width: 12.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featurecategories.text
                          .color(darkFontGrey)
                          .size(19)
                          .fontFamily(semibold)
                          .make()),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  FeaturedButton(
                                      icon: featureimage1[index],
                                      title: featureTitle1[index],
                                      index: index),
                                  10.heightBox,
                                  FeaturedButton(
                                      icon: featureimage2[index],
                                      title: featureTitle2[index])
                                ],
                              )).toList(),
                    ),
                  ),
                  //feature product
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(220, 254, 246, 1.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featureproduct.text.fontFamily(bold).size(18).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getFeatured(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;

                                  return Row(
                                      children: List.generate(
                                    featuredData.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_images'][1],
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make()
                                            .centered(),
                                        10.heightBox,
                                        "${String.fromCharCode(8377)} ${featuredData[index]['p_price']}"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make()
                                            .centered(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .roundedSM
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 5))
                                        .padding(const EdgeInsets.all(8))
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemsDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                    }),
                                  ));
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  30.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(220, 254, 246, 1.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        trendingItems.text.fontFamily(bold).size(18).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getTrend(),
                              //future: FirestoreServices.getFeatured(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;

                                  return Row(
                                      children: List.generate(
                                    featuredData.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          featuredData[index]['p_images'][0],
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make()
                                            .centered(),
                                        10.heightBox,
                                        "${String.fromCharCode(8377)} ${featuredData[index]['p_price']}"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make()
                                            .centered(),
                                      ],
                                    )
                                        .box
                                        .white
                                        .roundedSM
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 5))
                                        .padding(const EdgeInsets.all(8))
                                        .make()
                                        .onTap(() {
                                      Get.to(() => ItemsDetails(
                                            title:
                                                "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                    }),
                                  ));
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
