import 'package:flutter/material.dart';

import 'AppColors.dart';

class Drawerwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.17,
            color: AppColors.primaryColor,
            child: Center(
                child: Text(
              "News App",
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ),
          ListTile(
              leading: Icon(Icons.list, color: AppColors.black),
              title: Text(
                "Categories",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.black),
              ),
              onTap: () {}),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.black),
            title: Text(
              "Settings",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.black),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
