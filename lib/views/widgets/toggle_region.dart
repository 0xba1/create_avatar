import 'package:create_avatar/controllers/avatar_provider.dart';
import 'package:create_avatar/views/widgets/toggler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleRegion extends StatelessWidget {
  const ToggleRegion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AvatarProvider avatarProvider = Provider.of<AvatarProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextField(
        //   decoration:
        //       InputDecoration(
        //         border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10),), ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: avatarProvider.controller,
            onChanged: (_) {
              avatarProvider.notify();
            },
            style: const TextStyle(color: Colors.green),
            decoration: const InputDecoration(
              labelText: 'Seed Phrase',
              labelStyle: TextStyle(color: Colors.green),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButton(
                label: 'Skin Color',
                onPressed: avatarProvider.toggleSkinColorIndex),
            ToggleButton(
                label: 'Eyes', onPressed: avatarProvider.toggleEyesIndex),
            ToggleButton(
                label: 'Eyebrows',
                onPressed: avatarProvider.toggleEyebrowsIndex),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButton(
                label: 'Mouth', onPressed: avatarProvider.toggleMouthIndex),
            ToggleButton(
                label: 'Mouth Color',
                onPressed: avatarProvider.toggleMouthColorIndex),
            ToggleButton(
                label: 'Hair Color',
                onPressed: avatarProvider.toggleHairColorIndex),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButton(
                label: 'Accessories',
                onPressed: avatarProvider.toggleAccessoriesIndex),
            ToggleButton(
                label: 'Accessories Color',
                onPressed: avatarProvider.toggleAccessoriesColorIndex),
            ToggleButton(
                label: 'Hair', onPressed: avatarProvider.toggleHairIndex),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButton(
                label: 'Glasses', onPressed: avatarProvider.toggleGlassesIndex),
            ToggleButton(
                label: 'Glasses Color',
                onPressed: avatarProvider.toggleGlassesColorIndex),
            ToggleButton(
                label: 'Beard', onPressed: avatarProvider.toggleBeardIndex),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButton(
                label: 'Hat', onPressed: avatarProvider.toggleHatIndex),
            ToggleButton(
                label: 'Hat Color',
                onPressed: avatarProvider.toggleHatColorIndex),
            ToggleButton(
                label: 'Clothing',
                onPressed: avatarProvider.toggleClothingIndex),
            ToggleButton(
                label: 'Clothing Color',
                onPressed: avatarProvider.toggleClothesColorIndex),
          ],
        ),
      ],
    );
  }
}
