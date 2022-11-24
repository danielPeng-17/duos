import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:duos_ui/providers/providers.dart';
import 'package:duos_ui/screens/profile_creation_name.dart';

class ProfileCreationPicture extends StatefulWidget {
  const ProfileCreationPicture({Key? key}) : super(key: key);

  @override
  State<ProfileCreationPicture> createState() => _ProfileCreationPictureState();
}

class _ProfileCreationPictureState extends State<ProfileCreationPicture> {
  PlatformFile? pickedFile;
  FilePickerResult? result;

  String imageURL = "";

  Future<void> selectPhoto() async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result == null) {
      return;
    }

    setState(() {
      pickedFile = result?.files.first;
    });
  }

  Future<String> uploadPhoto() async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    if (result != null) {
      final path = result?.files.single.path!;
      final fileName = result?.files.single.name;
      final file = File(path!);
      final uploadTask = storage.ref('images/$fileName').putFile(file);
      var downloadURL = await (await uploadTask).ref.getDownloadURL();
      imageURL = downloadURL.toString();
    }

    return "";
  }

  void uploadAllPhotos() async {
    imageURL = await uploadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: Text.rich(
              //     TextSpan(
              //       children: <InlineSpan>[
              //         WidgetSpan(
              //           child: Icon(
              //             Icons.create_sharp,
              //             color: Colors.black,
              //             size: 25,
              //           ),
              //         ),
              //         TextSpan(text: ' Profile Creation'),
              //       ],
              //     ),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              const Center(
                child: Text(
                  "Add photos",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: pickedFile != null
                        ? Image.file(
                            File(pickedFile!.path!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/no_image.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: selectPhoto,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurpleAccent[200],
                      minimumSize: const Size(250, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: const Text(
                      'Select Photo',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black.withOpacity(0),
                      backgroundColor: Colors.black.withOpacity(0),
                      elevation: 20, // Elevation
                      shadowColor: Colors.black.withOpacity(0), // Shadow Color
                    ),
                    icon: Image.asset("assets/images/profile_creation_next.png",
                        width: 100, height: 100),
                    label: const Text(""),
                    onPressed: () async {
                      await uploadPhoto();
                      if (!mounted) return;
                      if (imageURL != "") {
                        context
                            .read<ProfileProvider>()
                            .setProfilePicURL(imageURL);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfileCreationName()));
                      } else if (imageURL == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No photo selected'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
