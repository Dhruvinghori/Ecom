

Product Variant Configurator
A high-performance Flutter implementation of a product detail screen featuring dynamic variant resolution, state-driven UI updates, and clean architecture.

🚀 Project Overview
This project demonstrates a robust solution for handling complex product variant matrices (e.g., Color and Size combinations). It ensures that the user is always presented with a valid, purchasable state while preserving their selection intent.
Key Features
* Intelligent Variant Resolution: Automatically snaps to the nearest valid variant if a combination is non-existent.
* Reactive UI: Instant updates for Price, Stock Status, Images, and CTA availability.
* MVVM Architecture: Strict separation between business logic and presentation.
* Design System: Centralized theme management using a dedicated AppColors class.

🛠 Architecture & State Management
This project follows the MVVM (Model-View-ViewModel) pattern using Provider for state management.
* Model: ProductVariant represents the data structure of a single SKU.
* Repository: ProductRepository acts as the data source, currently providing mocked data with simulated network latency.
* ViewModel: ProductViewModel contains all business logic. It manages the current selection, validates combinations, and notifies the UI of changes.
* View: Stateless widgets that rebuild reactively based on the ViewModel's state.

🧩 Technical Implementation Details
How Variant Resolution Works
The resolution logic lives in the _resolveVariant method. When a user selects an attribute:
1. The app attempts an Exact Match for the new combination.
2. If the combination does not exist (e.g., Blue + M), the system identifies the user's latest intent (the Color "Blue").
3. It then finds the first valid variant for that color and automatically updates the other attributes (e.g., resetting Size to "S").
Handling Invalid Combinations
Non-existent combinations are handled via two layers:
1. Visual Feedback: The isOptionValid helper checks the variant matrix and applies a TextDecoration.lineThrough and greys out the option if it's unavailable for the current selection.
2. Logical Reset: If an invalid state is reached, the fallback logic described above ensures the app always settles on a valid ProductVariant object.
Swapping for a Real API
The implementation is designed for easy extension:
* The ProductRepository returns Future<List<ProductVariant>>.
* To integrate a real backend, you simply need to replace the hardcoded list in fetchVariants() with an http or dio call. Because the ViewModel depends on the Repository's interface rather than its implementation details, the rest of the app remains unchanged.

📂 Project Structure
Plaintext

lib/
├── core/
│   └── constants/         # AppColors and central theme constants
├── data/
│   ├── models/            # Product data structures
│   └── repository/        # Data fetching logic (Mocked)
├── providers/             # ProductViewModel (State logic)
├── ui/
│   ├── screens/           # Main Product Detail Screen
│   └── widgets/           # Modularized UI components (Chips, Footer, etc.)
└── main.dart              # Entry point and Provider initialization

📋 Evaluation Criteria Check
Criteria	Implementation
Data Modeling	ProductVariant supports dynamic attributes, pricing, and stock status.
Derived State	All UI elements (CTA, Price, Stock) are derived from the resolved currentVariant.
Architecture	Clear separation between Data, Logic, and UI layers.
UX Consistency	Sticky footer and body content are synced via a single source of truth in the ViewModel.
Code Quality	Clean naming conventions, modular widgets, and efficient map-matching logic.
Export to Sheets

🏁 How to Run
1. Ensure you have Flutter installed.
2. Run flutter pub get.
3. Run flutter run.
