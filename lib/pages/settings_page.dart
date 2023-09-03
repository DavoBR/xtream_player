import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(this.settings, {super.key});

  final Settings settings;

  static MaterialPageRoute route(Settings settings) {
    return MaterialPageRoute(
      builder: (_) => SettingsPage(settings),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final _serverUrlCtrl = TextEditingController.fromValue(
    TextEditingValue(text: widget.settings.serverUrl),
  );
  late final _usernameCtrl = TextEditingController.fromValue(
    TextEditingValue(text: widget.settings.username),
  );
  late final _passwordCtrl = TextEditingController.fromValue(
    TextEditingValue(text: widget.settings.password),
  );

  @override
  void dispose() {
    _serverUrlCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _serverUrlCtrl,
                  decoration: const InputDecoration(labelText: 'Server URL'),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (Uri.tryParse(value) == null) {
                      return 'The url has invalid format';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      if (!Form.of(context).validate()) return;

                      ref
                          .read(settingsProvider.notifier)
                          .updateSettings(Settings(
                            serverUrl: _serverUrlCtrl.text,
                            username: _usernameCtrl.text,
                            password: _passwordCtrl.text,
                          ));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se ha guardado la configuración'),
                        ),
                      );

                      Navigator.of(context).pop();
                    },
                    child: const Text('Guardar'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
