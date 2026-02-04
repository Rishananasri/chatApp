import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessag(String receiverId, String message) async {
    final String curretuserId = _firebaseAuth.currentUser!.uid;
    final String currentuserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: curretuserId,
      senderEmail: currentuserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [curretuserId, receiverId];
    ids.sort(); 
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userid, String otherUserid) {
    List<String> ids = [userid, otherUserid];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> deleteChat(String otherUserId) async {
    try {
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      List<String> ids = [currentUserId, otherUserId];
      ids.sort(); 
      String chatRoomId = ids.join('_');

      final messagesSnapshot = await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .get();

      for (var doc in messagesSnapshot.docs) {
        await doc.reference.delete();
      }

      await _firestore.collection('chat_rooms').doc(chatRoomId).delete();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting chat: $e");
      }
    }
  }
}