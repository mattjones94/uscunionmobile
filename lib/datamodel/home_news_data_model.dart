import 'dart:convert';

List<NewsDataModel> newsDataModelFromJson(String str) => List<NewsDataModel>.from(json.decode(str).map((x) => NewsDataModel.fromJson(x)));

String newsDataModelToJson(List<NewsDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsDataModel {
    NewsDataModel({
        required this.newsid,
        required this.newstitle,
        required this.newsinfo,
        required this.newsimage,
    });

    String newsid;
    String newstitle;
    String newsinfo;
    String newsimage;

    factory NewsDataModel.fromJson(Map<String, dynamic> json) => NewsDataModel(
        newsid: json["newsid"],
        newstitle: json["newstitle"],
        newsinfo: json["newsinfo"],
        newsimage: json["newsimage"],
    );

    Map<String, dynamic> toJson() => {
        "newsid": newsid,
        "newstitle": newstitle,
        "newsinfo": newsinfo,
        "newsimage": newsimage,
    };
}
