import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembast_tutorial/model/user.dart';
import 'package:sembast_tutorial/user_bloc/bloc.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    // Obtaining the UserBloc instance through BlocProvider which is an InheritedWidget
    _userBloc = BlocProvider.of<UserBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    // We want to start loading fruits right from the start.
    _userBloc.dispatch(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sembast demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _userBloc.dispatch(AddRandomUser());
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _userBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, UserState state) {
        if (state is UsersLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UsersLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            padding: EdgeInsets.only(top: 20.0),
            itemBuilder: (context, index) {
              final displayedUser = state.users[index];
              return ListTile(
                title: Text(displayedUser.name),
                subtitle: _buildSubTitle(displayedUser),
                trailing: _buildUpdateDeleteButtons(displayedUser),
                leading: _buildProfilePic(displayedUser),
              );
            },
          );
        }
      },
    );
  }

  Container _buildProfilePic(User displayedUser) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(displayedUser.profilePic),
        ),
      ),
    );
  }

  Text _buildSubTitle(User displayedUser) {
    return Text(displayedUser.email + ' - ' + displayedUser.address.city);
  }

  Row _buildUpdateDeleteButtons(User displayedUser) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _userBloc.dispatch(UpdateWithRandomUser(displayedUser));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _userBloc.dispatch(DeleteUser(displayedUser));
          },
        ),
      ],
    );
  }
}
