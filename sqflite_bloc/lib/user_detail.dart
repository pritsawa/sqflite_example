import 'package:flutter/material.dart';
import 'package:sqflite_bloc/blocs/bloc_base.dart';
import 'package:sqflite_bloc/blocs/user_bloc.dart';
import 'package:sqflite_bloc/models/User.dart';
import 'package:sqflite_bloc/resources/repository.dart';

class UserDetail extends StatelessWidget {
  final User user;

  const UserDetail({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Enter User Details"),
        ),
        body: UserDetailClass(
          user: user,
        ),
      ),
    );
  }
}

class UserDetailClass extends StatefulWidget {
  final User user;

  const UserDetailClass({Key key, this.user}) : super(key: key);

  @override
  _UserDetailClassState createState() => _UserDetailClassState();
}

class _UserDetailClassState extends State<UserDetailClass> {
  UserBloc userBloc;
  String name;
  String id;
  String mobileNumber;

  TextEditingController nameController;
  TextEditingController idController;
  TextEditingController mobileNumberController;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);

    final tempName = widget.user?.name ?? "";
    final tempId = widget.user?.userId.toString() ?? "";
    final tempMobileNumber = widget.user?.mobileNumber.toString() ?? "";

    nameController = TextEditingController(text: tempName);
    idController = TextEditingController(text: tempId);
    mobileNumberController = TextEditingController(text: tempMobileNumber);
  }

  @override
  void dispose() {
    userBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: new InputDecoration(hintText: 'Enter Name'),
          onChanged: (value) {
            name = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: idController,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(hintText: 'Enter Id'),
          onChanged: (value) {
            id = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: mobileNumberController,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(hintText: 'Enter Phone Number'),
          onChanged: (value) {
            mobileNumber = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            widget.user.userName = name;
            widget.user.userId = int.parse(id);
            widget.user.mobileNumber = int.parse(mobileNumber);

            userBloc.updateUser(widget.user);
          },
          child: Text("Update"),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            userBloc
                .insertUser(name, int.parse(id), int.parse(mobileNumber))
                .then((result) {
              if (result != 0) {
                print("Saved");
              } else {
                print("Failed");
              }
            });
          },
          child: Text("Insert"),
        ),
      ],
    );
  }
}
