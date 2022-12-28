import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './privacyPolicy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final auth = FirebaseAuth.instance;
final firebase = FirebaseFirestore.instance;

Future<void> resetPassword(String email) async {
  await auth.sendPasswordResetEmail(email: email);
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var email = auth.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common', style: TextStyle(color: Color(0xff1d5c94)),),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('Language'),
                value: Text('English'),
                // onpressed -> multi lang
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: false, // switch default value
                title: Text('Enable Notification'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: false, // switch default value
                title: Text('GPS'),
              ),
            ],
          ),

          SettingsSection(
            title: Text('Account', style: TextStyle(color: Color(0xff1d5c94))),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('Log Out'),
              ),
              SettingsTile.navigation(
                title: Text('Change Password'),
                onPressed: (context) {
                  print(email.toString());
                  resetPassword(email.toString());
                },
              ),
            ],
          ),

          SettingsSection(
            title: Text('Privacy', style: TextStyle(color: Color(0xff1d5c94))),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                  title: Text('Privacy Policy'),
                  onPressed: (context) {Navigator.push(context, MaterialPageRoute(builder: (c) => PrivacyPolicy()));}
              ),
              SettingsTile.navigation(
                title: Text('Terms of Use'),
                onPressed: (context) {Navigator.push(context, MaterialPageRoute(builder: (c) => TermsofUse()));},),
            ],
          ),
        ],
      ),
    );
  }
}