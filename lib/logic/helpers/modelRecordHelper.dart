import 'package:hive/hive.dart';
import 'package:raylex_studio/logic/models/modelRecord.dart';

class ModelRecordHelper{
  Future<Box<ModelRecord>> openBox() async{
    return await Hive.openBox<ModelRecord>("records");
  }
  Box<ModelRecord> box(){
    return Hive.box<ModelRecord>("records");
  }
}