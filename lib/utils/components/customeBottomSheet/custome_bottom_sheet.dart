import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class AddMealBottomSheet extends StatefulWidget {
  final List<String> mealTypes;
  final List<String> quantities;
  final int initialServings;
  final Function(String) onMealTypeSelected;
  final Function(String) onQuantitySelected;
  final Function(int) onServingsChanged;
  final Function() onTap;

  // Optional selected values
  final String? selectedMealType;
  final String? selectedQuantity;
  final int? selectedServings;

  const AddMealBottomSheet({
    Key? key,
    required this.mealTypes,
    required this.quantities,
    required this.initialServings,
    required this.onMealTypeSelected,
    required this.onQuantitySelected,
    required this.onServingsChanged,
    required this.onTap,
    this.selectedMealType,
    this.selectedQuantity,
    this.selectedServings,
  }) : super(key: key);

  @override
  _AddMealBottomSheetState createState() => _AddMealBottomSheetState();
}

class _AddMealBottomSheetState extends State<AddMealBottomSheet> {
  late String _selectedMealType;
  late String _selectedQuantity;
  late int _numberOfServings;

  @override
  void initState() {
    super.initState();
    _selectedMealType = widget.selectedMealType ?? '';
    _selectedQuantity = widget.selectedQuantity ?? '';
    _numberOfServings = widget.selectedServings ?? widget.initialServings;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Type Selection
          MyManropeText(
            text: 'Meal Type:',
            color: AppColor.primaryColor2,
            fontWeight: FontWeight.w700,
            fontSize: AppSizer.fontSize14,
          ),

          SizedBox(height: height * 0.02),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.mealTypes.map((meal) {
              bool isSelected = _selectedMealType == meal;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMealType = meal;
                  });
                  widget.onMealTypeSelected(meal);
                },
                child: CommonTagWidget(
                  text: meal,
                  isSelected: isSelected,
                ),
              );
            }).toList(),
          ),

          SizedBox(height: height * 0.02),

          // Quantity Selection
          MyManropeText(
            text: 'Add Qty:',
            color: AppColor.primaryColor2,
            fontWeight: FontWeight.w700,
            fontSize: AppSizer.fontSize14,
          ),

          SizedBox(height: height * 0.02),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.quantities.map((quantity) {
              bool isSelected = _selectedQuantity == quantity;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedQuantity = quantity;
                  });
                  widget.onQuantitySelected(quantity);
                },
                child: CommonTagWidget(
                  text: quantity,
                  isSelected: isSelected,
                ),
              );
            }).toList(),
          ),

          SizedBox(height: height * 0.02),

          // Servings Selection
          Row(
            children: [
              MyManropeText(
                text: 'Servings:',
                color: AppColor.primaryColor2,
                fontWeight: FontWeight.w700,
                fontSize: AppSizer.fontSize14,
              ),
              SizedBox(width: width * 0.025),
              Row(
                children: [
                  // Decrease Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_numberOfServings > 1) {
                          _numberOfServings--;
                          widget.onServingsChanged(_numberOfServings);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Icon(Icons.remove, size: width * 0.06),
                    ),
                  ),
                  // Quantity Text
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                    alignment: Alignment.center,
                    child: MyManropeText(
                      text: _numberOfServings.toString(),
                    ),
                  ),
                  // Increase Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _numberOfServings++;
                        widget.onServingsChanged(_numberOfServings);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Icon(Icons.add, size: width * 0.06),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: height * 0.02),

          // Add Meal Button
          Center(
            child: CustomeButton(
              text: 'Add Meal',
              onPressed: widget.onTap,
              horizontalPadding: width * 0.35,
            ),
          ),
        ],
      ),
    );
  }
}

