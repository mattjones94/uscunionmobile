import 'package:uscunionmobile/datamodel/home_news_data_model.dart';
import 'package:http/http.dart' as http;

class NewsRemoteService {
  Future<List<NewsDataModel>?> getNewsPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://uscmobileapps.com/loadnewsdata_USCU.php");
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return newsDataModelFromJson(json);
    }
  }
}



//https://uscmobileapps.com/loadnewsdata_USCU.php