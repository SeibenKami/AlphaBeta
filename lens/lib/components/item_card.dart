import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {required this.title,
      required this.color,
      required this.rightWidget,
      required this.callback,
    });

  final Color color;
  final String title;
  final Widget rightWidget;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 24),
                child: Center(
                  child: Text(
                    title,
                    style:const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 24),
                child: rightWidget,
              )
            ],
          ),
        ),
      ),
      onTap: callback,
    );
  }
}
