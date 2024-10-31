import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  const MainTitleWidget({
    super.key,
    this.title = '',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).hintColor,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
