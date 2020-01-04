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
  int ___selectedItem = 0;
  TextEditingController _notesController = new TextEditingController();

  var currentTextFieldValue = new List<String>();
  var notesControllerText = new List<String>();
  var notesControllerTextAfter = new List<String>();

  void checkList(List<String> str) {
    if (str.isEmpty) {
      for (int i = 0; i < widget.boughtProductModel.qty; i++) {
        str.add("");
      }
    } else if (str.length < widget.boughtProductModel.qty) {
      int diff = widget.boughtProductModel.qty - str.length;
      for (int i = 0; i < diff; i++) {
        str.add("");
      }
    } else if (str.length > widget.boughtProductModel.qty) {
      int diff = str.length - widget.boughtProductModel.qty;
      for (int i = 0; i < diff; i++) {
        str.removeLast();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkList(notesControllerText);
    checkList(notesControllerTextAfter);
    checkList(currentTextFieldValue);

    print(widget.boughtProductModel.sub);
    var sub = widget.boughtProductModel.sub;
    var split = sub.split(RegExp(r"Item [0-9]*: ::"));
    print(split);
    print(split.length);

    for(int i = 1; i < split.length; i++) {
      notesControllerText[i-1] = split[i];
    }

    notesControllerTextAfter[___selectedItem] =
        notesControllerText[___selectedItem]
            .replaceAll(RegExp("::"), "\n");
    _notesController.text =
    notesControllerTextAfter[
    ___selectedItem];

    print(notesControllerText);
    print(notesControllerTextAfter);
  }


  @override
  Widget build(BuildContext context) {
    checkList(notesControllerText);
    checkList(notesControllerTextAfter);
    checkList(currentTextFieldValue);

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
                          if (widget.boughtProductModel.qty > 0) {
                            setState(() {
                              widget.boughtProductModel.qty--;
                            });
                          }
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
              return GestureDetector(
                onTap: () {
                  setState(() {
                    ___selectedItem = index;

                    notesControllerTextAfter[___selectedItem] =
                        notesControllerText[___selectedItem]
                            .replaceAll(RegExp("::"), "\n");
                    _notesController.text =
                    notesControllerTextAfter[
                    ___selectedItem];

                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5),
                  color: ___selectedItem == index
                      ? Colors.amber[900]
                      : Colors.amber[600],
                  width: 175,
                  child: Text("Item " + (index + 1).toString()),
                ),
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
                                onTap: () {
                                  if (notesControllerText[___selectedItem]
                                      .isEmpty) {
                                    notesControllerText.insert(
                                        ___selectedItem, "");
                                  }

                                  if (notesControllerTextAfter[___selectedItem]
                                      .isEmpty) {
                                    notesControllerTextAfter.insert(
                                        ___selectedItem, "");
                                  }

                                  if (RegExp("Less Ice::").hasMatch(
                                      notesControllerText[___selectedItem])) {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(
                                                RegExp("Less Ice::"), "");
                                  } else {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem] +
                                            "Less Ice::";
                                  }

                                  setState(() {
                                    notesControllerTextAfter[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(RegExp("::"), "\n");
                                    _notesController.text =
                                        notesControllerTextAfter[
                                            ___selectedItem];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "Less Ice",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (RegExp("Less Sugar::").hasMatch(
                                      notesControllerText[___selectedItem])) {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(
                                                RegExp("Less Sugar::"), "");
                                  } else {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem] +
                                            "Less Sugar::";
                                  }

                                  setState(() {
                                    notesControllerTextAfter[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(RegExp("::"), "\n");
                                    _notesController.text =
                                        notesControllerTextAfter[
                                            ___selectedItem];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "Less Sugar",
                                    style: TextStyle(color: Colors.black),
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
                                onTap: () {
                                  if (RegExp("More Ice::").hasMatch(
                                      notesControllerText[___selectedItem])) {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(
                                                RegExp("More Ice::"), "");
                                  } else {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem] +
                                            "More Ice::";
                                  }

                                  setState(() {
                                    notesControllerTextAfter[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(RegExp("::"), "\n");
                                    _notesController.text =
                                        notesControllerTextAfter[
                                            ___selectedItem];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "More Ice",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (RegExp("More Sugar::").hasMatch(
                                      notesControllerText[___selectedItem])) {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(
                                                RegExp("More Sugar::"), "");
                                  } else {
                                    notesControllerText[___selectedItem] =
                                        notesControllerText[___selectedItem] +
                                            "More Sugar::";
                                  }

                                  setState(() {
                                    notesControllerTextAfter[___selectedItem] =
                                        notesControllerText[___selectedItem]
                                            .replaceAll(RegExp("::"), "\n");
                                    _notesController.text =
                                        notesControllerTextAfter[
                                            ___selectedItem];
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width:
                                      MediaQuery.of(context).size.width * 0.475,
                                  color: Colors.amber,
                                  child: Text(
                                    "More Sugar",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              notesControllerTextAfter[___selectedItem] = text;
                              print(notesControllerTextAfter[___selectedItem]);
                            },
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Notes Here',
                                fillColor: Colors.white,
                                filled: true),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 4,
                            controller: _notesController,
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
                              onTap: () {
                                widget.boughtProductModel.qty = 0;
                                Navigator.pop(
                                    context, widget.boughtProductModel);
                              },
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
                                var allNotes = "";
                                for (int i = 0; i < notesControllerTextAfter.length; i++) {
                                  if(notesControllerTextAfter[i].isNotEmpty || notesControllerTextAfter[i] != ""){
                                    var splittedNotes = notesControllerTextAfter[i].replaceAll("\n", "::");
                                    if (i != 0) {
                                      allNotes += ("::Item " +
                                          (i + 1).toString() +
                                          ": ::" +
                                          splittedNotes);
                                    } else {
                                      allNotes += ("Item " +
                                          (i + 1).toString() +
                                          ": ::" +
                                          splittedNotes);
                                    }
                                  }
                                }

                                widget.boughtProductModel.sub = allNotes;

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
