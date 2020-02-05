

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:haber_app/model/news.dart';
import 'package:http/http.dart' as http;
class NewsService{

  static final NewsService _newsService = NewsService._internal();

  factory NewsService(){
    return _newsService;
  }

  NewsService._internal();

  //Request yapılacak api'nin URL adresi
  static final String testUrl="192.168.1.122";
  static final String baseUrl="209.97.135.176";

  //Veriler Çekildiğinde kullanılıcak olan global nesneler.
  News news;
  NewsList newsList;


  //Haberlerin liste halinde çekildiği metot
  Future<List<News>> getNews() async {
    var response = await http.get("http://$baseUrl:8080/api/haberler");
    if (response.statusCode == 200) {
      //return Gonderi.fromJsonMap(json.decode(response.body));
      return (json.decode(response.body) as List)
          .map((singleNews) => News.fromJson(singleNews))
          .toList();
    } else {
      throw Exception("Baglanamadık ${response.statusCode}");
    }
  }
  //Haberlerin liste halinde çekildiği metot
  Future<bool> postNews(News news) async {
    Map<String, String> headers = {"Content-type": "application/json"};

  debugPrint(jsonEncode(news.toJson()));

    var response = await http.post("http://$baseUrl:8080/api/yeniHaber",body: jsonEncode(news.toJson()),headers: headers);
    if (response.statusCode == 200) {
      debugPrint('Post işlemi başarılı.');
      return true;

    } else {

      return false;

    }
  }

  Future<bool> updateNews(News news) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    debugPrint(jsonEncode(news.toJson()));

    var response = await http.put("http://$baseUrl:8080/api/${news.id}",body: jsonEncode(news.toJson()),headers: headers);
    if (response.statusCode == 200) {
      debugPrint('Put işlemi başarılı.');
      return true;

    } else {

      return false;

    }
  }


  Future<bool> deleteNews(News news) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    debugPrint(jsonEncode(news.toJson()));

    var response = await http.delete("http://$baseUrl:8080/api/${news.id}",headers: headers);
    if (response.statusCode == 200) {
      debugPrint('Delete işlemi başarılı.');
      return true;

    } else {

      return false;

    }
  }

}