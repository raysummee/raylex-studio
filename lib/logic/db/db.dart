import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raylex_studio/logic/helpers/modelRecordHelper.dart';

class Db{
  Future<void> init() async{
    await Hive.initFlutter();
    await openAllBox();
  }

  Future<void> openAllBox() async{
    await ModelRecordHelper().openBox();
  }

}