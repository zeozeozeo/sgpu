Gpu_Pipeline :: #type,distinct u64;

Gpu_Texture :: #type,distinct u64;

Gpu_Depth_Stencil_State :: #type,distinct u64;

Gpu_Blend_State :: #type,distinct u64;

Gpu_Queue :: #type,distinct u64;

Gpu_Command_Buffer :: #type,distinct u64;

Gpu_Semaphore :: #type,distinct u64;

Gpu_Ptr :: #type,distinct u64;

Memory :: enum {
    DEFAULT;
    GPU;
    READBACK;
}

Cull :: enum {
    NONE;
    CCW;
    CW;
    ALL;
}

Depth_Flags :: enum_flags u8 {
    NONE    :: 0;
    READ    :: 1 << 0;
    WRITE   :: 1 << 1;
}

Op :: enum {
    NEVER;
    LESS;
    EQUAL;
    LESS_EQUAL;
    GREATER;
    NOT_EQUAL;
    GREATER_EQUAL;
    ALWAYS;
}

Stencil_Op :: enum {
    KEEP;
    ZERO;
    REPLACE;
    INVERT;
    INCREMENT_AND_CLAMP;
    DECREMENT_AND_CLAMP;
    INCREMENT_AND_WRAP;
    DECREMENT_AND_WARP;
}

Blend :: enum {
    ADD;
    SUBTRACT;
    REV_SUBTRACT;
    MIN;
    MAX;
}

Factor :: enum {
    ZERO;
    ONE;
    SRC_COLOR;
    DST_COLOR;
    SRC_ALPHA;
    DST_ALPHA;
    // #todo
}

Topology :: enum {
    TRIANGLE_LIST;
    TRIANGLE_STRIP;
    TRIANGLE_FAN;
}

Texture :: enum {
    _1D;
    _2D;
    _3D;
    CUBE;
    _2D_ARRAY;
    CUBE_ARRAY;
}

Format :: enum {
    NONE;
    // #todo
}

Usage_Flags :: enum {
    SAMPLED;
    STORAGE;
    COLOR_ATTACHMENT;
    DEPTH_STENCIL_ATTACHMENT;
    // #todo
}

Stage :: enum {
    TRANSFER;
    COMPUTE;
    RASTER_COLOR_OUT;
    PIXEL_SHADER;
    VERTEX_SHADER;
    // #todo:
}

Hazard_Flags :: enum {
    // #todo:
}

Signal :: enum {
    ATOMIC_SET;
    ATOMIC_MAX;
    ATOMIC_OR;
}

Stencil_Desc :: struct {
    test: Op = .ALWAYS;
    fail_op: Stencil_Op = .KEEP;
    pass_op: Stencil_Op = .KEEP;
    depth_fail_op: Stencil_Op = .KEEP;
    reference: u8 = 0;
}

Gpu_Depth_Stencil_Desc :: struct {
    depth_mode: Depth_Flags;
    depth_test: Op = .ALWAYS;

    depth_bias: float = 0.;
    depth_bias_slope_factor: float = 0.;
    depth_bias_clamp: float = 0.;

    stencil_read_mask: u8 = 0xff;
    stencil_write_mask: u8 = 0xff;

    stencil_front: Stencil_Desc;
    stencil_back: Stencil_Desc;
}

Color_Target :: struct {
    format: Format = .NONE;
    write_mask: u8 = 0xf;
}

Gpu_Raster_Desc :: struct {
    topology: Topology = .TRIANGLE_LIST;
    cull: Cull = .NONE;
    alpha_to_coverage := false;
    support_dual_source_blending := false;
    sample_count: u8 = 1;

    depth_format: Format = .NONE;
    stencil_format: Format = .NONE;
    
    color_targets: [] Color_Target;

    // #TODO: better way to convey Optional here.
    blend_state: *Gpu_Blend_State;
}

Gpu_Texture_Desc :: struct {
    type: Texture = ._2D;
    dimensions: [3] u32;

    mip_count: u32 = 1;
    layer_count: u32 = 1;
    sample_count: u32 = 1;

    format: Format = .NONE;
}

Gpu_View_Desc :: struct {
    format: Format = .NONE;
    base_mip: u8 = 0;
    mip_count: u8 = 0xFF; 
    base_layer: u16 = 0;
    layer_count: u16 = 0xFFFF;
}

Gpu_Render_Pass_Attachment_Desc :: struct {
    texture: Gpu_Texture;
    load_op: Op;
    store_op: Op;
    union {
        clear_value: float;
        clear_color: [3] u8;
    };
}

