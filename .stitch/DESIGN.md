# KhataMitra Design System

A premium, production-ready bookkeeping app for Indian shop owners. Built on Material Design 3 with a warm, accessible, and confident visual identity.

## 1. Visual Theme & Atmosphere

**Mood**: Trustworthy yet approachable. Clinical precision meets human warmth.

**Density**: 5/10 (Balanced) — Generous whitespace with clear hierarchy. Not dense dashboards, not art gallery sparse.

**Variance**: 6/10 (Offset Asymmetric) — Intentional asymmetric layouts. Left-aligned content. Strategic use of whitespace. No cookie-cutter card grids.

**Motion**: 5/10 (Fluid CSS) — Spring physics animations on all interactive elements. Micro-interactions on buttons, inputs, and state changes. No over-animation; purposeful motion only.

**Altitude**: 3/10 (Flat Modern) — Minimal elevation, high contrast with color coding. Shadows are subtle and functional, not decorative.

---

## 2. Color Palette & Roles

**Primary Intent**: Navy blue expresses trust and stability. Green signals income/credits. Red signals expense/debits.

### Light Theme

| Name | Hex | Role | Usage |
|------|-----|------|-------|
| **Canvas White** | `#F9F9F9` | Primary background | Screen background, scaffold |
| **Pure Surface** | `#FFFFFF` | Card/container fill | Card surfaces, input fields |
| **Charcoal Ink** | `#1A1C1C` | Primary text | Headlines, body copy |
| **Muted Steel** | `#71717A` | Secondary text | Descriptions, metadata, labels |
| **Whisper Border** | `#E2E2E2` | Subtle dividers | Card borders, dividing lines |
| **Navy Trust** | `#004D99` | Primary CTA, focus | Buttons, active states, links |
| **Green Prosperity** | `#1B6D24` | Income/credit, positive | Credit amounts, income entries, positive actions |
| **Red Caution** | `#A00312` | Expense/debit, negative | Debit amounts, warnings, destructive actions |
| **Light Navy** | `#D6E3FF` | Primary tint layer | Primary button backgrounds, active states |
| **Light Green** | `#A0F399` | Secondary tint layer | Secondary button backgrounds, credit tints |
| **Light Red** | `#FFB4AC` | Tertiary tint layer | Tertiary button backgrounds, debit tints |
| **Error Red** | `#BA1A1A` | Error state | Form validation errors, critical alerts |
| **Success Green** | `#228B22` | Success state | Successful operations, confirmations |

### Dark Theme

| Name | Hex | Role | Usage |
|------|-----|------|-------|
| **Darkest Canvas** | `#0A0A0A` | Primary background | Screen background, scaffold |
| **Dark Surface** | `#111111` | Card/container fill | Card surfaces, input fields |
| **Light Silver** | `#E2E2E2` | Primary text | Headlines, body copy |
| **Muted Silver** | `#A0A0A0` | Secondary text | Descriptions, metadata, labels |
| **Dark Whisper** | `#424752` | Subtle dividers | Card borders, dividing lines |
| **Light Navy** | `#A9C7FF` | Primary CTA, focus | Buttons, active states, links |
| **Light Green** | `#88D982` | Income/credit, positive | Credit amounts, income entries, positive actions |
| **Light Red** | `#FFAB99` | Expense/debit, negative | Debit amounts, warnings, destructive actions |

### Palette Rules

- **Maximum 1 accent color** (Navy primary) with strategic secondary colors (green, red) for semantic meaning
- **Never mix warm and cool grays** — stick to Zinc/Slate neutrals throughout
- **No pure black** (`#000000`) — use Charcoal Ink (`#1A1C1C`) or Dark Zinc
- **No neon/oversaturated accents** — Saturation stays below 80%
- **No outer glow shadows** — use subtle diffused shadows only
- **High contrast on light backgrounds** — Text always meets WCAG AA standards

---

## 3. Typography System

**Baseline**: Plus Jakarta Sans (headlines/display), Inter (body/labels) for readability and Indian market familiarity.

### Font Stack Rules

- **Display & Headlines**: Plus Jakarta Sans (weights: 400, 700, 800)
- **Body & Labels**: Inter (weights: 400, 500, 600, 700)
- **Mono (Data)**: Roboto Mono (for currency amounts, timestamps, codes)

### Type Scale & Hierarchy

