import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/screens/food_details_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/widgets/food_widget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  refresh(int jeloId)async {
    await HttpService.ukloniJeloIzFavorita(jeloId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicHeight(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Favoriti",
                  style: TextStyle(
                      color: ColorPallete.purple,
                      fontFamily: "Avenir-Medium",
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.0,
                      fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: Container(
                height: MediaQuery.of(context).size.height/1.4,
                child: FutureBuilder<List<JeloModel>>(
                  future: HttpService.getNajdrazaJela(
                      HttpService.klijent.klijentId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var elementAt = snapshot.data!.elementAt(index);
                          return GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodDetails(jelo: elementAt))),
                            child: FoodWidget(
                              jelo: elementAt,
                              isFavouriteScreen: true, notifyParent: refresh)
                            );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong ...');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
