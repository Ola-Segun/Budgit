# AI Development Guide: Strategic Instructions for Building the Budget Tracking App

## Core Principles for AI Implementation

### 1. **Sequential Execution Strategy**

**DO NOT attempt to build everything simultaneously.** Follow this strict hierarchy:

```
Priority 1: Foundation (Must be 100% complete before moving on)
  → Core error handling
  → Theme system
  → Local storage setup
  → Basic navigation

Priority 2: Single Feature Vertical Slice
  → Pick ONE feature (Transactions recommended)
  → Build complete: Domain → Data → Presentation
  → Test thoroughly
  → Only then move to next feature

Priority 3: Iteration
  → Build remaining features one at a time
  → Integrate with existing features
  → Maintain consistency
```

### 2. **Critical Decision Points**

When encountering ambiguity, apply these rules:

**Architecture Decisions:**
- If uncertain between two approaches → Choose the simpler one initially
- Can always refactor to complex later, but cannot easily simplify
- Example: Start with basic StateNotifier, add state machines only if needed

**Package Selection:**
- Essential vs Nice-to-have test: "Can the app function without this?"
- If yes → Defer to later phase
- If no → Implement now

**Feature Scope:**
- MVP test: "Would users pay for the app without this feature?"
- If yes → Core feature, build now
- If no → Enhancement, defer

### 3. **Code Generation Workflow**

**Critical: Generate code in this specific order:**

```dart
// Step 1: Define domain entities (pure Dart, no dependencies)
@freezed
class Transaction with _$Transaction {
  const factory Transaction({...}) = _Transaction;
}

// Step 2: Define repository interfaces (contracts)
abstract class TransactionRepository {
  Future<Result<List<Transaction>>> getAll();
}

// Step 3: Define use cases (business logic)
class AddTransaction {
  final TransactionRepository _repository;
  Future<Result<Transaction>> call(Transaction tx) async {...}
}

// Step 4: Implement data layer (DTOs, data sources, repository impl)
@HiveType(typeId: 0)
class TransactionDTO extends HiveObject {...}

// Step 5: Build presentation layer (providers, UI)
@riverpod
class TransactionNotifier extends _$TransactionNotifier {...}

// Step 6: Create UI widgets (screens, components)
class TransactionListScreen extends ConsumerWidget {...}
```

**Why this order matters:**
- Dependencies flow inward (UI depends on domain, not vice versa)
- Can test each layer independently
- Changes in UI don't break business logic
- Can swap implementations without touching core logic

### 4. **Testing Strategy for AI**

**Implement tests BEFORE moving to next feature:**

```
For each feature:
1. Write domain entity tests (5-10 tests)
2. Write use case tests (10-15 tests)
3. Write repository tests (8-12 tests)
4. Write widget tests (3-5 key screens)
5. Integration test (1 complete flow)

Only after all tests pass → Move to next feature
```

**Test Coverage Gates:**
- Domain layer: >90% coverage required
- Data layer: >80% coverage required
- Presentation: >60% coverage required
- If coverage drops below threshold → Fix before proceeding

### 5. **Error Handling Protocol**

**Every async operation must follow this pattern:**

```dart
// ALWAYS wrap in try-catch
try {
  final result = await operation();
  return Result.success(result);
} on SpecificException catch (e) {
  return Result.error(Failure.specific(e.message));
} catch (e) {
  return Result.error(Failure.unknown(e.toString()));
}

// NEVER return raw data without Result wrapper
// NEVER throw exceptions to UI layer
// ALWAYS log errors for debugging
```

### 6. **State Management Rules**

**Follow this state pattern strictly:**

```dart
// 1. Define state with all possible substates
@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState.initial() = _Initial;
  const factory FeatureState.loading() = _Loading;
  const factory FeatureState.loaded(Data data) = _Loaded;
  const factory FeatureState.error(String message) = _Error;
}

// 2. State notifier handles transitions
class FeatureNotifier extends StateNotifier<FeatureState> {
  // ALWAYS start with initial state
  FeatureNotifier() : super(const FeatureState.initial());
  
  // ALWAYS show loading before async operations
  Future<void> load() async {
    state = const FeatureState.loading();
    // ... operation
    state = FeatureState.loaded(data);
  }
}

// 3. UI handles all states
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(featureProvider);
  
  return state.when(
    initial: () => InitialView(),
    loading: () => LoadingView(),
    loaded: (data) => DataView(data),
    error: (msg) => ErrorView(msg),
  );
}
```

### 7. **Data Persistence Logic**

**Database operations must follow this pattern:**

```dart
// 1. ALWAYS use DTOs for storage (never domain entities directly)
// 2. ALWAYS use mappers for conversion
// 3. ALWAYS handle exceptions

class RepositoryImpl implements Repository {
  Future<Result<Entity>> add(Entity entity) async {
    try {
      // Convert to DTO
      final dto = Mapper.toDTO(entity);
      
      // Store
      await _dataSource.insert(dto);
      
      // Return original entity
      return Result.success(entity);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    }
  }
}
```

