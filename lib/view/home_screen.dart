import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meme/model/meme_model.dart';
import 'package:meme/view_model/meme_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    MemeList().getData();
    if(MemeList().memeList.isEmpty){
      print("Empty");
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final memeListProvider = Provider.of<MemeList>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: 
          FutureBuilder(
            future: memeListProvider.getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: memeListProvider.memeList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   memeListProvider
                        //       .memeList[index].data!.memes![index].name
                        //       .toString(),
                        // ),
                        Text("Shakin"),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
