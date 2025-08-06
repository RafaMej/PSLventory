# PSLventory
# 📌 Funcionalidades Implementadas

## 📦 Inventario
- Lista todos los artículos con disponibilidad en tiempo real  
- Búsqueda por nombre o categoría  
- Indicadores visuales de disponibilidad (**verde / naranja / rojo**)  
- Agregar nuevos artículos con categorías predefinidas  

## 👥 Sistema de Préstamos
- Prestar artículos con información del solicitante  
- Ver quién tiene qué artículo y desde cuándo  
- Proceso de devolución simple  
- Historial completo de préstamos  

## 📊 Estadísticas
- Total de artículos y disponibilidad  
- Préstamos activos vs devueltos  
- Estadísticas por categoría  
- Tasa de utilización del inventario  

---

# ⚙️ Características Técnicas
✅ **SwiftUI nativo** – Interfaz moderna y responsiva  
✅ **Firebase Firestore** – Base de datos en tiempo real  
✅ **Arquitectura MVVM** – Código bien estructurado  
✅ **Navegación por tabs** – Fácil acceso a todas las secciones  
✅ **Búsqueda en tiempo real** – Encuentra artículos rápidamente  
✅ **Validación de formularios** – Previene errores de entrada  

---

# 🚀 Para implementar la app

## 1️⃣ Configura Firebase
1. Crea un proyecto en **Firebase Console**  
2. Agrega la app iOS con tu *bundle identifier*  
3. Descarga `GoogleService-Info.plist` y agrégalo al proyecto  

## 2️⃣ Instala dependencias
En **Swift Package Manager**, agrega:  
https://github.com/firebase/firebase-ios-sdk

## 3️⃣ Estructura de datos en Firestore
- **Colección `items`** → almacena el inventario  
- **Colección `loans`** → almacena los préstamos  
