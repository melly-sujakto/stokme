import 'package:flutter/material.dart';

// TODO(Melly): move to independent feature
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$runtimeType'),
      ),
    );
  }
}
