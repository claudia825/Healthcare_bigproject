import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter/material.dart';


class searchBar extends StatelessWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SearchBarAnimation(
                textEditingController: TextEditingController(),
                isOriginalAnimation: true,
                enableKeyboardFocus: true,
                onExpansionComplete: () {
                  debugPrint(
                      'do something just after searchbox is opened.');
                },
                onCollapseComplete: () {
                  debugPrint(
                      'do something just after searchbox is closed.');
                },
                onPressButton: (isSearchBarOpens) {
                  debugPrint(
                      'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                },
                trailingWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                secondaryButtonWidget: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.grey,
                ),
                buttonWidget: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        )
    );
  }
}
