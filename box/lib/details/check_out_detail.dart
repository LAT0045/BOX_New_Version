import 'dart:ffi';

import 'package:box/cards/checkout_food_card.dart';
import 'package:box/details/all_voucher_detail.dart';
import 'package:box/screens/edit_checkout_info_screen.dart';
import 'package:box/screens/successful_checkout_screen.dart';
import 'package:box/service/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../class/food.dart';
import '../class/option.dart';
import '../class/option_detail.dart';
import '../utils/colors.dart';

class CheckOutDetail extends StatefulWidget {
  final List<Food> foods;
  final String username;
  final String shopAddress;
  final String phoneNumber;
  final String address;
  final String shopId;
  final UserCredential userCredential;

  const CheckOutDetail(
      {super.key,
      required this.foods,
      required this.username,
      required this.shopAddress,
      required this.phoneNumber,
      required this.address,
      required this.shopId,
      required this.userCredential});

  @override
  State<StatefulWidget> createState() {
    return _CheckOutDetailState();
  }
}

class _CheckOutDetailState extends State<CheckOutDetail> {
  int _selectedValue = 1;
  int _totalMoney = 0;
  int _subTotalMoney = 0;
  bool isScheduled = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  late String _editedUsername = widget.username;
  late String _editedPhoneNumber = widget.phoneNumber;
  late String _editedAddress = widget.address;

  int? returnedDiscount;
  int? discountQuantity;
  bool _isInitialized = false;
  int shippingFee = 0;
  double distance = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectPaymentMethod(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  int calculateSubtotalPrice(Food food) {
    int res = food.foodPrice;

    for (Option option in food.options) {
      res += calculateOptionDetail(option.optionList);
    }

    return res * food.quantity;
  }

  int calculateTotalPrice(Food food) {
    int res = calculateSubtotalPrice(food);
    return res;
  }

  void updateTotalAmount() {
    setState(() {
      _totalMoney = 0;
      for (Food food in widget.foods) {
        int totalPrice = calculateTotalPrice(food);
        _totalMoney += totalPrice;
      }
      _totalMoney += shippingFee;
      _totalMoney -= returnedDiscount ?? 0;
    });
  }

  Future<double> calculateDistance(
      String shopAddress, String orderAddress) async {
    LocationService locationService = LocationService();
    double distance = await locationService.calculateDistanceBetweenAddresses(
      shopAddress,
      orderAddress,
    );
    return double.parse(distance.toStringAsFixed(2));
  }

  Future<int> calculateShippingFee(
      String shopAddress, String orderAddress) async {
    const baseFee = 15000;
    const feePerKm = 5000;

    double distance = await calculateDistance(shopAddress, orderAddress);

    if (distance <= 3.0) {
      return baseFee;
    } else {
      final extraKm = distance - 3.0;
      final extraFee = (extraKm * feePerKm).ceil();
      double roundedNumber = (baseFee + extraFee + 50).roundToDouble() -
          ((baseFee + extraFee + 50).roundToDouble() % 100);
      return roundedNumber.ceil();
    }
  }

  void updateShippingInfo() {
    calculateShippingFee(widget.shopAddress, _editedAddress).then((fee) {
      setState(() {
        shippingFee = fee;
        updateTotalAmount();
        print(shippingFee);
      });
    }).catchError((error) {
      // Xử lý lỗi nếu có
    });

    calculateDistance(widget.shopAddress, _editedAddress)
        .then((calculatedDistance) {
      setState(() {
        distance = calculatedDistance;
      });
    }).catchError((error) {
      // Xử lý lỗi nếu có
    });
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

      // Add data
      databaseReference.push().set({
        'userId': widget.userCredential.user?.uid.toString(),
        'shopId': widget.foods[0].shopId,
        'name': _editedUsername,
        'address': _editedAddress,
        'phoneNumber': _editedPhoneNumber,
        'isScheduled': isScheduled,
        'dateScheduled': isScheduled
            ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
            : "",
        'timeScheduled':
            isScheduled ? "${selectedTime.hour}:${selectedTime.minute}" : "",
        'paymentMethod': _selectedValue == 1 ? "CASH" : "ONLINE",
        'status': "PENDING",
        'foods': widget.foods.map((food) => food.toJson()).toList(),
        'discount': returnedDiscount ?? 0,
        'shippingFee': shippingFee,
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

  void checkOutPayPal(String money) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId:
                  "ARA2HLL2SbIBVJ2hTeV_N_3B4YsBnRdw4B3Dee5W1PO9UdCSgOHAPGCQeG7rPizD6hLAN_38yQJLbdE5",
              secretKey:
                  "EKxLbi3dlt-QNxpBTvV7ipBEEBVFFDj8eSEOGA_mB6_dFZKlqOaV85aDftTbNTIOZEuH3tbFon-xe7L6",
              transactions: [
                {
                  "amount": {
                    "total": money,
                    "currency": "USD",
                    "details": {
                      "subtotal": money,
                      "shipping": '0',
                      "shipping_discount": 0
                    }
                  },
                  "description": "The payment transaction description.",
                  "item_list": {
                    "items": [],
                  }
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                Navigator.pop(context);
                pushNewOrder();
              },
              onCancel: () {
                Navigator.pop(context);
              },
              onError: (error) {
                // Handle error
                Navigator.pop(context);
              },
            )));
  }

  void checkOutOrder() {
    if (_editedUsername.isEmpty ||
        _editedPhoneNumber.isEmpty ||
        _editedAddress.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Thông báo',
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 18,
                  color: AppColors.orangeColor,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Vui lòng nhập đầy đủ thông tin',
              style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Đóng',
                  style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    if (_selectedValue == 2) {
      // Convert vnd to usd
      double moneyUsd = _totalMoney * 0.000041;
      moneyUsd = double.parse(moneyUsd.toStringAsFixed(1));
      print(moneyUsd.toString());

      checkOutPayPal(moneyUsd.toString());
    } else {
      pushNewOrder();
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
        _subTotalMoney += calculateSubtotalPrice(food);
      }
    });

    _editedUsername = widget.username;
    _editedPhoneNumber = widget.phoneNumber;
    _editedAddress = widget.address;
    _isInitialized = true;
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
                      onTap: () async {
                        if (!_isInitialized) {
                          return; // Return if not initialized yet
                        }
                        final editedData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUserInfoScreen(
                              name: _editedUsername,
                              phoneNumber: _editedPhoneNumber,
                              address: _editedAddress,
                            ),
                          ),
                        );

