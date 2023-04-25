class Post{
  final String postContent;
  final String timePosted;
  final String datePosted;
  final String studentID;
  final String studentName;


  Post({required this.postContent, 
  required this.timePosted, 
  required this.datePosted, 
  required this.studentID,
  required this.studentName
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postContent: json['content'],
      timePosted: json['time_posted'],
      datePosted: json['date_posted'],
      studentID:json['student_ID'], 
      studentName:json['name']
    );
  }

  Map<String, dynamic> toJson() => {
        'content': postContent,
        'time_posted': timePosted, 
        'date_posted':datePosted,
        'student_ID':studentID,
        'name': studentName,
      };
}
