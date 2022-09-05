// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class Authmethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error might occur';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods().uploadImageToStorage(
            childName: 'childName', file: file, ispost: false);
        //add user to the database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = 'success';
      }
    }
    on FirebaseAuthException catch (err) {
      if (err.code == 'Invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'sucess';
      } else {
        res = 'please enter all the fields';
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not found') {
        res = 'kindly input the correct parameters';
      } else if (e.code == 'wrong password') {
        res = 'Input the right password';
      }
    }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
