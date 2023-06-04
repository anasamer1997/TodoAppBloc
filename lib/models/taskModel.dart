import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavourite;

  Task({
    required this.date,
    required this.id,
    required this.description,
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavourite = false,
  });

  Task copyWith({
    String? title,
    String? description,
    String? date,
    String? id,
    bool? isDone,
    bool? isDeleted,
    bool? isFavourite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavourite: isFavourite ?? this.isFavourite,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'date': date,
      'isFavourite': isFavourite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'],
      isDeleted: map['isDeleted'] ,
      isFavourite: map['isFavourite'],
      date:map['date'] ?? ''
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, isDone, isDeleted, date, isFavourite];
}
