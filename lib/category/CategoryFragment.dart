import 'package:flutter/material.dart';

import '../AppColors.dart';
import 'Category.dart';
import 'CategoryItem.dart';

class CategoryFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categoriesList = [
      Category(
          id: "sports",
          name: "Sports",
          imagePath: "assets/images/sports.png",
          backgroundColor: AppColors.red),
      Category(
          id: "general",
          name: "General",
          imagePath: "assets/images/Politics.png",
          backgroundColor: AppColors.darkBlue),
      Category(
          id: "health",
          name: "Health",
          imagePath: "assets/images/health.png",
          backgroundColor: AppColors.pink),
      Category(
          id: "business",
          name: "Business",
          imagePath: "assets/images/bussines.png",
          backgroundColor: AppColors.orange),
      Category(
          id: "entertainment",
          name: "Entertainment",
          imagePath: "assets/images/environment.png",
          backgroundColor: AppColors.blue),
      Category(
          id: "science",
          name: "Science",
          imagePath: "assets/images/science.png",
          backgroundColor: AppColors.yellow)
    ];
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pick your category\nof interest',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.light_black),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    category: categoriesList[index],
                    index: index,
                  );
                }),
          )
        ],
      ),
    );
  }
}
