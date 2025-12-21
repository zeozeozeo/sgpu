struct VertexParams<T> {
    [[vk::offset(0)]]
    T* data;

    [ForceInline]
    T* get() { return data; }
};

struct PixelParams<T> {
    [[vk::offset(8)]]
    T* data;

    [ForceInline]
    T* get() { return data; }
};

struct ComputeParams<T> {
    [[vk::offset(16)]]
    T* data;

    [ForceInline]
    T* get() { return data; }
};
