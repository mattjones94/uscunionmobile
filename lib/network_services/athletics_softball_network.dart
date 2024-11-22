import 'package:uscunionmobile/datamodel/athletics_softball_model.dart';
import 'package:http/http.dart' as http;

class SoftballRemoteService {
  Future<List<SoftballDataModel>?> getSoftballPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://uscmobileapps.com/uscumobile/uscusports/uscusportsapi/loadsoftballdata_USCU.php");
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return softballDataModelFromJson(json);
    }
  }
}



//https://uscmobileapps.com/loadnewsdata_USCU.php