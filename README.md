# 🛡️ CNII Sentinel Eye (Critical Network Infrastructure Intelligence)

**CNII Sentinel Eye** is a specialized Flutter-based mobile dashboard designed to monitor, assess, and alert stakeholders about physical and cyber threats to critical network infrastructure. Serving as the interactive frontend for an automated, LLM-powered threat intelligence system, it visualizes real-time risks to communication networks to prevent outages and damage.

Developed to help safeguard critical telecommunications infrastructure, this system employs automation and LLMs to continuously scan for threats, plotting them on a tactical map and integrating with Telegram alerts for rapid response coordination.

## ✨ Key Features

* **Real-Time Threat Dashboard:** Fetches and displays the latest infrastructure risks directly from the Python/FastAPI backend API (`/patrol/latest`).
* **Interactive Geospatial Mapping:** Utilizes `flutter_map` and OpenStreetMap with "Dark Matter" CartoDB tile layers for a high-contrast, tactical viewing experience.
* **Risk Categorization:** Automatically color-codes threat markers and intelligence cards based on severity (High: Red, Medium: Orange, Low: Green).
* **Actionable Intelligence:** Displays the specific threat type (e.g., Heavy Excavation, Road Grading) and provides AI-generated recommended actions.
* **Resilient Fallback System:** Includes a robust offline mock-data generator tailored to Nigerian infrastructure routes (e.g., Lagos-Ibadan Expressway, Lekki-Epe Expressway) to ensure continuous demonstration capabilities even if the backend is unreachable.

## 🏗️ System Architecture 

CNII Sentinel Eye is the visual component of a larger Agentic AI ecosystem:
1.  **Threat Scanning (Backend):** Automation scripts and LLMs continuously scan for and assess potential threats to network infrastructure.
2.  **Alerting:** Critical threats trigger automated Telegram alerts for immediate stakeholder notification.
3.  **Visualization (This Repository):** The Flutter application consumes the processed threat data via a REST API hosted on Render (`https://cnii-sentinel-backend.onrender.com`) and plots it geographically.

## 🛠️ Tech Stack

* **Framework:** Flutter & Dart
* **Mapping & Geolocation:** `flutter_map`, `latlong2`
* **Networking:** `http` package for API consumption
* **UI/UX:** `google_fonts`, `flutter_svg`, `cupertino_icons`
* **Assets:** Custom adaptive launcher icons managed via `flutter_launcher_icons`

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (^3.10.7)
* Dart SDK

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/yourusername/cnii_sentinel_flutter.git](https://github.com/yourusername/cnii_sentinel_flutter.git)
    cd cnii_sentinel_flutter
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure Backend (Optional):**
    By default, the app points to the live Render backend. 
    * To test locally without the backend, open `lib/services/sentinel_service.dart` and set `useMock = true;`.
    * To connect to a local backend via an Android emulator, change the `baseUrl` to `http://10.0.2.2:<port>`.

4.  **Run the app:**
    ```bash
    flutter run
    ```

## 📱 Interface Overview
* **Main Map:** Centers by default on coordinates `(9.0820, 8.6753)` (Nigeria) with a zoom level of 6.0 to provide a nationwide overview of infrastructure status.
* **Draggable Intelligence Feed:** A bottom sheet that displays a list of active risks. Tapping any risk card automatically pans and zooms the map to the specific threat coordinates.

---
## 👨‍💻 About the Developer
Developed by **Ajijolaoluwa Adesoji**, Full-Stack & AI Engineer and AI Fellow at the Nigerian Communications Commission (NCC). This project showcases the integration of mobile frontend technologies (Flutter/Dart) with advanced AI agentic workflows (Python/FastAPI/LLMs) to solve real-world infrastructure security challenges in Nigeria.
