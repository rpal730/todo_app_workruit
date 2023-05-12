part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent {}

class SignoutEvent extends HomepageEvent {}

class AddTaskEvent extends HomepageEvent {
  final String title;
  final String? description;
  AddTaskEvent({required this.title, this.description});
}

class FetchTaskEvent extends HomepageEvent {}
class DeleteTaskEvent extends HomepageEvent {
  final String taskId;
  DeleteTaskEvent({required this.taskId});
}

class EditTaskEvent extends HomepageEvent {
  final String title;
  final String taskId;
  final String? description;
  EditTaskEvent({required this.title, this.description, required this.taskId});
}
