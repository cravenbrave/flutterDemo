import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

//Two top bars source:
//https://stackoverflow.com/questions/59675978/how-to-add-tabs-top-side-and-bottom-side-both-in-flutter
//Widge round shape & shadow source:
//https://stackoverflow.com/questions/57777737/flutter-give-container-rounded-border
//JSON file read source:
//https://faun.pub/flutter-implementing-listview-widget-using-json-file-fbd1e3ba60ad

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo LiuWenyi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  late TabController tabController;

  String title = "Home";

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  //build two tabs: by time & by owner
  //set styles: background, font, color, edge size etc
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 100.0,
            margin: EdgeInsets.only(top: 50, left: 80, right: 80),
            child: new TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "By Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Tab(
                    child: Text(
                      "By Owner",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ],
            ),
          ),
        ),
        //write each body in method
        body: TabBarView(
          children: [
            ByTimeScreen(),
            ByOwnerScreen(),
          ],
        ),
      ),
    );
  }
}

//By time body: set to empty, set background color
class ByTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
        child: Text("By Time body"),
    ),
    );
  }
}

//By owner stateless method, used in the MyApp builder
class ByOwnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MyHomePage()),
    );
  }
}

//By owner stateful method
class MyHomePage extends StatefulWidget {
  @override
  BodyByOwnerState createState() => BodyByOwnerState();
}

//By owner main method
class BodyByOwnerState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _ownerList(context),
    );
  }

  //Using listView builder return list, using FutureBuilder read JSON file
  Widget _ownerList(BuildContext context) {
    return FutureBuilder(
        //receives results and sends results to a Builder
        future:
        DefaultAssetBundle.of(context).loadString('lib/assets/ownerList.json'),
        builder: (context, snapshot) {
          // Decode the JSON
          var newData = json.decode(snapshot.data.toString());
          int index = newData.length;
          //return list, set up styles, set itemCount
          return ListView.builder(
              //set item count, if newData is null, set itemCount to 1, create
              //empty cell only, if not, create length + 1, 1 for empty cell
              itemCount: newData == null ? 1 : newData.length + 1,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                //if i is even, the border of list is grey,
                //set other style, edge length, color, shape, list size, list
                //shadow etc
                if (i < index && i.isEven) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(.1),
                            blurRadius: 1.0, // soften the shadow
                            spreadRadius: 0.5, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          //add image, set image shape
                          ClipOval(
                            child: Image.asset(
                              newData[i]['img'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              //add text by reading JSON file, set styles
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      newData[i]['ownerName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      newData[i]['details'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      '\n' + newData[i]['time'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ));
                }
                //if i is odd, set the list border blue
                //all others are the same above
                //I don't know how to set decoration separately, so have
                //the duplicate codes here
                //and if statement can't include i after return
                //let me improve this part after learning more Flutter later
                if (i < index && i.isOdd) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(.1),
                            blurRadius: 1.0, // soften the shadow
                            spreadRadius: 0.5, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              newData[i]['img'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      newData[i]['ownerName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      newData[i]['details'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      '\n' + newData[i]['time'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ));
                }
                return emptyCell;
              });
        });
  }

  //Add an empty cell in the end, set styles: color, size, position etc
  Widget emptyCell = Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.2),
          blurRadius: 1.0, // soften the shadow
          spreadRadius: 0.5, //extend the shadow
          offset: Offset(
            5.0, // Move to right 10  horizontally
            5.0, // Move to bottom 10 Vertically
          ),
        )
      ],
    ),
    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
    padding: const EdgeInsets.all(10),
    child: Column(children: [
      Text(
        '\n',
        style: TextStyle(
          color: Colors.grey[500],
        ),
      ),
      Icon(Icons.add, color: Colors.black, size: 15),
      Container(),
      Text(
        '\n',
        style: TextStyle(
          color: Colors.grey[500],
        ),
      ),
    ]),
  );
}
