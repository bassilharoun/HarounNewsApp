

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haroun_news/news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(artical , context) => InkWell(
  onTap: (){
      navigateTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage( artical['urlToImage'] != null ?

                      '${artical['urlToImage']}' : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'

                  ),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(

          width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${artical['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${artical['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey

                  ),

                ),



              ],

            ),

          ),

        )

      ],

    ),

  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.teal,
  ),
);

Widget articleBuilder(list , context , {isSearch = false}) => ConditionalBuilder(condition: list.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index) => buildArticleItem(list[index], context),
      separatorBuilder: (context , index) => myDivider(),
      itemCount: 10
  ),
  fallback: (context) => isSearch ? Container() : Center(
    child: CircularProgressIndicator(),
  ) ,

) ;

Widget defaultTxtForm({
  required TextEditingController controller ,
  required TextInputType type ,
  Function(String)? onSubmit ,
  VoidCallback? onTap ,
  Function(String)? onChanged ,
  required String? Function(String?)? validate ,
  required String label ,
  IconData? prefix ,
  IconData? suffix = null ,
  bool isPassword = false,
  bool isClickable = true ,
  VoidCallback? onSuffixPressed ,

}) => TextFormField(
  validator: validate,
  obscureText: isPassword,
  controller: controller,
  decoration: InputDecoration(

      labelText: label,
      prefixIcon: Icon(prefix , color: Colors.teal,),
      suffixIcon: GestureDetector(
        child: Icon(suffix),
        onTap: onSuffixPressed,
      ),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
  ),
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,

) ;

void navigateTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder:  (context) => widget)) ;