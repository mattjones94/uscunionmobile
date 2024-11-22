import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';

class SearchBox extends StatelessWidget {
  final Function changeFunction;
  final TextEditingController controller;
  SearchBox({
    Key? key,
    required this.changeFunction,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      constraints: BoxConstraints.tight(
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 10,
        ),
        child: TextField(
          cursorColor: Colors.white,
          controller: controller,
          onChanged: (value) {
            changeFunction();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            labelStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 20,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            labelText: "Search...",
          ),
        ),
      ),
    );
  }
}
