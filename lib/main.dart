import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Two top bars source:
//https://stackoverflow.com/questions/59675978/how-to-add-tabs-top-side-and-bottom-side-both-in-flutter
//Widge round shape & shadow source:
//https://stackoverflow.com/questions/57777737/flutter-give-container-rounded-border
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
            margin:EdgeInsets.only(top: 50, left: 80, right: 80),
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

class ByTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BodyByTime()),
    );
  }
}

class ByOwnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BodyByOwner()),
    );
  }
}

class BodyByTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text(" By Time body"),
      ),
    );
  }
}

class BodyByOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _ownerList(),
    );
  }

  Widget ownerCellGrey = Container(
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
          ClipOval(
            child: Image.asset(
              'lib/images/john.jpg',
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
                child: const Text(
                  'John Smith',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50),
                child: const Text(
                  'Male, Haircut',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50),
                child: const Text(
                  '\n5/30 slots booked',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ))
        ],
      ));

  Widget ownerCellBlue = Container(
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
              'lib/images/john.jpg',
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
                    child: const Text(
                      'John Smith',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    child: const Text(
                      'Male, Haircut',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    child: const Text(
                      '\n5/30 slots booked',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ));

  Widget _ownerList() {
    int index = 3;
    return ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i < index && i.isEven) {
            return ownerCellGrey;
          }
          if(i < index && i.isOdd) {
            return ownerCellBlue;
          }
          return emptyCell;
        });
  }

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
      Icon(Icons.add, color: Colors.black),
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
