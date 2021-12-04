import 'package:flutter/material.dart';
import 'package:marketplaceice/model/ice.dart';
import 'package:marketplaceice/model/cart.dart';
import 'package:marketplaceice/screen/cart_screen.dart';
import 'package:marketplaceice/screen/checkout_screen.dart';
import 'package:marketplaceice/util/badge.dart';
import 'package:marketplaceice/util/widget.dart';
import 'package:collection/collection.dart';

class DetailScreen extends StatefulWidget {
  final Ice ice;

  const DetailScreen({required this.ice});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  color: widget.ice.iceColor,
                  child: Image.network(
                    widget.ice.iceImage,
                    width: double.infinity,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Stack(alignment: Alignment.topRight,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return CartScreen();
                                      })).then((value) => setState(() {}));
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                )),
                            cartList.length > 0
                                ? Badge(
                                numberValue: (cartList.length).toString())
                                : Container()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ice.iceName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 24),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                  widget.ice.iceBrand,
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          ),
                          Text(
                            rupiahCurrencyFormat
                                .format(widget.ice.icePrice),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Description'),
                      Text(
                        widget.ice.iceDescriptions,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  addToCart(widget.ice.iceId, context);
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(14.0),
                                    primary: Color.fromARGB(0, 255, 255, 255)),
                                child: Icon(Icons.add_shopping_cart_outlined)),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                        Color.fromARGB(1000, 4, 93, 42),
                                        padding: EdgeInsets.all(16.0)),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return CheckoutScreen();
                                      }));
                                    },
                                    child: Text(
                                      'Buy Now',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            )
                          ],
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
    );
  }
  void addToCart(iceId, context) {
    bool isItemExist = false;
    if (cartList.firstWhereOrNull((cartItem) => cartItem.iceId == iceId) !=
        null) {
      isItemExist = true;
    }
    if(isItemExist){
      final snackBar = SnackBar(content: Text('Item already in cart !'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      setState(() {
        cartList.add(Cart(iceId: iceId));
      });
      final snackBar = SnackBar(content: Text('Item added to cart !'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}





