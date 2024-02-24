CC=gcc
CFLAGS=-I./calculator

# Specify the directory where your source files are located
SRC_DIR=./calculator

# Specify the output directory for the executable
OUT_DIR=./calculator

# Define object files with the directory
OBJ = $(SRC_DIR)/main.o $(SRC_DIR)/addition.o $(SRC_DIR)/subtraction.o $(SRC_DIR)/multiplication.o $(SRC_DIR)/division.o

# Specify where your header files are, if necessary
DEPS = $(SRC_DIR)/operations.h

# Rule to make the executable, naming it calculator to avoid conflicts
calculator: $(OBJ)
	$(CC) -o $(OUT_DIR)/$@ $^ $(CFLAGS)

# Rule to compile each source file to an object file
$(SRC_DIR)/%.o: $(SRC_DIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

# Clean rule
clean:
	rm -f $(SRC_DIR)/*.o $(OUT_DIR)/calculator
