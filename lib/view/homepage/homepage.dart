import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/model/tasks.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/utils/ui_helper.dart';
import 'package:todo_app_workruit/view/add_task/add_task.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/homepage/widgets/task_card.dart';
import 'package:todo_app_workruit/viewmodel/homepage/bloc/homepage_bloc.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/homepage';
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final HomepageBloc _bloc;
  List<TaskModel> tasks = [];

  @override
  void initState() {
    _bloc = HomepageBloc(context.read<UserRepository>());
    _bloc.add(FetchTaskEvent());
    super.initState();
  }

  _listenHomepageBloc(BuildContext context, HomepageState state) {
    if (state is TasksFetchSuccess) {
      print('-------------fetched tasks--------');
      tasks = state.tasks;
    } else if (state is TasksFetchFailed) {
      showErrorSnackbar(context, 'Oops couldnt fetch, uh oh');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
          width: 100,
          child: CustomProcessingButton(
            onPressed: () {
              context.pushNamed(AddTask.routeName).then((isNewTaskAdded) {
                _bloc.add(FetchTaskEvent());
              });
              print('you are trying to add task');
            },
            title: 'Add  + ',
          )),
      body: SafeArea(
        child: Center(
            child: BlocConsumer<HomepageBloc, HomepageState>(
          listener: _listenHomepageBloc,
          bloc: _bloc,
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskCard(
                  title: tasks[index].title,
                  description: tasks[index].description,
                  onPressed: () {},
                );
              },
              itemCount: tasks.length,
            );
          },
        )),
      ),
    );
  }
}
