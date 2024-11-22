import 'dart:convert';

List<BaseballDataModel> baseballDataModelFromJson(String str) => List<BaseballDataModel>.from(json.decode(str).map((x) => BaseballDataModel.fromJson(x)));

String baseballDataModelToJson(List<BaseballDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaseballDataModel {
    BaseballDataModel({
        required this.bballfirstname,
        required this.bballlastname,
        required this.bballimage,
        required this.bballposition,
    });

    String bballfirstname;
    String bballlastname;
    String bballimage;
    String bballposition;

    factory BaseballDataModel.fromJson(Map<String, dynamic> json) => BaseballDataModel(
        bballfirstname: json["bballfirstname"],
        bballlastname: json["bballlastname"],
        bballimage: json["bballimage"],
        bballposition: json["bballposition"],
    );

    Map<String, dynamic> toJson() => {
        "bballfirstname": bballfirstname,
        "bballlastname": bballlastname,
        "bballimage": bballimage,
        "bballposition": bballposition,
    };
}
