import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreUser{
createChatRoom(String chatRoomid,Map chatRoomInfo)async{
final snapshot=await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomid).get();
if(snapshot.exists){
  return true;
}else{
  return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomid).set(chatRoomInfo as Map<String,dynamic>);
}
}
Future<QuerySnapshot> getUserInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("id", isEqualTo: id)
        .get();
  }
  Future addMessage(String chatRoomId,messageId,Map MessageInfoMap)async{
return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chat").doc(messageId).set(MessageInfoMap as Map<String,dynamic>);
  }
  updateLastmsg(String chatRommid,Map infoLastMsg)async{
    return await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRommid).set(infoLastMsg as Map<String,dynamic>,SetOptions(merge: true));
  }
  }