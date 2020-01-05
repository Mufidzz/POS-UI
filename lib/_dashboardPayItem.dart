import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dashboard.dart';

class DashboardPayItem extends StatelessWidget {
  var boughtProductList = new List<BoughtProductModel>();
  int total;

  DashboardPayItem(this.boughtProductList, this.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.center,
            child: MainContainer(boughtProductList, total)));
  }
}

class MainContainer extends StatefulWidget {
  var boughtProductList = new List<BoughtProductModel>();
  int total;

  MainContainer(this.boughtProductList, this.total);

  @override
  MainContainerState createState() {
    return MainContainerState();
  }
}

class MainContainerState extends State<MainContainer> {
  int change = 0;
  int itemCount = 0;

  TextEditingController __amountController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.boughtProductList.forEach((e) {
      itemCount += e.qty;
    });
    change = 0 - widget.total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          height: 130,
          color: Colors.amber[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Rp. " + widget.total.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 46)),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Change : Rp. " + change.toString(),
                          style: TextStyle(fontSize: 16)),
                      Text("Item Count : " + itemCount.toString() + " Item(s)",
                          style: TextStyle(fontSize: 16)),
                      Text("Member : Member A", style: TextStyle(fontSize: 16)),
                    ],
                  )),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(249, 166, 2, 0.1),
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 42,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cash",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              __amountController.text = widget.total.toString();
                              change = int.parse(__amountController.text) - widget.total;

                            });
                          },
                          child: Container(
                            color: Colors.amber,
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(widget.total.toString()),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              __amountController.text = (widget.total +
                                      (5000 - (widget.total % 5000)))
                                  .toString();
                              change = int.parse(__amountController.text) - widget.total;

                            });
                          },
                          child: Container(
                            color: Colors.amber,
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                                (widget.total + (5000 - (widget.total % 5000)))
                                    .toString()),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                __amountController.text = 50000.toString();
                                change = int.parse(__amountController.text) - widget.total;

                              });
                            },
                            child: Container(
                              color: Colors.amber,
                              alignment: Alignment.center,
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text((50000).toString()),
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                __amountController.text = 100000.toString();
                                change = int.parse(__amountController.text) - widget.total;
                              });
                            },
                            child: Container(
                              color: Colors.amber,
                              alignment: Alignment.center,
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text((100000).toString()),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        setState(() {
                          change = int.parse(text) - widget.total;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Amount',
                          fillColor: Colors.white,
                          filled: true),
                      controller: __amountController,
                    ),
                    Divider(),
                    Container(
                      height: 42,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "EDC",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Wrap(
                      runSpacing: 15,
                      spacing:
                          MediaQuery.of(context).size.width * (0.2 / 4) + 5,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.amber,
                                )),
                            alignment: Alignment.center,
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset("assets/bank/bca.png")),
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.amber)),
                            alignment: Alignment.center,
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset("assets/bank/bri.png")),
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.amber)),
                            alignment: Alignment.center,
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset("assets/bank/mandiri.png")),
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.amber)),
                            alignment: Alignment.center,
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset("assets/bank/bni.png")),
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.amber)),
                            alignment: Alignment.center,
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset("assets/bank/nobu.png")),
                      ],
                    ),
                    Divider(),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.amber),
              ),
            ),
            alignment: Alignment.centerRight,
            height: 60,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.amber,
                      alignment: Alignment.center,
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.225,
                      child: Text("Cancel"),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        String f = "";
                        for (int i = 0;
                            i < widget.boughtProductList.length;
                            i++) {
                          f += widget.boughtProductList[i].product.productId
                                  .toString() +
                              "x" +
                              widget.boughtProductList[i].qty.toString() +
                              ";";
                        }
                        print(f);
                      },
                      child: Container(
                        color: Colors.amber,
                        alignment: Alignment.center,
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.225,
                        child: Text("Pay"),
                      )),
                ],
              ),
            ))
      ],
    );
  }
}
