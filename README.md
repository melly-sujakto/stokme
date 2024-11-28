# StokMe - Point of Sales App



![image](https://github.com/user-attachments/assets/211f6c74-99ab-4c32-96fa-697eac1c194f)

**StokMe** is a mobile app designed to simplify inventory and sales management for small to medium-sized businesses. The app includes features like stock entry, sales transactions, product management, supplier management, and more. StokMe also supports Bluetooth thermal printer integration and barcode scanning through the device's camera.

---

## Features:
- **Sales Management**: Record and manage sales transactions.
- **Stock Management**: Track stock levels, entry, and movement.
- **Product Management**: Manage products with pricing, description, and stock details.
- **Supplier Management**: Maintain and update supplier information.
- **Bluetooth Thermal Printer**: Print receipts using a Bluetooth thermal printer.
- **Barcode Scanning**: Use the mobile camera to scan product barcodes (not for QRIS).

---

## Technologies Used:
- **Mobile Platform**: Flutter
- **Database**: Firebase

---

## Installation

To run the project locally, follow these steps:

1. **Install the dependencies**:
    ```bash
    cd app
    make install-dependencies
    ```

2. **Run the app** on an emulator or physical device:
    ```bash
    flutter run
    ```

---

## Usage

1. Open the app and log in (if authentication is implemented).
2. Navigate to the **Sales** tab to make sales transactions.
3. Use the **Stock** tab to manage your product inventory.
4. Connect a Bluetooth thermal printer to print receipts.
5. Use the **Camera** to scan barcodes for quick product entry.

---

## To-Do List:
- **Bluetooth Scanner Integration**: Integrate Bluetooth barcode scanners for faster product identification.
- **PDF Exporter**: Implement PDF export functionality for transaction receipts and stock reports.
- **Product Discount Feature**: Add a discount option for products during the sales transaction process.

---

## Contributing

We welcome contributions to make StokMe better! If you'd like to contribute, please follow these steps:

1. Fork this repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to your fork (`git push origin feature-name`).
5. Create a pull request!

---

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---