| Role | Size | Weight | Letter-Spacing | Usage |
|------|------|--------|-----------------|-------|
| **Display Large** | 57px | 400 | -0.25px | Never used (too large) |
| **Display Medium** | 45px | 400 | 0px | Hero screens, primary page title |
| **Display Small** | 36px | 400 | 0px | Dashboard headers |
| **Headline Large** | 32px | 800 | -0.50px | Feature titles, section headers |
| **Headline Medium** | 28px | 700 | -0.25px | Screen titles, card headers |
| **Headline Small** | 24px | 700 | 0px | Subsection titles, emphasis |
| **Title Large** | 22px | 700 | 0px | Onboarding step titles |
| **Title Medium** | 16px | 600 | 0.15px | List item titles, bold body |
| **Title Small** | 14px | 600 | 0.10px | Card labels, input labels |
| **Body Large** | 16px | 400 | 0.50px | Primary body copy |
| **Body Medium** | 14px | 400 | 0.25px | Secondary copy, descriptions |
| **Body Small** | 12px | 400 | 0.40px | Captions, helper text, timestamps |
| **Label Large** | 14px | 600 | 0.10px | Metadata, tags, badges |
| **Label Medium** | 12px | 600 | 0.50px | Small labels, chips |
| **Label Small** | 11px | 600 | 0.40px | Micro labels, asset labels |

### Typography Rules

- **No all-caps styling** except for explicit micro-labels (e.g., "BUSINESS NAME")
- **Headlines must have clear hierarchy** via weight and color, never just size
- **Body text maximum 65 characters per line** for readability
- **Relaxed line height** on body (1.6x) for comfort
- **Brand voice**: Conversational, not technical. Never use "seamless", "elevate", "unleash"
- **Always use Theme.of(context).textTheme** — never hardcode font families or sizes
- **Currency amounts in Roboto Mono** for precision and visual scannability

### Anti-Patterns (NEVER DO)

- ❌ Mixed font families across a single screen (except mono for data)
- ❌ Hardcoded colors in TextStyle — use ThemeData.textTheme roles
- ❌ ALL CAPS body copy — reserved for micro-labels and business names
- ❌ Oversized headlines (57px) on mobile screens
- ❌ Light text on light backgrounds — always ensure WCAG AA contrast
- ❌ Custom text styles outside of AppTextStyles

---

## 4. Component Specifications

### Buttons

#### Primary Button (ElevatedButton)

```
Background: Navy (#004D99) on light, Light Navy (#A9C7FF) on dark
Text: White on light, Dark (#001B3D) on dark
Padding: Vertical 20px, Horizontal 24px
Border Radius: 12px
Height: 56px (minimum touch target)
State: Ripple effect on press, subtle -1px translate on active
Font: Title Medium (16px, 600 weight)
Icon Support: Leading or trailing icon, 24px
Shadow: None (flat modern)
Behavior: Full width in modals/forms, auto-width in inline contexts
```

**When to use**: Primary CTAs, form submissions, navigation actions that progress the flow.

#### Secondary Button (OutlinedButton)

```
Background: Transparent
Border: 1px Whisper Border (#E2E2E2) on light, 1px Dark Whisper (#424752) on dark
Text: Navy (#004D99) on light, Light Navy (#A9C7FF) on dark
Padding: Vertical 20px, Horizontal 24px
Border Radius: 12px
Height: 56px (minimum touch target)
State: Ripple effect on press, border darkens on hover
Font: Title Medium (16px, 600 weight)
Icon Support: Leading or trailing icon, 24px
Shadow: None
Behavior: Used for secondary actions, cancellations, non-adjacent navigation
```

**When to use**: Secondary actions, "Skip", "Cancel", optional flows.

#### Ghost Button (TextButton)

```
Background: Transparent
Border: None
Text: Navy (#004D99) on light, Light Navy (#A9C7FF) on dark
Padding: Vertical 12px, Horizontal 24px
Border Radius: 8px
Height: auto
State: Text color darkens on press
Font: Label Large (14px, 600 weight)
Icon Support: Leading or trailing icon, 20px
Shadow: None
Behavior: Inline, no visual prominence
```

**When to use**: Tertiary actions, "Learn more", links, retry actions.

#### Semantic Buttons (Income/Expense)

```
Green Prosperity Button:
  Background: Green (#1B6D24) on light, Light Green (#88D982) on dark
  Text: White on light, Dark (#002204) on dark
  Usage: Income/credit actions, positive operations

Red Caution Button:
  Background: Red (#A00312) on light, Light Red (#FFAB99) on dark
  Text: White on light, Dark (#410003) on dark
  Usage: Debit/expense actions, destructive operations, warnings
```

