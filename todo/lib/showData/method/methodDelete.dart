import 'package:todo/DB.dart';

SqlDb sqlDb = SqlDb();
Future<int> deleteData(String query) async {
  int respone = await sqlDb.deleteData(query);
  
  return respone;
}
