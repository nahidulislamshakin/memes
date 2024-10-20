import 'package:flutter/material.dart';
import 'package:meme/api_services/api_services.dart';
import 'package:meme/model/meme_model.dart';

class MemeList with ChangeNotifier {
  static const String url = "https://api.imgflip.com/get_memes";

  //list to put api data
  final List<Memes> memeList = [];
  List<Memes> filteredMemes = [];

//This method add api data to the list using model class
  Future getData() async {

    //getting api data
    var response = await ApiServices().getApiData(url);
    if (response == null) {
      return;
    }

//adding data to list
    var data = response['data']['memes'];
    memeList.clear();
    for (Map<String, dynamic> i in data) {
      memeList.add(
        Memes.fromJson(i),
      );
    }
//listening every changes in the list to update UI
    notifyListeners();
    return memeList;
  }


//this method is used to get the searched data
  void getSearchData(String searchText) {
    
//searching
    filteredMemes = memeList
        .where(
          (meme) =>
              meme.name != null &&
              meme.name!.toLowerCase().contains(searchText),
        )
        .toList();

        //listening changes in the search list
        notifyListeners();
      
  }
}
