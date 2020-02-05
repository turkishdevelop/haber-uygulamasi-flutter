import 'package:flutter/material.dart';
import 'package:haber_app/layout/add_news.dart';
import 'package:haber_app/layout/update_news.dart';
import 'package:haber_app/model/news.dart';
import 'package:haber_app/service/rest_service.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> newsList;
  NewsService _newsService;
  bool isDeleted=false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
 // final _scaffoldKey = GlobalKey<ScaffoldState>();
  int newsLength;

  @override
  void initState() {
    super.initState();
    newsList = List();
    _newsService = NewsService();
    newsLength=0;
    readDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewsPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Haberler'),
      ),
      body: _appBody(),
    );
  }

  _appBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: cardNewsList(),
    );
/* return Container();*/
  }

  cardNewsList() {
    readDataFromApi();
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: Colors.red,

      semanticsLabel: "Yükleniyor",
      child: ListView.builder(
        itemBuilder: (context, index) {
          return cardNews(context, index);
        },
        itemCount: newsLength,
      ),
      key: refreshKey,
      onRefresh: readDataFromApi,
    );
  }

  cardNews(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpdateNewsPage(newsList[index])));
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height / 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  '${newsList[index].pictureLink}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text('${newsList[index].title}'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('${newsList[index].shortInformation}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${newsList[index].date}'),
                Text('Yazar : ${newsList[index].author}'),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _delete(index,context);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> readDataFromApi() async {
   // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

      _newsService.getNews().then((newsListFromApi) {

        setState(() {
          newsList = newsListFromApi;
          newsLength=newsList.length;
        });

      });

    return null;
  }

  deleteData(int index) async {
    _newsService.deleteNews(newsList[index]).then((isDeleted) {
      setState(() {
        this.isDeleted = isDeleted;
      });

    });
  }

  Future<void> _delete(int index,BuildContext context)  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Haber Sil'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Haberi silmek istediğine emin misin ?'),
                Text('${newsList[index].title} haberi silinecek'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Vazgeç'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Onayla'),
              onPressed: () {
                //  _delete(index);
                deleteData(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
