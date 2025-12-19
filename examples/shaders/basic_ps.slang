struct PS_Input {
}

struct Push_Consts {
    // nothing for now
};

[vk::push_constant]
Push_Consts pc;

[shader("pixel")]
float4 main(PS_Input input) : SV_Target0 {
    return float4(1, 0, 0, 1.);
}