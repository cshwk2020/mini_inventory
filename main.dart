
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'TestDrawer/MultiPageDrawerApp.dart';
import 'TestNav/TestDrawerApp.dart';
import 'TestNav/TestNavApp.dart';
import 'TestNav/TestNavHome.dart';
import 'mini_inventory/MiniInventoryMain.dart';
import 'mini_inventory/db/CounterDbHelper.dart';
import 'mini_inventory/repository/ICounterRepository.dart';
import 'recipeapp/RecipeMain.dart';
import 'fooderlich/FooderlichMain.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //runApp(RecipeApp());
  //runApp(Fooderlich());
  //runApp(TestNavApp());

  await CounterDbHelper.instance.database;
  runApp(MiniInventoryMain());

  //runApp(MiniScreenSplashScreen());

  //runApp(TestDrawerApp());

  //runApp(MultiPageDrawerApp());

}
