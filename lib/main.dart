// Container(
//   height: MediaQuery.of(context).size.height,
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [Colors.red, Colors.orange, Colors.yellow]
//     ),
//   ),
//   child: // Your page content goes here
// )

// ISSUE - Add link to flutter feed page with emails notifying users about posts
// ISSUE - Add dialog letting user know their sign up has been successful
// ISSUE - Make Sacramento Kings themed
// ISSUE - If user enters wrong ID, display dialog box informing them of the error
// ISSUE - Use gradient color
// ISSUE - Add button from sign up screen to welcome page
// ISSUE - Add buffering icon from welcome screen
// ISSUE - Handle sign up error if user signs up with already existing ID/email (?)
// ISSUE - Add date created to create account data
// ISSUE - Access name user entered and add it to Welcome! on welcome screen.
// ISSUE - Experiment with icons - In data input areas and some other places and 
// ISSUE - Reduce form size and add background image (Experiment with image)
// ISSUE - Make major and residence drop downs
// ISSUE - Activate sign up button after all fields have been filled
// ISSUE - Call email validation before submitting function. How to display error message
// ISSUE - Change font 
// ISSUE - Change on highlighted colour to fit theme (for input boxes)
// ISSUE - After signup bring up welcome screen, Say welcome, with name and generated username. Have buffering saying "Taking you to feed" and then move to feed(with one of those inflatable avatars maybe)
// ISSUE - Edit page and post should bring up a pop-up form for determining which user's functionality is being accessed.
// ISSUE - Make sure all fields are filled before enabling submit button

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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:beam_frontend/feed.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
      apiKey: '',
      appId: '',
      messagingSenderId: '', 
      projectId: 'beamapp-a16fe' ),
  );
  runApp(BeamApp());
}

class BeamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}


// ignore: non_constant_identifier_names


// void main()=> runApp(const CreateAccountApp());

class CreateAccountApp extends StatelessWidget {
  const CreateAccountApp();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signup': (context) => const CreateAccountScreen(),
        '/viewProfile': (context) => const viewProfile(),
        '/viewFeed': (context) => const feedView(),


      }
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: 
      const Center(
        child: SizedBox(
          width: 600,
          child: Card(

            child: CreateAccountForm(),
          )
        
      ),)
    );
  }
}

TextStyle style = const TextStyle(
  fontFamily: 'Ridgeway', 
  fontSize: 35.0,
  fontWeight: FontWeight.w100,
);
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen();

@override
Widget build(BuildContext context) {
  
  return MaterialApp(
 
home: Scaffold(
   body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
    
    child: Center (
      
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello and Welcome to BEAM!', 
            style:style,
          ),
          SizedBox(height: 32,),
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => feedView()),
                    );
                },
                child: Text('Go to Feed'),
                style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 75)), 
                ),
              ),
              SizedBox(width: 16), // Add some space between the buttons
              ElevatedButton(
                onPressed: () async {
                  Map<String, String> submittedUserInfo = await showModal(context);
                  print(submittedUserInfo);
                  if (submittedUserInfo.isNotEmpty){
                    String studentID = submittedUserInfo['student_ID']!;
                    Student? requestedStudent = await getStudent(studentID);
                        String name = requestedStudent!.name;
                        print("Student name = $name");
           
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => viewProfile(studentInfo: requestedStudent)),
                    );

                 
                  }                   
                },
                style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 75)), // Set the minimum size
                ),
                child: const Text('View Profile'),
              ),
            ],
          ),


          const SizedBox(height: 32),


          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Map<String, String> submittedUserInfo = await showModal(context);
                  print(submittedUserInfo);
                  if (submittedUserInfo.isNotEmpty){
                    String studentID = submittedUserInfo['student_ID']!;
                    Student? requestedStudent = await getStudent(studentID);
                        String name = requestedStudent!.name;
                        print("Student name = $name");
           
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile(studentInfo: requestedStudent)),
                    );

                 
                  }
                },
                child: Text('Edit Profile'),
                style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 75)), 
  ),
              ),
              SizedBox(width: 16), // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                    );
                },
                child: Text('Sign Up'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 75))
                )
              ),
            ],
          )
        ],
      ),
    ),
  ),
   
  ),
  );
  
}

  
}

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm();

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _nameTextController = TextEditingController();
  final _idTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _dobController = TextEditingController();
  final _yearGroupController = TextEditingController();
  final _majorTextController = TextEditingController();
  final _residenceController = TextEditingController();
  final _favFoodTextController = TextEditingController();
  final _favMovieTextController = TextEditingController();


  //Date of birth helper functions
  late DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1970),
      lastDate: DateTime(2020));
      if (picked != null){
        setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat.yMd().format(selectedDate);
      });
      }
}

