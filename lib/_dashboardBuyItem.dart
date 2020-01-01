import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dashboard.dart';

class DashboardBuyItem extends StatelessWidget {
  BoughtProductModel boughtProductModel;
  BoughtProductModel boughtProductModelOrigin;

  DashboardBuyItem(BoughtProductModel boughtProductModel) {
    this.boughtProductModel = boughtProductModel;
    this.boughtProductModelOrigin = boughtProductModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
          alignment: Alignment.center,
          child: MainContainer(boughtProductModel, boughtProductModelOrigin)),
    );
  }
}

// ignore: must_be_immutable
class MainContainer extends StatefulWidget {
  BoughtProductModel boughtProductModel;
  BoughtProductModel boughtProductModelOrigin;

  MainContainer(this.boughtProductModel, this.boughtProductModelOrigin);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          height: 100,
          width: MediaQuery.of(context).size.width,
          color: Colors.amber[300],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 34,
                child: Text(
                  widget.boughtProductModel.product.productName,
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Divider(),
              Container(
                  alignment: Alignment.centerRight,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Qty : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.boughtProductModel.qty--;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          height: 30,
                          width: 35,
                          color: Colors.amber[700],
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 50,
                        color: Colors.white,
                        child: Text(widget.boughtProductModel.qty.toString()),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.boughtProductModel.qty++;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 35,
                          color: Colors.amber[700],
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        Container(
          height: 58,
          color: Colors.amber[200],
          child: ListView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            children: List.generate(widget.boughtProductModel.qty, (index) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5),
                color: Colors.amber[600],
                width: 175,
                child: Text("Item " + (index + 1).toString()),
              );
            }),
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(249, 166, 2, 0.1),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Text("Customization(s)"),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "Less Ice",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "Less Sugar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "More Ice",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "More Sugar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          TextField(
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                                hintText: 'Enter Notes Here',
                                fillColor: Colors.white,
                                filled: true),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 4,
                          ),
                        ],
                      )),
                ),
                Divider(),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        alignment: Alignment.centerRight,
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width:
                                    MediaQuery.of(context).size.width * 0.225,
                                color: Colors.red[700],
                                child: Text(
                                  "Delete Item",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        alignment: Alignment.centerRight,
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context, widget.boughtProductModelOrigin);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width:
                                    MediaQuery.of(context).size.width * 0.225,
                                color: Colors.amber,
                                child: Text("Cancel"),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context, widget.boughtProductModel);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width:
                                    MediaQuery.of(context).size.width * 0.225,
                                color: Colors.amber,
                                child: Text("Save"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
