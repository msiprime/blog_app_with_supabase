import 'package:logger/logger.dart';

class Log {
  late Logger _logger;
  static const lineLength = 120;

  Log._internal() {
    _logger = Logger(
      printer: PrefixPrinter(
        PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          colors: true,
          lineLength: 120,
          // colors: io.stdout.supportsAnsiEscapes,
          printEmojis: true,
          //dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      ),
    );
  }

  static final Log _singleton = Log._internal();

  static void trace(String message) => _singleton._logger.t(message);

  static void debug(String message) => _singleton._logger.d(message);

  static void info(String message) => _singleton._logger.i(message);

  static void error(String message) => _singleton._logger.e(message);

  static void warning(String message) => _singleton._logger.w(message);
}
