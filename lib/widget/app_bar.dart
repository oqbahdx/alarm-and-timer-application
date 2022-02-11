import 'package:alert/config/theme.dart';
import 'package:flutter/material.dart';

AppBar appBarBuild({required String title}){
  return AppBar(
    backgroundColor: blackC,
    elevation: 0.0,
    title: Text(title,style: appBarStyle,),
    centerTitle: true,
  );
}
