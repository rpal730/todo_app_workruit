import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/model/tasks.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/utils/ui_helper.dart';
import 'package:todo_app_workruit/view/add_task/add_task.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/edit_task/edit_task.dart';
import 'package:todo_app_workruit/view/homepage/widgets/task_card.dart';
import 'package:todo_app_workruit/view/landing_page/landing_page.dart';
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
if(state is SignoutSuccess){
  context.goNamed(LandingPage.routeName);
}

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
      appBar: AppBar(title: const Text('To-do Tasks'), actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Do you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                          width: 100,
                          child: CustomProcessingButton(
                              title: 'Yes',
                              onPressed: () => _bloc.add(SignoutEvent()))),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout))
      ]),
      floatingActionButton: SizedBox(
          width: 100,
          child: CustomProcessingButton(
            backgroundColor: Colors.blueGrey,
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
                    onPressed: () {
                      var pathParameters = {
                        'title': tasks[index].title,
                        'taskId': tasks[index].id,
                        'description': (tasks[index].description != '')
                            ? tasks[index].description
                            : ' ',
                      };

                      context
                          .pushNamed(EditTask.routeName,
                              pathParameters: pathParameters)
                          .then((value) {
                        if (value == true) {
                          _bloc.add(FetchTaskEvent());
                        }
                      });
                    });
              },
              itemCount: tasks.length,
            );
          },
        )),
      ),
    );
  }
}
