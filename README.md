<h1>📱 Mobile Restaurant App </h1>

## 📌 Project Overview

This project is a **Mobile Restaurant App** developed using:

- 🧑🏻‍💻 SwiftUI
- 🛠️ Xcode
- ☕ Java
- 🧪 Springboot
- 🧾 Stripe

The app contains typical e-commerce functionality such as:

- User Registration
- Login
- Product search
- Add to cart
- Checkout functionality
- Navigation across categories

This makes it ideal for mobile software development practice.

---

## 🚀 Features

✅ Page Object Model (POM) Design Pattern  
✅ Cross Browser Testing  
✅ Maven Build Management  
✅ TestNG Execution and Assertions  
✅ HTML Reports (Extent Reports / TestNG Reports)  
✅ Logging using Log4j2  
✅ Screenshot Capture on Failure  
✅ Parallel Execution Support  
✅ Configurable via properties file  
✅ Reusable utils  

---

## 🌐 Stripe Payments Support

This framework supports execution on:

| Browser | Supported |
|--------|-----------|
| Chrome | ✅ |
| Firefox | ✅ |
| Edge | ✅ |

Browser can be selected using:

```bash
mvn test -Dbrowser=chrome
mvn test -Dbrowser=firefox
mvn test -Dbrowser=edge
```
---

### 🏗️ Project Structure
```
SeleniumFramework/
│
├── src/
│   ├── test/java/
│   │   ├── base/
│   │   │   └── BaseTest.java
│   │   │
│   │   ├── pages/
│   │   │   ├── LoginPage.java
│   │   │   ├── HomePage.java
│   │   │   └── RegisterPage.java
│   │   │
│   │   ├── tests/
│   │   │   ├── LoginTest.java
│   │   │   ├── RegisterTest.java
│   │   │   └── SearchTest.java
│   │   │
│   │   └── utils/
│   │       ├── ConfigReader.java
│   │       ├── ScreenshotUtil.java
│   │       └── DriverFactory.java
│
├── src/test/resources/
│   ├── config.properties
│   ├── log4j2.xml
│   └── testng.xml
│
├── reports/
├── logs/
├── screenshots/
│
├── pom.xml
└── README.md
```

