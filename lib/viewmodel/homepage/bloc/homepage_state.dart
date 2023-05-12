part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

//-------------signout related
class SignoutLoading extends HomepageState {}

class SignoutSuccess extends HomepageState {}

class SignoutFailed extends HomepageState {
  final String message;
  SignoutFailed(this.message);
}

//-------------fetch tasks related

class TasksFetchLoading extends HomepageState {}

class TasksFetchSuccess extends HomepageState {
  final List<TaskModel> tasks;

  TasksFetchSuccess({required this.tasks});
}

class TasksFetchFailed extends HomepageState {}

//-----------------add task related

class AddTaskLoading extends HomepageState {}

class AddTaskSuccess extends HomepageState {}

class AddTaskFailed extends HomepageState {
  final String message;
  AddTaskFailed(this.message);
}
