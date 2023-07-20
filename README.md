# To Do list

## Приложение TODO лист by LilyKras 
tg: @lilykras

1. Список задач с возможностью скрыть выполненные (кнопка с глазом). Если задача слишком длинная, то сокрашается до 3-х строк, а дальше ...
2. Помимо основного экрана со списком задач так же присутствует экран редактирования задачи, в котором можно создать новую или удалить имеющуюся/отредактировать имеющуюся задачу в зависимости от режима этого экрана
3. Каждая из задач может быть удалена свайпом влево (20%) или с помощью экрана редактирования 
4. Каждая из задач может быть выполнена свайпом вправо (20%) или с помощью чекбокса 
5. С помощью кнопки внизу (Floating Button) и кнопки "Новое" можно перейти на второй экран в режиме создания новой такси
6. С нажатием на иконку INFO можно перейти на второй экран в режиме создания новой такси, где можно будет отредактировать дату, приоритетность и текст выбранной такси, а так же удалить ее
7. На основном экране присутствует счетчик выполненных тасков (считает сколько задач выполнено, не считает удаленные выполненные задачу)
8. Реализованы светлая и темная темы
9. Обработка полей формы (текст не пустой должен быть)
10. Присутствует логгирование 
11. Есть иконка у андройда и ios
12. Реализованна интернационализация для английского и русского языков
13. Добавлен flutter_lints
14. Для стейт-менеджмента используются RiverPod и иногда StateFullWidgets, где не требуется создание отдельного провайдера
15. Реализована работа с бэкендом, данные отправляются/получаются с сервера. Работа с сетью выделена в отдельный слой. Присутствует небольшая обработка ошибок
16. Организовано сохранение данных на диск при помощи одной из представленных библиотек (https://pub.dev/packages/sqflite). Реализована работа в оффлайн 
17. Открывается экран добавления по ссылке (http://lily.dev/newTask) - реализованы deeplinks
18. Подключила Firebase Analitics, Firebase Crashlytics
19. Поддержаны 2 флейвора - различия в названии
20. Есть распространение через сервис Firebase App Distribution (https://appdistribution.firebase.dev/i/ae1144ee85c8f950)
21. Реализована работа с Remote Configs (дефолтный красный по Фигме vs #FF793cd8)


## Ссылка на загрузку .apk с флейвором prod:
### [Тык](https://drive.google.com/uc?export=download&id=196zfK6CNt5wkiVUWYc5N3BeN968Lp6Ja)

## Ссылка на загрузку .apk с флейвором dev:
### [Тык](https://drive.google.com/uc?export=download&id=1jIj9jJ0MBB4MTJkn05qok6laI9-zLq-6)


## Немного скринов:
1. IPhone

> Главный экран

Светлая тема
![https://ibb.co/JmcnpbW](https://i.ibb.co/S56Nm1D/IMG-5521.png)

Темная тема
![https://ibb.co/SxzSWCM](https://i.ibb.co/cvjqMnZ/IMG-5522.png)


> Экран сохранения в разных режимах

Светлая тема
![https://ibb.co/T4qjCvN](https://i.ibb.co/F5qZPxd/IMG-5502.png)
![https://ibb.co/2FszWGr](https://i.ibb.co/WHPrGmX/IMG-5503.png)

Темная тема
![https://ibb.co/ZLH8zBk](https://i.ibb.co/Bz4Z2yS/IMG-5506.png)
![https://ibb.co/1vSNjGG](https://i.ibb.co/0DwLvyy/IMG-5504.png)

2. Android

![https://ibb.co/s5qR8hv](https://i.ibb.co/rbH0DgG/IMG-5525.jpg)
![https://ibb.co/DK4w2D6](https://i.ibb.co/WKnBJWd/IMG-5510.jpg)
![https://ibb.co/tmD1B5N](https://i.ibb.co/f1HTM7K/IMG-5511.jpg)


3. Лендскейп и планшет 
![https://ibb.co/yhZcPd0](https://i.ibb.co/9w1kgcn/Simulator-Screenshot-i-Pad-Air-5th-generation-2023-07-16-at-14-57-35.png) 

Не знаю, вроде норм выглядит... Что хотели в этом критерии мне не понятно 

Могу еще вот так сделать:
![https://ibb.co/3r8VfWg](https://i.ibb.co/h7nrXH3/Simulator-Screenshot-i-Pad-Air-5th-generation-2023-07-17-at-05-22-41.png)

Работа с firebase:

1. Firebase Crashlytics
![https://ibb.co/VC4crvR](https://i.ibb.co/qgQ3XRK/2023-07-16-19-20-18.png) 

2. Remote Configs 
![https://ibb.co/QbbB68T](https://i.ibb.co/GxxwVs8/2023-07-16-23-02-59.png) 

3. Аналитика с помощью Firebase
![https://ibb.co/6bd0VfP](https://i.ibb.co/CvrKNT7/2023-07-17-00-36-10.png)

4. Firebase App Distribution 
![https://ibb.co/SrHLPFF](https://i.ibb.co/ws8vR55/2023-07-16-22-57-44.png) 
