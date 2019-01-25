import 'package:rxdart/rxdart.dart';
import 'package:sqflite_bloc/blocs/bloc_base.dart';
import 'package:sqflite_bloc/models/User.dart';
import 'package:sqflite_bloc/resources/repository.dart';

class UserBloc implements BlocBase {
  final _users = BehaviorSubject<List<User>>();

  Observable<List<User>> get users => _users.stream;

  fetchUser() async {
    await userRepository.initializeDatabase();

    final users = await userRepository.getUserList();
    _users.sink.add(users);
  }

  insertUser(String name,int id,int phoneNumber) async {
    userRepository.insertUser(User(id, name, phoneNumber));
    fetchUser();
  }

  updateUser(User user) async {
    userRepository.updateUser(user);
  }

  deleteParticularUser(User user) async {
    userRepository.deleteParticularUser(user);
  }

  deleteAllUser() {
    return userRepository.deleteAllUsers();
  }

  @override
  void dispose() {
    _users.close();
  }
}
