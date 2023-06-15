import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:provider/provider.dart';
import '../../../providers/task.dart';

var logger = Logger();

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: const EdgeInsets.only(left: 28, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              textAlign: TextAlign.start,
              "Мои дела",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 20,
                  height: 32 / 20),
            ),
          ),
          Consumer<Tasks>(
            builder: (context, value, _) => IconButton(
              padding: const EdgeInsets.only(top: 5),
              onPressed: () {
                value.toggleShowDone();
                logger.i("Toggle showDone mode");
              },
              icon: value.showUndone
                  ? Icon(
                      Icons.visibility,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),
        ],
      ),
    );
    Widget hideText = Padding(
      padding: const EdgeInsets.only(left: 47),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<Tasks>(
            builder: (context, tasks, child) => Text(
              "Выполнено - ${tasks.counter}",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.color,
                  fontSize: 16,
                  height: 20 / 16),
            ),
          )
        ],
      ),
    );

    return SliverAppBar(
      stretch: true,
      snap: true,
      floating: true,
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).backgroundColor,
      pinned: true,
      expandedHeight: 130,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 10),
        expandedTitleScale: 32 / 20,
        title: title,
        background: hideText,
        centerTitle: false,
      ),
    );
  }
}
