import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? description;
  final void Function() onPressed;
  const TaskCard(
      {super.key,
      required this.title,
      this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
          boxShadow: const [BoxShadow(color: Colors.black)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 30)),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                ))
          ],
        ),
        if (description != '')
          Text(description ?? '',
              style: const TextStyle(color: Colors.black, fontSize: 15))
      ]),
    );
  }
}