//Options for drop downs
List<String> _residenceOptions = ['On-campus', 'Off-campus'];
 String? _selectedResidence;

List<String> _majorOptions = ['Computer Science', 'Computer Engineering', 'Electrical Engineering', 'Mechanical Engineering', 'Management Information Systems', 'Business Administration'];
String? _selectedMajor;

Color _dropDownColor = Colors.purple;

//Variables storing form field data
final _signUpInfo = GlobalKey<FormState>();
String _studentName = '';
String _studentID = '';
String _studentMajor = '';
String _studentResidence = '';
String _studentEmail = '';
String _studentMovie = '';
String _studentFood = '';
String _studentDateOfBirth = '';
String _studentYearGroup = '';




//Submit form function
void _submitForm() async {
  if (_signUpInfo.currentState!.validate()) {
    _signUpInfo.currentState!.save();
    try {
      await postStudent(_studentName,
       _studentID,
      _studentMajor,
      _studentResidence,
      _studentEmail,
      _studentMovie,
      _studentFood,
      _studentDateOfBirth,
      _studentYearGroup);
     
      // Do something with the server response
    } catch (e) {
      print('Error: $e');
    }
  }
}


Future<void> postStudent(
  String name, 
  String studentID,
  String studentMajor,
  String studentResidence,
  String studentEmail,
  String studentMovie,
  String studentFood,
  String studentDateOfBirth,
  String studentYearGroup
  ) async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/users");
  var request = await http.post(
    url, 
    headers:{'Content-Type':'application/json'},
    body: jsonEncode(<String, String>{
      "name": name,
      "student_ID": studentID,
      "major": studentMajor,
      "residence" : studentResidence,
      "email": studentEmail,
      "fav_food":studentFood,
      "fav_movie": studentMovie,
      "dob": studentDateOfBirth,
      "year_group": studentYearGroup

  
    }),
  );
  print(request.statusCode);
  if (request.statusCode == 201){
    print("Success");
  }
  else{
    print("eRROR");
  }

}

