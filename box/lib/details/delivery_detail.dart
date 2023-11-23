import 'package:box/cards/delivery_food_card.dart';
import 'package:box/cards/section_card.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryDetail extends StatefulWidget {
  final String shopName;

  const DeliveryDetail({super.key, required this.shopName});

  @override
  State<StatefulWidget> createState() {
    return _DeliveryDetailState();
  }
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const DeliveryFoodCard(),
      const DeliveryFoodCard(),
      const DeliveryFoodCard()
    ];

    List deliverySteps = [
      {
        "title": "Shipper đến cửa hàng",
        "address": "Địa chỉ cửa hàng",
        "time": "14:00"
      },
      {
        "title": "Shipper nhận đồ ăn",
        "address": "Địa chỉ cửa hàng",
        "time": "14:00"
      },
      {
        "title": "Shipp đến chỗ giao hàng",
        "address": "Địa chỉ nhà",
        "time": "14:00"
      },
      {"title": "Shipper giao đồ ăn", "address": "Địa chỉ nhà", "time": "14:00"}
    ];

    int currentIndex = 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            // Back button and shop name
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.shopName,
                        style: const TextStyle(
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

            // Delivery detail
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                child: Text(
                  "Chi Tiết Đơn Hàng",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
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
              height: 20.0,
            ),

            // Chosen food section
            //SectionCard(sectionName: "Các Món Đã Chọn", widgets: widgets),

            const SizedBox(
              height: 20.0,
            ),

            // Keeping track
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Dự Kiến",
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orangeColor),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            for (int i = 0; i < deliverySteps.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DeliveryStepper(
                  index: i,
                  currentIndex: currentIndex,
                  title: deliverySteps[i]["title"],
                  address: deliverySteps[i]["address"],
                  time: deliverySteps[i]["time"],
                  maxIndex: deliverySteps.length,
                ),
              ),

            // Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.mediumOrangeColor),
                  child: const Text(
                    "Đã Nhận Món Thành Công",
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                  )),
            )
          ],
        )),
      ),
    );
  }
}

class DeliveryStepper extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String title;
  final String address;
  final String time;
  final int maxIndex;

  const DeliveryStepper(
      {super.key,
      required this.index,
      required this.currentIndex,
      required this.title,
      required this.address,
      required this.time,
      required this.maxIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: index <= currentIndex
                  ? AppColors.mediumOrangeColor
                  : AppColors.grayColor,
              radius: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: AppColors.orangeColor),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: index < maxIndex - 1
                  ? Border(
                      left: BorderSide(
                          color: index + 1 <= currentIndex
                              ? AppColors.mediumOrangeColor
                              : AppColors.grayColor,
                          width: 2.0))
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Địa điểm: $address",
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          color: AppColors.grayColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Dự kiến: $time",
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          color: AppColors.grayColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
