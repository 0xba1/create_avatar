import 'package:create_avatar/controllers/avatar_provider.dart';
import 'package:create_avatar/views/widgets/avatar_view.dart';
import 'package:create_avatar/views/widgets/toggle_region.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Avatar: Pixel Art'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: const [
            AvatarView(),
            ToggleRegion(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download_rounded),
        onPressed: () {
          AvatarProvider avatarProvider =
              Provider.of<AvatarProvider>(context, listen: false);
          avatarProvider.download(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
