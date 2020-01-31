import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostIndividualComment extends StatefulWidget {
  static const routeName = '/post-comment';

  @override
  _PostIndividualCommentState createState() => _PostIndividualCommentState();
}

class _PostIndividualCommentState extends State<PostIndividualComment> {
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
    final postId = ModalRoute.of(context).settings.arguments;
    print(postId);
    final String url =
        "https://jsonplaceholder.typicode.com/posts/$postId/comments";

    try {
      var res = await http.get(url);

      // print(res.body);

      setState(() {
        var convertDataToJson = json.decode(res.body);
        data = convertDataToJson;
        //print(data);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (ctx, i) {
                return Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.deepPurple,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.amber,
                      child: Card(
                        elevation: 10.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "Name:  ${data[i]['name']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "Email:  ${data[i]['email']}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
