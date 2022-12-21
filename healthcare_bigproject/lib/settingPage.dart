import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './privacyPolicy.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
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
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('Log Out'),
              ),
              SettingsTile.navigation(
                title: Text('Change Password'),
              ),
            ],
          ),

          SettingsSection(
            title: Text('Privacy'),
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