# 📚 Book Management System – ASP.NET Web Forms MVP/Prototype  
**06/2025 · Standalone Development** | Desarrollo Independiente  

<br>

**Título en español**: Sistema de Gestión de Libros – MVP/Prototipo de ASP.NET Web Forms

<br><br>

## 🧩 Overview | Visión General

<br>

_general image_

<br><br>

**EN**  
Designed for educational and prototype-level use, showcasing practical proficiency in C# and ASP.NET for small-scale web applications. 

Book Management System is a compact ASP.NET Web Forms application built in C# for managing books, authors, and categories. Developed in just a few hours to showcase clean architecture, functional CRUD operations, and practical proficiency in small-scale web development.  

<br>

**ES**  
Diseñado con fines educativos y para uso a nivel de prototipo, demostrando competencia práctica en C# y ASP.NET para aplicaciones web de pequeña escala.  

Book Management System es una aplicación compacta en ASP.NET Web Forms desarrollada en C# para gestionar libros, autores y categorías de libros. Fue creada en pocas horas para demostrar arquitectura limpia, operaciones CRUD funcionales y competencia práctica en desarrollo web de pequeña escala.  

---

<br>

## 🧱 System Architecture | Arquitectura del sistema

<br>

- Built with ASP.NET Web Forms and C#, using a clean separation between presentation and logic layers. <br> _Construido con ASP.NET Web Forms y C#, con separación clara entre capas de presentación y lógica._

- Database management via Microsoft SQL Server Management Studio (SSMS). <br> _Gestión de bases de datos utilizando Microsoft SQL Server Management Studio (SSMS)._

- Structured for rapid deployment and easy maintenance in small-scale environments. <br> _Estructurado para despliegue rápido y mantenimiento sencillo en entornos reducidos._

<br><br>

## 📦 Core Modules | Módulos principales

<br>

- **Books** | **Libros** <br><br> Registration, editing, and deletion of book records. <br>_Registro, edición y eliminación de libros._

- **Authors** | **Autores** <br><br> Basic author management and association with books. <br>_Gestión básica de autores y asociación con libros._

- **Categories** | **Categorías** <br><br> Classification of books by genre or type. <br>_Clasificación de libros por género o tipo._

- **Navigation & Layout** | **Navegación y diseño** <br><br> Simple, intuitive page flow for CRUD operations. <br>_Flujo de páginas simple e intuitivo para operaciones CRUD._

<br><br>

## 🖥️ User Interface & UX | Interfaz de usuario y experiencia

<br>

- Functional layout using ASP.NET controls and server-side rendering. <br>_Diseño funcional con controles de ASP.NET y renderizado del lado del servidor._

- Minimalist design focused on clarity and ease of use. <br>_Diseño minimalista enfocado en claridad y facilidad de uso._

- Rapid form-based workflows for data entry and update. <br>_Flujo rápido basado en formularios para ingreso y actualización de datos._

<br><br>

## 🗄️ Database Management | Gestión de Base de Datos

<br>

**EN** <br>
The system uses Microsoft SQL Server Management Studio (SSMS) for database creation, configuration, and maintenance. All tables (Books, Authors, Categories) are manually defined and linked via foreign keys to ensure relational integrity. The database schema is lightweight and optimized for educational or prototype-level use.

<br>

**ES** <br>
El sistema utiliza Microsoft SQL Server Management Studio (SSMS) para la creación, configuración y mantenimiento de la base de datos. Todas las tablas (Libros, Autores, Categorías) están definidas manualmente y vinculadas mediante claves foráneas para garantizar la integridad relacional. El esquema de base de datos es liviano y está optimizado para fines educativos o de prototipo.

<br><br>

### 📂 Tables & Relationships | Tablas y relaciones

<br>

- **Books:** Includes title, author ID, category ID, and publication year. <br> **Libros:** _Incluye título, ID de autor, ID de categoría y año de publicación._

- **Authors:** Stores author names and identifiers. <br> **Autores:** _Almacena nombres e identificadores de autores._

- **Categories:** Defines genre or classification types. <br> **Categorías:** _Define géneros o tipos de clasificación._

<br><br>

## 📝 File-Based Logging | Registro en Archivos

<br>

**EN** <br>
Every time a CRUD operation is performed —whether adding, editing, or deleting a book, author, or category— the system logs the action to a local text file. This provides a simple audit trail for tracking user interactions and system behavior.

<br>

**ES** <br>
Cada vez que se realiza una operación CRUD (ya sea altas, modificaciones o bajas de libros, autores o categorías) el sistema registra la acción en un archivo de texto local. Esto proporciona una trazabilidad básica para monitorear interacciones del usuario y el comportamiento del sistema.

