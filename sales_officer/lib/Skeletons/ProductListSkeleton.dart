import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Container(
        height: 52,
        margin: EdgeInsets.all(12),
        child: Shimmer(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey],
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 30,height: 5,color: Colors.blue,),
                          SizedBox(
                            height: 5,
                          ),
                          Container(width: 100,height: 10,color: Colors.blue,),

                          SizedBox(
                            height: 5,
                          ),
                          Container(width: 30,height: 5,color: Colors.blue,),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
