import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembast_tutorial/model/user.dart';

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users) : super([users]);
}
