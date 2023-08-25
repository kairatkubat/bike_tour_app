import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udemythree/widgets/image_picker_widget.dart';

final firebase = FirebaseAuth.instance;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _form = GlobalKey<FormState>();
  var _isLogged = true;
  var _enteredUserName = '';
  var _enteredUserLastName;
  var _enteredLogin = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticated = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !isValid && _selectedImage == null) {
      //show error message
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticated = true;
      });
      if (_isLogged) {
        //login user
        final userCridentials = await firebase.signInWithEmailAndPassword(
            email: _enteredLogin, password: _enteredPassword);
      } else {
        //create users

        final userCridentials = await firebase.createUserWithEmailAndPassword(
            email: _enteredLogin, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCridentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCridentials.user!.uid)
            .set({
          'username': _enteredUserName,
          'userlastname': _enteredUserLastName,
          'email': _enteredLogin,
          'password': _enteredPassword,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentification failed')));
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if(_isLogged)
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            width: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/1.png',
                )),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      if (!_isLogged)
                        UserImagePicker(
                          onPickImage: ((pickedImage) {
                            _selectedImage = pickedImage;
                          }),
                        ),
                        if(!_isLogged)
                       Column(
                        children: [
                           TextFormField( decoration: const InputDecoration(
                          labelText: 'name',
                        ),
                        enableSuggestions: false ,
                          validator:(value) {
                            if(value == null || value.isEmpty|| value.trim().length<=5){
                              return 'Please enter valid user name';  
                            }
                            
                            return null;
                          },
                          onSaved: (value) {
                            _enteredUserName = value!;
                          } ,
                        ),
                        TextFormField( decoration: const InputDecoration(
                          labelText: 'last name',
                        ),
                        enableSuggestions: false ,
                          validator:(value) {
                            if(value == null || value.isEmpty|| value.trim().length<=5){
                              return 'Please enter valid user name';  
                            }
                            
                            return null;
                          },
                          onSaved: (value) {
                            _enteredUserLastName = value!;
                          } ,
                        ),
                        ],
                       ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'email adress',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email adress';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredLogin = value!;
                        },
                        textCapitalization: TextCapitalization.none,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'password',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 6) {
                            return 'Please enter mo re then 6 character';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (_isAuthenticated) const CircularProgressIndicator(),
                      if (!_isAuthenticated)
                        ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Text(!_isLogged ? 'SignUp' : 'Login')),
                      if (!_isAuthenticated)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogged = !_isLogged;
                            });
                          },
                          child: Text(_isLogged
                              ? 'Create an accout'
                              : 'I have an account'),
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