**Why DTOs are mandatory:**
- Domain entities may change (business rules)
- Storage format should be stable
- Allows versioning and migration
- Separates concerns cleanly

### 8. **UI Component Strategy**

**Build components in layers:**

```
Layer 1: Design System (Week 1-2)
  → Colors, Typography, Spacing
  → Base components (Button, TextField, Card)
  → Test in isolation

Layer 2: Feature Components (Week 3-4)
  → Transaction-specific widgets
  → Use design system components
  → No business logic in widgets

Layer 3: Screens (Week 3-4)
  → Compose feature components
  → Connect to state management
  → Handle navigation
```

**Component Checklist:**
```
Before creating new component, check:
☐ Can I use existing design system component?
☐ Can I compose from smaller components?
☐ Does this need to be a separate component?
☐ Is business logic separated?
☐ Are loading/error states handled?
☐ Is accessibility considered?
```

### 9. **Performance Optimization Guidelines**

**Apply optimizations in this order:**

```
Phase 1: Functional Correctness
  → Make it work first
  → Don't optimize prematurely

Phase 2: Obvious Issues
  → Remove unnecessary rebuilds (const, keys)
  → Lazy load lists (ListView.builder)
  → Cache computed values (riverpod select)

Phase 3: Measured Optimization
  → Profile app (DevTools)
  → Identify actual bottlenecks
  → Optimize only proven slow paths

Phase 4: Advanced Optimization
  → Isolates for heavy computation
  → Database indexing
  → Image optimization
```

**Performance Rules:**
- If list has >50 items → Use ListView.builder
- If computation takes >100ms → Consider caching
- If computation takes >500ms → Consider isolate
- If database query takes >200ms → Add index

### 10. **Critical Mistakes to Avoid**

**DO NOT:**

❌ **Mix layers:**
```dart
// WRONG: UI directly accessing database
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final box = Hive.box('transactions'); // ❌ No!
    return ListView(children: box.values.map(...));
  }
}

// RIGHT: UI uses provider → repository → data source
class MyWidget extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionsProvider); // ✓ Yes!
    return state.when(...);
  }
}
```

❌ **Ignore null safety:**
```dart
// WRONG
String? getName() => user.name; // Might be null
print(getName().toUpperCase()); // ❌ Crash!

// RIGHT
String? getName() => user.name;
final name = getName();
if (name != null) {
  print(name.toUpperCase()); // ✓ Safe
}
```

❌ **Skip error handling:**
```dart
// WRONG
Future<void> loadData() async {
  final data = await repository.getData(); // ❌ Unhandled errors
  state = data;
}

// RIGHT
Future<void> loadData() async {
  state = const LoadingState();
  final result = await repository.getData();
  result.when(
    success: (data) => state = LoadedState(data),
    error: (failure) => state = ErrorState(failure),
  );
}
```

❌ **Hard-code values:**
```dart
// WRONG
Container(
  padding: EdgeInsets.all(16), // ❌ Magic number
  child: Text('Title', style: TextStyle(fontSize: 24)), // ❌ Hard-coded
)

// RIGHT
Container(
  padding: AppSpacing.cardPaddingAll, // ✓ From design system
  child: Text('Title', style: AppTypography.headlineLarge), // ✓ Consistent
)
```

### 11. **Debugging Strategy**

**When something doesn't work:**

```
Step 1: Identify Layer
  → Is this a UI issue? (widget not showing)
  → Is this a state issue? (data not updating)
  → Is this a data issue? (database not saving)
  → Is this a logic issue? (calculation wrong)

Step 2: Isolate Problem
  → Add print statements at layer boundaries
  → Check return values
  → Verify state transitions

Step 3: Fix at Correct Layer
  → UI issue → Fix in presentation layer
  → State issue → Fix in provider
  → Data issue → Fix in repository/data source
  → Logic issue → Fix in use case

Step 4: Add Test
  → Write test that reproduces bug
  → Verify test fails
  → Fix code
  → Verify test passes
```

### 12. **Code Review Self-Checklist**

**Before considering any code "done":**

```
Functionality:
☐ Does it work as intended?
☐ Edge cases handled?
☐ Error cases handled?
☐ Loading states shown?

Code Quality:
☐ Follows architecture pattern?
☐ No business logic in UI?
☐ Proper error handling?
☐ Null safety respected?
☐ Constants used (no magic numbers)?
☐ Meaningful variable names?

Testing:
☐ Unit tests written?
☐ Tests pass?
☐ Coverage meets minimum?

Performance:
☐ No unnecessary rebuilds?
☐ Lists optimized?
☐ Images optimized?

Accessibility:
☐ Semantic labels added?
☐ Touch targets 48x48+?
☐ Color contrast checked?

Documentation:
☐ Public APIs documented?
☐ Complex logic explained?
☐ TODO comments addressed?
```

