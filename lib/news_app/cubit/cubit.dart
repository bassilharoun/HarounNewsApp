import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haroun_news/news_app/cubit/states.dart';
import 'package:haroun_news/news_app/modules/business/business_screen.dart';
import 'package:haroun_news/news_app/modules/science/science_screen.dart';
import 'package:haroun_news/news_app/modules/settings/settings_screen.dart';
import 'package:haroun_news/news_app/modules/sports/sports_screen.dart';
import 'package:haroun_news/news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
      Icons.business_center_outlined,
    ),label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_baseball_outlined,
        ),label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science_outlined,
        ),label: 'Science'),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index ;
    if(index == 1){
      getSports();
    }
    if(index == 2){
      getScience();
    }
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [] ;

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg' ,
          'category' : 'business' ,
          'apiKey' : '39789d531bc546ceb3939952a6f4ff95' ,
        }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [] ;

  void getSports(){
    emit(NewsGetBusinessLoadingState());

    if(sports.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country' : 'eg' ,
            'category' : 'sports' ,
            'apiKey' : '39789d531bc546ceb3939952a6f4ff95' ,
          }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsSuccessState());
      }).catchError((error){
        emit(GetSportsErrorState(error.toString()));
      });
    }else {
      emit(GetSportsSuccessState());
    }

  }

  List<dynamic> science = [] ;

  void getScience(){
    emit(NewsGetBusinessLoadingState());
    if(science.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country' : 'eg' ,
            'category' : 'science' ,
            'apiKey' : '39789d531bc546ceb3939952a6f4ff95' ,
          }).then((value) {
        science = value.data['articles'];
        emit(GetScienceSuccessState());
      }).catchError((error){
        emit(GetScienceErrorState(error.toString()));
      });
    }else{
      emit(GetScienceSuccessState());
    }


  }

  List<dynamic> search = [] ;

  void getSearch(String value){
    emit(NewsGetBusinessLoadingState());
    search = [];
    if(search.length == 0){
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q' : '$value' ,
            'apiKey' : '39789d531bc546ceb3939952a6f4ff95' ,
          }).then((value) {
        search = value.data['articles'];
        emit(GetSearchSuccessState());
      }).catchError((error){
        emit(GetSearchErrorState(error.toString()));
      });
    }else{
      emit(GetSearchSuccessState());
    }


  }

}