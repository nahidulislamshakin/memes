import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meme/model/meme_model.dart';
import 'package:meme/view/home_screen.dart';

class DetailScreen extends StatefulWidget {
  final Memes meme;
  DetailScreen({required this.meme});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meme.name ?? "Meme Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.network(widget.meme.url??"",fit:BoxFit.cover),

                ),
                SizedBox(height: 8.h,),
                Text(
              widget.meme.name ?? 'No Name',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8.0.h),
            Text('Captions: ${widget.meme.captions}',style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 8.0.h),
            Text('Width: ${widget.meme.width}',style:Theme.of(context).textTheme.bodyMedium,),
            Text('Height: ${widget.meme.height}',style:Theme.of(context).textTheme.bodyMedium),
                            ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      "Edit & download",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