Gpu_Render_Pass_Desc :: struct {
    depth_target: Gpu_Render_Pass_Attachment_Desc;
    stencil_target: Gpu_Render_Pass_Attachment_Desc;
    color_targets: [] Gpu_Render_Pass_Attachment_Desc;
}

Memory_Layout :: struct {
    size: s64;
    align: s64;
}

// ----------------------------- Global ------------------------------------

gpu_init :: () {

}

gpu_shutdown :: () {

}

// ----------------------------- Memory ------------------------------------

// #todo: use similar convetions to jai allocators?
gpu_malloc :: (size: s64, align: s64 = 0, memory_type: Memory = .DEFAULT) -> *void {
    return null;
}

gpu_free :: (ptr: *void) {
}

gpu_host_to_device_ptr :: (host: *void) -> Gpu_Ptr {
    return 0;
}


// ----------------------------- Textures ------------------------------------

gpu_compute_texture_layout :: (desc: Gpu_Texture_Desc) -> Memory_Layout {
    return .{};
}

gpu_create_texture :: (desc: Gpu_Texture_Desc, gpu_ptr: *void) -> Gpu_Texture {
    return 0;
}

gpu_texture_view :: (texture: Gpu_Texture, desc: Gpu_View_Desc) -> Gpu_Texture {
    return 0;
}

gpu_rw_texture_view :: (texture: Gpu_Texture, desc: Gpu_View_Desc) -> Gpu_Texture {
    return 0;
}


// ----------------------------- Pipelines ------------------------------------

gpu_create_compute_pipeline :: (spirv: [] u8) -> Gpu_Pipeline {
    return 0;
}

gpu_create_graphics_pipeline :: (vertex_spirv: [] u8, pixel_spirv: [] u8, raster_desc: Gpu_Raster_Desc) -> Gpu_Pipeline {
    return 0;
}

gpu_free_pipeline :: (pipeline: Gpu_Pipeline) {

}

// ----------------------------- Queues ------------------------------------

gpu_create_queue :: () -> Gpu_Queue {
    return 0;
}

gpu_start_command_recording :: (queue: Gpu_Queue) -> Gpu_Command_Buffer {
    return 0;
}

gpu_submit :: (queue: Gpu_Queue, buffers: [] Gpu_Command_Buffer) {

}

// ----------------------------- Semaphores ------------------------------------

gpu_create_semaphore :: (initial: u64) -> Gpu_Semaphore {
    return 0;
}

gpu_wait_semaphore :: (semaphore: Gpu_Semaphore, value: u64) {

}

gpu_destroy_semaphore :: (semaphore: Gpu_Semaphore) {

}

// ----------------------------- Commands ------------------------------------

gpu_memcpy :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr) {

}

gpu_copy_to_texture :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr, texture: Gpu_Texture) {

}

gpu_copy_from_texture :: (cmd: Gpu_Command_Buffer, dest: Gpu_Ptr, src: Gpu_Ptr, texture: Gpu_Texture) {

}


gpu_barrier :: (cmd: Gpu_Command_Buffer, before: Stage, after: Stage) {

}

gpu_signal_after :: (cmd: Gpu_Command_Buffer, before: Stage, ptr: Gpu_Ptr, value: u64, signal: Signal) {
    
}

gpu_wait_before :: (cmd: Gpu_Command_Buffer, after: Stage, ptr: Gpu_Ptr, value: u64, op: Op, signal: Signal) {
    
}


gpu_set_pipeline :: (cmd: Gpu_Command_Buffer, pipeline: Gpu_Pipeline) {

}

gpu_set_depth_stencil_state :: (cmd: Gpu_Command_Buffer, state: Gpu_Depth_Stencil_State) {

}

gpu_set_blend_state :: (cmd: Gpu_Command_Buffer, state: Gpu_Blend_State) {

}

gpu_dispatch :: (cmd: Gpu_Command_Buffer, dimensions: [3] u32) {

}

gpu_indirect_dispatch :: (cmd: Gpu_Command_Buffer, dimensions_gpu: Gpu_Ptr) {

}

gpu_begin_render_pass :: (cmd: Gpu_Command_Buffer, desc: Gpu_Render_Pass_Desc) {

}

gpu_end_render_pass :: (cmd: Gpu_Command_Buffer) {

}

gpu_draw_indexed_instanced :: (cmd: Gpu_Command_Buffer, vertex_data: Gpu_Ptr, index_data: Gpu_Ptr, index_count: u32, instance_count: u32) {

}



#scope_module

vk :: #import "Vulkan_With_VMA";