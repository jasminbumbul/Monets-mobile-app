import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/kategorija_model.dart';

class CategoriesWidget extends StatefulWidget {
  final KategorijaModel kategorija;

  const CategoriesWidget({Key? key, required this.kategorija})
      : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        child: Column(
          children: [
            Container(
              height: 62.0,
              width: 62.0,
              decoration: BoxDecoration(
                image: getCategoryImage(widget.kategorija),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color: ColorPallete.yellow,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                widget.kategorija.naziv!,
                style: const TextStyle(
                    color: ColorPallete.purple,
                    fontFamily: "Avenir-Medium",
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DecorationImage getCategoryImage(KategorijaModel kategorija) {
  if (kategorija.slika == null || kategorija.slika!.isEmpty) {
    return const DecorationImage(
        image: AssetImage("assets/images/placeholder_food.png"),
        fit: BoxFit.fill);
  } else {
    return DecorationImage(
        image: NetworkImage(kategorija.slika!), fit: BoxFit.fill);
  }
}
