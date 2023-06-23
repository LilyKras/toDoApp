import 'package:logger/logger.dart';

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

void log(String level, message) {
  if (level == 'info') {
    _logger.i(message);
  }
  if (level == 'warning') {
    _logger.w(message);
  }
}
