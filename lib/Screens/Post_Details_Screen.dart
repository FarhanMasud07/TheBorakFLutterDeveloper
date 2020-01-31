import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Screens/Post_Individual_Comments.dart';

class PostDetails extends StatefulWidget {
  static const routename = '/post-details';

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  //final String url = "https://jsonplaceholder.typicode.com/posts/$";
  var data;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      // Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
      this.getJsonDataDetails();
    }
    _isInit = false;
    //dispose();
    super.didChangeDependencies();
  }

  Future<String> getJsonDataDetails() async {
    final postId = ModalRoute.of(context).settings.arguments as dynamic;
    final String url = "https://jsonplaceholder.typicode.com/posts/$postId";
    try {
      var res = await http.get(url);

      print(res.body);

      setState(() {
        var convertDataToJson = json.decode(res.body);
        data = convertDataToJson;
        print(data);
      });

      return "success";
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(postId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        centerTitle: true,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Text('Click the post for show comments'),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.cyanAccent,
                        child: Card(
                          elevation: 10.0,
                          child: GestureDetector(
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Title:  ${data['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Body:  ${data['body']}",
                                      // textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PostIndividualComment.routeName,
                                arguments: data['id'],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