**When to use**: When the button's semantic meaning is critical (income vs. expense).

### Cards

#### Standard Card

```
Background: Pure Surface (#FFFFFF) on light, Dark Surface (#111111) on dark
Border Radius: 16px
Padding: 20px (generous)
Border: 1px Whisper Border (#E2E2E2) on light, 1px Dark Whisper (#424752) on dark
Shadow: Subtle elevation (1px offset, 4px blur, rgba(0,0,0,0.08))
Behavior: Clickable cards have ripple effect, elevated on hover (mobile: pressed state)
```

**When to use**: Grouping related content, separating concerns, visual containment.

#### Card Elevation Rules

- **Container Lowest** (Floating): Surfaces on top of the base (modals, overlays)
- **Container High**: Elevated above base surface (selected cards, hovered items)
- **Container Default**: Same level as background (listing cards, content grouping)
- **No shadow cards**: Use 1px top border dividers instead of elevation for subtle separation

#### Instruction Card (Special)

```
Background: Light Blue Tint (#EFF6FF) on light, Dark Blue Tint (#002244) on dark
Border: 1px Navy (#004D99) on light, 1px Light Navy (#A9C7FF) on dark
Border Radius: 12px
Padding: 16px
Leading Icon: Info icon (24px, Navy)
Text: Body Medium, Navy emphasis
Usage: Informational, tips, security notices
```

**Example**: "Your data is encrypted and only visible to you" (privacy card in onboarding).

### Text Inputs

#### InputDecoration Baseline

```
Label: Above input, Title Small (14px, 600 weight), always present
Hint: Lighter secondary text inside input
Background: Surface Container High (#E8E8E8) on light, Dark Surface High on dark
Border: 1px Whisper Border (#E2E2E2) on light, unfocused
Border Radius: 12px
Height: 56px (minimum)
Padding: Vertical 20px, Horizontal 16px
Focus Border: 2px Navy (#004D99) on light, 2px Light Navy (#A9C7FF) on dark
Error Border: 2px Error Red (#BA1A1A)
Error Text: Below input, Body Small, Error Red
Helper Text: Below input, Body Small, Muted Steel
Cursor Color: Navy (#004D99)
```

**Focus states**: Border thickness increases from 1px to 2px, fill lightens slightly.

#### Input Types

| Type | Icon | Numeric | Keyboard | Example |
|------|------|---------|----------|---------|
| **Phone** | Phone icon | No | `phone` | Enter phone number |
| **Rupee Amount** | Rupee icon | Yes | `number` | Amount (₹ prefix) |
| **Search** | Search icon | No | `text` | Search customers |
| **Business Name** | Building icon | No | `text` | "Raju Kirana Store" |
| **Textarea** | Text icon | No | `multiline` | Message for reminder |

#### Input States

- **Empty**: Placeholder text, neutral styling
- **Filled**: Label above, text visible, 1px border
- **Focused**: 2px Navy border, slight background lightening
- **Error**: 2px Error Red border, error text below, red exclamation icon
- **Disabled**: Opaque disabled state, cursor not-allowed
- **Success**: Subtle green checkmark on right (optional, for validation)

### List Items & Transactions

#### Transaction Row (ListTile variant)

```
Layout: Horizontal two-column flex
Left Column:
  - Customer Avatar: 44px circular, initials or photo
  - Name: Title Medium (16px), Charcoal
  - Description: Body Small (12px), Muted Steel
Right Column:
  - Amount: Label Large (14px), Monospace (Roboto Mono), 600 weight
  - Amount Color: Green (#1B6D24) for income, Red (#A00312) for expense
  - Date: Label Small (11px), Muted Steel, right-aligned
Heights: 72–80px
Divider: 1px Whisper Border below each row
Interactive: Tap to open ledger detail, ripple effect
```

**Example Patterns**:
- "Ramesh Kumar" | 200 received | "₹ 1,200" | "Today, 2:34 PM"
- "Amit Sharma" | "₹ 3,800" | "owes you" | Green text

#### Badge/Chip

```
Background: Colored container (e.g., Light Navy for status badges)
Text: Label Small (11px), 600 weight, matching text color
Padding: Vertical 6px, Horizontal 12px
Border Radius: 999px (pill-shaped)
Icon: Leading icon (16px) optional
Usage: Status labels, category tags, filters
```

