import 'package:flutter/material.dart';
import 'package:meme/api_services/api_services.dart';
import 'package:meme/model/meme_model.dart';

class MemeList with ChangeNotifier {
  static const String url = "https://api.imgflip.com/get_memes";
  final List<MemeModel> memeList = [];

  Future getData() async {
    var response = await ApiServices().getApiData(url);
    if (response == null) {
      print("Failed to fetch data from API");
      return;
    }
    var data = response;

    memeList.clear();
    for (Map<String, dynamic> i in data) {
      memeList.add(
        MemeModel.fromJson(i),
      );
    }
    notifyListeners();
    return memeList;
  }
}
