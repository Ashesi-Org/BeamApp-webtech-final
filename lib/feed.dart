// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:beam_frontend/Post.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:beam_frontend/APIConstants.dart' as API;
import 'package:beam_frontend/Student.dart';
import 'package:beam_frontend/viewProfile.dart';
import 'package:beam_frontend/userVerificationModal.dart';
import 'package:beam_frontend/apiCalls.dart';
import 'package:beam_frontend/editProfile.dart';
import 'package:beam_frontend/Post.dart';
import 'package:beam_frontend/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Query<Map<String, dynamic>> allPosts = FirebaseFirestore.instance.collection('posts').orderBy('date_posted', descending: true).orderBy('time_posted', descending:true);

class liveFeedPage extends StatelessWidget {
  @override
  
 Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      // Listen to a stream of data from Firestore, sorted by date and time
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: \${snapshot.error}');
        }

        if (!snapshot.hasData) {
          // Display a purple and blue progress indicator while the UI is being updated
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: Center(
           child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
           ),
            ),
        ),
            ]
              
                
              
              
              // LinearProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              // ),
            
          );
        }

        final posts = snapshot.data!.docs;

        // Convert the date and time to the correct Firebase format for each post
        final formattedPosts = posts.map((post) {
          final data = post.data();
          
          final timestamp = data['time_stamp'];
          return {...data, 'timestamp': timestamp};
        }).toList();

        // Sort the posts by timestamp in descending order
        formattedPosts.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

        // Display the list of posts using ListView.builder
        return ListView.builder(
          itemCount: formattedPosts.length,
          itemBuilder: (context, index) {
            final post = formattedPosts[index];

            return GestureDetector(
              onTap: () => _showPostCard(context, post),
              child: ListTile(
                title: Text(post['content']),
                subtitle: Text(post['name']),
                trailing: Text(post['time_posted'].toString()),
              ),
            );
          },
        );
      },
    );
  }



  void _openEditScreen(BuildContext context, Map<String, dynamic> post) async {
          Map<String, String> submittedUserInfo = await showModal(context);
          print(submittedUserInfo);
          if (submittedUserInfo.isNotEmpty){
          String studentID = submittedUserInfo['student_ID']!;
          Student? requestedStudent = await getStudent(studentID);
          // String name = requestedStudent!.name;
          // print("Student name = $name");

          if (studentID != post["student_ID"]){
              showDialog(
                context:context,
                builder: (BuildContext context){
return AlertDialog(
          title: Text(
                "Access Denied",
                style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                    ),
                ),
            content: Text(
            "You do not have permission to edit this post",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
 
                }
              );
              
          }
          else{
                String editedPost = '';
            showDialog(
              context: context,
              builder: (BuildContext context){
                return     AlertDialog(
      title: Text("Edit Post"),
      content: TextField(
        onChanged: (value) {
          editedPost = value;
        },
        decoration: InputDecoration(hintText: "Enter your new post here"),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Submit"),
          onPressed: () async {

            // Do something with the user input
            print("User entered: $editedPost");
          await patchPost(post["name"], post["student_ID"], editedPost, post["post_ID"]);
              //Action to take if post is found and edited


            
            // else{
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context){
            //  return  AlertDialog(
            //   title: Text('Edit Failed'),
            //   content: Text('your post could not be edited :/'),
            //   actions: [
            //     ElevatedButton(
            //       child: Text('Back to Feed'),
            //       onPressed: () {
            //         Navigator.pop(context);

            //         // Do something when the button is pressed
            //         // Navigator.push(context,
            //         //           MaterialPageRoute(builder: (context) => feedView()),
            //         // );
            //         },
            //         ),
            //     ],
            //             );
            //     }
            //   ,);
             
            // }

            // Close the dialog box
          },
        ),
      ]
            ); 
              }

            );
        
          }        
      
   
         }

    // Code to open edit screen
    
  }
  void _showPostCard(BuildContext context, Map<String, dynamic> post) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Color.fromARGB(255, 13, 90, 152),
                Colors.grey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(post['name'], style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),
                      Text(post['content'], style: TextStyle(fontSize: 16.0)),
                      SizedBox(height: 8.0),
                      Text(post['time_posted'].toString(), style: TextStyle(fontSize: 12.0)),
                    ],
                  ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _openEditScreen(context, post),
                    child: Text('Edit'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white,
                    minimumSize:const Size(200, 75)),
                    
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Return to Feed'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, 
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 75)),
                  ),
                ],
              ),
             
            ],
          ),
        ),
      ),
    ),
  );
}
}

class feedView extends StatefulWidget {
  const feedView({super.key});

  @override
  State<feedView> createState() => _feedViewState();
}

class _feedViewState extends State<feedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Feed Page'),
      actions: <Widget> [
        TextButton.icon(
          style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 242, 241, 246)),
          ),
          label: Text("Welcome Page"),
          icon: const Icon(UniconsSolid.airplay),
          onPressed: () {
            Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
          }
                
          )
      ]

      
    ),
    body: liveFeedPage(),
    
    floatingActionButton: FloatingActionButton(
      onPressed: () async{
          String posterName = "";
          Map<String, String> submittedUserInfo = await showModal(context);
          print(submittedUserInfo);
          if (submittedUserInfo.isNotEmpty){
          String studentID = submittedUserInfo['student_ID']!;
          Student? requestedStudent = await getStudent(studentID);
          String name = requestedStudent!.name;
          posterName = name;
          print("Student name = $name");

          Map<String, String> submittedUserPost = await showPostModal(context);
          print(submittedUserPost);
          if (submittedUserPost.isNotEmpty){
          String post = submittedUserPost['postContent']!;
          String name = posterName;

           await sendPost(name, studentID, post);
          }

          

          // ignore: use_build_context_synchronously
        
   
      }
      },
      child: Icon(UniconsLine.bolt),
    ),
    );
  }

  
  
  void createPost (requestedStudent) {
    String postContentHint = "Enter your post here";
    String emailHint = "Enter your email here";

    String newName = requestedStudent.name;
    String newID = requestedStudent.student_ID;
  
    


    void _showDialog(BuildContext context) {
    String postContent = '';
    String userEmail = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  postContent = value;
                },
                decoration: InputDecoration(
                  labelText: 'Post',
                  hintText: postContentHint
                ),
              ),
              TextField(
                onChanged: (value) {
                  userEmail = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: emailHint
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Do something with the text fields
                print('Post: $postContent');
                print('Email: $userEmail');
                sendPost(newName, newID, postContent);
                Navigator.of(context).pop();
              },
              child: Text('Send Beam'),
            ),
          ],
        );
    },
  );
  _showDialog(context);
}

  }
}