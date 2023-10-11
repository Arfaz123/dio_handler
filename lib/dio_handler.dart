/// This is the main library for the Dio Handler package.
library dio_handler;

// Import necessary Dart libraries
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Export Flutter's 'material' package for user convenience
export 'package:flutter/material.dart';

// Import the other parts of the DioHandler package
part 'src/network_connectivity.dart';
part 'src/custom_dialog.dart';
part 'src/network_call.dart';

