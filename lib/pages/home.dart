import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as color;
import 'package:flutter_project/models/diet_model.dart';
import 'package:flutter_project/models/popular_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/category_model.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  List<CategoryModel> categories =[];
  List<DietModel> diets = [];
  List < PopularDietsModel > popularDiets = [];

  void _getCategories(){
    categories = CategoryModel.getCategories();
  }

  void _getDiets(){
    diets = DietModel.getDiets();
  }

  void _getInitialInfo(){
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets =PopularDietsModel.getPopularDiets();
  }

  @override
  void initState() {
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    _getCategories();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _search_field(),
          SizedBox(height: 20),
          _categoriesSection(),
          SizedBox(height: 40),
          _dietSection(),
          SizedBox(height: 40,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Popular',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 25,),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
                itemBuilder: (context, index){
                  return Container(
                    
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(popularDiets[index].iconPath,
                        width: 65,
                        height: 65,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularDiets[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              popularDiets[index].level + ' | ' + popularDiets[index].duration + ' | ' + popularDiets[index].calorie,
                              style: TextStyle(
                                color: Color(0xff7B6F72),
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: SvgPicture.asset(
                            'assets/icons/button.svg',
                            width: 30,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: popularDiets[index].boxIsSelected ?
                       Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popularDiets[index].boxIsSelected ? [
                        BoxShadow(
                          color: const Color(0xff1D1617).withOpacity(0.07),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0
                        )
                      ] : []
                    ),

                  );  
                }
              )
            ],
          )
          // Your body content here
        ],
      ),
      );
  }

  Column _dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Recommendation\nfor Diet',
                 style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 240,
              child: ListView.separated
              (itemBuilder: (context, index) {
                return Container(
                  width: 210,
                  decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(diets[index].iconPath),
                      Text(diets[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                      ),
                      Text(diets[index].level + " | " + diets[index].duration + " | " + diets[index].calories,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff9DCEff),
                            Color(0xff92A3FD),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          diets[index].viewIsSelected
                              ? 'View Recipe'
                              : 'View Recipe',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: diets[index].viewIsSelected
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                        
                      ),
                    ),
                    ],
                  )
                );
              },
               separatorBuilder: (context, index) => SizedBox(width: 20),
              itemCount: diets.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: 20,
                 right: 20)
            ),
            )
          ],
        
        );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20),
                separatorBuilder: (context, index) {
                  return SizedBox(width: 25);
                },
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(categories[index].iconPath),
                        ),
                      ),
                      Text(categories[index].name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      )
                    ],)
                  );
                },
              )
            )
          ],
        );
  }

  Container _search_field() {
    return Container( 
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1D1617).withOpacity(0.11),
                spreadRadius: 0.0,
                blurRadius: 40,
                
              )
            ]
          ),
          child: TextField(
            decoration:InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search for Pancake',
              hintStyle: TextStyle(
                color: Color(0xffB6B7B7),
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
              prefixIcon: Padding(
                padding:  EdgeInsets.all(15),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              suffixIcon: Container(
                width: 100,
                child: IntrinsicHeight(
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 0.1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset('assets/icons/Filter.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              ),
            )
          ),
        );
  }

  AppBar appBar() {
    return AppBar(
      title: Center(
        child: Text('Breakfast',
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18),
        ),
      ),
        leading: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: SvgPicture.asset('assets/icons/Arrow - Left 2.svg'),
          decoration:BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          )
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Add your action here
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                'assets/icons/dots.svg',
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      );
  }
}