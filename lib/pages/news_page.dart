import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsUsersPage extends StatefulWidget {
  const NewsUsersPage({super.key});

  @override
  State<NewsUsersPage> createState() => _NewsUsersPageState();
}

class _NewsUsersPageState extends State<NewsUsersPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> items = [];

  Future<void> refresh() async {
    List<Map<String, dynamic>> itemsTemp = [];
    var get = await firestore.collection('users').get();

    for (var item in get.docs) {
      itemsTemp.add(item.data());
    }

    setState(() {
      items = itemsTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: RefreshIndicator(
            onRefresh: () async {
              await refresh();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    
                    itemBuilder: (context, index) {
                      return Text(items[index]['name']);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
