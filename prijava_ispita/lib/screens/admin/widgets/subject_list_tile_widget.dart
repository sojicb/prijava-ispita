import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/subject.dart';

class SubjectListTileWidget extends StatelessWidget{
  final Subject? subject;
  final bool? isSelected;
  final ValueChanged<Subject>? onSelectedSubject;

  const SubjectListTileWidget({
    Key? key,
    @required this.subject,
    @required this.isSelected,
    @required this.onSelectedSubject
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected!
        ? TextStyle(
          fontSize: 18,
          color: selectedColor,
          fontWeight: FontWeight.bold
    ) : const TextStyle(fontSize: 18);
    return ListTile(
      onTap: () => onSelectedSubject!(subject!),
      title: Text(
        subject!.title,
        style: style,
      ),
      trailing: isSelected! ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}