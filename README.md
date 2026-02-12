# Swift Mock Bank

Flutter demo banking dashboard with responsive layouts, typed mock domain models, centralized formatting utilities, and widget tests.

## Requirements

- Flutter SDK (stable channel)
- Dart SDK compatible with `sdk: ^3.10.8`

## Run

```bash
flutter pub get
flutter run
```

## Quality Checks

```bash
flutter analyze
flutter test
```

## Project Structure

- `lib/main.dart`: App entrypoint, theme, and named routes
- `lib/home_page.dart`: Responsive dashboard with extracted UI sections
- `lib/profile_page.dart`: Customer profile screen
- `lib/mock_bank_data.dart`: Mock seed data
- `lib/models.dart`: Domain entities and enums
- `lib/utils/app_formatters.dart`: Shared currency/date formatting helpers
- `test/widget_test.dart`: Widget behavior tests (rendering, navigation, responsive UI)
- `test/app_formatters_test.dart`: Formatter unit tests

## Implemented Improvements

- Named route navigation (`/` and `/profile`) for centralized routing.
- Responsive dashboard behavior:
  - Desktop uses persistent sidebar.
  - Mobile uses AppBar + Drawer layout.
- Extracted large page widgets into focused, reusable sections.
- Converted mock transaction dates from string to `DateTime` and categories/types to enums.
- Replaced duplicated ad-hoc currency formatting with `intl` formatters.
- Added accessibility improvements with semantic labels and actionable tooltips.
- Replaced eager spread list rendering with `ListView.builder` in account/activity sections.
- Enabled stricter lints in `analysis_options.yaml`.
- Expanded automated tests beyond a single smoke test.