                        if (editedData != null) {
                          setState(() {
                            _editedUsername =
                                editedData['name'] ?? _editedUsername;
                            _editedPhoneNumber =
                                editedData['phoneNumber'] ?? _editedPhoneNumber;
                            _editedAddress =
                                editedData['address'] ?? _editedAddress;
                          });
                          updateShippingInfo();
                        }
                      },
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
                  _editedUsername,
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
                  _editedAddress,
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
                  _editedPhoneNumber,
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
                title: Text(
                  AppLocalizations.of(context)!.cashPayment,
                  style: TextStyle(fontFamily: 'Comfortaa'),
                ),
                groupValue: _selectedValue,
                activeColor: AppColors.orangeColor,
                onChanged: (value) => _selectPaymentMethod(value!)),

            RadioListTile(
                value: 2,
                title: Text(
                  AppLocalizations.of(context)!.onlinePayment,
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

            const SizedBox(
              height: 20,
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
                      "Tạm tính",
                      style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${NumberFormat.decimalPattern().format(_subTotalMoney).replaceAll(',', '.').toString()}Đ",
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          color: AppColors.orangeColor),
                    ),
                  ),
                ],
              ),
            ),

            //
            const SizedBox(
              height: 20,
            ),

            //Shipping fee
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Phí giao hàng " + " ( ${distance} km )",
                      style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${NumberFormat.decimalPattern().format(shippingFee).replaceAll(',', '.').toString()}Đ",
                      style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          color: AppColors.mediumOrangeColor),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Visibility(
              visible: returnedDiscount != null && returnedDiscount != 0,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Mã giảm giá ",
                        style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "-" +
                            "${NumberFormat.decimalPattern().format(returnedDiscount ?? 0).replaceAll(',', '.').toString()}Đ",
                        style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            color: Color.fromRGBO(245, 131, 49, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  final discount = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllVoucherDetail(
                        shopId: widget.shopId,
                        subTotal: _subTotalMoney,
                        ship: shippingFee,
                      ),
                    ),
                  );

                  if (discount != null) {
                    setState(() {
                      returnedDiscount = discount;
                      updateTotalAmount();
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        returnedDiscount != null && returnedDiscount != 0
                        ?"Đã áp dụng mã giảm"
                        :"Thêm mã giảm", style: const TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mediumOrangeColor),),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: AppColors.mediumOrangeColor, // Màu cam
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${NumberFormat.decimalPattern().format(_totalMoney).replaceAll(',', '.').toString()}Đ",
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
                  onPressed: checkOutOrder,
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
