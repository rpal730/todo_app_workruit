import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/utils/ui_helper.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_textfield.dart';
import 'package:todo_app_workruit/viewmodel/homepage/bloc/homepage_bloc.dart';

class AddTask extends StatefulWidget {
  static const String routeName = '/addtask';
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final HomepageBloc _bloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool rememberMe = false;

  void _listenHomepageBloc(BuildContext context, HomepageState state) {
    if (state is AddTaskSuccess) {
      context.pop(true);
      showSuccessSnackbar(context, 'Successfully Added');
    } else if (state is AddTaskFailed) {
      showErrorSnackbar(context, state.message);
    }
  }

  void _addTask() {
    _bloc.add(
      AddTaskEvent(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      ),
    );
  }

  @override
  void initState() {
    _bloc = HomepageBloc(context.read<UserRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //--------------------------
              const SizedBox.square(dimension: 30),
              const Text(
                'New Task.',
                style: TextStyle(fontSize: 50),
              ),
              CustomTextField(
                controller: titleController,
                hint: 'Enter title',
                title: 'Title',
              ),
              const SizedBox.square(dimension: 10),
              CustomTextField(
                controller: descriptionController,
                hint: 'Enter description',
                title: 'Description',
                maxLines: 6,
              ),
              const SizedBox.square(dimension: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: CustomProcessingButton(
                        onPressed: () {
                          context.pop();
                        },
                        title: 'Back'),
                  ),
                  const SizedBox.square(dimension: 10),
                  Flexible(
                    child: BlocConsumer<HomepageBloc, HomepageState>(
                      bloc: _bloc,
                      listener: _listenHomepageBloc,
                      builder: (context, state) {
                        return CustomProcessingButton(
                          isProcessing: state is AddTaskLoading,
                          backgroundColor: Colors.blueGrey,
                          onPressed: _addTask,
                          title: ('SUBMIT'),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
