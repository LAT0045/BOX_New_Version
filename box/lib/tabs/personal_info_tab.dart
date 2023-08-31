import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/colors.dart';

class PersonalInfoTab extends StatelessWidget {
  const PersonalInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          //Header Info
          Stack(
            children: [
              //Background
              SvgPicture.asset(
                "assets/svg/personalinfobg.svg",
                width: 400,
                height: 230,
                fit: BoxFit.cover,
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 35,
                        ),
                        Text(
                          AppLocalizations.of(context)!.personalInformation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        GestureDetector(
                          onTap: onPressedSettingBtn,
                          child: SvgPicture.asset(
                            "assets/svg/setting.svg",
                            width: 35,
                            height: 35,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      //Avatar
                      Container(
                        width: 105,
                        height: 105,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/svg/avatest.jpg"),
                          ),
                        ),
                      ),

                      const SizedBox(width: 30),

                      //Info
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Họ Tên",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Comfortaa',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "0769816622",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Comfortaa',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 40),

                      GestureDetector(
                        onTap: onPressedEdit,
                        child: SvgPicture.asset(
                          "assets/svg/edit.svg",
                          width: 35,
                          height: 35,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          //Order button
          Container(
            width: 330,
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.orangeColor, width: 1.5)), // Viền dưới
            ),
            child: ElevatedButton(
              onPressed: onPressedOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                elevation: 0,
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svg/order.svg",
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor, // Màu mới bạn muốn thay đổi
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.order,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  Transform.rotate(
                    angle: 3.14159265,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg", // Đường dẫn đến tệp SVG
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor, // Màu mới bạn muốn thay đổi
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //BuyAgain
          Container(
            width: 330,
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.orangeColor, width: 1.5)), // Viền dưới
            ),
            child: ElevatedButton(
              onPressed: onPressedBuyAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                elevation: 0,
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svg/buyagain.svg",
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor, // Màu mới bạn muốn thay đổi
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.repurchase,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                  Transform.rotate(
                    angle: 3.14159265,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg", // Đường dẫn đến tệp SVG
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor, // Màu mới bạn muốn thay đổi
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Voucher
          Container(
            width: 330,
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.orangeColor, width: 1.5)), // Viền dưới
            ),
            child: ElevatedButton(
              onPressed: onPressedVoucher,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                elevation: 0,
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svg/voucher.svg",
                    width: 35,
                    height: 35,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppLocalizations.of(context)!.hotDeal,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 140,
                  ),
                  Transform.rotate(
                    angle: 3.14159265,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg",
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Payments
          Container(
            width: 330,
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.orangeColor, width: 1.5)), // Viền dưới
            ),
            child: ElevatedButton(
              onPressed: onPressedPayments,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                elevation: 0,
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svg/payments.svg",
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.payment,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 81,
                  ),
                  Transform.rotate(
                    angle: 3.14159265,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg",
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Logout
          Container(
            width: 330,
            height: 60,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.orangeColor, width: 1.5)), // Viền dưới
            ),
            child: ElevatedButton(
              onPressed: onPressedLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                elevation: 0,
                alignment: Alignment.centerLeft,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/svg/logout.svg",
                    width: 40,
                    height: 40,
                    colorFilter: const ColorFilter.mode(
                      AppColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.signOut,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  Transform.rotate(
                    angle: 3.14159265,
                    child: SvgPicture.asset(
                      "assets/svg/backarrow.svg",
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColors.orangeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  //--------------------------------------------
  // Functions
  void onPressedBackBtn() {}
  void onPressedSettingBtn() {}
  void onPressedEdit() {}
  void onPressedOrder() {}
  void onPressedBuyAgain() {}
  void onPressedFavour() {}
  void onPressedVoucher() {}
  void onPressedPayments() {}
  void onPressedLogout() {}
}
