#include <iostream>
#include <cuda_runtime.h>
#include <chrono>

#define N 1000000  // Vector size

using namespace std;
using namespace std::chrono;

// CUDA kernel for vector addition
__global__ void vectorAdd(float *A, float *B, float *C, int n) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    if (i < n) {
        C[i] = A[i] + B[i];
    }
}

// Function to run vector addition on GPU
void gpuVectorAdd(float *A, float *B, float *C, int n) {
    float *d_A, *d_B, *d_C;
    size_t size = n * sizeof(float);

    // Allocate memory on GPU
    cudaMalloc(&d_A, size);
    cudaMalloc(&d_B, size);
    cudaMalloc(&d_C, size);

    // Copy data from CPU to GPU
    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

    // Define grid and block size
    int threadsPerBlock = 256;
    int blocksPerGrid = (n + threadsPerBlock - 1) / threadsPerBlock;

    // Start timing
    auto start = high_resolution_clock::now();

    // Launch kernel
    vectorAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, n);

    // Synchronize to ensure completion
    cudaDeviceSynchronize();

    // End timing
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start);
    cout << "GPU Execution Time: " << duration.count() << " µs" << endl;

    // Copy result back to CPU
    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

    // Free GPU memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
}

// CPU Implementation
void cpuVectorAdd(float *A, float *B, float *C, int n) {
    auto start = high_resolution_clock::now();
    
    for (int i = 0; i < n; i++) {
        C[i] = A[i] + B[i];
    }
    
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start);
    cout << "CPU Execution Time: " << duration.count() << " µs" << endl;
}

// Main function
int main() {
    float *A, *B, *C_cpu, *C_gpu;
    A = new float[N];
    B = new float[N];
    C_cpu = new float[N];
    C_gpu = new float[N];

    // Initialize arrays with random values
    for (int i = 0; i < N; i++) {
        A[i] = static_cast<float>(rand()) / RAND_MAX;
        B[i] = static_cast<float>(rand()) / RAND_MAX;
    }

    // Run CPU addition
    cpuVectorAdd(A, B, C_cpu, N);

    // Run GPU addition
    gpuVectorAdd(A, B, C_gpu, N);

    // Verify correctness
    bool correct = true;
    for (int i = 0; i < N; i++) {
        if (abs(C_cpu[i] - C_gpu[i]) > 1e-5) {
            correct = false;
            break;
        }
    }

    if (correct) {
        cout << "Results are CORRECT!" << endl;
    } else {
        cout << "Results MISMATCH!" << endl;
    }

    // Cleanup
    delete[] A;
    delete[] B;
    delete[] C_cpu;
    delete[] C_gpu;

    return 0;
}
