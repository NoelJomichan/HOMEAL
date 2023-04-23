import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeal_flutter/cart_model.dart';
import 'package:homeal_flutter/cart_page.dart';
import 'package:provider/provider.dart';


class ItemPage extends StatefulWidget {
  // ItemPage({Key? key}) : super(key: key);

  ItemPage({required this.itemIndex, required this.docId });

  final int itemIndex;
  final String docId;
  late double price;


  static const id = 'item_page';

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  
  final _firestore = FirebaseFirestore.instance;

  final outerCollectionPath = 'Retailer';
  final innerCollectionPath = 'ingredients';

  // final innerCollectionReference = _firestore.collection(outerCollectionPath).doc()

  var firebaseUser = FirebaseAuth.instance.currentUser!;

  getList(index){
    itemIngredientList = Provider.of<CartModel>(context, listen: false).itemIngredients;
    if (widget.itemIndex == 0 || widget.itemIndex == 7){
      return itemIngredientList[0][index];
    }else if (widget.itemIndex == 1 || widget.itemIndex == 4){
      return itemIngredientList[1][index];
    }else if (widget.itemIndex == 2 || widget.itemIndex == 5){
      return itemIngredientList[2][index];
    }else if (widget.itemIndex == 3 || widget.itemIndex == 6){
      return itemIngredientList[3][index];
    }
  }


  Future addItemDetails(var name, List list, List itemList)async {
    _firestore.collection('item_macro').doc(firebaseUser.uid).collection('items').add({
      'name' : name,
      'macro' : list.toList(),
      'items' : itemList.toList(),
    });
    // _firestore.collection('item_macro').doc(firebaseUser.uid).set({
    //   'name' : name,
    //   'macro' : list.toList(),
    //   'items' : itemList.toList(),
    // });
  }

  calculatePrice(){
    double price = 0.0;
    for(int i = 0; i<newList.length; i++){
      price += (newList[i]/25)*(Provider.of<CartModel>(context, listen: false).BasePrice[i]);
    }
    return price;
  }

  var newList = [];

  void addItem(int index, double quant){
    newList[index].add(quant);
  }

  var itemIngredientList = [];

  var _currentValue;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Icon(Icons.shopping_bag),
        ),
        body: Consumer<CartModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text("Good Morning",),
                ),
                SizedBox(height: 24.0,),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Divider(),
                ),
                Expanded(
                    child: ListView.separated(
                      itemCount: 6,
                      itemBuilder: (context, index){
                        _currentValue = value.DefaultValue[0][index];
                        // currentValue = itemValueMap[index]!;
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(value.itemIngredients[0][index]),
                                Text(getList(index)),

                                Slider(
                                    // value: value.DefaultValue[0][index],
                                  value: _currentValue,
                                    min: 0,
                                    max: 200,
                                    divisions: 8,
                                    // label: "${currentValue.toInt()}%",
                                    onChanged: (Value){
                                      setState(() {
                                        value.DefaultValue[0][index] = Value;
                                        newList = value.DefaultValue[0];
                                        // value.DefaultValue[0][index] = Value;
                                      });
                                    }),
                                Text("${_currentValue.toInt()}%"),
                                // ElevatedButton(onPressed: (){
                                //   print(itemChangeMap);
                                // },
                                //     style: ButtonStyle(
                                //
                                //     ),
                                //     child: Text("Press me"))
                              ],

                            )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index){
                        return Divider();
                      },
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                    onTap: (){
                      _currentValue = value;
                    },
                    child: ListTile(
                      tileColor: Colors.blueGrey,
                      title: Text('Diabetic'),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print(newList);
                      addItemDetails(value.shopItems[widget.itemIndex][0], newList, value.itemIngredients[0]);
                      Provider.of<CartModel>(context, listen: false)
                          .addItemToCart(widget.itemIndex);
                      Provider.of<CartModel>(context, listen: false).addPrice(calculatePrice());
                      Navigator.pushNamed(context, CartPage.id);

                    },
                    child: Text('Add to Cart'),

                  ),
                )
              ],
            );
          },
        ),
      ),
    );;
  }

}
