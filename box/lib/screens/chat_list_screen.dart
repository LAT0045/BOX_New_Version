import 'dart:async';
import 'dart:convert';

import 'package:box/class/food.dart';
import 'package:box/class/message.dart';
import 'package:box/class/shop.dart';
import 'package:box/details/chat_detail.dart';
import 'package:box/screens/shop_screen.dart';
import 'package:box/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  final UserCredential userCredential;
  const ChatListScreen({super.key, required this.userCredential});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<String> roomIds = [];
  Map<String, Message> latestMessages = {};
  Map<String, Shop> shop = {};

  Future<void> getRoomsByUserId(String userId) async {
    final databaseReference = FirebaseDatabase.instance;
    final messageSnapshot = await databaseReference.ref("Messages").get();
    final messageMap = messageSnapshot.value as Map<dynamic, dynamic>;

    messageMap.forEach((roomId, messages) {
      if (roomId.toString().contains(userId)) {
        roomIds.add(roomId.toString());
      }
    });
    await getLatestMessagesForRooms(roomIds);
  }

  Future<void> getLatestMessagesForRooms(List<String> roomIds) async {
    for (var roomId in roomIds) {
      final databaseReference = FirebaseDatabase.instance;
      final messageSnapshot = await databaseReference
          .ref("Messages")
          .child(roomId)
          .limitToLast(1)
          .get();
      final messageMap = messageSnapshot.value as Map<dynamic, dynamic>;
      messageMap.forEach((messageId, messageData) {
        final message = Message.fromMap(messageId.toString(), messageData);
        setState(() {
          latestMessages[roomId] = message;
        });
      });

      final ids = roomId.split('_');
      final shopId = ids[1];

      print(shopId);

      setState(() {
        getShopById(shopId).then((shopData) {
          setState(() {
            shop[roomId] = shopData;
          });
        });
      });
    }
  }

  Future<Shop> getShopById(String shopId) async {
    final databaseReference = FirebaseDatabase.instance;
    final shopSnapshot = await databaseReference.ref("Shops").child(shopId).get();
    final shopData = shopSnapshot.value as Map<dynamic, dynamic>?;

    if (shopData != null) {
      return Shop.fromJson(shopId, Map<String, dynamic>.from(shopData));
    } else {
      throw Exception("Shop not found!");
    }
  }

  String _getFormattedTime(dynamic timestamp) {
    int time = int.tryParse(timestamp.toString()) ?? 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    getRoomsByUserId(widget.userCredential.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: AppColors.mediumOrangeColor,
        title: Text(
          "Tin nhắn",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Comfortaa",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: roomIds.length,
          itemBuilder: (context, index) {
            final roomId = roomIds[index];
            final latestMessage = latestMessages[roomId];
            final shopInfo = shop[roomId];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: ClipOval(
                child: latestMessage != null && shopInfo != null
                    ? Image.network(
                        shopInfo.shopImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : Text("No messages"),
              ),
              title: latestMessage != null
                  ? Text("${shopInfo?.shopName}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold))
                  : Text("No messages"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: latestMessage != null
                            ? Text(
                                latestMessage.senderId == widget.userCredential.user!.uid
                                    ? "Bạn: ${latestMessage.messageContent}"
                                    : latestMessage.messageContent, 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa',
                                  color: AppColors.grayColor,
                                ),
                              )
                            : Text("No messages"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _getFormattedTime(latestMessage?.timestamp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          color: AppColors.grayColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
                if (shopInfo != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetail(
                        userCredential: widget.userCredential,
                        shop: shopInfo,
                      ),
                    ),
                  );
                } else {
                  print("Shop information is not available");
                }
              },
            );
          },
        ),
      ),
    );
  }
}
