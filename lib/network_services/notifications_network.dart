
import 'package:uscunionmobile/datamodel/notifications_model.dart';
import 'package:http/http.dart' as http;

class UnionNotificationsNetworkService {
  Future<List<NotificationsDataModel>?> getUnionNotificationsPost() async {
    var client = http.Client();

    var uri = Uri.parse("https://uscmobileapps.com/uscumobile/uscunotifications/loadnotificationsdata_USCU.php");
    var response = await client.get(uri);
    if(response.statusCode == 200) {
      var json = response.body;
      return notificationDataModelFromJson(json);
    }
  }
}