// class AddMealBottomSheet extends StatefulWidget {
//   final List<String> mealTypes;
//   final List<String> quantities;
//   final int initialServings;
//   final Function(String) onMealTypeSelected;
//   final Function(String) onQuantitySelected;
//   final Function(int) onServingsChanged;
//   final Function() onTap; // Added onTap callback
//
//   const AddMealBottomSheet(
//       {Key? key,
//       required this.mealTypes,
//       required this.quantities,
//       required this.initialServings,
//       required this.onMealTypeSelected,
//       required this.onQuantitySelected,
//       required this.onServingsChanged,
//       required this.onTap})
//       : super(key: key);
//
//   @override
//   _AddMealBottomSheetState createState() => _AddMealBottomSheetState();
// }
//
// class _AddMealBottomSheetState extends State<AddMealBottomSheet> {
//   String _selectedMealType = '';
//   String _selectedQuantity = '';
//   int _numberOfServings = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     _numberOfServings = widget.initialServings;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Meal Type Selection
//           MyManropeText(
//             text: 'Meal Type:',
//             color: AppColor.primaryColor2,
//             fontWeight: FontWeight.w700,
//             fontSize: AppSizer.fontSize14,
//           ),
//
//           SizedBox(height: height * 0.02),
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: widget.mealTypes.map((meal) {
//               bool isSelected = _selectedMealType == meal;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedMealType = meal;
//                   });
//                   widget.onMealTypeSelected(meal);
//                 },
//                 child: CommonTagWidget(
//                   text: meal,
//                   isSelected: isSelected,
//                 ),
//               );
//             }).toList(),
//           ),
//
//           SizedBox(height: height * 0.02),
//
//           // Quantity Selection
//           MyManropeText(
//             text: 'Add Qty:',
//             color: AppColor.primaryColor2,
//             fontWeight: FontWeight.w700,
//             fontSize: AppSizer.fontSize14,
//           ),
//
//           SizedBox(height: height * 0.02),
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: widget.quantities.map((quantity) {
//               bool isSelected = _selectedQuantity == quantity;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedQuantity = quantity;
//                   });
//                   widget.onQuantitySelected(quantity);
//                 },
//                 child: CommonTagWidget(
//                   text: quantity,
//                   isSelected: isSelected,
//                 ),
//               );
//             }).toList(),
//           ),
//
//           SizedBox(height: height * 0.02),
//
//           // Servings Selection
//           Row(
//             children: [
//               MyManropeText(
//                 text: 'Servings:',
//                 color: AppColor.primaryColor2,
//                 fontWeight: FontWeight.w700,
//                 fontSize: AppSizer.fontSize14,
//               ),
//               SizedBox(width: width * 0.025),
//               Row(
//                 children: [
//                   // Decrease Button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (_numberOfServings > 1) {
//                           _numberOfServings--;
//                           widget.onServingsChanged(_numberOfServings);
//                         }
//                       });
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                       child: Icon(Icons.remove, size: width * 0.06),
//                     ),
//                   ),
//                   // Quantity Text
//                   Container(
//                       margin: EdgeInsets.symmetric(horizontal: width * 0.03),
//                       alignment: Alignment.center,
//                       child: MyManropeText(
//                         text: _numberOfServings.toString(),
//                       )),
//                   // Increase Button
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _numberOfServings++;
//                         widget.onServingsChanged(_numberOfServings);
//                       });
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                       child: Icon(Icons.add, size: width * 0.06),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           SizedBox(height: height * 0.02),
//
//           // Add Meal Button
//           Center(
//               child: CustomeButton(
//             text: 'Add meal',
//             onPressed: widget.onTap,
//             horizontalPadding: width * 0.35,
//           ))
//           // Center(
//           //   child: ElevatedButton(
//           //     onPressed: () {
//           //       Navigator.pop(context);
//           //     },
//           //     child: Text("Add Meal"),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

class CommonTagWidget extends StatelessWidget {
  final bool? isSelected;
  final String text;

  const CommonTagWidget({
    super.key,
    this.isSelected = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor1, width: 1.0),
        color: isSelected! ? AppColor.primaryColor1 : Colors.white,
        borderRadius: BorderRadius.circular(width * 0.1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: width * 0.012,
      ),
      margin: EdgeInsets.only(
        right: width * 0.02,
        bottom: width * 0.02,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyManropeText(
            text: text,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w600,
            color: isSelected! ? Colors.white : AppColor.primaryColor1,
          ),
        ],
      ),
    );
  }
}
