import 'package:flutter/material.dart';
import './Screens/Post_Details_Screen.dart';
import './Screens/Post_Individual_Comments.dart';

import 'Widgets/Post_Widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Post(),
      routes: {
        PostDetails.routename: (ctx) => PostDetails(),
        PostIndividualComment.routeName: (ctx) => PostIndividualComment(),
      },
    );
  }
}
