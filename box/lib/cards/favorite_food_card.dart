import 'package:box/class/food.dart';
import 'package:box/utils/colors.dart';
import 'package:flutter/material.dart';

class FavoriteFoodCard extends StatefulWidget {
  final Food food;
  final Function(Food, bool) updateFavoriteFoods;

  const FavoriteFoodCard(
      {super.key, required this.food, required this.updateFavoriteFoods});

  @override
  State<FavoriteFoodCard> createState() => _FavoriteFoodCardState();
}

class _FavoriteFoodCardState extends State<FavoriteFoodCard> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 100,
      width: double.infinity,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFECECEC), width: 2)),
          color: const Color(0xFFF7F7F7)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network(
              widget.food.foodImage,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),

          //
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  widget.food.foodName,
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              //
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10.0),
              //   child: SizedBox(
              //     width: 200,
              //     child: Text(
              //       "Milano Coffee",
              //       style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //   ),
              // ),

              //
              SizedBox(
                width: 200,
                child: Text(
                  widget.food.foodPrice.toString(),
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 15),
                ),
              )
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_isFavorite) {
                        widget.updateFavoriteFoods(widget.food, true);
                        _isFavorite = false;
                      } else {
                        widget.updateFavoriteFoods(widget.food, false);
                        _isFavorite = true;
                      }
                    });
                  },
                  child: Icon(
                    _isFavorite
                        ? Icons.favorite_outlined
                        : Icons.favorite_border_outlined,
                    size: 30,
                    color: AppColors.orangeColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
