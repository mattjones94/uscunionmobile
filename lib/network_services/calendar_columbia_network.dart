import 'package:uscunionmobile/datamodel/calendar_col_events_model.dart';
import 'package:http/http.dart' as http;

class ColumbiaCalenderNetworkService {
  Future<List<columbiaCalendarEvent>?> getColumbiaCalendarPost() async {
    var client = http.Client();

    var uri = Uri.parse(
        "https://25livepub.collegenet.com/calendars/cal-plm-union-public.json");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return columbiaCalendarEventsFromJson(json);
    }
  }
}
