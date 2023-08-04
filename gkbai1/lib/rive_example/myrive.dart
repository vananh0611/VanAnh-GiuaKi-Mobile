import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MyRive extends StatefulWidget {
  const MyRive({super.key});

  @override
  State<MyRive> createState() => _MyRiveState();
}

class _MyRiveState extends State<MyRive> {
  Artboard? riveArtboard;
  SMITrigger? hit;
  SMINumber? numSkins;

  @override
  void initState() {
    super.initState();
    rootBundle.load('rive/images/viking.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          hit = controller.findSMI('Hit');
          numSkins = controller.findSMI('numSkins');
        }
        setState(() => riveArtboard = artboard);
      },
    );
  }

  void toggleDance(bool newValue) {
    setState(() => hit!.value = newValue);
  }

  @override
  Widget build(BuildContext context) {
    const List<int> skin = [0, 1, 2];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation di flutter'),
        centerTitle: true,
      ),
      body: riveArtboard == null
          ? const SizedBox()
          : Column(
              children: [
                SizedBox(
                  height: 350,
                  child: Rive(
                    artboard: riveArtboard!,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => hit!.value = true,
                    child: const Text('Attack')),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Skin versi ke ${numSkins!.value.toInt()}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ganti Skin:'),
                    DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          numSkins!.change(value!.toDouble());
                        });
                      },
                      items: skin
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
