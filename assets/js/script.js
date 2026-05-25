/* JavaScript Functions */

// Validation Functions
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function validatePhone(phone) {
    const phoneRegex = /^[\d\s\-\+\(\)]{10,}$/;
    return phoneRegex.test(phone);
}

function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return false;

    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    for (let input of inputs) {
        if (input.value.trim() === '') {
            alert('Παρακαλώ συμπληρώστε όλα τα υποχρεωτικά πεδία!');
            input.focus();
            return false;
        }
    }
    return true;
}

// Format Currency
function formatCurrency(value) {
    return new Intl.NumberFormat('el-GR', {
        style: 'currency',
        currency: 'EUR'
    }).format(value);
}

// Format Date
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('el-GR', options);
}

// Show/Hide Elements
function toggleElement(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.style.display = element.style.display === 'none' ? 'block' : 'none';
    }
}

// Filter Table
function filterTable(tableId, searchInputId) {
    const input = document.getElementById(searchInputId);
    const table = document.getElementById(tableId);
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    input.addEventListener('keyup', function() {
        const filter = input.value.toUpperCase();
        for (let row of rows) {
            let text = row.textContent.toUpperCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        }
    });
}

// Sort Table
function sortTable(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    const rows = Array.from(table.querySelectorAll('tbody tr'));
    const isAscending = table.dataset.sortOrder !== 'asc';

    rows.sort((a, b) => {
        const aValue = a.cells[columnIndex].textContent.trim();
        const bValue = b.cells[columnIndex].textContent.trim();

        if (!isNaN(aValue) && !isNaN(bValue)) {
            return isAscending ? aValue - bValue : bValue - aValue;
        }
        return isAscending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue);
    });

    table.dataset.sortOrder = isAscending ? 'asc' : 'desc';
    const tbody = table.querySelector('tbody');
    rows.forEach(row => tbody.appendChild(row));
}

// Calculate Total
function calculateTotal(quantityId, priceId, totalId) {
    const quantity = document.getElementById(quantityId)?.value || 0;
    const price = document.getElementById(priceId)?.value || 0;
    const total = quantity * price;
    
    if (document.getElementById(totalId)) {
        document.getElementById(totalId).value = total.toFixed(2);
    }
}

// Delete Confirmation
function confirmDelete(message = 'Είστε σίγουρος;') {
    return confirm(message);
}

// Export to CSV
function exportTableToCSV(tableId, filename) {
    const table = document.getElementById(tableId);
    let csv = [];
    
    // Add headers
    const headers = table.querySelectorAll('th');
    let headerRow = [];
    headers.forEach(header => {
        headerRow.push(header.textContent.trim());
    });
    csv.push(headerRow.join(','));

    // Add rows
    const rows = table.querySelectorAll('tbody tr');
    rows.forEach(row => {
        let rowData = [];
        row.querySelectorAll('td').forEach(cell => {
            rowData.push('"' + cell.textContent.trim() + '"');
        });
        csv.push(rowData.join(','));
    });

    // Create download link
    const csvContent = csv.join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename || 'export.csv';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

// Print Page
function printPage(elementId) {
    const content = document.getElementById(elementId);
    const printWindow = window.open('', '', 'height=600,width=800');
    printWindow.document.write(content.innerHTML);
    printWindow.document.close();
    printWindow.print();
}

// Alert Functions
function showSuccessAlert(message) {
    const alert = document.createElement('div');
    alert.className = 'alert alert-success';
    alert.textContent = message;
    document.querySelector('.container').insertBefore(alert, document.querySelector('.container').firstChild);
    setTimeout(() => alert.remove(), 3000);
}

function showErrorAlert(message) {
    const alert = document.createElement('div');
    alert.className = 'alert alert-danger';
    alert.textContent = message;
    document.querySelector('.container').insertBefore(alert, document.querySelector('.container').firstChild);
    setTimeout(() => alert.remove(), 3000);
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded - The Supplier Manager');
});
