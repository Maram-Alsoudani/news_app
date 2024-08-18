import 'package:flutter/material.dart';

import 'AppColors.dart';

class ErrorScreen extends StatelessWidget {
  String msg;
  void Function() onClicked;

  ErrorScreen({required this.msg, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_outlined,
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Oops...!",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            msg,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.primaryColor)),
                onPressed: onClicked,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'retry',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.white, fontSize: 18),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
