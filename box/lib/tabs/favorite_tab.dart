import 'package:box/cards/favorite_food_card.dart';
import 'package:box/class/food.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTab extends StatefulWidget {
  final bool isEmpty;
  final List<Food> favoriteFoods;
  final Function(Food, bool) updateFavoriteFoods;

  const FavoriteTab(
      {super.key,
      required this.isEmpty,
      required this.favoriteFoods,
      required this.updateFavoriteFoods});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteTabState();
  }
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: widget.isEmpty
            ? const EmptyFavorite()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      AppLocalizations.of(context)!.favoriteDishes,
                      style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.favoriteFoods.length,
                        itemBuilder: (context, index) {
                          return FavoriteFoodCard(
                            food: widget.favoriteFoods[index],
                            updateFavoriteFoods: widget.updateFavoriteFoods,
                          );
                        }),
                  )
                ],
              ));
  }
}

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            AppLocalizations.of(context)!.favoriteDishes,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
        ),
        Lottie.asset("assets/anim/shake_empty_box.json"),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            "Opps!!!",
            style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.favoriteEmpty,
          style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 20,
              color: AppColors.grayColor),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.mediumOrangeColor),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.addDish,
                    style: const TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
