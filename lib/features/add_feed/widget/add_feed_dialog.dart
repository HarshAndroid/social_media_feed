import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global.dart';
import '../cubit/add_feed_cubit.dart';

class AddFeedDialog extends StatefulWidget {
  const AddFeedDialog({super.key});

  @override
  State<AddFeedDialog> createState() => _AddFeedDialogState();
}

class _AddFeedDialogState extends State<AddFeedDialog> {
  late final _c = context.read<AddFeedCubit>();
  final _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_node),
      child: Scaffold(
        appBar: AppBar(
          //
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),

          //
          title: const Text('Create Feed'),
          actions: const [],
        ),

        //fab
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _c.postFeed(context),
            icon: const Icon(Icons.send_rounded),
            label: const Text('Post')),

        //body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: mq.width * .05,
            right: mq.width * .05,
            top: mq.height * .02,
            bottom: mq.height * .1,
          ),
          child: // input field
              TextFormField(
            controller: _c.contentC,
            maxLines: null,
            minLines: 3,
            autocorrect: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(CupertinoIcons.text_bubble, size: 20),
                hintText: 'Just your creativity & write something amazing.'),
          ),
        ),
      ),
    );
  }
}