**Examples**: "Private & Secure", "Payment Received", "Reminder Set"

### Modals & Sheets

#### Bottom Sheet (Add Customer, Record Payment, etc.)

```
Corner Radius: 24px top only
Background: Pure Surface (#FFFFFF) on light, Dark Surface (#111111) on dark
Header:
  - Title: Headline Medium (28px), centered
  - Close Icon: Top-right, tap to dismiss
Content Padding: 24px
Dividers: 1px Whisper Border between logical sections
CTA Button: Primary or semantic button, full-width at bottom
Behavior: Swipe down to dismiss, tap outside does NOT dismiss (modal), Esc key dismisses
```

**Anti-Pattern**: Never auto-dismiss by tapping outside (leads to accidental dismissals).

#### Dialog (Confirmation)

```
Background: Pure Surface
Border Radius: 12px
Padding: 24px
Title: Headline Small (24px)
Action Buttons: Two-button footer (Cancel left, Action right)
Button Colors: Cancel as secondary, action as semantic (green/red if applicable)
```

### Navigation

#### App Bar

```
Height: 56px (medium)
Background: Surface Container Lowest (#FFFFFF) on light, Dark Surface (#111111) on dark
Border: None (or 1px subtle divider at bottom)
Leading Icon: Back button or menu hamburger (24px, Navy)
Title: Headline Small (24px) or Headline Medium (28px)
Trailing Icons: Search, notifications, overflow menu (24px, Navy)
Icon Colors: Navy (#004D99) on light, Light Navy (#A9C7FF) on dark
Text Color: Charcoal Ink (#1A1C1C) on light, Light Silver (#E2E2E2) on dark
Behavior: NO transparency or glassmorphism — solid, flat design
Elevation: None (flat)
```

#### Bottom Navigation

```
Height: 64px
Background: Pure Surface (#FFFFFF) on light, Dark Surface (#111111) on dark
Border: 1px Whisper Border top
Items: 4 navigation targets (DASHBOARD, CATALOG, REMINDERS, SETTINGS)
Active Icon Color: Navy (#004D99)
Inactive Icon Color: Muted Steel (#71717A)
Label: Label Small (11px), only visible when active
Icon: 24px
Behavior: Tab-style, no animation (simple state change)
Touch Target: Minimum 44px per item
```

---

## 5. Layout & Spacing Principles

### Spacing Scale

```
XSmall:  4px   — Micro-spacing (icon padding, tight gaps)
Small:   8px   — Minor gaps (element internal spacing)
Medium:  16px  — Standard padding/margin (cards, inline spacing)
Large:   24px  — Section padding, major gaps
XLarge:  32px  — Screen margins, major section separation
2XLarge: 48px  — Hero section bottom margin, page breaks
```

### Application Rules

- **Card Padding**: 20px (Medium + 4px extra for breathing room)
- **Screen Padding**: 16px on sides (mobile), 24px (tablet), 32px (desktop)
- **Between Sections**: 32px (Large vertical gap)
- **Between Lists**: 16px (standard gap)
- **Form Field Gap**: 16px (between input and next element)
- **Button-to-Button Gap**: 12px (secondary gap for button pairs)
- **Icon-to-Text Gap**: 12px (leading or trailing icons in buttons/labels)

### Container Rules

- **Max-width**: 480px (mobile optimized), 640px (tablet), 1020px (desktop)
- **Centered Layouts**: Prefer asymmetric left-aligned layouts over centered
- **Horizontal Scroll**: NEVER on mobile. All content must fit in viewport or scroll vertically
- **Safe Areas**: Respect notch/home indicator safe areas on mobile

### Responsive Collapse

**Mobile (< 640px)**:
- Single-column layouts
- 16px screen padding
- Full-width buttons and inputs
- No side-by-side elements except tight icon+text pairs

**Tablet (640px — 1024px)**:
- Two-column layouts for content + sidebar
- 24px screen padding
- Flexible grid layouts

**Desktop (> 1024px)**:
- Three-column layouts
- 32px screen padding
- Max-width containers

### Grid System

```
Mobile: 4-column grid (16px gutter)
Tablet: 8-column grid (24px gutter)
Desktop: 12-column grid (32px gutter)
```

**Example**: A "Record Payment" screen uses:
- Mobile: Full-width form (1 column)
- Tablet: 2-column sidebar layout (sidebar 3 cols, content 5 cols)
- Desktop: 3-column (sidebar 2 cols, content 7 cols, empty 3 cols)

