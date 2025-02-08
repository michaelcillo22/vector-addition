# Compiler and Flags
NVCC = nvcc
ARCH = -arch=sm_86  # Adjust based on your GPU (RTX 30 series uses sm_86)
CFLAGS = -std=c++11 -Xcompiler -fopenmp
LDFLAGS = -lcublas -lcudart

# Executable name
TARGET = vector_addition

# Source files
SRC = vector_addition.cu
OBJ = $(SRC:.cu=.o)

# Default build target
all: $(TARGET)

# Compile CUDA source file into an object file
%.o: %.cu
	$(NVCC) $(ARCH) $(CFLAGS) -c $< -o $@

# Link object files to create executable
$(TARGET): $(OBJ)
	$(NVCC) $(ARCH) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Run the executable
run: $(TARGET)
	./$(TARGET)

# Clean up build files
clean:
	rm -f $(OBJ) $(TARGET)
