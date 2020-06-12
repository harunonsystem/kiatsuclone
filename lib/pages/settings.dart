import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
          centerTitle: true,
        ),
        body: Center(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: 'Section',
                tiles: [
                  SettingsTile(
                    title: 'Language',
                    subtitle: 'English',
                    leading: Icon(Icons.language),
                    onTap: () {},
                  ),
                  SettingsTile.switchTile(
                    title: 'Use fingerprint',
                    leading: Icon(Icons.fingerprint),
                    switchValue: true,
                    onToggle: (bool value) {},
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
