import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        backgroundColor: Colors.amber[800],
      ),
      body: MainContainer(),
    );
  }
}

class MainContainer extends StatefulWidget {
  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  var __selectedOrder = new FinishedOrder(orderId: "",item: "",refundedItem: "");
  var finishedOrderList = new List<FinishedOrder>();
  var product = new List<String>();
  var refundedProduct = new List<String>();
  int qty;

  var productData = new List<Product>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productData = productList;
  }


  int _getQty(FinishedOrder fo){
    qty = 0;
    var str = fo.item.split(";");

    for(int i = 0; i < str.length ; i++) {
      var token = str[i].split("x");
      qty += int.parse(token[1]);
    }
  }


  @override
  Widget build(BuildContext context) {
    if(__selectedOrder.item.isNotEmpty){
      _getQty(__selectedOrder);
    }
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                border:
                    Border(right: BorderSide(width: 1, color: Colors.amber))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(child: Text(
                    "Order Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),)
                ),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: _orderList()
                )
              ],
            )
          ),
//          Container(
//            width: MediaQuery.of(context).size.width * 0.4,
//            decoration: BoxDecoration(
//                border:
//                    Border(right: BorderSide(width: 1, color: Colors.amber))),
//            child: ListView(
//              children: <Widget>[
//                Container(
//                  alignment: Alignment.center,
//                  child: Column(
//                    children: <Widget>[
//                      Text(
//                        __selectedOrder.orderId.toString(),
//                        style: TextStyle(fontSize: 20),
//                      ),
//                      Text("$qty Item(s) - No Member"),
//                    ],
//                  ),
//                  height: 70,
//                  padding: EdgeInsets.only(top: 15),
//                ),
//                Divider(),
//                ListTile(
//                  title: Text("Milkshake A"),
//                  subtitle: Text("10 Item(s) - 0 Refund(s)"),
//                ),
//                Divider(),
//                ListTile(
//                  title: Text("#Milkshake B"),
//                  subtitle: Text("10 Item(s) - 0 Refund(s)"),
//                ),
//                Divider(),
//                ListTile(
//                  title: Text("#Milkshake C"),
//                  subtitle: Text("10 Item(s) - 0 Refund(s)"),
//                ),
//                Divider(),
//              ],
//            ),
//          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  border:
                  Border(right: BorderSide(width: 1, color: Colors.amber))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              __selectedOrder.orderId.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text("$qty Item(s) - No Member"),
                          ],
                        ),
                        padding: EdgeInsets.only(top: 15),
                      ),
                  ),
                  Divider(),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _itemListListView(product, refundedProduct),
                  )
                ],
              )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "#20199-1",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text("30 Item - No Member"),
                    ],
                  )
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.amber), top: BorderSide(color: Colors.amber))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Qty : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                        child: Text("0"),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 35,
                          color: Colors.amber[700],
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment : Alignment.center,
                      height: 60,
                      padding: EdgeInsets.all(10),
                      color: Colors.amber,
                      child: Text("Refund", style: TextStyle(fontWeight: FontWeight.bold),),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderList() {
    return FutureBuilder<List<FinishedOrder>>(
      future: fetchFinishedOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? _orderListListView(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView _orderListListView(List<FinishedOrder> fo){
    finishedOrderList = fo;
    return ListView(
      children: List.generate(fo.length, (index) {
        return Column (
          children: <Widget>[
            ListTile(
              onTap: () {
                setState(() {
                  __selectedOrder = fo[index];
                  product = fo[index].item.split(";");
                  refundedProduct = fo[index].refundedItem.split(";");
                });
              },
              title: Text(fo[index].orderId.toString()),
            ),
            Divider()
          ],
        );
      }),
    );
  }

  ListView _itemListListView(List<String> item, List<String> itemRefund){
    return ListView(
      children: List.generate(item.length, (index) {

        var itemSplit = item[index].split("x");
        String itemName = productData.firstWhere((pd) => pd.productId.contains(itemSplit[0])).productName;

        String refQty = "0";

        for(int i = 0 ; i < itemRefund.length ; i++){
          var ir =  itemRefund[i].split("x");
          if(itemSplit[0] == ir[0]){
            refQty = ir[1];
          }
        }
        return Column (
          children: <Widget>[
            ListTile(
              title: Text(itemName),
              subtitle: Text(itemSplit[1] + " Item(s) - $refQty Refund(s)"),
            ),
            Divider(),
          ],
        );
      }),
    );
  }
}

class FinishedOrder {
  String orderId;
  String item;
  String refundedItem;

  FinishedOrder({this.orderId, this.item, this.refundedItem});

  factory FinishedOrder.fromJson(Map<String, dynamic> parsedJson) {
    return FinishedOrder(
        orderId: parsedJson['orderId'],
        item: parsedJson['item'],
        refundedItem: parsedJson['refundedItem']);
  }
}

Future<String> _loadAFinishedOrderAsset() async {
  return await rootBundle.loadString('assets/ext/order.json');
}

List<FinishedOrder> parseFinishedOrder(String myJson) {
  final parsed = json.decode(myJson).cast<Map<String, dynamic>>();
  return parsed.map<FinishedOrder>((json) => FinishedOrder.fromJson(json)).toList();
}

Future<List<FinishedOrder>> fetchFinishedOrder() async {
  await wait(1);
  String jsonString = await _loadAFinishedOrderAsset();
  return compute(parseFinishedOrder, jsonString);
}

Future wait(int s) {
  return new Future.delayed(Duration(seconds: s), () => {});
}