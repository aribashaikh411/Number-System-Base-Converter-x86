# x86 Assembly: Number System Base Converter

A low-level utility developed in x86 Assembly (MASM) designed to perform seamless, high-performance conversions between various numeric bases. By utilizing the Irvine32 library and centering all operations around the EAX register, 
the system ensures hardware-level efficiency and reliable data transformation.

## Key Features

Multi-Base Support: Seamlessly handles input and output for Binary, Octal, Decimal, and Hexadecimal formats.
Universal Intermediary Processing: Centralizes all conversion logic within the 32-bit **EAX register** to maintain data integrity across different bases.
Modular Architecture: Built with independent procedures for parsing and formatting, ensuring a scalable and maintainable codebase.
Interactive Menu System: Provides a user-friendly command-line interface for selecting input/output bases and viewing results in real-time.
## Technical Implementation

Language: x86 Assembly (MASM).
Library: Irvine32.inc.
Registers: Strategic use of EAX for arithmetic and EBX/ECX for loop control and pointer management.
Core Algorithms:
Polynomial Expansion: Used for parsing string-based inputs into numeric values.
Successive Division: Implemented for formatting numeric values into target base strings.
Bit Manipulation: Utilized `SHL` and `SHR` instructions for optimized binary and octal transformations.

