# Form Mixins Documentation

This directory contains separated mixins for different form functionalities. You can use them individually or combine them as needed.

## Available Mixins

### 1. `validation_mixin.dart`
**Purpose**: Form validation methods
**Methods**:
- `validateEmail(String? value)` - Email validation
- `validatePassword(String? value)` - Password validation  
- `validateRequired(String? value, String fieldName)` - Required field validation

### 2. `ui_mixin.dart`
**Purpose**: UI state management and user feedback
**Properties**:
- `isLoading` - Loading state getter
**Methods**:
- `showError(String message)` - Show error snackbar
- `showSuccess(String message)` - Show success snackbar
- `setLoading(bool loading)` - Set loading state

### 3. `form_widgets_mixin.dart`
**Purpose**: Form widget builders
**Properties**:
- `formKey` - Form state key
**Methods**:
- `buildSubmitButton()` - Create submit button with loading state
- `buildFormContainer()` - Create form container with title/subtitle

### 4. `form_logic_mixin.dart`
**Purpose**: Form submission logic
**Methods**:
- `handleSubmit(VoidCallback onSubmit)` - Handle form submission with validation

### 5. `combined_form_mixin.dart`
**Purpose**: Combined mixin that provides access to all other mixins
**Usage**: Use this when you need all form functionality

## Usage Examples

### Option 1: Use Individual Mixins
```dart
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
    with ValidationMixin, UIMixin, FormWidgetsMixin, FormLogicMixin {
  
  @override
  Widget build(BuildContext context) {
    return buildFormContainer(
      title: 'Login',
      child: Column(
        children: [
          // Your form fields here
          buildSubmitButton(
            text: 'Login',
            onPressed: () => handleSubmit(() {
              // Your login logic here
            }),
          ),
        ],
      ),
    );
  }
}
```

### Option 2: Use Combined Mixin
```dart
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
    with CombinedFormMixin {
  
  @override
  Widget build(BuildContext context) {
    return buildFormContainer(
      title: 'Login',
      child: Column(
        children: [
          // Your form fields here
          buildSubmitButton(
            text: 'Login',
            onPressed: () => handleSubmit(() {
              // Your login logic here
            }),
          ),
        ],
      ),
    );
  }
}
```

### Option 3: Use Only What You Need
```dart
class SimpleForm extends StatefulWidget {
  @override
  _SimpleFormState createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> 
    with ValidationMixin, UIMixin {
  
  // Only validation and UI methods available
  // No form widgets or submission logic
}
```

## Benefits

1. **Modularity**: Use only the mixins you need
2. **Reusability**: Mixins can be used across different widgets
3. **Maintainability**: Each mixin has a single responsibility
4. **Flexibility**: Combine mixins in different ways
5. **Testability**: Test each mixin independently

## Best Practices

1. **Use individual mixins** when you only need specific functionality
2. **Use CombinedFormMixin** when you need all form features
3. **Keep mixins focused** on a single responsibility
4. **Document your mixins** with clear purpose and usage examples 