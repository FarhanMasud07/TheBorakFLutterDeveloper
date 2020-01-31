import 'package:flutter/material.dart';
import '../Screens/Post_Details_Screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final String url = "https://jsonplaceholder.typicode.com/posts";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    try {
      var res = await http.get(url);

      print(res.body);

      setState(() {
        var convertDataToJson = json.decode(res.body);
        data = convertDataToJson;
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
    // final products =
    //     Provider.of<ProductProvider>(context).fetchAndSetProducts();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('List Of All Post')),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (ctx, i) {
          return data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.cyan,
                    child: Card(
                      elevation: 5.0,
                      child: GestureDetector(
                        child: Center(
                          child: Text(
                            "Title:  ${data[i]['title']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PostDetails.routename,
                            arguments: data[i]['id'],
                          );
                        },
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
