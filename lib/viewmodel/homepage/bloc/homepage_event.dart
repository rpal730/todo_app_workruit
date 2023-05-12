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
