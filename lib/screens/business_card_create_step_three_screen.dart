// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widgets/bottom_bar_widget.dart';
import '../features/qr_code/data/models/qr_code_model.dart';
import '../widgets/business_card/color_picker_dialog.dart';

class BusinessCardCreateStepThreeScreen extends StatefulWidget {
  const BusinessCardCreateStepThreeScreen({super.key});

  @override
  State<BusinessCardCreateStepThreeScreen> createState() =>
      _BusinessCardCreateStepThreeScreenState();
}

class _BusinessCardCreateStepThreeScreenState
    extends State<BusinessCardCreateStepThreeScreen> {
  late final QrCodeModel cardQrCodeStepOne;
  late final BoxDecoration boxDecorationStepTwo;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    cardQrCodeStepOne = QrCodeModel.fromJson(arguments['cardQrCodeStepOne']);
    boxDecorationStepTwo = arguments['boxDecoration'];
    print('id qr');
    print(cardQrCodeStepOne.id);
    print('boxdecoration');
    print(boxDecorationStepTwo);
  }

  bool isGradient = false;
  Color color1 = Colors.blue;
  Color color2 = Colors.red;
  String selectedDirection = 'leftToRight';

  final Map<String, Alignment> _beginAlignments = {
    'leftToRight': Alignment.centerLeft,
    'rightToLeft': Alignment.centerRight,
    'topToBottom': Alignment.topCenter,
    'bottomToTop': Alignment.bottomCenter,
    'centerOut': Alignment.center,
  };

  final Map<String, Alignment> _endAlignments = {
    'leftToRight': Alignment.centerRight,
    'rightToLeft': Alignment.centerLeft,
    'topToBottom': Alignment.bottomCenter,
    'bottomToTop': Alignment.topCenter,
    'centerOut': Alignment.center,
  };

  void _submit() {
    BoxDecoration decoration;

    if (isGradient && selectedDirection == 'centerOut') {
      decoration = BoxDecoration(
        gradient: RadialGradient(
          colors: [color1, color2],
          center: Alignment.center,
          radius: 1.0,
        ),
      );
    } else if (isGradient) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: _beginAlignments[selectedDirection]!,
          end: _endAlignments[selectedDirection]!,
        ),
      );
    } else {
      decoration = BoxDecoration(color: color1);
    }

    Navigator.pop(context, decoration);
  }

  Widget _buildFullWidthPreview(BoxDecoration decoration) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: decoration.copyWith(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final solidDecoration = BoxDecoration(color: color1);
    final gradientDecoration = selectedDirection == 'centerOut'
        ? BoxDecoration(
            gradient: RadialGradient(
              colors: [color1, color2],
              center: Alignment.center,
              radius: 1.0,
            ),
          )
        : BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: _beginAlignments[selectedDirection]!,
              end: _endAlignments[selectedDirection]!,
            ),
          );

    return Scaffold(
      appBar: AppBar(title: Text('3. Introducir texto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Usar degradado'),
              value: isGradient,
              onChanged: (value) => setState(() => isGradient = value),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Color 1'),
                      SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () async {
                          final selected = await showDialog<Color>(
                            context: context,
                            builder: (_) => ColorPickerDialog(
                              currentColor: color1,
                              onColorSelected: (color) {
                                setState(() {
                                  color1 = color;
                                  Get.back();
                                });
                              },
                            ),
                          );
                          if (selected != null) {
                            setState(() => color1 = selected);
                          }
                        },
                        child: Text('Seleccionar'),
                      ),
                    ],
                  ),
                ),
                if (isGradient)
                  Expanded(
                    child: Column(
                      children: [
                        Text('Color 2'),
                        SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () async {
                            final selected = await showDialog<Color>(
                              context: context,
                              builder: (_) => ColorPickerDialog(
                                currentColor: color2,
                                onColorSelected: (color) {
                                  setState(() {
                                    color2 = color;
                                    Get.back();
                                  });
                                },
                              ),
                            );
                            if (selected != null) {
                              setState(() => color2 = selected);
                            }
                          },
                          child: Text('Seleccionar'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (isGradient) ...[
              SizedBox(height: 20),
              Text('Dirección del degradado'),
              Spacer(),
              Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                children: _beginAlignments.keys.map((dir) {
                  return ChoiceChip(
                    label: Text(dir),
                    selected: selectedDirection == dir,
                    padding: EdgeInsets.all(0),
                    onSelected: (_) => setState(() => selectedDirection = dir),
                  );
                }).toList(),
              ),
              Spacer(),
              _buildFullWidthPreview(gradientDecoration),
            ],
            if (!isGradient)
              Expanded(
                child: Column(
                  children: [
                    Spacer(),
                    _buildFullWidthPreview(solidDecoration),
                  ],
                ),
              ),
            Spacer(),
          ],
        ),
      ),
      // BottomNavigationBar con el botón de siguiente
      bottomNavigationBar: Visibility(
        child: BottomBarWidget(
          labelBtn: 'Checar',
          function: _submit,
        ),
      ),
    );
  }
}
