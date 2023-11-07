// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String,
      name: fields[1] as String,
      typebest: fields[2] as String,
      typefavorite: fields[3] as String,
      author: fields[4] as String,
      availability: fields[5] as String,
      category: fields[6] as String,
      about: fields[7] as String,
      image: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.typebest)
      ..writeByte(3)
      ..write(obj.typefavorite)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.availability)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.about)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
