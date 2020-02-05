
import 'dart:convert';

NewsList newsListFromJson(String str){
  final jsonData=json.decode(str);
  return NewsList.fromJson(jsonData);
}

String newsListToJson(NewsList data){
  final writeData=data.toJson();
  return json.encode(writeData);
}

class NewsList{

  List<News> newsList;

  NewsList({this.newsList});

  factory NewsList.fromJson(Map<String,dynamic> jsonData)=>new NewsList(
    newsList: jsonData['newsList']==null?null: new List<News>.from(jsonData['newsList'].map((x)=>News.fromJson(x))),
  );

  Map<String,dynamic> toJson()=>{
    "newsList":newsList==null?null:new List<dynamic>.from(newsList.map((x)=>x.toJson())),
  };


}



class News{
  String id;
  String pictureLink;
  String title;
  String content;
  String shortInformation;
  String date;
  String author;


  News({this.id,this.title,this.pictureLink,this.content,this.author,this.date,this.shortInformation});

  factory News.fromJson(Map<String,dynamic> jsonData)=>new News(
    id:jsonData['_id']==null?null:jsonData['_id'],
    title: jsonData['title']==null?null:jsonData['title'],
    shortInformation: jsonData['shortInformation']==null?null:jsonData['shortInformation'],
    content: jsonData['content']==null?null:jsonData['content'],
    pictureLink: jsonData['pictureLink']==null?null:jsonData['pictureLink'],
    author: jsonData['author']==null?null:jsonData['author'],
    date: jsonData['date']==null?null:jsonData['date'],
  );


  Map<String, dynamic> toJson() => {

    "_id":id==null?null:id,
    "title": title == null ? null : title,
    "content": content == null ? null : content,
    "pictureLink": pictureLink == null ? null : pictureLink,
    "author": author == null ? null : author,
    "date": date == null ? null : date,
    "shortInformation":shortInformation==null?null:shortInformation,
  };
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['content'] = content;
    map['pictureLink'] = pictureLink;
    map['author'] = author;
    map['date'] = date;

    return map;
  }
}