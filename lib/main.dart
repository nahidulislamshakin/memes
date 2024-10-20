import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meme/view/home_screen.dart';
import 'package:meme/view_model/home_page_view_model/meme_list.dart';
import 'package:provider/provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MemeList>(create: (context)=>MemeList(),)
      ],
      child : ScreenUtilInit(
      designSize: Size(_deviceWidth,_deviceHeight),
      minTextAdapt: true,
      splitScreenMode: false,
      builder:(context,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple.shade100
            ),
            textTheme: TextTheme(
                bodyLarge: TextStyle(fontSize:16.sp,),
                bodyMedium: TextStyle(fontSize: 14.sp),
                bodySmall: TextStyle(fontSize:12.sp),
                titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,color: Colors.black,),
                titleMedium: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.black),
                labelLarge: TextStyle(fontSize: 11.sp,color: Colors.black),
              //  button: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: Colors.red),


              )
          ),
          home: HomeScreen(),
        );
      },
    ) 
    );
    
  }
}