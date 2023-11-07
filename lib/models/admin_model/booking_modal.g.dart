// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingModalAdapter extends TypeAdapter<BookingModal> {
  @override
  final int typeId = 2;

  @override
  BookingModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingModal(
      id: fields[0] as String,
      image: fields[6] as String,
      studentname: fields[1] as String,
      bookname: fields[2] as String,
      number: fields[3] as String,
      takendate: fields[4] as DateTime?,
      returndate: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BookingModal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentname)
      ..writeByte(2)
      ..write(obj.bookname)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.takendate)
      ..writeByte(5)
      ..write(obj.returndate)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
