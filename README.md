
# Laboratorio: Operaciones con Cadenas y Aritmética en NASM 

* **Estudiante:** Juan Carlos Barajas Quintero 
* **Curso:** Arquitectura de Computadores - Unidad 8
* **Institución:** Universidad Francisco de Paula Santander

## Descripción General
Este laboratorio consiste en el diseño e implementación de programas en lenguaje ensamblador **NASM** para el entorno **DOSBox**. El objetivo principal es dominar el procesamiento de cadenas mediante instrucciones especializadas, verificando el comportamiento de los registros de índice (`SI`, `DI`), el registro de conteo (`CX`) y el flag de dirección (`DF`).

### Entorno de Trabajo
Para el cumplimiento de los objetivos, se utilizó el siguiente software y versiones:
*   **Emulador:** DOSBox 0.74+.
*   **Ensamblador:** NASM versión 2.14+.
*   **Control de Versiones:** Git para la gestión del repositorio.
*   **Editor de Texto:** VS code para la escritura de los archivos .asm.

## Diseño del Laboratorio
El diseño se divide en tres módulos fundamentales de procesamiento de datos en memoria:

### 1. Copia de Bloques de Memoria (REP MOVSB/MOVSW)
Se implementa la transferencia de datos desde una cadena de origen hacia un buffer de destino.
*   **Diseño:** Se preparan los registros de segmento `DS` y `ES` para que apunten al mismo segmento (formato .com).
*   **Optimización:** El diseño incluye una transición de `MOVSB` (post1a.asm) (byte por byte) a `MOVSW` (post1b.asm) (word por word) para mejorar la eficiencia en cadenas de longitud par, manejando el byte sobrante de forma condicional.

### 2. Búsqueda de Caracteres (REPNE SCASB)
Se diseña una rutina para localizar la posición de un carácter específico dentro de una cadena de texto.
*   **Mecánica:** La instrucción escanea la memoria comparando el registro `AL` con el contenido en `ES:DI` mientras no haya coincidencia (`ZF=0`).
*   **Resultado:** El programa calcula la posición base-0 restando el puntero actual del inicio de la cadena.

### 3. Comparación de Cadenas (REPE CMPSB)
Se implementa una lógica de validación para determinar si dos bloques de memoria son idénticos.
*   **Mecánica:** Compara byte a byte `DS:SI` con `ES:DI` mientras los valores sean iguales (`ZF=1`).
*   **Validación:** El diseño permite identificar el punto exacto donde dos cadenas difieren al detenerse la ejecución del prefijo `REPE`.

## Instrucciones de Compilación y Ejecución
Para compilar y ejecutar cualquiera de los módulos, utilice los siguientes comandos en la consola de DOSBox:

```bash
nasm -f bin nombre_archivo.asm -o nombre_archivo.com (En consola del host)
nombre_archivo.com (En DOSBox)
```
