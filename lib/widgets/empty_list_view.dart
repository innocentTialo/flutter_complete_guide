import 'package:flutter/material.dart';

class EmptyListViewWidget extends StatelessWidget {
  final title;
  final imagePath;
  const EmptyListViewWidget({
    @required this.title,
    this.imagePath = 'assets/images/waiting.png'
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constrains) {
          return Column(
            children: <Widget>[
              Container(
                height: constrains.maxHeight * 0.1,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                height: constrains.maxHeight * 0.01,
              ),
              Container(
                height: constrains.maxHeight * 0.6,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      );
  }
}