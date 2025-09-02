import 'package:client/app/api/items/items.api.dart';
import 'package:client/app/core/exception/exception.dart';
import 'package:client/app/core/failure/failure.dart';
import 'package:client/app/data/models/item_model.dart';
import 'package:fpdart/fpdart.dart';

class ItemsRepositories {
  final ItemsApi remoteDataSource;
  ItemsRepositories({
    required this.remoteDataSource,
  });

  Future<Either<Failure, ItemModel>> getItemById({required int id}) async {
    try {
      final ItemModel response = await remoteDataSource.getById(id: id);

      return Right(response);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItems(
      {int limit = 10, int offset = 1}) async {
    try {
      final response =
          await remoteDataSource.getAll(limit: limit, offset: offset);

      return Right(response);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, void>> createItems(
      {required ItemModel item}) async {
    try {
      await remoteDataSource.createItem(item: item);
      return const Right(null);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }

  Future<Either<Failure, void>> deleteItemById({required int id}) async {
    try {
      await remoteDataSource.deleteItemById(id: id);

      return const Right(null);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }
  Future<Either<Failure, void>> deleteItems({required List<int> ids}) async {
    try {
      await remoteDataSource.deleteItems(ids: ids);

      return const Right(null);
    } on ClientException catch (e) {
      return Left(ClientFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure("Something wrong in server"));
    }
  }
}
