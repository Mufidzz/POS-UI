import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import '_dashboardBuyItem.dart';

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
        body: MainContainer());
  }
}

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  var boughtProductList = new List<BoughtProductModel>();
  int __subtotal = 0;
  int __discountPercent = 0;
  int __discount = 0;
  int __total = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  color: Color(0xfff5f3e9),
                  child:
                      Align(alignment: Alignment.center, child: _productGrid()),
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
                              child: _boughtProduct(),
                              color: Colors.white70,
                              margin: EdgeInsets.only(bottom: 5, top: 5),
                              padding: EdgeInsets.all(5),
                            ),
                          ),
                          Container(
                            height: 40,
                            color: Color.fromRGBO(249, 166, 2, 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    ___resetBoughtItem();
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Clear Bill",
                                      style: TextStyle(color: Colors.black87),
                                    ),
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
                              child: Text("Rp. " + __total.toString()),
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
    );
  }

  void ___resetBoughtItem() {
    setState(() {
      boughtProductList.clear();
      __subtotal = 0;
      __discount = 0;
      __total = 0;
    });
  }

  void ___updateBoughtItem(List<BoughtProductModel> boughtProductModelList) {
    setState(() {
      __subtotal = 0;

      for(int i = 0 ; i < boughtProductModelList.length ; i++) {
        __subtotal += boughtProductModelList[i].qty * int.parse(boughtProductModelList[i].product.productPrice);
      }
      __discount =
          ((__discountPercent * __subtotal) ~/ 100).toInt();
      __total = __subtotal - __discount;
    });
  }

  Widget _productGrid() {
    return FutureBuilder<List<Product>>(
      future: fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? _productGridView(product: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _productGridView({List<Product> product}) {
    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 5,
      children: List.generate(product.length, (index) {
        return GestureDetector(
            onTap: () {
              var content =
                  boughtProductList.where((bp) => bp.product == product[index]);
              if (content.length > 0) {
                setState(() {
                  boughtProductList
                      .singleWhere((bp) => bp.product == product[index])
                      .qty++;
                  ___updateBoughtItem(boughtProductList);
                });
              } else if (content.length == 0) {
                setState(() {
                  boughtProductList.add(new BoughtProductModel(
                      product: product[index], qty: 1, sub: "No Notes"));
                  ___updateBoughtItem(boughtProductList);
                });
              }
            },
            child: productGridItem(
                productName: product[index].productName.toString()));
      }),
    );
  }

  Future<List<BoughtProductModel>> boughtItemFuture() async {
    return boughtProductList;
  }

  Widget getBoughtItemWidgets() {
    return boughtProductBlockItem(boughtProductModel: boughtProductList);
  }

  Widget boughtProductBlockItem(
      {@required List<BoughtProductModel> boughtProductModel}) {
    return Column(
      children: List.generate(boughtProductModel.length, (index) {
        return GestureDetector(
            onTap: () async {
              final res = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardBuyItem(boughtProductModel[index])));
              setState(() {
                boughtProductModel[index] = res;
                if(boughtProductModel[index].qty <= 0){
                  boughtProductList.removeAt(index);
                }
                ___updateBoughtItem(boughtProductList);
              });
            },
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  boughtProductBlock(
                      productName:
                          boughtProductModel[index].product.productName,
                      productSinglePrice:
                          boughtProductModel[index].product.productPrice,
                      qty: boughtProductModel[index].qty,
                      sub: boughtProductModel[index].sub),
                  Divider()
                ],
              ),
            ));
      }),
    );
  }

  Widget _boughtProduct() {
    return ListView(
      children: <Widget>[
        getBoughtItemWidgets(),
        boughtProductTotalBlock(),
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
                  Text('Rp ' + __subtotal.toString(),
                      style: TextStyle(fontSize: 10)),
                  Text(
                      __discountPercent.toString() +
                          ' % - Rp ' +
                          __discount.toString(),
                      style: TextStyle(fontSize: 10)),
                  Divider(),
                  Text('Rp ' + __total.toString(),
                      style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ));
  }
}

class Product {
  String productId;
  String productName;
  String productPrice;

  Product({this.productId, this.productName, this.productPrice});

  Product.fromProduct(Product p) {
    this.productId = p.productId;
    this.productName = p.productName;
    this.productPrice = p.productPrice;
  }

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['Id'],
        productName: parsedJson['ProductName'],
        productPrice: parsedJson['Price']);
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

class BoughtProductModel {
  Product product;
  int qty;
  String sub;
  int subtotal;

  BoughtProductModel({this.product, this.qty, this.sub}){
    subtotal = qty * int.parse(product.productPrice);
  }

  BoughtProductModel.refresh(){
    subtotal = qty * int.parse(product.productPrice);
  }
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
