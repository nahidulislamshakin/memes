import 'package:http/http.dart' as http;
import 'dart:convert' as dc;
import 'dart:io' as io;

class ApiServices {
  

  Future getApiData (String url) async{
    http.Response response;
    dynamic data;
    try{
      response = await http.get(Uri.parse(url),);
      data = dc.jsonDecode(response.body.toString(),);
    } on io.SocketException{
      print("No internet Connection");
    }
    return data;
  }
}