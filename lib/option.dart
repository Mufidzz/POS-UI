import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(alignment: Alignment.center, child: MainContainer()),
    );
  }
}

// ignore: must_be_immutable
class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

  int __selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber[100],
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Application Option",
                        style: TextStyle(fontSize: 20),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.amber,
                        child: Text("Back to Dashboard"),
                      )
                    ],
                  ) ,
                ),
                Divider(),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: 120,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 5),
                        color: __selectedItem == 0
                            ? Colors.amber[900]
                            : Colors.amber[600],
                        child: Text("Printer"),
                      )
                    ],
                  ),
                )
              ],
            )),
        Container(
          padding: EdgeInsets.all(60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Printer Connection : DISCONECTED"),
              Divider(),
              FlatButton(
                padding: EdgeInsets.only(right: 80, left: 80, top: 15, bottom: 15),
                color: Colors.amber,
                onPressed: (){

                },
                child: Text("Connect Printer"),
              )
            ],
          ),
        )
      ],
    );
  }
}
