import 'package:flutter/material.dart';

// TODO(Melly): move to independent feature
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$runtimeType'),
      ),
    );
  }
}
