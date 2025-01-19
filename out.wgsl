struct type_5 {
    member: vec4<f32>,
    member_1: vec4<f32>,
    member_2: vec4<f32>,
    member_3: vec4<f32>,
}

struct type_6 {
    member: type_5,
    member_1: type_5,
    member_2: vec4<f32>,
    member_3: vec4<f32>,
}

struct type_7 {
    member: type_6,
}

struct type_11 {
    member: vec2<f32>,
    member_1: vec2<u32>,
}

struct type_12 {
    member: type_11,
}

struct type_23 {
    member: u32,
}

struct type_24 {
    member: type_23,
}

struct type_26 {
    member: vec4<f32>,
    member_1: vec4<f32>,
    member_2: vec4<f32>,
    member_3: vec4<f32>,
    member_4: vec4<f32>,
}

struct type_28 {
    member: array<type_26>,
}

struct type_31 {
    member: vec3<f32>,
    member_1: vec3<f32>,
    member_2: vec2<f32>,
    member_3: vec2<u32>,
}

var<private> global: vec3<u32>;
@group(0) @binding(0) 
var<uniform> global_1: type_7;
@group(0) @binding(1) 
var<uniform> global_2: type_12;
var<push_constant> global_3: type_24;
@group(0) @binding(2) 
var<storage> global_4: type_28;
@group(0) @binding(3) 
var global_5: texture_2d<f32>;
@group(0) @binding(4) 
var global_6: sampler;
@group(0) @binding(5) 
var global_7: texture_storage_2d<rgba32float,read_write>;