<br><br>

### 📄 Log Format | Formato del registro

<br>

- Timestamp of the operation. <br>_Marca de tiempo de la operación._

- Type of action (Create, Update, Delete). <br>_Tipo de acción (Alta, Modificación, Baja)._

- Entity affected (Book, Author, Category). <br>_Entidad afectada (Libro, Autor, Categoría._

- Record details (e.g., title, ID). <br>_Detalles del registro (por ejemplo, título, ID)._

<br><br>

### 📁 Log Location | Ubicación del archivo

<br>

- Logs are stored in a dedicated folder within the project directory (e.g., `/Logs/`). <br> _Los registros se almacenan en una carpeta dedicada dentro del directorio del proyecto (por ejemplo, `/Logs/`)._

- Each log entry is appended to the file to preserve history. <br> _Cada entrada se agrega al archivo para preservar el historial._

<br>

> This feature is ideal for educational QA, debugging, or internal audit simulation. <br><br>
> Esta funcionalidad es ideal para QA educativo, depuración o simulación de auditoría interna.

<br><br>

## 📐 Modeling & Documentation | Modelado y documentación

<br>

- Clear naming conventions. <br>_Convenciones de nombres claras._

- Logical structure for maintainability and expansion. <br>_Estructura lógica para mantenimiento y expansión._

- Designed for educational or prototype-level use cases. <br>_Diseñado para casos educativos o de prototipo._

<br><br>

## 🧪 Testing & Quality Assurance | Pruebas y aseguramiento de calidad

<br>

- Manual validation of CRUD operations and navigation flow. <br>_Validación manual de operaciones CRUD y flujo de navegación._

- Error handling for basic form inputs and data integrity. <br>_Manejo de errores en formularios básicos y validación de integridad._

- Lightweight footprint ideal for quick demonstrations or internal tools. <br>_Huella ligera ideal para demostraciones rápidas o herramientas internas._

<br><br>

## 🌀 Development Methodology | Metodología de desarrollo

<br>

- Completed in a focused sprint over a few hours. <br>_Completado en un sprint enfocado de pocas horas._

- Prioritized simplicity, clarity, and functional completeness. <br>_Se priorizó la simplicidad, claridad y completitud funcional._

- Demonstrates proficiency in ASP.NET and C# for small-scale web applications. <br>_Demuestra competencia en ASP.NET y C# para aplicaciones web pequeñas._

---

<br>

## 📺 Demo & Screenshots | Demo y capturas

<br>

### 🧭 Main Menu | Menu Principal

_aquí_

<br>

### 📚 Books Module | Módulo de Libros

_aquí_

<br>

### 👥 Authors Module | Módulo de Autores

_aquí_

<br>

### 🗂️ Categories Module | Módulo de Categorías

_aquí_

---

<br>

## 🛠️ Tech Stack | Tecnologías Utilizadas

<br>

**EN** <br>
This project is built using a classic ASP.NET Web Forms architecture, ideal for demonstrating CRUD operations, modular design, and basic logging - among other things. It integrates front-end and back-end components with a focus on maintainability and educational clarity.

<br>

**ES** <br>
Este proyecto está construido con una arquitectura clásica de ASP.NET Web Forms, ideal para demostrar operaciones CRUD, diseño modular y registro básico, entre otras cosas. Integra componentes de frontend y backend con enfoque en mantenibilidad y claridad educativa.

<br><br>

### 🔧 Core Technologies | Tecnologías principales

<br>

| Layer / Capa        | Technology / Tecnología                          | Purpose / Propósito                                      |
|---------------------|--------------------------------------------------|-----------------------------------------------------------|
| Frontend            | HTML, CSS, JavaScript                            | UI rendering, styling, and basic interactivity            |
| Backend             | C# in ASP.NET Web Forms (.NET Framework)         | Server-side logic, page lifecycle, event handling         |
| Database            | Microsoft SQL Server (SSMS)                      | Relational data storage and management                    |
| Logging             | File-based logging (TXT)                         | Local audit trail of CRUD operations                      |
| IDE / Editor        | Visual Studio                                    | Development, debugging, and deployment                    |
| Hosting (local)     | IIS Express / Localhost                          | Runtime environment for testing and demo                  |

---

<br>

## 📄 License | Licencia

<br>

**MIT License.** Extremely permissive. Allows use, modification, distribution, and private/commercial use. Requires attribution.

Copyright (c) 2025 Nicolás D. Servidio

---

<br>

## 🤝 Contact | Contacto

<br>

**Nicolás D. Servidio**  
📧 nicolasservidio.dm@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/nicolas-servidio-del-monte) · [GitHub](https://github.com/nicolasservidio)

---
