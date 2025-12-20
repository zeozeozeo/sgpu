#scope_export

Gpu_Arena :: struct {
    cpu: *void;
    gpu: Gpu_Ptr;
    size: s64;

    head: s64;
}

gpu_make_arena :: (size: s64) -> Gpu_Arena {
    cpu, gpu := gpu_malloc(size);

    return .{cpu = cpu, gpu = gpu, size = size};
}

gpu_arena_alloc :: (arena: *Gpu_Arena, $type: Type) -> *type, Gpu_Ptr {
    alignment := calculate_alignment(type);
    size := size_of(type);
    aligned_size := align_forward(size, alignment);

    cpu := arena.cpu + arena.head;
    gpu := arena.gpu + arena.head.(Gpu_Ptr);
    arena.head += aligned_size;
    return cpu.(*type), gpu;
}

gpu_reset_arena :: (arena: *Gpu_Arena) {
    arena.head = 0;
}

gpu_free_arena :: (arena: Gpu_Arena) {
    gpu_free(arena.cpu);
}

#scope_module

calculate_alignment :: ($type: Type) -> s64 {
    return max(vk_physical_device_properties.properties.limits.minStorageBufferOffsetAlignment.(s64), size_of(type));
}
