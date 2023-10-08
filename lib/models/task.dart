import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  Task({
    required this.description,
    required this.date,
    required this.title,
    required this.id,
    this.isDone,
    this.isDelete,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
    isFavorite = isFavorite ?? false;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      description: map['description'] as String,
      title: map['title'] as String,
      date: map['date'] as String,
      id: map['id'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as bool : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  final String date;
  final String description;
  final String id;
  bool? isDelete;
  bool? isDone;
  bool? isFavorite;
  final String title;

  @override
  List<Object?> get props =>
      [title, isDone, isDelete, id, description, isFavorite, date];

  Task copyWith({
    String? date,
    String? title,
    String? description,
    String? id,
    bool? isDone,
    bool? isDelete,
    bool? isFavorite,
  }) {
    return Task(
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "description": description,
      'title': title,
      'id': id,
      'isDone': isDone,
      'isDelete': isDelete,
      'isFavorite': isFavorite,
      'date': date,
    };
  }
}
