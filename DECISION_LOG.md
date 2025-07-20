# EV Charging Station Finder - Decision Log

This document captures the key architectural and implementation decisions made during the development of the EV Charging Station Finder application.

## 2025-07-18

### Initial Project Setup
- **Decision**: Set up the initial project structure and version control
- **Details**: Created the initial Xcode project with iOS 14 as the minimum supported version

### Documentation
- **Decision**: Added initial project documentation
- **Details**: Created README.md with project overview and setup instructions

### Architecture Definition
- **Decision**: Adopted Clean Architecture with MVVM pattern
- **Details**: 
  - Defined core protocols for the application layers
  - Implemented a clear separation of concerns with distinct layers for Data, Domain, and Presentation

### Data Layer Implementation
- **Decision**: Structured the data layer with repository pattern and automated model generation.
- **Details**:
  - Created models by generating Swift structures directly from the OpenChargeMap API's JSON schema using the JSON4Swift tool. This approach ensures accuracy and efficiency in mapping external data structures to native Swift types.
  - Implemented API service for EV charging stations.
  - Set up repository implementation for data management.

### Dependency Injection
- **Decision**: Implemented dependency injection for better testability and modularity
- **Details**: Added DI container to manage dependencies between components

### Domain Layer
- **Decision**: Implemented use cases to encapsulate business logic
- **Details**: Created use cases to handle the core functionality of the application

## 2025-07-19

### Presentation Layer - Map Integration
- **Decision**: Added MapView for station location visualization
- **Details**:
  - Implemented a reusable MapView component using MapKit
  - Added support for displaying multiple annotations
  - Integrated with SwiftUI using UIViewRepresentable

### Station Detail Screen
- **Decision**: Implemented StationDetailScreen with map integration
- **Details**:
  - Created a detailed view for individual charging stations
  - Integrated MapView to show station location
  - Added UI components for station information display
  - MKMapView is used to display the map

### UI Enhancements
- **Decision**: Improved station list item appearance
- **Details**:
  - Adjusted icon sizing for better visual hierarchy
  - Updated location handling with new default coordinates (34.0286238, -84.2173394)
  - Enhanced overall UI consistency

### Key Architectural Decisions

1. **Minimum iOS Version**
   - **Decision**: iOS 14.0 as minimum supported version
   - **Rationale**: Balances access to modern APIs with broad device support

2. **Architecture**
   - **Pattern**: Clean Architecture with MVVM
   - **Layers**:
     - **Data**: Handles data retrieval and persistence
     - **Domain**: Contains business logic and use cases
     - **Presentation**: Handles UI and user interactions

3. **Dependency Management**
   - **Approach**: Manual dependency injection
   - **Benefits**: Improved testability and separation of concerns

4. **Networking Framework**
   - **Decision**: Utilize `URLSession` for all network requests.
   - **Rationale**: `URLSession` is Apple's native framework for handling network requests, offering robust and efficient capabilities for HTTP/HTTPS communication. Its deep integration with the Apple ecosystem provides reliable performance and security, making it a suitable choice for the application's data fetching needs.

5. **Networking Implementation**
   - **Implementation**: Custom API service layer
   - **Data Format**: JSON
   - **Parsing**: Manual mapping from JSON to Swift models

### Unit Testing and Mocking Strategy
- **Decision**: Utilize SwiftTesting for unit tests and create mocks manually.
- **Details**: The project leverages the SwiftTesting framework for unit testing. Mocks are implemented manually within the test targets, as attempts to integrate third-party mocking libraries like SwiftyMocky proved problematic.

### Secrets Management
- **Decision**: Manage secrets using an untracked `Secrets.xcconfig` file.
- **Details**: This approach keeps API keys and other sensitive data out of version control. A `Secrets.xcconfig.example` file is included as a template.

### Visual Architecture Documentation
- **Decision**: Document the system architecture visually using PlantUML.
- **Details**: An `architecture.puml` file defines the components and their relationships, with the resulting `architecture.png` diagram stored in the repository for easy reference.

