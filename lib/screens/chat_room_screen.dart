import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:models/models.dart';
import 'package:verbly/core/constants/app_colors.dart';
import 'package:verbly/core/constants/app_constants.dart';
import 'package:verbly/core/widgets/circle_avatar_widget.dart';
import 'package:verbly/core/widgets/message_bubble.dart';
import 'package:verbly/main.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    super.key,
    required this.chatRoom,
  });

  final ChatRoom chatRoom;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();

  List<Message> messages = [];

  @override
  void initState() {
    _loadMessages();
    _startWebSocket();

    messageRepository.subscribeToMessageUpdates((messageData) {
      final message = Message.fromJson(messageData);

      if (message.chatRoomId == widget.chatRoom.id) {
        messages.add(message);
        messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        setState(() {});
      }
    });
    super.initState();
  }

  _startWebSocket() {
    webSocketClient.connect(
      "ws://localhost:8080/ws",
      {
        "Authorization": "Bearer ...",
      },
    );
  }

  _sendMessage() async {
    final message = Message(
      chatRoomId: widget.chatRoom.id,
      senderUserId: userId1,
      receiverUserId: userId2,
      content: messageController.text.trim(),
      createdAt: DateTime.now(),
    );

    // setState(() {
    //   messages.add(message);
    // });

    await messageRepository.createMessage(message);
    messageController.clear();
  }

  _loadMessages() async {
    final messagesList =
        await messageRepository.fetchMessages(widget.chatRoom.id);

    messagesList.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    setState(() {
      messages.addAll(messagesList);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = AppConstants.isDarkMode(context: context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final currentParticipant = widget.chatRoom.participants.firstWhere(
      (user) => user.id == userId1,
    );
    final otherParticipant = widget.chatRoom.participants.firstWhere(
      (user) => user.id != currentParticipant.id,
    );
    return GestureDetector(
      onTap: () {
        AppConstants.hideKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 65.h,
          title: Column(
            children: [
              CircleAvatarWidget(
                imageUrl: otherParticipant.avatarUrl,
                radius: 20.r,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                otherParticipant.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 14.sp,
                    ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
            SizedBox(
              width: 15.w,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 10.h,
              bottom: viewInsets.bottom > 0 ? 10.h : 0.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final showImage = index + 1 == messages.length ||
                          messages[index].senderUserId != message.senderUserId;

                      return Row(
                        mainAxisAlignment: (message.senderUserId != userId1)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (showImage && message.senderUserId == userId1)
                            CircleAvatarWidget(
                              imageUrl: otherParticipant.avatarUrl,
                              radius: 15.r,
                            ),
                          MessageBubble(
                            message: message,
                          ),
                          if (showImage && message.senderUserId != userId1)
                            CircleAvatarWidget(
                              imageUrl: otherParticipant.avatarUrl,
                              radius: 15.r,
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: isDarkMode
                              ? AppColors.darkerGrey
                              : AppColors.primaryColor.withOpacity(0.1),
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _sendMessage,
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
