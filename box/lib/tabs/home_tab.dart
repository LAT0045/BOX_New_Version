import 'package:box/cards/category_card.dart';
import 'package:box/cards/food_card.dart';
import 'package:box/cards/lastest_card.dart';
import 'package:box/cards/nearby_card.dart';
import 'package:box/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab> {
  final List _bannerList = [
    {"imagePath": 'assets/images/banner_1.png'},
    {"imagePath": 'assets/images/banner_2.png'},
    {"imagePath": 'assets/images/banner_3.png'}
  ];
  int _currentIndex = 0;

  final List<CategoryCard> _categories = [
    const CategoryCard(iconPath: "assets/svg/deal.svg", name: "Hot Deal"),
    const CategoryCard(iconPath: "assets/svg/voucher.svg", name: "Voucher"),
    const CategoryCard(iconPath: "assets/svg/all.svg", name: "Tất Cả"),
    const CategoryCard(iconPath: "assets/svg/fastfood.svg", name: "Fastfood"),
    const CategoryCard(iconPath: "assets/svg/bubble_tea.svg", name: "Trà Sữa"),
    const CategoryCard(
        iconPath: "assets/svg/vietnamese_food.svg", name: "Món Việt"),
    const CategoryCard(iconPath: "assets/svg/korean_food.svg", name: "Món Hàn"),
    const CategoryCard(
        iconPath: "assets/svg/japanese_food.svg", name: "Món Nhật")
  ];

  final List<LastestCard> _testCards = [
    const LastestCard(
      imagePath: "assets/test/milano_coffee.jpg",
      shopName: "Milano Coffee",
      iconType: "voucher",
      otherInfo: "Mã giảm 20%",
    ),
    const LastestCard(
      imagePath: "assets/test/milano_coffee.jpg",
      shopName: "Milano Coffee",
      iconType: "location",
      otherInfo: "100m",
    )
  ];

  void _onPressedAddress() {
    // TODO: Thêm hàm thay đổi địa chỉ
  }

  void _onPressedSeeMore() {
    // TODO: Thêm hàm xem thêm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              // Slogan
              Container(
                margin: const EdgeInsets.only(left: 5.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      width: 35,
                      height: 35,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "Tình yêu chỉ là hạt cát, vì đồ ăn đã lấn át tình yêu.",
                        style: TextStyle(
                            color: AppColors.orangeColor,
                            fontFamily: 'Comfortaa',
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Location
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: const Text(
                  "Có phải bạn đang ở:",
                  style: TextStyle(fontFamily: 'Comfortaa'),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/location_icon.svg",
                      height: 15,
                      width: 15,
                      colorFilter: const ColorFilter.mode(
                          AppColors.orangeColor, BlendMode.srcIn),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "155A Đường Gì Đó, P. Phường gì đó, Q. Quận gì đó, Tỉnh/Thành Gì đó",
                          style: TextStyle(fontFamily: 'Comfortaa'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onPressedAddress,
                      child: SvgPicture.asset(
                        "assets/svg/next_icon.svg",
                        height: 15,
                        width: 15,
                        colorFilter: const ColorFilter.mode(
                            AppColors.orangeColor, BlendMode.srcIn),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    hintText: "Hôm nay bạn muốn ăn gì?",
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: SvgPicture.asset(
                        "assets/svg/search_icon.svg",
                        colorFilter: const ColorFilter.mode(
                            AppColors.orangeColor, BlendMode.srcIn),
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(maxHeight: 35, maxWidth: 35),
                    fillColor: AppColors.lightGrayColor,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                    isDense: true,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Banner
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CarouselSlider(
                        items: _bannerList
                            .map((item) => Image.asset(
                                  item['imagePath'],
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ))
                            .toList(),
                        options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            })),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DotsIndicator(
                          dotsCount: _bannerList.length,
                          position: _currentIndex,
                          decorator: const DotsDecorator(
                              color: Colors.white,
                              activeColor: AppColors.orangeColor,
                              spacing: EdgeInsets.all(0.0),
                              shape: Border(),
                              activeShape: Border(),
                              size: Size(20, 3),
                              activeSize: Size(20, 3)),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Categories
              SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return _categories[index];
                    }),
              ),

              Container(
                height: 10,
                color: AppColors.lightGrayColor,
              ),

              // Flash Sale
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        const Text(
                          "FLASH \nSALE",
                          style: TextStyle(
                              fontFamily: 'LilitaOne',
                              color: AppColors.orangeColor,
                              fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        SvgPicture.asset(
                          "assets/svg/flash_sale.svg",
                          height: 30,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                              AppColors.orangeColor, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SlideCountdownSeparated(
                          duration: Duration(hours: 12),
                          decoration: BoxDecoration(color: Colors.black),
                          textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          height: 20,
                          width: 18,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const FoodCard(
                                type: FoodCard.salesFood,
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: 10,
                color: AppColors.lightGrayColor,
              ),

              // History
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Đã Xem Gần Đây",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: AppColors.orangeColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: _onPressedSeeMore,
                        child: const Text(
                          "Xem thêm >>",
                          style: TextStyle(
                              fontFamily: 'Comfortaa',
                              color: AppColors.blueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _testCards.length,
                    itemBuilder: (context, index) {
                      return _testCards[index];
                    }),
              ),

              Container(
                height: 10,
                color: AppColors.lightGrayColor,
              ),

              // For you
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dành Riêng Cho Bạn",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: AppColors.orangeColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: _onPressedSeeMore,
                        child: const Text(
                          "Xem thêm >>",
                          style: TextStyle(
                              fontFamily: 'Comfortaa',
                              color: AppColors.blueColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const FoodCard(type: FoodCard.forYouFood);
                      }),
                ),
              ),

              Container(
                height: 10,
                color: AppColors.lightGrayColor,
              ),

              // Nearby
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Ở Gần Bạn",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const NearbyCard(
                        imagePath: "assets/test/milano_coffee.jpg",
                        hasVoucher: true,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
