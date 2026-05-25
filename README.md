# The Supplier Manager - Supply Chain Management System

## 📋 Περιγραφή Έργου

Το **The Supplier Manager** είναι μια ολοκληρωμένη εφαρμογή διαχείρισης εφοδιαστικής αλυσίδας και παραγγελιών. 
Αναπτύχθηκε για να διαχειρίζεται παραγγελίες, αποθέματα, προμηθευτές, πελάτες και logistics.

### 🎯 Σενάριο
Μια εταιρεία χρειάζεται ένα σύστημα για:
- Να παρακολουθεί τις παραγγελίες σε διάφορες καταστάσεις
- Να διαχειρίζεται το απόθεμα και τις κινήσεις αποθήκης
- Να διαχειρίζεται τις σχέσεις με προμηθευτές και πελάτες
- Να παρακολουθεί τις αποστολές και logistics
- Να δημιουργεί αναφορές και παρακολουθεί KPIs

---

## 🛠️ Τεχνικές Προδιαγραφές

### **Backend & Server**
- **Web Server**: Apache (XAMPP)
- **Γλώσσα**: PHP
- **Database**: MySQL / MariaDB

### **Frontend**
- **HTML5**
- **CSS3**
- **JavaScript**

### **Περιβάλλον Ανάπτυξης**
- **XAMPP** (τοπικό περιβάλλον)
- **VSCode** ή άλλο editor
- **GitHub** (version control)

---

## 📁 Δομή του Project

```
the-supplier-manager/
│
├── README.md                 # Αυτό το αρχείο
├── database/
│   └── supplier_manager.sql  # SQL database export
│
├── assets/
│   ├── css/
│   │   └── style.css         # Κύρια CSS
│   ├── js/
│   │   └── script.js         # JavaScript functions
│   └── images/               # Εικόνες
│
├── includes/
│   ├── config.php            # Database connection
│   ├── header.php            # Header template
│   └── footer.php            # Footer template
│
├── pages/
│   ├── dashboard.php         # Dashboard - Αρχική σελίδα
│   ├── orders.php            # Διαχείριση Παραγγελιών
│   ├── inventory.php         # Διαχείριση Αποθέματος
│   ├── suppliers.php         # Διαχείριση Προμηθευτών
│   ├── customers.php         # Διαχείριση Πελατών
│   └── reports.php           # Αναφορές & Analytics
│
└── index.php                 # Entry point
```

---

## 📊 Δομή Βάσης Δεδομένων

### **Πίνακες (Tables)**

#### 1. **suppliers** (Προμηθευτές)
```sql
- supplier_id (PK)
- supplier_name
- contact_person
- email
- phone
- address
- lead_time_days
- rating (1-5)
- created_at
```

#### 2. **products** (Προϊόντα)
```sql
- product_id (PK)
- product_name
- supplier_id (FK)
- price
- available_stock
- reserved_stock
- damaged_stock
- reorder_level
- created_at
```

#### 3. **customers** (Πελάτες)
```sql
- customer_id (PK)
- customer_name
- email
- phone
- address
- outstanding_balance
- created_at
```

#### 4. **orders** (Παραγγελίες)
```sql
- order_id (PK)
- customer_id (FK)
- order_date
- status (Pending, Approved, Processing, Packed, Shipped, Delivered, Returned, Cancelled)
- total_amount
- payment_method
- tracking_number
- delivery_date_estimated
- created_at
```

#### 5. **order_items** (Είδη Παραγγελίας)
```sql
- item_id (PK)
- order_id (FK)
- product_id (FK)
- quantity
- unit_price
- total_price
```

#### 6. **warehouse_movements** (Κινήσεις Αποθήκης)
```sql
- movement_id (PK)
- product_id (FK)
- movement_type (inbound, outbound, transfer)
- quantity
- from_warehouse
- to_warehouse
- movement_date
- notes
```

#### 7. **shipments** (Αποστολές)
```sql
- shipment_id (PK)
- order_id (FK)
- courier_name
- tracking_number
- estimated_delivery
- actual_delivery
- status
- created_at
```

---

## 🚀 Διαδικασία Ανάπτυξης & Υλοποίησης

### **Βήμα 1: Περιβάλλον Setup**
1. Εγκαταστήστε το **XAMPP**
2. Ξεκινήστε τις υπηρεσίες **Apache** και **MySQL**
3. Κλωνοποιήστε ή κατεβάστε το repository

