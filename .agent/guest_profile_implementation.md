# Guest-Specific Profile View Implementation

## Overview

Implemented guest-specific UI components for the profile view to provide a tailored experience for users browsing in guest mode.

## Changes Made

### 1. New Widget Files Created

#### `guest_profile_image.dart`

- **Location**: `lib/features/profile/presentation/widgets/guest_profile_image.dart`
- **Purpose**: Displays a default person icon for guest users instead of allowing profile image uploads
- **Features**:
  - Circular avatar with person icon
  - Consistent styling with the app's design system
  - No upload functionality for guests

#### `guest_profile_fields.dart`

- **Location**: `lib/features/profile/presentation/widgets/guest_profile_fields.dart`
- **Purpose**: Shows guest mode information and benefits of creating an account
- **Features**:
  - Informative card explaining guest mode
  - List of features available to registered users:
    - Save favorite meals
    - Track orders
    - Save delivery addresses
    - Manage payment methods
    - Get personalized recommendations
  - Clean, modern design with icons and proper spacing

#### `guest_profile_actions.dart`

- **Location**: `lib/features/profile/presentation/widgets/guest_profile_actions.dart`
- **Purpose**: Provides guest-specific action buttons
- **Features**:
  - "Sign Up" button (primary action) - navigates to login/registration
  - "Exit Guest" button - ends guest session
  - Loading state support for logout action
  - Consistent styling with existing profile actions

### 2. Updated Files

#### `profile_view.dart`

- **Changes**:
  - Added imports for new guest-specific widgets
  - Implemented conditional rendering based on `authRepo.isGuest`
  - Profile image: Shows `GuestProfileImage` for guests, `ProfileImage` for authenticated users
  - Profile fields: Shows `GuestProfileFields` for guests, `ProfileFields` for authenticated users
  - Payment card section: Hidden for guest users
  - Action buttons: Shows `GuestProfileActions` for guests, `ProfileActions` for authenticated users
  - Disabled image upload functionality for guest users

## User Experience Flow

### For Guest Users:

1. **Profile Image**: Default person icon (no upload button)
2. **Information Section**: Card explaining guest mode with benefits of signing up
3. **Payment Section**: Hidden (not available for guests)
4. **Actions**:
   - Primary: "Sign Up" button → navigates to login/registration view
   - Secondary: "Exit Guest" button → ends guest session and returns to login

### For Authenticated Users:

1. **Profile Image**: User's image or default, with upload button
2. **Profile Fields**: Editable name, email (read-only), and address fields
3. **Payment Section**: Debit card display or "Add Card" button
4. **Actions**:
   - Primary: "Edit Profile" button → saves profile changes
   - Secondary: "Log out" button → logs out and returns to login

## Technical Implementation Details

### Conditional Rendering Pattern

```dart
if (authRepo.isGuest)
  const GuestProfileImage()
else
  ProfileImage(...)
```

### Guest Mode Detection

- Uses `authRepo.isGuest` property from the singleton `AuthRepo` instance
- Guest state is managed through `PrefHelper.isGuestMode()`
- Consistent across the entire app

### Design Consistency

- All guest widgets follow the existing design system
- Use `AppColors` for consistent color scheme
- Use `flutter_screenutil` for responsive sizing
- Match the visual style of existing profile widgets

## Benefits

1. **Clear User Communication**: Guest users understand their limitations and are encouraged to sign up
2. **Improved UX**: Tailored interface prevents confusion about unavailable features
3. **Conversion Optimization**: Prominent "Sign Up" button encourages account creation
4. **Code Organization**: Separate widgets for guest and authenticated states improve maintainability
5. **Consistent Design**: All components follow the app's design language

## Testing Recommendations

1. Test guest mode profile view display
2. Verify "Sign Up" button navigation
3. Test "Exit Guest" functionality
4. Verify authenticated user profile still works correctly
5. Test transitions between guest and authenticated states
6. Verify responsive design on different screen sizes
