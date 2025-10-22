# Product Requirements Document (PRD)

## Adventure Hive - MVP: AI-Powered Adventure Checklist Generator

---

## 1. Product Overview

**Product Name:** Adventure Hive  
**Version:** MVP 1.0  
**Target Platform:** Flutter Mobile App  

### Vision Statement
Create an intelligent adventure planning assistant that generates personalized equipment checklists using AI, helping adventurers prepare efficiently for their outdoor activities with rich user feedback and interactions.

---

## 2. Problem Statement

Outdoor enthusiasts often forget essential items when planning adventures, leading to:
- Safety risks from missing critical equipment
- Reduced enjoyment due to inadequate preparation  
- Time wasted creating manual packing lists
- Inexperience with specific adventure types
- Lack of immediate feedback during the planning process

---

## 3. Solution Overview

An AI-powered mobile app that:
1. **Collects** adventure details through an intuitive form with real-time validation
2. **Generates** personalized equipment checklists using Gemini AI
3. **Allows** users to select/deselect items from AI suggestions with visual feedback
4. **Saves** selected items for easy reference during packing
5. **Provides** rich user feedback through dialogs, snackbars, and interactive elements

---

## 4. Core User Journey

```
Login → Adventure Form → AI Generation → Item Selection → Final Checklist
```

### Detailed Flow:
1. **User Authentication** - Simple login/signup with validation feedback
2. **Adventure Details Collection** - Multi-step form with real-time validation
3. **AI Checklist Generation** - Gemini creates suggestions with loading states
4. **Item Selection Interface** - Bottom sheet with selectable items and feedback
5. **Final Checklist View** - Review selected items with interactive features

---

## 5. Feature Requirements

### 5.1 Adventure Form (Core Data Collection)

**Based on AdventureModel:**
- **Type**: Hiking, Camping, BikePacking, RoadTrip, Other (custom)
- **Members**: Number of participants
- **Difficulty**: Easy, Medium, Hard
- **Distance**: Kilometers to travel/walk
- **Challenge**: Specific requirements/obstacles
- **Weather**: Sunny ☀️, Rainy 🌧️, Snowy ❄️, Mixed/Unpredictable

**UI Requirements:**
- **Page 1**: Adventure type selection (buttons) + members + difficulty
- **Page 2**: Distance + challenge + weather conditions
- **Navigation**: Swipe between pages or next/back buttons
- **Validation**: All fields required with real-time feedback
- **User Feedback**: 
  - Snackbars for validation errors
  - Success dialogs for form completion
  - Progress indicators for multi-step form

### 5.2 AI Checklist Generation

**Integration with Gemini AI:**
- **Input**: Complete AdventureModel data
- **Prompt Engineering**: Generate contextual equipment lists
- **Output Format**: Items separated by " - " (e.g., "Backpack - Hiking boots - Tent")
- **Response Handling**: Parse and display as selectable list

**User Feedback During Generation:**
- **Loading Dialog**: Show AI generation progress with animated indicators
- **Success Snackbar**: "AI generated X items for your adventure!"
- **Error Handling**: User-friendly error dialogs with retry options
- **Timeout Handling**: "Taking longer than expected" feedback

**Sample Prompt:**
```
Generate a list of essential items for an adventure.
Type: Hiking, Members: 4, Difficulty: Hard, Distance: 15km, 
Challenge: Mountain climbing, Weather: Snowy
Output only items separated with - Example: Backpacks - Hiking boots - Tent
```

### 5.3 Item Selection Interface (Bottom Sheet)

**UI Components:**
- **Bottom Sheet**: Modal presentation over adventure form
- **Item List**: Scrollable list of AI-generated suggestions
- **Selection State**: Checkbox/toggle for each item with visual feedback
- **Visual Feedback**: Selected items highlighted (green background)
- **Actions**: 
  - "Select All" / "Deselect All" buttons with confirmation dialogs
  - "Submit Selection" button (only enabled when items selected)

**User Feedback:**
- **Selection Feedback**: Snackbar showing "X items selected"
- **Confirmation Dialogs**: "Are you sure you want to select all items?"
- **Validation**: "Please select at least one item" with themed snackbar
- **Success**: "X items added to your checklist!" with success animation

**Behavior:**
- **Multi-selection**: Users can select multiple items
- **Persistent state**: Selections maintained during session
- **Validation**: Minimum 1 item must be selected to submit
- **Undo Actions**: Swipe to undo recent selections

### 5.4 Final Checklist View

