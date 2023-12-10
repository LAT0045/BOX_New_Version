import 'package:box/cards/checkout_food_card.dart';
import 'package:box/cards/delivery_food_card.dart';
import 'package:box/class/food.dart';
import 'package:box/class/option.dart';
import 'package:box/class/option_detail.dart';
import 'package:box/class/order.dart';
import 'package:box/class/shop.dart';
import 'package:box/screens/successful_order_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryDetail extends StatefulWidget {
  final Order order;
  final Shop shop;
  final String foodImage;
  final List<Food> foods;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;

  const DeliveryDetail({
    Key? key,
    required this.order,
    required this.shop,
    required this.foodImage,
    required this.foods,
    required this.username,
    required this.phoneNumber,
    required this.address,
    required this.userCredential,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DeliveryDetailState();
  }
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  int _totalMoney = 0;
  DateTime date = DateTime.now();
  int calculateTotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    return res * food.quantity;
  }

  int calculateOptionDetail(List<OptionDetail> optionDetails) {
    int res = 0;

    for (OptionDetail optionDetail in optionDetails) {
      res += optionDetail.price;
    }

    return res;
  }

  Future<void> pushNewInvoice() async {
    try {
      // Get a reference to the Realtime Database instance
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("Invoices");

      databaseReference.push().set({
        'userId': widget.userCredential.user?.uid.toString(),
        'shopId': widget.order.shopId,
        'name': widget.order.name,
        'address': widget.order.address,
        'phoneNumber': widget.order.phoneNumber,
        'createdDate': "${date.day}/${date.month}/${date.year}",
        'totalPrice': _totalMoney,
        'foods': widget.foods.map((food) => food.toJson()).toList(),
      });

      DatabaseReference databaseReference2 =
          FirebaseDatabase.instance.ref("Orders");
      DatabaseReference orderReference =
          databaseReference2.child(widget.order.orderId);

      orderReference.update({
        "status": "COMPLETED",
      }).catchError((error) {
        print(error);
      });

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SuccessfulOrderScreen(
                  userCredential: widget.userCredential,
                  address: widget.address,
                  status: true,
                )),
      );
    } catch (e) {
      // Error
    }
  }

  Future<void> cancelOrder() async {
    try {
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("Orders");
      DatabaseReference orderReference =
          databaseReference.child(widget.order.orderId);

      orderReference.update({
        "status": "DENIED",
      }).catchError((error) {
        print(error);
      });

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SuccessfulOrderScreen(
                  userCredential: widget.userCredential,
                  address: widget.address,
                  status: false,
                )),
      );
    } catch (e) {
      // Error
    }
  }

  Future<void> _showCancelConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Bạn có chắc chắn muốn hủy đơn?",
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              fontWeight: FontWeight.bold),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                cancelOrder(); // Hủy đơn hàng
              },
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              child: Text(
                "Yes",
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mediumOrangeColor)
              
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor:  AppColors.mediumOrangeColor // Màu xám khi nút bị disable
                ),
              child: Text(
                "Cancel",
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _totalMoney = 0;
    setState(() {
      for (Food food in widget.foods) {
        print("_______________________");
        print(food.foodName);
        print(food.foodPrice);
        print(food.quantity);

        _totalMoney += calculateTotalPrice(food);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
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
                        widget.shop.shopName,
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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.username,
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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.order.address,
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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.phoneNumber,
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

            for (int i = 0; i < widget.foods.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DeliveryFoodCard(food: widget.foods[i]),
              ),

            const SizedBox(
              height: 20.0,
            ),

            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.total,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${_totalMoney.toString()}Đ",
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orangeColor),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),

            // Keeping track
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Tình trạng",
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

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DeliveryStepper(
                  status: widget.order.status,
                )),

            // Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: TextButton(
                onPressed: () {
                  if (widget.order.status == "PENDING") {
                    _showCancelConfirmationDialog();
                  } else if (widget.order.status == "DELIVERING") {
                    pushNewInvoice();
                  }
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: (widget.order.status == "PENDING" ||
                          widget.order.status == "DELIVERING")
                      ? AppColors.mediumOrangeColor
                      : Colors.grey, // Màu xám khi nút bị disable
                ),
                child: Text(
                  (widget.order.status == "PENDING")
                      ? "Hủy Đơn Hàng"
                      : "Đã Nhận Món Thành Công",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class DeliveryStepper extends StatelessWidget {
  final String status;
  final Map<String, int> statusMap = {
    "PENDING": 1,
    "ACCEPTED": 2,
    "DELIVERING": 3,
  };

  final Map<String, String> statusText = {
    "PENDING": "Chờ xác nhận",
    "ACCEPTED": "Đã chấp nhận",
    "DELIVERING": "Đang giao hàng",
  };

  DeliveryStepper({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = statusMap[status] ?? 0;

    List<String> deliverySteps = [
      statusText["PENDING"]!,
      statusText["ACCEPTED"]!,
      statusText["DELIVERING"]!,
    ];

    return Column(
      children: [
        for (int i = 0; i < deliverySteps.length; i++)
          _buildStep(
            title: deliverySteps[i],
            currentIndex: currentIndex,
            index: i + 1,
            maxIndex: deliverySteps.length,
          )
      ],
    );
  }

  Widget _buildStep({
    required String title,
    required int currentIndex,
    required int index,
    required int maxIndex,
  }) {
    bool isCurrentStep = index == currentIndex;
    bool isPastStep = index < currentIndex;

    String statusTitle;
    if (isCurrentStep) {
      statusTitle = "Đang thực hiện";
    } else if (isPastStep) {
      statusTitle = "Đã xong";
    } else {
      statusTitle = "Đang chờ";
    }

    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: isCurrentStep
                  ? AppColors.mediumOrangeColor
                  : isPastStep
                      ? AppColors.mediumOrangeColor.withOpacity(0.5)
                      : AppColors.grayColor,
              radius: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 18,
                  color: isCurrentStep
                      ? AppColors.orangeColor
                      : isPastStep
                          ? AppColors.mediumOrangeColor.withOpacity(0.5)
                          : AppColors.grayColor,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              border: index < maxIndex
                  ? Border(
                      left: BorderSide(
                        color: isPastStep
                            ? AppColors.mediumOrangeColor.withOpacity(0.5)
                            : AppColors.grayColor,
                        width: 2.0,
                      ),
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Tình trạng: $statusTitle",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        color: isPastStep
                            ? AppColors.mediumOrangeColor.withOpacity(0.5)
                            : AppColors.grayColor,
                      ),
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
