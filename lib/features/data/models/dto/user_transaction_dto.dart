import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:send_money_assessment/features/data/models/dto/app_dto.dart';
import 'package:send_money_assessment/features/domain/entities/app_entity.dart';
import 'package:send_money_assessment/features/domain/entities/user_transaction_entity.dart';

part 'user_transaction_dto.g.dart';

@JsonSerializable()
class UserTransactionDto extends AppDto {
  final int phoneNumber;
  final double amount;
  final String? createdDate;

  UserTransactionDto(this.phoneNumber, this.amount, {this.createdDate});

  @override
  UserTransactionEntity toEntity() =>
      UserTransactionEntity(phoneNumber, amount, createdDate: createdDate);

  // @factoryMethod

  factory UserTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$UserTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionDtoToJson(this);
}

@JsonSerializable()
class UserDataTransactionDto {
  final double? walletAmount;
  final List<UserTransactionDto> data;
  UserDataTransactionDto(this.data, {this.walletAmount});

  factory UserDataTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataTransactionDtoToJson(this);
}
