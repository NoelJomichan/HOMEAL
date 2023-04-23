import 'package:flutter/material.dart';
import 'package:homeal_flutter/screens/itemPage.dart';

class PopularWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            // for (int i=0; i<10; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170, height: 225,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                      boxShadow : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                  ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ItemPage.id);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/roti_dal.png',
                            height: 130,
                          ),
                        ),
                      ),
                      Text(
                        "Dal Roti",
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Taste our hot burger",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹100",
                            style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border, size: 16,
                            color: Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            for (int i=0; i<10; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170, height: 225,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ItemPage.id);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/paneer.png',
                            height: 130,
                          ),
                        ),
                      ),
                      Text(
                        "Shahi Paneer",
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Taste our hot burger",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹90",
                            style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.favorite_border, size: 16,
                            color: Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}