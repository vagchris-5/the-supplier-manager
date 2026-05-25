<?php
/**
 * Dashboard - Αρχική Σελίδα
 * Εμφανίζει KPIs και σύνοψη δεδομένων
 */
include '../includes/config.php';
include '../includes/header.php';
?>

<h2>📊 Dashboard</h2>

<!-- KPI Cards -->
<div class="dashboard-grid">
    <?php
    // Total Orders
    $ordersResult = executeQuery($conn, "SELECT COUNT(*) as total FROM orders");
    $ordersData = $ordersResult->fetch_assoc();
    $totalOrders = $ordersData['total'];
    
    // Total Revenue
    $revenueResult = executeQuery($conn, "SELECT SUM(total_amount) as revenue FROM orders WHERE status='Delivered'");
    $revenueData = $revenueResult->fetch_assoc();
    $totalRevenue = $revenueData['revenue'] ?? 0;
    
    // Pending Orders
    $pendingResult = executeQuery($conn, "SELECT COUNT(*) as pending FROM orders WHERE status IN ('Pending', 'Approved', 'Processing')");
    $pendingData = $pendingResult->fetch_assoc();
    $pendingOrders = $pendingData['pending'];
    
    // Low Stock Products
    $stockResult = executeQuery($conn, "SELECT COUNT(*) as lowstock FROM products WHERE (available_stock - reserved_stock) <= reorder_level");
    $stockData = $stockResult->fetch_assoc();
    $lowStockItems = $stockData['lowstock'];
    ?>
    
    <div class="card">
        <h3>📦 Συνολικές Παραγγελίες</h3>
        <div class="value"><?php echo $totalOrders; ?></div>
        <div class="status">Όλες οι παραγγελίες</div>
    </div>
    
    <div class="card">
        <h3>💰 Συνολικά Έσοδα</h3>
        <div class="value">€<?php echo number_format($totalRevenue, 2); ?></div>
        <div class="status">Παραδιδόμενες</div>
    </div>
    
    <div class="card">
        <h3>⏳ Εκκρεμείς Παραγγελίες</h3>
        <div class="value"><?php echo $pendingOrders; ?></div>
        <div class="status">Που περιμένουν διεκπεραίωση</div>
    </div>
    
    <div class="card">
        <h3>⚠️ Χαμηλό Απόθεμα</h3>
        <div class="value"><?php echo $lowStockItems; ?></div>
        <div class="status">Προϊόντα κάτω από όριο</div>
    </div>
</div>

<!-- KPI Section -->
<div class="kpi-section">
    <h2>📈 Key Performance Indicators (KPIs)</h2>
    <div class="kpi-grid">
        <?php
        // Order Fulfillment Rate
        $fulfilledResult = executeQuery($conn, "SELECT COUNT(*) as fulfilled FROM orders WHERE status='Delivered'");
        $fulfilledData = $fulfilledResult->fetch_assoc();
        $fulfillmentRate = ($fulfilledData['fulfilled'] / $totalOrders * 100);
        
        // Average Order Value
        $avgResult = executeQuery($conn, "SELECT AVG(total_amount) as average FROM orders WHERE status='Delivered'");
        $avgData = $avgResult->fetch_assoc();
        $avgOrderValue = $avgData['average'] ?? 0;
        
        // Total Customers
        $customersResult = executeQuery($conn, "SELECT COUNT(*) as total FROM customers");
        $customersData = $customersResult->fetch_assoc();
        $totalCustomers = $customersData['total'];
        
        // Total Suppliers
        $suppliersResult = executeQuery($conn, "SELECT COUNT(*) as total FROM suppliers");
        $suppliersData = $suppliersResult->fetch_assoc();
        $totalSuppliers = $suppliersData['total'];
        ?>
        
        <div class="kpi-item">
            <div class="label">Ποσοστό Ολοκλήρωσης</div>
            <div class="value"><?php echo number_format($fulfillmentRate, 1); ?>%</div>
        </div>
        
        <div class="kpi-item">
            <div class="label">Μέσο Ποσό Παραγγελίας</div>
            <div class="value">€<?php echo number_format($avgOrderValue, 2); ?></div>
        </div>
        
        <div class="kpi-item">
            <div class="label">Σύνολο Πελατών</div>
            <div class="value"><?php echo $totalCustomers; ?></div>
        </div>
        
        <div class="kpi-item">
            <div class="label">Σύνολο Προμηθευτών</div>
            <div class="value"><?php echo $totalSuppliers; ?></div>
        </div>
    </div>
</div>

<!-- Recent Orders -->
<div class="kpi-section">
    <h2>📋 Πρόσφατες Παραγγελίες</h2>
    <table id="recentOrdersTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Πελάτης</th>
                <th>Ημερομηνία</th>
                <th>Ποσό</th>
                <th>Κατάσταση</th>
                <th>Ενέργειες</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $recentOrdersQuery = "
                SELECT o.order_id, c.customer_name, o.order_date, o.total_amount, o.status
                FROM orders o
                JOIN customers c ON o.customer_id = c.customer_id
                ORDER BY o.order_date DESC
                LIMIT 5
            ";
            $result = executeQuery($conn, $recentOrdersQuery);
            
            while ($row = $result->fetch_assoc()) {
                $statusClass = strtolower(str_replace(' ', '-', $row['status']));
                echo "<tr>";
                echo "<td>" . $row['order_id'] . "</td>";
                echo "<td>" . $row['customer_name'] . "</td>";
                echo "<td>" . date('d/m/Y', strtotime($row['order_date'])) . "</td>";
                echo "<td>€" . number_format($row['total_amount'], 2) . "</td>";
                echo "<td><span class='badge badge-" . $statusClass . "'>" . $row['status'] . "</span></td>";
                echo "<td><a href='orders.php?view=" . $row['order_id'] . "' class='btn btn-primary'>Προβολή</a></td>";
                echo "</tr>";
            }
            ?>
        </tbody>
    </table>
</div>

<!-- Low Stock Alert -->
<div class="kpi-section">
    <h2>⚠️ Προϊόντα με Χαμηλό Απόθεμα</h2>
    <table id="lowStockTable">
        <thead>
            <tr>
                <th>Προϊόν</th>
                <th>Προμηθευτής</th>
                <th>Διαθέσιμο</th>
                <th>Ελάχιστο</th>
                <th>Κατάσταση</th>
            </tr>
        </thead>
        <tbody>
            <?php
            $lowStockQuery = "
                SELECT p.product_id, p.product_name, s.supplier_name, p.available_stock, p.reserved_stock, p.reorder_level
                FROM products p
                JOIN suppliers s ON p.supplier_id = s.supplier_id
                WHERE (p.available_stock - p.reserved_stock) <= p.reorder_level
                ORDER BY p.available_stock ASC
                LIMIT 10
            ";
            $result = executeQuery($conn, $lowStockQuery);
            
            while ($row = $result->fetch_assoc()) {
                $netStock = $row['available_stock'] - $row['reserved_stock'];
                echo "<tr>";
                echo "<td>" . $row['product_name'] . "</td>";
                echo "<td>" . $row['supplier_name'] . "</td>";
                echo "<td>" . $netStock . "</td>";
                echo "<td>" . $row['reorder_level'] . "</td>";
                echo "<td><span class='badge badge-danger'>ΧΑΜΗΛΟ</span></td>";
                echo "</tr>";
            }
            ?>
        </tbody>
    </table>
</div>

<script src="../assets/js/script.js"></script>

<?php include '../includes/footer.php'; ?>
