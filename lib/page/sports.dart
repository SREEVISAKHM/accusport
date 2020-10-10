import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports/api/api.dart';
import 'package:sports/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<UserModel> _userModel;

  @override
  void initState() {
    _userModel = API().getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ACCUSPORTS',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
        child: FutureBuilder<UserModel>(
          future: _userModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];

                    _launchURL() async {
                      var url = article.url;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    return Container(
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.urlToImage,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  article.author,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.title,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 7, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.description,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                RaisedButton(
                                  color: Colors.transparent,
                                  onPressed: _launchURL,
                                  child: Text(
                                    article.url,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
