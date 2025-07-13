# Hospital Database Schema Project

This project is part of an academic assessment for the IFB105 (Database Management) course at Queensland University of Technology (QUT). It demonstrates the design and implementation of a relational database for managing hospital operations using SQL (MySQL syntax).

## 📁 Project Structure

- `IFB105_3B_n11266139.sql` — Main SQL script including:
  - Database schema creation
  - Table definitions with constraints
  - View creation
  - Sample data insertion
  - Constraint violation examples
  - Role and privilege management using `GRANT` and `REVOKE`

## 🏥 Database Overview

The database models a simplified hospital system with the following key entities:

- **Doctor** — Stores doctor details including registration and specialization.
- **Patient** — Holds patient demographics and links to the attending doctor.
- **Appointment** — Manages scheduled interactions between patients and doctors.
- **Medication** — Catalog of medications, including dosage and dispensation rules.
- **Prescription** — Connects doctors, patients, and medications with administration instructions.

### ✅ Features Implemented

- **Primary and Foreign Key constraints**
- **Data validation (e.g., `CHECK`, `ENUM`, and `UNIQUE`)**
- **View creation (`Patient_medicationView`) for simplified data access**
- **Role-based access control:**
  - `administrator`
  - `doctor`
  - `receptionist`
  - `pharmacist`
- **Security and access revocation**

## 🧪 Sample Queries

The script includes sample `INSERT` statements for demonstration, as well as examples of intentional constraint violations to test database rules.

## 🛠️ Technologies

- SQL (MySQL syntax)
- Compatible with MySQL 8.x

## 📚 Learning Outcomes

- Design normalized relational schemas
- Implement data integrity constraints
- Apply access control using SQL roles
- Understand and demonstrate SQL views
- Develop test data and validate constraints

## 📄 License

This project is part of an academic submission and is intended for educational use only.

---

