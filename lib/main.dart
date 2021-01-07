import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fcgStore/Arama.dart';
import 'package:fcgStore/models/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/news_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anasayfa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnaSayfa(title: 'Haberler'),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  AnaSayfa({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int secilenMenuItem = 0;
  List<Articles> articles = [];
  AnaSayfa sayfaAna;
  AramaSayfasi sayfaArama;

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value;
      });
    });
    super.initState();
    sayfaAna = AnaSayfa() as AnaSayfa;
    sayfaArama = AramaSayfasi();
    // = [sayfaAna, sayfaArama];
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: 40,
        leading: Icon(
          Icons.verified_outlined,
          size: 30.0,
          color: Colors.white,
        ),
        title: Text("HABERLER"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        backgroundColor: Colors.red[50],
        color: Colors.transparent,
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(articles[index].urlToImage),
                  ListTile(
                    title: Text(articles[index].title),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(articles[index].description),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                          child: Text('Haberi Oku'),
                          autofocus: false,
                          textColor: Colors.deepOrangeAccent,
                          onPressed: () async {
                            await launch(articles[index].url);
                          }),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavMenu(),
    );
  }

  CurvedNavigationBar BottomNavMenu() {
    return CurvedNavigationBar(
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      height: 50,
      items: <Widget>[
        Icon(Icons.wysiwyg_sharp, size: 35, color: Colors.redAccent),
        Icon(Icons.sports_basketball_sharp, size: 40, color: Colors.redAccent),
        Icon(Icons.whatshot, size: 35, color: Colors.redAccent),
      ],
      animationDuration: Duration(milliseconds: 200),
      onTap: (index) {
        debugPrint("tıklandı1 $index");
      },
      backgroundColor: Colors.red[50],
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
