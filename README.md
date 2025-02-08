cuda_vector_addition/
│── src/
│   ├── vector_addition.cu   # CUDA source file
│── Makefile                 # (Optional) For easier compilation
│── README.md                # (Optional) Project description


# CUDA Vector Addition Experiment

This project is a simple **CUDA-based vector addition** program designed to test GPU computation and CUDA environment setup.

## **Overview**
This experiment performs element-wise addition of two vectors using NVIDIA's CUDA parallel computing framework. The goal is to:
- Understand CUDA kernel execution.
- Compare CPU vs. GPU execution for vector addition.
- Ensure that CUDA and the necessary compilers are properly configured.

## **Prerequisites**
Before running this project, ensure you have:
- **NVIDIA GPU** (with CUDA Compute Capability 7.5 or higher recommended).
- **CUDA Toolkit 12.8** (or compatible version).
- **NVIDIA GPU Drivers** (updated and compatible with CUDA 12.8).
- **Visual Studio 2022 with C++ Build Tools**.

## **Project Structure**
```
/cuda-vector-addition/
│── src/
│   ├── vector_addition.cu  # CUDA source code
│   ├── Makefile (optional) # Build automation script
│── README.md               # This document
```

## **Compiling the CUDA Program (double check your path and version)**
Navigate to the project directory and run the following command to compile the CUDA source code:

```sh
nvcc -ccbin "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.39.33519\bin\Hostx64\x64" vector_addition.cu -o vector_addition.exe -arch=sm_86
```

If you experience compilation errors, try:
- Running in the **x64 Native Tools Command Prompt for VS 2022**.
- Checking that **Visual Studio C++ Build Tools** are installed.
- Updating your **NVIDIA driver** and **CUDA Toolkit**.

## **Running the Program**
After a successful compilation, execute the program:

```sh
./vector_addition.exe
```

## **Expected Output**
The program should display output similar to:
```
Vector Addition Completed Successfully!
```
If an error occurs, check for:
- Incorrect CUDA installation.
- Missing or outdated drivers.
- Memory access issues in the CUDA kernel.

## **Troubleshooting**
1. **Check CUDA installation:**
   ```sh
   nvcc --version
   ```
2. **Check GPU availability:**
   ```sh
   nvidia-smi
   ```
3. **Run a simple CUDA test:**
   ```sh
   nvcc test.cu -o test.exe && ./test.exe
   ```

## **License**
This project is open-source and available for educational purposes.

---
🚀 Happy coding with CUDA! If you run into issues, feel free to tweak your setup and debug step-by-step. 🚀

