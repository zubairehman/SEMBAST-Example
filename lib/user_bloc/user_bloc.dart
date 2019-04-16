import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:sembast_tutorial/data/user_dao.dart';
import 'package:sembast_tutorial/model/adderss.dart';
import 'package:sembast_tutorial/model/user.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserDao _userDao = UserDao();

  // Display a loading indicator right from the start of the app
  @override
  UserState get initialState => UsersLoading();

  // This is where we place the logic.
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUsers) {
      // Indicating that fruits are being loaded - display progress indicator.
      yield UsersLoading();
      yield* _reloadUsers();
    } else if (event is AddRandomUser) {
      // Loading indicator shouldn't be displayed while adding/updating/deleting
      // a single User from the database - we aren't yielding UsersLoading().
      await _userDao.insert(RandomUserGenerator.getRandomUser());
      yield* _reloadUsers();
    } else if (event is UpdateWithRandomUser) {
      final newUser = RandomUserGenerator.getRandomUser();
      // Keeping the ID of the User the same
      newUser.id = event.updatedUser.id;
      await _userDao.update(newUser);
      yield* _reloadUsers();
    } else if (event is DeleteUser) {
      await _userDao.delete(event.user);
      yield* _reloadUsers();
    }
  }

  Stream<UserState> _reloadUsers() async* {
    final fruits = await _userDao.getAllSortedByName();
    // Yielding a state bundled with the Users from the database.
    yield UsersLoaded(fruits);
  }
}

class RandomUserGenerator {
  static final _users = [

    //user 1
    User(
        name: 'Zubair Rehamn',
        email: 'zr@gmail.com',
        profilePic:
            'http://wbtta.org/images/table_tennis/profile_photo.jpg',
        skills: ['Android', 'Flutter', 'Xamarin'],
        address: Address(
            address: 'Sample address',
            city: 'Islamabad',
            state: 'ICT',
            zip: '44000')),

    //user 2
    User(
        name: 'Umair Adil',
        email: 'mua@gmail.com',
        profilePic:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNk-s5Ll5IPdMkMvl0QtVCmFSsmN-qg_xUnbGQNVdnQ59m2tCa',
        skills: ['Android', 'Flutter', 'iOS'],
        address: Address(
            address: 'Sample address',
            city: 'Karachi',
            state: 'ICT',
            zip: '44000')),

    //user 3
    User(
        name: 'Jawad Hassan',
        email: 'jh@gmail.com',
        profilePic:
        'https://ya-webdesign.com/images/profile-photo-png-1.png',
        skills: ['Android', 'Flutter', 'AR'],
        address: Address(
            address: 'Sample address',
            city: 'Lahore',
            state: 'ICT',
            zip: '44000')),
  ];

  static User getRandomUser() {
    return _users[Random().nextInt(_users.length)];
  }
}
