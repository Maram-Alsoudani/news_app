import 'package:flutter/material.dart';

import 'Category.dart';

class CategoryItem extends StatelessWidget {
  // take obj from category model to use its date here
  Category category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: category.backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight:
                  index % 2 == 0 ? Radius.circular(20) : Radius.circular(0),
              bottomLeft:
                  index % 2 == 0 ? Radius.circular(0) : Radius.circular(20),
            )),
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage(category.imagePath),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    category.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
