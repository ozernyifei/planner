import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/src/calendar/common/enums.dart' show CalendarView;

class ViewMode {

  ViewMode([CalendarView initialView = CalendarView.day]) : _currentView = initialView;
  CalendarView _currentView;

  CalendarView get currentView => _currentView;

  void change() {
    switch (_currentView) {
      case CalendarView.day:
        _currentView = CalendarView.week;
        break;
      case CalendarView.week:
        _currentView = CalendarView.month;
        break;
      case CalendarView.month:
        _currentView = CalendarView.day;
        break;
      default:
        _currentView = CalendarView.day;
        break;
    }
  }

  // Save view mode to SharedPreferences (assuming you have a save function)
  Future<void> save(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, _currentView.toString());
  }

  // Load view mode from SharedPreferences (assuming you have a load function)
  Future<CalendarView> load(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final storedViewString = prefs.getString(key);
    if (storedViewString != null) {
      return CalendarView.values.firstWhere((view) => view.toString() == storedViewString);
    } else {
      return CalendarView.day; // Set default if not found
    }
  }
}
