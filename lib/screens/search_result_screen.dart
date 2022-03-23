import 'package:flutter/material.dart';

import '../constants/color_pallete.dart';
import '../models/jelo_model.dart';
import '../services/http_service.dart';
import '../widgets/food_widget.dart';
import 'food_details_screen.dart';

class SearchResult extends StatefulWidget {
  late String searchQuery;
  late int kategorijaId;

  SearchResult({Key? key, this.searchQuery="", this.kategorijaId=0}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                      )),
                ),
                const Spacer(),
                const IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 15.0, bottom: 15.0, right: 60.0),
                      child: Text(
                        'Rezultati pretrage',
                        style: TextStyle(
                            color: ColorPallete.purple,
                            fontFamily: "Avenir-Medium",
                            fontWeight: FontWeight.w500,
                            letterSpacing: -1.0,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 30.0, right: 30.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 100.0,
              child: FutureBuilder<List<JeloModel>>(
                future: HttpService.pretragaJela(widget.searchQuery, widget.kategorijaId),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return const Text("Jela nisu pronađena");
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var elementAt = snapshot.data!.elementAt(index);
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetails(jelo: elementAt,))),
                          child: FoodWidget(
                            jelo: elementAt,
                            isFavouriteScreen: false,
                            kolicina: 0,
                          ),
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
    ));
  }
}
