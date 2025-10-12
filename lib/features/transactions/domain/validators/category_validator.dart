import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';

/// Validator for transaction category operations
class CategoryValidator {
  /// Maximum allowed length for category name
  static const int maxNameLength = 50;

  /// Minimum allowed length for category name
  static const int minNameLength = 1;

  /// Validates a category for creation
  static Result<TransactionCategory> validateForCreation(
    TransactionCategory category,
    List<TransactionCategory> existingCategories,
  ) {
    // Basic field validation
    final basicValidation = _validateBasicFields(category);
    if (basicValidation.isError) {
      return basicValidation;
    }

    // Check for duplicate names within the same type
    final duplicateCheck = _validateNoDuplicateName(category, existingCategories);
    if (duplicateCheck.isError) {
      return duplicateCheck;
    }

    return Result.success(category);
  }

  /// Validates a category for update
  static Result<TransactionCategory> validateForUpdate(
    TransactionCategory category,
    List<TransactionCategory> existingCategories,
  ) {
    // Basic field validation
    final basicValidation = _validateBasicFields(category);
    if (basicValidation.isError) {
      return basicValidation;
    }

    // Check for duplicate names within the same type (excluding current category)
    final duplicateCheck = _validateNoDuplicateNameForUpdate(category, existingCategories);
    if (duplicateCheck.isError) {
      return duplicateCheck;
    }

    return Result.success(category);
  }

  /// Validates a category for deletion
  static Result<String> validateForDeletion(
    String categoryId,
    bool isInUse,
  ) {
    if (categoryId.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category ID cannot be empty',
        {'categoryId': 'ID is required'},
      ));
    }

    if (isInUse) {
      return Result.error(Failure.validation(
        'Cannot delete category that is currently in use',
        {'categoryId': 'Category is assigned to transactions or bills'},
      ));
    }

    return Result.success(categoryId);
  }

  /// Validates basic category fields
  static Result<TransactionCategory> _validateBasicFields(TransactionCategory category) {
    // Name validation
    if (category.name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (category.name.trim().length < minNameLength) {
      return Result.error(Failure.validation(
        'Category name is too short',
        {'name': 'Name must be at least $minNameLength character${minNameLength == 1 ? '' : 's'}'},
      ));
    }

    if (category.name.trim().length > maxNameLength) {
      return Result.error(Failure.validation(
        'Category name is too long',
        {'name': 'Name must be $maxNameLength characters or less'},
      ));
    }

    // Icon validation
    if (category.icon.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category icon cannot be empty',
        {'icon': 'Icon is required'},
      ));
    }

    // Color validation (basic check for valid color range)
    if (category.color < 0 || category.color > 0xFFFFFFFF) {
      return Result.error(Failure.validation(
        'Invalid category color',
        {'color': 'Color must be a valid 32-bit integer'},
      ));
    }

    return Result.success(category);
  }

  /// Validates that category name is unique within the same type
  static Result<TransactionCategory> _validateNoDuplicateName(
    TransactionCategory category,
    List<TransactionCategory> existingCategories,
  ) {
    final normalizedName = category.name.trim().toLowerCase();

    final duplicate = existingCategories.any(
      (existing) =>
        existing.type == category.type &&
        existing.name.trim().toLowerCase() == normalizedName,
    );

    if (duplicate) {
      return Result.error(Failure.validation(
        'Category name already exists for this type',
        {'name': 'A category with this name already exists for ${category.type.displayName.toLowerCase()} transactions'},
      ));
    }

    return Result.success(category);
  }

  /// Validates that category name is unique within the same type (for updates)
  static Result<TransactionCategory> _validateNoDuplicateNameForUpdate(
    TransactionCategory category,
    List<TransactionCategory> existingCategories,
  ) {
    final normalizedName = category.name.trim().toLowerCase();

    final duplicate = existingCategories.any(
      (existing) =>
        existing.id != category.id && // Exclude current category
        existing.type == category.type &&
        existing.name.trim().toLowerCase() == normalizedName,
    );

    if (duplicate) {
      return Result.error(Failure.validation(
        'Category name already exists for this type',
        {'name': 'A category with this name already exists for ${category.type.displayName.toLowerCase()} transactions'},
      ));
    }

    return Result.success(category);
  }

  /// Validates category ID format
  static Result<String> validateCategoryId(String categoryId) {
    if (categoryId.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category ID cannot be empty',
        {'categoryId': 'ID is required'},
      ));
    }

    return Result.success(categoryId.trim());
  }
}