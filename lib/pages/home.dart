import 'dart:convert';

import 'package:flutter/material.dart';
import '../components/MyDrawer.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Vegetables'),
            backgroundColor: Colors.green,
            actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
          ),
          drawer: MyDrawer(),
          body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/img/2.jpg"),
                      ),
                      title: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            text: snapshot.data[i]['title']),
                      ),
                      subtitle: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            text: snapshot.data[i]['body']),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
    );
  }
}
