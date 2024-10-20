
import 'package:http/http.dart' as http;
import 'dart:convert' as dc;
import 'dart:io' as io;

class ApiServices {

  //method to get data from the api
  Future<dynamic> getApiData(String url) async {
    http.Response response;
    dynamic data;

    try {

      //geting data from the api
      response = await http.get(Uri.parse(url));

      // Check if the status code is 200 (OK)
      if (response.statusCode == 200) {

        //decode the json data
        data = dc.jsonDecode(response.body.toString());
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
        return null;
      }
    } on io.SocketException {
      print("No internet connection");
      return null;
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }

    return data;
  }
}
