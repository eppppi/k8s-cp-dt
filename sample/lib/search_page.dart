import 'package:flutter/material.dart';
import 'package:sample/canvas_page.dart';
import 'package:sample/cpid_page.dart';
import 'canvas_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var cpid = '';

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 400,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                hintText: 'Enter your CPID',
              ),
              autofocus: true,
              onChanged: (value) {
                cpid = value;
              },
              onSubmitted: ((value) => canvasPage(context, cpid)),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            child: Text('Find Traces'),
            onPressed: () => cpidPage(context, cpid),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            child: Text('Flame Graph'),
            onPressed: () => canvasPage(context, cpid),
          ),
        ],
      ),
    );
  }
}

void cpidPage(BuildContext context, String cpid) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return CpidPage(cpid: cpid);
      },
    ),
  );
}

void canvasPage(BuildContext context, String cpid) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return CanvasPage(cpid: cpid);
      },
    ),
  );
}