### **Βήμα 2: Database Setup**
1. Ανοίξτε **phpMyAdmin** (http://localhost/phpmyadmin)
2. Δημιουργήστε νέα βάση δεδομένων: `supplier_manager`
3. Εισαγάγετε το SQL file: `database/supplier_manager.sql`

### **Βήμα 3: Configuration**
1. Ανοίξτε το `includes/config.php`
2. Ρυθμίστε τα credentials της βάσης:
```php
$host = 'localhost';
$user = 'root';
$password = '';
$database = 'supplier_manager';
```

### **Βήμα 4: Τοποθέτηση Αρχείων**
1. Αντιγράψτε όλο το φάκελο στο: `C:\xampp\htdocs\the-supplier-manager`

### **Βήμα 5: Δοκιμή**
1. Ανοίξτε το browser: `http://localhost/the-supplier-manager`
2. Δείτε το dashboard και τις σελίδες

---

## 📄 Κύριες Σελίδες (Pages)

### **1. Dashboard (index.php / dashboard.php)**
**Features:**
- Σημερινές παραγγελίες
- Εκκρεμείς αποστολές
- Χαμηλό απόθεμα
- Συνολικά έσοδα
- Alerts/Ειδοποιήσεις

**KPIs:**
- Order Fulfillment Rate
- Average Delivery Time
- Stock Turnover
- Supplier Performance

### **2. Orders Management (orders.php)**
**Δυνατότητες:**
- ✅ Νέα παραγγελία
- ✅ Επεξεργασία παραγγελίας
- ✅ Ακύρωση/Επιστροφή
- ✅ Invoice generation
- ✅ Tracking number

**Καταστάσεις:**
- Pending, Approved, Processing, Packed, Shipped, Delivered, Returned, Cancelled

**Φίλτρα:**
- Ημερομηνία, Πελάτης, Κατάσταση, Μεταφορική, Τρόπος Πληρωμής

### **3. Inventory Management (inventory.php)**
**Διαχείριση Αποθέματος:**
- Διαθέσιμο stock
- Reserved stock
- Damaged stock
- Incoming stock

**Κινήσεις:**
- Inbound (εισαγωγή)
- Outbound (εξαγωγή)
- Transfer μεταξύ αποθηκών

**Extra:**
- Barcode scanning
- QR support
- Batch tracking
- Serial numbers
- Expiration dates

---

## 🤖 Χρήση Εργαλείων AI

### **Εργαλείο Χρησιμοποιημένο: GitHub Copilot**

**Τρόπος Χρήσης:**
1. Δημιουργία δομής database queries
2. PHP functions για CRUD operations
3. HTML/CSS templates
4. JavaScript validation functions
5. SQL queries optimization

**Τμήματα κώδικα με AI υποστήριξη:**
- `includes/config.php` - Database connection handler
- `pages/dashboard.php` - Dashboard queries & display
- `pages/orders.php` - Order management functions
- `pages/inventory.php` - Stock management functions
- `assets/js/script.js` - Client-side validation

---

## 📡 Δικτυακή Αρχιτεκτονική (Network Architecture)

### **Cisco Packet Tracer Topology**

**Απαιτήσεις:**
- ✅ 5 Routers
- ✅ 2 Switches
- ✅ 2 PCs (διαφορετικά δίκτυα, αντιδιαμετρικά)
- ✅ Κυκλική τοπολογία

**Ρύθμιση:**
- IP διευθύνσεις
- Dynamic Routing (OSPF ή RIP)
- Ping connectivity test
- HTTP request από PC προς webserver

**File:** `network-topology.pkt` (δημιουργείται στο Packet Tracer)

---

## 🔧 Εγκατάσταση & Οδηγίες Χρήσης

### **Προαπαιτούμενα**
- XAMPP
- VSCode ή editor
- Git
- Cisco Packet Tracer (για network part)

### **Installation Steps**

```bash
# 1. Clone repository
git clone https://github.com/vagchris-5/the-supplier-manager.git

# 2. Μεταφορά σε XAMPP folder
mv the-supplier-manager C:\xampp\htdocs\

# 3. Database import
# - Ανοίξτε phpMyAdmin
# - Δημιουργήστε DB: supplier_manager
# - Import: database/supplier_manager.sql

# 4. Configuration
# - Επεξεργασία includes/config.php (αν χρειάζεται)

# 5. Access
# http://localhost/the-supplier-manager
```

---

## 📊 Screenshots & Documentation

### **Application Screenshots**
- Dashboard με KPIs
- Orders management page
- Inventory tracking
- Reports & Analytics

### **Database Diagram**
- Entity Relationship Diagram (ERD)
- Table relationships

### **Network Topology**
- Cisco Packet Tracer configuration
- Connectivity tests (ping, tracert)
- HTTP request flow

---

## 📝 Σημειώσεις

- Όλα τα δεδομένα είναι δοκιμαστικά
- Το σύστημα υποστηρίζει multiple users (με authentication σε future versions)
- Η βάση δεδομένων είναι normalization-ready
- Όλα τα queries είναι optimized για performance

---

## 👨‍💼 Συγγραφέας

**Σπουδαστής:** vagchris-5  
**Μάθημα:** Supply Chain Management & Networks  
**Ημερομηνία:** 2026

---

## 📞 Υποστήριξη

Για τυχόν ερωτήματα ή προβλήματα:
- Ελέγξτε τα logs στο XAMPP
- Βεβαιωθείτε ότι η MySQL service είναι ενεργή
- Ελέγξτε τη σύνδεση της βάσης δεδομένων

---

**Happy Coding! 🚀**
