class ChatUser{
  final int id;
  final String name;

  ChatUser({this.id, this.name});
}

ChatUser userOne = ChatUser(id: 1, name: 'Nabeel');
ChatUser userTwo = ChatUser(id: 2, name: 'Zain \nUr Rehman');


class ChatMessages{
  final ChatUser firstUserId;
  final ChatUser secondUserId;
  final String message;
  final DateTime dateTime;

  ChatMessages({this.firstUserId, this.secondUserId, this.message, this.dateTime});
}


List<ChatMessages> messages = <ChatMessages>[
  ChatMessages(firstUserId: userOne, secondUserId: userTwo, message: 'Hello', dateTime: DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day)),
  ChatMessages(firstUserId: userTwo, secondUserId: userOne, message: 'how are you', dateTime: DateTime(DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)),
  ChatMessages(firstUserId: userOne, secondUserId: userTwo, message: 'I am fine.', dateTime: DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
];