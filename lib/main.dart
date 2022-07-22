import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haroun_news/news_app/cubit/app_states.dart';
import 'package:haroun_news/news_app/cubit/cubit.dart';
import 'package:haroun_news/news_app/shared/network/local/cache_helper.dart';

import 'news_app/cubit/app_cubit.dart';
import 'news_app/news_layout.dart';
import 'news_app/shared/network/remote/dio_helper.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget{

  final bool? isDark;

   MyApp( this.isDark) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
            fromShared: isDark
        ))
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.teal,
                floatingActionButtonTheme:FloatingActionButtonThemeData(
                    backgroundColor: Colors.teal
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.teal),
                  titleTextStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.teal,
                    elevation: 20
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87
                    )
                )

            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.teal,
                floatingActionButtonTheme:FloatingActionButtonThemeData(
                    backgroundColor: Colors.teal
                ),
                scaffoldBackgroundColor: Colors.black87,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.teal),
                  titleTextStyle: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  backgroundColor: Colors.black87,
                  elevation: 0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    elevation: 20,
                    backgroundColor: Colors.teal
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                    )
                )
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }

}
