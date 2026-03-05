import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio _dio;

  OrderRemoteDataSourceImpl(this._dio);

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _dio.get(ApiEndpoints.orders);
      final raw = response.data;
      if (raw == null) return [];
      if (raw is List) {
        return raw
            .map<OrderModel>(
                (e) => OrderModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      if (raw is! Map<String, dynamic>) return [];
      final list = raw['data'];
      if (list == null) return [];
      if (list is! List) return [];
      return list
          .map<OrderModel>(
              (e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException('Connection failed');
      }
      if (e.response?.statusCode == 401) throw AuthException('Unauthorized');
      if ((e.response?.statusCode ?? 0) >= 400) {
        final msg = (e.response?.data is Map &&
                (e.response!.data as Map)['message'] != null)
            ? (e.response!.data as Map)['message'].toString()
            : 'Server error';
        throw ServerException(msg, statusCode: e.response?.statusCode);
      }
      throw ServerException('Request failed');
    }
  }
}
