import 'package:box/class/food.dart';
import 'package:box/class/shop.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Shop> shops;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;
  final List<String> favoriteFoods;
  final Function(Food, bool) updateFavoriteFoods;

  const SearchScreen(
      {super.key,
      required this.shops,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.userCredential,
      required this.favoriteFoods,
      required this.updateFavoriteFoods});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Shop> filteredShopList;
  TextEditingController searchController = TextEditingController();
  bool showList = false;

  @override
  void initState() {
    super.initState();
    filteredShopList = widget.shops;
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredShopList = widget.shops
            .where((shop) =>
                shop.shopName.toLowerCase().contains(query.toLowerCase()) ||
                shop.shopAddress.toLowerCase().contains(query.toLowerCase()))
            .toList();
        showList = filteredShopList.isNotEmpty;
      });
    } else {
      setState(() {
        filteredShopList = widget.shops;
        showList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: AppColors.mediumOrangeColor,
        ),
        title: TextField(
            controller: searchController,
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
              hintText: 'Tìm kiếm theo tên hoặc địa chỉ của cửa hàng',
              border: InputBorder.none,
            ),
            cursorColor: AppColors.mediumOrangeColor,
            style: const TextStyle(fontSize: 15, fontFamily: 'Comfortaa')),
      ),
      body: showList
          ? ListView.builder(
              itemCount: filteredShopList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(
                      filteredShopList[index].shopImage,
                    ),
                  ),
                  title: Text(filteredShopList[index].shopName,
                      style: const TextStyle(
                          fontSize: 18, fontFamily: 'Comfortaa')),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredShopList[index].shopAddress,
                        style: const TextStyle(
                            fontSize: 15, fontFamily: 'Comfortaa'),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.mediumOrangeColor,size: 18,),
                          SizedBox(width: 5),
                          Text(filteredShopList[index].ratingScore.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Comfortaa')),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopScreen(
                          shop: filteredShopList[index],
                          username: widget.username,
                          phoneNumber: widget.phoneNumber,
                          address: widget.address,
                          userCredential: widget.userCredential,
                          favoriteFoods: widget.favoriteFoods,
                          updateFavoriteFoods: widget.updateFavoriteFoods,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(),
    );
  }
}
