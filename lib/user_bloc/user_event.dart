import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembast_tutorial/model/user.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class LoadUsers extends UserEvent {}

class AddRandomUser extends UserEvent {}

class UpdateWithRandomUser extends UserEvent {
  final User updatedUser;

  UpdateWithRandomUser(this.updatedUser) : super([updatedUser]);
}

class DeleteUser extends UserEvent {
  final User user;

  DeleteUser(this.user) : super([user]);
}
