import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String uid;
  final String email;
  final String username;
  final String name;
  final String password;
  final String phoneNumber;
  final Timestamp createAt;
  final Timestamp lastSeen;
  final bool isOnline;
  final String? fcmToken;
  final List<String> blockedUser;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.name,
    required this.password,
    required this.phoneNumber,
    Timestamp? createAt,
    Timestamp? lastSeen,
    this.isOnline = false,
    this.fcmToken,
    this.blockedUser = const [],
  }
  ) : createAt = createAt ?? Timestamp.now(),
        lastSeen = lastSeen ?? Timestamp.now();

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? name,
    String? password,
    String? phoneNumber,
    Timestamp? createAt,
    Timestamp? lastSeen,
    bool? isOnline,
    String? fcmToken,
    List<String>? blockedUser,
  })
  {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        username: username ?? this.username,
        name: name ?? this.name,
        password: password ?? this.password,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fcmToken: fcmToken ?? this.fcmToken,
        isOnline: isOnline ?? this.isOnline,
        createAt: createAt ?? this.createAt,
        lastSeen: lastSeen ?? this.lastSeen,
        blockedUser: blockedUser ?? this.blockedUser,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String,dynamic>;
    return UserModel(
         uid: doc.id,
        email: data["email"] ?? "",
        username: data["username"] ?? "",
        name: data["name"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        fcmToken: data["fcmToken"]  ?? "",
        lastSeen: data["lastSeen"]  ?? Timestamp.now(),
        createAt: data["createAt"] ?? Timestamp.now(),
        isOnline: data["isOnline"] ?? "",
        blockedUser: List<String>.from(data["blockedUser"]),
        password: data["password"] ?? "",
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'email' : email,
      'username' : username,
      'name' : name,
      'password' : password,
      'phoneNumber' : phoneNumber,
      'fcmToken' : fcmToken,
      'isOnline' : isOnline,
      'blockedUser' : blockedUser,
      'lastSeen' : lastSeen,
      'createdAt' : createAt,
    };
  }

}

