import 'dart:convert';

List<SoccerDataModel> soccerDataModelFromJson(String str) => List<SoccerDataModel>.from(json.decode(str).map((x) => SoccerDataModel.fromJson(x)));

String soccerDataModelToJson(List<SoccerDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoccerDataModel {
    SoccerDataModel({
        required this.soccer_first_name,
        required this.soccer_last_name,
        required this.soccer_position,
        required this.soccer_image,
    });

    String soccer_first_name;
    String soccer_last_name;
    String soccer_position;
    String soccer_image;

    factory SoccerDataModel.fromJson(Map<String, dynamic> json) => SoccerDataModel(
        soccer_first_name: json["soccer_first_name"],
        soccer_last_name: json["soccer_last_name"],
        soccer_position: json["soccer_position"],
        soccer_image: json["soccer_image"],
    );

    Map<String, dynamic> toJson() => {
        "soccer_first_name": soccer_first_name,
        "soccer_last_name": soccer_last_name,
        "soccer_position": soccer_position,
        "soccer_image": soccer_image,
    };
}
