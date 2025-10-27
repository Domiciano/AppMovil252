import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviles252/features/auth/ui/bloc/logout_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProfilePageState();
  }
}

class MyProfilePageState extends State<MyProfilePage> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Image.network(
            "https://unpocoloco.com.co/cdn/shop/files/RICK-AND-MORTY.jpg?v=1725400047",
          ),
          onTap: () {
            _pickImage();
          },
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    var xfile = await picker.pickImage(source: ImageSource.gallery);

    if (xfile == null) {
      return;
    }
    var file = File(xfile.path);
    var uuid = Uuid();
    var filename = uuid.v4(); //UUID

    //Subir foto
    await Supabase.instance.client.storage.from("gamma").upload(filename, file);

    //Actualzar el profile
    String? id = Supabase.instance.client.auth.currentUser?.id;

    //Cargar la foto basado en el profile
  }
}
