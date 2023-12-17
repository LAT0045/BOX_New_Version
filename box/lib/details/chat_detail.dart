import 'package:box/class/food.dart';
import 'package:box/class/message.dart';
import 'package:box/class/shop.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatDetail extends StatefulWidget {
  final UserCredential userCredential;
  final Shop shop;

  ChatDetail({required this.userCredential, required this.shop});

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  late DatabaseReference _reference;
  TextEditingController _textEditingController = TextEditingController();
  List<Map<dynamic, dynamic>> _messages = [];
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    String roomID = '${widget.userCredential.user!.uid}_${widget.shop.shopId}';
    _reference = FirebaseDatabase.instance.ref().child('Messages').child(roomID);

    _reference.onChildAdded.listen((event) {
      Map<dynamic, dynamic>? messageData =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (messageData != null) {
        setState(() {
          _messages.add(Map.from(messageData));
        });
      }
    });
  }

  void _sendMessage(String text) {
    _reference.push().set({
      'senderID': widget.userCredential.user!.uid,
      'receiverID': widget.shop.shopId,
      'message': text,
      'timestamp': ServerValue.timestamp,
    });
    _textEditingController.clear();
  }

  String _getFormattedTime(dynamic timestamp) {
    int time = int.tryParse(timestamp.toString()) ?? 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  Widget _buildMessageItem(int index) {
    Map<dynamic, dynamic> message = _messages[index];
    DateTime messageDate = DateTime.fromMillisecondsSinceEpoch(
      int.tryParse(message['timestamp'].toString()) ?? 0,
    );

    bool showDate = true;

    if (index > 0) {
      DateTime previousMessageDate = DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(_messages[index - 1]['timestamp'].toString()) ?? 0,
      );

      if (messageDate.year == previousMessageDate.year &&
          messageDate.month == previousMessageDate.month &&
          messageDate.day == previousMessageDate.day) {
        showDate = false;
      }
    }

    if (showDate) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                messageDate.year == now.year
                    ? '${messageDate.day}-${messageDate.month}'
                    : '${messageDate.day}/${messageDate.month}/${messageDate.year}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
          ),
          _buildMessageWidget(message),
        ],
      );
    } else {
      return _buildMessageWidget(message);
    }
  }

  Widget _buildMessageWidget(Map<dynamic, dynamic> message) {
    return Align(
      alignment: message['senderID'] == widget.userCredential.user!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          decoration: BoxDecoration(
            color: message['senderID'] == widget.userCredential.user!.uid
                ? AppColors.mediumOrangeColor
                : AppColors.lightGrayColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: message['senderID'] == widget.userCredential.user!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                message['message'],
                style: TextStyle(
                  color: message['senderID'] == widget.userCredential.user!.uid
                      ? Colors.white
                      : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Comfortaa',
                ),
              ),
              SizedBox(height: 5),
              Text(
                _getFormattedTime(message['timestamp']),
                style: TextStyle(
                  color: message['senderID'] == widget.userCredential.user!.uid
                      ? Colors.white
                      : Colors.black,
                  fontSize: 12,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.mediumOrangeColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.shop.shopImage,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.shop.shopName,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   "Hoạt động 3 phút trước",
                  //   style: const TextStyle(
                  //       fontSize: 12,
                  //       fontFamily: 'Comfortaa',
                  //       color: Colors.white),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                int reversedIndex = _messages.length - 1 - index;
                return _buildMessageItem(reversedIndex);
              },
            ),
          ),
          Container(
            color: AppColors.grayColor.withOpacity(0.08),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.orangeColor.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 4 *  20.0, 
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Nhập tin nhắn...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        ),
                        cursorColor: AppColors.mediumOrangeColor,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ),),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.mediumOrangeColor),
                  onPressed: () {
                    _sendMessage(_textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
