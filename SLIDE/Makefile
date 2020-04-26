TARGET  := runme

CUDAOBJDIR = cudaobjs

CUDASOURCES := $(wildcard *.cu)
CUDAOBJS := $(CUDASOURCES:%.cu=$(CUDAOBJDIR)/%.o)

CPPOBJDIR = cppobjs

CPPSOURCES := $(wildcard *.cpp)
CPPOBJS := $(CPPSOURCES:%.cpp=$(CPPOBJDIR)/%.o)

COBJDIR = cobjs

CSOURCES := $(wildcard *.c)
COBJS := $(CSOURCES:%.c=$(COBJDIR)/%.o)

OBJS = $(CPPOBJS) $(COBJS) $(CUDAOBJS)

#OPT_FLAGS   := -fno-strict-aliasing -O2 -fopenmp #-march=skylake -mtune=intel -mavx2 -mavx512f
OPT_FLAGS   := -fno-strict-aliasing -g -O3 -fopenmp -mtune=intel -mavx2

INC := /usr/include/

LIB += -fPIC -fopenmp -L /slide/cnpy/build/ -lcnpy -lz -L$(TACC_CUDA_DIR)/lib64/ -lcudart -Wl,-rpath=$(TACC_CUDA_DIR)/lib64

CXXFLAGS := -m64  -DUNIX -I /slide/cnpy/ -lcnpy -lz -std=c++11 $(WARN_FLAGS) $(OPT_FLAGS) -I$(INC)
CFLAGS := -m64 -DUNIX -I /slide/cnpy/ -lcnpy -lz $(WARN_FLAGS) $(OPT_FLAGS) -I$(INC)
CUFLAGS := -O3 -m64 -gencode arch=compute_61,code=sm_61 -I.

LDFLAGS := $(LIBRARY_PATH) $(LIB)

.PHONY: clean

$(TARGET): $(CUDAOBJDIR) $(CPPOBJDIR) $(COBJDIR) $(CUDAOBJS) $(CPPOBJS) $(COBJS)
	g++ -o $(TARGET) $(OBJS) $(LDFLAGS)

$(CUDAOBJS): $(CUDAOBJDIR)/%.o: %.cu
	@echo "compile $@ $<"
	nvcc -ccbin=g++ $(CUFLAGS) -c $< -o $@

$(CPPOBJS): $(CPPOBJDIR)/%.o: %.cpp
	@echo "compile $@ $<"
	g++ -fPIC $(CXXFLAGS) -c $< -o $@

$(COBJS): $(COBJDIR)/%.o: %.c
	@echo "compile $@ $<"
	gcc -fPIC $(CFLAGS) -c $< -o $@

$(CUDAOBJDIR):
	@ mkdir -p $(CUDAOBJDIR)
        
$(CPPOBJDIR):   
	@ mkdir -p $(CPPOBJDIR)
        
$(COBJDIR):     
	@ mkdir -p $(COBJDIR)

clean:
	$(RM) $(TARGET) $(OBJ)
	$(RM) -rf $(CUDAOBJDIR)
	$(RM) -rf $(CPPOBJDIR)
	$(RM) -rf $(COBJDIR)
