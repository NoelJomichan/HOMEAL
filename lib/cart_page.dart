import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeal_flutter/home_page.dart';
import 'package:provider/provider.dart';

import '../cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const String id = "cart_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's order fresh items for you
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "My Cart",
                      style: GoogleFonts.notoSerif(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      // Navigator.pushNamed(context, HomePage.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(docId: 'docId')));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Icon(Icons.home_outlined),
                    ),
                  ),

                ],
              ),

              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(
                              value.cartItems[index][0],
                              // value.modifiedItemList[index].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              // '\$' + value.cartItems[index][1],
                              '\$' + value.ModifiedPrice[index].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () =>
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // total amount + pay now

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(color: Colors.green[200]),
                          ),

                          const SizedBox(height: 8),
                          // total price
                          Text(
                            '\$${value.calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // pay now
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: const [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
