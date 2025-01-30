import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _receiveNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Pop-up Notifications'),
              value: _receiveNotifications,
              onChanged: (bool value) {
                setState(() {
                  _receiveNotifications = value;
                });
              },
            ),
            Divider(),
            SwitchListTile(
              title: Text('Notification Sound'),
              value: _soundEnabled,
              onChanged: (bool value) {
                setState(() {
                  _soundEnabled = value;
                });
              },
            ),
            Divider(),
            SwitchListTile(
              title: Text('Vibration'),
              value: _vibrationEnabled,
              onChanged: (bool value) {
                setState(() {
                  _vibrationEnabled = value;
                });
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}