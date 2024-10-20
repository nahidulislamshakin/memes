import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meme/model/meme_model.dart';
import 'package:meme/view_model/home_page_view_model/meme_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController searchController = TextEditingController();
   final FocusNode _focusNode = FocusNode();
// @override
//   void initState() {
//     final memeListProvider = Provider.of<MemeList>(context,listen: false);

//     // searchController.addListener((){
//     //   memeListProvider.getSearchData(searchController.text);
//     // });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final memeListProvider = Provider.of<MemeList>(context);
    return Scaffold(
      appBar: AppBar(
        title:TextField(
          focusNode: _focusNode,
          onTapOutside: (event){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          autofocus: false,
          controller: searchController,
            cursorColor: Colors.black,
            
            decoration: InputDecoration(
                hintText: " Search...",
                border: InputBorder.none,
                
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color.fromRGBO(93, 25, 72, 1),
                  onPressed: () {
                    memeListProvider.getSearchData(searchController.text);
                  },
                ),),
            style: TextStyle(color: Colors.black, fontSize: 15.0.sp),
          ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w,top: 10.h),
          child: FutureBuilder(
            future: memeListProvider.getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              } else {
                final memesToShow = searchController.text.isNotEmpty
                ? memeListProvider.filteredMemes
                : memeListProvider.memeList;
                // if (memesToShow.isEmpty) {
                //   return Center(child: Text('No memes found'));
                // }
                if(searchController.text.isEmpty){
                  memeListProvider.filteredMemes.clear();
                }
                return ListView.builder(
                  itemCount: memesToShow.length,
                  itemBuilder: (context, index) {
                    final meme = memesToShow[index];
                    return Card(
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(meme.name ?? "No Name",
                                style: Theme.of(context).textTheme.titleMedium),
                            SizedBox(
                              height: 2.h,
                            ),
                            
                            
                            Text(meme.captions.toString(),),
                            SizedBox(height: 3.h,),
                            GestureDetector(
                              child: Center(
                                child: Image.network(
                                  meme.url?? "loading",
                                  fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                            SizedBox(height: 15.h,)
                          ],
                        ),
                      ),
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