### 13. **Feature Implementation Template**

**For each new feature, follow this exact sequence:**

```
Day 1: Planning
  1. Define entities (domain models)
  2. Define repository interface
  3. List required use cases
  4. Sketch UI flow

Day 2-3: Domain Layer
  1. Create entities with freezed
  2. Create repository interface
  3. Implement use cases
  4. Write unit tests (>90% coverage)

Day 4-5: Data Layer
  1. Create DTOs with Hive annotations
  2. Create mappers
  3. Implement data sources
  4. Implement repository
  5. Write tests (>80% coverage)

Day 6-7: Presentation Layer
  1. Create state classes
  2. Create providers
  3. Build UI components
  4. Build screens
  5. Write widget tests
  6. Write integration test

Day 8: Polish & Test
  1. Manual testing
  2. Fix bugs
  3. Add loading states
  4. Add error handling
  5. Verify accessibility
```

### 14. **Dependency Management**

**Add packages in phases:**

```
Phase 1 (Foundation): Only essential
  - flutter_riverpod
  - go_router
  - hive
  - freezed
  - intl

Phase 2 (Core Features): As needed per feature
  - Add only when starting that feature
  - Verify compatibility
  - Test before committing

Phase 3 (Polish): Enhancement packages
  - flutter_animate
  - shimmer
  - lottie
  
Phase 4 (Production): Monitoring
  - sentry_flutter
  - firebase_analytics (optional)
```

**Package Addition Rules:**
1. Search pub.dev for package
2. Check: popularity, likes, pub points, maintenance
3. Verify null safety support
4. Check last update date (<6 months preferred)
5. Read documentation
6. Test in isolation first
7. Only then integrate into main code

### 15. **Git Workflow for AI**

**Commit after each completed unit:**

```
Commit Frequency:
- After each entity created
- After each use case implemented
- After each test file completed
- After each screen completed
- After fixing each bug

Commit Message Format:
feat(transactions): add Transaction entity
feat(transactions): implement AddTransaction use case
test(transactions): add AddTransaction tests
fix(transactions): handle null date in mapper
refactor(transactions): simplify repository logic

Branch Strategy:
main (don't touch until Phase 7)
  └── develop (your working branch)
      ├── feature/transactions-domain (merge after day 3)
      ├── feature/transactions-data (merge after day 5)
      └── feature/transactions-ui (merge after day 7)
```

### 16. **Context Window Management**

**As an AI with limited context, manage information:**

```
Keep in Active Context:
- Current feature being built
- Related domain entities
- Error handling patterns
- Architecture rules

Document and Reference:
- Completed features (don't keep in memory)
- Design system components (reference when needed)
- Test patterns (document once, reuse)

Use External Tools:
- Write TODO.md with next steps
- Update PROGRESS.md after each feature
- Document decisions in DECISIONS.md
```

### 17. **Quality Gates**

**Do not proceed to next phase if:**

```
❌ Any tests failing
❌ Coverage below minimum
❌ Flutter analyze shows errors
❌ App crashes on basic operation
❌ Previous feature incomplete
❌ Critical bug unresolved

✓ Proceed only when:
✓ All tests pass
✓ Coverage meets minimum
✓ No analysis errors
✓ Manual testing successful
✓ Feature fully functional
```

### 18. **Production Readiness Checklist**

**Before submitting to stores:**

```
Functionality:
☐ All features work
☐ No placeholder data
☐ All screens accessible
☐ Navigation flows correctly

Performance:
☐ App starts in <2 seconds
☐ No frame drops on main flows
☐ Database queries <200ms
☐ Images optimized

Quality:
☐ No console logs
☐ No TODOs in code
☐ All tests pass
☐ Test coverage >70%

Assets:
☐ App icon (all sizes)
☐ Splash screen
☐ Screenshots
☐ Store listing

Legal:
☐ Privacy policy
☐ Terms of service
☐ Third-party licenses

Configuration:
☐ Production API keys
☐ Signing keys configured
☐ Version number set
☐ Build number incremented
```

## Final Strategic Guidance

**The most important rule: Build incrementally, test continuously, integrate carefully.**

Think of this like building a house:
1. Foundation must be solid (Core architecture)
2. Build one room at a time (One feature)
3. Finish each room completely (Test thoroughly)
4. Only then start next room (Next feature)
5. Don't decorate until structure is sound (Polish after functionality)

**Success = Slow, steady, tested progress**
**Failure = Trying to do everything at once**

Follow this guide sequentially, validate at each step, and you'll build a production-ready app systematically and reliably.