//Welcome Screen function 
void _showWelcomeScreen(){
  Navigator.of(context).pushNamed('/');
}

  @override
  Widget build(BuildContext context) {
    const nameHintText = "Enter your name";
    const yearGroupHintText = "Enter your year group";
    const foodHintText = "Enter your favourite food";
    const movieHintText = "Enter your favourite movie";
    const idHintText = "Enter your ID";
    const emailHintText = "Enter your student email";

    //Form value variables


    return Form(
      key: _signUpInfo,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Text('Create  Account', style: Theme.of(context).textTheme.headlineMedium),

          // Name field
          Padding(
            padding: EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _nameTextController,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                hintText: nameHintText,
                prefixIcon: const Icon(Icons.person)
                ),
                onSaved: (value){
                  _studentName = value ?? '';
                },
            ),
            ),
            
            // Student ID field
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _idTextController,
                decoration: const InputDecoration(
                hintText: idHintText,
                prefixIcon: Icon(UniconsLine.tag)
                ),
                onSaved: (value){
                  _studentID = value!;
                }
              ),
              ),

            // Date of birth field

            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
              controller: _dobController,
              decoration: const InputDecoration(
              labelText: 'Date of birth',
              hintText: 'Select your date of birth',
              prefixIcon: Icon(Icons.calendar_today),
          ),
              onSaved: (value){
                _studentDateOfBirth = value!;
              },
              onTap: () async {
              final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            
              if (picked != null) {
                _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
              }
              },
        ),
            ),
              
          //Email input field
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _emailTextController,
                decoration: const InputDecoration(
                hintText: emailHintText,
                prefixIcon: Icon(UniconsLine.fast_mail_alt)
                ),
              
              
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your student email';
                }
                // Validate email using regular expression
                // bool emailValid = RegExp(r'^.*@ashesi\.edu\.gh$').hasMatch(value);
                // if (!emailValid) {
                //   return 'Please enter a valid email';
                // }
                // return null;
              },
              onSaved: (value){
                _studentEmail = value!;
              }
              ),
              
              ),

            // Year Group Field
            Padding(
              padding:EdgeInsets.all(4.0),
              child:TextFormField(
                controller: _yearGroupController,
                decoration:const InputDecoration(
                  hintText: yearGroupHintText,
                  prefixIcon: Icon(UniconsLine.graduation_cap)
                  ),
              onSaved: (value){
                _studentYearGroup = value!;
              }
              )
            ),

            //Residence drop down 
            Padding(
              padding: EdgeInsets.all(4.0),
              child:DropdownButtonFormField(
                items: _residenceOptions.map((item) {
                return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
              decoration:const InputDecoration(
                filled:true,
                fillColor: Colors.purple
              ),
              onSaved: (value){
                _studentResidence = value!;
              },

            value: _selectedResidence,
            hint:const Text('Residential Status'),
            onChanged: (value){
              setState((){
                _selectedResidence = value;
                _dropDownColor = Colors.green;
                
              }
              );
            },
            ),
            ),

          // Major drop down 
          Padding(
            padding:EdgeInsets.all(4.0),
             child: DropdownButtonFormField(
              items: _majorOptions.map((item) {
                return DropdownMenuItem(
                value: item,
                child: Text(item),
             );}).toList(),
             hint: const Text('Select your major'),
             decoration:const InputDecoration(
              filled:true,
              fillColor: Colors.purple,
             ),
             onSaved: (value){
              _studentMajor = value!;
             },
             value: _selectedMajor,
             onChanged: (value){

              setState((){
                _selectedMajor = value;
                _dropDownColor = Colors.green;
                
              }
              );
            },
             ),
             ),


            // Favourite Food Field
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _favFoodTextController,
                decoration: const InputDecoration(
                hintText: foodHintText,
                prefixIcon: Icon(UniconsLine.crockery)
                ),
                onSaved:(value){
                  _studentFood = value!;
                }
              )
              ),

              // Favourite movie field
              Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _favMovieTextController,
                decoration: const InputDecoration(
                hintText: movieHintText,
                prefixIcon: Icon(UniconsLine.film)
                ),
                onSaved: (value){
                  _studentMovie = value!;
                }
              )
              ),

              




              

            Padding(
              padding: EdgeInsets.only( bottom : 5.0),
              child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states){
                    return states.contains(MaterialState.disabled)
                    ? null : Colors.white;
                  }
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states){
                    return states.contains(MaterialState.disabled)
                    ? null : Colors.purple;
                  }
                ),
              ),
              onPressed: () {
                if (_signUpInfo.currentState!.validate()) {
                  _signUpInfo.currentState!.save();
                  _submitForm();
                  _showWelcomeScreen();
                  // print('Student name is $_studentName');
                  // print('Student ID is $_studentID');
                  // print('Student major is $_studentMajor');
                  // print('Student residence is $_studentResidence');
                  // print('Student email is $_studentEmail');
                  // print('Student food is $_studentFood');
                  // print('Student movie is $_studentMovie');
                  // print('Student date of birth is $_studentDateOfBirth');
                  // print('Student year group is $_studentYearGroup');



                  

                }
              },

              child: const Text('Create Beam Pass'),
              ) 
              )
             //Test 8.0 value here
        ],
      ),
    );
  }

}