**Display Requirements:**
- **Selected Items**: Show only user-chosen items with pack status
- **Adventure Summary**: Display adventure details at top
- **Item Status**: Checkbox to mark items as "packed" with animations
- **Progress Tracking**: Visual progress bar showing packed vs total items
- **Actions**:
  - "Edit Selection" - return to item selection with confirmation
  - "Start New Adventure" - clear form with confirmation dialog
  - "Export/Share" - share checklist (future feature)

**User Feedback:**
- **Packing Progress**: "X of Y items packed" with progress indicators
- **Completion Celebration**: "All items packed! Ready for adventure!" dialog
- **Share Success**: "Checklist shared successfully!" snackbar
- **Clear Confirmation**: "Are you sure? This will clear your current checklist"

---

## 6. Technical Architecture

### 6.1 State Management (GetX)

**Controllers:**
```dart
class AdventureController extends GetxController {
  final _isLoading = false.obs;
  final _error = ''.obs;
  final _generatedItems = <String>[].obs;
  
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  List<String> get generatedItems => _generatedItems.toList();
  
  Future<void> generateItems(AdventureModel model) async {
    _isLoading.value = true;
    _error.value = '';
    
    try {
      final items = await adventureRepository.generateItems(model);
      _generatedItems.value = _parseItems(items);
      Get.snackbar('Success', 'AI generated ${_generatedItems.length} items!');
    } catch (e) {
      _error.value = e.toString();
      Get.dialog(ErrorDialog(message: e.toString()));
    } finally {
      _isLoading.value = false;
    }
  }
}

class AdventureFormController extends GetxController {
  final _adventureModel = AdventureModel().obs;
  final _currentPage = 0.obs;
  
  AdventureModel get adventureModel => _adventureModel.value;
  int get currentPage => _currentPage.value;
  
  void setValue(String key, dynamic value) {
    _adventureModel.update((model) {
      // Update specific field
    });
  }
  
  bool get isFormValid => _validateForm();
  
  void nextPage() {
    if (_currentPage.value < 1) {
      _currentPage.value++;
      Get.snackbar('Page ${_currentPage.value + 1}', 'Form progress saved');
    }
  }
}

class ChecklistController extends GetxController {
  final _selectedItems = <String>[].obs;
  final _packedItems = <String>[].obs;
  
  List<String> get selectedItems => _selectedItems.toList();
  List<String> get packedItems => _packedItems.toList();
  
  void toggleItem(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      Get.snackbar('Removed', '$item removed from checklist');
    } else {
      _selectedItems.add(item);
      Get.snackbar('Added', '$item added to checklist');
    }
  }
  
  void selectAll() {
    Get.dialog(
      ConfirmationDialog(
        title: 'Select All Items',
        message: 'Are you sure you want to select all ${generatedItems.length} items?',
        onConfirm: () {
          _selectedItems.value = generatedItems;
          Get.snackbar('Success', 'All items selected!');
        },
      ),
    );
  }
  
  void markAsPacked(String item) {
    if (_packedItems.contains(item)) {
      _packedItems.remove(item);
      Get.snackbar('Unpacked', '$item marked as unpacked');
    } else {
      _packedItems.add(item);
      Get.snackbar('Packed', '$item marked as packed');
      
      if (_packedItems.length == _selectedItems.length) {
        Get.dialog(
          SuccessDialog(
            title: 'Adventure Ready!',
            message: 'All items packed! You\'re ready for your adventure!',
          ),
        );
      }
    }
  }
}
```

**Dependency Injection:**
```dart
// lib/shared/locator.dart
void setupLocator() {
  Get.lazyPut<AdventureRepository>(() => AdventureRepositoryImpl());
  Get.lazyPut<AdventureController>(() => AdventureController());
  Get.lazyPut<AdventureFormController>(() => AdventureFormController());
  Get.lazyPut<ChecklistController>(() => ChecklistController());
}
```

### 6.2 Data Models

**Core Model:**
```dart
class AdventureModel {
  final String type, members, difficulty, distance, challenge, weather;
  
  AdventureModel({
    this.type = '',
    this.members = '',
    this.difficulty = '',
    this.distance = '',
    this.challenge = '',
    this.weather = '',
  });
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'members': members,
    'difficulty': difficulty,
    'distance': distance,
    'challenge': challenge,
    'weather': weather,
  };
  
  factory AdventureModel.fromJson(Map<String, dynamic> json) => AdventureModel(
    type: json['type'] ?? '',
    members: json['members'] ?? '',
    difficulty: json['difficulty'] ?? '',
    distance: json['distance'] ?? '',
    challenge: json['challenge'] ?? '',
    weather: json['weather'] ?? '',
  );
}

class ChecklistItem {
  final String name;
  final bool isSelected;
  final bool isPacked;
  
  ChecklistItem({
    required this.name,
    this.isSelected = false,
    this.isPacked = false,
  });
}
```

