import 'package:flutter/material.dart';

import 'Category.dart';

class CategoryItem extends StatefulWidget {
  // take obj from category model to use its date here
  Category category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.category.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: widget.index % 2 == 0
                ? Radius.circular(20)
                : Radius.circular(0),
            bottomLeft: widget.index % 2 == 0
                ? Radius.circular(0)
                : Radius.circular(20),
          )),
      child: Center(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage(widget.category.imagePath),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  widget.category.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