### Data Caching Strategy
- **Decision**: Implement a "local-first" data caching strategy using a protocol-based local data source.
- **Details**: The repository first attempts to fetch data from the local data source. If the source is empty, it retrieves data from the remote API and caches it locally. The current implementation uses an in-memory cache, but thanks to the protocol-oriented design, it can be easily swapped with other persistence mechanisms like a database.

### Inter-Layer Model Mapping
- **Decision**: Adopt a strict one-model-per-layer policy, using dedicated Mappers for data transformation between layers.
- **Details**: Each layer (Data, Domain, Presentation) defines its own model tailored to its specific needs. This prevents creating a single "God Model" and decouples the layers. Dedicated Mapper classes are responsible for converting models as they flow from the data source to the UI, ensuring changes in one layer do not impact others. For a detailed explanation of this strategy, see this [reference article](https://blog.jesusdmedinac.com/mapping-data-between-layers-db8ad93f0f8f?gi=f585a31c8963).

### Network Client Abstraction
- **Decision**: Implement a `NetworkClient` protocol to abstract the underlying `URLSession` for improved testability.
- **Details**: This design allows for easy mocking and replacement of network dependencies in unit tests, ensuring that components relying on network requests can be tested in isolation without actual network calls.

### User Interface Framework
- **Decision**: Adopt SwiftUI as the primary framework for building the user interface.
- **Details**: SwiftUI was chosen for its declarative syntax, cross-platform capabilities (within the Apple ecosystem), and seamless integration with the MVVM pattern, allowing for a more modern and efficient UI development workflow.

### Dependency Injection Container
- **Decision**: Implement a centralized `DIContainer` to manage and resolve dependencies.
- **Details**: This container facilitates the manual dependency injection approach, ensuring that components receive their required dependencies in a structured and testable manner, promoting loose coupling throughout the application.

### Custom Error Handling
- **Decision**: Implement custom error types for specific application layers.
- **Details**: Custom error enums like `EVChargingAPIError` and `UseCaseError` are used to provide granular and domain-specific error information. This approach improves error handling clarity, allows for more precise error management, and enhances the overall robustness of the application.

### API Constants Management
- **Decision**: Centralize API-related constants in a dedicated `OpenChargeMapAPIConstants.swift` file.
- **Details**: This approach improves maintainability by providing a single source of truth for API endpoints and other related configurations, making it easier to manage and update external service details.

### Protocol-Oriented Design for Dependency Inversion
- **Decision**: Adopt a pervasive protocol-oriented design to abstract dependencies and invert control throughout the project.
- **Details**: This fundamental architectural principle ensures that modules depend on abstractions (protocols) rather than concrete implementations. This promotes loose coupling, enhances testability by allowing easy mocking of dependencies, and increases flexibility for future changes or alternative implementations across all layers, including data sources, network clients, and use cases.

### Project Structure and Layer Organization
- **Decision**: Organize the project's codebase into distinct top-level directories reflecting the Clean Architecture layers (Data, Domain, Presentation).
- **Details**: This physical separation reinforces the logical boundaries between layers, making the codebase easier to navigate, understand, and maintain. Each layer contains its specific components (e.g., Data contains models, data sources, repositories; Domain contains models, use cases, repositories; Presentation contains views, view models, mappers).

### Default Location for Station Search
- **Decision**: Use a hardcoded default latitude, longitude, and distance for fetching EV charging stations.
- **Details**: For initial development and demonstration, the `StationsListScreenViewModel` is configured with fixed coordinates (e.g., `defaultLatitude`, `defaultLongitude`) and a default search radius (`defaultDistance`). This simplifies early testing and ensures data is displayed immediately. In future iterations, this should be replaced with dynamic user location detection or user-defined search parameters to provide a more personalized and functional experience.

### Map View Implementation
- **Decision**: Utilize `MKMapView` for map display within the application.
- **Rationale**: Given the minimum iOS deployment target of iOS 14, `MKMapView` from the MapKit framework was chosen as the primary map component. While newer SwiftUI-native map components are available in later iOS versions, `MKMapView` provides robust functionality and broad compatibility with the specified minimum iOS version, ensuring the application's reach to a wider range of devices.
