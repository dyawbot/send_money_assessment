import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:send_money_assessment/common/web_urls.dart';
import 'package:send_money_assessment/features/data/models/dto/user_transaction_dto.dart';
part 'user_transaction_api.g.dart';

@injectable
@RestApi(baseUrl: WebUrls.url)
abstract class UserTransactionApi {
  factory UserTransactionApi(Dio dio, {String baseUrl}) = _UserTransactionApi;

  @factoryMethod
  static create(Dio dio) => UserTransactionApi(dio);

  @POST("/posts")
  Future<UserTransactionDto> createTransaction(
    // @Path("url")
    @Body() Map<String, dynamic> body,
  );

  @POST("/posts")
  Future<UserDataTransactionDto> getAllTransactions(
    @Body() Map<String, dynamic> body,
  );
}
