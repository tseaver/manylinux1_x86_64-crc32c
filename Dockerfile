FROM quay.io/pypa/manylinux1_x86_64

RUN /opt/python/cp39-cp39/bin/python -m pip install --upgrade setuptools pip wheel \
 && /opt/python/cp39-cp39/bin/python -m pip install cmake auditwheel

RUN git clone https://github.com/google/crc32c \
 && cd crc32c \
 && git submodule update --init --recursive \
 && mkdir build \
 && cd build \
 && /opt/python/cp39-cp39/bin/cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCRC32C_BUILD_TESTS=no \
        -DCRC32C_BUILD_BENCHMARKS=no \
        -DBUILD_SHARED_LIBS=yes \
        .. \
 && make all install

CMD ["/bin/bash"]
