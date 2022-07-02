import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowTeamporaryStorage extends StatefulWidget {
  const ShowTeamporaryStorage({Key? key}) : super(key: key);

  @override
  State<ShowTeamporaryStorage> createState() => _ShowTeamporaryStorageState();
}

class _ShowTeamporaryStorageState extends State<ShowTeamporaryStorage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context,innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text("임시 저장",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            centerTitle: true,
            pinned: true,
          ),
        ],
        body: Container(
            child: Column(
              children: [
                Text("hello"),
              ],
            )
        ),
      ),
    );
  }
}
