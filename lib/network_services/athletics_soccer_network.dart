import 'package:uscunionmobile/datamodel/athletics_soccer_model.dart';
import 'package:http/http.dart' as http;

class SoccerRemoteService {
  Future<List<SoccerDataModel>?> getSoccerPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://uscmobileapps.com/uscumobile/uscusports/uscusportsapi/loadsoccerdata_USCU.php");
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return soccerDataModelFromJson(json);
    }
  }
}



//https://uscmobileapps.com/loadnewsdata_USCU.php