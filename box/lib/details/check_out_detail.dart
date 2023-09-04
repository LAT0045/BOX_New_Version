import 'package:box/cards/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cards/delivery_food_card.dart';
import '../utils/colors.dart';

class CheckOutDetail extends StatefulWidget {
  CheckOutDetail({super.key});

  final List<Widget> _widgets = [
    const DeliveryFoodCard(),
    const DeliveryFoodCard(),
    const DeliveryFoodCard()
  ];

  @override
  State<StatefulWidget> createState() {
    return _CheckOutDetailState();
  }
}

class _CheckOutDetailState extends State<CheckOutDetail> {
  int _selectedValue = 1;

  void _selectPaymentMethod(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            // Back button and screen name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/svg/backarrow.svg",
                          height: 30,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                              AppColors.orangeColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Thanh Toán",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 20,
                            color: AppColors.orangeColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Checkout information
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Thông Tin Đặt Hàng",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Chỉnh Sửa",
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 15,
                            color: AppColors.blueColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Tên của người nhận",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Địa chỉ của người nhận",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Số điện thoại của người nhận",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Chosen food
            SectionCard(
                sectionName: "Các Món Đã Chọn", widgets: widget._widgets),

            const SizedBox(
              height: 20,
            ),

            // Payment method
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Phương Thức Thanh Toán",
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeColor)),
              ),
            ),

            RadioListTile(
                value: 1,
                title: const Text(
                  "Thanh toán tiền mặt",
                  style: TextStyle(fontFamily: 'Comfortaa'),
                ),
                groupValue: _selectedValue,
                activeColor: AppColors.orangeColor,
                onChanged: (value) => _selectPaymentMethod(value!)),

            RadioListTile(
                value: 2,
                title: const Text(
                  "Thanh toán online",
                  style: TextStyle(fontFamily: 'Comfortaa'),
                ),
                groupValue: _selectedValue,
                activeColor: AppColors.orangeColor,
                onChanged: (value) => _selectPaymentMethod(value!)),

            const SizedBox(
              height: 20,
            ),

            // Checkout money
            const SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Tổng Cộng",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "174.000Đ",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orangeColor),
                    ),
                  ),
                ],
              ),
            ),

            // Checkout button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.mediumOrangeColor),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Đặt Hàng",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        )),
      ),
    );
  }
}
