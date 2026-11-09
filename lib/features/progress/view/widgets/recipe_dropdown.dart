// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:flutter/material.dart';

// class RecipeQuantityDropDown extends StatefulWidget {
//   final List<String> items;
//   final String? selectedValue; // Allow null to handle no initial value
//   final ValueChanged<String> onSelected;

//   const RecipeQuantityDropDown({
//     super.key,
//     required this.items,
//     this.selectedValue,
//     required this.onSelected,
//   });

//   @override
//   _RecipeQuantityDropDownState createState() => _RecipeQuantityDropDownState();
// }

// class _RecipeQuantityDropDownState extends State<RecipeQuantityDropDown> {
//   late OverlayEntry _overlayEntry;
//   bool isDropdownOpen = false;
//   late String? selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.selectedValue;
//   }

//   @override
//   void dispose() {
//     if (isDropdownOpen) {
//       _overlayEntry.remove();
//       isDropdownOpen = false;
//     }
//     super.dispose();
//   }

//   void _closeDropdown() {
//     if (isDropdownOpen) {
//       _overlayEntry.remove();
//       isDropdownOpen = false;
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }

//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//     var offset = renderBox.localToGlobal(Offset.zero);

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: offset.dx,
//         top: offset.dy + size.height - AppSizer.height * 0.0024,
//         width: size.width,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             width: AppSizer.width * 0.28,
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8),
//                 ),
//                 border: Border(
//                   bottom: BorderSide(
//                     width: 3,
//                     color: AppColor.cardBackGroundBlueColor,
//                   ),
//                   left: BorderSide(
//                     width: 3,
//                     color: AppColor.cardBackGroundBlueColor,
//                   ),
//                   right: BorderSide(
//                     width: 3,
//                     color: AppColor.cardBackGroundBlueColor,
//                   ),
//                 )),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: widget.items
//                   .map((item) => InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedValue = item;
//                             widget.onSelected(item);
//                           });
//                           _closeDropdown();
//                         },
//                         child: Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.symmetric(vertical: 6.0),
//                           child: Center(
//                             child: MyManropeText(
//                               text: item,
//                               color: const Color(0xFF006193),
//                               fontSize: AppSizer.fontSize12,
//                             ),
//                           ),
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _toggleDropdown() {
//     if (isDropdownOpen) {
//       _closeDropdown();
//     } else {
//       _openDropdown();
//     }
//   }

//   void _openDropdown() {
//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry);
//     setState(() {
//       isDropdownOpen = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isValueSelected = selectedValue != null;

//     return GestureDetector(
//       onTap: _toggleDropdown,
//       child: Container(
//         width: AppSizer.width * 0.28,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//         decoration: BoxDecoration(
//           border: isDropdownOpen
//               ? Border.all(color: AppColor.cardBackGroundBlueColor)
//               : null,
//           borderRadius: isDropdownOpen
//               ? const BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 )
//               : BorderRadius.circular(8.0),
//           color: isValueSelected
//               ? AppColor
//                   .primaryColor1 // Change this to the desired color for selected
//               : AppColor.cardBackGroundBlueColor,
//         ),
//         child: Center(
//           child: MyManropeText(
//             text: isValueSelected
//                 ? "${selectedValue!.replaceAll(" ", "")} Added"
//                 : "Add to Meal",
//             color: isValueSelected
//                 ? Colors.white // Adjust text color for better contrast
//                 : AppColor.primaryColor1,
//             fontWeight: FontWeight.w900,
//             fontSize: AppSizer.fontSize12,
//           ),
//         ),
//       ),
//     );
//   }
// }