fn function() {
    var phi_1068_: f32;
    var phi_1071_: u32;
    var phi_1072_: u32;
    var phi_5195_: f32;
    var phi_5221_: f32;
    var phi_1125_: f32;
    var phi_1127_: f32;
    var phi_1128_: bool;
    var phi_1129_: bool;
    var phi_1130_: vec3<f32>;
    var phi_1131_: vec2<f32>;
    var phi_1069_: f32;
    var phi_1132_: bool;
    var phi_1133_: bool;
    var phi_1134_: bool;
    var local: bool;
    var local_1: vec3<f32>;
    var local_2: vec3<f32>;
    var local_3: vec3<f32>;
    var local_4: vec3<f32>;
    var local_5: vec3<f32>;
    var phi_5592_: f32;
    var phi_5618_: f32;
    var local_6: vec3<f32>;
    var local_7: vec3<f32>;
    var phi_5989_: f32;
    var phi_6015_: f32;
    var local_8: vec3<f32>;
    var local_9: vec3<f32>;
    var phi_6386_: f32;
    var phi_6412_: f32;
    var local_10: vec3<f32>;
    var local_11: vec3<f32>;
    var phi_6783_: f32;
    var phi_6809_: f32;
    var local_12: vec2<f32>;
    var local_13: f32;
    var local_14: f32;
    var phi_1354_: type_26;
    var phi_1355_: type_26;
    var local_15: bool;
    var local_16: bool;
    var local_17: bool;
    var local_18: bool;
    var phi_1366_: type_26;
    var phi_7125_: f32;
    var phi_7126_: f32;
    var phi_7127_: f32;
    var phi_1530_: f32;
    var phi_1533_: u32;
    var phi_1534_: u32;
    var phi_7504_: f32;
    var phi_7530_: f32;
    var phi_1587_: f32;
    var phi_1589_: f32;
    var phi_1590_: bool;
    var phi_1591_: bool;
    var phi_1592_: vec3<f32>;
    var phi_1593_: vec2<f32>;
    var phi_1531_: f32;
    var phi_1594_: bool;
    var phi_1595_: bool;
    var phi_1596_: bool;
    var local_19: bool;
    var local_20: vec3<f32>;
    var local_21: vec3<f32>;
    var local_22: vec3<f32>;
    var local_23: vec3<f32>;
    var local_24: vec3<f32>;
    var phi_7901_: f32;
    var phi_7927_: f32;
    var local_25: vec3<f32>;
    var local_26: vec3<f32>;
    var phi_8298_: f32;
    var phi_8324_: f32;
    var local_27: vec3<f32>;
    var local_28: vec3<f32>;
    var phi_8695_: f32;
    var phi_8721_: f32;
    var local_29: vec3<f32>;
    var local_30: vec3<f32>;
    var phi_9092_: f32;
    var phi_9118_: f32;
    var local_31: vec2<f32>;
    var local_32: f32;
    var local_33: f32;
    var phi_1816_: type_26;
    var phi_1817_: type_26;
    var local_34: bool;
    var local_35: bool;
    var local_36: bool;
    var local_37: bool;
    var phi_1828_: type_26;
    var phi_9300_: f32;
    var phi_9313_: f32;
    var phi_9436_: f32;
    var phi_9485_: f32;
    var phi_9524_: f32;
    var phi_9525_: f32;
    var phi_9526_: f32;
    var phi_1963_: f32;
    var phi_1966_: u32;
    var phi_1967_: u32;
    var phi_9903_: f32;
    var phi_9929_: f32;
    var phi_2020_: f32;
    var phi_2022_: f32;
    var phi_2023_: bool;
    var phi_2024_: bool;
    var phi_2025_: vec3<f32>;
    var phi_2026_: vec2<f32>;
    var phi_1964_: f32;
    var phi_2027_: bool;
    var phi_2028_: bool;
    var phi_2029_: bool;
    var local_38: bool;
    var local_39: vec3<f32>;
    var local_40: vec3<f32>;
    var local_41: vec3<f32>;
    var local_42: vec3<f32>;
    var local_43: vec3<f32>;
    var phi_10300_: f32;
    var phi_10326_: f32;
    var local_44: vec3<f32>;
    var local_45: vec3<f32>;
    var phi_10697_: f32;
    var phi_10723_: f32;
    var local_46: vec3<f32>;
    var local_47: vec3<f32>;
    var phi_11094_: f32;
    var phi_11120_: f32;
    var local_48: vec3<f32>;
    var local_49: vec3<f32>;
    var phi_11491_: f32;
    var phi_11517_: f32;
    var local_50: vec2<f32>;
    var local_51: f32;
    var local_52: f32;
    var phi_2249_: type_26;
    var phi_2250_: type_26;
    var local_53: bool;
    var local_54: bool;
    var local_55: bool;
    var local_56: bool;
    var phi_2261_: type_26;
    var phi_2290_: f32;
    var phi_2291_: f32;
    var phi_2292_: f32;
    var phi_2294_: f32;
    var phi_2295_: f32;
    var phi_2296_: f32;
    var phi_2297_: bool;
    var phi_2298_: f32;
    var phi_2299_: f32;
    var phi_2300_: f32;
    var phi_23840_: vec3<f32>;
    var phi_23593_: vec3<f32>;
    var phi_2309_: type_31;
    var phi_2312_: vec3<f32>;
    var phi_2314_: u32;
    var phi_2316_: f32;
    var phi_2318_: f32;
    var phi_2320_: f32;
    var phi_2322_: f32;
    var phi_2324_: f32;
    var phi_2326_: f32;
    var phi_2315_: u32;
    var phi_11782_: f32;
    var phi_11783_: f32;
    var phi_11784_: f32;
    var phi_2405_: f32;
    var phi_2408_: u32;
    var phi_2409_: u32;
    var phi_12158_: f32;
    var phi_12184_: f32;
    var phi_2462_: f32;
    var phi_2464_: f32;
    var phi_2465_: bool;
    var phi_2466_: bool;
    var phi_2467_: vec3<f32>;
    var phi_2468_: vec2<f32>;
    var phi_2406_: f32;
    var phi_2469_: bool;
    var phi_2470_: bool;
    var phi_2471_: bool;
    var local_57: bool;
    var local_58: vec3<f32>;
    var local_59: vec3<f32>;
    var local_60: vec3<f32>;
    var local_61: vec3<f32>;
    var local_62: vec3<f32>;
    var phi_12555_: f32;
    var phi_12581_: f32;
    var local_63: vec3<f32>;
    var local_64: vec3<f32>;
    var phi_12952_: f32;
    var phi_12978_: f32;
    var local_65: vec3<f32>;
    var local_66: vec3<f32>;
    var phi_13349_: f32;
    var phi_13375_: f32;
    var local_67: vec3<f32>;
    var local_68: vec3<f32>;
    var phi_13746_: f32;
    var phi_13772_: f32;
    var local_69: vec2<f32>;
    var local_70: f32;
    var local_71: f32;
    var phi_2691_: type_26;
    var phi_2692_: type_26;
    var local_72: bool;
    var local_73: bool;
    var local_74: bool;
    var local_75: bool;
    var phi_2703_: type_26;
    var phi_14004_: f32;
    var phi_14053_: f32;
    var phi_14092_: f32;
    var phi_14093_: f32;
    var phi_14094_: f32;
    var phi_2837_: f32;
    var phi_2840_: u32;
    var phi_2841_: u32;
    var phi_14471_: f32;
    var phi_14497_: f32;
    var phi_2894_: f32;
    var phi_2896_: f32;
    var phi_2897_: bool;
    var phi_2898_: bool;
    var phi_2899_: vec3<f32>;
    var phi_2900_: vec2<f32>;
    var phi_2838_: f32;
    var phi_2901_: bool;
    var phi_2902_: bool;
    var phi_2903_: bool;
    var local_76: bool;
    var local_77: vec3<f32>;
    var local_78: vec3<f32>;
    var local_79: vec3<f32>;
    var local_80: vec3<f32>;
    var local_81: vec3<f32>;
    var phi_14868_: f32;
    var phi_14894_: f32;
    var local_82: vec3<f32>;
    var local_83: vec3<f32>;
    var phi_15265_: f32;
    var phi_15291_: f32;
    var local_84: vec3<f32>;
    var local_85: vec3<f32>;
    var phi_15662_: f32;
    var phi_15688_: f32;
    var local_86: vec3<f32>;
    var local_87: vec3<f32>;
    var phi_16059_: f32;
    var phi_16085_: f32;
    var local_88: vec2<f32>;
    var local_89: f32;
    var local_90: f32;
    var phi_3123_: type_26;
    var phi_3124_: type_26;
    var local_91: bool;
    var local_92: bool;
    var local_93: bool;
    var local_94: bool;
    var phi_3135_: type_26;
    var phi_3164_: f32;
    var phi_3165_: f32;
    var phi_3166_: f32;
    var phi_3168_: f32;
    var phi_3169_: f32;
    var phi_3170_: f32;
    var phi_3171_: bool;
    var phi_3172_: f32;
    var phi_3173_: f32;
    var phi_3174_: f32;
    var phi_3187_: type_31;
    var phi_3190_: f32;
    var phi_3191_: f32;
    var phi_3192_: f32;
    var phi_3193_: f32;
    var phi_3194_: f32;
    var phi_3195_: f32;
    var phi_3196_: type_31;
    var phi_3197_: vec3<f32>;
    var phi_3198_: bool;
    var phi_3199_: bool;
    var phi_3201_: f32;
    var phi_3202_: f32;
    var phi_3203_: f32;
    var phi_3204_: f32;
    var phi_3205_: f32;
    var phi_3206_: f32;
    var phi_23838_: vec3<f32>;
    var phi_23591_: vec3<f32>;
    var phi_3207_: f32;
    var phi_2310_: type_31;
    var phi_2313_: vec3<f32>;
    var phi_3209_: bool;
    var phi_3210_: bool;
    var phi_3211_: bool;
    var phi_2317_: f32;
    var phi_2319_: f32;
    var phi_2321_: f32;
    var phi_2323_: f32;
    var phi_2325_: f32;
    var phi_2327_: f32;
    var phi_23748_: vec3<f32>;
    var phi_23501_: vec3<f32>;
    var phi_23254_: bool;
    var phi_4716_: bool;
    var phi_4715_: bool;
    var phi_4713_: f32;
    var local_95: f32;
    var local_96: f32;
    var local_97: f32;
    var local_98: f32;
    var local_99: f32;
    var local_100: f32;
    var phi_3222_: f32;
    var phi_3223_: f32;
    var phi_3224_: f32;
    var local_101: f32;
    var local_102: f32;
    var local_103: f32;
    var phi_16290_: f32;
    var phi_16303_: f32;
    var local_104: f32;
    var local_105: f32;
    var local_106: f32;
    var phi_3259_: f32;
    var phi_3260_: f32;
    var phi_3261_: f32;
    var local_107: f32;
    var local_108: f32;
    var local_109: f32;
    var phi_16421_: f32;
    var phi_16470_: f32;
    var phi_16509_: f32;
    var phi_16510_: f32;
    var phi_16511_: f32;
    var phi_3408_: f32;
    var phi_3411_: u32;
    var phi_3412_: u32;
    var phi_16874_: f32;
    var phi_16900_: f32;
    var phi_3485_: f32;
    var phi_3487_: f32;
    var phi_3488_: bool;
    var phi_3489_: bool;
    var phi_3490_: f32;
    var phi_3491_: f32;
    var phi_3492_: f32;
    var phi_3493_: vec2<f32>;
    var phi_3409_: f32;
    var phi_3494_: bool;
    var phi_3495_: bool;
    var phi_3496_: bool;
    var local_110: bool;
    var local_111: f32;
    var local_112: f32;
    var local_113: f32;
    var local_114: f32;
    var local_115: f32;
    var phi_17271_: f32;
    var phi_17297_: f32;
    var local_116: f32;
    var local_117: f32;
    var local_118: f32;
    var local_119: f32;
    var local_120: f32;
    var phi_17668_: f32;
    var phi_17694_: f32;
    var local_121: f32;
    var local_122: f32;
    var local_123: f32;
    var phi_18065_: f32;
    var phi_18091_: f32;
    var local_124: f32;
    var phi_18462_: f32;
    var phi_18488_: f32;
    var local_125: vec2<f32>;
    var local_126: f32;
    var local_127: f32;
    var phi_3699_: type_26;
    var phi_3700_: type_26;
    var local_128: bool;
    var local_129: bool;
    var local_130: bool;
    var local_131: bool;
    var phi_3711_: type_26;
    var phi_3735_: f32;
    var phi_3738_: u32;
    var phi_3739_: u32;
    var phi_18922_: f32;
    var phi_18948_: f32;
    var phi_3792_: f32;
    var phi_3794_: f32;
    var phi_3795_: bool;
    var phi_3796_: bool;
    var phi_3797_: vec3<f32>;
    var phi_3798_: vec2<f32>;
    var phi_3736_: f32;
    var phi_3799_: bool;
    var phi_3800_: bool;
    var phi_3801_: bool;
    var local_132: bool;
    var local_133: vec3<f32>;
    var local_134: vec3<f32>;
    var local_135: vec3<f32>;
    var local_136: vec3<f32>;
    var local_137: vec3<f32>;
    var phi_19319_: f32;
    var phi_19345_: f32;
    var local_138: vec3<f32>;
    var local_139: vec3<f32>;
    var phi_19716_: f32;
    var phi_19742_: f32;
    var local_140: vec3<f32>;
    var local_141: vec3<f32>;
    var phi_20113_: f32;
    var phi_20139_: f32;
    var local_142: vec3<f32>;
    var local_143: vec3<f32>;
    var phi_20510_: f32;
    var phi_20536_: f32;
    var local_144: vec2<f32>;
    var local_145: f32;
    var local_146: f32;
    var phi_4021_: type_26;
    var phi_4022_: type_26;
    var local_147: bool;
    var local_148: bool;
    var local_149: bool;
    var local_150: bool;
    var phi_4033_: type_26;
    var phi_4091_: f32;
    var phi_4092_: f32;
    var phi_4093_: f32;
    var phi_4094_: f32;
    var phi_4095_: f32;
    var phi_4096_: f32;
    var phi_4104_: vec3<f32>;
    var phi_4105_: vec3<f32>;
    var phi_4127_: vec3<f32>;
    var phi_4147_: f32;
    var phi_4148_: f32;
    var phi_4149_: f32;
    var phi_4150_: f32;
    var phi_20855_: f32;
    var phi_20904_: f32;
    var phi_20943_: f32;
    var phi_20944_: f32;
    var phi_20945_: f32;
    var phi_4290_: f32;
    var phi_4293_: u32;
    var phi_4294_: u32;
    var phi_21319_: f32;
    var phi_21345_: f32;
    var phi_4347_: f32;
    var phi_4349_: f32;
    var phi_4350_: bool;
    var phi_4351_: bool;
    var phi_4352_: vec3<f32>;
    var phi_4353_: vec2<f32>;
    var phi_4291_: f32;
    var phi_4354_: bool;
    var phi_4355_: bool;
    var phi_4356_: bool;
    var local_151: bool;
    var local_152: vec3<f32>;
    var local_153: vec3<f32>;
    var local_154: vec3<f32>;
    var local_155: vec3<f32>;
    var local_156: vec3<f32>;
    var phi_21716_: f32;
    var phi_21742_: f32;
    var local_157: vec3<f32>;
    var local_158: vec3<f32>;
    var phi_22113_: f32;
    var phi_22139_: f32;
    var local_159: vec3<f32>;
    var local_160: vec3<f32>;
    var phi_22510_: f32;
    var phi_22536_: f32;
    var local_161: vec3<f32>;
    var local_162: vec3<f32>;
    var phi_22907_: f32;
    var phi_22933_: f32;
    var local_163: vec2<f32>;
    var local_164: f32;
    var local_165: f32;
    var phi_4576_: type_26;
    var phi_4577_: type_26;
    var local_166: bool;
    var local_167: bool;
    var local_168: bool;
    var local_169: bool;
    var phi_4588_: type_26;
    var phi_4631_: f32;
    var phi_4632_: f32;
    var phi_4633_: f32;
    var phi_4634_: f32;
    var phi_4635_: f32;
    var phi_4636_: f32;
    var phi_4637_: f32;
    var phi_4638_: f32;
    var phi_4639_: f32;
    var phi_4643_: f32;
    var phi_4644_: f32;
    var phi_4645_: f32;
    var phi_4646_: f32;
    var phi_4647_: f32;
    var phi_4648_: f32;
    var phi_4649_: f32;
    var phi_4650_: f32;

    switch bitcast<i32>(0u) {
        default: {
            let _e148 = global;
            let _e152 = arrayLength((&global_4.member));
            let _e158 = textureLoad(global_7, vec2<i32>(bitcast<i32>(_e148.x), bitcast<i32>(_e148.y)));
            let _e159 = f32(_e148.x);
            let _e160 = f32(_e148.y);
            let _e163 = global_1.member.member_3;
            let _e168 = global_1.member.member_1;
            let _e171 = global_2.member.member_1;
            let _e178 = ((((_e159 + 0.5f) * 2f) / _e163.x) - 1f);
            let _e179 = ((((_e160 + 0.5f) * 2f) / _e163.y) - 1f);
            let _e194 = fma(_e168.member_1.x, _e179, (_e168.member.x * _e178));
            let _e195 = fma(_e168.member_1.y, _e179, (_e168.member.y * _e178));
            let _e196 = fma(_e168.member_1.z, _e179, (_e168.member.z * _e178));
            let _e197 = fma(_e168.member_1.w, _e179, (_e168.member.w * _e178));
            let _e215 = (_e168.member_3.w + fma(_e168.member_2.w, 0.00000011920929f, _e197));
            let _e226 = (_e168.member_3.w + (_e168.member_2.w + _e197));
            let _e227 = ((_e168.member_3.x + (_e168.member_2.x + _e194)) / _e226);
            let _e228 = ((_e168.member_3.y + (_e168.member_2.y + _e195)) / _e226);
            let _e229 = ((_e168.member_3.z + (_e168.member_2.z + _e196)) / _e226);
            let _e231 = (((_e168.member_3.x + fma(_e168.member_2.x, 0.00000011920929f, _e194)) / _e215) - _e227);
            let _e232 = (((_e168.member_3.y + fma(_e168.member_2.y, 0.00000011920929f, _e195)) / _e215) - _e228);
            let _e233 = (((_e168.member_3.z + fma(_e168.member_2.z, 0.00000011920929f, _e196)) / _e215) - _e229);
            let _e238 = (1f / sqrt(fma(_e233, _e233, fma(_e231, _e231, (_e232 * _e232)))));
            let _e239 = (_e231 * _e238);
            let _e240 = (_e232 * _e238);
            let _e241 = (_e233 * _e238);
            let _e247 = (vec3<f32>((_e239 * _e158.w), (_e240 * _e158.w), (_e241 * _e158.w)) + vec3<f32>(_e227, _e228, _e229));
            phi_1068_ = 0.01f;
            phi_1071_ = 0u;
            loop {
                let _e249 = phi_1068_;
                let _e251 = phi_1071_;
                local_13 = _e249;
                local_14 = _e249;
                let _e252 = (_e251 < 300u);
                if _e252 {
                    phi_1072_ = (_e251 + 1u);
                } else {
                    phi_1072_ = _e251;
                }
                let _e255 = phi_1072_;
                if _e252 {
                    let _e260 = (vec3<f32>((_e239 * _e249), (_e240 * _e249), (_e241 * _e249)) + _e247);
                    let _e261 = (_e260 - vec3<f32>(0f, -2f, 2.5f));
                    let _e269 = (sqrt(fma(_e261.z, _e261.z, fma(_e261.x, _e261.x, (_e261.y * _e261.y)))) - 1f);
                    let _e270 = (_e260 + vec3<f32>(0f, -1f, 0f));
                    let _e280 = fma(0.9689124f, _e270.z, fma(0.04851991f, _e270.y, (_e270.x * -0.24259955f)));
                    let _e287 = (_e270 + vec3<f32>((_e280 * 0.4851991f), (_e280 * -0.09703982f), (2f * fma(0.04851991f, fma(_e270.z, -0.04851991f, (0.9689124f * _e270.y)), (fma(0.24259955f, _e270.z, (0.9689124f * _e270.x)) * -0.24259955f)))));
                    let _e307 = ((_e287 + vec3<f32>(0f, (fma(0.38268346f, _e287.y, (0.9238795f * _e287.z)) * -0.7653669f), (fma(_e287.z, -0.38268346f, (0.9238795f * _e287.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                    let _e313 = (sqrt(fma(_e307.x, _e307.x, (_e307.z * _e307.z))) + -0.5f);
                    let _e316 = (abs(_e307.y) - 0.1f);
                    let _e319 = max(_e313, 0f);
                    let _e320 = max(_e316, 0f);
                    let _e325 = ((min(max(_e313, _e316), 0f) + sqrt(fma(_e319, _e319, (_e320 * _e320)))) - 0.1f);
                    let _e326 = ((_e287 + vec3<f32>((fma(0.70710677f, _e287.x, (0.70710677f * _e287.y)) * -1.4142135f), (fma(_e287.y, -0.70710677f, (0.70710677f * _e287.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                    let _e331 = sqrt(fma(_e326.x, _e326.x, (_e326.z * _e326.z)));
                    let _e332 = (_e331 + -0.5f);
                    let _e334 = abs(_e326.y);
                    let _e335 = (_e334 - 0.1f);
                    let _e338 = max(_e332, 0f);
                    let _e339 = max(_e335, 0f);
                    let _e344 = ((min(max(_e332, _e335), 0f) + sqrt(fma(_e338, _e338, (_e339 * _e339)))) - 0.1f);
                    let _e345 = (_e331 + -0.20000002f);
                    let _e346 = (_e334 - 0.4f);
                    let _e349 = max(_e345, 0f);
                    let _e350 = max(_e346, 0f);
                    let _e354 = (min(max(_e345, _e346), 0f) + sqrt(fma(_e349, _e349, (_e350 * _e350))));
                    let _e358 = fma(-((_e344 + (_e354 - 0.1f))), 5f, 0.5f);
                    if (_e358 < 0f) {
                        phi_5195_ = 0f;
                    } else {
                        phi_5195_ = select(_e358, 1f, (_e358 > 1f));
                    }
                    let _e363 = phi_5195_;
                    let _e369 = fma((0.1f * _e363), (1f - _e363), fma(((0.1f - _e354) - _e344), _e363, _e344));
                    let _e371 = fma((_e369 - _e325), 5f, 0.5f);
                    if (_e371 < 0f) {
                        phi_5221_ = 0f;
                    } else {
                        phi_5221_ = select(_e371, 1f, (_e371 > 1f));
                    }
                    let _e376 = phi_5221_;
                    let _e381 = fma((_e376 * -0.1f), (1f - _e376), fma((_e325 - _e369), _e376, _e369));
                    let _e383 = fma(_e260.y, -1f, 3f);
                    let _e387 = (_e260 - vec3<f32>(-1f, 1f, 0f));
                    let _e395 = (sqrt(fma(_e387.z, _e387.z, fma(_e387.x, _e387.x, (_e387.y * _e387.y)))) - 0.6f);
                    let _e399 = select(vec2<f32>(_e381, 1f), vec2<f32>(_e269, 0f), vec2((_e269 < _e381)));
                    let _e403 = select(vec2<f32>(_e395, 3f), _e399, vec2((_e399.x < _e395)));
                    let _e407 = select(vec2<f32>(_e383, 2f), _e403, vec2((_e403.x < _e383)));
                    let _e409 = (_e407.x < 0.001f);
                    if _e409 {
                        phi_1127_ = f32();
                        phi_1128_ = false;
                        phi_1129_ = false;
                    } else {
                        let _e410 = (_e249 > 22f);
                        if _e410 {
                            phi_1125_ = f32();
                        } else {
                            phi_1125_ = (_e249 + _e407.x);
                        }
                        let _e413 = phi_1125_;
                        phi_1127_ = _e413;
                        phi_1128_ = select(true, false, _e410);
                        phi_1129_ = _e410;
                    }
                    let _e416 = phi_1127_;
                    let _e418 = phi_1128_;
                    let _e420 = phi_1129_;
                    phi_1130_ = _e260;
                    phi_1131_ = _e407;
                    phi_1069_ = _e416;
                    phi_1132_ = _e418;
                    phi_1133_ = _e409;
                    phi_1134_ = _e420;
                } else {
                    phi_1130_ = vec3<f32>();
                    phi_1131_ = vec2<f32>();
                    phi_1069_ = f32();
                    phi_1132_ = false;
                    phi_1133_ = false;
                    phi_1134_ = false;
                }
                let _e422 = phi_1130_;
                let _e424 = phi_1131_;
                let _e426 = phi_1069_;
                let _e428 = phi_1132_;
                let _e430 = phi_1133_;
                let _e432 = phi_1134_;
                local = _e430;
                local_1 = _e422;
                local_2 = _e422;
                local_3 = _e422;
                local_4 = _e422;
                local_5 = _e422;
                local_6 = _e422;
                local_7 = _e422;
                local_8 = _e422;
                local_9 = _e422;
                local_10 = _e422;
                local_11 = _e422;
                local_12 = _e424;
                local_15 = _e430;
                local_16 = _e432;
                local_17 = _e430;
                local_18 = select(true, false, _e252);
                continue;
                continuing {
                    phi_1068_ = _e426;
                    phi_1071_ = _e255;
                    break if !(_e428);
                }
            }
            let _e436 = local;
            if _e436 {
                let _e438 = local_1;
                let _e440 = (_e438.x + 0.000057729998f);
                let _e442 = local_2;
                let _e445 = local_3;
                let _e447 = (_e445.z + -0.000057729998f);
                let _e449 = local_4;
                let _e451 = (_e442.y + 1.9999423f);
                let _e452 = (_e445.z + -2.5000577f);
                let _e453 = (_e451 * _e451);
                let _e457 = (sqrt(fma(_e452, _e452, fma(_e440, _e440, _e453))) - 1f);
                let _e459 = local_5;
                let _e460 = (_e459 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                let _e470 = fma(0.9689124f, _e460.z, fma(0.04851991f, _e460.y, (_e460.x * -0.24259955f)));
                let _e477 = (_e460 + vec3<f32>((_e470 * 0.4851991f), (_e470 * -0.09703982f), (2f * fma(0.04851991f, fma(_e460.z, -0.04851991f, (0.9689124f * _e460.y)), (fma(0.24259955f, _e460.z, (0.9689124f * _e460.x)) * -0.24259955f)))));
                let _e497 = ((_e477 + vec3<f32>(0f, (fma(0.38268346f, _e477.y, (0.9238795f * _e477.z)) * -0.7653669f), (fma(_e477.z, -0.38268346f, (0.9238795f * _e477.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                let _e503 = (sqrt(fma(_e497.x, _e497.x, (_e497.z * _e497.z))) + -0.5f);
                let _e506 = (abs(_e497.y) - 0.1f);
                let _e509 = max(_e503, 0f);
                let _e510 = max(_e506, 0f);
                let _e515 = ((min(max(_e503, _e506), 0f) + sqrt(fma(_e509, _e509, (_e510 * _e510)))) - 0.1f);
                let _e516 = ((_e477 + vec3<f32>((fma(0.70710677f, _e477.x, (0.70710677f * _e477.y)) * -1.4142135f), (fma(_e477.y, -0.70710677f, (0.70710677f * _e477.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                let _e521 = sqrt(fma(_e516.x, _e516.x, (_e516.z * _e516.z)));
                let _e522 = (_e521 + -0.5f);
                let _e524 = abs(_e516.y);
                let _e525 = (_e524 - 0.1f);
                let _e528 = max(_e522, 0f);
                let _e529 = max(_e525, 0f);
                let _e534 = ((min(max(_e522, _e525), 0f) + sqrt(fma(_e528, _e528, (_e529 * _e529)))) - 0.1f);
                let _e535 = (_e521 + -0.20000002f);
                let _e536 = (_e524 - 0.4f);
                let _e539 = max(_e535, 0f);
                let _e540 = max(_e536, 0f);
                let _e544 = (min(max(_e535, _e536), 0f) + sqrt(fma(_e539, _e539, (_e540 * _e540))));
                let _e548 = fma(-((_e534 + (_e544 - 0.1f))), 5f, 0.5f);
                if (_e548 < 0f) {
                    phi_5592_ = 0f;
                } else {
                    phi_5592_ = select(_e548, 1f, (_e548 > 1f));
                }
                let _e553 = phi_5592_;
                let _e559 = fma((0.1f * _e553), (1f - _e553), fma(((0.1f - _e544) - _e534), _e553, _e534));
                let _e561 = fma((_e559 - _e515), 5f, 0.5f);
                if (_e561 < 0f) {
                    phi_5618_ = 0f;
                } else {
                    phi_5618_ = select(_e561, 1f, (_e561 > 1f));
                }
                let _e566 = phi_5618_;
                let _e571 = fma((_e566 * -0.1f), (1f - _e566), fma((_e515 - _e559), _e566, _e559));
                let _e573 = fma((_e449 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                let _e577 = (_e438.x + 1.0000577f);
                let _e578 = (_e442.y + -1.0000577f);
                let _e579 = (_e578 * _e578);
                let _e583 = (sqrt(fma(_e447, _e447, fma(_e577, _e577, _e579))) - 0.6f);
                let _e587 = select(vec2<f32>(_e571, 1f), vec2<f32>(_e457, 0f), vec2((_e457 < _e571)));
                let _e591 = select(vec2<f32>(_e583, 3f), _e587, vec2((_e587.x < _e583)));
                let _e597 = (_e438.x + -0.000057729998f);
                let _e598 = (_e445.z + 0.000057729998f);
                let _e600 = local_6;
                let _e602 = (_e445.z + -2.4999423f);
                let _e606 = (sqrt(fma(_e602, _e602, fma(_e597, _e597, _e453))) - 1f);
                let _e608 = local_7;
                let _e609 = (_e608 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                let _e619 = fma(0.9689124f, _e609.z, fma(0.04851991f, _e609.y, (_e609.x * -0.24259955f)));
                let _e626 = (_e609 + vec3<f32>((_e619 * 0.4851991f), (_e619 * -0.09703982f), (2f * fma(0.04851991f, fma(_e609.z, -0.04851991f, (0.9689124f * _e609.y)), (fma(0.24259955f, _e609.z, (0.9689124f * _e609.x)) * -0.24259955f)))));
                let _e646 = ((_e626 + vec3<f32>(0f, (fma(0.38268346f, _e626.y, (0.9238795f * _e626.z)) * -0.7653669f), (fma(_e626.z, -0.38268346f, (0.9238795f * _e626.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                let _e652 = (sqrt(fma(_e646.x, _e646.x, (_e646.z * _e646.z))) + -0.5f);
                let _e655 = (abs(_e646.y) - 0.1f);
                let _e658 = max(_e652, 0f);
                let _e659 = max(_e655, 0f);
                let _e664 = ((min(max(_e652, _e655), 0f) + sqrt(fma(_e658, _e658, (_e659 * _e659)))) - 0.1f);
                let _e665 = ((_e626 + vec3<f32>((fma(0.70710677f, _e626.x, (0.70710677f * _e626.y)) * -1.4142135f), (fma(_e626.y, -0.70710677f, (0.70710677f * _e626.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                let _e670 = sqrt(fma(_e665.x, _e665.x, (_e665.z * _e665.z)));
                let _e671 = (_e670 + -0.5f);
                let _e673 = abs(_e665.y);
                let _e674 = (_e673 - 0.1f);
                let _e677 = max(_e671, 0f);
                let _e678 = max(_e674, 0f);
                let _e683 = ((min(max(_e671, _e674), 0f) + sqrt(fma(_e677, _e677, (_e678 * _e678)))) - 0.1f);
                let _e684 = (_e670 + -0.20000002f);
                let _e685 = (_e673 - 0.4f);
                let _e688 = max(_e684, 0f);
                let _e689 = max(_e685, 0f);
                let _e693 = (min(max(_e684, _e685), 0f) + sqrt(fma(_e688, _e688, (_e689 * _e689))));
                let _e697 = fma(-((_e683 + (_e693 - 0.1f))), 5f, 0.5f);
                if (_e697 < 0f) {
                    phi_5989_ = 0f;
                } else {
                    phi_5989_ = select(_e697, 1f, (_e697 > 1f));
                }
                let _e702 = phi_5989_;
                let _e708 = fma((0.1f * _e702), (1f - _e702), fma(((0.1f - _e693) - _e683), _e702, _e683));
                let _e710 = fma((_e708 - _e664), 5f, 0.5f);
                if (_e710 < 0f) {
                    phi_6015_ = 0f;
                } else {
                    phi_6015_ = select(_e710, 1f, (_e710 > 1f));
                }
                let _e715 = phi_6015_;
                let _e720 = fma((_e715 * -0.1f), (1f - _e715), fma((_e664 - _e708), _e715, _e708));
                let _e722 = fma((_e600 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                let _e726 = (_e438.x + 0.99994224f);
                let _e730 = (sqrt(fma(_e598, _e598, fma(_e726, _e726, _e579))) - 0.6f);
                let _e734 = select(vec2<f32>(_e720, 1f), vec2<f32>(_e606, 0f), vec2((_e606 < _e720)));
                let _e738 = select(vec2<f32>(_e730, 3f), _e734, vec2((_e734.x < _e730)));
                let _e744 = (-0.5773f * select(vec2<f32>(_e722, 2f), _e738, vec2((_e738.x < _e722))).x);
                let _e750 = local_8;
                let _e752 = (_e442.y + 2.0000577f);
                let _e753 = (_e752 * _e752);
                let _e757 = (sqrt(fma(_e452, _e452, fma(_e597, _e597, _e753))) - 1f);
                let _e759 = local_9;
                let _e760 = (_e759 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                let _e770 = fma(0.9689124f, _e760.z, fma(0.04851991f, _e760.y, (_e760.x * -0.24259955f)));
                let _e777 = (_e760 + vec3<f32>((_e770 * 0.4851991f), (_e770 * -0.09703982f), (2f * fma(0.04851991f, fma(_e760.z, -0.04851991f, (0.9689124f * _e760.y)), (fma(0.24259955f, _e760.z, (0.9689124f * _e760.x)) * -0.24259955f)))));
                let _e797 = ((_e777 + vec3<f32>(0f, (fma(0.38268346f, _e777.y, (0.9238795f * _e777.z)) * -0.7653669f), (fma(_e777.z, -0.38268346f, (0.9238795f * _e777.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                let _e803 = (sqrt(fma(_e797.x, _e797.x, (_e797.z * _e797.z))) + -0.5f);
                let _e806 = (abs(_e797.y) - 0.1f);
                let _e809 = max(_e803, 0f);
                let _e810 = max(_e806, 0f);
                let _e815 = ((min(max(_e803, _e806), 0f) + sqrt(fma(_e809, _e809, (_e810 * _e810)))) - 0.1f);
                let _e816 = ((_e777 + vec3<f32>((fma(0.70710677f, _e777.x, (0.70710677f * _e777.y)) * -1.4142135f), (fma(_e777.y, -0.70710677f, (0.70710677f * _e777.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                let _e821 = sqrt(fma(_e816.x, _e816.x, (_e816.z * _e816.z)));
                let _e822 = (_e821 + -0.5f);
                let _e824 = abs(_e816.y);
                let _e825 = (_e824 - 0.1f);
                let _e828 = max(_e822, 0f);
                let _e829 = max(_e825, 0f);
                let _e834 = ((min(max(_e822, _e825), 0f) + sqrt(fma(_e828, _e828, (_e829 * _e829)))) - 0.1f);
                let _e835 = (_e821 + -0.20000002f);
                let _e836 = (_e824 - 0.4f);
                let _e839 = max(_e835, 0f);
                let _e840 = max(_e836, 0f);
                let _e844 = (min(max(_e835, _e836), 0f) + sqrt(fma(_e839, _e839, (_e840 * _e840))));
                let _e848 = fma(-((_e834 + (_e844 - 0.1f))), 5f, 0.5f);
                if (_e848 < 0f) {
                    phi_6386_ = 0f;
                } else {
                    phi_6386_ = select(_e848, 1f, (_e848 > 1f));
                }
                let _e853 = phi_6386_;
                let _e859 = fma((0.1f * _e853), (1f - _e853), fma(((0.1f - _e844) - _e834), _e853, _e834));
                let _e861 = fma((_e859 - _e815), 5f, 0.5f);
                if (_e861 < 0f) {
                    phi_6412_ = 0f;
                } else {
                    phi_6412_ = select(_e861, 1f, (_e861 > 1f));
                }
                let _e866 = phi_6412_;
                let _e871 = fma((_e866 * -0.1f), (1f - _e866), fma((_e815 - _e859), _e866, _e859));
                let _e873 = fma((_e750 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                let _e877 = (_e442.y + -0.99994224f);
                let _e878 = (_e877 * _e877);
                let _e882 = (sqrt(fma(_e447, _e447, fma(_e726, _e726, _e878))) - 0.6f);
                let _e886 = select(vec2<f32>(_e871, 1f), vec2<f32>(_e757, 0f), vec2((_e757 < _e871)));
                let _e890 = select(vec2<f32>(_e882, 3f), _e886, vec2((_e886.x < _e882)));
                let _e900 = local_10;
                let _e905 = (sqrt(fma(_e602, _e602, fma(_e440, _e440, _e753))) - 1f);
                let _e907 = local_11;
                let _e908 = (_e907 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                let _e918 = fma(0.9689124f, _e908.z, fma(0.04851991f, _e908.y, (_e908.x * -0.24259955f)));
                let _e925 = (_e908 + vec3<f32>((_e918 * 0.4851991f), (_e918 * -0.09703982f), (2f * fma(0.04851991f, fma(_e908.z, -0.04851991f, (0.9689124f * _e908.y)), (fma(0.24259955f, _e908.z, (0.9689124f * _e908.x)) * -0.24259955f)))));
                let _e945 = ((_e925 + vec3<f32>(0f, (fma(0.38268346f, _e925.y, (0.9238795f * _e925.z)) * -0.7653669f), (fma(_e925.z, -0.38268346f, (0.9238795f * _e925.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                let _e951 = (sqrt(fma(_e945.x, _e945.x, (_e945.z * _e945.z))) + -0.5f);
                let _e954 = (abs(_e945.y) - 0.1f);
                let _e957 = max(_e951, 0f);
                let _e958 = max(_e954, 0f);
                let _e963 = ((min(max(_e951, _e954), 0f) + sqrt(fma(_e957, _e957, (_e958 * _e958)))) - 0.1f);
                let _e964 = ((_e925 + vec3<f32>((fma(0.70710677f, _e925.x, (0.70710677f * _e925.y)) * -1.4142135f), (fma(_e925.y, -0.70710677f, (0.70710677f * _e925.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                let _e969 = sqrt(fma(_e964.x, _e964.x, (_e964.z * _e964.z)));
                let _e970 = (_e969 + -0.5f);
                let _e972 = abs(_e964.y);
                let _e973 = (_e972 - 0.1f);
                let _e976 = max(_e970, 0f);
                let _e977 = max(_e973, 0f);
                let _e982 = ((min(max(_e970, _e973), 0f) + sqrt(fma(_e976, _e976, (_e977 * _e977)))) - 0.1f);
                let _e983 = (_e969 + -0.20000002f);
                let _e984 = (_e972 - 0.4f);
                let _e987 = max(_e983, 0f);
                let _e988 = max(_e984, 0f);
                let _e992 = (min(max(_e983, _e984), 0f) + sqrt(fma(_e987, _e987, (_e988 * _e988))));
                let _e996 = fma(-((_e982 + (_e992 - 0.1f))), 5f, 0.5f);
                if (_e996 < 0f) {
                    phi_6783_ = 0f;
                } else {
                    phi_6783_ = select(_e996, 1f, (_e996 > 1f));
                }
                let _e1001 = phi_6783_;
                let _e1007 = fma((0.1f * _e1001), (1f - _e1001), fma(((0.1f - _e992) - _e982), _e1001, _e982));
                let _e1009 = fma((_e1007 - _e963), 5f, 0.5f);
                if (_e1009 < 0f) {
                    phi_6809_ = 0f;
                } else {
                    phi_6809_ = select(_e1009, 1f, (_e1009 > 1f));
                }
                let _e1014 = phi_6809_;
                let _e1019 = fma((_e1014 * -0.1f), (1f - _e1014), fma((_e963 - _e1007), _e1014, _e1007));
                let _e1021 = fma((_e900 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                let _e1028 = (sqrt(fma(_e598, _e598, fma(_e577, _e577, _e878))) - 0.6f);
                let _e1032 = select(vec2<f32>(_e1019, 1f), vec2<f32>(_e905, 0f), vec2((_e905 < _e1019)));
                let _e1036 = select(vec2<f32>(_e1028, 3f), _e1032, vec2((_e1032.x < _e1028)));
                let _e1042 = fma(0.5773f, select(vec2<f32>(_e1021, 2f), _e1036, vec2((_e1036.x < _e1021))).x, fma(-0.5773f, select(vec2<f32>(_e873, 2f), _e890, vec2((_e890.x < _e873))).x, fma(0.5773f, select(vec2<f32>(_e573, 2f), _e591, vec2((_e591.x < _e573))).x, _e744)));
                let _e1043 = fma(0.5773f, select(vec2<f32>(_e1021, 2f), _e1036, vec2((_e1036.x < _e1021))).x, fma(0.5773f, select(vec2<f32>(_e873, 2f), _e890, vec2((_e890.x < _e873))).x, fma(-0.5773f, select(vec2<f32>(_e573, 2f), _e591, vec2((_e591.x < _e573))).x, _e744)));
                let _e1044 = fma(0.5773f, select(vec2<f32>(_e1021, 2f), _e1036, vec2((_e1036.x < _e1021))).x, fma(-0.5773f, select(vec2<f32>(_e873, 2f), _e890, vec2((_e890.x < _e873))).x, fma(-0.5773f, select(vec2<f32>(_e573, 2f), _e591, vec2((_e591.x < _e573))).x, (0.5773f * select(vec2<f32>(_e722, 2f), _e738, vec2((_e738.x < _e722))).x))));
                let _e1049 = (1f / sqrt(fma(_e1044, _e1044, fma(_e1042, _e1042, (_e1043 * _e1043)))));
                let _e1050 = (_e1042 * _e1049);
                let _e1051 = (_e1043 * _e1049);
                let _e1052 = (_e1044 * _e1049);
                let _e1054 = local_12;
                let _e1060 = select(select(u32(_e1054.y), 0u, (_e1054.y < 0f)), 4294967295u, (_e1054.y > 4294967000f));
                if (_e1060 > (_e152 - 1u)) {
                    let _e1076 = local_14;
                    phi_1354_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e1050, _e1051, _e1052, _e1076), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                } else {
                    if (_e1060 < _e152) {
                    } else {
                        break;
                    }
                    let _e1065 = global_4.member[_e1060];
                    let _e1067 = local_13;
                    phi_1354_ = type_26(_e1065.member, vec4<f32>(_e1050, _e1051, _e1052, _e1067), _e1065.member_2, _e1065.member_3, _e1065.member_4);
                }
                let _e1085 = phi_1354_;
                phi_1355_ = _e1085;
            } else {
                phi_1355_ = type_26();
            }
            let _e1087 = phi_1355_;
            let _e1089 = local_15;
            let _e1091 = local_16;
            let _e1094 = local_17;
            let _e1096 = local_18;
            if select(select(_e1096, false, _e1094), true, select(_e1091, false, _e1089)) {
                phi_1366_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
            } else {
                phi_1366_ = _e1087;
            }
            let _e1100 = phi_1366_;
            let _e1105 = (_e1100.member_4.y > 0f);
            if _e1105 {
                let _e1111 = (_e1100.member_1.z * _e1100.member_1.z);
                if (sqrt(fma(_e1100.member_1.z, _e1100.member_1.z, fma(_e1100.member_1.x, _e1100.member_1.x, (_e1100.member_1.y * _e1100.member_1.y)))) > 0f) {
                    let _e1120 = (vec3<f32>((_e239 * _e1100.member_1.w), (_e240 * _e1100.member_1.w), (_e241 * _e1100.member_1.w)) + _e247);
                    let _e1123 = global_3.member.member;
                    if _e1105 {
                        if (((_e1123 >> bitcast<u32>(2i)) & 1u) == 1u) {
                            let _e1128 = -(_e239);
                            let _e1129 = -(_e240);
                            let _e1130 = -(_e241);
                            let _e1133 = vec2<f32>((_e159 + 1f), (_e160 + -1f));
                            let _e1136 = (_e1100.member.z * _e1100.member.z);
                            let _e1137 = fma(_e1136, _e1136, 1f);
                            let _e1138 = (_e1137 * 0.125f);
                            let _e1139 = (_e1136 * 0.5f);
                            let _e1141 = (_e171.y + 10u);
                            let _e1142 = (_e159 + 2.22f);
                            let _e1143 = (_e160 + 1.53f);
                            let _e1146 = global_1.member.member_3[1u];
                            let _e1151 = select(select(u32(_e1146), 0u, (_e1146 < 0f)), 4294967295u, (_e1146 > 4294967000f));
                            let _e1167 = ((((select(select(u32(_e1142), 0u, (_e1142 < 0f)), 4294967295u, (_e1142 > 4294967000f)) * _e1141) + ((select(select(u32(_e1143), 0u, (_e1143 < 0f)), 4294967295u, (_e1143 > 4294967000f)) * _e1141) * _e1151)) * 747796405u) + 2891336453u);
                            let _e1175 = (((_e1167 >> bitcast<u32>((((_e1167 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e1167) * 277803737u);
                            let _e1179 = f32(((_e1175 >> bitcast<u32>(22i)) ^ _e1175));
                            let _e1181 = (_e160 + 2.83f);
                            let _e1182 = (_e159 + 4.92f);
                            let _e1198 = ((((select(select(u32(_e1181), 0u, (_e1181 < 0f)), 4294967295u, (_e1181 > 4294967000f)) * _e1141) + ((select(select(u32(_e1182), 0u, (_e1182 < 0f)), 4294967295u, (_e1182 > 4294967000f)) * _e1141) * _e1151)) * 747796405u) + 2891336453u);
                            let _e1206 = (((_e1198 >> bitcast<u32>((((_e1198 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e1198) * 277803737u);
                            let _e1216 = sqrt((fma(-(_e1179), 0.00000000023283064f, 1f) / fma(fma(_e1136, _e1136, -1f), (_e1179 * 0.00000000023283064f), 1f)));
                            let _e1220 = sqrt(max(fma(-(_e1216), _e1216, 1f), 0f));
                            let _e1221 = (f32(((_e1206 >> bitcast<u32>(22i)) ^ _e1206)) * 0.0000000014629181f);
                            let _e1223 = (cos(_e1221) * _e1220);
                            let _e1225 = (sin(_e1221) * _e1220);
                            if (abs(_e1100.member_1.x) > abs(_e1100.member_1.y)) {
                                let _e1236 = sqrt(fma(_e1100.member_1.x, _e1100.member_1.x, _e1111));
                                phi_7125_ = (-(_e1100.member_1.x) / _e1236);
                                phi_7126_ = 0f;
                                phi_7127_ = (_e1100.member_1.z / _e1236);
                            } else {
                                let _e1231 = sqrt(fma(_e1100.member_1.y, _e1100.member_1.y, _e1111));
                                phi_7125_ = (_e1100.member_1.y / _e1231);
                                phi_7126_ = (-(_e1100.member_1.z) / _e1231);
                                phi_7127_ = 0f;
                            }
                            let _e1240 = phi_7125_;
                            let _e1242 = phi_7126_;
                            let _e1244 = phi_7127_;
                            let _e1256 = fma(_e1225, _e1244, fma(_e1223, fma(_e1100.member_1.y, _e1240, -((_e1242 * _e1100.member_1.z))), (_e1216 * _e1100.member_1.x)));
                            let _e1259 = fma(_e1225, _e1242, fma(_e1223, fma(_e1100.member_1.z, _e1244, -((_e1240 * _e1100.member_1.x))), (_e1216 * _e1100.member_1.y)));
                            let _e1262 = fma(_e1225, _e1240, fma(_e1223, fma(_e1100.member_1.x, _e1242, -((_e1244 * _e1100.member_1.y))), (_e1216 * _e1100.member_1.z)));
                            let _e1266 = max(fma(_e1130, _e1262, fma(_e1128, _e1256, (_e1129 * _e1259))), 0.000001f);
                            let _e1270 = fma(2f, (_e1266 * _e1256), _e239);
                            let _e1271 = fma(2f, (_e1266 * _e1259), _e240);
                            let _e1272 = fma(2f, (_e1266 * _e1262), _e241);
                            let _e1277 = max(fma(_e1100.member_1.z, _e1130, fma(_e1100.member_1.x, _e1128, (_e1100.member_1.y * _e1129))), 0f);
                            let _e1280 = fma(_e1100.member_1.z, _e1272, fma(_e1100.member_1.x, _e1270, (_e1100.member_1.y * _e1271)));
                            if (_e1280 > 0f) {
                                let _e1290 = (_e1120 + vec3<f32>((_e1270 * 0.02f), (_e1271 * 0.02f), (_e1272 * 0.02f)));
                                phi_1530_ = 0.01f;
                                phi_1533_ = 0u;
                                loop {
                                    let _e1292 = phi_1530_;
                                    let _e1294 = phi_1533_;
                                    local_32 = _e1292;
                                    local_33 = _e1292;
                                    let _e1295 = (_e1294 < 300u);
                                    if _e1295 {
                                        phi_1534_ = (_e1294 + 1u);
                                    } else {
                                        phi_1534_ = _e1294;
                                    }
                                    let _e1298 = phi_1534_;
                                    if _e1295 {
                                        let _e1303 = (vec3<f32>((_e1270 * _e1292), (_e1271 * _e1292), (_e1272 * _e1292)) + _e1290);
                                        let _e1304 = (_e1303 - vec3<f32>(0f, -2f, 2.5f));
                                        let _e1312 = (sqrt(fma(_e1304.z, _e1304.z, fma(_e1304.x, _e1304.x, (_e1304.y * _e1304.y)))) - 1f);
                                        let _e1313 = (_e1303 + vec3<f32>(0f, -1f, 0f));
                                        let _e1323 = fma(0.9689124f, _e1313.z, fma(0.04851991f, _e1313.y, (_e1313.x * -0.24259955f)));
                                        let _e1330 = (_e1313 + vec3<f32>((_e1323 * 0.4851991f), (_e1323 * -0.09703982f), (2f * fma(0.04851991f, fma(_e1313.z, -0.04851991f, (0.9689124f * _e1313.y)), (fma(0.24259955f, _e1313.z, (0.9689124f * _e1313.x)) * -0.24259955f)))));
                                        let _e1350 = ((_e1330 + vec3<f32>(0f, (fma(0.38268346f, _e1330.y, (0.9238795f * _e1330.z)) * -0.7653669f), (fma(_e1330.z, -0.38268346f, (0.9238795f * _e1330.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                        let _e1356 = (sqrt(fma(_e1350.x, _e1350.x, (_e1350.z * _e1350.z))) + -0.5f);
                                        let _e1359 = (abs(_e1350.y) - 0.1f);
                                        let _e1362 = max(_e1356, 0f);
                                        let _e1363 = max(_e1359, 0f);
                                        let _e1368 = ((min(max(_e1356, _e1359), 0f) + sqrt(fma(_e1362, _e1362, (_e1363 * _e1363)))) - 0.1f);
                                        let _e1369 = ((_e1330 + vec3<f32>((fma(0.70710677f, _e1330.x, (0.70710677f * _e1330.y)) * -1.4142135f), (fma(_e1330.y, -0.70710677f, (0.70710677f * _e1330.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                        let _e1374 = sqrt(fma(_e1369.x, _e1369.x, (_e1369.z * _e1369.z)));
                                        let _e1375 = (_e1374 + -0.5f);
                                        let _e1377 = abs(_e1369.y);
                                        let _e1378 = (_e1377 - 0.1f);
                                        let _e1381 = max(_e1375, 0f);
                                        let _e1382 = max(_e1378, 0f);
                                        let _e1387 = ((min(max(_e1375, _e1378), 0f) + sqrt(fma(_e1381, _e1381, (_e1382 * _e1382)))) - 0.1f);
                                        let _e1388 = (_e1374 + -0.20000002f);
                                        let _e1389 = (_e1377 - 0.4f);
                                        let _e1392 = max(_e1388, 0f);
                                        let _e1393 = max(_e1389, 0f);
                                        let _e1397 = (min(max(_e1388, _e1389), 0f) + sqrt(fma(_e1392, _e1392, (_e1393 * _e1393))));
                                        let _e1401 = fma(-((_e1387 + (_e1397 - 0.1f))), 5f, 0.5f);
                                        if (_e1401 < 0f) {
                                            phi_7504_ = 0f;
                                        } else {
                                            phi_7504_ = select(_e1401, 1f, (_e1401 > 1f));
                                        }
                                        let _e1406 = phi_7504_;
                                        let _e1412 = fma((0.1f * _e1406), (1f - _e1406), fma(((0.1f - _e1397) - _e1387), _e1406, _e1387));
                                        let _e1414 = fma((_e1412 - _e1368), 5f, 0.5f);
                                        if (_e1414 < 0f) {
                                            phi_7530_ = 0f;
                                        } else {
                                            phi_7530_ = select(_e1414, 1f, (_e1414 > 1f));
                                        }
                                        let _e1419 = phi_7530_;
                                        let _e1424 = fma((_e1419 * -0.1f), (1f - _e1419), fma((_e1368 - _e1412), _e1419, _e1412));
                                        let _e1426 = fma(_e1303.y, -1f, 3f);
                                        let _e1430 = (_e1303 - vec3<f32>(-1f, 1f, 0f));
                                        let _e1438 = (sqrt(fma(_e1430.z, _e1430.z, fma(_e1430.x, _e1430.x, (_e1430.y * _e1430.y)))) - 0.6f);
                                        let _e1442 = select(vec2<f32>(_e1424, 1f), vec2<f32>(_e1312, 0f), vec2((_e1312 < _e1424)));
                                        let _e1446 = select(vec2<f32>(_e1438, 3f), _e1442, vec2((_e1442.x < _e1438)));
                                        let _e1450 = select(vec2<f32>(_e1426, 2f), _e1446, vec2((_e1446.x < _e1426)));
                                        let _e1452 = (_e1450.x < 0.001f);
                                        if _e1452 {
                                            phi_1589_ = f32();
                                            phi_1590_ = false;
                                            phi_1591_ = false;
                                        } else {
                                            let _e1453 = (_e1292 > 22f);
                                            if _e1453 {
                                                phi_1587_ = f32();
                                            } else {
                                                phi_1587_ = (_e1292 + _e1450.x);
                                            }
                                            let _e1456 = phi_1587_;
                                            phi_1589_ = _e1456;
                                            phi_1590_ = select(true, false, _e1453);
                                            phi_1591_ = _e1453;
                                        }
                                        let _e1459 = phi_1589_;
                                        let _e1461 = phi_1590_;
                                        let _e1463 = phi_1591_;
                                        phi_1592_ = _e1303;
                                        phi_1593_ = _e1450;
                                        phi_1531_ = _e1459;
                                        phi_1594_ = _e1461;
                                        phi_1595_ = _e1452;
                                        phi_1596_ = _e1463;
                                    } else {
                                        phi_1592_ = vec3<f32>();
                                        phi_1593_ = vec2<f32>();
                                        phi_1531_ = f32();
                                        phi_1594_ = false;
                                        phi_1595_ = false;
                                        phi_1596_ = false;
                                    }
                                    let _e1465 = phi_1592_;
                                    let _e1467 = phi_1593_;
                                    let _e1469 = phi_1531_;
                                    let _e1471 = phi_1594_;
                                    let _e1473 = phi_1595_;
                                    let _e1475 = phi_1596_;
                                    local_19 = _e1473;
                                    local_20 = _e1465;
                                    local_21 = _e1465;
                                    local_22 = _e1465;
                                    local_23 = _e1465;
                                    local_24 = _e1465;
                                    local_25 = _e1465;
                                    local_26 = _e1465;
                                    local_27 = _e1465;
                                    local_28 = _e1465;
                                    local_29 = _e1465;
                                    local_30 = _e1465;
                                    local_31 = _e1467;
                                    local_34 = _e1473;
                                    local_35 = _e1475;
                                    local_36 = _e1473;
                                    local_37 = select(true, false, _e1295);
                                    continue;
                                    continuing {
                                        phi_1530_ = _e1469;
                                        phi_1533_ = _e1298;
                                        break if !(_e1471);
                                    }
                                }
                                let _e1479 = local_19;
                                if _e1479 {
                                    let _e1481 = local_20;
                                    let _e1483 = (_e1481.x + 0.000057729998f);
                                    let _e1485 = local_21;
                                    let _e1488 = local_22;
                                    let _e1490 = (_e1488.z + -0.000057729998f);
                                    let _e1492 = local_23;
                                    let _e1494 = (_e1485.y + 1.9999423f);
                                    let _e1495 = (_e1488.z + -2.5000577f);
                                    let _e1496 = (_e1494 * _e1494);
                                    let _e1500 = (sqrt(fma(_e1495, _e1495, fma(_e1483, _e1483, _e1496))) - 1f);
                                    let _e1502 = local_24;
                                    let _e1503 = (_e1502 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                    let _e1513 = fma(0.9689124f, _e1503.z, fma(0.04851991f, _e1503.y, (_e1503.x * -0.24259955f)));
                                    let _e1520 = (_e1503 + vec3<f32>((_e1513 * 0.4851991f), (_e1513 * -0.09703982f), (2f * fma(0.04851991f, fma(_e1503.z, -0.04851991f, (0.9689124f * _e1503.y)), (fma(0.24259955f, _e1503.z, (0.9689124f * _e1503.x)) * -0.24259955f)))));
                                    let _e1540 = ((_e1520 + vec3<f32>(0f, (fma(0.38268346f, _e1520.y, (0.9238795f * _e1520.z)) * -0.7653669f), (fma(_e1520.z, -0.38268346f, (0.9238795f * _e1520.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e1546 = (sqrt(fma(_e1540.x, _e1540.x, (_e1540.z * _e1540.z))) + -0.5f);
                                    let _e1549 = (abs(_e1540.y) - 0.1f);
                                    let _e1552 = max(_e1546, 0f);
                                    let _e1553 = max(_e1549, 0f);
                                    let _e1558 = ((min(max(_e1546, _e1549), 0f) + sqrt(fma(_e1552, _e1552, (_e1553 * _e1553)))) - 0.1f);
                                    let _e1559 = ((_e1520 + vec3<f32>((fma(0.70710677f, _e1520.x, (0.70710677f * _e1520.y)) * -1.4142135f), (fma(_e1520.y, -0.70710677f, (0.70710677f * _e1520.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e1564 = sqrt(fma(_e1559.x, _e1559.x, (_e1559.z * _e1559.z)));
                                    let _e1565 = (_e1564 + -0.5f);
                                    let _e1567 = abs(_e1559.y);
                                    let _e1568 = (_e1567 - 0.1f);
                                    let _e1571 = max(_e1565, 0f);
                                    let _e1572 = max(_e1568, 0f);
                                    let _e1577 = ((min(max(_e1565, _e1568), 0f) + sqrt(fma(_e1571, _e1571, (_e1572 * _e1572)))) - 0.1f);
                                    let _e1578 = (_e1564 + -0.20000002f);
                                    let _e1579 = (_e1567 - 0.4f);
                                    let _e1582 = max(_e1578, 0f);
                                    let _e1583 = max(_e1579, 0f);
                                    let _e1587 = (min(max(_e1578, _e1579), 0f) + sqrt(fma(_e1582, _e1582, (_e1583 * _e1583))));
                                    let _e1591 = fma(-((_e1577 + (_e1587 - 0.1f))), 5f, 0.5f);
                                    if (_e1591 < 0f) {
                                        phi_7901_ = 0f;
                                    } else {
                                        phi_7901_ = select(_e1591, 1f, (_e1591 > 1f));
                                    }
                                    let _e1596 = phi_7901_;
                                    let _e1602 = fma((0.1f * _e1596), (1f - _e1596), fma(((0.1f - _e1587) - _e1577), _e1596, _e1577));
                                    let _e1604 = fma((_e1602 - _e1558), 5f, 0.5f);
                                    if (_e1604 < 0f) {
                                        phi_7927_ = 0f;
                                    } else {
                                        phi_7927_ = select(_e1604, 1f, (_e1604 > 1f));
                                    }
                                    let _e1609 = phi_7927_;
                                    let _e1614 = fma((_e1609 * -0.1f), (1f - _e1609), fma((_e1558 - _e1602), _e1609, _e1602));
                                    let _e1616 = fma((_e1492 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                    let _e1620 = (_e1481.x + 1.0000577f);
                                    let _e1621 = (_e1485.y + -1.0000577f);
                                    let _e1622 = (_e1621 * _e1621);
                                    let _e1626 = (sqrt(fma(_e1490, _e1490, fma(_e1620, _e1620, _e1622))) - 0.6f);
                                    let _e1630 = select(vec2<f32>(_e1614, 1f), vec2<f32>(_e1500, 0f), vec2((_e1500 < _e1614)));
                                    let _e1634 = select(vec2<f32>(_e1626, 3f), _e1630, vec2((_e1630.x < _e1626)));
                                    let _e1640 = (_e1481.x + -0.000057729998f);
                                    let _e1641 = (_e1488.z + 0.000057729998f);
                                    let _e1643 = local_25;
                                    let _e1645 = (_e1488.z + -2.4999423f);
                                    let _e1649 = (sqrt(fma(_e1645, _e1645, fma(_e1640, _e1640, _e1496))) - 1f);
                                    let _e1651 = local_26;
                                    let _e1652 = (_e1651 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                    let _e1662 = fma(0.9689124f, _e1652.z, fma(0.04851991f, _e1652.y, (_e1652.x * -0.24259955f)));
                                    let _e1669 = (_e1652 + vec3<f32>((_e1662 * 0.4851991f), (_e1662 * -0.09703982f), (2f * fma(0.04851991f, fma(_e1652.z, -0.04851991f, (0.9689124f * _e1652.y)), (fma(0.24259955f, _e1652.z, (0.9689124f * _e1652.x)) * -0.24259955f)))));
                                    let _e1689 = ((_e1669 + vec3<f32>(0f, (fma(0.38268346f, _e1669.y, (0.9238795f * _e1669.z)) * -0.7653669f), (fma(_e1669.z, -0.38268346f, (0.9238795f * _e1669.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e1695 = (sqrt(fma(_e1689.x, _e1689.x, (_e1689.z * _e1689.z))) + -0.5f);
                                    let _e1698 = (abs(_e1689.y) - 0.1f);
                                    let _e1701 = max(_e1695, 0f);
                                    let _e1702 = max(_e1698, 0f);
                                    let _e1707 = ((min(max(_e1695, _e1698), 0f) + sqrt(fma(_e1701, _e1701, (_e1702 * _e1702)))) - 0.1f);
                                    let _e1708 = ((_e1669 + vec3<f32>((fma(0.70710677f, _e1669.x, (0.70710677f * _e1669.y)) * -1.4142135f), (fma(_e1669.y, -0.70710677f, (0.70710677f * _e1669.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e1713 = sqrt(fma(_e1708.x, _e1708.x, (_e1708.z * _e1708.z)));
                                    let _e1714 = (_e1713 + -0.5f);
                                    let _e1716 = abs(_e1708.y);
                                    let _e1717 = (_e1716 - 0.1f);
                                    let _e1720 = max(_e1714, 0f);
                                    let _e1721 = max(_e1717, 0f);
                                    let _e1726 = ((min(max(_e1714, _e1717), 0f) + sqrt(fma(_e1720, _e1720, (_e1721 * _e1721)))) - 0.1f);
                                    let _e1727 = (_e1713 + -0.20000002f);
                                    let _e1728 = (_e1716 - 0.4f);
                                    let _e1731 = max(_e1727, 0f);
                                    let _e1732 = max(_e1728, 0f);
                                    let _e1736 = (min(max(_e1727, _e1728), 0f) + sqrt(fma(_e1731, _e1731, (_e1732 * _e1732))));
                                    let _e1740 = fma(-((_e1726 + (_e1736 - 0.1f))), 5f, 0.5f);
                                    if (_e1740 < 0f) {
                                        phi_8298_ = 0f;
                                    } else {
                                        phi_8298_ = select(_e1740, 1f, (_e1740 > 1f));
                                    }
                                    let _e1745 = phi_8298_;
                                    let _e1751 = fma((0.1f * _e1745), (1f - _e1745), fma(((0.1f - _e1736) - _e1726), _e1745, _e1726));
                                    let _e1753 = fma((_e1751 - _e1707), 5f, 0.5f);
                                    if (_e1753 < 0f) {
                                        phi_8324_ = 0f;
                                    } else {
                                        phi_8324_ = select(_e1753, 1f, (_e1753 > 1f));
                                    }
                                    let _e1758 = phi_8324_;
                                    let _e1763 = fma((_e1758 * -0.1f), (1f - _e1758), fma((_e1707 - _e1751), _e1758, _e1751));
                                    let _e1765 = fma((_e1643 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                    let _e1769 = (_e1481.x + 0.99994224f);
                                    let _e1773 = (sqrt(fma(_e1641, _e1641, fma(_e1769, _e1769, _e1622))) - 0.6f);
                                    let _e1777 = select(vec2<f32>(_e1763, 1f), vec2<f32>(_e1649, 0f), vec2((_e1649 < _e1763)));
                                    let _e1781 = select(vec2<f32>(_e1773, 3f), _e1777, vec2((_e1777.x < _e1773)));
                                    let _e1787 = (-0.5773f * select(vec2<f32>(_e1765, 2f), _e1781, vec2((_e1781.x < _e1765))).x);
                                    let _e1793 = local_27;
                                    let _e1795 = (_e1485.y + 2.0000577f);
                                    let _e1796 = (_e1795 * _e1795);
                                    let _e1800 = (sqrt(fma(_e1495, _e1495, fma(_e1640, _e1640, _e1796))) - 1f);
                                    let _e1802 = local_28;
                                    let _e1803 = (_e1802 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                    let _e1813 = fma(0.9689124f, _e1803.z, fma(0.04851991f, _e1803.y, (_e1803.x * -0.24259955f)));
                                    let _e1820 = (_e1803 + vec3<f32>((_e1813 * 0.4851991f), (_e1813 * -0.09703982f), (2f * fma(0.04851991f, fma(_e1803.z, -0.04851991f, (0.9689124f * _e1803.y)), (fma(0.24259955f, _e1803.z, (0.9689124f * _e1803.x)) * -0.24259955f)))));
                                    let _e1840 = ((_e1820 + vec3<f32>(0f, (fma(0.38268346f, _e1820.y, (0.9238795f * _e1820.z)) * -0.7653669f), (fma(_e1820.z, -0.38268346f, (0.9238795f * _e1820.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e1846 = (sqrt(fma(_e1840.x, _e1840.x, (_e1840.z * _e1840.z))) + -0.5f);
                                    let _e1849 = (abs(_e1840.y) - 0.1f);
                                    let _e1852 = max(_e1846, 0f);
                                    let _e1853 = max(_e1849, 0f);
                                    let _e1858 = ((min(max(_e1846, _e1849), 0f) + sqrt(fma(_e1852, _e1852, (_e1853 * _e1853)))) - 0.1f);
                                    let _e1859 = ((_e1820 + vec3<f32>((fma(0.70710677f, _e1820.x, (0.70710677f * _e1820.y)) * -1.4142135f), (fma(_e1820.y, -0.70710677f, (0.70710677f * _e1820.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e1864 = sqrt(fma(_e1859.x, _e1859.x, (_e1859.z * _e1859.z)));
                                    let _e1865 = (_e1864 + -0.5f);
                                    let _e1867 = abs(_e1859.y);
                                    let _e1868 = (_e1867 - 0.1f);
                                    let _e1871 = max(_e1865, 0f);
                                    let _e1872 = max(_e1868, 0f);
                                    let _e1877 = ((min(max(_e1865, _e1868), 0f) + sqrt(fma(_e1871, _e1871, (_e1872 * _e1872)))) - 0.1f);
                                    let _e1878 = (_e1864 + -0.20000002f);
                                    let _e1879 = (_e1867 - 0.4f);
                                    let _e1882 = max(_e1878, 0f);
                                    let _e1883 = max(_e1879, 0f);
                                    let _e1887 = (min(max(_e1878, _e1879), 0f) + sqrt(fma(_e1882, _e1882, (_e1883 * _e1883))));
                                    let _e1891 = fma(-((_e1877 + (_e1887 - 0.1f))), 5f, 0.5f);
                                    if (_e1891 < 0f) {
                                        phi_8695_ = 0f;
                                    } else {
                                        phi_8695_ = select(_e1891, 1f, (_e1891 > 1f));
                                    }
                                    let _e1896 = phi_8695_;
                                    let _e1902 = fma((0.1f * _e1896), (1f - _e1896), fma(((0.1f - _e1887) - _e1877), _e1896, _e1877));
                                    let _e1904 = fma((_e1902 - _e1858), 5f, 0.5f);
                                    if (_e1904 < 0f) {
                                        phi_8721_ = 0f;
                                    } else {
                                        phi_8721_ = select(_e1904, 1f, (_e1904 > 1f));
                                    }
                                    let _e1909 = phi_8721_;
                                    let _e1914 = fma((_e1909 * -0.1f), (1f - _e1909), fma((_e1858 - _e1902), _e1909, _e1902));
                                    let _e1916 = fma((_e1793 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                    let _e1920 = (_e1485.y + -0.99994224f);
                                    let _e1921 = (_e1920 * _e1920);
                                    let _e1925 = (sqrt(fma(_e1490, _e1490, fma(_e1769, _e1769, _e1921))) - 0.6f);
                                    let _e1929 = select(vec2<f32>(_e1914, 1f), vec2<f32>(_e1800, 0f), vec2((_e1800 < _e1914)));
                                    let _e1933 = select(vec2<f32>(_e1925, 3f), _e1929, vec2((_e1929.x < _e1925)));
                                    let _e1943 = local_29;
                                    let _e1948 = (sqrt(fma(_e1645, _e1645, fma(_e1483, _e1483, _e1796))) - 1f);
                                    let _e1950 = local_30;
                                    let _e1951 = (_e1950 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                    let _e1961 = fma(0.9689124f, _e1951.z, fma(0.04851991f, _e1951.y, (_e1951.x * -0.24259955f)));
                                    let _e1968 = (_e1951 + vec3<f32>((_e1961 * 0.4851991f), (_e1961 * -0.09703982f), (2f * fma(0.04851991f, fma(_e1951.z, -0.04851991f, (0.9689124f * _e1951.y)), (fma(0.24259955f, _e1951.z, (0.9689124f * _e1951.x)) * -0.24259955f)))));
                                    let _e1988 = ((_e1968 + vec3<f32>(0f, (fma(0.38268346f, _e1968.y, (0.9238795f * _e1968.z)) * -0.7653669f), (fma(_e1968.z, -0.38268346f, (0.9238795f * _e1968.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e1994 = (sqrt(fma(_e1988.x, _e1988.x, (_e1988.z * _e1988.z))) + -0.5f);
                                    let _e1997 = (abs(_e1988.y) - 0.1f);
                                    let _e2000 = max(_e1994, 0f);
                                    let _e2001 = max(_e1997, 0f);
                                    let _e2006 = ((min(max(_e1994, _e1997), 0f) + sqrt(fma(_e2000, _e2000, (_e2001 * _e2001)))) - 0.1f);
                                    let _e2007 = ((_e1968 + vec3<f32>((fma(0.70710677f, _e1968.x, (0.70710677f * _e1968.y)) * -1.4142135f), (fma(_e1968.y, -0.70710677f, (0.70710677f * _e1968.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e2012 = sqrt(fma(_e2007.x, _e2007.x, (_e2007.z * _e2007.z)));
                                    let _e2013 = (_e2012 + -0.5f);
                                    let _e2015 = abs(_e2007.y);
                                    let _e2016 = (_e2015 - 0.1f);
                                    let _e2019 = max(_e2013, 0f);
                                    let _e2020 = max(_e2016, 0f);
                                    let _e2025 = ((min(max(_e2013, _e2016), 0f) + sqrt(fma(_e2019, _e2019, (_e2020 * _e2020)))) - 0.1f);
                                    let _e2026 = (_e2012 + -0.20000002f);
                                    let _e2027 = (_e2015 - 0.4f);
                                    let _e2030 = max(_e2026, 0f);
                                    let _e2031 = max(_e2027, 0f);
                                    let _e2035 = (min(max(_e2026, _e2027), 0f) + sqrt(fma(_e2030, _e2030, (_e2031 * _e2031))));
                                    let _e2039 = fma(-((_e2025 + (_e2035 - 0.1f))), 5f, 0.5f);
                                    if (_e2039 < 0f) {
                                        phi_9092_ = 0f;
                                    } else {
                                        phi_9092_ = select(_e2039, 1f, (_e2039 > 1f));
                                    }
                                    let _e2044 = phi_9092_;
                                    let _e2050 = fma((0.1f * _e2044), (1f - _e2044), fma(((0.1f - _e2035) - _e2025), _e2044, _e2025));
                                    let _e2052 = fma((_e2050 - _e2006), 5f, 0.5f);
                                    if (_e2052 < 0f) {
                                        phi_9118_ = 0f;
                                    } else {
                                        phi_9118_ = select(_e2052, 1f, (_e2052 > 1f));
                                    }
                                    let _e2057 = phi_9118_;
                                    let _e2062 = fma((_e2057 * -0.1f), (1f - _e2057), fma((_e2006 - _e2050), _e2057, _e2050));
                                    let _e2064 = fma((_e1943 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                    let _e2071 = (sqrt(fma(_e1641, _e1641, fma(_e1620, _e1620, _e1921))) - 0.6f);
                                    let _e2075 = select(vec2<f32>(_e2062, 1f), vec2<f32>(_e1948, 0f), vec2((_e1948 < _e2062)));
                                    let _e2079 = select(vec2<f32>(_e2071, 3f), _e2075, vec2((_e2075.x < _e2071)));
                                    let _e2085 = fma(0.5773f, select(vec2<f32>(_e2064, 2f), _e2079, vec2((_e2079.x < _e2064))).x, fma(-0.5773f, select(vec2<f32>(_e1916, 2f), _e1933, vec2((_e1933.x < _e1916))).x, fma(0.5773f, select(vec2<f32>(_e1616, 2f), _e1634, vec2((_e1634.x < _e1616))).x, _e1787)));
                                    let _e2086 = fma(0.5773f, select(vec2<f32>(_e2064, 2f), _e2079, vec2((_e2079.x < _e2064))).x, fma(0.5773f, select(vec2<f32>(_e1916, 2f), _e1933, vec2((_e1933.x < _e1916))).x, fma(-0.5773f, select(vec2<f32>(_e1616, 2f), _e1634, vec2((_e1634.x < _e1616))).x, _e1787)));
                                    let _e2087 = fma(0.5773f, select(vec2<f32>(_e2064, 2f), _e2079, vec2((_e2079.x < _e2064))).x, fma(-0.5773f, select(vec2<f32>(_e1916, 2f), _e1933, vec2((_e1933.x < _e1916))).x, fma(-0.5773f, select(vec2<f32>(_e1616, 2f), _e1634, vec2((_e1634.x < _e1616))).x, (0.5773f * select(vec2<f32>(_e1765, 2f), _e1781, vec2((_e1781.x < _e1765))).x))));
                                    let _e2092 = (1f / sqrt(fma(_e2087, _e2087, fma(_e2085, _e2085, (_e2086 * _e2086)))));
                                    let _e2093 = (_e2085 * _e2092);
                                    let _e2094 = (_e2086 * _e2092);
                                    let _e2095 = (_e2087 * _e2092);
                                    let _e2097 = local_31;
                                    let _e2103 = select(select(u32(_e2097.y), 0u, (_e2097.y < 0f)), 4294967295u, (_e2097.y > 4294967000f));
                                    if (_e2103 > (_e152 - 1u)) {
                                        let _e2119 = local_33;
                                        phi_1816_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e2093, _e2094, _e2095, _e2119), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                    } else {
                                        if (_e2103 < _e152) {
                                        } else {
                                            break;
                                        }
                                        let _e2108 = global_4.member[_e2103];
                                        let _e2110 = local_32;
                                        phi_1816_ = type_26(_e2108.member, vec4<f32>(_e2093, _e2094, _e2095, _e2110), _e2108.member_2, _e2108.member_3, _e2108.member_4);
                                    }
                                    let _e2128 = phi_1816_;
                                    phi_1817_ = _e2128;
                                } else {
                                    phi_1817_ = type_26();
                                }
                                let _e2130 = phi_1817_;
                                let _e2132 = local_34;
                                let _e2134 = local_35;
                                let _e2137 = local_36;
                                let _e2139 = local_37;
                                if select(select(_e2139, false, _e2137), true, select(_e2134, false, _e2132)) {
                                    phi_1828_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                } else {
                                    phi_1828_ = _e2130;
                                }
                                let _e2143 = phi_1828_;
                                if (sqrt(fma(_e2143.member_1.z, _e2143.member_1.z, fma(_e2143.member_1.x, _e2143.member_1.x, (_e2143.member_1.y * _e2143.member_1.y)))) > 0f) {
                                    if (_e2143.member_4.z > 0f) {
                                        phi_4105_ = vec3<f32>(_e2143.member_2.x, _e2143.member_2.y, _e2143.member_2.z);
                                    } else {
                                        let _e2211 = (_e1120 + vec3<f32>((_e1270 * _e2143.member_1.w), (_e1271 * _e2143.member_1.w), (_e1272 * _e2143.member_1.w)));
                                        let _e2214 = (_e171.y + 31u);
                                        let _e2220 = (vec2<f32>((_e159 + 2.2233f), (_e160 + 1.1110001f)) + vec2<f32>(2f, 3f));
                                        let _e2223 = global_1.member.member_3[0u];
                                        let _e2228 = select(select(u32(_e2223), 0u, (_e2223 < 0f)), 4294967295u, (_e2223 > 4294967000f));
                                        let _e2246 = ((((select(select(u32(_e2220.x), 0u, (_e2220.x < 0f)), 4294967295u, (_e2220.x > 4294967000f)) * _e2214) + ((select(select(u32(_e2220.y), 0u, (_e2220.y < 0f)), 4294967295u, (_e2220.y > 4294967000f)) * _e2214) * _e2228)) * 747796405u) + 2891336453u);
                                        let _e2254 = (((_e2246 >> bitcast<u32>((((_e2246 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e2246) * 277803737u);
                                        let _e2259 = (f32(((_e2254 >> bitcast<u32>(22i)) ^ _e2254)) * 0.00000000023283064f);
                                        if (_e2259 < 0f) {
                                            phi_9436_ = 0f;
                                        } else {
                                            phi_9436_ = select(_e2259, 1f, (_e2259 > 1f));
                                        }
                                        let _e2264 = phi_9436_;
                                        let _e2265 = (_e160 + 0.11100006f);
                                        let _e2266 = (_e159 + 1.2233f);
                                        let _e2282 = ((((select(select(u32(_e2265), 0u, (_e2265 < 0f)), 4294967295u, (_e2265 > 4294967000f)) * _e2214) + ((select(select(u32(_e2266), 0u, (_e2266 < 0f)), 4294967295u, (_e2266 > 4294967000f)) * _e2214) * _e2228)) * 747796405u) + 2891336453u);
                                        let _e2290 = (((_e2282 >> bitcast<u32>((((_e2282 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e2282) * 277803737u);
                                        let _e2295 = (f32(((_e2290 >> bitcast<u32>(22i)) ^ _e2290)) * 0.00000000023283064f);
                                        if (_e2295 < 0f) {
                                            phi_9485_ = 0f;
                                        } else {
                                            phi_9485_ = select(_e2295, 1f, (_e2295 > 1f));
                                        }
                                        let _e2300 = phi_9485_;
                                        let _e2302 = -(_e2211.x);
                                        let _e2304 = (-2f - _e2211.y);
                                        let _e2306 = (2.5f - _e2211.z);
                                        let _e2310 = sqrt(fma(_e2306, _e2306, fma(_e2302, _e2302, (_e2304 * _e2304))));
                                        let _e2311 = (_e2302 / _e2310);
                                        let _e2312 = (_e2304 / _e2310);
                                        let _e2313 = (_e2306 / _e2310);
                                        let _e2320 = fma(_e2264, sqrt(max((1f - (1f / (_e2310 * _e2310))), 0f)), (1f - _e2264));
                                        let _e2324 = sqrt(max(fma(-(_e2320), _e2320, 1f), 0f));
                                        let _e2325 = (_e2300 * 6.2831855f);
                                        let _e2327 = (cos(_e2325) * _e2324);
                                        let _e2329 = (sin(_e2325) * _e2324);
                                        if (abs(_e2311) > abs(_e2312)) {
                                            let _e2342 = sqrt(fma(_e2311, _e2311, (_e2313 * _e2313)));
                                            phi_9524_ = (-(_e2311) / _e2342);
                                            phi_9525_ = 0f;
                                            phi_9526_ = (_e2313 / _e2342);
                                        } else {
                                            let _e2336 = sqrt(fma(_e2312, _e2312, (_e2313 * _e2313)));
                                            phi_9524_ = (_e2312 / _e2336);
                                            phi_9525_ = (-(_e2313) / _e2336);
                                            phi_9526_ = 0f;
                                        }
                                        let _e2346 = phi_9524_;
                                        let _e2348 = phi_9525_;
                                        let _e2350 = phi_9526_;
                                        let _e2362 = fma(_e2329, _e2350, fma(_e2327, fma(_e2312, _e2346, -((_e2348 * _e2313))), (_e2320 * _e2311)));
                                        let _e2365 = fma(_e2329, _e2348, fma(_e2327, fma(_e2313, _e2350, -((_e2346 * _e2311))), (_e2320 * _e2312)));
                                        let _e2368 = fma(_e2329, _e2346, fma(_e2327, fma(_e2311, _e2348, -((_e2350 * _e2312))), (_e2320 * _e2313)));
                                        let _e2372 = fma(_e2143.member_1.z, _e2368, fma(_e2143.member_1.x, _e2362, (_e2143.member_1.y * _e2365)));
                                        if (_e2372 < 0f) {
                                            phi_2297_ = true;
                                            phi_2298_ = f32();
                                            phi_2299_ = f32();
                                            phi_2300_ = f32();
                                        } else {
                                            phi_1963_ = 0.01f;
                                            phi_1966_ = 0u;
                                            loop {
                                                let _e2376 = phi_1963_;
                                                let _e2378 = phi_1966_;
                                                local_51 = _e2376;
                                                local_52 = _e2376;
                                                let _e2379 = (_e2378 < 300u);
                                                if _e2379 {
                                                    phi_1967_ = (_e2378 + 1u);
                                                } else {
                                                    phi_1967_ = _e2378;
                                                }
                                                let _e2382 = phi_1967_;
                                                if _e2379 {
                                                    let _e2387 = (vec3<f32>((_e2362 * _e2376), (_e2365 * _e2376), (_e2368 * _e2376)) + (_e2211 + vec3<f32>(_e2362, _e2365, _e2368)));
                                                    let _e2388 = (_e2387 - vec3<f32>(0f, -2f, 2.5f));
                                                    let _e2396 = (sqrt(fma(_e2388.z, _e2388.z, fma(_e2388.x, _e2388.x, (_e2388.y * _e2388.y)))) - 1f);
                                                    let _e2397 = (_e2387 + vec3<f32>(0f, -1f, 0f));
                                                    let _e2407 = fma(0.9689124f, _e2397.z, fma(0.04851991f, _e2397.y, (_e2397.x * -0.24259955f)));
                                                    let _e2414 = (_e2397 + vec3<f32>((_e2407 * 0.4851991f), (_e2407 * -0.09703982f), (2f * fma(0.04851991f, fma(_e2397.z, -0.04851991f, (0.9689124f * _e2397.y)), (fma(0.24259955f, _e2397.z, (0.9689124f * _e2397.x)) * -0.24259955f)))));
                                                    let _e2434 = ((_e2414 + vec3<f32>(0f, (fma(0.38268346f, _e2414.y, (0.9238795f * _e2414.z)) * -0.7653669f), (fma(_e2414.z, -0.38268346f, (0.9238795f * _e2414.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e2440 = (sqrt(fma(_e2434.x, _e2434.x, (_e2434.z * _e2434.z))) + -0.5f);
                                                    let _e2443 = (abs(_e2434.y) - 0.1f);
                                                    let _e2446 = max(_e2440, 0f);
                                                    let _e2447 = max(_e2443, 0f);
                                                    let _e2452 = ((min(max(_e2440, _e2443), 0f) + sqrt(fma(_e2446, _e2446, (_e2447 * _e2447)))) - 0.1f);
                                                    let _e2453 = ((_e2414 + vec3<f32>((fma(0.70710677f, _e2414.x, (0.70710677f * _e2414.y)) * -1.4142135f), (fma(_e2414.y, -0.70710677f, (0.70710677f * _e2414.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e2458 = sqrt(fma(_e2453.x, _e2453.x, (_e2453.z * _e2453.z)));
                                                    let _e2459 = (_e2458 + -0.5f);
                                                    let _e2461 = abs(_e2453.y);
                                                    let _e2462 = (_e2461 - 0.1f);
                                                    let _e2465 = max(_e2459, 0f);
                                                    let _e2466 = max(_e2462, 0f);
                                                    let _e2471 = ((min(max(_e2459, _e2462), 0f) + sqrt(fma(_e2465, _e2465, (_e2466 * _e2466)))) - 0.1f);
                                                    let _e2472 = (_e2458 + -0.20000002f);
                                                    let _e2473 = (_e2461 - 0.4f);
                                                    let _e2476 = max(_e2472, 0f);
                                                    let _e2477 = max(_e2473, 0f);
                                                    let _e2481 = (min(max(_e2472, _e2473), 0f) + sqrt(fma(_e2476, _e2476, (_e2477 * _e2477))));
                                                    let _e2485 = fma(-((_e2471 + (_e2481 - 0.1f))), 5f, 0.5f);
                                                    if (_e2485 < 0f) {
                                                        phi_9903_ = 0f;
                                                    } else {
                                                        phi_9903_ = select(_e2485, 1f, (_e2485 > 1f));
                                                    }
                                                    let _e2490 = phi_9903_;
                                                    let _e2496 = fma((0.1f * _e2490), (1f - _e2490), fma(((0.1f - _e2481) - _e2471), _e2490, _e2471));
                                                    let _e2498 = fma((_e2496 - _e2452), 5f, 0.5f);
                                                    if (_e2498 < 0f) {
                                                        phi_9929_ = 0f;
                                                    } else {
                                                        phi_9929_ = select(_e2498, 1f, (_e2498 > 1f));
                                                    }
                                                    let _e2503 = phi_9929_;
                                                    let _e2508 = fma((_e2503 * -0.1f), (1f - _e2503), fma((_e2452 - _e2496), _e2503, _e2496));
                                                    let _e2510 = fma(_e2387.y, -1f, 3f);
                                                    let _e2514 = (_e2387 - vec3<f32>(-1f, 1f, 0f));
                                                    let _e2522 = (sqrt(fma(_e2514.z, _e2514.z, fma(_e2514.x, _e2514.x, (_e2514.y * _e2514.y)))) - 0.6f);
                                                    let _e2526 = select(vec2<f32>(_e2508, 1f), vec2<f32>(_e2396, 0f), vec2((_e2396 < _e2508)));
                                                    let _e2530 = select(vec2<f32>(_e2522, 3f), _e2526, vec2((_e2526.x < _e2522)));
                                                    let _e2534 = select(vec2<f32>(_e2510, 2f), _e2530, vec2((_e2530.x < _e2510)));
                                                    let _e2536 = (_e2534.x < 0.001f);
                                                    if _e2536 {
                                                        phi_2022_ = f32();
                                                        phi_2023_ = false;
                                                        phi_2024_ = false;
                                                    } else {
                                                        let _e2537 = (_e2376 > 22f);
                                                        if _e2537 {
                                                            phi_2020_ = f32();
                                                        } else {
                                                            phi_2020_ = (_e2376 + _e2534.x);
                                                        }
                                                        let _e2540 = phi_2020_;
                                                        phi_2022_ = _e2540;
                                                        phi_2023_ = select(true, false, _e2537);
                                                        phi_2024_ = _e2537;
                                                    }
                                                    let _e2543 = phi_2022_;
                                                    let _e2545 = phi_2023_;
                                                    let _e2547 = phi_2024_;
                                                    phi_2025_ = _e2387;
                                                    phi_2026_ = _e2534;
                                                    phi_1964_ = _e2543;
                                                    phi_2027_ = _e2545;
                                                    phi_2028_ = _e2536;
                                                    phi_2029_ = _e2547;
                                                } else {
                                                    phi_2025_ = vec3<f32>();
                                                    phi_2026_ = vec2<f32>();
                                                    phi_1964_ = f32();
                                                    phi_2027_ = false;
                                                    phi_2028_ = false;
                                                    phi_2029_ = false;
                                                }
                                                let _e2549 = phi_2025_;
                                                let _e2551 = phi_2026_;
                                                let _e2553 = phi_1964_;
                                                let _e2555 = phi_2027_;
                                                let _e2557 = phi_2028_;
                                                let _e2559 = phi_2029_;
                                                local_38 = _e2557;
                                                local_39 = _e2549;
                                                local_40 = _e2549;
                                                local_41 = _e2549;
                                                local_42 = _e2549;
                                                local_43 = _e2549;
                                                local_44 = _e2549;
                                                local_45 = _e2549;
                                                local_46 = _e2549;
                                                local_47 = _e2549;
                                                local_48 = _e2549;
                                                local_49 = _e2549;
                                                local_50 = _e2551;
                                                local_53 = _e2557;
                                                local_54 = _e2559;
                                                local_55 = _e2557;
                                                local_56 = select(true, false, _e2379);
                                                continue;
                                                continuing {
                                                    phi_1963_ = _e2553;
                                                    phi_1966_ = _e2382;
                                                    break if !(_e2555);
                                                }
                                            }
                                            let _e2563 = local_38;
                                            if _e2563 {
                                                let _e2565 = local_39;
                                                let _e2567 = (_e2565.x + 0.000057729998f);
                                                let _e2569 = local_40;
                                                let _e2572 = local_41;
                                                let _e2574 = (_e2572.z + -0.000057729998f);
                                                let _e2576 = local_42;
                                                let _e2578 = (_e2569.y + 1.9999423f);
                                                let _e2579 = (_e2572.z + -2.5000577f);
                                                let _e2580 = (_e2578 * _e2578);
                                                let _e2584 = (sqrt(fma(_e2579, _e2579, fma(_e2567, _e2567, _e2580))) - 1f);
                                                let _e2586 = local_43;
                                                let _e2587 = (_e2586 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                                let _e2597 = fma(0.9689124f, _e2587.z, fma(0.04851991f, _e2587.y, (_e2587.x * -0.24259955f)));
                                                let _e2604 = (_e2587 + vec3<f32>((_e2597 * 0.4851991f), (_e2597 * -0.09703982f), (2f * fma(0.04851991f, fma(_e2587.z, -0.04851991f, (0.9689124f * _e2587.y)), (fma(0.24259955f, _e2587.z, (0.9689124f * _e2587.x)) * -0.24259955f)))));
                                                let _e2624 = ((_e2604 + vec3<f32>(0f, (fma(0.38268346f, _e2604.y, (0.9238795f * _e2604.z)) * -0.7653669f), (fma(_e2604.z, -0.38268346f, (0.9238795f * _e2604.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e2630 = (sqrt(fma(_e2624.x, _e2624.x, (_e2624.z * _e2624.z))) + -0.5f);
                                                let _e2633 = (abs(_e2624.y) - 0.1f);
                                                let _e2636 = max(_e2630, 0f);
                                                let _e2637 = max(_e2633, 0f);
                                                let _e2642 = ((min(max(_e2630, _e2633), 0f) + sqrt(fma(_e2636, _e2636, (_e2637 * _e2637)))) - 0.1f);
                                                let _e2643 = ((_e2604 + vec3<f32>((fma(0.70710677f, _e2604.x, (0.70710677f * _e2604.y)) * -1.4142135f), (fma(_e2604.y, -0.70710677f, (0.70710677f * _e2604.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e2648 = sqrt(fma(_e2643.x, _e2643.x, (_e2643.z * _e2643.z)));
                                                let _e2649 = (_e2648 + -0.5f);
                                                let _e2651 = abs(_e2643.y);
                                                let _e2652 = (_e2651 - 0.1f);
                                                let _e2655 = max(_e2649, 0f);
                                                let _e2656 = max(_e2652, 0f);
                                                let _e2661 = ((min(max(_e2649, _e2652), 0f) + sqrt(fma(_e2655, _e2655, (_e2656 * _e2656)))) - 0.1f);
                                                let _e2662 = (_e2648 + -0.20000002f);
                                                let _e2663 = (_e2651 - 0.4f);
                                                let _e2666 = max(_e2662, 0f);
                                                let _e2667 = max(_e2663, 0f);
                                                let _e2671 = (min(max(_e2662, _e2663), 0f) + sqrt(fma(_e2666, _e2666, (_e2667 * _e2667))));
                                                let _e2675 = fma(-((_e2661 + (_e2671 - 0.1f))), 5f, 0.5f);
                                                if (_e2675 < 0f) {
                                                    phi_10300_ = 0f;
                                                } else {
                                                    phi_10300_ = select(_e2675, 1f, (_e2675 > 1f));
                                                }
                                                let _e2680 = phi_10300_;
                                                let _e2686 = fma((0.1f * _e2680), (1f - _e2680), fma(((0.1f - _e2671) - _e2661), _e2680, _e2661));
                                                let _e2688 = fma((_e2686 - _e2642), 5f, 0.5f);
                                                if (_e2688 < 0f) {
                                                    phi_10326_ = 0f;
                                                } else {
                                                    phi_10326_ = select(_e2688, 1f, (_e2688 > 1f));
                                                }
                                                let _e2693 = phi_10326_;
                                                let _e2698 = fma((_e2693 * -0.1f), (1f - _e2693), fma((_e2642 - _e2686), _e2693, _e2686));
                                                let _e2700 = fma((_e2576 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                let _e2704 = (_e2565.x + 1.0000577f);
                                                let _e2705 = (_e2569.y + -1.0000577f);
                                                let _e2706 = (_e2705 * _e2705);
                                                let _e2710 = (sqrt(fma(_e2574, _e2574, fma(_e2704, _e2704, _e2706))) - 0.6f);
                                                let _e2714 = select(vec2<f32>(_e2698, 1f), vec2<f32>(_e2584, 0f), vec2((_e2584 < _e2698)));
                                                let _e2718 = select(vec2<f32>(_e2710, 3f), _e2714, vec2((_e2714.x < _e2710)));
                                                let _e2724 = (_e2565.x + -0.000057729998f);
                                                let _e2725 = (_e2572.z + 0.000057729998f);
                                                let _e2727 = local_44;
                                                let _e2729 = (_e2572.z + -2.4999423f);
                                                let _e2733 = (sqrt(fma(_e2729, _e2729, fma(_e2724, _e2724, _e2580))) - 1f);
                                                let _e2735 = local_45;
                                                let _e2736 = (_e2735 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                                let _e2746 = fma(0.9689124f, _e2736.z, fma(0.04851991f, _e2736.y, (_e2736.x * -0.24259955f)));
                                                let _e2753 = (_e2736 + vec3<f32>((_e2746 * 0.4851991f), (_e2746 * -0.09703982f), (2f * fma(0.04851991f, fma(_e2736.z, -0.04851991f, (0.9689124f * _e2736.y)), (fma(0.24259955f, _e2736.z, (0.9689124f * _e2736.x)) * -0.24259955f)))));
                                                let _e2773 = ((_e2753 + vec3<f32>(0f, (fma(0.38268346f, _e2753.y, (0.9238795f * _e2753.z)) * -0.7653669f), (fma(_e2753.z, -0.38268346f, (0.9238795f * _e2753.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e2779 = (sqrt(fma(_e2773.x, _e2773.x, (_e2773.z * _e2773.z))) + -0.5f);
                                                let _e2782 = (abs(_e2773.y) - 0.1f);
                                                let _e2785 = max(_e2779, 0f);
                                                let _e2786 = max(_e2782, 0f);
                                                let _e2791 = ((min(max(_e2779, _e2782), 0f) + sqrt(fma(_e2785, _e2785, (_e2786 * _e2786)))) - 0.1f);
                                                let _e2792 = ((_e2753 + vec3<f32>((fma(0.70710677f, _e2753.x, (0.70710677f * _e2753.y)) * -1.4142135f), (fma(_e2753.y, -0.70710677f, (0.70710677f * _e2753.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e2797 = sqrt(fma(_e2792.x, _e2792.x, (_e2792.z * _e2792.z)));
                                                let _e2798 = (_e2797 + -0.5f);
                                                let _e2800 = abs(_e2792.y);
                                                let _e2801 = (_e2800 - 0.1f);
                                                let _e2804 = max(_e2798, 0f);
                                                let _e2805 = max(_e2801, 0f);
                                                let _e2810 = ((min(max(_e2798, _e2801), 0f) + sqrt(fma(_e2804, _e2804, (_e2805 * _e2805)))) - 0.1f);
                                                let _e2811 = (_e2797 + -0.20000002f);
                                                let _e2812 = (_e2800 - 0.4f);
                                                let _e2815 = max(_e2811, 0f);
                                                let _e2816 = max(_e2812, 0f);
                                                let _e2820 = (min(max(_e2811, _e2812), 0f) + sqrt(fma(_e2815, _e2815, (_e2816 * _e2816))));
                                                let _e2824 = fma(-((_e2810 + (_e2820 - 0.1f))), 5f, 0.5f);
                                                if (_e2824 < 0f) {
                                                    phi_10697_ = 0f;
                                                } else {
                                                    phi_10697_ = select(_e2824, 1f, (_e2824 > 1f));
                                                }
                                                let _e2829 = phi_10697_;
                                                let _e2835 = fma((0.1f * _e2829), (1f - _e2829), fma(((0.1f - _e2820) - _e2810), _e2829, _e2810));
                                                let _e2837 = fma((_e2835 - _e2791), 5f, 0.5f);
                                                if (_e2837 < 0f) {
                                                    phi_10723_ = 0f;
                                                } else {
                                                    phi_10723_ = select(_e2837, 1f, (_e2837 > 1f));
                                                }
                                                let _e2842 = phi_10723_;
                                                let _e2847 = fma((_e2842 * -0.1f), (1f - _e2842), fma((_e2791 - _e2835), _e2842, _e2835));
                                                let _e2849 = fma((_e2727 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                let _e2853 = (_e2565.x + 0.99994224f);
                                                let _e2857 = (sqrt(fma(_e2725, _e2725, fma(_e2853, _e2853, _e2706))) - 0.6f);
                                                let _e2861 = select(vec2<f32>(_e2847, 1f), vec2<f32>(_e2733, 0f), vec2((_e2733 < _e2847)));
                                                let _e2865 = select(vec2<f32>(_e2857, 3f), _e2861, vec2((_e2861.x < _e2857)));
                                                let _e2871 = (-0.5773f * select(vec2<f32>(_e2849, 2f), _e2865, vec2((_e2865.x < _e2849))).x);
                                                let _e2877 = local_46;
                                                let _e2879 = (_e2569.y + 2.0000577f);
                                                let _e2880 = (_e2879 * _e2879);
                                                let _e2884 = (sqrt(fma(_e2579, _e2579, fma(_e2724, _e2724, _e2880))) - 1f);
                                                let _e2886 = local_47;
                                                let _e2887 = (_e2886 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                                let _e2897 = fma(0.9689124f, _e2887.z, fma(0.04851991f, _e2887.y, (_e2887.x * -0.24259955f)));
                                                let _e2904 = (_e2887 + vec3<f32>((_e2897 * 0.4851991f), (_e2897 * -0.09703982f), (2f * fma(0.04851991f, fma(_e2887.z, -0.04851991f, (0.9689124f * _e2887.y)), (fma(0.24259955f, _e2887.z, (0.9689124f * _e2887.x)) * -0.24259955f)))));
                                                let _e2924 = ((_e2904 + vec3<f32>(0f, (fma(0.38268346f, _e2904.y, (0.9238795f * _e2904.z)) * -0.7653669f), (fma(_e2904.z, -0.38268346f, (0.9238795f * _e2904.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e2930 = (sqrt(fma(_e2924.x, _e2924.x, (_e2924.z * _e2924.z))) + -0.5f);
                                                let _e2933 = (abs(_e2924.y) - 0.1f);
                                                let _e2936 = max(_e2930, 0f);
                                                let _e2937 = max(_e2933, 0f);
                                                let _e2942 = ((min(max(_e2930, _e2933), 0f) + sqrt(fma(_e2936, _e2936, (_e2937 * _e2937)))) - 0.1f);
                                                let _e2943 = ((_e2904 + vec3<f32>((fma(0.70710677f, _e2904.x, (0.70710677f * _e2904.y)) * -1.4142135f), (fma(_e2904.y, -0.70710677f, (0.70710677f * _e2904.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e2948 = sqrt(fma(_e2943.x, _e2943.x, (_e2943.z * _e2943.z)));
                                                let _e2949 = (_e2948 + -0.5f);
                                                let _e2951 = abs(_e2943.y);
                                                let _e2952 = (_e2951 - 0.1f);
                                                let _e2955 = max(_e2949, 0f);
                                                let _e2956 = max(_e2952, 0f);
                                                let _e2961 = ((min(max(_e2949, _e2952), 0f) + sqrt(fma(_e2955, _e2955, (_e2956 * _e2956)))) - 0.1f);
                                                let _e2962 = (_e2948 + -0.20000002f);
                                                let _e2963 = (_e2951 - 0.4f);
                                                let _e2966 = max(_e2962, 0f);
                                                let _e2967 = max(_e2963, 0f);
                                                let _e2971 = (min(max(_e2962, _e2963), 0f) + sqrt(fma(_e2966, _e2966, (_e2967 * _e2967))));
                                                let _e2975 = fma(-((_e2961 + (_e2971 - 0.1f))), 5f, 0.5f);
                                                if (_e2975 < 0f) {
                                                    phi_11094_ = 0f;
                                                } else {
                                                    phi_11094_ = select(_e2975, 1f, (_e2975 > 1f));
                                                }
                                                let _e2980 = phi_11094_;
                                                let _e2986 = fma((0.1f * _e2980), (1f - _e2980), fma(((0.1f - _e2971) - _e2961), _e2980, _e2961));
                                                let _e2988 = fma((_e2986 - _e2942), 5f, 0.5f);
                                                if (_e2988 < 0f) {
                                                    phi_11120_ = 0f;
                                                } else {
                                                    phi_11120_ = select(_e2988, 1f, (_e2988 > 1f));
                                                }
                                                let _e2993 = phi_11120_;
                                                let _e2998 = fma((_e2993 * -0.1f), (1f - _e2993), fma((_e2942 - _e2986), _e2993, _e2986));
                                                let _e3000 = fma((_e2877 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                let _e3004 = (_e2569.y + -0.99994224f);
                                                let _e3005 = (_e3004 * _e3004);
                                                let _e3009 = (sqrt(fma(_e2574, _e2574, fma(_e2853, _e2853, _e3005))) - 0.6f);
                                                let _e3013 = select(vec2<f32>(_e2998, 1f), vec2<f32>(_e2884, 0f), vec2((_e2884 < _e2998)));
                                                let _e3017 = select(vec2<f32>(_e3009, 3f), _e3013, vec2((_e3013.x < _e3009)));
                                                let _e3027 = local_48;
                                                let _e3032 = (sqrt(fma(_e2729, _e2729, fma(_e2567, _e2567, _e2880))) - 1f);
                                                let _e3034 = local_49;
                                                let _e3035 = (_e3034 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                                let _e3045 = fma(0.9689124f, _e3035.z, fma(0.04851991f, _e3035.y, (_e3035.x * -0.24259955f)));
                                                let _e3052 = (_e3035 + vec3<f32>((_e3045 * 0.4851991f), (_e3045 * -0.09703982f), (2f * fma(0.04851991f, fma(_e3035.z, -0.04851991f, (0.9689124f * _e3035.y)), (fma(0.24259955f, _e3035.z, (0.9689124f * _e3035.x)) * -0.24259955f)))));
                                                let _e3072 = ((_e3052 + vec3<f32>(0f, (fma(0.38268346f, _e3052.y, (0.9238795f * _e3052.z)) * -0.7653669f), (fma(_e3052.z, -0.38268346f, (0.9238795f * _e3052.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e3078 = (sqrt(fma(_e3072.x, _e3072.x, (_e3072.z * _e3072.z))) + -0.5f);
                                                let _e3081 = (abs(_e3072.y) - 0.1f);
                                                let _e3084 = max(_e3078, 0f);
                                                let _e3085 = max(_e3081, 0f);
                                                let _e3090 = ((min(max(_e3078, _e3081), 0f) + sqrt(fma(_e3084, _e3084, (_e3085 * _e3085)))) - 0.1f);
                                                let _e3091 = ((_e3052 + vec3<f32>((fma(0.70710677f, _e3052.x, (0.70710677f * _e3052.y)) * -1.4142135f), (fma(_e3052.y, -0.70710677f, (0.70710677f * _e3052.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e3096 = sqrt(fma(_e3091.x, _e3091.x, (_e3091.z * _e3091.z)));
                                                let _e3097 = (_e3096 + -0.5f);
                                                let _e3099 = abs(_e3091.y);
                                                let _e3100 = (_e3099 - 0.1f);
                                                let _e3103 = max(_e3097, 0f);
                                                let _e3104 = max(_e3100, 0f);
                                                let _e3109 = ((min(max(_e3097, _e3100), 0f) + sqrt(fma(_e3103, _e3103, (_e3104 * _e3104)))) - 0.1f);
                                                let _e3110 = (_e3096 + -0.20000002f);
                                                let _e3111 = (_e3099 - 0.4f);
                                                let _e3114 = max(_e3110, 0f);
                                                let _e3115 = max(_e3111, 0f);
                                                let _e3119 = (min(max(_e3110, _e3111), 0f) + sqrt(fma(_e3114, _e3114, (_e3115 * _e3115))));
                                                let _e3123 = fma(-((_e3109 + (_e3119 - 0.1f))), 5f, 0.5f);
                                                if (_e3123 < 0f) {
                                                    phi_11491_ = 0f;
                                                } else {
                                                    phi_11491_ = select(_e3123, 1f, (_e3123 > 1f));
                                                }
                                                let _e3128 = phi_11491_;
                                                let _e3134 = fma((0.1f * _e3128), (1f - _e3128), fma(((0.1f - _e3119) - _e3109), _e3128, _e3109));
                                                let _e3136 = fma((_e3134 - _e3090), 5f, 0.5f);
                                                if (_e3136 < 0f) {
                                                    phi_11517_ = 0f;
                                                } else {
                                                    phi_11517_ = select(_e3136, 1f, (_e3136 > 1f));
                                                }
                                                let _e3141 = phi_11517_;
                                                let _e3146 = fma((_e3141 * -0.1f), (1f - _e3141), fma((_e3090 - _e3134), _e3141, _e3134));
                                                let _e3148 = fma((_e3027 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                let _e3155 = (sqrt(fma(_e2725, _e2725, fma(_e2704, _e2704, _e3005))) - 0.6f);
                                                let _e3159 = select(vec2<f32>(_e3146, 1f), vec2<f32>(_e3032, 0f), vec2((_e3032 < _e3146)));
                                                let _e3163 = select(vec2<f32>(_e3155, 3f), _e3159, vec2((_e3159.x < _e3155)));
                                                let _e3169 = fma(0.5773f, select(vec2<f32>(_e3148, 2f), _e3163, vec2((_e3163.x < _e3148))).x, fma(-0.5773f, select(vec2<f32>(_e3000, 2f), _e3017, vec2((_e3017.x < _e3000))).x, fma(0.5773f, select(vec2<f32>(_e2700, 2f), _e2718, vec2((_e2718.x < _e2700))).x, _e2871)));
                                                let _e3170 = fma(0.5773f, select(vec2<f32>(_e3148, 2f), _e3163, vec2((_e3163.x < _e3148))).x, fma(0.5773f, select(vec2<f32>(_e3000, 2f), _e3017, vec2((_e3017.x < _e3000))).x, fma(-0.5773f, select(vec2<f32>(_e2700, 2f), _e2718, vec2((_e2718.x < _e2700))).x, _e2871)));
                                                let _e3171 = fma(0.5773f, select(vec2<f32>(_e3148, 2f), _e3163, vec2((_e3163.x < _e3148))).x, fma(-0.5773f, select(vec2<f32>(_e3000, 2f), _e3017, vec2((_e3017.x < _e3000))).x, fma(-0.5773f, select(vec2<f32>(_e2700, 2f), _e2718, vec2((_e2718.x < _e2700))).x, (0.5773f * select(vec2<f32>(_e2849, 2f), _e2865, vec2((_e2865.x < _e2849))).x))));
                                                let _e3176 = (1f / sqrt(fma(_e3171, _e3171, fma(_e3169, _e3169, (_e3170 * _e3170)))));
                                                let _e3177 = (_e3169 * _e3176);
                                                let _e3178 = (_e3170 * _e3176);
                                                let _e3179 = (_e3171 * _e3176);
                                                let _e3181 = local_50;
                                                let _e3187 = select(select(u32(_e3181.y), 0u, (_e3181.y < 0f)), 4294967295u, (_e3181.y > 4294967000f));
                                                if (_e3187 > (_e152 - 1u)) {
                                                    let _e3203 = local_52;
                                                    phi_2249_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e3177, _e3178, _e3179, _e3203), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                                } else {
                                                    if (_e3187 < _e152) {
                                                    } else {
                                                        break;
                                                    }
                                                    let _e3192 = global_4.member[_e3187];
                                                    let _e3194 = local_51;
                                                    phi_2249_ = type_26(_e3192.member, vec4<f32>(_e3177, _e3178, _e3179, _e3194), _e3192.member_2, _e3192.member_3, _e3192.member_4);
                                                }
                                                let _e3212 = phi_2249_;
                                                phi_2250_ = _e3212;
                                            } else {
                                                phi_2250_ = type_26();
                                            }
                                            let _e3214 = phi_2250_;
                                            let _e3216 = local_53;
                                            let _e3218 = local_54;
                                            let _e3221 = local_55;
                                            let _e3223 = local_56;
                                            if select(select(_e3223, false, _e3221), true, select(_e3218, false, _e3216)) {
                                                phi_2261_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                            } else {
                                                phi_2261_ = _e3214;
                                            }
                                            let _e3227 = phi_2261_;
                                            let _e3238 = (sqrt(fma(_e3227.member_1.z, _e3227.member_1.z, fma(_e3227.member_1.x, _e3227.member_1.x, (_e3227.member_1.y * _e3227.member_1.y)))) > 0f);
                                            if _e3238 {
                                                if (_e3227.member_4.z > 0f) {
                                                    let _e3242 = (_e3227.member_1.w + 1f);
                                                    let _e3252 = (_e3242 * _e3242);
                                                    phi_2290_ = (((_e3227.member_2.x * _e3227.member_4.z) * _e2372) / _e3252);
                                                    phi_2291_ = (((_e3227.member_2.y * _e3227.member_4.z) * _e2372) / _e3252);
                                                    phi_2292_ = (((_e3227.member_2.z * _e3227.member_4.z) * _e2372) / _e3252);
                                                } else {
                                                    phi_2290_ = 0f;
                                                    phi_2291_ = 0f;
                                                    phi_2292_ = 0f;
                                                }
                                                let _e3257 = phi_2290_;
                                                let _e3259 = phi_2291_;
                                                let _e3261 = phi_2292_;
                                                phi_2294_ = _e3257;
                                                phi_2295_ = _e3259;
                                                phi_2296_ = _e3261;
                                            } else {
                                                phi_2294_ = f32();
                                                phi_2295_ = f32();
                                                phi_2296_ = f32();
                                            }
                                            let _e3263 = phi_2294_;
                                            let _e3265 = phi_2295_;
                                            let _e3267 = phi_2296_;
                                            phi_2297_ = select(true, false, _e3238);
                                            phi_2298_ = _e3263;
                                            phi_2299_ = _e3265;
                                            phi_2300_ = _e3267;
                                        }
                                        let _e3270 = phi_2297_;
                                        let _e3272 = phi_2298_;
                                        let _e3274 = phi_2299_;
                                        let _e3276 = phi_2300_;
                                        phi_23840_ = vec3<f32>();
                                        phi_23593_ = vec3<f32>();
                                        phi_2309_ = type_31(_e2211, vec3<f32>(_e1270, _e1271, _e1272), _e1133, vec2<u32>((_e171.x + 31u), _e2214));
                                        phi_2312_ = vec3<f32>(_e2143.member_1.x, _e2143.member_1.y, _e2143.member_1.z);
                                        phi_2314_ = 0u;
                                        phi_2316_ = 1f;
                                        phi_2318_ = 1f;
                                        phi_2320_ = 1f;
                                        phi_2322_ = select(_e3272, 0f, _e3270);
                                        phi_2324_ = select(_e3274, 0f, _e3270);
                                        phi_2326_ = select(_e3276, 0f, _e3270);
                                        loop {
                                            let _e3281 = phi_23840_;
                                            let _e3283 = phi_23593_;
                                            let _e3285 = phi_2309_;
                                            let _e3287 = phi_2312_;
                                            let _e3289 = phi_2314_;
                                            let _e3291 = phi_2316_;
                                            let _e3293 = phi_2318_;
                                            let _e3295 = phi_2320_;
                                            let _e3297 = phi_2322_;
                                            let _e3299 = phi_2324_;
                                            let _e3301 = phi_2326_;
                                            local_95 = _e3291;
                                            local_96 = _e3297;
                                            local_97 = _e3293;
                                            local_98 = _e3299;
                                            local_99 = _e3295;
                                            local_100 = _e3301;
                                            local_101 = _e3291;
                                            local_102 = _e3293;
                                            local_103 = _e3295;
                                            local_104 = _e3297;
                                            local_105 = _e3299;
                                            local_106 = _e3301;
                                            local_107 = _e3297;
                                            local_108 = _e3299;
                                            local_109 = _e3301;
                                            let _e3302 = (_e3289 < 21u);
                                            if _e3302 {
                                                phi_2315_ = (_e3289 + 1u);
                                            } else {
                                                phi_2315_ = _e3289;
                                            }
                                            let _e3305 = phi_2315_;
                                            if _e3302 {
                                                let _e3309 = (_e3285.member_3.y + (_e3289 * 2u));
                                                let _e3317 = (select(select(u32(_e3285.member_2.x), 0u, (_e3285.member_2.x < 0f)), 4294967295u, (_e3285.member_2.x > 4294967000f)) * _e3309);
                                                let _e3324 = (select(select(u32(_e3285.member_2.y), 0u, (_e3285.member_2.y < 0f)), 4294967295u, (_e3285.member_2.y > 4294967000f)) * _e3309);
                                                let _e3328 = (((_e3317 + (_e3324 * _e1151)) * 747796405u) + 2891336453u);
                                                let _e3336 = (((_e3328 >> bitcast<u32>((((_e3328 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e3328) * 277803737u);
                                                let _e3343 = sqrt(fma(-(f32(((_e3336 >> bitcast<u32>(22i)) ^ _e3336))), 0.00000000023283064f, 1f));
                                                let _e3347 = sqrt(max(fma(-(_e3343), _e3343, 1f), 0f));
                                                let _e3351 = (((_e3324 + (_e3317 * _e1151)) * 747796405u) + 2891336453u);
                                                let _e3359 = (((_e3351 >> bitcast<u32>((((_e3351 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e3351) * 277803737u);
                                                let _e3364 = (f32(((_e3359 >> bitcast<u32>(22i)) ^ _e3359)) * 0.0000000014629181f);
                                                let _e3366 = (cos(_e3364) * _e3347);
                                                let _e3368 = (sin(_e3364) * _e3347);
                                                if (abs(_e3287.x) > abs(_e3287.y)) {
                                                    let _e3385 = sqrt(fma(_e3287.x, _e3287.x, (_e3287.z * _e3287.z)));
                                                    phi_11782_ = (-(_e3287.x) / _e3385);
                                                    phi_11783_ = 0f;
                                                    phi_11784_ = (_e3287.z / _e3385);
                                                } else {
                                                    let _e3378 = sqrt(fma(_e3287.y, _e3287.y, (_e3287.z * _e3287.z)));
                                                    phi_11782_ = (_e3287.y / _e3378);
                                                    phi_11783_ = (-(_e3287.z) / _e3378);
                                                    phi_11784_ = 0f;
                                                }
                                                let _e3389 = phi_11782_;
                                                let _e3391 = phi_11783_;
                                                let _e3393 = phi_11784_;
                                                let _e3406 = fma(_e3368, _e3393, fma(_e3366, fma(_e3287.y, _e3389, -((_e3391 * _e3287.z))), (_e3343 * _e3287.x)));
                                                let _e3409 = fma(_e3368, _e3391, fma(_e3366, fma(_e3287.z, _e3393, -((_e3389 * _e3287.x))), (_e3343 * _e3287.y)));
                                                let _e3412 = fma(_e3368, _e3389, fma(_e3366, fma(_e3287.x, _e3391, -((_e3393 * _e3287.y))), (_e3343 * _e3287.z)));
                                                let _e3413 = vec3<f32>(_e3406, _e3409, _e3412);
                                                let _e3417 = max(fma(_e3287.z, _e3412, fma(_e3287.x, _e3406, (_e3287.y * _e3409))), 0f);
                                                phi_2405_ = 0.01f;
                                                phi_2408_ = 0u;
                                                loop {
                                                    let _e3420 = phi_2405_;
                                                    let _e3422 = phi_2408_;
                                                    local_70 = _e3420;
                                                    local_71 = _e3420;
                                                    let _e3423 = (_e3422 < 300u);
                                                    if _e3423 {
                                                        phi_2409_ = (_e3422 + 1u);
                                                    } else {
                                                        phi_2409_ = _e3422;
                                                    }
                                                    let _e3426 = phi_2409_;
                                                    if _e3423 {
                                                        let _e3431 = (vec3<f32>((_e3406 * _e3420), (_e3409 * _e3420), (_e3412 * _e3420)) + _e3285.member);
                                                        let _e3432 = (_e3431 - vec3<f32>(0f, -2f, 2.5f));
                                                        let _e3440 = (sqrt(fma(_e3432.z, _e3432.z, fma(_e3432.x, _e3432.x, (_e3432.y * _e3432.y)))) - 1f);
                                                        let _e3441 = (_e3431 + vec3<f32>(0f, -1f, 0f));
                                                        let _e3451 = fma(0.9689124f, _e3441.z, fma(0.04851991f, _e3441.y, (_e3441.x * -0.24259955f)));
                                                        let _e3458 = (_e3441 + vec3<f32>((_e3451 * 0.4851991f), (_e3451 * -0.09703982f), (2f * fma(0.04851991f, fma(_e3441.z, -0.04851991f, (0.9689124f * _e3441.y)), (fma(0.24259955f, _e3441.z, (0.9689124f * _e3441.x)) * -0.24259955f)))));
                                                        let _e3478 = ((_e3458 + vec3<f32>(0f, (fma(0.38268346f, _e3458.y, (0.9238795f * _e3458.z)) * -0.7653669f), (fma(_e3458.z, -0.38268346f, (0.9238795f * _e3458.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                        let _e3484 = (sqrt(fma(_e3478.x, _e3478.x, (_e3478.z * _e3478.z))) + -0.5f);
                                                        let _e3487 = (abs(_e3478.y) - 0.1f);
                                                        let _e3490 = max(_e3484, 0f);
                                                        let _e3491 = max(_e3487, 0f);
                                                        let _e3496 = ((min(max(_e3484, _e3487), 0f) + sqrt(fma(_e3490, _e3490, (_e3491 * _e3491)))) - 0.1f);
                                                        let _e3497 = ((_e3458 + vec3<f32>((fma(0.70710677f, _e3458.x, (0.70710677f * _e3458.y)) * -1.4142135f), (fma(_e3458.y, -0.70710677f, (0.70710677f * _e3458.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                        let _e3502 = sqrt(fma(_e3497.x, _e3497.x, (_e3497.z * _e3497.z)));
                                                        let _e3503 = (_e3502 + -0.5f);
                                                        let _e3505 = abs(_e3497.y);
                                                        let _e3506 = (_e3505 - 0.1f);
                                                        let _e3509 = max(_e3503, 0f);
                                                        let _e3510 = max(_e3506, 0f);
                                                        let _e3515 = ((min(max(_e3503, _e3506), 0f) + sqrt(fma(_e3509, _e3509, (_e3510 * _e3510)))) - 0.1f);
                                                        let _e3516 = (_e3502 + -0.20000002f);
                                                        let _e3517 = (_e3505 - 0.4f);
                                                        let _e3520 = max(_e3516, 0f);
                                                        let _e3521 = max(_e3517, 0f);
                                                        let _e3525 = (min(max(_e3516, _e3517), 0f) + sqrt(fma(_e3520, _e3520, (_e3521 * _e3521))));
                                                        let _e3529 = fma(-((_e3515 + (_e3525 - 0.1f))), 5f, 0.5f);
                                                        if (_e3529 < 0f) {
                                                            phi_12158_ = 0f;
                                                        } else {
                                                            phi_12158_ = select(_e3529, 1f, (_e3529 > 1f));
                                                        }
                                                        let _e3534 = phi_12158_;
                                                        let _e3540 = fma((0.1f * _e3534), (1f - _e3534), fma(((0.1f - _e3525) - _e3515), _e3534, _e3515));
                                                        let _e3542 = fma((_e3540 - _e3496), 5f, 0.5f);
                                                        if (_e3542 < 0f) {
                                                            phi_12184_ = 0f;
                                                        } else {
                                                            phi_12184_ = select(_e3542, 1f, (_e3542 > 1f));
                                                        }
                                                        let _e3547 = phi_12184_;
                                                        let _e3552 = fma((_e3547 * -0.1f), (1f - _e3547), fma((_e3496 - _e3540), _e3547, _e3540));
                                                        let _e3554 = fma(_e3431.y, -1f, 3f);
                                                        let _e3558 = (_e3431 - vec3<f32>(-1f, 1f, 0f));
                                                        let _e3566 = (sqrt(fma(_e3558.z, _e3558.z, fma(_e3558.x, _e3558.x, (_e3558.y * _e3558.y)))) - 0.6f);
                                                        let _e3570 = select(vec2<f32>(_e3552, 1f), vec2<f32>(_e3440, 0f), vec2((_e3440 < _e3552)));
                                                        let _e3574 = select(vec2<f32>(_e3566, 3f), _e3570, vec2((_e3570.x < _e3566)));
                                                        let _e3578 = select(vec2<f32>(_e3554, 2f), _e3574, vec2((_e3574.x < _e3554)));
                                                        let _e3580 = (_e3578.x < 0.001f);
                                                        if _e3580 {
                                                            phi_2464_ = f32();
                                                            phi_2465_ = false;
                                                            phi_2466_ = false;
                                                        } else {
                                                            let _e3581 = (_e3420 > 22f);
                                                            if _e3581 {
                                                                phi_2462_ = f32();
                                                            } else {
                                                                phi_2462_ = (_e3420 + _e3578.x);
                                                            }
                                                            let _e3584 = phi_2462_;
                                                            phi_2464_ = _e3584;
                                                            phi_2465_ = select(true, false, _e3581);
                                                            phi_2466_ = _e3581;
                                                        }
                                                        let _e3587 = phi_2464_;
                                                        let _e3589 = phi_2465_;
                                                        let _e3591 = phi_2466_;
                                                        phi_2467_ = _e3431;
                                                        phi_2468_ = _e3578;
                                                        phi_2406_ = _e3587;
                                                        phi_2469_ = _e3589;
                                                        phi_2470_ = _e3580;
                                                        phi_2471_ = _e3591;
                                                    } else {
                                                        phi_2467_ = vec3<f32>();
                                                        phi_2468_ = vec2<f32>();
                                                        phi_2406_ = f32();
                                                        phi_2469_ = false;
                                                        phi_2470_ = false;
                                                        phi_2471_ = false;
                                                    }
                                                    let _e3593 = phi_2467_;
                                                    let _e3595 = phi_2468_;
                                                    let _e3597 = phi_2406_;
                                                    let _e3599 = phi_2469_;
                                                    let _e3601 = phi_2470_;
                                                    let _e3603 = phi_2471_;
                                                    local_57 = _e3601;
                                                    local_58 = _e3593;
                                                    local_59 = _e3593;
                                                    local_60 = _e3593;
                                                    local_61 = _e3593;
                                                    local_62 = _e3593;
                                                    local_63 = _e3593;
                                                    local_64 = _e3593;
                                                    local_65 = _e3593;
                                                    local_66 = _e3593;
                                                    local_67 = _e3593;
                                                    local_68 = _e3593;
                                                    local_69 = _e3595;
                                                    local_72 = _e3601;
                                                    local_73 = _e3603;
                                                    local_74 = _e3601;
                                                    local_75 = select(true, false, _e3423);
                                                    continue;
                                                    continuing {
                                                        phi_2405_ = _e3597;
                                                        phi_2408_ = _e3426;
                                                        break if !(_e3599);
                                                    }
                                                }
                                                let _e3607 = local_57;
                                                if _e3607 {
                                                    let _e3609 = local_58;
                                                    let _e3611 = (_e3609.x + 0.000057729998f);
                                                    let _e3613 = local_59;
                                                    let _e3616 = local_60;
                                                    let _e3618 = (_e3616.z + -0.000057729998f);
                                                    let _e3620 = local_61;
                                                    let _e3622 = (_e3613.y + 1.9999423f);
                                                    let _e3623 = (_e3616.z + -2.5000577f);
                                                    let _e3624 = (_e3622 * _e3622);
                                                    let _e3628 = (sqrt(fma(_e3623, _e3623, fma(_e3611, _e3611, _e3624))) - 1f);
                                                    let _e3630 = local_62;
                                                    let _e3631 = (_e3630 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                                    let _e3641 = fma(0.9689124f, _e3631.z, fma(0.04851991f, _e3631.y, (_e3631.x * -0.24259955f)));
                                                    let _e3648 = (_e3631 + vec3<f32>((_e3641 * 0.4851991f), (_e3641 * -0.09703982f), (2f * fma(0.04851991f, fma(_e3631.z, -0.04851991f, (0.9689124f * _e3631.y)), (fma(0.24259955f, _e3631.z, (0.9689124f * _e3631.x)) * -0.24259955f)))));
                                                    let _e3668 = ((_e3648 + vec3<f32>(0f, (fma(0.38268346f, _e3648.y, (0.9238795f * _e3648.z)) * -0.7653669f), (fma(_e3648.z, -0.38268346f, (0.9238795f * _e3648.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e3674 = (sqrt(fma(_e3668.x, _e3668.x, (_e3668.z * _e3668.z))) + -0.5f);
                                                    let _e3677 = (abs(_e3668.y) - 0.1f);
                                                    let _e3680 = max(_e3674, 0f);
                                                    let _e3681 = max(_e3677, 0f);
                                                    let _e3686 = ((min(max(_e3674, _e3677), 0f) + sqrt(fma(_e3680, _e3680, (_e3681 * _e3681)))) - 0.1f);
                                                    let _e3687 = ((_e3648 + vec3<f32>((fma(0.70710677f, _e3648.x, (0.70710677f * _e3648.y)) * -1.4142135f), (fma(_e3648.y, -0.70710677f, (0.70710677f * _e3648.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e3692 = sqrt(fma(_e3687.x, _e3687.x, (_e3687.z * _e3687.z)));
                                                    let _e3693 = (_e3692 + -0.5f);
                                                    let _e3695 = abs(_e3687.y);
                                                    let _e3696 = (_e3695 - 0.1f);
                                                    let _e3699 = max(_e3693, 0f);
                                                    let _e3700 = max(_e3696, 0f);
                                                    let _e3705 = ((min(max(_e3693, _e3696), 0f) + sqrt(fma(_e3699, _e3699, (_e3700 * _e3700)))) - 0.1f);
                                                    let _e3706 = (_e3692 + -0.20000002f);
                                                    let _e3707 = (_e3695 - 0.4f);
                                                    let _e3710 = max(_e3706, 0f);
                                                    let _e3711 = max(_e3707, 0f);
                                                    let _e3715 = (min(max(_e3706, _e3707), 0f) + sqrt(fma(_e3710, _e3710, (_e3711 * _e3711))));
                                                    let _e3719 = fma(-((_e3705 + (_e3715 - 0.1f))), 5f, 0.5f);
                                                    if (_e3719 < 0f) {
                                                        phi_12555_ = 0f;
                                                    } else {
                                                        phi_12555_ = select(_e3719, 1f, (_e3719 > 1f));
                                                    }
                                                    let _e3724 = phi_12555_;
                                                    let _e3730 = fma((0.1f * _e3724), (1f - _e3724), fma(((0.1f - _e3715) - _e3705), _e3724, _e3705));
                                                    let _e3732 = fma((_e3730 - _e3686), 5f, 0.5f);
                                                    if (_e3732 < 0f) {
                                                        phi_12581_ = 0f;
                                                    } else {
                                                        phi_12581_ = select(_e3732, 1f, (_e3732 > 1f));
                                                    }
                                                    let _e3737 = phi_12581_;
                                                    let _e3742 = fma((_e3737 * -0.1f), (1f - _e3737), fma((_e3686 - _e3730), _e3737, _e3730));
                                                    let _e3744 = fma((_e3620 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                    let _e3748 = (_e3609.x + 1.0000577f);
                                                    let _e3749 = (_e3613.y + -1.0000577f);
                                                    let _e3750 = (_e3749 * _e3749);
                                                    let _e3754 = (sqrt(fma(_e3618, _e3618, fma(_e3748, _e3748, _e3750))) - 0.6f);
                                                    let _e3758 = select(vec2<f32>(_e3742, 1f), vec2<f32>(_e3628, 0f), vec2((_e3628 < _e3742)));
                                                    let _e3762 = select(vec2<f32>(_e3754, 3f), _e3758, vec2((_e3758.x < _e3754)));
                                                    let _e3768 = (_e3609.x + -0.000057729998f);
                                                    let _e3769 = (_e3616.z + 0.000057729998f);
                                                    let _e3771 = local_63;
                                                    let _e3773 = (_e3616.z + -2.4999423f);
                                                    let _e3777 = (sqrt(fma(_e3773, _e3773, fma(_e3768, _e3768, _e3624))) - 1f);
                                                    let _e3779 = local_64;
                                                    let _e3780 = (_e3779 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                                    let _e3790 = fma(0.9689124f, _e3780.z, fma(0.04851991f, _e3780.y, (_e3780.x * -0.24259955f)));
                                                    let _e3797 = (_e3780 + vec3<f32>((_e3790 * 0.4851991f), (_e3790 * -0.09703982f), (2f * fma(0.04851991f, fma(_e3780.z, -0.04851991f, (0.9689124f * _e3780.y)), (fma(0.24259955f, _e3780.z, (0.9689124f * _e3780.x)) * -0.24259955f)))));
                                                    let _e3817 = ((_e3797 + vec3<f32>(0f, (fma(0.38268346f, _e3797.y, (0.9238795f * _e3797.z)) * -0.7653669f), (fma(_e3797.z, -0.38268346f, (0.9238795f * _e3797.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e3823 = (sqrt(fma(_e3817.x, _e3817.x, (_e3817.z * _e3817.z))) + -0.5f);
                                                    let _e3826 = (abs(_e3817.y) - 0.1f);
                                                    let _e3829 = max(_e3823, 0f);
                                                    let _e3830 = max(_e3826, 0f);
                                                    let _e3835 = ((min(max(_e3823, _e3826), 0f) + sqrt(fma(_e3829, _e3829, (_e3830 * _e3830)))) - 0.1f);
                                                    let _e3836 = ((_e3797 + vec3<f32>((fma(0.70710677f, _e3797.x, (0.70710677f * _e3797.y)) * -1.4142135f), (fma(_e3797.y, -0.70710677f, (0.70710677f * _e3797.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e3841 = sqrt(fma(_e3836.x, _e3836.x, (_e3836.z * _e3836.z)));
                                                    let _e3842 = (_e3841 + -0.5f);
                                                    let _e3844 = abs(_e3836.y);
                                                    let _e3845 = (_e3844 - 0.1f);
                                                    let _e3848 = max(_e3842, 0f);
                                                    let _e3849 = max(_e3845, 0f);
                                                    let _e3854 = ((min(max(_e3842, _e3845), 0f) + sqrt(fma(_e3848, _e3848, (_e3849 * _e3849)))) - 0.1f);
                                                    let _e3855 = (_e3841 + -0.20000002f);
                                                    let _e3856 = (_e3844 - 0.4f);
                                                    let _e3859 = max(_e3855, 0f);
                                                    let _e3860 = max(_e3856, 0f);
                                                    let _e3864 = (min(max(_e3855, _e3856), 0f) + sqrt(fma(_e3859, _e3859, (_e3860 * _e3860))));
                                                    let _e3868 = fma(-((_e3854 + (_e3864 - 0.1f))), 5f, 0.5f);
                                                    if (_e3868 < 0f) {
                                                        phi_12952_ = 0f;
                                                    } else {
                                                        phi_12952_ = select(_e3868, 1f, (_e3868 > 1f));
                                                    }
                                                    let _e3873 = phi_12952_;
                                                    let _e3879 = fma((0.1f * _e3873), (1f - _e3873), fma(((0.1f - _e3864) - _e3854), _e3873, _e3854));
                                                    let _e3881 = fma((_e3879 - _e3835), 5f, 0.5f);
                                                    if (_e3881 < 0f) {
                                                        phi_12978_ = 0f;
                                                    } else {
                                                        phi_12978_ = select(_e3881, 1f, (_e3881 > 1f));
                                                    }
                                                    let _e3886 = phi_12978_;
                                                    let _e3891 = fma((_e3886 * -0.1f), (1f - _e3886), fma((_e3835 - _e3879), _e3886, _e3879));
                                                    let _e3893 = fma((_e3771 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                    let _e3897 = (_e3609.x + 0.99994224f);
                                                    let _e3901 = (sqrt(fma(_e3769, _e3769, fma(_e3897, _e3897, _e3750))) - 0.6f);
                                                    let _e3905 = select(vec2<f32>(_e3891, 1f), vec2<f32>(_e3777, 0f), vec2((_e3777 < _e3891)));
                                                    let _e3909 = select(vec2<f32>(_e3901, 3f), _e3905, vec2((_e3905.x < _e3901)));
                                                    let _e3915 = (-0.5773f * select(vec2<f32>(_e3893, 2f), _e3909, vec2((_e3909.x < _e3893))).x);
                                                    let _e3921 = local_65;
                                                    let _e3923 = (_e3613.y + 2.0000577f);
                                                    let _e3924 = (_e3923 * _e3923);
                                                    let _e3928 = (sqrt(fma(_e3623, _e3623, fma(_e3768, _e3768, _e3924))) - 1f);
                                                    let _e3930 = local_66;
                                                    let _e3931 = (_e3930 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                                    let _e3941 = fma(0.9689124f, _e3931.z, fma(0.04851991f, _e3931.y, (_e3931.x * -0.24259955f)));
                                                    let _e3948 = (_e3931 + vec3<f32>((_e3941 * 0.4851991f), (_e3941 * -0.09703982f), (2f * fma(0.04851991f, fma(_e3931.z, -0.04851991f, (0.9689124f * _e3931.y)), (fma(0.24259955f, _e3931.z, (0.9689124f * _e3931.x)) * -0.24259955f)))));
                                                    let _e3968 = ((_e3948 + vec3<f32>(0f, (fma(0.38268346f, _e3948.y, (0.9238795f * _e3948.z)) * -0.7653669f), (fma(_e3948.z, -0.38268346f, (0.9238795f * _e3948.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e3974 = (sqrt(fma(_e3968.x, _e3968.x, (_e3968.z * _e3968.z))) + -0.5f);
                                                    let _e3977 = (abs(_e3968.y) - 0.1f);
                                                    let _e3980 = max(_e3974, 0f);
                                                    let _e3981 = max(_e3977, 0f);
                                                    let _e3986 = ((min(max(_e3974, _e3977), 0f) + sqrt(fma(_e3980, _e3980, (_e3981 * _e3981)))) - 0.1f);
                                                    let _e3987 = ((_e3948 + vec3<f32>((fma(0.70710677f, _e3948.x, (0.70710677f * _e3948.y)) * -1.4142135f), (fma(_e3948.y, -0.70710677f, (0.70710677f * _e3948.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e3992 = sqrt(fma(_e3987.x, _e3987.x, (_e3987.z * _e3987.z)));
                                                    let _e3993 = (_e3992 + -0.5f);
                                                    let _e3995 = abs(_e3987.y);
                                                    let _e3996 = (_e3995 - 0.1f);
                                                    let _e3999 = max(_e3993, 0f);
                                                    let _e4000 = max(_e3996, 0f);
                                                    let _e4005 = ((min(max(_e3993, _e3996), 0f) + sqrt(fma(_e3999, _e3999, (_e4000 * _e4000)))) - 0.1f);
                                                    let _e4006 = (_e3992 + -0.20000002f);
                                                    let _e4007 = (_e3995 - 0.4f);
                                                    let _e4010 = max(_e4006, 0f);
                                                    let _e4011 = max(_e4007, 0f);
                                                    let _e4015 = (min(max(_e4006, _e4007), 0f) + sqrt(fma(_e4010, _e4010, (_e4011 * _e4011))));
                                                    let _e4019 = fma(-((_e4005 + (_e4015 - 0.1f))), 5f, 0.5f);
                                                    if (_e4019 < 0f) {
                                                        phi_13349_ = 0f;
                                                    } else {
                                                        phi_13349_ = select(_e4019, 1f, (_e4019 > 1f));
                                                    }
                                                    let _e4024 = phi_13349_;
                                                    let _e4030 = fma((0.1f * _e4024), (1f - _e4024), fma(((0.1f - _e4015) - _e4005), _e4024, _e4005));
                                                    let _e4032 = fma((_e4030 - _e3986), 5f, 0.5f);
                                                    if (_e4032 < 0f) {
                                                        phi_13375_ = 0f;
                                                    } else {
                                                        phi_13375_ = select(_e4032, 1f, (_e4032 > 1f));
                                                    }
                                                    let _e4037 = phi_13375_;
                                                    let _e4042 = fma((_e4037 * -0.1f), (1f - _e4037), fma((_e3986 - _e4030), _e4037, _e4030));
                                                    let _e4044 = fma((_e3921 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                    let _e4048 = (_e3613.y + -0.99994224f);
                                                    let _e4049 = (_e4048 * _e4048);
                                                    let _e4053 = (sqrt(fma(_e3618, _e3618, fma(_e3897, _e3897, _e4049))) - 0.6f);
                                                    let _e4057 = select(vec2<f32>(_e4042, 1f), vec2<f32>(_e3928, 0f), vec2((_e3928 < _e4042)));
                                                    let _e4061 = select(vec2<f32>(_e4053, 3f), _e4057, vec2((_e4057.x < _e4053)));
                                                    let _e4071 = local_67;
                                                    let _e4076 = (sqrt(fma(_e3773, _e3773, fma(_e3611, _e3611, _e3924))) - 1f);
                                                    let _e4078 = local_68;
                                                    let _e4079 = (_e4078 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                                    let _e4089 = fma(0.9689124f, _e4079.z, fma(0.04851991f, _e4079.y, (_e4079.x * -0.24259955f)));
                                                    let _e4096 = (_e4079 + vec3<f32>((_e4089 * 0.4851991f), (_e4089 * -0.09703982f), (2f * fma(0.04851991f, fma(_e4079.z, -0.04851991f, (0.9689124f * _e4079.y)), (fma(0.24259955f, _e4079.z, (0.9689124f * _e4079.x)) * -0.24259955f)))));
                                                    let _e4116 = ((_e4096 + vec3<f32>(0f, (fma(0.38268346f, _e4096.y, (0.9238795f * _e4096.z)) * -0.7653669f), (fma(_e4096.z, -0.38268346f, (0.9238795f * _e4096.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e4122 = (sqrt(fma(_e4116.x, _e4116.x, (_e4116.z * _e4116.z))) + -0.5f);
                                                    let _e4125 = (abs(_e4116.y) - 0.1f);
                                                    let _e4128 = max(_e4122, 0f);
                                                    let _e4129 = max(_e4125, 0f);
                                                    let _e4134 = ((min(max(_e4122, _e4125), 0f) + sqrt(fma(_e4128, _e4128, (_e4129 * _e4129)))) - 0.1f);
                                                    let _e4135 = ((_e4096 + vec3<f32>((fma(0.70710677f, _e4096.x, (0.70710677f * _e4096.y)) * -1.4142135f), (fma(_e4096.y, -0.70710677f, (0.70710677f * _e4096.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e4140 = sqrt(fma(_e4135.x, _e4135.x, (_e4135.z * _e4135.z)));
                                                    let _e4141 = (_e4140 + -0.5f);
                                                    let _e4143 = abs(_e4135.y);
                                                    let _e4144 = (_e4143 - 0.1f);
                                                    let _e4147 = max(_e4141, 0f);
                                                    let _e4148 = max(_e4144, 0f);
                                                    let _e4153 = ((min(max(_e4141, _e4144), 0f) + sqrt(fma(_e4147, _e4147, (_e4148 * _e4148)))) - 0.1f);
                                                    let _e4154 = (_e4140 + -0.20000002f);
                                                    let _e4155 = (_e4143 - 0.4f);
                                                    let _e4158 = max(_e4154, 0f);
                                                    let _e4159 = max(_e4155, 0f);
                                                    let _e4163 = (min(max(_e4154, _e4155), 0f) + sqrt(fma(_e4158, _e4158, (_e4159 * _e4159))));
                                                    let _e4167 = fma(-((_e4153 + (_e4163 - 0.1f))), 5f, 0.5f);
                                                    if (_e4167 < 0f) {
                                                        phi_13746_ = 0f;
                                                    } else {
                                                        phi_13746_ = select(_e4167, 1f, (_e4167 > 1f));
                                                    }
                                                    let _e4172 = phi_13746_;
                                                    let _e4178 = fma((0.1f * _e4172), (1f - _e4172), fma(((0.1f - _e4163) - _e4153), _e4172, _e4153));
                                                    let _e4180 = fma((_e4178 - _e4134), 5f, 0.5f);
                                                    if (_e4180 < 0f) {
                                                        phi_13772_ = 0f;
                                                    } else {
                                                        phi_13772_ = select(_e4180, 1f, (_e4180 > 1f));
                                                    }
                                                    let _e4185 = phi_13772_;
                                                    let _e4190 = fma((_e4185 * -0.1f), (1f - _e4185), fma((_e4134 - _e4178), _e4185, _e4178));
                                                    let _e4192 = fma((_e4071 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                    let _e4199 = (sqrt(fma(_e3769, _e3769, fma(_e3748, _e3748, _e4049))) - 0.6f);
                                                    let _e4203 = select(vec2<f32>(_e4190, 1f), vec2<f32>(_e4076, 0f), vec2((_e4076 < _e4190)));
                                                    let _e4207 = select(vec2<f32>(_e4199, 3f), _e4203, vec2((_e4203.x < _e4199)));
                                                    let _e4213 = fma(0.5773f, select(vec2<f32>(_e4192, 2f), _e4207, vec2((_e4207.x < _e4192))).x, fma(-0.5773f, select(vec2<f32>(_e4044, 2f), _e4061, vec2((_e4061.x < _e4044))).x, fma(0.5773f, select(vec2<f32>(_e3744, 2f), _e3762, vec2((_e3762.x < _e3744))).x, _e3915)));
                                                    let _e4214 = fma(0.5773f, select(vec2<f32>(_e4192, 2f), _e4207, vec2((_e4207.x < _e4192))).x, fma(0.5773f, select(vec2<f32>(_e4044, 2f), _e4061, vec2((_e4061.x < _e4044))).x, fma(-0.5773f, select(vec2<f32>(_e3744, 2f), _e3762, vec2((_e3762.x < _e3744))).x, _e3915)));
                                                    let _e4215 = fma(0.5773f, select(vec2<f32>(_e4192, 2f), _e4207, vec2((_e4207.x < _e4192))).x, fma(-0.5773f, select(vec2<f32>(_e4044, 2f), _e4061, vec2((_e4061.x < _e4044))).x, fma(-0.5773f, select(vec2<f32>(_e3744, 2f), _e3762, vec2((_e3762.x < _e3744))).x, (0.5773f * select(vec2<f32>(_e3893, 2f), _e3909, vec2((_e3909.x < _e3893))).x))));
                                                    let _e4220 = (1f / sqrt(fma(_e4215, _e4215, fma(_e4213, _e4213, (_e4214 * _e4214)))));
                                                    let _e4221 = (_e4213 * _e4220);
                                                    let _e4222 = (_e4214 * _e4220);
                                                    let _e4223 = (_e4215 * _e4220);
                                                    let _e4225 = local_69;
                                                    let _e4231 = select(select(u32(_e4225.y), 0u, (_e4225.y < 0f)), 4294967295u, (_e4225.y > 4294967000f));
                                                    if (_e4231 > (_e152 - 1u)) {
                                                        let _e4247 = local_71;
                                                        phi_2691_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e4221, _e4222, _e4223, _e4247), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                                    } else {
                                                        if (_e4231 < _e152) {
                                                        } else {
                                                            phi_23748_ = _e3285.member;
                                                            phi_23501_ = _e3413;
                                                            phi_23254_ = true;
                                                            phi_4716_ = bool();
                                                            phi_4715_ = bool();
                                                            phi_4713_ = f32();
                                                            break;
                                                        }
                                                        let _e4236 = global_4.member[_e4231];
                                                        let _e4238 = local_70;
                                                        phi_2691_ = type_26(_e4236.member, vec4<f32>(_e4221, _e4222, _e4223, _e4238), _e4236.member_2, _e4236.member_3, _e4236.member_4);
                                                    }
                                                    let _e4256 = phi_2691_;
                                                    phi_2692_ = _e4256;
                                                } else {
                                                    phi_2692_ = type_26();
                                                }
                                                let _e4258 = phi_2692_;
                                                let _e4260 = local_72;
                                                let _e4262 = local_73;
                                                let _e4265 = local_74;
                                                let _e4267 = local_75;
                                                if select(select(_e4267, false, _e4265), true, select(_e4262, false, _e4260)) {
                                                    phi_2703_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                                } else {
                                                    phi_2703_ = _e4258;
                                                }
                                                let _e4271 = phi_2703_;
                                                let _e4283 = (sqrt(fma(_e4271.member_1.z, _e4271.member_1.z, fma(_e4271.member_1.x, _e4271.member_1.x, (_e4271.member_1.y * _e4271.member_1.y)))) > 0f);
                                                if _e4283 {
                                                    let _e4285 = (_e4271.member_4.z > 0f);
                                                    if _e4285 {
                                                        phi_3187_ = type_31();
                                                        phi_3190_ = f32();
                                                        phi_3191_ = f32();
                                                        phi_3192_ = f32();
                                                        phi_3193_ = f32();
                                                        phi_3194_ = f32();
                                                        phi_3195_ = f32();
                                                    } else {
                                                        let _e4289 = (_e3291 * _e4271.member_2.x);
                                                        let _e4290 = (_e3293 * _e4271.member_2.y);
                                                        let _e4291 = (_e3295 * _e4271.member_2.z);
                                                        let _e4297 = (vec3<f32>((_e3406 * _e4271.member_1.w), (_e3409 * _e4271.member_1.w), (_e3412 * _e4271.member_1.w)) + _e3285.member);
                                                        let _e4306 = (_e3285.member_2 + vec2<f32>(2f, 3f));
                                                        let _e4324 = ((((select(select(u32(_e4306.x), 0u, (_e4306.x < 0f)), 4294967295u, (_e4306.x > 4294967000f)) * _e3285.member_3.y) + ((select(select(u32(_e4306.y), 0u, (_e4306.y < 0f)), 4294967295u, (_e4306.y > 4294967000f)) * _e3285.member_3.y) * _e2228)) * 747796405u) + 2891336453u);
                                                        let _e4332 = (((_e4324 >> bitcast<u32>((((_e4324 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e4324) * 277803737u);
                                                        let _e4337 = (f32(((_e4332 >> bitcast<u32>(22i)) ^ _e4332)) * 0.00000000023283064f);
                                                        if (_e4337 < 0f) {
                                                            phi_14004_ = 0f;
                                                        } else {
                                                            phi_14004_ = select(_e4337, 1f, (_e4337 > 1f));
                                                        }
                                                        let _e4342 = phi_14004_;
                                                        let _e4343 = (_e3285.member_2.y - 1f);
                                                        let _e4344 = (_e3285.member_2.x - 1f);
                                                        let _e4360 = ((((select(select(u32(_e4343), 0u, (_e4343 < 0f)), 4294967295u, (_e4343 > 4294967000f)) * _e3285.member_3.y) + ((select(select(u32(_e4344), 0u, (_e4344 < 0f)), 4294967295u, (_e4344 > 4294967000f)) * _e3285.member_3.y) * _e2228)) * 747796405u) + 2891336453u);
                                                        let _e4368 = (((_e4360 >> bitcast<u32>((((_e4360 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e4360) * 277803737u);
                                                        let _e4373 = (f32(((_e4368 >> bitcast<u32>(22i)) ^ _e4368)) * 0.00000000023283064f);
                                                        if (_e4373 < 0f) {
                                                            phi_14053_ = 0f;
                                                        } else {
                                                            phi_14053_ = select(_e4373, 1f, (_e4373 > 1f));
                                                        }
                                                        let _e4378 = phi_14053_;
                                                        let _e4380 = -(_e4297.x);
                                                        let _e4382 = (-2f - _e4297.y);
                                                        let _e4384 = (2.5f - _e4297.z);
                                                        let _e4388 = sqrt(fma(_e4384, _e4384, fma(_e4380, _e4380, (_e4382 * _e4382))));
                                                        let _e4389 = (_e4380 / _e4388);
                                                        let _e4390 = (_e4382 / _e4388);
                                                        let _e4391 = (_e4384 / _e4388);
                                                        let _e4398 = fma(_e4342, sqrt(max((1f - (1f / (_e4388 * _e4388))), 0f)), (1f - _e4342));
                                                        let _e4402 = sqrt(max(fma(-(_e4398), _e4398, 1f), 0f));
                                                        let _e4403 = (_e4378 * 6.2831855f);
                                                        let _e4405 = (cos(_e4403) * _e4402);
                                                        let _e4407 = (sin(_e4403) * _e4402);
                                                        if (abs(_e4389) > abs(_e4390)) {
                                                            let _e4420 = sqrt(fma(_e4389, _e4389, (_e4391 * _e4391)));
                                                            phi_14092_ = (-(_e4389) / _e4420);
                                                            phi_14093_ = 0f;
                                                            phi_14094_ = (_e4391 / _e4420);
                                                        } else {
                                                            let _e4414 = sqrt(fma(_e4390, _e4390, (_e4391 * _e4391)));
                                                            phi_14092_ = (_e4390 / _e4414);
                                                            phi_14093_ = (-(_e4391) / _e4414);
                                                            phi_14094_ = 0f;
                                                        }
                                                        let _e4424 = phi_14092_;
                                                        let _e4426 = phi_14093_;
                                                        let _e4428 = phi_14094_;
                                                        let _e4440 = fma(_e4407, _e4428, fma(_e4405, fma(_e4390, _e4424, -((_e4426 * _e4391))), (_e4398 * _e4389)));
                                                        let _e4443 = fma(_e4407, _e4426, fma(_e4405, fma(_e4391, _e4428, -((_e4424 * _e4389))), (_e4398 * _e4390)));
                                                        let _e4446 = fma(_e4407, _e4424, fma(_e4405, fma(_e4389, _e4426, -((_e4428 * _e4390))), (_e4398 * _e4391)));
                                                        let _e4450 = fma(_e4271.member_1.z, _e4446, fma(_e4271.member_1.x, _e4440, (_e4271.member_1.y * _e4443)));
                                                        if (_e4450 < 0f) {
                                                            phi_3171_ = true;
                                                            phi_3172_ = f32();
                                                            phi_3173_ = f32();
                                                            phi_3174_ = f32();
                                                        } else {
                                                            phi_2837_ = 0.01f;
                                                            phi_2840_ = 0u;
                                                            loop {
                                                                let _e4454 = phi_2837_;
                                                                let _e4456 = phi_2840_;
                                                                local_89 = _e4454;
                                                                local_90 = _e4454;
                                                                let _e4457 = (_e4456 < 300u);
                                                                if _e4457 {
                                                                    phi_2841_ = (_e4456 + 1u);
                                                                } else {
                                                                    phi_2841_ = _e4456;
                                                                }
                                                                let _e4460 = phi_2841_;
                                                                if _e4457 {
                                                                    let _e4465 = (vec3<f32>((_e4440 * _e4454), (_e4443 * _e4454), (_e4446 * _e4454)) + (_e4297 + vec3<f32>(_e4440, _e4443, _e4446)));
                                                                    let _e4466 = (_e4465 - vec3<f32>(0f, -2f, 2.5f));
                                                                    let _e4474 = (sqrt(fma(_e4466.z, _e4466.z, fma(_e4466.x, _e4466.x, (_e4466.y * _e4466.y)))) - 1f);
                                                                    let _e4475 = (_e4465 + vec3<f32>(0f, -1f, 0f));
                                                                    let _e4485 = fma(0.9689124f, _e4475.z, fma(0.04851991f, _e4475.y, (_e4475.x * -0.24259955f)));
                                                                    let _e4492 = (_e4475 + vec3<f32>((_e4485 * 0.4851991f), (_e4485 * -0.09703982f), (2f * fma(0.04851991f, fma(_e4475.z, -0.04851991f, (0.9689124f * _e4475.y)), (fma(0.24259955f, _e4475.z, (0.9689124f * _e4475.x)) * -0.24259955f)))));
                                                                    let _e4512 = ((_e4492 + vec3<f32>(0f, (fma(0.38268346f, _e4492.y, (0.9238795f * _e4492.z)) * -0.7653669f), (fma(_e4492.z, -0.38268346f, (0.9238795f * _e4492.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                                    let _e4518 = (sqrt(fma(_e4512.x, _e4512.x, (_e4512.z * _e4512.z))) + -0.5f);
                                                                    let _e4521 = (abs(_e4512.y) - 0.1f);
                                                                    let _e4524 = max(_e4518, 0f);
                                                                    let _e4525 = max(_e4521, 0f);
                                                                    let _e4530 = ((min(max(_e4518, _e4521), 0f) + sqrt(fma(_e4524, _e4524, (_e4525 * _e4525)))) - 0.1f);
                                                                    let _e4531 = ((_e4492 + vec3<f32>((fma(0.70710677f, _e4492.x, (0.70710677f * _e4492.y)) * -1.4142135f), (fma(_e4492.y, -0.70710677f, (0.70710677f * _e4492.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                                    let _e4536 = sqrt(fma(_e4531.x, _e4531.x, (_e4531.z * _e4531.z)));
                                                                    let _e4537 = (_e4536 + -0.5f);
                                                                    let _e4539 = abs(_e4531.y);
                                                                    let _e4540 = (_e4539 - 0.1f);
                                                                    let _e4543 = max(_e4537, 0f);
                                                                    let _e4544 = max(_e4540, 0f);
                                                                    let _e4549 = ((min(max(_e4537, _e4540), 0f) + sqrt(fma(_e4543, _e4543, (_e4544 * _e4544)))) - 0.1f);
                                                                    let _e4550 = (_e4536 + -0.20000002f);
                                                                    let _e4551 = (_e4539 - 0.4f);
                                                                    let _e4554 = max(_e4550, 0f);
                                                                    let _e4555 = max(_e4551, 0f);
                                                                    let _e4559 = (min(max(_e4550, _e4551), 0f) + sqrt(fma(_e4554, _e4554, (_e4555 * _e4555))));
                                                                    let _e4563 = fma(-((_e4549 + (_e4559 - 0.1f))), 5f, 0.5f);
                                                                    if (_e4563 < 0f) {
                                                                        phi_14471_ = 0f;
                                                                    } else {
                                                                        phi_14471_ = select(_e4563, 1f, (_e4563 > 1f));
                                                                    }
                                                                    let _e4568 = phi_14471_;
                                                                    let _e4574 = fma((0.1f * _e4568), (1f - _e4568), fma(((0.1f - _e4559) - _e4549), _e4568, _e4549));
                                                                    let _e4576 = fma((_e4574 - _e4530), 5f, 0.5f);
                                                                    if (_e4576 < 0f) {
                                                                        phi_14497_ = 0f;
                                                                    } else {
                                                                        phi_14497_ = select(_e4576, 1f, (_e4576 > 1f));
                                                                    }
                                                                    let _e4581 = phi_14497_;
                                                                    let _e4586 = fma((_e4581 * -0.1f), (1f - _e4581), fma((_e4530 - _e4574), _e4581, _e4574));
                                                                    let _e4588 = fma(_e4465.y, -1f, 3f);
                                                                    let _e4592 = (_e4465 - vec3<f32>(-1f, 1f, 0f));
                                                                    let _e4600 = (sqrt(fma(_e4592.z, _e4592.z, fma(_e4592.x, _e4592.x, (_e4592.y * _e4592.y)))) - 0.6f);
                                                                    let _e4604 = select(vec2<f32>(_e4586, 1f), vec2<f32>(_e4474, 0f), vec2((_e4474 < _e4586)));
                                                                    let _e4608 = select(vec2<f32>(_e4600, 3f), _e4604, vec2((_e4604.x < _e4600)));
                                                                    let _e4612 = select(vec2<f32>(_e4588, 2f), _e4608, vec2((_e4608.x < _e4588)));
                                                                    let _e4614 = (_e4612.x < 0.001f);
                                                                    if _e4614 {
                                                                        phi_2896_ = f32();
                                                                        phi_2897_ = false;
                                                                        phi_2898_ = false;
                                                                    } else {
                                                                        let _e4615 = (_e4454 > 22f);
                                                                        if _e4615 {
                                                                            phi_2894_ = f32();
                                                                        } else {
                                                                            phi_2894_ = (_e4454 + _e4612.x);
                                                                        }
                                                                        let _e4618 = phi_2894_;
                                                                        phi_2896_ = _e4618;
                                                                        phi_2897_ = select(true, false, _e4615);
                                                                        phi_2898_ = _e4615;
                                                                    }
                                                                    let _e4621 = phi_2896_;
                                                                    let _e4623 = phi_2897_;
                                                                    let _e4625 = phi_2898_;
                                                                    phi_2899_ = _e4465;
                                                                    phi_2900_ = _e4612;
                                                                    phi_2838_ = _e4621;
                                                                    phi_2901_ = _e4623;
                                                                    phi_2902_ = _e4614;
                                                                    phi_2903_ = _e4625;
                                                                } else {
                                                                    phi_2899_ = vec3<f32>();
                                                                    phi_2900_ = vec2<f32>();
                                                                    phi_2838_ = f32();
                                                                    phi_2901_ = false;
                                                                    phi_2902_ = false;
                                                                    phi_2903_ = false;
                                                                }
                                                                let _e4627 = phi_2899_;
                                                                let _e4629 = phi_2900_;
                                                                let _e4631 = phi_2838_;
                                                                let _e4633 = phi_2901_;
                                                                let _e4635 = phi_2902_;
                                                                let _e4637 = phi_2903_;
                                                                local_76 = _e4635;
                                                                local_77 = _e4627;
                                                                local_78 = _e4627;
                                                                local_79 = _e4627;
                                                                local_80 = _e4627;
                                                                local_81 = _e4627;
                                                                local_82 = _e4627;
                                                                local_83 = _e4627;
                                                                local_84 = _e4627;
                                                                local_85 = _e4627;
                                                                local_86 = _e4627;
                                                                local_87 = _e4627;
                                                                local_88 = _e4629;
                                                                local_91 = _e4635;
                                                                local_92 = _e4637;
                                                                local_93 = _e4635;
                                                                local_94 = select(true, false, _e4457);
                                                                continue;
                                                                continuing {
                                                                    phi_2837_ = _e4631;
                                                                    phi_2840_ = _e4460;
                                                                    break if !(_e4633);
                                                                }
                                                            }
                                                            let _e4641 = local_76;
                                                            if _e4641 {
                                                                let _e4643 = local_77;
                                                                let _e4645 = (_e4643.x + 0.000057729998f);
                                                                let _e4647 = local_78;
                                                                let _e4650 = local_79;
                                                                let _e4652 = (_e4650.z + -0.000057729998f);
                                                                let _e4654 = local_80;
                                                                let _e4656 = (_e4647.y + 1.9999423f);
                                                                let _e4657 = (_e4650.z + -2.5000577f);
                                                                let _e4658 = (_e4656 * _e4656);
                                                                let _e4662 = (sqrt(fma(_e4657, _e4657, fma(_e4645, _e4645, _e4658))) - 1f);
                                                                let _e4664 = local_81;
                                                                let _e4665 = (_e4664 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                                                let _e4675 = fma(0.9689124f, _e4665.z, fma(0.04851991f, _e4665.y, (_e4665.x * -0.24259955f)));
                                                                let _e4682 = (_e4665 + vec3<f32>((_e4675 * 0.4851991f), (_e4675 * -0.09703982f), (2f * fma(0.04851991f, fma(_e4665.z, -0.04851991f, (0.9689124f * _e4665.y)), (fma(0.24259955f, _e4665.z, (0.9689124f * _e4665.x)) * -0.24259955f)))));
                                                                let _e4702 = ((_e4682 + vec3<f32>(0f, (fma(0.38268346f, _e4682.y, (0.9238795f * _e4682.z)) * -0.7653669f), (fma(_e4682.z, -0.38268346f, (0.9238795f * _e4682.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                                let _e4708 = (sqrt(fma(_e4702.x, _e4702.x, (_e4702.z * _e4702.z))) + -0.5f);
                                                                let _e4711 = (abs(_e4702.y) - 0.1f);
                                                                let _e4714 = max(_e4708, 0f);
                                                                let _e4715 = max(_e4711, 0f);
                                                                let _e4720 = ((min(max(_e4708, _e4711), 0f) + sqrt(fma(_e4714, _e4714, (_e4715 * _e4715)))) - 0.1f);
                                                                let _e4721 = ((_e4682 + vec3<f32>((fma(0.70710677f, _e4682.x, (0.70710677f * _e4682.y)) * -1.4142135f), (fma(_e4682.y, -0.70710677f, (0.70710677f * _e4682.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                                let _e4726 = sqrt(fma(_e4721.x, _e4721.x, (_e4721.z * _e4721.z)));
                                                                let _e4727 = (_e4726 + -0.5f);
                                                                let _e4729 = abs(_e4721.y);
                                                                let _e4730 = (_e4729 - 0.1f);
                                                                let _e4733 = max(_e4727, 0f);
                                                                let _e4734 = max(_e4730, 0f);
                                                                let _e4739 = ((min(max(_e4727, _e4730), 0f) + sqrt(fma(_e4733, _e4733, (_e4734 * _e4734)))) - 0.1f);
                                                                let _e4740 = (_e4726 + -0.20000002f);
                                                                let _e4741 = (_e4729 - 0.4f);
                                                                let _e4744 = max(_e4740, 0f);
                                                                let _e4745 = max(_e4741, 0f);
                                                                let _e4749 = (min(max(_e4740, _e4741), 0f) + sqrt(fma(_e4744, _e4744, (_e4745 * _e4745))));
                                                                let _e4753 = fma(-((_e4739 + (_e4749 - 0.1f))), 5f, 0.5f);
                                                                if (_e4753 < 0f) {
                                                                    phi_14868_ = 0f;
                                                                } else {
                                                                    phi_14868_ = select(_e4753, 1f, (_e4753 > 1f));
                                                                }
                                                                let _e4758 = phi_14868_;
                                                                let _e4764 = fma((0.1f * _e4758), (1f - _e4758), fma(((0.1f - _e4749) - _e4739), _e4758, _e4739));
                                                                let _e4766 = fma((_e4764 - _e4720), 5f, 0.5f);
                                                                if (_e4766 < 0f) {
                                                                    phi_14894_ = 0f;
                                                                } else {
                                                                    phi_14894_ = select(_e4766, 1f, (_e4766 > 1f));
                                                                }
                                                                let _e4771 = phi_14894_;
                                                                let _e4776 = fma((_e4771 * -0.1f), (1f - _e4771), fma((_e4720 - _e4764), _e4771, _e4764));
                                                                let _e4778 = fma((_e4654 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                                let _e4782 = (_e4643.x + 1.0000577f);
                                                                let _e4783 = (_e4647.y + -1.0000577f);
                                                                let _e4784 = (_e4783 * _e4783);
                                                                let _e4788 = (sqrt(fma(_e4652, _e4652, fma(_e4782, _e4782, _e4784))) - 0.6f);
                                                                let _e4792 = select(vec2<f32>(_e4776, 1f), vec2<f32>(_e4662, 0f), vec2((_e4662 < _e4776)));
                                                                let _e4796 = select(vec2<f32>(_e4788, 3f), _e4792, vec2((_e4792.x < _e4788)));
                                                                let _e4802 = (_e4643.x + -0.000057729998f);
                                                                let _e4803 = (_e4650.z + 0.000057729998f);
                                                                let _e4805 = local_82;
                                                                let _e4807 = (_e4650.z + -2.4999423f);
                                                                let _e4811 = (sqrt(fma(_e4807, _e4807, fma(_e4802, _e4802, _e4658))) - 1f);
                                                                let _e4813 = local_83;
                                                                let _e4814 = (_e4813 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                                                let _e4824 = fma(0.9689124f, _e4814.z, fma(0.04851991f, _e4814.y, (_e4814.x * -0.24259955f)));
                                                                let _e4831 = (_e4814 + vec3<f32>((_e4824 * 0.4851991f), (_e4824 * -0.09703982f), (2f * fma(0.04851991f, fma(_e4814.z, -0.04851991f, (0.9689124f * _e4814.y)), (fma(0.24259955f, _e4814.z, (0.9689124f * _e4814.x)) * -0.24259955f)))));
                                                                let _e4851 = ((_e4831 + vec3<f32>(0f, (fma(0.38268346f, _e4831.y, (0.9238795f * _e4831.z)) * -0.7653669f), (fma(_e4831.z, -0.38268346f, (0.9238795f * _e4831.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                                let _e4857 = (sqrt(fma(_e4851.x, _e4851.x, (_e4851.z * _e4851.z))) + -0.5f);
                                                                let _e4860 = (abs(_e4851.y) - 0.1f);
                                                                let _e4863 = max(_e4857, 0f);
                                                                let _e4864 = max(_e4860, 0f);
                                                                let _e4869 = ((min(max(_e4857, _e4860), 0f) + sqrt(fma(_e4863, _e4863, (_e4864 * _e4864)))) - 0.1f);
                                                                let _e4870 = ((_e4831 + vec3<f32>((fma(0.70710677f, _e4831.x, (0.70710677f * _e4831.y)) * -1.4142135f), (fma(_e4831.y, -0.70710677f, (0.70710677f * _e4831.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                                let _e4875 = sqrt(fma(_e4870.x, _e4870.x, (_e4870.z * _e4870.z)));
                                                                let _e4876 = (_e4875 + -0.5f);
                                                                let _e4878 = abs(_e4870.y);
                                                                let _e4879 = (_e4878 - 0.1f);
                                                                let _e4882 = max(_e4876, 0f);
                                                                let _e4883 = max(_e4879, 0f);
                                                                let _e4888 = ((min(max(_e4876, _e4879), 0f) + sqrt(fma(_e4882, _e4882, (_e4883 * _e4883)))) - 0.1f);
                                                                let _e4889 = (_e4875 + -0.20000002f);
                                                                let _e4890 = (_e4878 - 0.4f);
                                                                let _e4893 = max(_e4889, 0f);
                                                                let _e4894 = max(_e4890, 0f);
                                                                let _e4898 = (min(max(_e4889, _e4890), 0f) + sqrt(fma(_e4893, _e4893, (_e4894 * _e4894))));
                                                                let _e4902 = fma(-((_e4888 + (_e4898 - 0.1f))), 5f, 0.5f);
                                                                if (_e4902 < 0f) {
                                                                    phi_15265_ = 0f;
                                                                } else {
                                                                    phi_15265_ = select(_e4902, 1f, (_e4902 > 1f));
                                                                }
                                                                let _e4907 = phi_15265_;
                                                                let _e4913 = fma((0.1f * _e4907), (1f - _e4907), fma(((0.1f - _e4898) - _e4888), _e4907, _e4888));
                                                                let _e4915 = fma((_e4913 - _e4869), 5f, 0.5f);
                                                                if (_e4915 < 0f) {
                                                                    phi_15291_ = 0f;
                                                                } else {
                                                                    phi_15291_ = select(_e4915, 1f, (_e4915 > 1f));
                                                                }
                                                                let _e4920 = phi_15291_;
                                                                let _e4925 = fma((_e4920 * -0.1f), (1f - _e4920), fma((_e4869 - _e4913), _e4920, _e4913));
                                                                let _e4927 = fma((_e4805 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                                let _e4931 = (_e4643.x + 0.99994224f);
                                                                let _e4935 = (sqrt(fma(_e4803, _e4803, fma(_e4931, _e4931, _e4784))) - 0.6f);
                                                                let _e4939 = select(vec2<f32>(_e4925, 1f), vec2<f32>(_e4811, 0f), vec2((_e4811 < _e4925)));
                                                                let _e4943 = select(vec2<f32>(_e4935, 3f), _e4939, vec2((_e4939.x < _e4935)));
                                                                let _e4949 = (-0.5773f * select(vec2<f32>(_e4927, 2f), _e4943, vec2((_e4943.x < _e4927))).x);
                                                                let _e4955 = local_84;
                                                                let _e4957 = (_e4647.y + 2.0000577f);
                                                                let _e4958 = (_e4957 * _e4957);
                                                                let _e4962 = (sqrt(fma(_e4657, _e4657, fma(_e4802, _e4802, _e4958))) - 1f);
                                                                let _e4964 = local_85;
                                                                let _e4965 = (_e4964 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                                                let _e4975 = fma(0.9689124f, _e4965.z, fma(0.04851991f, _e4965.y, (_e4965.x * -0.24259955f)));
                                                                let _e4982 = (_e4965 + vec3<f32>((_e4975 * 0.4851991f), (_e4975 * -0.09703982f), (2f * fma(0.04851991f, fma(_e4965.z, -0.04851991f, (0.9689124f * _e4965.y)), (fma(0.24259955f, _e4965.z, (0.9689124f * _e4965.x)) * -0.24259955f)))));
                                                                let _e5002 = ((_e4982 + vec3<f32>(0f, (fma(0.38268346f, _e4982.y, (0.9238795f * _e4982.z)) * -0.7653669f), (fma(_e4982.z, -0.38268346f, (0.9238795f * _e4982.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                                let _e5008 = (sqrt(fma(_e5002.x, _e5002.x, (_e5002.z * _e5002.z))) + -0.5f);
                                                                let _e5011 = (abs(_e5002.y) - 0.1f);
                                                                let _e5014 = max(_e5008, 0f);
                                                                let _e5015 = max(_e5011, 0f);
                                                                let _e5020 = ((min(max(_e5008, _e5011), 0f) + sqrt(fma(_e5014, _e5014, (_e5015 * _e5015)))) - 0.1f);
                                                                let _e5021 = ((_e4982 + vec3<f32>((fma(0.70710677f, _e4982.x, (0.70710677f * _e4982.y)) * -1.4142135f), (fma(_e4982.y, -0.70710677f, (0.70710677f * _e4982.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                                let _e5026 = sqrt(fma(_e5021.x, _e5021.x, (_e5021.z * _e5021.z)));
                                                                let _e5027 = (_e5026 + -0.5f);
                                                                let _e5029 = abs(_e5021.y);
                                                                let _e5030 = (_e5029 - 0.1f);
                                                                let _e5033 = max(_e5027, 0f);
                                                                let _e5034 = max(_e5030, 0f);
                                                                let _e5039 = ((min(max(_e5027, _e5030), 0f) + sqrt(fma(_e5033, _e5033, (_e5034 * _e5034)))) - 0.1f);
                                                                let _e5040 = (_e5026 + -0.20000002f);
                                                                let _e5041 = (_e5029 - 0.4f);
                                                                let _e5044 = max(_e5040, 0f);
                                                                let _e5045 = max(_e5041, 0f);
                                                                let _e5049 = (min(max(_e5040, _e5041), 0f) + sqrt(fma(_e5044, _e5044, (_e5045 * _e5045))));
                                                                let _e5053 = fma(-((_e5039 + (_e5049 - 0.1f))), 5f, 0.5f);
                                                                if (_e5053 < 0f) {
                                                                    phi_15662_ = 0f;
                                                                } else {
                                                                    phi_15662_ = select(_e5053, 1f, (_e5053 > 1f));
                                                                }
                                                                let _e5058 = phi_15662_;
                                                                let _e5064 = fma((0.1f * _e5058), (1f - _e5058), fma(((0.1f - _e5049) - _e5039), _e5058, _e5039));
                                                                let _e5066 = fma((_e5064 - _e5020), 5f, 0.5f);
                                                                if (_e5066 < 0f) {
                                                                    phi_15688_ = 0f;
                                                                } else {
                                                                    phi_15688_ = select(_e5066, 1f, (_e5066 > 1f));
                                                                }
                                                                let _e5071 = phi_15688_;
                                                                let _e5076 = fma((_e5071 * -0.1f), (1f - _e5071), fma((_e5020 - _e5064), _e5071, _e5064));
                                                                let _e5078 = fma((_e4955 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                                let _e5082 = (_e4647.y + -0.99994224f);
                                                                let _e5083 = (_e5082 * _e5082);
                                                                let _e5087 = (sqrt(fma(_e4652, _e4652, fma(_e4931, _e4931, _e5083))) - 0.6f);
                                                                let _e5091 = select(vec2<f32>(_e5076, 1f), vec2<f32>(_e4962, 0f), vec2((_e4962 < _e5076)));
                                                                let _e5095 = select(vec2<f32>(_e5087, 3f), _e5091, vec2((_e5091.x < _e5087)));
                                                                let _e5105 = local_86;
                                                                let _e5110 = (sqrt(fma(_e4807, _e4807, fma(_e4645, _e4645, _e4958))) - 1f);
                                                                let _e5112 = local_87;
                                                                let _e5113 = (_e5112 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                                                let _e5123 = fma(0.9689124f, _e5113.z, fma(0.04851991f, _e5113.y, (_e5113.x * -0.24259955f)));
                                                                let _e5130 = (_e5113 + vec3<f32>((_e5123 * 0.4851991f), (_e5123 * -0.09703982f), (2f * fma(0.04851991f, fma(_e5113.z, -0.04851991f, (0.9689124f * _e5113.y)), (fma(0.24259955f, _e5113.z, (0.9689124f * _e5113.x)) * -0.24259955f)))));
                                                                let _e5150 = ((_e5130 + vec3<f32>(0f, (fma(0.38268346f, _e5130.y, (0.9238795f * _e5130.z)) * -0.7653669f), (fma(_e5130.z, -0.38268346f, (0.9238795f * _e5130.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                                let _e5156 = (sqrt(fma(_e5150.x, _e5150.x, (_e5150.z * _e5150.z))) + -0.5f);
                                                                let _e5159 = (abs(_e5150.y) - 0.1f);
                                                                let _e5162 = max(_e5156, 0f);
                                                                let _e5163 = max(_e5159, 0f);
                                                                let _e5168 = ((min(max(_e5156, _e5159), 0f) + sqrt(fma(_e5162, _e5162, (_e5163 * _e5163)))) - 0.1f);
                                                                let _e5169 = ((_e5130 + vec3<f32>((fma(0.70710677f, _e5130.x, (0.70710677f * _e5130.y)) * -1.4142135f), (fma(_e5130.y, -0.70710677f, (0.70710677f * _e5130.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                                let _e5174 = sqrt(fma(_e5169.x, _e5169.x, (_e5169.z * _e5169.z)));
                                                                let _e5175 = (_e5174 + -0.5f);
                                                                let _e5177 = abs(_e5169.y);
                                                                let _e5178 = (_e5177 - 0.1f);
                                                                let _e5181 = max(_e5175, 0f);
                                                                let _e5182 = max(_e5178, 0f);
                                                                let _e5187 = ((min(max(_e5175, _e5178), 0f) + sqrt(fma(_e5181, _e5181, (_e5182 * _e5182)))) - 0.1f);
                                                                let _e5188 = (_e5174 + -0.20000002f);
                                                                let _e5189 = (_e5177 - 0.4f);
                                                                let _e5192 = max(_e5188, 0f);
                                                                let _e5193 = max(_e5189, 0f);
                                                                let _e5197 = (min(max(_e5188, _e5189), 0f) + sqrt(fma(_e5192, _e5192, (_e5193 * _e5193))));
                                                                let _e5201 = fma(-((_e5187 + (_e5197 - 0.1f))), 5f, 0.5f);
                                                                if (_e5201 < 0f) {
                                                                    phi_16059_ = 0f;
                                                                } else {
                                                                    phi_16059_ = select(_e5201, 1f, (_e5201 > 1f));
                                                                }
                                                                let _e5206 = phi_16059_;
                                                                let _e5212 = fma((0.1f * _e5206), (1f - _e5206), fma(((0.1f - _e5197) - _e5187), _e5206, _e5187));
                                                                let _e5214 = fma((_e5212 - _e5168), 5f, 0.5f);
                                                                if (_e5214 < 0f) {
                                                                    phi_16085_ = 0f;
                                                                } else {
                                                                    phi_16085_ = select(_e5214, 1f, (_e5214 > 1f));
                                                                }
                                                                let _e5219 = phi_16085_;
                                                                let _e5224 = fma((_e5219 * -0.1f), (1f - _e5219), fma((_e5168 - _e5212), _e5219, _e5212));
                                                                let _e5226 = fma((_e5105 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                                let _e5233 = (sqrt(fma(_e4803, _e4803, fma(_e4782, _e4782, _e5083))) - 0.6f);
                                                                let _e5237 = select(vec2<f32>(_e5224, 1f), vec2<f32>(_e5110, 0f), vec2((_e5110 < _e5224)));
                                                                let _e5241 = select(vec2<f32>(_e5233, 3f), _e5237, vec2((_e5237.x < _e5233)));
                                                                let _e5247 = fma(0.5773f, select(vec2<f32>(_e5226, 2f), _e5241, vec2((_e5241.x < _e5226))).x, fma(-0.5773f, select(vec2<f32>(_e5078, 2f), _e5095, vec2((_e5095.x < _e5078))).x, fma(0.5773f, select(vec2<f32>(_e4778, 2f), _e4796, vec2((_e4796.x < _e4778))).x, _e4949)));
                                                                let _e5248 = fma(0.5773f, select(vec2<f32>(_e5226, 2f), _e5241, vec2((_e5241.x < _e5226))).x, fma(0.5773f, select(vec2<f32>(_e5078, 2f), _e5095, vec2((_e5095.x < _e5078))).x, fma(-0.5773f, select(vec2<f32>(_e4778, 2f), _e4796, vec2((_e4796.x < _e4778))).x, _e4949)));
                                                                let _e5249 = fma(0.5773f, select(vec2<f32>(_e5226, 2f), _e5241, vec2((_e5241.x < _e5226))).x, fma(-0.5773f, select(vec2<f32>(_e5078, 2f), _e5095, vec2((_e5095.x < _e5078))).x, fma(-0.5773f, select(vec2<f32>(_e4778, 2f), _e4796, vec2((_e4796.x < _e4778))).x, (0.5773f * select(vec2<f32>(_e4927, 2f), _e4943, vec2((_e4943.x < _e4927))).x))));
                                                                let _e5254 = (1f / sqrt(fma(_e5249, _e5249, fma(_e5247, _e5247, (_e5248 * _e5248)))));
                                                                let _e5255 = (_e5247 * _e5254);
                                                                let _e5256 = (_e5248 * _e5254);
                                                                let _e5257 = (_e5249 * _e5254);
                                                                let _e5259 = local_88;
                                                                let _e5265 = select(select(u32(_e5259.y), 0u, (_e5259.y < 0f)), 4294967295u, (_e5259.y > 4294967000f));
                                                                if (_e5265 > (_e152 - 1u)) {
                                                                    let _e5281 = local_90;
                                                                    phi_3123_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e5255, _e5256, _e5257, _e5281), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                                                } else {
                                                                    if (_e5265 < _e152) {
                                                                    } else {
                                                                        phi_23748_ = _e3285.member;
                                                                        phi_23501_ = _e3413;
                                                                        phi_23254_ = true;
                                                                        phi_4716_ = bool();
                                                                        phi_4715_ = bool();
                                                                        phi_4713_ = f32();
                                                                        break;
                                                                    }
                                                                    let _e5270 = global_4.member[_e5265];
                                                                    let _e5272 = local_89;
                                                                    phi_3123_ = type_26(_e5270.member, vec4<f32>(_e5255, _e5256, _e5257, _e5272), _e5270.member_2, _e5270.member_3, _e5270.member_4);
                                                                }
                                                                let _e5290 = phi_3123_;
                                                                phi_3124_ = _e5290;
                                                            } else {
                                                                phi_3124_ = type_26();
                                                            }
                                                            let _e5292 = phi_3124_;
                                                            let _e5294 = local_91;
                                                            let _e5296 = local_92;
                                                            let _e5299 = local_93;
                                                            let _e5301 = local_94;
                                                            if select(select(_e5301, false, _e5299), true, select(_e5296, false, _e5294)) {
                                                                phi_3135_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                                            } else {
                                                                phi_3135_ = _e5292;
                                                            }
                                                            let _e5305 = phi_3135_;
                                                            let _e5316 = (sqrt(fma(_e5305.member_1.z, _e5305.member_1.z, fma(_e5305.member_1.x, _e5305.member_1.x, (_e5305.member_1.y * _e5305.member_1.y)))) > 0f);
                                                            if _e5316 {
                                                                if (_e5305.member_4.z > 0f) {
                                                                    let _e5320 = (_e5305.member_1.w + 1f);
                                                                    let _e5330 = (_e5320 * _e5320);
                                                                    phi_3164_ = (((_e5305.member_2.x * _e5305.member_4.z) * _e4450) / _e5330);
                                                                    phi_3165_ = (((_e5305.member_2.y * _e5305.member_4.z) * _e4450) / _e5330);
                                                                    phi_3166_ = (((_e5305.member_2.z * _e5305.member_4.z) * _e4450) / _e5330);
                                                                } else {
                                                                    phi_3164_ = 0f;
                                                                    phi_3165_ = 0f;
                                                                    phi_3166_ = 0f;
                                                                }
                                                                let _e5335 = phi_3164_;
                                                                let _e5337 = phi_3165_;
                                                                let _e5339 = phi_3166_;
                                                                phi_3168_ = _e5335;
                                                                phi_3169_ = _e5337;
                                                                phi_3170_ = _e5339;
                                                            } else {
                                                                phi_3168_ = f32();
                                                                phi_3169_ = f32();
                                                                phi_3170_ = f32();
                                                            }
                                                            let _e5341 = phi_3168_;
                                                            let _e5343 = phi_3169_;
                                                            let _e5345 = phi_3170_;
                                                            phi_3171_ = select(true, false, _e5316);
                                                            phi_3172_ = _e5341;
                                                            phi_3173_ = _e5343;
                                                            phi_3174_ = _e5345;
                                                        }
                                                        let _e5348 = phi_3171_;
                                                        let _e5350 = phi_3172_;
                                                        let _e5352 = phi_3173_;
                                                        let _e5354 = phi_3174_;
                                                        phi_3187_ = type_31(_e4297, _e3285.member_1, _e3285.member_2, _e3285.member_3);
                                                        phi_3190_ = _e4289;
                                                        phi_3191_ = _e4290;
                                                        phi_3192_ = _e4291;
                                                        phi_3193_ = fma((_e4289 * _e3417), select(_e5350, 0f, _e5348), _e3297);
                                                        phi_3194_ = fma((_e4290 * _e3417), select(_e5352, 0f, _e5348), _e3299);
                                                        phi_3195_ = fma((_e4291 * _e3417), select(_e5354, 0f, _e5348), _e3301);
                                                    }
                                                    let _e5362 = phi_3187_;
                                                    let _e5364 = phi_3190_;
                                                    let _e5366 = phi_3191_;
                                                    let _e5368 = phi_3192_;
                                                    let _e5370 = phi_3193_;
                                                    let _e5372 = phi_3194_;
                                                    let _e5374 = phi_3195_;
                                                    phi_3196_ = _e5362;
                                                    phi_3197_ = select(vec3<f32>(_e4271.member_1.x, _e4271.member_1.y, _e4271.member_1.z), vec3<f32>(), vec3(_e4285));
                                                    phi_3198_ = select(true, false, _e4285);
                                                    phi_3199_ = _e4285;
                                                    phi_3201_ = _e5364;
                                                    phi_3202_ = _e5366;
                                                    phi_3203_ = _e5368;
                                                    phi_3204_ = _e5370;
                                                    phi_3205_ = _e5372;
                                                    phi_3206_ = _e5374;
                                                } else {
                                                    phi_3196_ = type_31();
                                                    phi_3197_ = vec3<f32>();
                                                    phi_3198_ = false;
                                                    phi_3199_ = false;
                                                    phi_3201_ = f32();
                                                    phi_3202_ = f32();
                                                    phi_3203_ = f32();
                                                    phi_3204_ = f32();
                                                    phi_3205_ = f32();
                                                    phi_3206_ = f32();
                                                }
                                                let _e5379 = phi_3196_;
                                                let _e5381 = phi_3197_;
                                                let _e5383 = phi_3198_;
                                                let _e5385 = phi_3199_;
                                                let _e5387 = phi_3201_;
                                                let _e5389 = phi_3202_;
                                                let _e5391 = phi_3203_;
                                                let _e5393 = phi_3204_;
                                                let _e5395 = phi_3205_;
                                                let _e5397 = phi_3206_;
                                                phi_23838_ = _e3285.member;
                                                phi_23591_ = _e3413;
                                                phi_3207_ = _e3417;
                                                phi_2310_ = _e5379;
                                                phi_2313_ = _e5381;
                                                phi_3209_ = _e5383;
                                                phi_3210_ = _e5385;
                                                phi_3211_ = select(true, false, _e4283);
                                                phi_2317_ = _e5387;
                                                phi_2319_ = _e5389;
                                                phi_2321_ = _e5391;
                                                phi_2323_ = _e5393;
                                                phi_2325_ = _e5395;
                                                phi_2327_ = _e5397;
                                            } else {
                                                phi_23838_ = _e3281;
                                                phi_23591_ = _e3283;
                                                phi_3207_ = f32();
                                                phi_2310_ = type_31();
                                                phi_2313_ = vec3<f32>();
                                                phi_3209_ = false;
                                                phi_3210_ = false;
                                                phi_3211_ = false;
                                                phi_2317_ = f32();
                                                phi_2319_ = f32();
                                                phi_2321_ = f32();
                                                phi_2323_ = f32();
                                                phi_2325_ = f32();
                                                phi_2327_ = f32();
                                            }
                                            let _e5400 = phi_23838_;
                                            let _e5402 = phi_23591_;
                                            let _e5404 = phi_3207_;
                                            let _e5406 = phi_2310_;
                                            let _e5408 = phi_2313_;
                                            let _e5410 = phi_3209_;
                                            let _e5412 = phi_3210_;
                                            let _e5414 = phi_3211_;
                                            let _e5416 = phi_2317_;
                                            let _e5418 = phi_2319_;
                                            let _e5420 = phi_2321_;
                                            let _e5422 = phi_2323_;
                                            let _e5424 = phi_2325_;
                                            let _e5426 = phi_2327_;
                                            continue;
                                            continuing {
                                                phi_23840_ = _e5400;
                                                phi_23593_ = _e5402;
                                                phi_2309_ = _e5406;
                                                phi_2312_ = _e5408;
                                                phi_2314_ = _e3305;
                                                phi_2316_ = _e5416;
                                                phi_2318_ = _e5418;
                                                phi_2320_ = _e5420;
                                                phi_2322_ = _e5422;
                                                phi_2324_ = _e5424;
                                                phi_2326_ = _e5426;
                                                phi_23748_ = _e5400;
                                                phi_23501_ = _e5402;
                                                phi_23254_ = false;
                                                phi_4716_ = _e5414;
                                                phi_4715_ = _e5412;
                                                phi_4713_ = _e5404;
                                                break if !(_e5410);
                                            }
                                        }
                                        let _e5429 = phi_23748_;
                                        let _e5431 = phi_23501_;
                                        let _e5433 = phi_23254_;
                                        let _e5435 = phi_4716_;
                                        let _e5437 = phi_4715_;
                                        let _e5439 = phi_4713_;
                                        if _e5433 {
                                            break;
                                        }
                                        if _e5437 {
                                            let _e5441 = local_95;
                                            let _e5443 = local_96;
                                            let _e5446 = local_97;
                                            let _e5448 = local_98;
                                            let _e5451 = local_99;
                                            let _e5453 = local_100;
                                            phi_3222_ = fma(_e5441, _e5439, _e5443);
                                            phi_3223_ = fma(_e5446, _e5439, _e5448);
                                            phi_3224_ = fma(_e5451, _e5439, _e5453);
                                        } else {
                                            phi_3222_ = f32();
                                            phi_3223_ = f32();
                                            phi_3224_ = f32();
                                        }
                                        let _e5456 = phi_3222_;
                                        let _e5458 = phi_3223_;
                                        let _e5460 = phi_3224_;
                                        let _e5461 = select(_e5435, false, _e5437);
                                        if _e5461 {
                                            let _e5463 = local_101;
                                            let _e5466 = local_102;
                                            let _e5469 = local_103;
                                            let _e5478 = (_e5429 + vec3<f32>((_e5431.x * 1000f), (_e5431.y * 1000f), (_e5431.z * 1000f)));
                                            let _e5486 = (1f / sqrt(fma(_e5478.z, _e5478.z, fma(_e5478.x, _e5478.x, (_e5478.y * _e5478.y)))));
                                            let _e5492 = fma(atan2((_e5478.z * _e5486), (_e5478.x * _e5486)), 0.31830987f, 1f);
                                            let _e5493 = fma(asin((_e5478.y * _e5486)), 0.63661975f, 1f);
                                            let _e5494 = (_e5492 * 0.5f);
                                            let _e5495 = (_e5493 * 0.5f);
                                            if (_e5494 > 0f) {
                                                phi_16290_ = (_e5494 % 1f);
                                            } else {
                                                phi_16290_ = (1f - ((_e5492 * -0.5f) % 1f));
                                            }
                                            let _e5502 = phi_16290_;
                                            if (_e5495 > 0f) {
                                                phi_16303_ = (_e5495 % 1f);
                                            } else {
                                                phi_16303_ = (1f - ((_e5493 * -0.5f) % 1f));
                                            }
                                            let _e5509 = phi_16303_;
                                            let _e5511 = textureSampleLevel(global_5, global_6, vec2<f32>(_e5502, _e5509), 0f);
                                            let _e5516 = local_104;
                                            let _e5519 = local_105;
                                            let _e5522 = local_106;
                                            phi_3259_ = fma((_e5463 * _e5439), _e5511.x, _e5516);
                                            phi_3260_ = fma((_e5466 * _e5439), _e5511.y, _e5519);
                                            phi_3261_ = fma((_e5469 * _e5439), _e5511.z, _e5522);
                                        } else {
                                            phi_3259_ = _e5456;
                                            phi_3260_ = _e5458;
                                            phi_3261_ = _e5460;
                                        }
                                        let _e5525 = phi_3259_;
                                        let _e5527 = phi_3260_;
                                        let _e5529 = phi_3261_;
                                        let _e5530 = select(_e5437, true, _e5461);
                                        let _e5532 = local_107;
                                        let _e5533 = select(_e5532, _e5525, _e5530);
                                        let _e5535 = local_108;
                                        let _e5536 = select(_e5535, _e5527, _e5530);
                                        let _e5538 = local_109;
                                        let _e5539 = select(_e5538, _e5529, _e5530);
                                        if (_e2143.member.w > 0f) {
                                            let _e5550 = (_e171.y + 33u);
                                            let _e5561 = (_e2211 - vec3<f32>((_e2143.member_1.x * 0.02f), (_e2143.member_1.y * 0.02f), (_e2143.member_1.z * 0.02f)));
                                            let _e5562 = (_e1133 + vec2<f32>(2f, 3f));
                                            let _e5580 = ((((select(select(u32(_e5562.x), 0u, (_e5562.x < 0f)), 4294967295u, (_e5562.x > 4294967000f)) * _e5550) + ((select(select(u32(_e5562.y), 0u, (_e5562.y < 0f)), 4294967295u, (_e5562.y > 4294967000f)) * _e5550) * _e2228)) * 747796405u) + 2891336453u);
                                            let _e5588 = (((_e5580 >> bitcast<u32>((((_e5580 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e5580) * 277803737u);
                                            let _e5593 = (f32(((_e5588 >> bitcast<u32>(22i)) ^ _e5588)) * 0.00000000023283064f);
                                            if (_e5593 < 0f) {
                                                phi_16421_ = 0f;
                                            } else {
                                                phi_16421_ = select(_e5593, 1f, (_e5593 > 1f));
                                            }
                                            let _e5598 = phi_16421_;
                                            let _e5599 = (_e160 + -2f);
                                            let _e5615 = ((((select(select(u32(_e5599), 0u, (_e5599 < 0f)), 4294967295u, (_e5599 > 4294967000f)) * _e5550) + ((select(select(u32(_e159), 0u, (_e159 < 0f)), 4294967295u, (_e159 > 4294967000f)) * _e5550) * _e2228)) * 747796405u) + 2891336453u);
                                            let _e5623 = (((_e5615 >> bitcast<u32>((((_e5615 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e5615) * 277803737u);
                                            let _e5628 = (f32(((_e5623 >> bitcast<u32>(22i)) ^ _e5623)) * 0.00000000023283064f);
                                            if (_e5628 < 0f) {
                                                phi_16470_ = 0f;
                                            } else {
                                                phi_16470_ = select(_e5628, 1f, (_e5628 > 1f));
                                            }
                                            let _e5633 = phi_16470_;
                                            let _e5635 = -(_e5561.x);
                                            let _e5637 = (-2f - _e5561.y);
                                            let _e5639 = (2.5f - _e5561.z);
                                            let _e5643 = sqrt(fma(_e5639, _e5639, fma(_e5635, _e5635, (_e5637 * _e5637))));
                                            let _e5644 = (_e5635 / _e5643);
                                            let _e5645 = (_e5637 / _e5643);
                                            let _e5646 = (_e5639 / _e5643);
                                            let _e5653 = fma(_e5598, sqrt(max((1f - (1f / (_e5643 * _e5643))), 0f)), (1f - _e5598));
                                            let _e5657 = sqrt(max(fma(-(_e5653), _e5653, 1f), 0f));
                                            let _e5658 = (_e5633 * 6.2831855f);
                                            let _e5660 = (cos(_e5658) * _e5657);
                                            let _e5662 = (sin(_e5658) * _e5657);
                                            if (abs(_e5644) > abs(_e5645)) {
                                                let _e5675 = sqrt(fma(_e5644, _e5644, (_e5646 * _e5646)));
                                                phi_16509_ = (-(_e5644) / _e5675);
                                                phi_16510_ = 0f;
                                                phi_16511_ = (_e5646 / _e5675);
                                            } else {
                                                let _e5669 = sqrt(fma(_e5645, _e5645, (_e5646 * _e5646)));
                                                phi_16509_ = (_e5645 / _e5669);
                                                phi_16510_ = (-(_e5646) / _e5669);
                                                phi_16511_ = 0f;
                                            }
                                            let _e5679 = phi_16509_;
                                            let _e5681 = phi_16510_;
                                            let _e5683 = phi_16511_;
                                            let _e5695 = fma(_e5662, _e5683, fma(_e5660, fma(_e5645, _e5679, -((_e5681 * _e5646))), (_e5653 * _e5644)));
                                            let _e5698 = fma(_e5662, _e5681, fma(_e5660, fma(_e5646, _e5683, -((_e5679 * _e5644))), (_e5653 * _e5645)));
                                            let _e5701 = fma(_e5662, _e5679, fma(_e5660, fma(_e5644, _e5681, -((_e5683 * _e5645))), (_e5653 * _e5646)));
                                            phi_3408_ = 0.01f;
                                            phi_3411_ = 0u;
                                            loop {
                                                let _e5703 = phi_3408_;
                                                let _e5705 = phi_3411_;
                                                local_126 = _e5703;
                                                local_127 = _e5703;
                                                let _e5706 = (_e5705 < 300u);
                                                if _e5706 {
                                                    phi_3412_ = (_e5705 + 1u);
                                                } else {
                                                    phi_3412_ = _e5705;
                                                }
                                                let _e5709 = phi_3412_;
                                                if _e5706 {
                                                    let _e5713 = fma(_e5703, _e5695, _e5561.x);
                                                    let _e5714 = fma(_e5703, _e5698, _e5561.y);
                                                    let _e5715 = fma(_e5703, _e5701, _e5561.z);
                                                    let _e5717 = (_e5561 + vec3<f32>((_e5703 * _e5695), (_e5703 * _e5698), (_e5703 * _e5701)));
                                                    let _e5718 = (_e5714 - -2f);
                                                    let _e5719 = (_e5715 - 2.5f);
                                                    let _e5724 = (sqrt(fma(_e5719, _e5719, fma(_e5713, _e5713, (_e5718 * _e5718)))) - 1f);
                                                    let _e5725 = (_e5717 + vec3<f32>(0f, -1f, 0f));
                                                    let _e5735 = fma(0.9689124f, _e5725.z, fma(0.04851991f, _e5725.y, (_e5725.x * -0.24259955f)));
                                                    let _e5742 = (_e5725 + vec3<f32>((_e5735 * 0.4851991f), (_e5735 * -0.09703982f), (2f * fma(0.04851991f, fma(_e5725.z, -0.04851991f, (0.9689124f * _e5725.y)), (fma(0.24259955f, _e5725.z, (0.9689124f * _e5725.x)) * -0.24259955f)))));
                                                    let _e5762 = ((_e5742 + vec3<f32>(0f, (fma(0.38268346f, _e5742.y, (0.9238795f * _e5742.z)) * -0.7653669f), (fma(_e5742.z, -0.38268346f, (0.9238795f * _e5742.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e5768 = (sqrt(fma(_e5762.x, _e5762.x, (_e5762.z * _e5762.z))) + -0.5f);
                                                    let _e5771 = (abs(_e5762.y) - 0.1f);
                                                    let _e5774 = max(_e5768, 0f);
                                                    let _e5775 = max(_e5771, 0f);
                                                    let _e5780 = ((min(max(_e5768, _e5771), 0f) + sqrt(fma(_e5774, _e5774, (_e5775 * _e5775)))) - 0.1f);
                                                    let _e5781 = ((_e5742 + vec3<f32>((fma(0.70710677f, _e5742.x, (0.70710677f * _e5742.y)) * -1.4142135f), (fma(_e5742.y, -0.70710677f, (0.70710677f * _e5742.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e5786 = sqrt(fma(_e5781.x, _e5781.x, (_e5781.z * _e5781.z)));
                                                    let _e5787 = (_e5786 + -0.5f);
                                                    let _e5789 = abs(_e5781.y);
                                                    let _e5790 = (_e5789 - 0.1f);
                                                    let _e5793 = max(_e5787, 0f);
                                                    let _e5794 = max(_e5790, 0f);
                                                    let _e5799 = ((min(max(_e5787, _e5790), 0f) + sqrt(fma(_e5793, _e5793, (_e5794 * _e5794)))) - 0.1f);
                                                    let _e5800 = (_e5786 + -0.20000002f);
                                                    let _e5801 = (_e5789 - 0.4f);
                                                    let _e5804 = max(_e5800, 0f);
                                                    let _e5805 = max(_e5801, 0f);
                                                    let _e5809 = (min(max(_e5800, _e5801), 0f) + sqrt(fma(_e5804, _e5804, (_e5805 * _e5805))));
                                                    let _e5813 = fma(-((_e5799 + (_e5809 - 0.1f))), 5f, 0.5f);
                                                    if (_e5813 < 0f) {
                                                        phi_16874_ = 0f;
                                                    } else {
                                                        phi_16874_ = select(_e5813, 1f, (_e5813 > 1f));
                                                    }
                                                    let _e5818 = phi_16874_;
                                                    let _e5824 = fma((0.1f * _e5818), (1f - _e5818), fma(((0.1f - _e5809) - _e5799), _e5818, _e5799));
                                                    let _e5826 = fma((_e5824 - _e5780), 5f, 0.5f);
                                                    if (_e5826 < 0f) {
                                                        phi_16900_ = 0f;
                                                    } else {
                                                        phi_16900_ = select(_e5826, 1f, (_e5826 > 1f));
                                                    }
                                                    let _e5831 = phi_16900_;
                                                    let _e5836 = fma((_e5831 * -0.1f), (1f - _e5831), fma((_e5780 - _e5824), _e5831, _e5824));
                                                    let _e5838 = fma(_e5717.y, -1f, 3f);
                                                    let _e5842 = (_e5713 - -1f);
                                                    let _e5843 = (_e5714 - 1f);
                                                    let _e5848 = (sqrt(fma(_e5715, _e5715, fma(_e5842, _e5842, (_e5843 * _e5843)))) - 0.6f);
                                                    let _e5852 = select(vec2<f32>(_e5836, 1f), vec2<f32>(_e5724, 0f), vec2((_e5724 < _e5836)));
                                                    let _e5856 = select(vec2<f32>(_e5848, 3f), _e5852, vec2((_e5852.x < _e5848)));
                                                    let _e5860 = select(vec2<f32>(_e5838, 2f), _e5856, vec2((_e5856.x < _e5838)));
                                                    let _e5863 = ((_e5860.x * -1f) < 0.002f);
                                                    if _e5863 {
                                                        phi_3487_ = f32();
                                                        phi_3488_ = false;
                                                        phi_3489_ = false;
                                                    } else {
                                                        let _e5864 = (_e5703 > 22f);
                                                        if _e5864 {
                                                            phi_3485_ = f32();
                                                        } else {
                                                            phi_3485_ = fma(_e5860.x, -1f, _e5703);
                                                        }
                                                        let _e5867 = phi_3485_;
                                                        phi_3487_ = _e5867;
                                                        phi_3488_ = select(true, false, _e5864);
                                                        phi_3489_ = _e5864;
                                                    }
                                                    let _e5870 = phi_3487_;
                                                    let _e5872 = phi_3488_;
                                                    let _e5874 = phi_3489_;
                                                    phi_3490_ = _e5713;
                                                    phi_3491_ = _e5714;
                                                    phi_3492_ = _e5715;
                                                    phi_3493_ = _e5860;
                                                    phi_3409_ = _e5870;
                                                    phi_3494_ = _e5872;
                                                    phi_3495_ = _e5863;
                                                    phi_3496_ = _e5874;
                                                } else {
                                                    phi_3490_ = f32();
                                                    phi_3491_ = f32();
                                                    phi_3492_ = f32();
                                                    phi_3493_ = vec2<f32>();
                                                    phi_3409_ = f32();
                                                    phi_3494_ = false;
                                                    phi_3495_ = false;
                                                    phi_3496_ = false;
                                                }
                                                let _e5876 = phi_3490_;
                                                let _e5878 = phi_3491_;
                                                let _e5880 = phi_3492_;
                                                let _e5882 = phi_3493_;
                                                let _e5884 = phi_3409_;
                                                let _e5886 = phi_3494_;
                                                let _e5888 = phi_3495_;
                                                let _e5890 = phi_3496_;
                                                local_110 = _e5888;
                                                local_111 = _e5876;
                                                local_112 = _e5878;
                                                local_113 = _e5880;
                                                local_114 = _e5878;
                                                local_115 = _e5880;
                                                local_116 = _e5876;
                                                local_117 = _e5878;
                                                local_118 = _e5876;
                                                local_119 = _e5880;
                                                local_120 = _e5880;
                                                local_121 = _e5876;
                                                local_122 = _e5878;
                                                local_123 = _e5878;
                                                local_124 = _e5878;
                                                local_125 = _e5882;
                                                local_128 = _e5888;
                                                local_129 = _e5890;
                                                local_130 = _e5888;
                                                local_131 = select(true, false, _e5706);
                                                continue;
                                                continuing {
                                                    phi_3408_ = _e5884;
                                                    phi_3411_ = _e5709;
                                                    break if !(_e5886);
                                                }
                                            }
                                            let _e5894 = local_110;
                                            if _e5894 {
                                                let _e5896 = local_111;
                                                let _e5897 = (_e5896 + 0.000057729998f);
                                                let _e5899 = local_112;
                                                let _e5900 = (_e5899 + -0.000057729998f);
                                                let _e5902 = local_113;
                                                let _e5903 = (_e5902 + -0.000057729998f);
                                                let _e5906 = local_114;
                                                let _e5907 = (_e5906 + 1.9999423f);
                                                let _e5909 = local_115;
                                                let _e5910 = (_e5909 + -2.5000577f);
                                                let _e5911 = (_e5907 * _e5907);
                                                let _e5915 = (sqrt(fma(_e5910, _e5910, fma(_e5897, _e5897, _e5911))) - 1f);
                                                let _e5916 = (vec3<f32>(_e5897, _e5900, _e5903) + vec3<f32>(0f, -1f, 0f));
                                                let _e5926 = fma(0.9689124f, _e5916.z, fma(0.04851991f, _e5916.y, (_e5916.x * -0.24259955f)));
                                                let _e5933 = (_e5916 + vec3<f32>((_e5926 * 0.4851991f), (_e5926 * -0.09703982f), (2f * fma(0.04851991f, fma(_e5916.z, -0.04851991f, (0.9689124f * _e5916.y)), (fma(0.24259955f, _e5916.z, (0.9689124f * _e5916.x)) * -0.24259955f)))));
                                                let _e5953 = ((_e5933 + vec3<f32>(0f, (fma(0.38268346f, _e5933.y, (0.9238795f * _e5933.z)) * -0.7653669f), (fma(_e5933.z, -0.38268346f, (0.9238795f * _e5933.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e5959 = (sqrt(fma(_e5953.x, _e5953.x, (_e5953.z * _e5953.z))) + -0.5f);
                                                let _e5962 = (abs(_e5953.y) - 0.1f);
                                                let _e5965 = max(_e5959, 0f);
                                                let _e5966 = max(_e5962, 0f);
                                                let _e5971 = ((min(max(_e5959, _e5962), 0f) + sqrt(fma(_e5965, _e5965, (_e5966 * _e5966)))) - 0.1f);
                                                let _e5972 = ((_e5933 + vec3<f32>((fma(0.70710677f, _e5933.x, (0.70710677f * _e5933.y)) * -1.4142135f), (fma(_e5933.y, -0.70710677f, (0.70710677f * _e5933.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e5977 = sqrt(fma(_e5972.x, _e5972.x, (_e5972.z * _e5972.z)));
                                                let _e5978 = (_e5977 + -0.5f);
                                                let _e5980 = abs(_e5972.y);
                                                let _e5981 = (_e5980 - 0.1f);
                                                let _e5984 = max(_e5978, 0f);
                                                let _e5985 = max(_e5981, 0f);
                                                let _e5990 = ((min(max(_e5978, _e5981), 0f) + sqrt(fma(_e5984, _e5984, (_e5985 * _e5985)))) - 0.1f);
                                                let _e5991 = (_e5977 + -0.20000002f);
                                                let _e5992 = (_e5980 - 0.4f);
                                                let _e5995 = max(_e5991, 0f);
                                                let _e5996 = max(_e5992, 0f);
                                                let _e6000 = (min(max(_e5991, _e5992), 0f) + sqrt(fma(_e5995, _e5995, (_e5996 * _e5996))));
                                                let _e6004 = fma(-((_e5990 + (_e6000 - 0.1f))), 5f, 0.5f);
                                                if (_e6004 < 0f) {
                                                    phi_17271_ = 0f;
                                                } else {
                                                    phi_17271_ = select(_e6004, 1f, (_e6004 > 1f));
                                                }
                                                let _e6009 = phi_17271_;
                                                let _e6015 = fma((0.1f * _e6009), (1f - _e6009), fma(((0.1f - _e6000) - _e5990), _e6009, _e5990));
                                                let _e6017 = fma((_e6015 - _e5971), 5f, 0.5f);
                                                if (_e6017 < 0f) {
                                                    phi_17297_ = 0f;
                                                } else {
                                                    phi_17297_ = select(_e6017, 1f, (_e6017 > 1f));
                                                }
                                                let _e6022 = phi_17297_;
                                                let _e6027 = fma((_e6022 * -0.1f), (1f - _e6022), fma((_e5971 - _e6015), _e6022, _e6015));
                                                let _e6028 = fma(_e5900, -1f, 3f);
                                                let _e6031 = vec2<f32>(_e6028, 2f);
                                                let _e6033 = local_116;
                                                let _e6034 = (_e6033 + 1.0000577f);
                                                let _e6036 = local_117;
                                                let _e6037 = (_e6036 + -1.0000577f);
                                                let _e6038 = (_e6037 * _e6037);
                                                let _e6042 = (sqrt(fma(_e5903, _e5903, fma(_e6034, _e6034, _e6038))) - 0.6f);
                                                let _e6046 = select(vec2<f32>(_e6027, 1f), vec2<f32>(_e5915, 0f), vec2((_e5915 < _e6027)));
                                                let _e6050 = select(vec2<f32>(_e6042, 3f), _e6046, vec2((_e6046.x < _e6042)));
                                                let _e6057 = local_118;
                                                let _e6058 = (_e6057 + -0.000057729998f);
                                                let _e6060 = local_119;
                                                let _e6061 = (_e6060 + 0.000057729998f);
                                                let _e6064 = local_120;
                                                let _e6065 = (_e6064 + -2.4999423f);
                                                let _e6069 = (sqrt(fma(_e6065, _e6065, fma(_e6058, _e6058, _e5911))) - 1f);
                                                let _e6070 = (vec3<f32>(_e6058, _e5900, _e6061) + vec3<f32>(0f, -1f, 0f));
                                                let _e6080 = fma(0.9689124f, _e6070.z, fma(0.04851991f, _e6070.y, (_e6070.x * -0.24259955f)));
                                                let _e6087 = (_e6070 + vec3<f32>((_e6080 * 0.4851991f), (_e6080 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6070.z, -0.04851991f, (0.9689124f * _e6070.y)), (fma(0.24259955f, _e6070.z, (0.9689124f * _e6070.x)) * -0.24259955f)))));
                                                let _e6107 = ((_e6087 + vec3<f32>(0f, (fma(0.38268346f, _e6087.y, (0.9238795f * _e6087.z)) * -0.7653669f), (fma(_e6087.z, -0.38268346f, (0.9238795f * _e6087.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e6113 = (sqrt(fma(_e6107.x, _e6107.x, (_e6107.z * _e6107.z))) + -0.5f);
                                                let _e6116 = (abs(_e6107.y) - 0.1f);
                                                let _e6119 = max(_e6113, 0f);
                                                let _e6120 = max(_e6116, 0f);
                                                let _e6125 = ((min(max(_e6113, _e6116), 0f) + sqrt(fma(_e6119, _e6119, (_e6120 * _e6120)))) - 0.1f);
                                                let _e6126 = ((_e6087 + vec3<f32>((fma(0.70710677f, _e6087.x, (0.70710677f * _e6087.y)) * -1.4142135f), (fma(_e6087.y, -0.70710677f, (0.70710677f * _e6087.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e6131 = sqrt(fma(_e6126.x, _e6126.x, (_e6126.z * _e6126.z)));
                                                let _e6132 = (_e6131 + -0.5f);
                                                let _e6134 = abs(_e6126.y);
                                                let _e6135 = (_e6134 - 0.1f);
                                                let _e6138 = max(_e6132, 0f);
                                                let _e6139 = max(_e6135, 0f);
                                                let _e6144 = ((min(max(_e6132, _e6135), 0f) + sqrt(fma(_e6138, _e6138, (_e6139 * _e6139)))) - 0.1f);
                                                let _e6145 = (_e6131 + -0.20000002f);
                                                let _e6146 = (_e6134 - 0.4f);
                                                let _e6149 = max(_e6145, 0f);
                                                let _e6150 = max(_e6146, 0f);
                                                let _e6154 = (min(max(_e6145, _e6146), 0f) + sqrt(fma(_e6149, _e6149, (_e6150 * _e6150))));
                                                let _e6158 = fma(-((_e6144 + (_e6154 - 0.1f))), 5f, 0.5f);
                                                if (_e6158 < 0f) {
                                                    phi_17668_ = 0f;
                                                } else {
                                                    phi_17668_ = select(_e6158, 1f, (_e6158 > 1f));
                                                }
                                                let _e6163 = phi_17668_;
                                                let _e6169 = fma((0.1f * _e6163), (1f - _e6163), fma(((0.1f - _e6154) - _e6144), _e6163, _e6144));
                                                let _e6171 = fma((_e6169 - _e6125), 5f, 0.5f);
                                                if (_e6171 < 0f) {
                                                    phi_17694_ = 0f;
                                                } else {
                                                    phi_17694_ = select(_e6171, 1f, (_e6171 > 1f));
                                                }
                                                let _e6176 = phi_17694_;
                                                let _e6181 = fma((_e6176 * -0.1f), (1f - _e6176), fma((_e6125 - _e6169), _e6176, _e6169));
                                                let _e6185 = local_121;
                                                let _e6186 = (_e6185 + 0.99994224f);
                                                let _e6190 = (sqrt(fma(_e6061, _e6061, fma(_e6186, _e6186, _e6038))) - 0.6f);
                                                let _e6194 = select(vec2<f32>(_e6181, 1f), vec2<f32>(_e6069, 0f), vec2((_e6069 < _e6181)));
                                                let _e6198 = select(vec2<f32>(_e6190, 3f), _e6194, vec2((_e6194.x < _e6190)));
                                                let _e6204 = (-0.5773f * select(_e6031, _e6198, vec2((_e6198.x < _e6028))).x);
                                                let _e6210 = local_122;
                                                let _e6211 = (_e6210 + 0.000057729998f);
                                                let _e6214 = local_123;
                                                let _e6215 = (_e6214 + 2.0000577f);
                                                let _e6216 = (_e6215 * _e6215);
                                                let _e6220 = (sqrt(fma(_e5910, _e5910, fma(_e6058, _e6058, _e6216))) - 1f);
                                                let _e6221 = (vec3<f32>(_e6058, _e6211, _e5903) + vec3<f32>(0f, -1f, 0f));
                                                let _e6231 = fma(0.9689124f, _e6221.z, fma(0.04851991f, _e6221.y, (_e6221.x * -0.24259955f)));
                                                let _e6238 = (_e6221 + vec3<f32>((_e6231 * 0.4851991f), (_e6231 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6221.z, -0.04851991f, (0.9689124f * _e6221.y)), (fma(0.24259955f, _e6221.z, (0.9689124f * _e6221.x)) * -0.24259955f)))));
                                                let _e6258 = ((_e6238 + vec3<f32>(0f, (fma(0.38268346f, _e6238.y, (0.9238795f * _e6238.z)) * -0.7653669f), (fma(_e6238.z, -0.38268346f, (0.9238795f * _e6238.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e6264 = (sqrt(fma(_e6258.x, _e6258.x, (_e6258.z * _e6258.z))) + -0.5f);
                                                let _e6267 = (abs(_e6258.y) - 0.1f);
                                                let _e6270 = max(_e6264, 0f);
                                                let _e6271 = max(_e6267, 0f);
                                                let _e6276 = ((min(max(_e6264, _e6267), 0f) + sqrt(fma(_e6270, _e6270, (_e6271 * _e6271)))) - 0.1f);
                                                let _e6277 = ((_e6238 + vec3<f32>((fma(0.70710677f, _e6238.x, (0.70710677f * _e6238.y)) * -1.4142135f), (fma(_e6238.y, -0.70710677f, (0.70710677f * _e6238.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e6282 = sqrt(fma(_e6277.x, _e6277.x, (_e6277.z * _e6277.z)));
                                                let _e6283 = (_e6282 + -0.5f);
                                                let _e6285 = abs(_e6277.y);
                                                let _e6286 = (_e6285 - 0.1f);
                                                let _e6289 = max(_e6283, 0f);
                                                let _e6290 = max(_e6286, 0f);
                                                let _e6295 = ((min(max(_e6283, _e6286), 0f) + sqrt(fma(_e6289, _e6289, (_e6290 * _e6290)))) - 0.1f);
                                                let _e6296 = (_e6282 + -0.20000002f);
                                                let _e6297 = (_e6285 - 0.4f);
                                                let _e6300 = max(_e6296, 0f);
                                                let _e6301 = max(_e6297, 0f);
                                                let _e6305 = (min(max(_e6296, _e6297), 0f) + sqrt(fma(_e6300, _e6300, (_e6301 * _e6301))));
                                                let _e6309 = fma(-((_e6295 + (_e6305 - 0.1f))), 5f, 0.5f);
                                                if (_e6309 < 0f) {
                                                    phi_18065_ = 0f;
                                                } else {
                                                    phi_18065_ = select(_e6309, 1f, (_e6309 > 1f));
                                                }
                                                let _e6314 = phi_18065_;
                                                let _e6320 = fma((0.1f * _e6314), (1f - _e6314), fma(((0.1f - _e6305) - _e6295), _e6314, _e6295));
                                                let _e6322 = fma((_e6320 - _e6276), 5f, 0.5f);
                                                if (_e6322 < 0f) {
                                                    phi_18091_ = 0f;
                                                } else {
                                                    phi_18091_ = select(_e6322, 1f, (_e6322 > 1f));
                                                }
                                                let _e6327 = phi_18091_;
                                                let _e6332 = fma((_e6327 * -0.1f), (1f - _e6327), fma((_e6276 - _e6320), _e6327, _e6320));
                                                let _e6333 = fma(_e6211, -1f, 3f);
                                                let _e6336 = vec2<f32>(_e6333, 2f);
                                                let _e6338 = local_124;
                                                let _e6339 = (_e6338 + -0.99994224f);
                                                let _e6340 = (_e6339 * _e6339);
                                                let _e6344 = (sqrt(fma(_e5903, _e5903, fma(_e6186, _e6186, _e6340))) - 0.6f);
                                                let _e6348 = select(vec2<f32>(_e6332, 1f), vec2<f32>(_e6220, 0f), vec2((_e6220 < _e6332)));
                                                let _e6352 = select(vec2<f32>(_e6344, 3f), _e6348, vec2((_e6348.x < _e6344)));
                                                let _e6365 = (sqrt(fma(_e6065, _e6065, fma(_e5897, _e5897, _e6216))) - 1f);
                                                let _e6366 = (vec3<f32>(_e5897, _e6211, _e6061) + vec3<f32>(0f, -1f, 0f));
                                                let _e6376 = fma(0.9689124f, _e6366.z, fma(0.04851991f, _e6366.y, (_e6366.x * -0.24259955f)));
                                                let _e6383 = (_e6366 + vec3<f32>((_e6376 * 0.4851991f), (_e6376 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6366.z, -0.04851991f, (0.9689124f * _e6366.y)), (fma(0.24259955f, _e6366.z, (0.9689124f * _e6366.x)) * -0.24259955f)))));
                                                let _e6403 = ((_e6383 + vec3<f32>(0f, (fma(0.38268346f, _e6383.y, (0.9238795f * _e6383.z)) * -0.7653669f), (fma(_e6383.z, -0.38268346f, (0.9238795f * _e6383.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e6409 = (sqrt(fma(_e6403.x, _e6403.x, (_e6403.z * _e6403.z))) + -0.5f);
                                                let _e6412 = (abs(_e6403.y) - 0.1f);
                                                let _e6415 = max(_e6409, 0f);
                                                let _e6416 = max(_e6412, 0f);
                                                let _e6421 = ((min(max(_e6409, _e6412), 0f) + sqrt(fma(_e6415, _e6415, (_e6416 * _e6416)))) - 0.1f);
                                                let _e6422 = ((_e6383 + vec3<f32>((fma(0.70710677f, _e6383.x, (0.70710677f * _e6383.y)) * -1.4142135f), (fma(_e6383.y, -0.70710677f, (0.70710677f * _e6383.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e6427 = sqrt(fma(_e6422.x, _e6422.x, (_e6422.z * _e6422.z)));
                                                let _e6428 = (_e6427 + -0.5f);
                                                let _e6430 = abs(_e6422.y);
                                                let _e6431 = (_e6430 - 0.1f);
                                                let _e6434 = max(_e6428, 0f);
                                                let _e6435 = max(_e6431, 0f);
                                                let _e6440 = ((min(max(_e6428, _e6431), 0f) + sqrt(fma(_e6434, _e6434, (_e6435 * _e6435)))) - 0.1f);
                                                let _e6441 = (_e6427 + -0.20000002f);
                                                let _e6442 = (_e6430 - 0.4f);
                                                let _e6445 = max(_e6441, 0f);
                                                let _e6446 = max(_e6442, 0f);
                                                let _e6450 = (min(max(_e6441, _e6442), 0f) + sqrt(fma(_e6445, _e6445, (_e6446 * _e6446))));
                                                let _e6454 = fma(-((_e6440 + (_e6450 - 0.1f))), 5f, 0.5f);
                                                if (_e6454 < 0f) {
                                                    phi_18462_ = 0f;
                                                } else {
                                                    phi_18462_ = select(_e6454, 1f, (_e6454 > 1f));
                                                }
                                                let _e6459 = phi_18462_;
                                                let _e6465 = fma((0.1f * _e6459), (1f - _e6459), fma(((0.1f - _e6450) - _e6440), _e6459, _e6440));
                                                let _e6467 = fma((_e6465 - _e6421), 5f, 0.5f);
                                                if (_e6467 < 0f) {
                                                    phi_18488_ = 0f;
                                                } else {
                                                    phi_18488_ = select(_e6467, 1f, (_e6467 > 1f));
                                                }
                                                let _e6472 = phi_18488_;
                                                let _e6477 = fma((_e6472 * -0.1f), (1f - _e6472), fma((_e6421 - _e6465), _e6472, _e6465));
                                                let _e6483 = (sqrt(fma(_e6061, _e6061, fma(_e6034, _e6034, _e6340))) - 0.6f);
                                                let _e6487 = select(vec2<f32>(_e6477, 1f), vec2<f32>(_e6365, 0f), vec2((_e6365 < _e6477)));
                                                let _e6491 = select(vec2<f32>(_e6483, 3f), _e6487, vec2((_e6487.x < _e6483)));
                                                let _e6497 = fma(0.5773f, select(_e6336, _e6491, vec2((_e6491.x < _e6333))).x, fma(-0.5773f, select(_e6336, _e6352, vec2((_e6352.x < _e6333))).x, fma(0.5773f, select(_e6031, _e6050, vec2((_e6050.x < _e6028))).x, _e6204)));
                                                let _e6498 = fma(0.5773f, select(_e6336, _e6491, vec2((_e6491.x < _e6333))).x, fma(0.5773f, select(_e6336, _e6352, vec2((_e6352.x < _e6333))).x, fma(-0.5773f, select(_e6031, _e6050, vec2((_e6050.x < _e6028))).x, _e6204)));
                                                let _e6499 = fma(0.5773f, select(_e6336, _e6491, vec2((_e6491.x < _e6333))).x, fma(-0.5773f, select(_e6336, _e6352, vec2((_e6352.x < _e6333))).x, fma(-0.5773f, select(_e6031, _e6050, vec2((_e6050.x < _e6028))).x, (0.5773f * select(_e6031, _e6198, vec2((_e6198.x < _e6028))).x))));
                                                let _e6504 = (1f / sqrt(fma(_e6499, _e6499, fma(_e6497, _e6497, (_e6498 * _e6498)))));
                                                let _e6505 = (_e6497 * _e6504);
                                                let _e6506 = (_e6498 * _e6504);
                                                let _e6507 = (_e6499 * _e6504);
                                                let _e6509 = local_125;
                                                let _e6515 = select(select(u32(_e6509.y), 0u, (_e6509.y < 0f)), 4294967295u, (_e6509.y > 4294967000f));
                                                if (_e6515 > (_e152 - 1u)) {
                                                    let _e6531 = local_127;
                                                    phi_3699_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e6505, _e6506, _e6507, _e6531), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                                } else {
                                                    if (_e6515 < _e152) {
                                                    } else {
                                                        break;
                                                    }
                                                    let _e6520 = global_4.member[_e6515];
                                                    let _e6522 = local_126;
                                                    phi_3699_ = type_26(_e6520.member, vec4<f32>(_e6505, _e6506, _e6507, _e6522), _e6520.member_2, _e6520.member_3, _e6520.member_4);
                                                }
                                                let _e6540 = phi_3699_;
                                                phi_3700_ = _e6540;
                                            } else {
                                                phi_3700_ = type_26();
                                            }
                                            let _e6542 = phi_3700_;
                                            let _e6544 = local_128;
                                            let _e6546 = local_129;
                                            let _e6549 = local_130;
                                            let _e6551 = local_131;
                                            if select(select(_e6551, false, _e6549), true, select(_e6546, false, _e6544)) {
                                                phi_3711_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                            } else {
                                                phi_3711_ = _e6542;
                                            }
                                            let _e6555 = phi_3711_;
                                            phi_3735_ = 0.01f;
                                            phi_3738_ = 0u;
                                            loop {
                                                let _e6566 = phi_3735_;
                                                let _e6568 = phi_3738_;
                                                local_145 = _e6566;
                                                local_146 = _e6566;
                                                let _e6569 = (_e6568 < 300u);
                                                if _e6569 {
                                                    phi_3739_ = (_e6568 + 1u);
                                                } else {
                                                    phi_3739_ = _e6568;
                                                }
                                                let _e6572 = phi_3739_;
                                                if _e6569 {
                                                    let _e6577 = (vec3<f32>((_e5695 * _e6566), (_e5698 * _e6566), (_e5701 * _e6566)) + vec3<f32>(fma(0.03f, _e5695, fma(_e5695, _e6555.member_1.w, fma(-(_e2143.member_1.x), 0.02f, _e2211.x))), fma(0.03f, _e5698, fma(_e5698, _e6555.member_1.w, fma(-(_e2143.member_1.y), 0.02f, _e2211.y))), fma(0.03f, _e5701, fma(_e5701, _e6555.member_1.w, fma(-(_e2143.member_1.z), 0.02f, _e2211.z)))));
                                                    let _e6578 = (_e6577 - vec3<f32>(0f, -2f, 2.5f));
                                                    let _e6586 = (sqrt(fma(_e6578.z, _e6578.z, fma(_e6578.x, _e6578.x, (_e6578.y * _e6578.y)))) - 1f);
                                                    let _e6587 = (_e6577 + vec3<f32>(0f, -1f, 0f));
                                                    let _e6597 = fma(0.9689124f, _e6587.z, fma(0.04851991f, _e6587.y, (_e6587.x * -0.24259955f)));
                                                    let _e6604 = (_e6587 + vec3<f32>((_e6597 * 0.4851991f), (_e6597 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6587.z, -0.04851991f, (0.9689124f * _e6587.y)), (fma(0.24259955f, _e6587.z, (0.9689124f * _e6587.x)) * -0.24259955f)))));
                                                    let _e6624 = ((_e6604 + vec3<f32>(0f, (fma(0.38268346f, _e6604.y, (0.9238795f * _e6604.z)) * -0.7653669f), (fma(_e6604.z, -0.38268346f, (0.9238795f * _e6604.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                    let _e6630 = (sqrt(fma(_e6624.x, _e6624.x, (_e6624.z * _e6624.z))) + -0.5f);
                                                    let _e6633 = (abs(_e6624.y) - 0.1f);
                                                    let _e6636 = max(_e6630, 0f);
                                                    let _e6637 = max(_e6633, 0f);
                                                    let _e6642 = ((min(max(_e6630, _e6633), 0f) + sqrt(fma(_e6636, _e6636, (_e6637 * _e6637)))) - 0.1f);
                                                    let _e6643 = ((_e6604 + vec3<f32>((fma(0.70710677f, _e6604.x, (0.70710677f * _e6604.y)) * -1.4142135f), (fma(_e6604.y, -0.70710677f, (0.70710677f * _e6604.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                    let _e6648 = sqrt(fma(_e6643.x, _e6643.x, (_e6643.z * _e6643.z)));
                                                    let _e6649 = (_e6648 + -0.5f);
                                                    let _e6651 = abs(_e6643.y);
                                                    let _e6652 = (_e6651 - 0.1f);
                                                    let _e6655 = max(_e6649, 0f);
                                                    let _e6656 = max(_e6652, 0f);
                                                    let _e6661 = ((min(max(_e6649, _e6652), 0f) + sqrt(fma(_e6655, _e6655, (_e6656 * _e6656)))) - 0.1f);
                                                    let _e6662 = (_e6648 + -0.20000002f);
                                                    let _e6663 = (_e6651 - 0.4f);
                                                    let _e6666 = max(_e6662, 0f);
                                                    let _e6667 = max(_e6663, 0f);
                                                    let _e6671 = (min(max(_e6662, _e6663), 0f) + sqrt(fma(_e6666, _e6666, (_e6667 * _e6667))));
                                                    let _e6675 = fma(-((_e6661 + (_e6671 - 0.1f))), 5f, 0.5f);
                                                    if (_e6675 < 0f) {
                                                        phi_18922_ = 0f;
                                                    } else {
                                                        phi_18922_ = select(_e6675, 1f, (_e6675 > 1f));
                                                    }
                                                    let _e6680 = phi_18922_;
                                                    let _e6686 = fma((0.1f * _e6680), (1f - _e6680), fma(((0.1f - _e6671) - _e6661), _e6680, _e6661));
                                                    let _e6688 = fma((_e6686 - _e6642), 5f, 0.5f);
                                                    if (_e6688 < 0f) {
                                                        phi_18948_ = 0f;
                                                    } else {
                                                        phi_18948_ = select(_e6688, 1f, (_e6688 > 1f));
                                                    }
                                                    let _e6693 = phi_18948_;
                                                    let _e6698 = fma((_e6693 * -0.1f), (1f - _e6693), fma((_e6642 - _e6686), _e6693, _e6686));
                                                    let _e6700 = fma(_e6577.y, -1f, 3f);
                                                    let _e6704 = (_e6577 - vec3<f32>(-1f, 1f, 0f));
                                                    let _e6712 = (sqrt(fma(_e6704.z, _e6704.z, fma(_e6704.x, _e6704.x, (_e6704.y * _e6704.y)))) - 0.6f);
                                                    let _e6716 = select(vec2<f32>(_e6698, 1f), vec2<f32>(_e6586, 0f), vec2((_e6586 < _e6698)));
                                                    let _e6720 = select(vec2<f32>(_e6712, 3f), _e6716, vec2((_e6716.x < _e6712)));
                                                    let _e6724 = select(vec2<f32>(_e6700, 2f), _e6720, vec2((_e6720.x < _e6700)));
                                                    let _e6726 = (_e6724.x < 0.001f);
                                                    if _e6726 {
                                                        phi_3794_ = f32();
                                                        phi_3795_ = false;
                                                        phi_3796_ = false;
                                                    } else {
                                                        let _e6727 = (_e6566 > 22f);
                                                        if _e6727 {
                                                            phi_3792_ = f32();
                                                        } else {
                                                            phi_3792_ = (_e6566 + _e6724.x);
                                                        }
                                                        let _e6730 = phi_3792_;
                                                        phi_3794_ = _e6730;
                                                        phi_3795_ = select(true, false, _e6727);
                                                        phi_3796_ = _e6727;
                                                    }
                                                    let _e6733 = phi_3794_;
                                                    let _e6735 = phi_3795_;
                                                    let _e6737 = phi_3796_;
                                                    phi_3797_ = _e6577;
                                                    phi_3798_ = _e6724;
                                                    phi_3736_ = _e6733;
                                                    phi_3799_ = _e6735;
                                                    phi_3800_ = _e6726;
                                                    phi_3801_ = _e6737;
                                                } else {
                                                    phi_3797_ = vec3<f32>();
                                                    phi_3798_ = vec2<f32>();
                                                    phi_3736_ = f32();
                                                    phi_3799_ = false;
                                                    phi_3800_ = false;
                                                    phi_3801_ = false;
                                                }
                                                let _e6739 = phi_3797_;
                                                let _e6741 = phi_3798_;
                                                let _e6743 = phi_3736_;
                                                let _e6745 = phi_3799_;
                                                let _e6747 = phi_3800_;
                                                let _e6749 = phi_3801_;
                                                local_132 = _e6747;
                                                local_133 = _e6739;
                                                local_134 = _e6739;
                                                local_135 = _e6739;
                                                local_136 = _e6739;
                                                local_137 = _e6739;
                                                local_138 = _e6739;
                                                local_139 = _e6739;
                                                local_140 = _e6739;
                                                local_141 = _e6739;
                                                local_142 = _e6739;
                                                local_143 = _e6739;
                                                local_144 = _e6741;
                                                local_147 = _e6747;
                                                local_148 = _e6749;
                                                local_149 = _e6747;
                                                local_150 = select(true, false, _e6569);
                                                continue;
                                                continuing {
                                                    phi_3735_ = _e6743;
                                                    phi_3738_ = _e6572;
                                                    break if !(_e6745);
                                                }
                                            }
                                            let _e6753 = local_132;
                                            if _e6753 {
                                                let _e6755 = local_133;
                                                let _e6757 = (_e6755.x + 0.000057729998f);
                                                let _e6759 = local_134;
                                                let _e6762 = local_135;
                                                let _e6764 = (_e6762.z + -0.000057729998f);
                                                let _e6766 = local_136;
                                                let _e6768 = (_e6759.y + 1.9999423f);
                                                let _e6769 = (_e6762.z + -2.5000577f);
                                                let _e6770 = (_e6768 * _e6768);
                                                let _e6774 = (sqrt(fma(_e6769, _e6769, fma(_e6757, _e6757, _e6770))) - 1f);
                                                let _e6776 = local_137;
                                                let _e6777 = (_e6776 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                                let _e6787 = fma(0.9689124f, _e6777.z, fma(0.04851991f, _e6777.y, (_e6777.x * -0.24259955f)));
                                                let _e6794 = (_e6777 + vec3<f32>((_e6787 * 0.4851991f), (_e6787 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6777.z, -0.04851991f, (0.9689124f * _e6777.y)), (fma(0.24259955f, _e6777.z, (0.9689124f * _e6777.x)) * -0.24259955f)))));
                                                let _e6814 = ((_e6794 + vec3<f32>(0f, (fma(0.38268346f, _e6794.y, (0.9238795f * _e6794.z)) * -0.7653669f), (fma(_e6794.z, -0.38268346f, (0.9238795f * _e6794.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e6820 = (sqrt(fma(_e6814.x, _e6814.x, (_e6814.z * _e6814.z))) + -0.5f);
                                                let _e6823 = (abs(_e6814.y) - 0.1f);
                                                let _e6826 = max(_e6820, 0f);
                                                let _e6827 = max(_e6823, 0f);
                                                let _e6832 = ((min(max(_e6820, _e6823), 0f) + sqrt(fma(_e6826, _e6826, (_e6827 * _e6827)))) - 0.1f);
                                                let _e6833 = ((_e6794 + vec3<f32>((fma(0.70710677f, _e6794.x, (0.70710677f * _e6794.y)) * -1.4142135f), (fma(_e6794.y, -0.70710677f, (0.70710677f * _e6794.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e6838 = sqrt(fma(_e6833.x, _e6833.x, (_e6833.z * _e6833.z)));
                                                let _e6839 = (_e6838 + -0.5f);
                                                let _e6841 = abs(_e6833.y);
                                                let _e6842 = (_e6841 - 0.1f);
                                                let _e6845 = max(_e6839, 0f);
                                                let _e6846 = max(_e6842, 0f);
                                                let _e6851 = ((min(max(_e6839, _e6842), 0f) + sqrt(fma(_e6845, _e6845, (_e6846 * _e6846)))) - 0.1f);
                                                let _e6852 = (_e6838 + -0.20000002f);
                                                let _e6853 = (_e6841 - 0.4f);
                                                let _e6856 = max(_e6852, 0f);
                                                let _e6857 = max(_e6853, 0f);
                                                let _e6861 = (min(max(_e6852, _e6853), 0f) + sqrt(fma(_e6856, _e6856, (_e6857 * _e6857))));
                                                let _e6865 = fma(-((_e6851 + (_e6861 - 0.1f))), 5f, 0.5f);
                                                if (_e6865 < 0f) {
                                                    phi_19319_ = 0f;
                                                } else {
                                                    phi_19319_ = select(_e6865, 1f, (_e6865 > 1f));
                                                }
                                                let _e6870 = phi_19319_;
                                                let _e6876 = fma((0.1f * _e6870), (1f - _e6870), fma(((0.1f - _e6861) - _e6851), _e6870, _e6851));
                                                let _e6878 = fma((_e6876 - _e6832), 5f, 0.5f);
                                                if (_e6878 < 0f) {
                                                    phi_19345_ = 0f;
                                                } else {
                                                    phi_19345_ = select(_e6878, 1f, (_e6878 > 1f));
                                                }
                                                let _e6883 = phi_19345_;
                                                let _e6888 = fma((_e6883 * -0.1f), (1f - _e6883), fma((_e6832 - _e6876), _e6883, _e6876));
                                                let _e6890 = fma((_e6766 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                let _e6894 = (_e6755.x + 1.0000577f);
                                                let _e6895 = (_e6759.y + -1.0000577f);
                                                let _e6896 = (_e6895 * _e6895);
                                                let _e6900 = (sqrt(fma(_e6764, _e6764, fma(_e6894, _e6894, _e6896))) - 0.6f);
                                                let _e6904 = select(vec2<f32>(_e6888, 1f), vec2<f32>(_e6774, 0f), vec2((_e6774 < _e6888)));
                                                let _e6908 = select(vec2<f32>(_e6900, 3f), _e6904, vec2((_e6904.x < _e6900)));
                                                let _e6914 = (_e6755.x + -0.000057729998f);
                                                let _e6915 = (_e6762.z + 0.000057729998f);
                                                let _e6917 = local_138;
                                                let _e6919 = (_e6762.z + -2.4999423f);
                                                let _e6923 = (sqrt(fma(_e6919, _e6919, fma(_e6914, _e6914, _e6770))) - 1f);
                                                let _e6925 = local_139;
                                                let _e6926 = (_e6925 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                                let _e6936 = fma(0.9689124f, _e6926.z, fma(0.04851991f, _e6926.y, (_e6926.x * -0.24259955f)));
                                                let _e6943 = (_e6926 + vec3<f32>((_e6936 * 0.4851991f), (_e6936 * -0.09703982f), (2f * fma(0.04851991f, fma(_e6926.z, -0.04851991f, (0.9689124f * _e6926.y)), (fma(0.24259955f, _e6926.z, (0.9689124f * _e6926.x)) * -0.24259955f)))));
                                                let _e6963 = ((_e6943 + vec3<f32>(0f, (fma(0.38268346f, _e6943.y, (0.9238795f * _e6943.z)) * -0.7653669f), (fma(_e6943.z, -0.38268346f, (0.9238795f * _e6943.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e6969 = (sqrt(fma(_e6963.x, _e6963.x, (_e6963.z * _e6963.z))) + -0.5f);
                                                let _e6972 = (abs(_e6963.y) - 0.1f);
                                                let _e6975 = max(_e6969, 0f);
                                                let _e6976 = max(_e6972, 0f);
                                                let _e6981 = ((min(max(_e6969, _e6972), 0f) + sqrt(fma(_e6975, _e6975, (_e6976 * _e6976)))) - 0.1f);
                                                let _e6982 = ((_e6943 + vec3<f32>((fma(0.70710677f, _e6943.x, (0.70710677f * _e6943.y)) * -1.4142135f), (fma(_e6943.y, -0.70710677f, (0.70710677f * _e6943.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e6987 = sqrt(fma(_e6982.x, _e6982.x, (_e6982.z * _e6982.z)));
                                                let _e6988 = (_e6987 + -0.5f);
                                                let _e6990 = abs(_e6982.y);
                                                let _e6991 = (_e6990 - 0.1f);
                                                let _e6994 = max(_e6988, 0f);
                                                let _e6995 = max(_e6991, 0f);
                                                let _e7000 = ((min(max(_e6988, _e6991), 0f) + sqrt(fma(_e6994, _e6994, (_e6995 * _e6995)))) - 0.1f);
                                                let _e7001 = (_e6987 + -0.20000002f);
                                                let _e7002 = (_e6990 - 0.4f);
                                                let _e7005 = max(_e7001, 0f);
                                                let _e7006 = max(_e7002, 0f);
                                                let _e7010 = (min(max(_e7001, _e7002), 0f) + sqrt(fma(_e7005, _e7005, (_e7006 * _e7006))));
                                                let _e7014 = fma(-((_e7000 + (_e7010 - 0.1f))), 5f, 0.5f);
                                                if (_e7014 < 0f) {
                                                    phi_19716_ = 0f;
                                                } else {
                                                    phi_19716_ = select(_e7014, 1f, (_e7014 > 1f));
                                                }
                                                let _e7019 = phi_19716_;
                                                let _e7025 = fma((0.1f * _e7019), (1f - _e7019), fma(((0.1f - _e7010) - _e7000), _e7019, _e7000));
                                                let _e7027 = fma((_e7025 - _e6981), 5f, 0.5f);
                                                if (_e7027 < 0f) {
                                                    phi_19742_ = 0f;
                                                } else {
                                                    phi_19742_ = select(_e7027, 1f, (_e7027 > 1f));
                                                }
                                                let _e7032 = phi_19742_;
                                                let _e7037 = fma((_e7032 * -0.1f), (1f - _e7032), fma((_e6981 - _e7025), _e7032, _e7025));
                                                let _e7039 = fma((_e6917 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                let _e7043 = (_e6755.x + 0.99994224f);
                                                let _e7047 = (sqrt(fma(_e6915, _e6915, fma(_e7043, _e7043, _e6896))) - 0.6f);
                                                let _e7051 = select(vec2<f32>(_e7037, 1f), vec2<f32>(_e6923, 0f), vec2((_e6923 < _e7037)));
                                                let _e7055 = select(vec2<f32>(_e7047, 3f), _e7051, vec2((_e7051.x < _e7047)));
                                                let _e7061 = (-0.5773f * select(vec2<f32>(_e7039, 2f), _e7055, vec2((_e7055.x < _e7039))).x);
                                                let _e7067 = local_140;
                                                let _e7069 = (_e6759.y + 2.0000577f);
                                                let _e7070 = (_e7069 * _e7069);
                                                let _e7074 = (sqrt(fma(_e6769, _e6769, fma(_e6914, _e6914, _e7070))) - 1f);
                                                let _e7076 = local_141;
                                                let _e7077 = (_e7076 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                                let _e7087 = fma(0.9689124f, _e7077.z, fma(0.04851991f, _e7077.y, (_e7077.x * -0.24259955f)));
                                                let _e7094 = (_e7077 + vec3<f32>((_e7087 * 0.4851991f), (_e7087 * -0.09703982f), (2f * fma(0.04851991f, fma(_e7077.z, -0.04851991f, (0.9689124f * _e7077.y)), (fma(0.24259955f, _e7077.z, (0.9689124f * _e7077.x)) * -0.24259955f)))));
                                                let _e7114 = ((_e7094 + vec3<f32>(0f, (fma(0.38268346f, _e7094.y, (0.9238795f * _e7094.z)) * -0.7653669f), (fma(_e7094.z, -0.38268346f, (0.9238795f * _e7094.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e7120 = (sqrt(fma(_e7114.x, _e7114.x, (_e7114.z * _e7114.z))) + -0.5f);
                                                let _e7123 = (abs(_e7114.y) - 0.1f);
                                                let _e7126 = max(_e7120, 0f);
                                                let _e7127 = max(_e7123, 0f);
                                                let _e7132 = ((min(max(_e7120, _e7123), 0f) + sqrt(fma(_e7126, _e7126, (_e7127 * _e7127)))) - 0.1f);
                                                let _e7133 = ((_e7094 + vec3<f32>((fma(0.70710677f, _e7094.x, (0.70710677f * _e7094.y)) * -1.4142135f), (fma(_e7094.y, -0.70710677f, (0.70710677f * _e7094.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e7138 = sqrt(fma(_e7133.x, _e7133.x, (_e7133.z * _e7133.z)));
                                                let _e7139 = (_e7138 + -0.5f);
                                                let _e7141 = abs(_e7133.y);
                                                let _e7142 = (_e7141 - 0.1f);
                                                let _e7145 = max(_e7139, 0f);
                                                let _e7146 = max(_e7142, 0f);
                                                let _e7151 = ((min(max(_e7139, _e7142), 0f) + sqrt(fma(_e7145, _e7145, (_e7146 * _e7146)))) - 0.1f);
                                                let _e7152 = (_e7138 + -0.20000002f);
                                                let _e7153 = (_e7141 - 0.4f);
                                                let _e7156 = max(_e7152, 0f);
                                                let _e7157 = max(_e7153, 0f);
                                                let _e7161 = (min(max(_e7152, _e7153), 0f) + sqrt(fma(_e7156, _e7156, (_e7157 * _e7157))));
                                                let _e7165 = fma(-((_e7151 + (_e7161 - 0.1f))), 5f, 0.5f);
                                                if (_e7165 < 0f) {
                                                    phi_20113_ = 0f;
                                                } else {
                                                    phi_20113_ = select(_e7165, 1f, (_e7165 > 1f));
                                                }
                                                let _e7170 = phi_20113_;
                                                let _e7176 = fma((0.1f * _e7170), (1f - _e7170), fma(((0.1f - _e7161) - _e7151), _e7170, _e7151));
                                                let _e7178 = fma((_e7176 - _e7132), 5f, 0.5f);
                                                if (_e7178 < 0f) {
                                                    phi_20139_ = 0f;
                                                } else {
                                                    phi_20139_ = select(_e7178, 1f, (_e7178 > 1f));
                                                }
                                                let _e7183 = phi_20139_;
                                                let _e7188 = fma((_e7183 * -0.1f), (1f - _e7183), fma((_e7132 - _e7176), _e7183, _e7176));
                                                let _e7190 = fma((_e7067 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                                let _e7194 = (_e6759.y + -0.99994224f);
                                                let _e7195 = (_e7194 * _e7194);
                                                let _e7199 = (sqrt(fma(_e6764, _e6764, fma(_e7043, _e7043, _e7195))) - 0.6f);
                                                let _e7203 = select(vec2<f32>(_e7188, 1f), vec2<f32>(_e7074, 0f), vec2((_e7074 < _e7188)));
                                                let _e7207 = select(vec2<f32>(_e7199, 3f), _e7203, vec2((_e7203.x < _e7199)));
                                                let _e7217 = local_142;
                                                let _e7222 = (sqrt(fma(_e6919, _e6919, fma(_e6757, _e6757, _e7070))) - 1f);
                                                let _e7224 = local_143;
                                                let _e7225 = (_e7224 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                                let _e7235 = fma(0.9689124f, _e7225.z, fma(0.04851991f, _e7225.y, (_e7225.x * -0.24259955f)));
                                                let _e7242 = (_e7225 + vec3<f32>((_e7235 * 0.4851991f), (_e7235 * -0.09703982f), (2f * fma(0.04851991f, fma(_e7225.z, -0.04851991f, (0.9689124f * _e7225.y)), (fma(0.24259955f, _e7225.z, (0.9689124f * _e7225.x)) * -0.24259955f)))));
                                                let _e7262 = ((_e7242 + vec3<f32>(0f, (fma(0.38268346f, _e7242.y, (0.9238795f * _e7242.z)) * -0.7653669f), (fma(_e7242.z, -0.38268346f, (0.9238795f * _e7242.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                                let _e7268 = (sqrt(fma(_e7262.x, _e7262.x, (_e7262.z * _e7262.z))) + -0.5f);
                                                let _e7271 = (abs(_e7262.y) - 0.1f);
                                                let _e7274 = max(_e7268, 0f);
                                                let _e7275 = max(_e7271, 0f);
                                                let _e7280 = ((min(max(_e7268, _e7271), 0f) + sqrt(fma(_e7274, _e7274, (_e7275 * _e7275)))) - 0.1f);
                                                let _e7281 = ((_e7242 + vec3<f32>((fma(0.70710677f, _e7242.x, (0.70710677f * _e7242.y)) * -1.4142135f), (fma(_e7242.y, -0.70710677f, (0.70710677f * _e7242.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                                let _e7286 = sqrt(fma(_e7281.x, _e7281.x, (_e7281.z * _e7281.z)));
                                                let _e7287 = (_e7286 + -0.5f);
                                                let _e7289 = abs(_e7281.y);
                                                let _e7290 = (_e7289 - 0.1f);
                                                let _e7293 = max(_e7287, 0f);
                                                let _e7294 = max(_e7290, 0f);
                                                let _e7299 = ((min(max(_e7287, _e7290), 0f) + sqrt(fma(_e7293, _e7293, (_e7294 * _e7294)))) - 0.1f);
                                                let _e7300 = (_e7286 + -0.20000002f);
                                                let _e7301 = (_e7289 - 0.4f);
                                                let _e7304 = max(_e7300, 0f);
                                                let _e7305 = max(_e7301, 0f);
                                                let _e7309 = (min(max(_e7300, _e7301), 0f) + sqrt(fma(_e7304, _e7304, (_e7305 * _e7305))));
                                                let _e7313 = fma(-((_e7299 + (_e7309 - 0.1f))), 5f, 0.5f);
                                                if (_e7313 < 0f) {
                                                    phi_20510_ = 0f;
                                                } else {
                                                    phi_20510_ = select(_e7313, 1f, (_e7313 > 1f));
                                                }
                                                let _e7318 = phi_20510_;
                                                let _e7324 = fma((0.1f * _e7318), (1f - _e7318), fma(((0.1f - _e7309) - _e7299), _e7318, _e7299));
                                                let _e7326 = fma((_e7324 - _e7280), 5f, 0.5f);
                                                if (_e7326 < 0f) {
                                                    phi_20536_ = 0f;
                                                } else {
                                                    phi_20536_ = select(_e7326, 1f, (_e7326 > 1f));
                                                }
                                                let _e7331 = phi_20536_;
                                                let _e7336 = fma((_e7331 * -0.1f), (1f - _e7331), fma((_e7280 - _e7324), _e7331, _e7324));
                                                let _e7338 = fma((_e7217 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                                let _e7345 = (sqrt(fma(_e6915, _e6915, fma(_e6894, _e6894, _e7195))) - 0.6f);
                                                let _e7349 = select(vec2<f32>(_e7336, 1f), vec2<f32>(_e7222, 0f), vec2((_e7222 < _e7336)));
                                                let _e7353 = select(vec2<f32>(_e7345, 3f), _e7349, vec2((_e7349.x < _e7345)));
                                                let _e7359 = fma(0.5773f, select(vec2<f32>(_e7338, 2f), _e7353, vec2((_e7353.x < _e7338))).x, fma(-0.5773f, select(vec2<f32>(_e7190, 2f), _e7207, vec2((_e7207.x < _e7190))).x, fma(0.5773f, select(vec2<f32>(_e6890, 2f), _e6908, vec2((_e6908.x < _e6890))).x, _e7061)));
                                                let _e7360 = fma(0.5773f, select(vec2<f32>(_e7338, 2f), _e7353, vec2((_e7353.x < _e7338))).x, fma(0.5773f, select(vec2<f32>(_e7190, 2f), _e7207, vec2((_e7207.x < _e7190))).x, fma(-0.5773f, select(vec2<f32>(_e6890, 2f), _e6908, vec2((_e6908.x < _e6890))).x, _e7061)));
                                                let _e7361 = fma(0.5773f, select(vec2<f32>(_e7338, 2f), _e7353, vec2((_e7353.x < _e7338))).x, fma(-0.5773f, select(vec2<f32>(_e7190, 2f), _e7207, vec2((_e7207.x < _e7190))).x, fma(-0.5773f, select(vec2<f32>(_e6890, 2f), _e6908, vec2((_e6908.x < _e6890))).x, (0.5773f * select(vec2<f32>(_e7039, 2f), _e7055, vec2((_e7055.x < _e7039))).x))));
                                                let _e7366 = (1f / sqrt(fma(_e7361, _e7361, fma(_e7359, _e7359, (_e7360 * _e7360)))));
                                                let _e7367 = (_e7359 * _e7366);
                                                let _e7368 = (_e7360 * _e7366);
                                                let _e7369 = (_e7361 * _e7366);
                                                let _e7371 = local_144;
                                                let _e7377 = select(select(u32(_e7371.y), 0u, (_e7371.y < 0f)), 4294967295u, (_e7371.y > 4294967000f));
                                                if (_e7377 > (_e152 - 1u)) {
                                                    let _e7393 = local_146;
                                                    phi_4021_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e7367, _e7368, _e7369, _e7393), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                                } else {
                                                    if (_e7377 < _e152) {
                                                    } else {
                                                        break;
                                                    }
                                                    let _e7382 = global_4.member[_e7377];
                                                    let _e7384 = local_145;
                                                    phi_4021_ = type_26(_e7382.member, vec4<f32>(_e7367, _e7368, _e7369, _e7384), _e7382.member_2, _e7382.member_3, _e7382.member_4);
                                                }
                                                let _e7402 = phi_4021_;
                                                phi_4022_ = _e7402;
                                            } else {
                                                phi_4022_ = type_26();
                                            }
                                            let _e7404 = phi_4022_;
                                            let _e7406 = local_147;
                                            let _e7408 = local_148;
                                            let _e7411 = local_149;
                                            let _e7413 = local_150;
                                            if select(select(_e7413, false, _e7411), true, select(_e7408, false, _e7406)) {
                                                phi_4033_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                            } else {
                                                phi_4033_ = _e7404;
                                            }
                                            let _e7417 = phi_4033_;
                                            if (sqrt(fma(_e7417.member_1.z, _e7417.member_1.z, fma(_e7417.member_1.x, _e7417.member_1.x, (_e7417.member_1.y * _e7417.member_1.y)))) > 0f) {
                                                if (_e7417.member_4.z > 0f) {
                                                    let _e7437 = (_e6555.member_1.w + 0.01f);
                                                    let _e7440 = max((0.3f + fma(-(_e7417.member_1.z), _e5701, fma(-(_e7417.member_1.x), _e5695, (-(_e7417.member_1.y) * _e5698)))), 0f);
                                                    let _e7443 = (0.2f / (_e7417.member_1.w * _e7417.member_1.w));
                                                    let _e7445 = ((_e7437 * -3f) * (3f * _e7437));
                                                    let _e7447 = exp((_e7445 * 156.25f));
                                                    let _e7449 = exp((_e7445 * 20.661158f));
                                                    let _e7457 = exp((_e7445 * 5.3475933f));
                                                    let _e7461 = exp((_e7445 * 1.7636685f));
                                                    let _e7466 = exp((_e7445 * 0.5025126f));
                                                    phi_4091_ = (((fma(0.078f, exp((_e7445 * 0.13495277f)), fma(0.358f, _e7466, fma(0.113f, _e7461, fma(0.118f, _e7457, fma(0.233f, _e7447, (0.1f * _e7449)))))) * _e7440) * _e7443) * (_e7417.member_2.x * _e7417.member_4.z));
                                                    phi_4092_ = (((fma(0.004f, _e7466, fma(0.007f, _e7461, fma(0.198f, _e7457, fma(0.455f, _e7447, (0.336f * _e7449))))) * _e7440) * _e7443) * (_e7417.member_2.y * _e7417.member_4.z));
                                                    phi_4093_ = (((fma(0.007f, _e7461, fma(0.649f, _e7447, (0.344f * _e7449))) * _e7440) * _e7443) * (_e7417.member_2.z * _e7417.member_4.z));
                                                } else {
                                                    phi_4091_ = 0f;
                                                    phi_4092_ = 0f;
                                                    phi_4093_ = 0f;
                                                }
                                                let _e7488 = phi_4091_;
                                                let _e7490 = phi_4092_;
                                                let _e7492 = phi_4093_;
                                                phi_4094_ = _e7488;
                                                phi_4095_ = _e7490;
                                                phi_4096_ = _e7492;
                                            } else {
                                                phi_4094_ = 0f;
                                                phi_4095_ = 0f;
                                                phi_4096_ = 0f;
                                            }
                                            let _e7494 = phi_4094_;
                                            let _e7496 = phi_4095_;
                                            let _e7498 = phi_4096_;
                                            phi_4104_ = vec3<f32>(fma(_e2143.member_2.x, _e5533, ((_e2143.member.w * _e2143.member_3.x) * _e7494)), fma(_e2143.member_2.y, _e5536, ((_e2143.member.w * _e2143.member_3.y) * _e7496)), fma(_e2143.member_2.z, _e5539, ((_e2143.member.w * _e2143.member_3.z) * _e7498)));
                                        } else {
                                            phi_4104_ = (vec3<f32>(_e2143.member_2.x, _e2143.member_2.y, _e2143.member_2.z) * vec3<f32>(_e5533, _e5536, _e5539));
                                        }
                                        let _e7507 = phi_4104_;
                                        phi_4105_ = _e7507;
                                    }
                                    let _e7513 = phi_4105_;
                                    phi_4127_ = _e7513;
                                } else {
                                    let _e2162 = (_e1290 + vec3<f32>((_e1270 * 1000f), (_e1271 * 1000f), (_e1272 * 1000f)));
                                    let _e2170 = (1f / sqrt(fma(_e2162.z, _e2162.z, fma(_e2162.x, _e2162.x, (_e2162.y * _e2162.y)))));
                                    let _e2176 = fma(atan2((_e2162.z * _e2170), (_e2162.x * _e2170)), 0.31830987f, 1f);
                                    let _e2177 = fma(asin((_e2162.y * _e2170)), 0.63661975f, 1f);
                                    let _e2178 = (_e2176 * 0.5f);
                                    let _e2179 = (_e2177 * 0.5f);
                                    if (_e2178 > 0f) {
                                        phi_9300_ = (_e2178 % 1f);
                                    } else {
                                        phi_9300_ = (1f - ((_e2176 * -0.5f) % 1f));
                                    }
                                    let _e2186 = phi_9300_;
                                    if (_e2179 > 0f) {
                                        phi_9313_ = (_e2179 % 1f);
                                    } else {
                                        phi_9313_ = (1f - ((_e2177 * -0.5f) % 1f));
                                    }
                                    let _e2193 = phi_9313_;
                                    let _e2195 = textureSampleLevel(global_5, global_6, vec2<f32>(_e2186, _e2193), 0f);
                                    phi_4127_ = vec3<f32>(_e2195.x, _e2195.y, _e2195.z);
                                }
                                let _e7515 = phi_4127_;
                                let _e7519 = fma((1f - _e1100.member.y), pow((1f - _e1277), 5f), _e1100.member.y);
                                let _e7521 = fma(-(_e1136), 0.5f, 1f);
                                let _e7530 = (((((_e1277 / fma(_e1277, _e7521, _e1139)) * (_e1280 / fma(_e1280, _e7521, _e1139))) * _e7519) * _e1266) / (max(fma(_e1100.member_1.z, _e1262, fma(_e1100.member_1.x, _e1256, (_e1100.member_1.y * _e1259))), 0f) * _e1277));
                                phi_4147_ = _e7519;
                                phi_4148_ = (_e7515.x * _e7530);
                                phi_4149_ = (_e7515.y * _e7530);
                                phi_4150_ = (_e7515.z * _e7530);
                            } else {
                                phi_4147_ = 0f;
                                phi_4148_ = 0f;
                                phi_4149_ = 0f;
                                phi_4150_ = 0f;
                            }
                            let _e7538 = phi_4147_;
                            let _e7540 = phi_4148_;
                            let _e7542 = phi_4149_;
                            let _e7544 = phi_4150_;
                            let _e7545 = (_e171.y + 30u);
                            let _e7546 = (_e1133 + vec2<f32>(2f, 3f));
                            let _e7549 = global_1.member.member_3[0u];
                            let _e7554 = select(select(u32(_e7549), 0u, (_e7549 < 0f)), 4294967295u, (_e7549 > 4294967000f));
                            let _e7572 = ((((select(select(u32(_e7546.x), 0u, (_e7546.x < 0f)), 4294967295u, (_e7546.x > 4294967000f)) * _e7545) + ((select(select(u32(_e7546.y), 0u, (_e7546.y < 0f)), 4294967295u, (_e7546.y > 4294967000f)) * _e7545) * _e7554)) * 747796405u) + 2891336453u);
                            let _e7580 = (((_e7572 >> bitcast<u32>((((_e7572 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e7572) * 277803737u);
                            let _e7585 = (f32(((_e7580 >> bitcast<u32>(22i)) ^ _e7580)) * 0.00000000023283064f);
                            if (_e7585 < 0f) {
                                phi_20855_ = 0f;
                            } else {
                                phi_20855_ = select(_e7585, 1f, (_e7585 > 1f));
                            }
                            let _e7590 = phi_20855_;
                            let _e7591 = (_e160 + -2f);
                            let _e7607 = ((((select(select(u32(_e7591), 0u, (_e7591 < 0f)), 4294967295u, (_e7591 > 4294967000f)) * _e7545) + ((select(select(u32(_e159), 0u, (_e159 < 0f)), 4294967295u, (_e159 > 4294967000f)) * _e7545) * _e7554)) * 747796405u) + 2891336453u);
                            let _e7615 = (((_e7607 >> bitcast<u32>((((_e7607 >> bitcast<u32>(28i)) + 4u) & 31u))) ^ _e7607) * 277803737u);
                            let _e7620 = (f32(((_e7615 >> bitcast<u32>(22i)) ^ _e7615)) * 0.00000000023283064f);
                            if (_e7620 < 0f) {
                                phi_20904_ = 0f;
                            } else {
                                phi_20904_ = select(_e7620, 1f, (_e7620 > 1f));
                            }
                            let _e7625 = phi_20904_;
                            let _e7627 = -(_e1120.x);
                            let _e7629 = (-2f - _e1120.y);
                            let _e7631 = (2.5f - _e1120.z);
                            let _e7635 = sqrt(fma(_e7631, _e7631, fma(_e7627, _e7627, (_e7629 * _e7629))));
                            let _e7636 = (_e7627 / _e7635);
                            let _e7637 = (_e7629 / _e7635);
                            let _e7638 = (_e7631 / _e7635);
                            let _e7645 = fma(_e7590, sqrt(max((1f - (1f / (_e7635 * _e7635))), 0f)), (1f - _e7590));
                            let _e7649 = sqrt(max(fma(-(_e7645), _e7645, 1f), 0f));
                            let _e7650 = (_e7625 * 6.2831855f);
                            let _e7652 = (cos(_e7650) * _e7649);
                            let _e7654 = (sin(_e7650) * _e7649);
                            if (abs(_e7636) > abs(_e7637)) {
                                let _e7667 = sqrt(fma(_e7636, _e7636, (_e7638 * _e7638)));
                                phi_20943_ = (-(_e7636) / _e7667);
                                phi_20944_ = 0f;
                                phi_20945_ = (_e7638 / _e7667);
                            } else {
                                let _e7661 = sqrt(fma(_e7637, _e7637, (_e7638 * _e7638)));
                                phi_20943_ = (_e7637 / _e7661);
                                phi_20944_ = (-(_e7638) / _e7661);
                                phi_20945_ = 0f;
                            }
                            let _e7671 = phi_20943_;
                            let _e7673 = phi_20944_;
                            let _e7675 = phi_20945_;
                            let _e7687 = fma(_e7654, _e7675, fma(_e7652, fma(_e7637, _e7671, -((_e7673 * _e7638))), (_e7645 * _e7636)));
                            let _e7690 = fma(_e7654, _e7673, fma(_e7652, fma(_e7638, _e7675, -((_e7671 * _e7636))), (_e7645 * _e7637)));
                            let _e7693 = fma(_e7654, _e7671, fma(_e7652, fma(_e7636, _e7673, -((_e7675 * _e7637))), (_e7645 * _e7638)));
                            let _e7694 = (_e1128 + _e7687);
                            let _e7695 = (_e1129 + _e7690);
                            let _e7696 = (_e1130 + _e7693);
                            let _e7700 = sqrt(fma(_e7696, _e7696, fma(_e7694, _e7694, (_e7695 * _e7695))));
                            let _e7706 = fma(_e1100.member_1.z, _e7693, fma(_e1100.member_1.x, _e7687, (_e1100.member_1.y * _e7690)));
                            let _e7710 = max(fma(_e1100.member_1.z, (_e7696 / _e7700), fma(_e1100.member_1.x, (_e7694 / _e7700), (_e1100.member_1.y * (_e7695 / _e7700)))), 0f);
                            if (_e7706 > 0f) {
                                phi_4290_ = 0.01f;
                                phi_4293_ = 0u;
                                loop {
                                    let _e7713 = phi_4290_;
                                    let _e7715 = phi_4293_;
                                    local_164 = _e7713;
                                    local_165 = _e7713;
                                    let _e7716 = (_e7715 < 300u);
                                    if _e7716 {
                                        phi_4294_ = (_e7715 + 1u);
                                    } else {
                                        phi_4294_ = _e7715;
                                    }
                                    let _e7719 = phi_4294_;
                                    if _e7716 {
                                        let _e7724 = (vec3<f32>((_e7687 * _e7713), (_e7690 * _e7713), (_e7693 * _e7713)) + _e1120);
                                        let _e7725 = (_e7724 - vec3<f32>(0f, -2f, 2.5f));
                                        let _e7733 = (sqrt(fma(_e7725.z, _e7725.z, fma(_e7725.x, _e7725.x, (_e7725.y * _e7725.y)))) - 1f);
                                        let _e7734 = (_e7724 + vec3<f32>(0f, -1f, 0f));
                                        let _e7744 = fma(0.9689124f, _e7734.z, fma(0.04851991f, _e7734.y, (_e7734.x * -0.24259955f)));
                                        let _e7751 = (_e7734 + vec3<f32>((_e7744 * 0.4851991f), (_e7744 * -0.09703982f), (2f * fma(0.04851991f, fma(_e7734.z, -0.04851991f, (0.9689124f * _e7734.y)), (fma(0.24259955f, _e7734.z, (0.9689124f * _e7734.x)) * -0.24259955f)))));
                                        let _e7771 = ((_e7751 + vec3<f32>(0f, (fma(0.38268346f, _e7751.y, (0.9238795f * _e7751.z)) * -0.7653669f), (fma(_e7751.z, -0.38268346f, (0.9238795f * _e7751.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                        let _e7777 = (sqrt(fma(_e7771.x, _e7771.x, (_e7771.z * _e7771.z))) + -0.5f);
                                        let _e7780 = (abs(_e7771.y) - 0.1f);
                                        let _e7783 = max(_e7777, 0f);
                                        let _e7784 = max(_e7780, 0f);
                                        let _e7789 = ((min(max(_e7777, _e7780), 0f) + sqrt(fma(_e7783, _e7783, (_e7784 * _e7784)))) - 0.1f);
                                        let _e7790 = ((_e7751 + vec3<f32>((fma(0.70710677f, _e7751.x, (0.70710677f * _e7751.y)) * -1.4142135f), (fma(_e7751.y, -0.70710677f, (0.70710677f * _e7751.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                        let _e7795 = sqrt(fma(_e7790.x, _e7790.x, (_e7790.z * _e7790.z)));
                                        let _e7796 = (_e7795 + -0.5f);
                                        let _e7798 = abs(_e7790.y);
                                        let _e7799 = (_e7798 - 0.1f);
                                        let _e7802 = max(_e7796, 0f);
                                        let _e7803 = max(_e7799, 0f);
                                        let _e7808 = ((min(max(_e7796, _e7799), 0f) + sqrt(fma(_e7802, _e7802, (_e7803 * _e7803)))) - 0.1f);
                                        let _e7809 = (_e7795 + -0.20000002f);
                                        let _e7810 = (_e7798 - 0.4f);
                                        let _e7813 = max(_e7809, 0f);
                                        let _e7814 = max(_e7810, 0f);
                                        let _e7818 = (min(max(_e7809, _e7810), 0f) + sqrt(fma(_e7813, _e7813, (_e7814 * _e7814))));
                                        let _e7822 = fma(-((_e7808 + (_e7818 - 0.1f))), 5f, 0.5f);
                                        if (_e7822 < 0f) {
                                            phi_21319_ = 0f;
                                        } else {
                                            phi_21319_ = select(_e7822, 1f, (_e7822 > 1f));
                                        }
                                        let _e7827 = phi_21319_;
                                        let _e7833 = fma((0.1f * _e7827), (1f - _e7827), fma(((0.1f - _e7818) - _e7808), _e7827, _e7808));
                                        let _e7835 = fma((_e7833 - _e7789), 5f, 0.5f);
                                        if (_e7835 < 0f) {
                                            phi_21345_ = 0f;
                                        } else {
                                            phi_21345_ = select(_e7835, 1f, (_e7835 > 1f));
                                        }
                                        let _e7840 = phi_21345_;
                                        let _e7845 = fma((_e7840 * -0.1f), (1f - _e7840), fma((_e7789 - _e7833), _e7840, _e7833));
                                        let _e7847 = fma(_e7724.y, -1f, 3f);
                                        let _e7851 = (_e7724 - vec3<f32>(-1f, 1f, 0f));
                                        let _e7859 = (sqrt(fma(_e7851.z, _e7851.z, fma(_e7851.x, _e7851.x, (_e7851.y * _e7851.y)))) - 0.6f);
                                        let _e7863 = select(vec2<f32>(_e7845, 1f), vec2<f32>(_e7733, 0f), vec2((_e7733 < _e7845)));
                                        let _e7867 = select(vec2<f32>(_e7859, 3f), _e7863, vec2((_e7863.x < _e7859)));
                                        let _e7871 = select(vec2<f32>(_e7847, 2f), _e7867, vec2((_e7867.x < _e7847)));
                                        let _e7873 = (_e7871.x < 0.001f);
                                        if _e7873 {
                                            phi_4349_ = f32();
                                            phi_4350_ = false;
                                            phi_4351_ = false;
                                        } else {
                                            let _e7874 = (_e7713 > 22f);
                                            if _e7874 {
                                                phi_4347_ = f32();
                                            } else {
                                                phi_4347_ = (_e7713 + _e7871.x);
                                            }
                                            let _e7877 = phi_4347_;
                                            phi_4349_ = _e7877;
                                            phi_4350_ = select(true, false, _e7874);
                                            phi_4351_ = _e7874;
                                        }
                                        let _e7880 = phi_4349_;
                                        let _e7882 = phi_4350_;
                                        let _e7884 = phi_4351_;
                                        phi_4352_ = _e7724;
                                        phi_4353_ = _e7871;
                                        phi_4291_ = _e7880;
                                        phi_4354_ = _e7882;
                                        phi_4355_ = _e7873;
                                        phi_4356_ = _e7884;
                                    } else {
                                        phi_4352_ = vec3<f32>();
                                        phi_4353_ = vec2<f32>();
                                        phi_4291_ = f32();
                                        phi_4354_ = false;
                                        phi_4355_ = false;
                                        phi_4356_ = false;
                                    }
                                    let _e7886 = phi_4352_;
                                    let _e7888 = phi_4353_;
                                    let _e7890 = phi_4291_;
                                    let _e7892 = phi_4354_;
                                    let _e7894 = phi_4355_;
                                    let _e7896 = phi_4356_;
                                    local_151 = _e7894;
                                    local_152 = _e7886;
                                    local_153 = _e7886;
                                    local_154 = _e7886;
                                    local_155 = _e7886;
                                    local_156 = _e7886;
                                    local_157 = _e7886;
                                    local_158 = _e7886;
                                    local_159 = _e7886;
                                    local_160 = _e7886;
                                    local_161 = _e7886;
                                    local_162 = _e7886;
                                    local_163 = _e7888;
                                    local_166 = _e7894;
                                    local_167 = _e7896;
                                    local_168 = _e7894;
                                    local_169 = select(true, false, _e7716);
                                    continue;
                                    continuing {
                                        phi_4290_ = _e7890;
                                        phi_4293_ = _e7719;
                                        break if !(_e7892);
                                    }
                                }
                                let _e7900 = local_151;
                                if _e7900 {
                                    let _e7902 = local_152;
                                    let _e7904 = (_e7902.x + 0.000057729998f);
                                    let _e7906 = local_153;
                                    let _e7909 = local_154;
                                    let _e7911 = (_e7909.z + -0.000057729998f);
                                    let _e7913 = local_155;
                                    let _e7915 = (_e7906.y + 1.9999423f);
                                    let _e7916 = (_e7909.z + -2.5000577f);
                                    let _e7917 = (_e7915 * _e7915);
                                    let _e7921 = (sqrt(fma(_e7916, _e7916, fma(_e7904, _e7904, _e7917))) - 1f);
                                    let _e7923 = local_156;
                                    let _e7924 = (_e7923 + vec3<f32>(0.000057729998f, -1.0000577f, -0.000057729998f));
                                    let _e7934 = fma(0.9689124f, _e7924.z, fma(0.04851991f, _e7924.y, (_e7924.x * -0.24259955f)));
                                    let _e7941 = (_e7924 + vec3<f32>((_e7934 * 0.4851991f), (_e7934 * -0.09703982f), (2f * fma(0.04851991f, fma(_e7924.z, -0.04851991f, (0.9689124f * _e7924.y)), (fma(0.24259955f, _e7924.z, (0.9689124f * _e7924.x)) * -0.24259955f)))));
                                    let _e7961 = ((_e7941 + vec3<f32>(0f, (fma(0.38268346f, _e7941.y, (0.9238795f * _e7941.z)) * -0.7653669f), (fma(_e7941.z, -0.38268346f, (0.9238795f * _e7941.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e7967 = (sqrt(fma(_e7961.x, _e7961.x, (_e7961.z * _e7961.z))) + -0.5f);
                                    let _e7970 = (abs(_e7961.y) - 0.1f);
                                    let _e7973 = max(_e7967, 0f);
                                    let _e7974 = max(_e7970, 0f);
                                    let _e7979 = ((min(max(_e7967, _e7970), 0f) + sqrt(fma(_e7973, _e7973, (_e7974 * _e7974)))) - 0.1f);
                                    let _e7980 = ((_e7941 + vec3<f32>((fma(0.70710677f, _e7941.x, (0.70710677f * _e7941.y)) * -1.4142135f), (fma(_e7941.y, -0.70710677f, (0.70710677f * _e7941.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e7985 = sqrt(fma(_e7980.x, _e7980.x, (_e7980.z * _e7980.z)));
                                    let _e7986 = (_e7985 + -0.5f);
                                    let _e7988 = abs(_e7980.y);
                                    let _e7989 = (_e7988 - 0.1f);
                                    let _e7992 = max(_e7986, 0f);
                                    let _e7993 = max(_e7989, 0f);
                                    let _e7998 = ((min(max(_e7986, _e7989), 0f) + sqrt(fma(_e7992, _e7992, (_e7993 * _e7993)))) - 0.1f);
                                    let _e7999 = (_e7985 + -0.20000002f);
                                    let _e8000 = (_e7988 - 0.4f);
                                    let _e8003 = max(_e7999, 0f);
                                    let _e8004 = max(_e8000, 0f);
                                    let _e8008 = (min(max(_e7999, _e8000), 0f) + sqrt(fma(_e8003, _e8003, (_e8004 * _e8004))));
                                    let _e8012 = fma(-((_e7998 + (_e8008 - 0.1f))), 5f, 0.5f);
                                    if (_e8012 < 0f) {
                                        phi_21716_ = 0f;
                                    } else {
                                        phi_21716_ = select(_e8012, 1f, (_e8012 > 1f));
                                    }
                                    let _e8017 = phi_21716_;
                                    let _e8023 = fma((0.1f * _e8017), (1f - _e8017), fma(((0.1f - _e8008) - _e7998), _e8017, _e7998));
                                    let _e8025 = fma((_e8023 - _e7979), 5f, 0.5f);
                                    if (_e8025 < 0f) {
                                        phi_21742_ = 0f;
                                    } else {
                                        phi_21742_ = select(_e8025, 1f, (_e8025 > 1f));
                                    }
                                    let _e8030 = phi_21742_;
                                    let _e8035 = fma((_e8030 * -0.1f), (1f - _e8030), fma((_e7979 - _e8023), _e8030, _e8023));
                                    let _e8037 = fma((_e7913 + vec3<f32>(0.000057729998f, -0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                    let _e8041 = (_e7902.x + 1.0000577f);
                                    let _e8042 = (_e7906.y + -1.0000577f);
                                    let _e8043 = (_e8042 * _e8042);
                                    let _e8047 = (sqrt(fma(_e7911, _e7911, fma(_e8041, _e8041, _e8043))) - 0.6f);
                                    let _e8051 = select(vec2<f32>(_e8035, 1f), vec2<f32>(_e7921, 0f), vec2((_e7921 < _e8035)));
                                    let _e8055 = select(vec2<f32>(_e8047, 3f), _e8051, vec2((_e8051.x < _e8047)));
                                    let _e8061 = (_e7902.x + -0.000057729998f);
                                    let _e8062 = (_e7909.z + 0.000057729998f);
                                    let _e8064 = local_157;
                                    let _e8066 = (_e7909.z + -2.4999423f);
                                    let _e8070 = (sqrt(fma(_e8066, _e8066, fma(_e8061, _e8061, _e7917))) - 1f);
                                    let _e8072 = local_158;
                                    let _e8073 = (_e8072 + vec3<f32>(-0.000057729998f, -1.0000577f, 0.000057729998f));
                                    let _e8083 = fma(0.9689124f, _e8073.z, fma(0.04851991f, _e8073.y, (_e8073.x * -0.24259955f)));
                                    let _e8090 = (_e8073 + vec3<f32>((_e8083 * 0.4851991f), (_e8083 * -0.09703982f), (2f * fma(0.04851991f, fma(_e8073.z, -0.04851991f, (0.9689124f * _e8073.y)), (fma(0.24259955f, _e8073.z, (0.9689124f * _e8073.x)) * -0.24259955f)))));
                                    let _e8110 = ((_e8090 + vec3<f32>(0f, (fma(0.38268346f, _e8090.y, (0.9238795f * _e8090.z)) * -0.7653669f), (fma(_e8090.z, -0.38268346f, (0.9238795f * _e8090.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e8116 = (sqrt(fma(_e8110.x, _e8110.x, (_e8110.z * _e8110.z))) + -0.5f);
                                    let _e8119 = (abs(_e8110.y) - 0.1f);
                                    let _e8122 = max(_e8116, 0f);
                                    let _e8123 = max(_e8119, 0f);
                                    let _e8128 = ((min(max(_e8116, _e8119), 0f) + sqrt(fma(_e8122, _e8122, (_e8123 * _e8123)))) - 0.1f);
                                    let _e8129 = ((_e8090 + vec3<f32>((fma(0.70710677f, _e8090.x, (0.70710677f * _e8090.y)) * -1.4142135f), (fma(_e8090.y, -0.70710677f, (0.70710677f * _e8090.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e8134 = sqrt(fma(_e8129.x, _e8129.x, (_e8129.z * _e8129.z)));
                                    let _e8135 = (_e8134 + -0.5f);
                                    let _e8137 = abs(_e8129.y);
                                    let _e8138 = (_e8137 - 0.1f);
                                    let _e8141 = max(_e8135, 0f);
                                    let _e8142 = max(_e8138, 0f);
                                    let _e8147 = ((min(max(_e8135, _e8138), 0f) + sqrt(fma(_e8141, _e8141, (_e8142 * _e8142)))) - 0.1f);
                                    let _e8148 = (_e8134 + -0.20000002f);
                                    let _e8149 = (_e8137 - 0.4f);
                                    let _e8152 = max(_e8148, 0f);
                                    let _e8153 = max(_e8149, 0f);
                                    let _e8157 = (min(max(_e8148, _e8149), 0f) + sqrt(fma(_e8152, _e8152, (_e8153 * _e8153))));
                                    let _e8161 = fma(-((_e8147 + (_e8157 - 0.1f))), 5f, 0.5f);
                                    if (_e8161 < 0f) {
                                        phi_22113_ = 0f;
                                    } else {
                                        phi_22113_ = select(_e8161, 1f, (_e8161 > 1f));
                                    }
                                    let _e8166 = phi_22113_;
                                    let _e8172 = fma((0.1f * _e8166), (1f - _e8166), fma(((0.1f - _e8157) - _e8147), _e8166, _e8147));
                                    let _e8174 = fma((_e8172 - _e8128), 5f, 0.5f);
                                    if (_e8174 < 0f) {
                                        phi_22139_ = 0f;
                                    } else {
                                        phi_22139_ = select(_e8174, 1f, (_e8174 > 1f));
                                    }
                                    let _e8179 = phi_22139_;
                                    let _e8184 = fma((_e8179 * -0.1f), (1f - _e8179), fma((_e8128 - _e8172), _e8179, _e8172));
                                    let _e8186 = fma((_e8064 + vec3<f32>(-0.000057729998f, -0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                    let _e8190 = (_e7902.x + 0.99994224f);
                                    let _e8194 = (sqrt(fma(_e8062, _e8062, fma(_e8190, _e8190, _e8043))) - 0.6f);
                                    let _e8198 = select(vec2<f32>(_e8184, 1f), vec2<f32>(_e8070, 0f), vec2((_e8070 < _e8184)));
                                    let _e8202 = select(vec2<f32>(_e8194, 3f), _e8198, vec2((_e8198.x < _e8194)));
                                    let _e8208 = (-0.5773f * select(vec2<f32>(_e8186, 2f), _e8202, vec2((_e8202.x < _e8186))).x);
                                    let _e8214 = local_159;
                                    let _e8216 = (_e7906.y + 2.0000577f);
                                    let _e8217 = (_e8216 * _e8216);
                                    let _e8221 = (sqrt(fma(_e7916, _e7916, fma(_e8061, _e8061, _e8217))) - 1f);
                                    let _e8223 = local_160;
                                    let _e8224 = (_e8223 + vec3<f32>(-0.000057729998f, -0.99994224f, -0.000057729998f));
                                    let _e8234 = fma(0.9689124f, _e8224.z, fma(0.04851991f, _e8224.y, (_e8224.x * -0.24259955f)));
                                    let _e8241 = (_e8224 + vec3<f32>((_e8234 * 0.4851991f), (_e8234 * -0.09703982f), (2f * fma(0.04851991f, fma(_e8224.z, -0.04851991f, (0.9689124f * _e8224.y)), (fma(0.24259955f, _e8224.z, (0.9689124f * _e8224.x)) * -0.24259955f)))));
                                    let _e8261 = ((_e8241 + vec3<f32>(0f, (fma(0.38268346f, _e8241.y, (0.9238795f * _e8241.z)) * -0.7653669f), (fma(_e8241.z, -0.38268346f, (0.9238795f * _e8241.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e8267 = (sqrt(fma(_e8261.x, _e8261.x, (_e8261.z * _e8261.z))) + -0.5f);
                                    let _e8270 = (abs(_e8261.y) - 0.1f);
                                    let _e8273 = max(_e8267, 0f);
                                    let _e8274 = max(_e8270, 0f);
                                    let _e8279 = ((min(max(_e8267, _e8270), 0f) + sqrt(fma(_e8273, _e8273, (_e8274 * _e8274)))) - 0.1f);
                                    let _e8280 = ((_e8241 + vec3<f32>((fma(0.70710677f, _e8241.x, (0.70710677f * _e8241.y)) * -1.4142135f), (fma(_e8241.y, -0.70710677f, (0.70710677f * _e8241.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e8285 = sqrt(fma(_e8280.x, _e8280.x, (_e8280.z * _e8280.z)));
                                    let _e8286 = (_e8285 + -0.5f);
                                    let _e8288 = abs(_e8280.y);
                                    let _e8289 = (_e8288 - 0.1f);
                                    let _e8292 = max(_e8286, 0f);
                                    let _e8293 = max(_e8289, 0f);
                                    let _e8298 = ((min(max(_e8286, _e8289), 0f) + sqrt(fma(_e8292, _e8292, (_e8293 * _e8293)))) - 0.1f);
                                    let _e8299 = (_e8285 + -0.20000002f);
                                    let _e8300 = (_e8288 - 0.4f);
                                    let _e8303 = max(_e8299, 0f);
                                    let _e8304 = max(_e8300, 0f);
                                    let _e8308 = (min(max(_e8299, _e8300), 0f) + sqrt(fma(_e8303, _e8303, (_e8304 * _e8304))));
                                    let _e8312 = fma(-((_e8298 + (_e8308 - 0.1f))), 5f, 0.5f);
                                    if (_e8312 < 0f) {
                                        phi_22510_ = 0f;
                                    } else {
                                        phi_22510_ = select(_e8312, 1f, (_e8312 > 1f));
                                    }
                                    let _e8317 = phi_22510_;
                                    let _e8323 = fma((0.1f * _e8317), (1f - _e8317), fma(((0.1f - _e8308) - _e8298), _e8317, _e8298));
                                    let _e8325 = fma((_e8323 - _e8279), 5f, 0.5f);
                                    if (_e8325 < 0f) {
                                        phi_22536_ = 0f;
                                    } else {
                                        phi_22536_ = select(_e8325, 1f, (_e8325 > 1f));
                                    }
                                    let _e8330 = phi_22536_;
                                    let _e8335 = fma((_e8330 * -0.1f), (1f - _e8330), fma((_e8279 - _e8323), _e8330, _e8323));
                                    let _e8337 = fma((_e8214 + vec3<f32>(-0.000057729998f, 0.000057729998f, -0.000057729998f)).y, -1f, 3f);
                                    let _e8341 = (_e7906.y + -0.99994224f);
                                    let _e8342 = (_e8341 * _e8341);
                                    let _e8346 = (sqrt(fma(_e7911, _e7911, fma(_e8190, _e8190, _e8342))) - 0.6f);
                                    let _e8350 = select(vec2<f32>(_e8335, 1f), vec2<f32>(_e8221, 0f), vec2((_e8221 < _e8335)));
                                    let _e8354 = select(vec2<f32>(_e8346, 3f), _e8350, vec2((_e8350.x < _e8346)));
                                    let _e8364 = local_161;
                                    let _e8369 = (sqrt(fma(_e8066, _e8066, fma(_e7904, _e7904, _e8217))) - 1f);
                                    let _e8371 = local_162;
                                    let _e8372 = (_e8371 + vec3<f32>(0.000057729998f, -0.99994224f, 0.000057729998f));
                                    let _e8382 = fma(0.9689124f, _e8372.z, fma(0.04851991f, _e8372.y, (_e8372.x * -0.24259955f)));
                                    let _e8389 = (_e8372 + vec3<f32>((_e8382 * 0.4851991f), (_e8382 * -0.09703982f), (2f * fma(0.04851991f, fma(_e8372.z, -0.04851991f, (0.9689124f * _e8372.y)), (fma(0.24259955f, _e8372.z, (0.9689124f * _e8372.x)) * -0.24259955f)))));
                                    let _e8409 = ((_e8389 + vec3<f32>(0f, (fma(0.38268346f, _e8389.y, (0.9238795f * _e8389.z)) * -0.7653669f), (fma(_e8389.z, -0.38268346f, (0.9238795f * _e8389.y)) * 0.7653669f))) + vec3<f32>(0f, 0f, -0.35f));
                                    let _e8415 = (sqrt(fma(_e8409.x, _e8409.x, (_e8409.z * _e8409.z))) + -0.5f);
                                    let _e8418 = (abs(_e8409.y) - 0.1f);
                                    let _e8421 = max(_e8415, 0f);
                                    let _e8422 = max(_e8418, 0f);
                                    let _e8427 = ((min(max(_e8415, _e8418), 0f) + sqrt(fma(_e8421, _e8421, (_e8422 * _e8422)))) - 0.1f);
                                    let _e8428 = ((_e8389 + vec3<f32>((fma(0.70710677f, _e8389.x, (0.70710677f * _e8389.y)) * -1.4142135f), (fma(_e8389.y, -0.70710677f, (0.70710677f * _e8389.x)) * 1.4142135f), 0f)) + vec3<f32>(-0.35f, 0f, 0.35f));
                                    let _e8433 = sqrt(fma(_e8428.x, _e8428.x, (_e8428.z * _e8428.z)));
                                    let _e8434 = (_e8433 + -0.5f);
                                    let _e8436 = abs(_e8428.y);
                                    let _e8437 = (_e8436 - 0.1f);
                                    let _e8440 = max(_e8434, 0f);
                                    let _e8441 = max(_e8437, 0f);
                                    let _e8446 = ((min(max(_e8434, _e8437), 0f) + sqrt(fma(_e8440, _e8440, (_e8441 * _e8441)))) - 0.1f);
                                    let _e8447 = (_e8433 + -0.20000002f);
                                    let _e8448 = (_e8436 - 0.4f);
                                    let _e8451 = max(_e8447, 0f);
                                    let _e8452 = max(_e8448, 0f);
                                    let _e8456 = (min(max(_e8447, _e8448), 0f) + sqrt(fma(_e8451, _e8451, (_e8452 * _e8452))));
                                    let _e8460 = fma(-((_e8446 + (_e8456 - 0.1f))), 5f, 0.5f);
                                    if (_e8460 < 0f) {
                                        phi_22907_ = 0f;
                                    } else {
                                        phi_22907_ = select(_e8460, 1f, (_e8460 > 1f));
                                    }
                                    let _e8465 = phi_22907_;
                                    let _e8471 = fma((0.1f * _e8465), (1f - _e8465), fma(((0.1f - _e8456) - _e8446), _e8465, _e8446));
                                    let _e8473 = fma((_e8471 - _e8427), 5f, 0.5f);
                                    if (_e8473 < 0f) {
                                        phi_22933_ = 0f;
                                    } else {
                                        phi_22933_ = select(_e8473, 1f, (_e8473 > 1f));
                                    }
                                    let _e8478 = phi_22933_;
                                    let _e8483 = fma((_e8478 * -0.1f), (1f - _e8478), fma((_e8427 - _e8471), _e8478, _e8471));
                                    let _e8485 = fma((_e8364 + vec3<f32>(0.000057729998f, 0.000057729998f, 0.000057729998f)).y, -1f, 3f);
                                    let _e8492 = (sqrt(fma(_e8062, _e8062, fma(_e8041, _e8041, _e8342))) - 0.6f);
                                    let _e8496 = select(vec2<f32>(_e8483, 1f), vec2<f32>(_e8369, 0f), vec2((_e8369 < _e8483)));
                                    let _e8500 = select(vec2<f32>(_e8492, 3f), _e8496, vec2((_e8496.x < _e8492)));
                                    let _e8506 = fma(0.5773f, select(vec2<f32>(_e8485, 2f), _e8500, vec2((_e8500.x < _e8485))).x, fma(-0.5773f, select(vec2<f32>(_e8337, 2f), _e8354, vec2((_e8354.x < _e8337))).x, fma(0.5773f, select(vec2<f32>(_e8037, 2f), _e8055, vec2((_e8055.x < _e8037))).x, _e8208)));
                                    let _e8507 = fma(0.5773f, select(vec2<f32>(_e8485, 2f), _e8500, vec2((_e8500.x < _e8485))).x, fma(0.5773f, select(vec2<f32>(_e8337, 2f), _e8354, vec2((_e8354.x < _e8337))).x, fma(-0.5773f, select(vec2<f32>(_e8037, 2f), _e8055, vec2((_e8055.x < _e8037))).x, _e8208)));
                                    let _e8508 = fma(0.5773f, select(vec2<f32>(_e8485, 2f), _e8500, vec2((_e8500.x < _e8485))).x, fma(-0.5773f, select(vec2<f32>(_e8337, 2f), _e8354, vec2((_e8354.x < _e8337))).x, fma(-0.5773f, select(vec2<f32>(_e8037, 2f), _e8055, vec2((_e8055.x < _e8037))).x, (0.5773f * select(vec2<f32>(_e8186, 2f), _e8202, vec2((_e8202.x < _e8186))).x))));
                                    let _e8513 = (1f / sqrt(fma(_e8508, _e8508, fma(_e8506, _e8506, (_e8507 * _e8507)))));
                                    let _e8514 = (_e8506 * _e8513);
                                    let _e8515 = (_e8507 * _e8513);
                                    let _e8516 = (_e8508 * _e8513);
                                    let _e8518 = local_163;
                                    let _e8524 = select(select(u32(_e8518.y), 0u, (_e8518.y < 0f)), 4294967295u, (_e8518.y > 4294967000f));
                                    if (_e8524 > (_e152 - 1u)) {
                                        let _e8540 = local_165;
                                        phi_4576_ = type_26(type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member, vec4<f32>(_e8514, _e8515, _e8516, _e8540), type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_2, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_3, type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f)).member_4);
                                    } else {
                                        if (_e8524 < _e152) {
                                        } else {
                                            break;
                                        }
                                        let _e8529 = global_4.member[_e8524];
                                        let _e8531 = local_164;
                                        phi_4576_ = type_26(_e8529.member, vec4<f32>(_e8514, _e8515, _e8516, _e8531), _e8529.member_2, _e8529.member_3, _e8529.member_4);
                                    }
                                    let _e8549 = phi_4576_;
                                    phi_4577_ = _e8549;
                                } else {
                                    phi_4577_ = type_26();
                                }
                                let _e8551 = phi_4577_;
                                let _e8553 = local_166;
                                let _e8555 = local_167;
                                let _e8558 = local_168;
                                let _e8560 = local_169;
                                if select(select(_e8560, false, _e8558), true, select(_e8555, false, _e8553)) {
                                    phi_4588_ = type_26(vec4<f32>(0f, 0.04f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 22f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(0f, 0f, 0f, 0f), vec4<f32>(1f, 1f, 0f, 1f));
                                } else {
                                    phi_4588_ = _e8551;
                                }
                                let _e8564 = phi_4588_;
                                if (sqrt(fma(_e8564.member_1.z, _e8564.member_1.z, fma(_e8564.member_1.x, _e8564.member_1.x, (_e8564.member_1.y * _e8564.member_1.y)))) > 0f) {
                                    if (_e8564.member_4.z > 0f) {
                                        let _e8580 = (1f / (_e8564.member_1.w * _e8564.member_1.w));
                                        let _e8590 = (_e7710 * _e1136);
                                        let _e8594 = (_e8590 / fma((_e7710 * _e7710), fma(_e8590, _e8590, -1f), 1f));
                                        let _e8596 = ((_e8594 * _e8594) * 0.31830987f);
                                        let _e8598 = fma(-(_e1137), 0.125f, 1f);
                                        let _e8603 = ((_e1277 / fma(_e1277, _e8598, _e1138)) * (_e7706 / fma(_e7706, _e8598, _e1138)));
                                        let _e8613 = (4f / _e1277);
                                        phi_4631_ = (_e7540 + ((((((_e8564.member_2.x * _e8564.member_4.z) * _e8580) * _e8603) * _e7538) * _e8596) / _e8613));
                                        phi_4632_ = (_e7542 + ((((((_e8564.member_2.y * _e8564.member_4.z) * _e8580) * _e8603) * _e7538) * _e8596) / _e8613));
                                        phi_4633_ = (_e7544 + ((((((_e8564.member_2.z * _e8564.member_4.z) * _e8580) * _e8603) * _e7538) * _e8596) / _e8613));
                                    } else {
                                        phi_4631_ = _e7540;
                                        phi_4632_ = _e7542;
                                        phi_4633_ = _e7544;
                                    }
                                    let _e8621 = phi_4631_;
                                    let _e8623 = phi_4632_;
                                    let _e8625 = phi_4633_;
                                    phi_4634_ = _e8621;
                                    phi_4635_ = _e8623;
                                    phi_4636_ = _e8625;
                                } else {
                                    phi_4634_ = _e7540;
                                    phi_4635_ = _e7542;
                                    phi_4636_ = _e7544;
                                }
                                let _e8627 = phi_4634_;
                                let _e8629 = phi_4635_;
                                let _e8631 = phi_4636_;
                                phi_4637_ = _e8627;
                                phi_4638_ = _e8629;
                                phi_4639_ = _e8631;
                            } else {
                                phi_4637_ = _e7540;
                                phi_4638_ = _e7542;
                                phi_4639_ = _e7544;
                            }
                            let _e8633 = phi_4637_;
                            let _e8635 = phi_4638_;
                            let _e8637 = phi_4639_;
                            phi_4643_ = _e7538;
                            phi_4644_ = (_e1100.member_4.y * _e8633);
                            phi_4645_ = (_e1100.member_4.y * _e8635);
                            phi_4646_ = (_e1100.member_4.y * _e8637);
                        } else {
                            phi_4643_ = 0f;
                            phi_4644_ = 0f;
                            phi_4645_ = 0f;
                            phi_4646_ = 0f;
                        }
                        let _e8642 = phi_4643_;
                        let _e8644 = phi_4644_;
                        let _e8646 = phi_4645_;
                        let _e8648 = phi_4646_;
                        phi_4647_ = _e8642;
                        phi_4648_ = _e8644;
                        phi_4649_ = _e8646;
                        phi_4650_ = _e8648;
                    } else {
                        phi_4647_ = 0f;
                        phi_4648_ = 0f;
                        phi_4649_ = 0f;
                        phi_4650_ = 0f;
                    }
                    let _e8650 = phi_4647_;
                    let _e8652 = phi_4648_;
                    let _e8654 = phi_4649_;
                    let _e8656 = phi_4650_;
                    let _e8657 = (1f - _e8650);
                    textureStore(global_7, vec2<u32>(_e148.x, _e148.y), vec4<f32>(fma(_e8657, _e158.x, _e8652), fma(_e8657, _e158.y, _e8654), fma(_e8657, _e158.z, _e8656), _e158.w));
                }
            }
            break;
        }
    }
    return;
}

@compute @workgroup_size(1, 1, 1) 
fn specularmain(@builtin(global_invocation_id) param: vec3<u32>) {
    global = param;
    function();
}
