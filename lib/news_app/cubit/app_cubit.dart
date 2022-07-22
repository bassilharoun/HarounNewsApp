import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haroun_news/news_app/cubit/app_states.dart';
import 'package:haroun_news/news_app/cubit/states.dart';
import 'package:haroun_news/news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false ;

  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared ;
    }
    else{
      isDark = !isDark ;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMoodState());
      });
    }


  }

}