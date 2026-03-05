<h1>📱 Mobile Restaurant App </h1>

## 📌 Project Overview

A modern iOS restaurant ordering application built with SwiftUI and Xcode, designed to deliver a smooth food-ordering experience for customers. The app integrates secure payments with Stripe, supports user accounts and provides a menu with appetizers views.

This project is a **Mobile Restaurant App** developed using:

- 🧑🏻‍💻 SwiftUI
- 🛠️ Xcode
- ☕ Java
- 🧪 Springboot
- 🧾 Stripe

The app contains typical e-commerce functionality such as:

✅ User Registration  
✅ Login  
✅ Product search  
✅ Add to cart  
✅ Payments  
✅ Navigation across categories

This makes it ideal for mobile software development practice.

---

## 🚀 Getting Started
# Prerequisites

- macOS
- Xcode 14+
- Swift 5+
- Stripe account
- Running Spring Boot backend services

---

## 💳 Stripe Payments Support

1. User select appetizer, click order button  
2. App requests **Payment Intent** from backend  
3. Backend communicates with Stripe API  
4. Stripe Payment Sheet is displayed on iOS  
5. Payment confirmation returned to backend  
6. Order is finalized


### 🏗️ Project Structure
```
MobileRestaurantApp
│
├── Models
│   ├── User.swift
│   ├── MenuItem.swift
│   └── Order.swift
│
├── Views
│   ├── LoginView.swift
│   ├── MenuView.swift
│   ├── AppetizersView.swift
│   ├── CartView.swift
│   └── CheckoutView.swift
│
├── ViewModels
│   ├── AuthViewModel.swift
│   ├── MenuViewModel.swift
│   └── OrderViewModel.swift
│
├── Services
│   ├── APIService.swift
│   └── StripeService.swift
│
└── Resources
```

