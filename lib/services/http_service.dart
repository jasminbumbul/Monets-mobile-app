import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:monets/constants/constants.dart';
import 'package:monets/models/favorit_model.dart';
import 'package:monets/models/grad_model.dart';
import 'package:monets/models/jelo_model.dart';
import 'package:monets/models/jelo_rezervacija_model.dart';
import 'package:monets/models/kategorija_model.dart';
import 'package:monets/models/klijent_insert_model.dart';
import 'package:monets/models/klijent_model.dart';
import 'package:monets/models/login_model.dart';
import 'package:monets/models/password_reset_model.dart';
import 'package:monets/models/rezervacija_insert_model.dart';
import 'package:monets/models/rezervacija_model.dart';
import 'package:monets/models/rezervacija_search_model.dart';
import 'package:monets/models/rezervacija_update_model.dart';
import 'package:monets/models/stol_model.dart';
import 'package:monets/models/vrijeme_model.dart';

class HttpService {
  static String authToken = "";
  static KlijentModel klijent = KlijentModel.Default();

  static Future<KlijentModel> loginKlijenta(
      String korisnickoIme, String lozinka) async {
    const String apiUrl = Constants.serverRoute + Constants.klijentLoginRoute;
    final LoginModel loginModel = LoginModel(korisnickoIme, lozinka);
    authToken =
        'Basic ' + base64Encode(utf8.encode('$korisnickoIme:$lozinka'));
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Authorization": authToken,
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(loginModel));
    if (response.statusCode == 200) {
      klijent = KlijentModel.fromJson(json.decode(response.body));
      return compute(login, response.body);
    } else {
      throw Exception("Error while logging in");
    }
  }

  static KlijentModel login(String response) {
    if (response.isNotEmpty) {
      return KlijentModel.fromJson(json.decode(response));
    } else {
      throw Exception('Response is empty');
    }
  }

  static Future<KlijentModel> registracijaKlijenta(
      KlijentInsertModel klijent) async {
    const String apiUrl =
        Constants.serverRoute + Constants.klijentRegisterRoute;
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(klijent));
    if (response.statusCode == 200) {
      return compute(registracija, response.body);
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<KlijentModel> updateKlijenta(
      KlijentInsertModel klijentInsertRequest) async {
    String apiUrl =
        Constants.serverRoute + Constants.klijentRegisterRoute+"/"+klijent.klijentId.toString();
    final response = await http.put(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(klijentInsertRequest));
    if (response.statusCode == 200) {
      return compute(registracija, response.body);
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static KlijentModel registracija(String response) {
    if (response.isNotEmpty) {
      return KlijentModel.fromJson(json.decode(response));
    } else {
      throw Exception('Response is empty');
    }
  }

  static Future<List<GradModel>> getGradove() async {
    const String apiUrl = Constants.serverRoute + Constants.gradoviRoute;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      return compute(gradovi, response.body);
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static List<GradModel> gradovi(String response) {
    if (response.isNotEmpty) {
      return (jsonDecode(response) as List)
          .map((e) => GradModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Response is empty');
    }
  }

  static Future<List<JeloModel>> getPopularnaJela() async {
    final response =
        await http.get(Uri.parse(Constants.serverRoute + Constants.jelaRoute),headers: {"Authorization": authToken});
    if (response.statusCode == 200) {
      return compute(getPopularnoJelo, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

  static List<JeloModel> getPopularnoJelo(String response) {
    if (response.isNotEmpty) {
      return (jsonDecode(response) as List)
          .map((e) => JeloModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  static Future<List<KategorijaModel>> getKategorije() async {
    final response = await http
        .get(Uri.parse(Constants.serverRoute + Constants.kategorijeRoute),headers: {"Authorization": authToken});
    if (response.statusCode == 200) {
      return compute(getKategorija, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

  static List<KategorijaModel> getKategorija(String response) {
    if (response.isNotEmpty) {
      return (jsonDecode(response) as List)
          .map((e) => KategorijaModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  static Future<List<RezervacijaModel>> getRezervacije(
      RezervacijaSearchModel searchRequest) async {

    var statusQuery = searchRequest.status==true?"?Status=true":searchRequest.status==false?"?Status=false":"";
    var klijentQuery = searchRequest.klijentId!=0?"KlijentId="+searchRequest.klijentId.toString():"";

    if(statusQuery!="" && searchRequest.klijentId!=0){
      statusQuery+="&";
    }
    else if(statusQuery=="" && searchRequest.klijentId!=0){
      statusQuery+="?";
    }

    var statusKlijentQuery = statusQuery+klijentQuery;
    var potvrdjenaQuery = "potvrdjenaKlijent="+searchRequest.potvrdjenaKlijent.toString();
    if(statusKlijentQuery =="" ){
      statusKlijentQuery  += "?"+potvrdjenaQuery;
    }
    else{
      statusKlijentQuery  += "&"+potvrdjenaQuery;
    }

    var url = Constants.serverRoute + Constants.rezervacijeRoute.toString()+statusKlijentQuery;

    final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": authToken,
          "Accept": "application/json",
          "content-type": "application/json"
        });
    if (response.statusCode == 200) {
      return compute(getRezervacija, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

  static List<RezervacijaModel> getRezervacija(String response) {
    if (response.isNotEmpty) {
      return (jsonDecode(response) as List)
          .map((e) => RezervacijaModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  static Future<List<JeloModel>> getNajdrazaJela(int klijentId) async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute + Constants.favoritiRoute+"?klijentId="+klijent.klijentId.toString()),headers: {"Authorization": authToken});
    if (response.statusCode == 200) {
      return compute(getNajdrazeJelo, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

  static List<JeloModel> getNajdrazeJelo(String response) {
    if (response.isNotEmpty) {
      return (jsonDecode(response) as List)
          .map((e) => JeloModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  static Future<FavoritModel> dodajJeloUFavorite(int jeloId) async {
    var favoritModel = FavoritModel(0, jeloId, klijent.klijentId);
    final response =
    await http.post(Uri.parse(Constants.serverRoute + Constants.favoritiRoute), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    },  body: jsonEncode(favoritModel));
    if (response.statusCode == 200) {
      return compute(dodajJelo, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

  static FavoritModel dodajJelo(String response) {
    if (response.isNotEmpty) {
      return FavoritModel.fromJson(json.decode(response));
    } else {
      throw Exception('Response is empty');
    }
  }


  static Future<FavoritModel> ukloniJeloIzFavorita(int jeloId) async {
    var favoritModel = FavoritModel(0, jeloId, klijent.klijentId);
    final response =
    await http.delete(Uri.parse(Constants.serverRoute + Constants.favoritiRoute), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    },  body: jsonEncode(favoritModel));
    if (response.statusCode == 200) {
      return compute(ukloniJelo, response.body);
    } else {
      throw Exception('Something went wrong...');
    }
  }

    static FavoritModel ukloniJelo(String response) {
    if (response.isNotEmpty) {
      return FavoritModel.fromJson(json.decode(response));
    } else {
      throw Exception('Response is empty');
    }
  }

  static Future<JeloModel?> provjeriJeLiJeloFavorit(int jeloId) async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute +Constants.favoritiRoute+ Constants.checkJeloFavorit+"?KlijentId="+klijent.klijentId.toString()+"&JeloId="+jeloId.toString()), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200) {
      return JeloModel.fromJson(json.decode(response.body));
    } else if(response.statusCode==204) {
      return null;
    }
    else{
      throw Exception('Something went wrong...');
    }
  }

  static void posaljiKonfirmacijskiMail(int klijentId) async {
    final response =
    await http.post(Uri.parse(Constants.serverRoute + Constants.posaljiKonfirmacijskiMail+"?klijentId="+klijentId.toString()), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode != 200) {
      throw Exception('Something went wrong...');
    }
  }

  static Future<dynamic> posaljiKodZaRestartPassworda(String email) async {
    final response =
    await http.post(Uri.parse(Constants.serverRoute + Constants.posaljiPasswordResetMail+"?email="+email), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode != 200) {
      throw Exception('Something went wrong...');
    }
  }
  static Future<dynamic> posaljiKodNaVerifikaciju(String email, String code) async {
    var provjeraKodaModel = PasswordResetModel(email,"","",code);
    final response =
    await http.put(Uri.parse(Constants.serverRoute+Constants.klijentRegisterRoute + Constants.provjeraKoda), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    },body: json.encode(provjeraKodaModel));
    if (response.statusCode != 200) {
      throw Exception('Something went wrong...');
    }
  }

  static Future<dynamic> updatePassword(PasswordResetModel passwordRequest) async {
    final response =
    await http.put(Uri.parse(Constants.serverRoute+Constants.klijentRegisterRoute + Constants.updatePassworda), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    },body: json.encode(passwordRequest));
    if (response.statusCode != 200) {
      throw Exception('Something went wrong...');
    }
  }

  static Future<dynamic> logout() async {
    klijent=KlijentModel.Default();
    authToken="";
  }

  static Future<List<VrijemeModel>?>? getSlodobnaVremena(DateTime datum, int stolId) async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute+Constants.rezervacijeRoute+Constants.slobodnaVremenaRoute +"?date="+datum.toString()+"&stolId="+stolId.toString() ), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => VrijemeModel.fromJson(e))
          .toList();
    } else if(response.statusCode==204) {
      return null;
    }
    else{
      throw Exception('Something went wrong...');
    }
  }
  static Future<List<VrijemeModel>?>? getSlodobnaKrajnjaVremena(DateTime datum) async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute+Constants.rezervacijeRoute+Constants.slobodnaKrajnjaVremenaRoute +"?date="+datum.toString() ), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => VrijemeModel.fromJson(e))
          .toList();
    } else if(response.statusCode==204) {
      return null;
    }
    else{
      throw Exception('Something went wrong...');
    }
  }

  static Future<List<StolModel>?> getStolove() async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute +Constants.stolRoute), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200){
      return (jsonDecode(response.body) as List)
          .map((e) => StolModel.fromJson(e))
          .toList();
    } else if(response.statusCode==204) {
      return null;
    }
    else{
      throw Exception('Something went wrong...');
    }
  }

  static Future<List<JeloModel>?> getJelaIzRezervacije(int rezervacijaId) async {
    final response =
    await http.get(Uri.parse(Constants.serverRoute +Constants.rezervacijeRoute+Constants.jelaIzRezervacijeRoute+"?rezervacijaId="+rezervacijaId.toString()), headers: {
      "Authorization": authToken,
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200){
      return  (jsonDecode(response.body) as List)
          .map((e) => JeloModel.fromJson(e))
          .toList();
    } else if(response.statusCode==204) {
      return null;
    }
    else{
      throw Exception('Something went wrong...');
    }
  }

  static Future<RezervacijaModel> kreirajRezervaciju(
      RezervacijaInsertModel rezervacijaInsertModel) async {
    rezervacijaInsertModel.klijentId=klijent.klijentId;
    const String apiUrl =
        Constants.serverRoute + Constants.rezervacijeRoute;
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(rezervacijaInsertModel));
    if (response.statusCode == 200) {
      return RezervacijaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<dynamic> dodajJeloURezervaciju(
     JeloRezervacijaModel jeloRezervacijaModel) async {
    const String apiUrl =
        Constants.serverRoute + Constants.rezervacijeRoute + Constants.dodajJeloURezervaciju;
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(jeloRezervacijaModel));
    if (response.statusCode == 200) {
      return RezervacijaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<dynamic> ukloniJeloIzRezervacije(
      JeloRezervacijaModel jeloRezervacijaModel) async {
    const String apiUrl =
        Constants.serverRoute + Constants.rezervacijeRoute + Constants.ukloniJeloIzRezervacije;
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(jeloRezervacijaModel));
    if (response.statusCode == 200) {
      return RezervacijaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<JeloRezervacijaModel> getKolicinuZaJeloRezervaciju(
      int jeloId, int rezervacijaId) async {
     String apiUrl =
        Constants.serverRoute + Constants.rezervacijeRoute + Constants.getKolicinuZaJeloRezervaciju
    +"?jeloId="+jeloId.toString()+"&rezervacijaId="+rezervacijaId.toString();
    final response = await http.get(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    if (response.statusCode == 200) {
      return JeloRezervacijaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<RezervacijaModel> updateRezervaciju(int rezervacijaId,
      RezervacijaUpdateModel rezervacijaModel) async {
    rezervacijaModel.klijentId=klijent.klijentId;
    String apiUrl =
        Constants.serverRoute + Constants.rezervacijeRoute+"/"+rezervacijaId.toString();
    final response = await http.put(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(rezervacijaModel));
    if (response.statusCode == 200) {
      return RezervacijaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }

  static Future<List<JeloModel>> getJeloById(int jeloId) async {
    String apiUrl =
        Constants.serverRoute + Constants.jelaRoute+"?jeloId="+jeloId.toString();
    print(apiUrl);
    final response = await http.get(Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    if (response.statusCode == 200) {
      return  (jsonDecode(response.body) as List)
          .map((e) => JeloModel.fromJson(e))
          .toList();
    } else {
      throw Exception(
          response.statusCode.toString() + response.body.toString());
    }
  }
}