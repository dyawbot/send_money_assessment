// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransactionDto _$UserTransactionDtoFromJson(Map<String, dynamic> json) =>
    UserTransactionDto(
      (json['phoneNumber'] as num).toInt(),
      (json['amount'] as num).toDouble(),
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$UserTransactionDtoToJson(UserTransactionDto instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
      'createdDate': instance.createdDate,
    };

UserDataTransactionDto _$UserDataTransactionDtoFromJson(
        Map<String, dynamic> json) =>
    UserDataTransactionDto(
      (json['data'] as List<dynamic>)
          .map((e) => UserTransactionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAmount: (json['walletAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDataTransactionDtoToJson(
        UserDataTransactionDto instance) =>
    <String, dynamic>{
      'walletAmount': instance.walletAmount,
      'data': instance.data,
    };
