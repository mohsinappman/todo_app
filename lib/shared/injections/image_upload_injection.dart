import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories/image_upload_repository_impl.dart';
import '../domain/usecases/image_upload_usecase.dart';

final supabaseClient = Supabase.instance.client;
final imageUploadRepository = ImageUploadRepositoryImpl(supabaseClient);
final imageUploadUsecase = ImageUploadUsecase(imageUploadRepository);