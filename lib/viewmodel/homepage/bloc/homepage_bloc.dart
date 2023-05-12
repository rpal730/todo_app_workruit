import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_workruit/model/tasks.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final UserRepository userRepository;
  HomepageBloc(this.userRepository) : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignoutEvent>(_signout);
    on<AddTaskEvent>(_addTask);
    on<FetchTaskEvent>(_fetchTask);
  }
  //---------for signout
  void _signout(SignoutEvent event, Emitter<HomepageState> emit) async {
    emit(SignoutLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(SignoutSuccess());
    } catch (e) {
      emit(SignoutFailed(e.toString()));
    }
  }

  //--------for adding task
  void _addTask(AddTaskEvent event, Emitter<HomepageState> emit) async {
    emit(AddTaskLoading());
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      await userRepository.addTask(
          userId: userId, title: event.title, description: event.description);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailed(e.toString()));
    }
  }

  //--------for fetching task
  void _fetchTask(FetchTaskEvent event, Emitter<HomepageState> emit) async {
    emit((TasksFetchLoading()));
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var tasks = await userRepository.fetchTasks(
        userId: userId,
      );
      emit(TasksFetchSuccess(tasks: tasks));
    } catch (e) {
      emit(AddTaskFailed(e.toString()));
    }
  }
}
