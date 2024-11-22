import 'dart:convert';

List<VolleyballDataModel> volleyballDataModelFromJson(String str) => List<VolleyballDataModel>.from(json.decode(str).map((x) => VolleyballDataModel.fromJson(x)));

String volleyballDataModelToJson(List<VolleyballDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VolleyballDataModel {
    VolleyballDataModel({
        required this.vball_first_name,
        required this.vball_last_name,
        required this.vball_position,
        required this.vball_image,
    });

    String vball_first_name;
    String vball_last_name;
    String vball_position;
    String vball_image;

    factory VolleyballDataModel.fromJson(Map<String, dynamic> json) => VolleyballDataModel(
        vball_first_name: json["vball_first_name"],
        vball_last_name: json["vball_last_name"],
        vball_position: json["vball_position"],
        vball_image: json["vball_image"],
    );

    Map<String, dynamic> toJson() => {
        "vball_first_name": vball_first_name,
        "vball_last_name": vball_last_name,
        "vball_position": vball_position,
        "vball_image": vball_image,
    };
}
