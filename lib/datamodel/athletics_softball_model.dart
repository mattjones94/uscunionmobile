import 'dart:convert';

List<SoftballDataModel> softballDataModelFromJson(String str) => List<SoftballDataModel>.from(json.decode(str).map((x) => SoftballDataModel.fromJson(x)));

String softballDataModelToJson(List<SoftballDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoftballDataModel {
    SoftballDataModel({
        required this.soft_first_name,
        required this.soft_last_name,
        required this.soft_position,
        required this.soft_image,
    });

    String soft_first_name;
    String soft_last_name;
    String soft_position;
    String soft_image;

    factory SoftballDataModel.fromJson(Map<String, dynamic> json) => SoftballDataModel(
        soft_first_name: json["soft_first_name"],
        soft_last_name: json["soft_last_name"],
        soft_position: json["soft_position"],
        soft_image: json["soft_image"],
    );

    Map<String, dynamic> toJson() => {
        "soft_first_name": soft_first_name,
        "soft_last_name": soft_last_name,
        "soft_position": soft_position,
        "soft_image": soft_image,
    };
}