---

## 6. Motion & Interaction Philosophy

### Spring Physics (Default)

```
Stiffness: 100
Damping: 20
Mass: 1.0
Duration: 350–500ms for all interactive transitions
```

This creates a **weighty, premium feel** — responsive but not snappy.

### Micro-Interactions

- **Button Press**: -1px translate on active (tactile feedback), gravity return on release
- **Input Focus**: Subtle 2px border expansion (no scale, no color shift)
- **Card Hover**: Slight elevation increase (shadow deepens, scale 1.01x)
- **List Item Swipe**: Ripple effect on tap, slide animation if swiped for action
- **Loading State**: Shimmer animation across content skeleton (no spinning icons)
- **State Change**: Fade in/out (opacity transition 200ms linear) for visibility changes

### Perpetual Motion (Loops)

- **Loading Screen**: Subtle shimmer crawl across input skeleton (2s infinite loop)
- **Empty State Icon**: Gentle float/pulse (4s infinite loop, amplitude 2px)
- **Featured Item**: Subtle pulse on focus state (highlight = "look at me")

### Entrance/Exit Animations

- **Screen Entrance**: Fade in (200ms) with slight -10px vertical translate (bottom-to-top)
- **Modal Open**: Scale up from center (0.95 → 1.0, 300ms spring)
- **List Item Cascade**: Staggered fade-in (50ms delay between items, max 300ms per item)
- **Page Exit**: Fade out (150ms) — no reverse animation

### Anti-Pattern Animations

- ❌ No page rotate/flip transitions
- ❌ No bounce/elastic easing on primary interactions
- ❌ No parallax scrolling (performance killer on mobile)
- ❌ No auto-playing video backgrounds
- ❌ No CSS gradients animating (animate only opacity or transform)
- ❌ No more than 1 simultaneous animation per component (stagger or nest instead)

---

## 7. Dark Mode Specifications

The app supports light (default) and dark themes, toggled via `ThemeMode` in settings.

### Dark Mode Rules

