// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';

import '../../helpers/enums.dart';
import '../../models/task.dart';
import '../local storage/tasks_list_db.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class TaskListAPIStorage implements TaskDB {
  @override
  Future<void> addItem(Task task) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );

    var revision = json.decode(response.body)['revision'].toString();
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
    await http.post(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'X-Last-Known-Revision': revision,
        'Content-Type': 'appplication/json',
      },
      body: json.encode(obj),
    );

    Uri url1 = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response1 = await http.get(
      url1,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );
    (json.decode(response1.body)['list'].toString());
  }

  @override
  Future<void> removeItem(String id) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );

    var revision = json.decode(response.body)['revision'].toString();
    await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'X-Last-Known-Revision': revision,
        'Content-Type': 'appplication/json',
      },
    );
  }

  @override
  Future<void> updateItem(String id, Task newTask) async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );
    var revision = json.decode(response.body)['revision'].toString();
    var createdAt = json.decode(response.body)['element']['created_at'];
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

    await http.put(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
        'X-Last-Known-Revision': revision,
      },
      body: json.encode(obj),
    );
  }

  @override
  Future<List> getAll() async {
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );
    return json.decode(response.body)['list'];
  }
}
