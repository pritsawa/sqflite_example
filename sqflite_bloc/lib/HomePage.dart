import 'package:flutter/material.dart';
import 'package:sqflite_bloc/blocs/bloc_base.dart';
import 'package:sqflite_bloc/blocs/user_bloc.dart';
import 'package:sqflite_bloc/models/User.dart';
import 'package:sqflite_bloc/user_detail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.fetchUser();
  }

  @override
  void dispose() {
    userBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                userBloc?.deleteAllUser();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/detail");
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: userBloc.users,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    userBloc.deleteParticularUser(snapshot.data[index]);
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserDetail(
                                user: snapshot.data[index],
                              )));
                    },
                    title: Text(snapshot.data[index].name),
                    subtitle:
                        Text("Mobile Number ${snapshot.data[index].userId}"),
                    trailing:
                        Text("User Id ${snapshot.data[index].mobileNumber}"),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      ),
    );
  }
}
