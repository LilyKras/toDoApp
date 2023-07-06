// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';

import '../../helpers/enums.dart';
import '../../models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data.dart';

// Future<String> _getId() async {
//   var deviceInfo = DeviceInfoPlugin();
//   if (Platform.isIOS) {
//     var iosDeviceInfo = await deviceInfo.iosInfo;
//     return iosDeviceInfo.identifierForVendor ?? 'undefined IOS';
//   } else if (Platform.isAndroid) {
//     var androidDeviceInfo = await deviceInfo.androidInfo;
//     return androidDeviceInfo.id;
//   }
//   return 'unknown';
// }

String getPriority(Priority a) {
  if (a == Priority.hight) {
    return 'important';
  }
  if (a == Priority.low) {
    return 'low';
  }
  return 'basic';
}

Priority importanceToPriority(String imp) {
  if (imp == 'low') {
    return Priority.low;
  }
  if (imp == 'important') {
    return Priority.hight;
  }
  return Priority.none;
}

Future<String> getRevision() async {
  try {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );

    return json.decode(response.body)['revision'].toString();
  } catch (e) {
    return '0';
  }
}

class TaskListAPIStorage implements TaskDB {
  @override
  Future<void> addItem(Task task) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');

    var obj = {
      'element': {
        'id': task.id, // уникальный идентификатор элемента
        'text': task.text,
        'importance': getPriority(
          task.priority,
        ), // importance = low | basic | important// int64, может отсутствовать, тогда нет
        'done': task.doneStatus,
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'changed_at': DateTime.now().millisecondsSinceEpoch,
        'last_updated_by': 'unknown'
      }
    };
    if (task.hasDate != false) {
      obj['element']?['deadline'] = task.date!.millisecondsSinceEpoch;
    }
    try {
      await http.post(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'X-Last-Known-Revision': await getRevision(),
          'Content-Type': 'appplication/json',
        },
        body: json.encode(obj),
      );
    } catch (e) {
      debugPrint('No internet');
    }
  }

  @override
  Future<void> removeItem(String id) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    try {
      await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'X-Last-Known-Revision': await getRevision(),
          'Content-Type': 'appplication/json',
        },
      );
    } catch (e) {
      debugPrint('No internet');
    }
  }

  @override
  Future<void> updateItem(String id, Task newTask) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    var revision = '0';
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'Content-Type': 'appplication/json',
        },
      );
      revision = json.decode(response.body)['revision'].toString();
      createdAt = json.decode(response.body)['element']['created_at'];
    } catch (e) {
      createdAt = DateTime.now().millisecondsSinceEpoch;
      revision = '0';
    }
    var obj = {
      'element': {
        'id': newTask.id, // уникальный идентификатор элемента
        'text': newTask.text,
        'importance': getPriority(
          newTask.priority,
        ), // importance = low | basic | important
        'done': newTask.doneStatus, // может отсутствовать
        'created_at': createdAt,
        'changed_at': DateTime.now().millisecondsSinceEpoch,
        'last_updated_by': 'unknown'
      }
    };
    if (newTask.hasDate != false) {
      obj['element']?['deadline'] = newTask.date!.millisecondsSinceEpoch;
    }
    try {
      await http.put(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'Content-Type': 'appplication/json',
          'X-Last-Known-Revision': revision,
        },
        body: json.encode(obj),
      );
    } catch (e) {
      debugPrint('No internet');
    }
  }

  @override
  Future<List<Task>> getAll() async {
    var tempList = [];
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'Content-Type': 'appplication/json',
        },
      );
      tempList = json.decode(response.body)['list'];
    } catch (e) {
      debugPrint('No internet');
    }

    List<Task> loadedTaskList = [];
    for (var elem in tempList) {
      var tempTask = Task(
        id: elem['id'],
        text: elem['text'],
        priority: importanceToPriority(elem['importance']),
        hasDate: elem.containsKey('deadline'),
        doneStatus: elem['done'],
        date: elem.containsKey('deadline')
            ? DateTime.fromMillisecondsSinceEpoch(elem['deadline'])
            : null,
      );
      loadedTaskList.add(tempTask);
    }
    return loadedTaskList;
  }

  @override
  Future<void> patch(List<Task> tasks) async {
    var revision = await getRevision();

    var obj = {'list': []};

    for (var task in tasks) {
      int createdAt, changedAt;

      Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/${task.id}');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer demirelief',
          'Content-Type': 'appplication/json',
        },
      );
      createdAt = json.decode(response.body)['element']['created_at'];
      changedAt = json.decode(response.body)['element']['changed_at'];
      obj['list']?.add(
        {
          'id': task.id, // уникальный идентификатор элемента
          'text': task.text,
          'importance': getPriority(
            task.priority,
          ), // importance = low | basic | important
          'done': task.doneStatus, // может отсутствовать
          'created_at': createdAt,
          'changed_at': changedAt,
          'last_updated_by': 'unknown'
        },
      );
    }

    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
        'X-Last-Known-Revision': revision,
      },
      body: json.encode(obj),
    );
  }
}
