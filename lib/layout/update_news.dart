import 'package:flutter/material.dart';
import 'package:haber_app/model/news.dart';
import 'package:haber_app/service/rest_service.dart';

class UpdateNewsPage extends StatefulWidget {

  News haber;

  UpdateNewsPage(News gelenHaber){
    this.haber=gelenHaber;
  }




  @override
  _UpdateNewsPageState createState() => _UpdateNewsPageState();
}

class _UpdateNewsPageState extends State<UpdateNewsPage> {
  NewsService _newsService;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final pictureLinkController = TextEditingController();
  final shortInformationController = TextEditingController();
  final contentController = TextEditingController();
  final authorController = TextEditingController();

  String newsTitle;
  String pictureLink;
  String shortInformation;
  String content;
  String author;
  String date;

  bool isSuccessful;

  @override
  void initState() {
    _newsService = NewsService();
    isSuccessful = false;
    date = "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
    super.initState();

    titleController.text=widget.haber.title;
    pictureLinkController.text=widget.haber.pictureLink;
    shortInformationController.text=widget.haber.shortInformation;
    contentController.text=widget.haber.content;
    authorController.text=widget.haber.author;
  }

  @override
  void dispose() {
    authorController.dispose();
    contentController.dispose();
    shortInformationController.dispose();
    pictureLinkController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Haber Güncelle"),
        centerTitle: true,
      ),
      body: _addNewsBody(),
    );
  }

  _addNewsBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Form(
        child: _addNewsForm(),
        key: _formKey,
      ),
    );
  }

  _addNewsForm() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen haber başlığını giriniz.';
              }
              return null;
            },
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Haber başlığı giriniz',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen resim linkini giriniz.';
              }
              return null;
            },
            controller: pictureLinkController,
            decoration: InputDecoration(
                hintText: 'Resim linkini giriniz',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen kısa bilgi giriniz.';
              }
              return null;
            },
            controller: shortInformationController,
            decoration: InputDecoration(
                hintText: 'Kısa bilgi giriniz',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen haber içeriğini giriniz.';
              }
              return null;
            },
            controller: contentController,
            decoration: InputDecoration(
                hintText: 'Haber içeriğini giriniz',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Lütfen yazar adını giriniz.';
              }

              return null;
            },
            controller: authorController,
            decoration: InputDecoration(
                hintText: 'Yazar adını giriniz',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              color: Colors.red,
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //put işlemini burda yap.
                  newsTitle = titleController.text;
                  pictureLink = pictureLinkController.text;
                  author = authorController.text;
                  content = contentController.text;
                  shortInformation = shortInformationController.text;
                  _newsService.updateNews(News(
                    id: widget.haber.id,
                    title: newsTitle,
                    pictureLink: pictureLink,
                    author: author,
                    content: content,
                    shortInformation: shortInformation,
                    date: date,
                  )).then((isSaved){
                    debugPrint('Kayıt güncellendi.');
                  });
                }
              },
              color: Colors.green,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
