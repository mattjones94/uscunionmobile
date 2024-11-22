import 'package:uscunionmobile/datamodel/athletics_volleyball_model.dart';
import 'package:http/http.dart' as http;

class VolleyballRemoteService {
  Future<List<VolleyballDataModel>?> getVolleyballPost() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://uscmobileapps.com/uscumobile/uscusports/uscusportsapi/loadvolleyballdata_USCU.php");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return volleyballDataModelFromJson(json);
    }
  }
}



//https://uscmobileapps.com/loadnewsdata_USCU.php

