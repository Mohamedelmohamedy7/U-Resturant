import 'package:flutter/material.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({Key? key}) : super(key: key);

  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                    BorderSide(color: Colors.grey.shade800)),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                  BorderSide(color: Colors.grey.shade800),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white38,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                hintText: "Search for recipes",
                hintStyle: TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade800,
            ),
            width: 49,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                "assets/images/filter1.png",
              ),
            ),
          )
        ],

    );
  }
}
