import 'package:dart_frog/dart_frog.dart';
import 'package:verbly_server/src/repositories/message_repository.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<MessageRepository>((_) => messageRepository),
      );
}
