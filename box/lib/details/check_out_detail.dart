import 'package:box/cards/checkout_food_card.dart';
import 'package:box/screens/successful_checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../class/food.dart';
import '../class/option.dart';
import '../class/option_detail.dart';
import '../utils/colors.dart';

class CheckOutDetail extends StatefulWidget {
  final List<Food> foods;
  final String username;
  final String phoneNumber;
  final String address;
  final UserCredential userCredential;

  const CheckOutDetail(
      {super.key,
      required this.foods,
      required this.username,
      required this.phoneNumber,
      required this.address,
      required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _CheckOutDetailState();
  }
}

class _CheckOutDetailState extends State<CheckOutDetail> {
  int _selectedValue = 1;
  int _totalMoney = 0;
  bool isScheduled = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void _selectPaymentMethod(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  int calculateTotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    return res;
  }

  int calculateOptionDetail(List<OptionDetail> optionDetails) {
    int res = 0;

    for (OptionDetail optionDetail in optionDetails) {
      res += optionDetail.price;
    }

    return res;
  }

  Future<void> pushNewOrder() async {
    try {
      // Get a reference to the Realtime Database instance
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref("Orders");

      // Add data to a specific node (e.g., 'users')
      databaseReference.push().set({
        'userId': widget.userCredential.user?.uid.toString(),
        'shopId': widget.foods[0].shopId,
        'name': widget.username,
        'address': widget.address,
        'phoneNumber': widget.phoneNumber,
        'isScheduled': isScheduled,
        'dateScheduled': isScheduled
            ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
            : "",
        'timeScheduled':
            isScheduled ? "${selectedTime.hour}:${selectedTime.minute}" : "",
        'paymentMethod': _selectedValue == 1 ? "cash" : "online",
        'status': "pending",
        'foods': widget.foods.map((food) => food.toJson()).toList(),
      });

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SuccessfulCheckoutScreen(
                  userCredential: widget.userCredential,
                  address: widget.address,
                )),
      );
    } catch (e) {
      // Error
    }
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

                    // Payment text
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.payment,
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
                    Text(
                      AppLocalizations.of(context)!.checkOutInfo,
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: const TextStyle(
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

            // Username
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.username,
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),

            //
            const SizedBox(
              height: 10,
            ),

            // Address
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.address,
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),

            //
            const SizedBox(
              height: 10,
            ),

            //
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      color: AppColors.darkGrayColor),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Foods
            for (int i = 0; i < widget.foods.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CheckOutFoodCard(food: widget.foods[i]),
              ),

            const SizedBox(
              height: 20,
            ),

            // Payment method
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(AppLocalizations.of(context)!.paymentMethod,
                    style: const TextStyle(
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

            // Schedule
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    Text(AppLocalizations.of(context)!.schedule,
                        style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.orangeColor)),

                    //
                    Switch(
                        value: isScheduled,
                        activeColor: AppColors.orangeColor,
                        onChanged: (value) {
                          setState(() {
                            isScheduled = value;
                          });
                        }),
                  ],
                ),
              ),
            ),

            // Schedule details
            Visibility(
              visible: isScheduled,
              child: Column(
                children: [
                  // Select date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Text(AppLocalizations.of(context)!.date,
                              style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),

                          // Text
                          GestureDetector(
                            onTap: () async {
                              final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));

                              if (dateTime != null) {
                                setState(() {
                                  selectedDate = dateTime;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                // Day
                                Text("${selectedDate.day.toString()} / ",
                                    style: const TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),

                                // Month
                                Text("${selectedDate.month.toString()} / ",
                                    style: const TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),

                                // Year
                                Text(selectedDate.year.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Select time
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          Text(AppLocalizations.of(context)!.time,
                              style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),

                          //
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context, initialTime: selectedTime);

                              if (timeOfDay != null) {
                                setState(() {
                                  selectedTime = timeOfDay;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                // Hour
                                Text("${selectedTime.hour}:",
                                    style: const TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),

                                // Minute
                                Text(selectedTime.minute.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //
            const SizedBox(
              height: 20,
            ),

            // Checkout money
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${_totalMoney.toString()}Đ",
                      style: const TextStyle(
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
                  onPressed: pushNewOrder,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.mediumOrangeColor),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.orderCheckOut,
                      style: const TextStyle(
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
