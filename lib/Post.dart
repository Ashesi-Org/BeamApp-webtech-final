import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String postContent;
  final String timePosted;
  final String datePosted;
  final String studentID;
  final String studentName;
  final Timestamp timeStamp;


  Post({required this.postContent, 
  required this.timePosted, 
  required this.datePosted, 
  required this.studentID,
  required this.studentName,
  required this.timeStamp
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postContent: json['content'],
      timePosted: json['time_posted'],
      datePosted: json['date_posted'],
      studentID:json['student_ID'], 
      studentName:json['name'],
      timeStamp:json["time_stamp"]
    );
  }

  Map<String, dynamic> toJson() => {
        'content': postContent,
        'time_posted': timePosted, 
        'date_posted':datePosted,
        'student_ID':studentID,
        'name': studentName,
        'time_stamp': timeStamp
      };
}
