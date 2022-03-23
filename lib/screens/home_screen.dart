import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/kategorija_model.dart';
import 'package:monets/screens/search_result_screen.dart';
import 'package:monets/services/http_service.dart';
import 'package:monets/templates/home_template.dart';
import 'package:monets/templates/login_template.dart';
import 'package:monets/widgets/categories_widget.dart';
import 'package:monets/widgets/food_widget.dart';

import 'food_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  search(String query) {
    if (query.length >= 3) {
      searchController.clear();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchResult(searchQuery: query)));
    }
  }

  searchKategorija(int kategorijaId) {
    if (kategorijaId >= 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchResult(kategorijaId: kategorijaId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/main_screen_background.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 30.0, right: 10.0),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: ColorPallete.purple,
                                    width: 2.0,
                                  ),
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(10.0),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.9),
                                labelText: "Pretraga",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: ColorPallete.purple,
                                  size: 20.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintStyle: const TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                labelStyle: const TextStyle(
                                  fontSize: 15,
                                  color: ColorPallete.purple,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorPallete.yellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                            ),
                            onPressed: () => search(searchController.text),
                            child: const Icon(Icons.search,
                                color: ColorPallete.purple)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 30.0, right: 30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Kategorije",
                                  style: TextStyle(
                                      color: ColorPallete.purple,
                                      fontFamily: "Avenir-Medium",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                          //getCategoriesWidget(),
                          FutureBuilder<List<KategorijaModel>>(
                            future: HttpService.getKategorije(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: 140.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      var elementAt = snapshot.data!.elementAt(index);
                                      return GestureDetector(
                                        onTap: ()=> searchKategorija(elementAt.kategorijaId),
                                        child: CategoriesWidget(
                                          kategorija: elementAt,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Something went wrong ...');
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Preporučena jela",
                          style: TextStyle(
                              color: ColorPallete.purple,
                              fontFamily: "Avenir-Medium",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 100.0,
                    child: FutureBuilder<List<JeloModel>>(
                      future: HttpService.getPopularnaJela(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var elementAt = snapshot.data!.elementAt(index);
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodDetails(jelo: elementAt))),
                                child: FoodWidget(
                                  jelo: elementAt,
                                  isFavouriteScreen: false,
                                  kolicina: 0,
                                  rezervacija: 0,
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong ...');
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Widget getCategoriesWidget() {
  return SizedBox(
    height: 140,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const CategoriesWidget();
      },
    ),
  );
}*/
