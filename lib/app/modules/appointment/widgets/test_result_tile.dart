// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class TestResultTile extends StatelessWidget {
//   final _isExpanded = false.obs;
//   TestResultTile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10.sp),
//       child: Column(children: [
//         ListTile(
//           title: Text('\$${widget.order.amount}'),
//           subtitle: Text(
//             DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
//           ),
//           trailing: ObxValue(
//               (data) => IconButton(
//                     icon: _isExpanded.value ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),
//                     onPressed: () => _isExpanded.value = !_isExpanded.value,
//                   ),
//               _isExpanded),
//         ),
//         Visibility(
//           visible: _isExpanded.value,
//           child: Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 15,
//               vertical: 4,
//             ),
//             height: min(widget.order.products.length * 20.0 + 10, 180),
//             child: ListView(
//                 children: widget.order.products
//                     .map((prod) => Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               prod.title,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '${prod.quantity}x \$${prod.price}',
//                               style: const TextStyle(fontSize: 18, color: Colors.grey),
//                             ),
//                           ],
//                         ))
//                     .toList()),
//           ),
//         )
//       ]),
//     );
//   }
// }