- **Lighten surfaces**: Light Navy (#A9C7FF), Light Green (#88D982), Light Red (#FFAB99)
- **Darken backgrounds**: Zinc-950 (#0A0A0A) for maximum contrast
- **Increase text contrast**: Use Light Silver (#E2E2E2) for all body text
- **Maintain color semantics**: Green = income, Red = expense in both modes
- **No color inversion**: Semantic colors stay the same (just lightened accents)
- **Badge tints**: Use 20% opacity overlays (dark surfaces don't use light tints)

### Dark Mode Testing

Every screen must pass:
- [ ] Text contrast ≥ 7:1 (WCAG AAA)
- [ ] Icons readable at 24px
- [ ] Borders visible (min 1px, `rgba(255,255,255,0.12)`)
- [ ] No "crushed blacks" (pure #000000 never used)
- [ ] Color semantics preserved (green income, red expense)

---

## 8. Anti-Patterns & Banned Styles

### Absolutely BANNED

- ❌ **Emojis** anywhere (including buttons or headings)
- ❌ **Hardcoded colors** — always reference `AppColors`
- ❌ **Custom fonts** outside Plus Jakarta Sans and Inter
- ❌ **Pure black** (`#000000`) — use Charcoal Ink (`#1A1C1C`)
- ❌ **Neon/outer glows** on buttons or text
- ❌ **Oversaturated accents** (saturation > 80%)
- ❌ **ALL CAPS body copy** (reserved for micro-labels)
- ❌ **Overlapping text and images** — clear spatial separation
- ❌ **3-column equal card grids** on mobile (collapses to 1)
- ❌ **Generic placeholder names** ("John Doe", "Acme Store", "User 123")
- ❌ **Fabricated metrics** ("99.9% uptime", "50ms response time", "18.5k transactions")
- ❌ **Fake system labels** ("SYSTEM // 2024", "METRICS // JAN")
- ❌ **Broken image links** (use SVG avatars or picsum.photos)
- ❌ **Filler UI text** ("Scroll to explore", "Swipe down", bouncing chevrons)
- ❌ **Circular spinners** — use skeleton loaders instead
- ❌ **Fixed modal backdrops** (scrim color with transparency only)
- ❌ **Custom scrollbars** — use default OS behavior
- ❌ **Gradient text** on headlines (reserved for display only, max once per screen)
- ❌ **Manual focus handling** — use Flutter's focus system (`FocusNode`)

### Strongly Discouraged

- 🟡 **Gradient backgrounds** (only on hero, max 1 per screen)
- 🟡 **Hover states on mobile** (use pressed instead)
- 🟡 **Hero animations** on small elements (distracting)
- 🟡 **Drop shadows** (prefer elevation/borders instead)
- 🟡 **Centered hero layouts** (use asymmetric left-aligned instead)
- 🟡 **Serif fonts** (not in dashboards; only for print/editorial)
- 🟡 **Flash animation** (jarring; use fade instead)
- 🟡 **Blur filters** (performance cost; use opacity instead)

---

## 9. Implementation Checklist

Before finishing any screen, verify:

### Design Consistency
- [ ] Colors match `AppColors` (no hardcoded hex codes)
- [ ] Typography uses `Theme.of(context).textTheme` roles
- [ ] Spacing uses `AppDimensions` tokens
- [ ] Border radius matches `AppDimensions.radiusSmall` (12px) or `radiusMedium` (16px)
- [ ] Shadows are subtle and functional (if any)

### Accessibility
- [ ] Text contrast ≥ 4.5:1 (WCAG AA)
- [ ] Touch targets ≥ 44px
- [ ] Status and meaning not conveyed by color alone (use icons + text)
- [ ] Form labels always present and associated
- [ ] Error messages are clear and actionable

### Mobile Responsiveness
- [ ] No horizontal scroll
- [ ] Single-column layout on mobile (< 640px)
- [ ] All buttons and inputs full-width on mobile
- [ ] Padding reduces on mobile (16px vs. 24px+)
- [ ] Text scales appropriately (no oversized headlines on mobile)

### Localization (L10n)
- [ ] All user-facing text in `AppLocalizations` (English, Hindi, Telugu)
- [ ] RTL layout support considered (future)
- [ ] Currency always uses locale-aware formatting

### Testing
- [ ] Screenshot test (golden test via Alchemist package)
- [ ] Tested in light and dark modes
- [ ] Tested on emulator and real device
- [ ] Accessibility audit via Flutter's `accessibility_testing` package
- [ ] Coverage ≥ 85% for related test files

---

## 10. Component Library Quick Reference

### Widgets to Use (in `lib/core/widgets/`)

- `AppButton` — Primary, secondary, ghost buttons with optional semantics
- `AppCard` — Standard card containers with consistent styling
- `AppTextField` — Text inputs with labels, hints, validation
- `AppListTile` — Transaction rows with avatar, amount, date
- `AppBadge` — Status badges and chips
- `AppEmptyState` — Composed empty state with icon and call-to-action
- `AppLoadingState` — Skeleton loaders matching layout dimensions
- `AppErrorState` — Error feedback with retry action

### Theme Usage

```dart
// ✅ DO:
Theme.of(context).colorScheme.primary
Theme.of(context).textTheme.headlineMedium
Text('Hello', style: Theme.of(context).textTheme.bodyLarge)

// ❌ DON'T:
Color(0xFF004D99)  // Use AppColors.primary instead
Text('Hello', style: TextStyle(fontSize: 16, fontFamily: 'Inter'))
```

### Dimensions Usage

```dart
// ✅ DO:
Padding(
  padding: const EdgeInsets.all(AppDimensions.spacingMedium),
  child: ...,
)
BorderRadius.circular(AppDimensions.radiusSmall)

// ❌ DON'T:
padding: const EdgeInsets.all(16),
borderRadius: BorderRadius.circular(12),
```

---

## 11. Screen Flow Reference

**Route Flow (from `app_router.dart`)**:

```
/theme          → Theme selection screen
  ↓
/language       → Language selection screen
  ↓
/login          → OTP login screen
  ↓
/shop-details   → Onboarding (business name + details)
  ↓
/dashboard      → Main dashboard (to-receive, to-pay, recent, actions)
  ├─ /ledger/{customerId}
  ├─ /catalog
  ├─ /reminders
  └─ /settings
```

---

## 12. Design Inspiration & References

The visual language draws from:
- **Material Design 3** — System fonts, color roles, touch targets
- **Stitch Design** — Component library and layout systems
- **Effective Dart** — Code clarity and naming conventions
- **Bookkeeping Domain** — Color semantics (green income, red expense)
- **Indian Market** — Plus Jakarta Sans for warm, approachable identity

---

**Last Updated**: April 4, 2026  
**Version**: 1.0.0  
**Maintainer**: KhataMitra SDE Team
