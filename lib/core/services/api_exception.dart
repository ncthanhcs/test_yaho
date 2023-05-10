// import 'dart:io';
// enum SocketError {
//   errrorSocket,
// }

// enum HttpStatus {
//   pageNotFound,
//   unknown,
// }

// enum InternalStatus { errorInternal, unknown }

// extension HttpStatusEx on HttpStatus {
//   static HttpStatus fromValue(value) {
//     for (var item in HttpStatus.values) {
//       if (item.code.toString().toUpperCase() ==
//           value.toString().toUpperCase()) {
//         return item;
//       }
//     }
//     return HttpStatus.unknown;
//   }

//   int get code {
//     switch (this) {
//       case HttpStatus.pageNotFound:
//         return 404;
//       case HttpStatus.unknown:
//         return -1;
//     }
//   }
// }

// extension InternalStatusEx on InternalStatus {
//   static InternalStatus fromValue(value) {
//     for (var item in InternalStatus.values) {
//       if (item.code.toString().toUpperCase() ==
//           value.toString().toUpperCase()) {
//         return item;
//       }
//     }
//     return InternalStatus.unknown;
//   }

//   int get code {
//     switch (this) {
//       case InternalStatus.errorInternal:
//         return 01;
//       case InternalStatus.unknown:
//         return -1;
//     }
//   }
// }
