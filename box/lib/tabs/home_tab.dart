import 'package:box/cards/category_card.dart';
import 'package:box/cards/food_card.dart';
import 'package:box/cards/lastest_card.dart';
import 'package:box/cards/nearby_card.dart';
import 'package:box/class/food.dart';
import 'package:box/class/section.dart';
import 'package:box/class/shop.dart';
import 'package:box/screens/map_screen.dart';
import 'package:box/service/location_service.dart';
import 'package:box/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../class/food.dart';
import '../class/section.dart';
import '../class/shop.dart';

class HomeTab extends StatefulWidget {
  final String address;
  final UserCredential userCredential;

  const HomeTab(
      {super.key, required this.address, required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab> {
  late String _currentAddress;
  late String newAddress = '';
  final List _bannerList = [
    {"imagePath": 'assets/images/banner_1.png'},
    {"imagePath": 'assets/images/banner_2.png'},
    {"imagePath": 'assets/images/banner_3.png'}
  ];
  int _currentIndex = 0;
  bool _isDoneGettingInfo = false;

  final List<Shop> _shops = [];
  final List<Shop> _fastFoodShops = [];
  final List<Shop> _drinkShops = [];
  final List<Shop> _vietnameseShops = [];
  final List<Shop> _koreanShops = [];
  final List<Shop> _japaneseShops = [];

  String _phoneNumber = "";
  String _name = "";

  List<CategoryCard> _initializeCategories(BuildContext context) {
    final List<CategoryCard> categories = [
      CategoryCard(
        iconPath: "assets/svg/deal.svg",
        name: AppLocalizations.of(context)!.hotDeal,
        shops: const [],
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/voucher.svg",
        name: AppLocalizations.of(context)!.voucher,
        shops: const [],
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/all.svg",
        name: AppLocalizations.of(context)!.all,
        shops: _shops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/fastfood.svg",
        name: AppLocalizations.of(context)!.fastFood,
        shops: _fastFoodShops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/bubble_tea.svg",
        name: AppLocalizations.of(context)!.drink,
        shops: _drinkShops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/vietnamese_food.svg",
        name: AppLocalizations.of(context)!.vietnameseFood,
        shops: _vietnameseShops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/korean_food.svg",
        name: AppLocalizations.of(context)!.koreanFood,
        shops: _koreanShops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      ),
      CategoryCard(
        iconPath: "assets/svg/japanese_food.svg",
        name: AppLocalizations.of(context)!.japaneseFood,
        shops: _japaneseShops,
        username: _name,
        phoneNumber: _phoneNumber,
        address: widget.address,
        userCredential: widget.userCredential,
      )
    ];

    return categories;
  }

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

  int getShopById(String shopId) {
    for (int i = 0; i < _shops.length; i++) {
      if (_shops[i].shopId == shopId) {
        return i;
      }
    }

    return -1;
  }

  bool isFoodExist(Food food, List<Food> foods) {
    for (Food curFood in foods) {
      if (curFood.foodId == food.foodId) {
        return true;
      }
    }

    return false;
  }

  void addFoodToSection(Food food, Section section) {
    if (section.sectionId == food.sectionId &&
        !isFoodExist(food, section.foods)) {
      section.addFood(food);
    }
  }

  void sortShop(Shop shop, String type) {
    switch (type) {
      case "fastfood":
        isExisted(_fastFoodShops, shop) ? null : _fastFoodShops.add(shop);
        break;
      case "drink":
        isExisted(_drinkShops, shop) ? null : _drinkShops.add(shop);
        break;
      case "vietnameseFood":
        isExisted(_vietnameseShops, shop) ? null : _vietnameseShops.add(shop);
        break;
      case "koreanFood":
        isExisted(_koreanShops, shop) ? null : _koreanShops.add(shop);
        break;
      case "japaneseFood":
        isExisted(_japaneseShops, shop) ? null : _japaneseShops.add(shop);
        break;
      default:
    }
  }

  bool isExisted(List<Shop> shops, Shop curShop) {
    for (Shop shop in shops) {
      if (shop.shopId == curShop.shopId) {
        return true;
      }
    }

    return false;
  }

  Future<void> getInfo() async {
    final databaseReference = FirebaseDatabase.instance;

    final shopSnapshot = await databaseReference.ref("Shops").get();
    final foodSnapshot = await databaseReference.ref("Foods").get();

    final shopMap = shopSnapshot.value as Map;

    List<Food> foods = [];
    final foodMap = foodSnapshot.value as Map;

    shopMap.forEach((key, value) {
      _shops.add(Shop.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map)));
    });

    foodMap.forEach((key, value) {
      Food food = Food.fromJson(
          key.toString(), Map<String, dynamic>.from(value as Map));

      foods.add(food);

      int shopIndex = getShopById(food.shopId);

      if (shopIndex != -1) {
        sortShop(_shops[shopIndex], food.foodType);

        for (Section section in _shops[shopIndex].sections) {
          addFoodToSection(food, section);
        }
      }
    });

    final databaseReference2 = databaseReference.ref("Users");
    DatabaseReference userReference =
        databaseReference2.child(widget.userCredential.user!.uid);

    final snapshot = await userReference.get();
    if (snapshot.exists) {
      setState(() {
        _name = (snapshot.value as Map)["name"];
        _phoneNumber = (snapshot.value as Map)["phoneNumber"] ??
            AppLocalizations.of(context)!.notUpdate;
      });
    } else {
      // User info doesn't exist
    }

    // for (Shop shop in _shops) {
    //   double calculatedDistance = await locationService.calculateDistanceBetweenAddresses(
    //     widget.address,
    //     shop.shopAddress,
    //   );
    //   if (calculatedDistance < 3.0) {
    //     setState(() {
    //       _nearbyShops.add(shop);
    //     });
    //   }
    // }
    _isDoneGettingInfo = true;
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    _currentAddress = widget.address;
    _loadSavedAddress();
  }

  void _loadSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newAddress.isEmpty) {
      setState(() {
        _currentAddress = prefs.getString('savedAddress') ?? widget.address;
      });
    }
  }

  void _onPressedAddress() async {
    newAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );

    if (newAddress.isNotEmpty) {
      setState(() {
        _currentAddress = newAddress;
      });
    }
  }

  void _onPressedSeeMore() {
    // TODO: Thêm hàm xem thêm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getInfo(),
            builder: (context, snapshot) {
              if (!_isDoneGettingInfo) {
                return const SafeArea(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),

                        // Slogan
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/logo.svg",
                                width: 35,
                                height: 35,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.homeSlogan,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        color: AppColors.orangeColor,
                                        fontFamily: 'Comfortaa',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
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
                          child: Text(
                            AppLocalizations.of(context)!.locationQuestion,
                            style: const TextStyle(fontFamily: 'Comfortaa'),
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    _currentAddress,
                                    style: const TextStyle(
                                        fontFamily: 'Comfortaa'),
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
                              hintText:
                                  AppLocalizations.of(context)!.homeHintText,
                              hintStyle:
                                  const TextStyle(fontFamily: 'Comfortaa'),
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                child: SvgPicture.asset(
                                  "assets/svg/search_icon.svg",
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.orangeColor, BlendMode.srcIn),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 35, maxWidth: 35),
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
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
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

                        // Categories
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < _initializeCategories(context).length;
                                  i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: _initializeCategories(context)[i],
                                ),
                            ],
                          ),
                        ),

                        Container(
                          height: 10,
                          color: AppColors.lightGrayColor,
                        ),

                        // Flash Sale
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    // Flash sale
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "FLASH \nSALE",
                                              style: TextStyle(
                                                  fontFamily: 'LilitaOne',
                                                  color: AppColors.orangeColor,
                                                  fontSize: 35),
                                              textAlign: TextAlign.center,
                                            ),
                                            SvgPicture.asset(
                                              "assets/svg/flash_sale.svg",
                                              height: 35,
                                              width: 35,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      AppColors.orangeColor,
                                                      BlendMode.srcIn),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const SlideCountdownSeparated(
                                              duration: Duration(hours: 12),
                                              decoration: BoxDecoration(
                                                  color: Colors.black),
                                              textStyle: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              height: 20,
                                              width: 18,
                                            )
                                          ],
                                        ),
                                      );
                                    }

                                    // Flash sale items
                                    else {
                                      return const FoodCard(
                                        type: FoodCard.salesFood,
                                      );
                                    }
                                  }),
                            ),
                          ),
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
                              Text(
                                AppLocalizations.of(context)!.recentlyViewed,
                                style: const TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: AppColors.orangeColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.seeMore,
                                    style: const TextStyle(
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
                              Text(
                                AppLocalizations.of(context)!.forYou,
                                style: const TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: AppColors.orangeColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.seeMore,
                                    style: const TextStyle(
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
                                  return const FoodCard(
                                      type: FoodCard.forYouFood);
                                }),
                          ),
                        ),

                        Container(
                          height: 10,
                          color: AppColors.lightGrayColor,
                        ),

                        // Nearby
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            AppLocalizations.of(context)!.nearYou,
                            style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                color: AppColors.orangeColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
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
                );
              }
            }));
  }
}
