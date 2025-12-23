import 'package:client/features/chat/data/datasource/api_chat_datasource.dart';
import 'package:client/features/chat/data/repositories/chat_repo%20_impl.dart';
import 'package:client/features/chat/domain/entities/chat_message.dart';
import 'package:client/features/chat/domain/repositories/chat_repo.dart';
import 'package:client/features/chat/presentation/state/notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final dataSource = RemoteDataSourceImpl();
  ref.onDispose(dataSource.dispose);
  
  return dataSource;
});



final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(ref.read(remoteDataSourceProvider));
});



final chatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier(
    ref.read(chatRepositoryProvider),
    'me', // replace with auth user id
  );
});
