import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviles252/domain/model/profile.dart';
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
  void initState() {
    super.initState();
    loadProfile();
  }

  String photoUrl =
      "https://unpocoloco.com.co/cdn/shop/files/RICK-AND-MORTY.jpg?v=1725400047";

  Future<void> loadProfile() async {
    var response = await Supabase.instance.client
        .from("profiles")
        .select()
        .eq("id", Supabase.instance.client.auth.currentUser!.id)
        .single();
    var profile = Profile.fromJson(response);
    setState(() {
      photoUrl =
          profile.photoUrl ??
          "https://unpocoloco.com.co/cdn/shop/files/RICK-AND-MORTY.jpg?v=1725400047";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Image.network(photoUrl),
          onTap: () {
            _pickImage(ImageSource.camera);
          },
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    var xfile = await picker.pickImage(source: source);

    if (xfile == null) {
      return;
    }
    var file = File(xfile.path);
    var uuid = Uuid();
    var filename = uuid.v4(); //UUID

    //Subir foto
    await Supabase.instance.client.storage.from("gamma").upload(filename, file);

    final publicUrl = Supabase.instance.client.storage
        .from('gamma')
        .getPublicUrl(filename);

    //Actualzar el profile
    String? id = Supabase.instance.client.auth.currentUser?.id;
    await Supabase.instance.client
        .from("profiles")
        .update({"photo_url": publicUrl})
        .eq("id", id!);
    //https://yzosfzyewkdpnmlbgbej.supabase.co/storage/v1/object/public/gamma/60fd8c14-8702-4021-b469-25a511a11535
    //Cargar la foto basado en el profile
    setState(() {
      photoUrl = publicUrl;
    });
  }
}
