import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => {},
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Menu A"),
                  Text("Menu B"),
                  Text("Menu C"),
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    color: Color(0xfff5f3e9),
                    child: Align(
                        alignment: Alignment.center, child: ProductGrid()),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(249, 166, 2, 0.1),
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 58,
                                    width: 58,
                                    color: Color.fromRGBO(249, 166, 2, 0.5),
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: 58,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    249, 166, 2, 0.5))),
                                        child: Align(
                                          child: Text("#1234567890"),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 360,
                                child: BoughtProduct(),
                                color: Colors.white70,
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                padding: EdgeInsets.all(5),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: Color.fromRGBO(249, 166, 2, 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Simpan Bill",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  )),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Cetak Bill",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 48,
                              color: Colors.amber,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Rp. Value"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  String productId;
  String productName;
  String productPrice;

  Product({this.productId, this.productName, this.productPrice});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['Id'],
        productName: parsedJson['ProductName'],
        productPrice: parsedJson['price']);
  }
}

Future<String> _loadAProductAsset() async {
  return await rootBundle.loadString('assets/ext/product.json');
}

List<Product> parseProduct(String myJson) {
  final parsed = json.decode(myJson).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProduct() async {
  await wait(5);
  String jsonString = await _loadAProductAsset();
  return compute(parseProduct, jsonString);
}

Future wait(int s) {
  return new Future.delayed(Duration(seconds: s), () => {});
}

class ProductGrid extends StatefulWidget {
  @override
  ProductGridState createState() => new ProductGridState();
}

class ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? ProductGridView(product: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProductGridView extends StatefulWidget {
  List<Product> product;
  Function callback;
  ProductGridView({Key key, this.product, this.callback}) : super(key: key);

  @override
  ProductGridViewState createState() => ProductGridViewState();
}

class ProductGridViewState extends State<ProductGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      children: List.generate(this.widget.product.length, (index) {
        return GestureDetector(
            onTap: () {
                  boughtProductList.add(new BoughtProductModel(
                      product: widget.product[index], qty: 1, sub: ""));
              this.widget.callback();
                },
            child: productGridItem(
                productName: widget.product[index].productName.toString()));
      }),
    );
  }
}

class BoughtProductModel {
  Product product;
  int qty;
  String sub;

  BoughtProductModel({this.product, this.qty, this.sub});
}

var boughtProductList = new List<BoughtProductModel>();

class BoughtProduct extends StatefulWidget {
  @override
  BoughtProductState createState() => new BoughtProductState();
}

class BoughtProductState extends State<BoughtProduct> {

  ProductGridView pgv;
  var _boughtProductModelState = new List<BoughtProductModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pgv = ProductGridView(callback: __addBoughtItem);
  }

  void __addBoughtItem(){
    setState(() {
      _boughtProductModelState = boughtProductList;
    });
    print("Set State Runn");
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        getBoughtItemWidgets(_boughtProductModelState),
        boughtProductTotalBlock(),
      ],
    );
  }
}


Widget getBoughtItemWidgets(List<BoughtProductModel> boughtProductModelList) {
  return FutureBuilder(
      future: boughtItemFuture(),

      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Text(snapshot.data.toString())
            : Center(child: CircularProgressIndicator());
      });
}



Future<List<BoughtProductModel>> boughtItemFuture() async {
  return boughtProductList;
}


Widget getSubstringTextWidgets(List<String> strings) {
  return new Column(
      children: strings
          .map((item) => new Container(
              alignment: Alignment.centerLeft,
              child: Text(item,
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 9))))
          .toList());
}

Widget boughtProductBlock(
    {@required String productName,
    @required String productSinglePrice,
    @required int qty,
    String sub}) {
  var subToken = sub.split("::");
  var subList = new List<String>();
  var price = int.parse(productSinglePrice) * qty;

  for (int i = 0; i < subToken.length; i++) {
    subList.add(subToken[i].toString());
  }

  return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(productName,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                getSubstringTextWidgets(subList),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('x' + qty.toString(), style: TextStyle(fontSize: 11)),
                Text('Rp ' + price.toString(), style: TextStyle(fontSize: 11))
              ],
            ),
          ),
        ],
      ));
}

Widget productGridItem({@required String productName}) {
  return Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
        color: Color.fromRGBO(249, 166, 2, 0.4),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Column(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              getProductDisplay(productName),
              style: TextStyle(fontSize: 38),
            ),
          ),
        ),
        Container(
          height: 25,
          child: Text(
            productName,
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

String getProductDisplay(String productName) {
  String res;
  var token = productName.split(" ");
  if (token.length > 1) {
    res = token.first[0] + token.last[0];
  } else {
    res = token.first[0];
  }
  return res;
}

Widget boughtProductBlockItem(
    {@required BoughtProductModel boughtProductModel}) {
  return Column(
    children: <Widget>[
      boughtProductBlock(
          productName: boughtProductModel.product.productName,
          productSinglePrice: boughtProductModel.product.productPrice,
          qty: boughtProductModel.qty,
          sub: boughtProductModel.sub),
      Divider(),
    ],
  );
}

Widget boughtProductTotalBlock() {
  return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Subtotal',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('Discount', style: TextStyle(fontSize: 10)),
                Divider(),
                Text('Total',
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Rp 999.999', style: TextStyle(fontSize: 10)),
                Text('Rp 999.999', style: TextStyle(fontSize: 10)),
                Divider(),
                Text('Rp 999.999', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ));
}
