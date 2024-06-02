
import 'package:sqltest/db_helper.dart';
import 'package:sqltest/student_model.dart';

void main() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initDatabase();

  var fido = Student(1, 'Fido');
  await dbHelper.add(fido);

  print(await dbHelper.getStudents());

  await dbHelper.update(Student(fido.id, "new Fido"));

  print(await dbHelper.getStudents());

  await dbHelper.delete(fido.id);

  print(await dbHelper.getStudents());

  print('end');
}
