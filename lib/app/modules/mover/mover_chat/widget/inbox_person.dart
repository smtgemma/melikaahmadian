import 'package:flutter/material.dart';

class InboxPersonTile extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String? imageUrl;
  final String lastMessage;
  final VoidCallback onTap;

  const InboxPersonTile({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.lastMessage,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage:
        imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? const Icon(Icons.person) : null,
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(role),
    );
  }
}
