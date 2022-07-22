import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haroun_news/news_app/cubit/cubit.dart';
import 'package:haroun_news/news_app/cubit/states.dart';
import 'package:haroun_news/news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTxtForm(
                    onChanged: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value) {
                      if(value!.isEmpty){
                        return 'What are you want to search for ?';
                      }
                      return null ;
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'search',
                    prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context , isSearch: true))
            ],
          ),
        ) ;
      },
    );
  }
}