import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/calendar_event.dart';
import '../repositories/calendar_repository.dart';

/// Use case for syncing bill reminders to calendar
class SyncBillsToCalendar {
  const SyncBillsToCalendar(this._repository);

  final CalendarRepository _repository;

  /// Execute the sync operation
  Future<Result<void>> call() async {
    try {
      // Get sync settings
      final settingsResult = await _repository.getSyncSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.getOrThrow();
      if (!settings.isEnabled || settings.selectedCalendarId == null) {
        return const Result.success(null);
      }

      // TODO: Get bills from bills repository
      // For now, return success
      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to sync bills to calendar: $e'));
    }
  }
}