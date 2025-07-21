# EV Charging Station Finder

## Overview

A simple list-detail app that displays a list of EV charging stations from OpenChargeMap API and allows the user to select one to view its details.

## Screenshots and videos

https://github.com/user-attachments/assets/c666c76c-639d-4688-8606-67c748490246

<img width="270" alt="Simulator Screenshot - iPhone 16 - 2025-07-20 at 14 11 35" src="https://github.com/user-attachments/assets/a25c8d1a-a78a-401b-8be0-02a9178c84fd" />

<img width="270" alt="Simulator Screenshot - iPhone 16 - 2025-07-20 at 14 11 42" src="https://github.com/user-attachments/assets/9d0b29b3-df3f-4997-9ad1-3f3846dd4845" />

## [DECISION_LOG.md](DECISION_LOG.md)

Read [DECISION_LOG.md](DECISION_LOG.md) for a detailed explaination about how this app was created developed.

## Setup instructions

The app is expecting a **Secrets.xcconfig** file to be present in the root directory of the project. This file should contain the following variables:

*   **OPEN_CHARGE_MAP_KEY**: The API key for the OpenChargeMap API.

Just create a copy of the **Secrets.xcconfig.example** file and rename it to **Secrets.xcconfig**.

Make you to replace the **OPEN_CHARGE_MAP_KEY** value with your own API key.

## Architecture Proposal

The architecture of the application is based on the **MVVM architecture**. The application is divided into three layers: **Data Layer**, **Domain Layer**, and **Presentation Layer**.

![Architecture](architecture.png)

> You can see the architecture in the **architecture.puml** file.

### Data Layer

The **Data Layer** is responsible for fetching data from the **OpenChargeMap API**. It is divided into two sublayers: **Data Sources** and **Repositories**.

It also includes a **EVChargingStationsInMemoryDataSource** to store the data in memory. It could be replaced with a **Core Data** or **SQLite** database in the future.

#### Models

The **Models** are the data models that are used to represent the data from the **OpenChargeMap API**.

[JSON4Swift](https://www.json4swift.com/) was used to generate the models from the **OpenChargeMap API**.

### Domain Layer

The **Domain Layer** is responsible for business logic. It is divided into two sublayers: **Use Cases** and **Repositories**.

### Presentation Layer

The **Presentation Layer** is responsible for user interface. It is divided into two sublayers: **ViewModels** and **Views**.