### 6.3 Repository Pattern

```dart
abstract class AdventureRepository {
  Future<String> generateItems(AdventureModel model);
}

class AdventureRepositoryImpl implements AdventureRepository {
  final Gemini _gemini = Gemini.instance;
  
  @override
  Future<String> generateItems(AdventureModel model) async {
    try {
      final prompt = _buildPrompt(model);
      final response = await _gemini.text(prompt);
      return response?.content?.parts.firstOrNull?.text ?? '';
    } catch (e) {
      throw Exception('Failed to generate items: $e');
    }
  }
  
  String _buildPrompt(AdventureModel model) {
    return '''
Generate a list of essential items for an adventure.
Type: ${model.type}, Members: ${model.members}, Difficulty: ${model.difficulty}, 
Distance: ${model.distance}km, Challenge: ${model.challenge}, Weather: ${model.weather}
Output only items separated with - Example: Backpacks - Hiking boots - Tent
''';
  }
}
```

---

## 7. UI/UX Specifications

### 7.1 Design System

**Color Palette (Using AppColors):**
- **Primary**: Dark green (#2E6939) - Main actions, headings
- **Secondary**: Dark teal (#2D5F5A) - Supporting elements
- **Success**: Light green (#95EB84) - Positive feedback, selections
- **Warning**: Light yellow (#EAEA78) - Attention, ratings
- **Error**: Red (#E53E3E) - Error states, destructive actions
- **Surface**: White (#FFFFFF) - Cards, sheets
- **Background**: Light brown (#F5F3F0) - App background

**Typography (San Francisco Font):**
- **Headers**: SFUIDisplay, Bold, 20px
- **Body**: SFUIDisplay, Regular, 16px
- **Labels**: SFUIDisplay, Medium, 14px

### 7.2 User Feedback Components

**Snackbars (GetX):**
```dart
// Success Snackbar
Get.snackbar(
  'Success',
  'Items generated successfully!',
  backgroundColor: colors.success,
  colorText: Colors.white,
  duration: Duration(seconds: 3),
  snackPosition: SnackPosition.TOP,
);

// Error Snackbar
Get.snackbar(
  'Error',
  'Failed to generate items. Please try again.',
  backgroundColor: colors.error,
  colorText: Colors.white,
  duration: Duration(seconds: 4),
  snackPosition: SnackPosition.TOP,
);

// Info Snackbar
Get.snackbar(
  'Info',
  'Please select at least one item',
  backgroundColor: colors.secondary,
  colorText: Colors.white,
  duration: Duration(seconds: 2),
  snackPosition: SnackPosition.BOTTOM,
);
```

**Dialogs:**
```dart
// Loading Dialog
Get.dialog(
  LoadingDialog(
    message: 'AI is generating your checklist...',
    showProgress: true,
  ),
  barrierDismissible: false,
);

// Confirmation Dialog
Get.dialog(
  ConfirmationDialog(
    title: 'Clear Checklist',
    message: 'Are you sure you want to clear your current checklist?',
    confirmText: 'Clear',
    cancelText: 'Cancel',
    onConfirm: () => clearChecklist(),
  ),
);

// Success Dialog
Get.dialog(
  SuccessDialog(
    title: 'Adventure Ready!',
    message: 'All items packed! You\'re ready for your adventure!',
    icon: Icons.check_circle,
  ),
);
```

**Custom Components:**
- **LoadingDialog**: Animated loading with progress indicator
- **ConfirmationDialog**: Yes/No dialogs with themed buttons
- **SuccessDialog**: Celebration dialogs with animations
- **ErrorDialog**: Error display with retry options
- **ProgressIndicator**: Custom progress bars for packing status

### 7.3 Screen Layouts

**Adventure Form Screen:**
- **Header**: Location + edit icon with snackbar feedback
- **Content**: PageView with form fields and real-time validation
- **Footer**: "Start generating" button with loading states
- **Navigation**: Progress indicator with page transitions
- **Validation**: Inline error messages and snackbar notifications

**Item Selection Bottom Sheet:**
- **Header**: "Generated Items" title + close button
- **Content**: Scrollable list with selection feedback
- **Footer**: Action buttons with confirmation dialogs
- **Feedback**: Selection counters and progress indicators

**Final Checklist Screen:**
- **Header**: "Your Adventure Checklist" with progress
- **Content**: Selected items with pack status and animations
- **Actions**: Themed buttons with confirmation dialogs
- **Progress**: Visual progress bar and completion celebrations

---

## 8. Success Metrics

### 8.1 User Engagement
- **Form Completion Rate**: >80% of users complete adventure form
- **Item Selection Rate**: Average 60% of suggested items selected
- **Session Duration**: >3 minutes average time in app
- **User Feedback**: Positive response to interactive elements

### 8.2 AI Performance
- **Generation Success Rate**: >95% successful API calls
- **Response Time**: <5 seconds for item generation
- **Error Recovery**: >90% successful retry attempts
- **User Satisfaction**: High ratings for feedback mechanisms

### 8.3 User Satisfaction
- **App Store Rating**: Target 4.5+ stars
- **User Retention**: 40% return usage within 7 days
- **Completion Rate**: 70% of users reach final checklist
- **Feedback Quality**: Positive user reviews about interactions

---

## 9. Technical Constraints

### 9.1 Dependencies
- **Flutter SDK**: Latest stable version
- **Packages**: get, get_it, flutter_gemini
- **API**: Gemini AI with valid API key required
- **Fonts**: San Francisco (SFUIDisplay, SFNSText)

### 9.2 Performance Requirements
- **App Launch**: <3 seconds cold start
- **Form Response**: Immediate UI feedback
- **AI Generation**: Loading states during API calls
- **Memory Usage**: Efficient state management with GetX

---

## 10. Future Enhancements (Post-MVP)

### Phase 2 Features:
- **Offline Mode**: Cache previous checklists with sync feedback
- **User Profiles**: Save preferences with profile completion dialogs
- **Social Sharing**: Share adventures with success notifications
- **Photo Integration**: Add images with upload progress
- **Location Services**: GPS-based suggestions with permission dialogs
- **Premium Features**: Advanced AI prompts with upgrade prompts

### Phase 3 Features:
- **Community**: User-generated checklists with social feedback
- **Marketplace**: Equipment purchase with transaction confirmations
- **Weather Integration**: Real-time weather with weather alerts
- **Trip Planning**: Multi-day adventure with timeline feedback

---

## 11. Implementation Priority

### Sprint 1 (Core MVP):
1. ✅ Adventure form with GetX state management
2. ✅ AI integration with loading dialogs
3. ✅ Basic item selection with feedback
4. ✅ GetX controllers and dependency injection

### Sprint 2 (UI Polish):
1. 🔄 Bottom sheet item selection with animations
2. 🔄 Final checklist view with progress tracking
3. 🔄 Comprehensive user feedback system
4. 🔄 Error handling and retry mechanisms

### Sprint 3 (Testing & Launch):
1. ⏳ User testing and feedback collection
2. ⏳ Performance optimization
3. ⏳ App store preparation
4. ⏳ Analytics integration

---

## 12. Current Implementation Status

### Architecture Setup ✅
- **AdventureModel**: Complete with serialization
- **AdventureRepository**: Interface and implementation ready
- **Dependency Injection**: GetX locator configured
- **State Management**: GetX controllers implemented

### Controllers ✅
- **AdventureController**: Handles AI generation with loading/error states
- **AdventureFormController**: Form state management with validation
- **ChecklistController**: Item selection and packing state
- **Service Locator**: Clean dependency injection setup

### Next Steps 🔄
- **Implement User Feedback System**: Snackbars, dialogs, animations
- **Create Custom Dialog Components**: Loading, confirmation, success dialogs
- **Add Progress Tracking**: Visual progress indicators throughout
- **Enhance Error Handling**: User-friendly error messages and retry options
- **Implement Animations**: Smooth transitions and micro-interactions

### Technical Debt to Address
- **Add comprehensive user feedback**: Implement snackbars and dialogs
- **Create custom dialog components**: Loading, confirmation, success dialogs
- **Add progress tracking**: Visual indicators for user progress
- **Implement error recovery**: Retry mechanisms and fallback options

---

**This PRD defines a focused MVP that delivers core value: AI-powered adventure checklist generation with rich user feedback and interactions, following GetX architecture principles and modern Flutter development practices.** 