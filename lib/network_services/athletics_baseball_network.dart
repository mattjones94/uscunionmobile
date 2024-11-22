import 'package:uscunionmobile/datamodel/athletics_baseball_model.dart';
import 'package:http/http.dart' as http;

class BaseballRemoteService {
  Future<List<BaseballDataModel>?> getBaseballPost() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://uscmobileapps.com/uscumobile/uscusports/uscusportsapi/loadbaseballdata_USCU.php");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return baseballDataModelFromJson(json);
    }
  }
}



//https://uscmobileapps.com/loadnewsdata_USCU.php


// RSS feed to get the data from the usc Union athletics page events
// ---https://www.uscunionathletics.com/composite?print=rss&view=1