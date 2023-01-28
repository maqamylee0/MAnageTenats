
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/services/amplify_service.dart';
import 'package:provider/provider.dart';

import '../../providers/tenant_provider.dart';

class Agreement extends StatefulWidget {
  const Agreement({Key? key,required this.tenant}) : super(key: key);
final TenantModel tenant;
  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  var _image;
  File? image;
  AmplifyService amplifyService = AmplifyService();
  String? path;


  @override
  Widget build(BuildContext context) {

    final tenants = Provider.of<TenantsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }
            , icon: Icon(Icons.arrow_back)),

        title: Text("Agreement"),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () async {
          await getImage(ImgSource.Both);
          amplifyService.uploadImage(_image.path,widget.tenant);

        },

      ),
      body: Container(

          child: Column(
            children: [
              (tenants.path == null) ? Container():Expanded(child: Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      blurRadius: 20.0,
                    ),
                  ],
                ),

                // width:  MediaQuery.of(context).size.width*0.7,
                child: Card(

                    child: Row(
                      children: [
                        SizedBox(
                            width: 80,height: 80,
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              child: CachedNetworkImage(
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                imageUrl: '${tenants.path}',
                              )
                              ),
                            ),
                        Center(child: Text("name"),)
                      ],
                    )
                ),
              )
              ),

            _image != null ?  Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      blurRadius: 20.0,
                    ),
                  ],
                ),

                // width:  MediaQuery.of(context).size.width*0.7,
                child: Card(

                  child: Row(
                    children: [
                      SizedBox(
                  width: 80,height: 80,
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Image.file(File(_image.path),
                        ),
                      )),
                    Center(child: Text("name"),)
                    ],
                  )
                ),
              ): Container(
            )
            ],
          ),
        )
//Image.file(File(_image.path))

      );

  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(

        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));

    setState(() {
      _image = image;
    });
  }

}