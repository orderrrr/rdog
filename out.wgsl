struct type_2 {
    member: vec4<f32>,
    member_1: vec4<f32>,
    member_2: vec4<f32>,
    member_3: vec4<f32>,
}

struct type_3 {
    member: type_2,
    member_1: type_2,
    member_2: vec4<f32>,
    member_3: vec4<f32>,
}

struct type_4 {
    member: type_3,
}

struct type_9 {
    member: vec2<f32>,
    member_1: vec2<u32>,
}

struct type_10 {
    member: type_9,
}

var<private> global: vec3<u32>;
@group(0) @binding(0) 
var<uniform> global_1: type_4;
@group(0) @binding(1) 
var<uniform> global_2: type_10;
@group(0) @binding(2) 
var global_3: texture_2d<f32>;
@group(0) @binding(3) 
var global_4: sampler;
@group(0) @binding(4) 
var global_5: texture_storage_2d<rgba16float,read_write>;

fn function() {
    var phi_8899_: vec2<f32>;
    var phi_8939_: vec2<f32>;
    var phi_418_: f32;
    var phi_421_: u32;
    var phi_423_: f32;
    var phi_425_: f32;
    var phi_427_: f32;
    var phi_429_: f32;
    var phi_431_: f32;
    var phi_433_: f32;
    var phi_422_: u32;
    var phi_9165_: f32;
    var phi_9178_: f32;
    var phi_9208_: f32;
    var phi_9221_: f32;
    var phi_9281_: f32;
    var phi_9294_: f32;
    var phi_9324_: f32;
    var phi_9337_: f32;
    var phi_9397_: f32;
    var phi_9410_: f32;
    var phi_9440_: f32;
    var phi_9453_: f32;
    var phi_9513_: f32;
    var phi_9526_: f32;
    var phi_9556_: f32;
    var phi_9569_: f32;
    var phi_548_: f32;
    var phi_549_: f32;
    var phi_550_: bool;
    var phi_581_: f32;
    var phi_584_: u32;
    var phi_585_: u32;
    var phi_9645_: f32;
    var phi_9658_: f32;
    var phi_9688_: f32;
    var phi_9701_: f32;
    var phi_9761_: f32;
    var phi_9774_: f32;
    var phi_9804_: f32;
    var phi_9817_: f32;
    var phi_9877_: f32;
    var phi_9890_: f32;
    var phi_9920_: f32;
    var phi_9933_: f32;
    var phi_9993_: f32;
    var phi_10006_: f32;
    var phi_10036_: f32;
    var phi_10049_: f32;
    var phi_699_: f32;
    var phi_700_: f32;
    var phi_701_: bool;
    var phi_582_: f32;
    var local: f32;
    var phi_758_: f32;
    var phi_759_: f32;
    var phi_760_: f32;
    var phi_761_: f32;
    var phi_762_: f32;
    var phi_763_: f32;
    var phi_764_: f32;
    var phi_419_: f32;
    var phi_424_: f32;
    var phi_426_: f32;
    var phi_428_: f32;
    var phi_430_: f32;
    var phi_432_: f32;
    var phi_434_: f32;
    var local_1: f32;
    var local_2: f32;
    var local_3: f32;
    var local_4: f32;
    var local_5: f32;
    var local_6: f32;
    var phi_10123_: vec2<f32>;
    var phi_10163_: vec2<f32>;
    var phi_869_: f32;
    var phi_872_: u32;
    var phi_874_: f32;
    var phi_876_: f32;
    var phi_878_: f32;
    var phi_880_: f32;
    var phi_882_: f32;
    var phi_884_: f32;
    var phi_873_: u32;
    var phi_10388_: f32;
    var phi_10401_: f32;
    var phi_10431_: f32;
    var phi_10444_: f32;
    var phi_10504_: f32;
    var phi_10517_: f32;
    var phi_10547_: f32;
    var phi_10560_: f32;
    var phi_10620_: f32;
    var phi_10633_: f32;
    var phi_10663_: f32;
    var phi_10676_: f32;
    var phi_10736_: f32;
    var phi_10749_: f32;
    var phi_10779_: f32;
    var phi_10792_: f32;
    var phi_999_: f32;
    var phi_1000_: f32;
    var phi_1001_: bool;
    var phi_1032_: f32;
    var phi_1035_: u32;
    var phi_1036_: u32;
    var phi_10868_: f32;
    var phi_10881_: f32;
    var phi_10911_: f32;
    var phi_10924_: f32;
    var phi_10984_: f32;
    var phi_10997_: f32;
    var phi_11027_: f32;
    var phi_11040_: f32;
    var phi_11100_: f32;
    var phi_11113_: f32;
    var phi_11143_: f32;
    var phi_11156_: f32;
    var phi_11216_: f32;
    var phi_11229_: f32;
    var phi_11259_: f32;
    var phi_11272_: f32;
    var phi_1150_: f32;
    var phi_1151_: f32;
    var phi_1152_: bool;
    var phi_1033_: f32;
    var local_7: f32;
    var phi_1209_: f32;
    var phi_1210_: f32;
    var phi_1211_: f32;
    var phi_1212_: f32;
    var phi_1213_: f32;
    var phi_1214_: f32;
    var phi_1215_: f32;
    var phi_870_: f32;
    var phi_875_: f32;
    var phi_877_: f32;
    var phi_879_: f32;
    var phi_881_: f32;
    var phi_883_: f32;
    var phi_885_: f32;
    var local_8: f32;
    var local_9: f32;
    var local_10: f32;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var phi_11346_: vec2<f32>;
    var phi_11386_: vec2<f32>;
    var phi_1323_: f32;
    var phi_1326_: u32;
    var phi_1328_: f32;
    var phi_1330_: f32;
    var phi_1332_: f32;
    var phi_1334_: f32;
    var phi_1336_: f32;
    var phi_1338_: f32;
    var phi_1327_: u32;
    var phi_11611_: f32;
    var phi_11624_: f32;
    var phi_11654_: f32;
    var phi_11667_: f32;
    var phi_11727_: f32;
    var phi_11740_: f32;
    var phi_11770_: f32;
    var phi_11783_: f32;
    var phi_11843_: f32;
    var phi_11856_: f32;
    var phi_11886_: f32;
    var phi_11899_: f32;
    var phi_11959_: f32;
    var phi_11972_: f32;
    var phi_12002_: f32;
    var phi_12015_: f32;
    var phi_1453_: f32;
    var phi_1454_: f32;
    var phi_1455_: bool;
    var phi_1486_: f32;
    var phi_1489_: u32;
    var phi_1490_: u32;
    var phi_12091_: f32;
    var phi_12104_: f32;
    var phi_12134_: f32;
    var phi_12147_: f32;
    var phi_12207_: f32;
    var phi_12220_: f32;
    var phi_12250_: f32;
    var phi_12263_: f32;
    var phi_12323_: f32;
    var phi_12336_: f32;
    var phi_12366_: f32;
    var phi_12379_: f32;
    var phi_12439_: f32;
    var phi_12452_: f32;
    var phi_12482_: f32;
    var phi_12495_: f32;
    var phi_1604_: f32;
    var phi_1605_: f32;
    var phi_1606_: bool;
    var phi_1487_: f32;
    var local_14: f32;
    var phi_1663_: f32;
    var phi_1664_: f32;
    var phi_1665_: f32;
    var phi_1666_: f32;
    var phi_1667_: f32;
    var phi_1668_: f32;
    var phi_1669_: f32;
    var phi_1324_: f32;
    var phi_1329_: f32;
    var phi_1331_: f32;
    var phi_1333_: f32;
    var phi_1335_: f32;
    var phi_1337_: f32;
    var phi_1339_: f32;
    var local_15: f32;
    var local_16: f32;
    var local_17: f32;
    var local_18: f32;
    var local_19: f32;
    var local_20: f32;
    var phi_12569_: vec2<f32>;
    var phi_12609_: vec2<f32>;
    var phi_1777_: f32;
    var phi_1780_: u32;
    var phi_1782_: f32;
    var phi_1784_: f32;
    var phi_1786_: f32;
    var phi_1788_: f32;
    var phi_1790_: f32;
    var phi_1792_: f32;
    var phi_1781_: u32;
    var phi_12834_: f32;
    var phi_12847_: f32;
    var phi_12877_: f32;
    var phi_12890_: f32;
    var phi_12950_: f32;
    var phi_12963_: f32;
    var phi_12993_: f32;
    var phi_13006_: f32;
    var phi_13066_: f32;
    var phi_13079_: f32;
    var phi_13109_: f32;
    var phi_13122_: f32;
    var phi_13182_: f32;
    var phi_13195_: f32;
    var phi_13225_: f32;
    var phi_13238_: f32;
    var phi_1907_: f32;
    var phi_1908_: f32;
    var phi_1909_: bool;
    var phi_1940_: f32;
    var phi_1943_: u32;
    var phi_1944_: u32;
    var phi_13314_: f32;
    var phi_13327_: f32;
    var phi_13357_: f32;
    var phi_13370_: f32;
    var phi_13430_: f32;
    var phi_13443_: f32;
    var phi_13473_: f32;
    var phi_13486_: f32;
    var phi_13546_: f32;
    var phi_13559_: f32;
    var phi_13589_: f32;
    var phi_13602_: f32;
    var phi_13662_: f32;
    var phi_13675_: f32;
    var phi_13705_: f32;
    var phi_13718_: f32;
    var phi_2058_: f32;
    var phi_2059_: f32;
    var phi_2060_: bool;
    var phi_1941_: f32;
    var local_21: f32;
    var phi_2117_: f32;
    var phi_2118_: f32;
    var phi_2119_: f32;
    var phi_2120_: f32;
    var phi_2121_: f32;
    var phi_2122_: f32;
    var phi_2123_: f32;
    var phi_1778_: f32;
    var phi_1783_: f32;
    var phi_1785_: f32;
    var phi_1787_: f32;
    var phi_1789_: f32;
    var phi_1791_: f32;
    var phi_1793_: f32;
    var local_22: f32;
    var local_23: f32;
    var local_24: f32;
    var local_25: f32;
    var local_26: f32;
    var local_27: f32;
    var phi_13792_: vec2<f32>;
    var phi_13832_: vec2<f32>;
    var phi_2231_: f32;
    var phi_2234_: u32;
    var phi_2236_: f32;
    var phi_2238_: f32;
    var phi_2240_: f32;
    var phi_2242_: f32;
    var phi_2244_: f32;
    var phi_2246_: f32;
    var phi_2235_: u32;
    var phi_14057_: f32;
    var phi_14070_: f32;
    var phi_14100_: f32;
    var phi_14113_: f32;
    var phi_14173_: f32;
    var phi_14186_: f32;
    var phi_14216_: f32;
    var phi_14229_: f32;
    var phi_14289_: f32;
    var phi_14302_: f32;
    var phi_14332_: f32;
    var phi_14345_: f32;
    var phi_14405_: f32;
    var phi_14418_: f32;
    var phi_14448_: f32;
    var phi_14461_: f32;
    var phi_2361_: f32;
    var phi_2362_: f32;
    var phi_2363_: bool;
    var phi_2394_: f32;
    var phi_2397_: u32;
    var phi_2398_: u32;
    var phi_14537_: f32;
    var phi_14550_: f32;
    var phi_14580_: f32;
    var phi_14593_: f32;
    var phi_14653_: f32;
    var phi_14666_: f32;
    var phi_14696_: f32;
    var phi_14709_: f32;
    var phi_14769_: f32;
    var phi_14782_: f32;
    var phi_14812_: f32;
    var phi_14825_: f32;
    var phi_14885_: f32;
    var phi_14898_: f32;
    var phi_14928_: f32;
    var phi_14941_: f32;
    var phi_2512_: f32;
    var phi_2513_: f32;
    var phi_2514_: bool;
    var phi_2395_: f32;
    var local_28: f32;
    var phi_2571_: f32;
    var phi_2572_: f32;
    var phi_2573_: f32;
    var phi_2574_: f32;
    var phi_2575_: f32;
    var phi_2576_: f32;
    var phi_2577_: f32;
    var phi_2232_: f32;
    var phi_2237_: f32;
    var phi_2239_: f32;
    var phi_2241_: f32;
    var phi_2243_: f32;
    var phi_2245_: f32;
    var phi_2247_: f32;
    var local_29: f32;
    var local_30: f32;
    var local_31: f32;
    var local_32: f32;
    var local_33: f32;
    var local_34: f32;
    var phi_15015_: vec2<f32>;
    var phi_15055_: vec2<f32>;
    var phi_2685_: f32;
    var phi_2688_: u32;
    var phi_2690_: f32;
    var phi_2692_: f32;
    var phi_2694_: f32;
    var phi_2696_: f32;
    var phi_2698_: f32;
    var phi_2700_: f32;
    var phi_2689_: u32;
    var phi_15280_: f32;
    var phi_15293_: f32;
    var phi_15323_: f32;
    var phi_15336_: f32;
    var phi_15396_: f32;
    var phi_15409_: f32;
    var phi_15439_: f32;
    var phi_15452_: f32;
    var phi_15512_: f32;
    var phi_15525_: f32;
    var phi_15555_: f32;
    var phi_15568_: f32;
    var phi_15628_: f32;
    var phi_15641_: f32;
    var phi_15671_: f32;
    var phi_15684_: f32;
    var phi_2815_: f32;
    var phi_2816_: f32;
    var phi_2817_: bool;
    var phi_2848_: f32;
    var phi_2851_: u32;
    var phi_2852_: u32;
    var phi_15760_: f32;
    var phi_15773_: f32;
    var phi_15803_: f32;
    var phi_15816_: f32;
    var phi_15876_: f32;
    var phi_15889_: f32;
    var phi_15919_: f32;
    var phi_15932_: f32;
    var phi_15992_: f32;
    var phi_16005_: f32;
    var phi_16035_: f32;
    var phi_16048_: f32;
    var phi_16108_: f32;
    var phi_16121_: f32;
    var phi_16151_: f32;
    var phi_16164_: f32;
    var phi_2966_: f32;
    var phi_2967_: f32;
    var phi_2968_: bool;
    var phi_2849_: f32;
    var local_35: f32;
    var phi_3025_: f32;
    var phi_3026_: f32;
    var phi_3027_: f32;
    var phi_3028_: f32;
    var phi_3029_: f32;
    var phi_3030_: f32;
    var phi_3031_: f32;
    var phi_2686_: f32;
    var phi_2691_: f32;
    var phi_2693_: f32;
    var phi_2695_: f32;
    var phi_2697_: f32;
    var phi_2699_: f32;
    var phi_2701_: f32;
    var local_36: f32;
    var local_37: f32;
    var local_38: f32;
    var local_39: f32;
    var local_40: f32;
    var local_41: f32;
    var phi_16238_: vec2<f32>;
    var phi_16278_: vec2<f32>;
    var phi_3139_: f32;
    var phi_3142_: u32;
    var phi_3144_: f32;
    var phi_3146_: f32;
    var phi_3148_: f32;
    var phi_3150_: f32;
    var phi_3152_: f32;
    var phi_3154_: f32;
    var phi_3143_: u32;
    var phi_16503_: f32;
    var phi_16516_: f32;
    var phi_16546_: f32;
    var phi_16559_: f32;
    var phi_16619_: f32;
    var phi_16632_: f32;
    var phi_16662_: f32;
    var phi_16675_: f32;
    var phi_16735_: f32;
    var phi_16748_: f32;
    var phi_16778_: f32;
    var phi_16791_: f32;
    var phi_16851_: f32;
    var phi_16864_: f32;
    var phi_16894_: f32;
    var phi_16907_: f32;
    var phi_3269_: f32;
    var phi_3270_: f32;
    var phi_3271_: bool;
    var phi_3302_: f32;
    var phi_3305_: u32;
    var phi_3306_: u32;
    var phi_16983_: f32;
    var phi_16996_: f32;
    var phi_17026_: f32;
    var phi_17039_: f32;
    var phi_17099_: f32;
    var phi_17112_: f32;
    var phi_17142_: f32;
    var phi_17155_: f32;
    var phi_17215_: f32;
    var phi_17228_: f32;
    var phi_17258_: f32;
    var phi_17271_: f32;
    var phi_17331_: f32;
    var phi_17344_: f32;
    var phi_17374_: f32;
    var phi_17387_: f32;
    var phi_3420_: f32;
    var phi_3421_: f32;
    var phi_3422_: bool;
    var phi_3303_: f32;
    var local_42: f32;
    var phi_3479_: f32;
    var phi_3480_: f32;
    var phi_3481_: f32;
    var phi_3482_: f32;
    var phi_3483_: f32;
    var phi_3484_: f32;
    var phi_3485_: f32;
    var phi_3140_: f32;
    var phi_3145_: f32;
    var phi_3147_: f32;
    var phi_3149_: f32;
    var phi_3151_: f32;
    var phi_3153_: f32;
    var phi_3155_: f32;
    var local_43: f32;
    var local_44: f32;
    var local_45: f32;
    var local_46: f32;
    var local_47: f32;
    var local_48: f32;
    var phi_17461_: vec2<f32>;
    var phi_17501_: vec2<f32>;
    var phi_3593_: f32;
    var phi_3596_: u32;
    var phi_3598_: f32;
    var phi_3600_: f32;
    var phi_3602_: f32;
    var phi_3604_: f32;
    var phi_3606_: f32;
    var phi_3608_: f32;
    var phi_3597_: u32;
    var phi_17726_: f32;
    var phi_17739_: f32;
    var phi_17769_: f32;
    var phi_17782_: f32;
    var phi_17842_: f32;
    var phi_17855_: f32;
    var phi_17885_: f32;
    var phi_17898_: f32;
    var phi_17958_: f32;
    var phi_17971_: f32;
    var phi_18001_: f32;
    var phi_18014_: f32;
    var phi_18074_: f32;
    var phi_18087_: f32;
    var phi_18117_: f32;
    var phi_18130_: f32;
    var phi_3723_: f32;
    var phi_3724_: f32;
    var phi_3725_: bool;
    var phi_3756_: f32;
    var phi_3759_: u32;
    var phi_3760_: u32;
    var phi_18206_: f32;
    var phi_18219_: f32;
    var phi_18249_: f32;
    var phi_18262_: f32;
    var phi_18322_: f32;
    var phi_18335_: f32;
    var phi_18365_: f32;
    var phi_18378_: f32;
    var phi_18438_: f32;
    var phi_18451_: f32;
    var phi_18481_: f32;
    var phi_18494_: f32;
    var phi_18554_: f32;
    var phi_18567_: f32;
    var phi_18597_: f32;
    var phi_18610_: f32;
    var phi_3874_: f32;
    var phi_3875_: f32;
    var phi_3876_: bool;
    var phi_3757_: f32;
    var local_49: f32;
    var phi_3933_: f32;
    var phi_3934_: f32;
    var phi_3935_: f32;
    var phi_3936_: f32;
    var phi_3937_: f32;
    var phi_3938_: f32;
    var phi_3939_: f32;
    var phi_3594_: f32;
    var phi_3599_: f32;
    var phi_3601_: f32;
    var phi_3603_: f32;
    var phi_3605_: f32;
    var phi_3607_: f32;
    var phi_3609_: f32;
    var local_50: f32;
    var local_51: f32;
    var local_52: f32;
    var local_53: f32;
    var local_54: f32;
    var local_55: f32;
    var phi_18684_: vec2<f32>;
    var phi_18724_: vec2<f32>;
    var phi_4047_: f32;
    var phi_4050_: u32;
    var phi_4052_: f32;
    var phi_4054_: f32;
    var phi_4056_: f32;
    var phi_4058_: f32;
    var phi_4060_: f32;
    var phi_4062_: f32;
    var phi_4051_: u32;
    var phi_18949_: f32;
    var phi_18962_: f32;
    var phi_18992_: f32;
    var phi_19005_: f32;
    var phi_19065_: f32;
    var phi_19078_: f32;
    var phi_19108_: f32;
    var phi_19121_: f32;
    var phi_19181_: f32;
    var phi_19194_: f32;
    var phi_19224_: f32;
    var phi_19237_: f32;
    var phi_19297_: f32;
    var phi_19310_: f32;
    var phi_19340_: f32;
    var phi_19353_: f32;
    var phi_4177_: f32;
    var phi_4178_: f32;
    var phi_4179_: bool;
    var phi_4210_: f32;
    var phi_4213_: u32;
    var phi_4214_: u32;
    var phi_19429_: f32;
    var phi_19442_: f32;
    var phi_19472_: f32;
    var phi_19485_: f32;
    var phi_19545_: f32;
    var phi_19558_: f32;
    var phi_19588_: f32;
    var phi_19601_: f32;
    var phi_19661_: f32;
    var phi_19674_: f32;
    var phi_19704_: f32;
    var phi_19717_: f32;
    var phi_19777_: f32;
    var phi_19790_: f32;
    var phi_19820_: f32;
    var phi_19833_: f32;
    var phi_4328_: f32;
    var phi_4329_: f32;
    var phi_4330_: bool;
    var phi_4211_: f32;
    var local_56: f32;
    var phi_4387_: f32;
    var phi_4388_: f32;
    var phi_4389_: f32;
    var phi_4390_: f32;
    var phi_4391_: f32;
    var phi_4392_: f32;
    var phi_4393_: f32;
    var phi_4048_: f32;
    var phi_4053_: f32;
    var phi_4055_: f32;
    var phi_4057_: f32;
    var phi_4059_: f32;
    var phi_4061_: f32;
    var phi_4063_: f32;
    var local_57: f32;
    var local_58: f32;
    var local_59: f32;
    var local_60: f32;
    var local_61: f32;
    var local_62: f32;
    var phi_19907_: vec2<f32>;
    var phi_19947_: vec2<f32>;
    var phi_4501_: f32;
    var phi_4504_: u32;
    var phi_4506_: f32;
    var phi_4508_: f32;
    var phi_4510_: f32;
    var phi_4512_: f32;
    var phi_4514_: f32;
    var phi_4516_: f32;
    var phi_4505_: u32;
    var phi_20172_: f32;
    var phi_20185_: f32;
    var phi_20215_: f32;
    var phi_20228_: f32;
    var phi_20288_: f32;
    var phi_20301_: f32;
    var phi_20331_: f32;
    var phi_20344_: f32;
    var phi_20404_: f32;
    var phi_20417_: f32;
    var phi_20447_: f32;
    var phi_20460_: f32;
    var phi_20520_: f32;
    var phi_20533_: f32;
    var phi_20563_: f32;
    var phi_20576_: f32;
    var phi_4631_: f32;
    var phi_4632_: f32;
    var phi_4633_: bool;
    var phi_4664_: f32;
    var phi_4667_: u32;
    var phi_4668_: u32;
    var phi_20652_: f32;
    var phi_20665_: f32;
    var phi_20695_: f32;
    var phi_20708_: f32;
    var phi_20768_: f32;
    var phi_20781_: f32;
    var phi_20811_: f32;
    var phi_20824_: f32;
    var phi_20884_: f32;
    var phi_20897_: f32;
    var phi_20927_: f32;
    var phi_20940_: f32;
    var phi_21000_: f32;
    var phi_21013_: f32;
    var phi_21043_: f32;
    var phi_21056_: f32;
    var phi_4782_: f32;
    var phi_4783_: f32;
    var phi_4784_: bool;
    var phi_4665_: f32;
    var local_63: f32;
    var phi_4841_: f32;
    var phi_4842_: f32;
    var phi_4843_: f32;
    var phi_4844_: f32;
    var phi_4845_: f32;
    var phi_4846_: f32;
    var phi_4847_: f32;
    var phi_4502_: f32;
    var phi_4507_: f32;
    var phi_4509_: f32;
    var phi_4511_: f32;
    var phi_4513_: f32;
    var phi_4515_: f32;
    var phi_4517_: f32;
    var local_64: f32;
    var local_65: f32;
    var local_66: f32;
    var local_67: f32;
    var local_68: f32;
    var local_69: f32;
    var phi_21130_: vec2<f32>;
    var phi_21170_: vec2<f32>;
    var phi_4955_: f32;
    var phi_4958_: u32;
    var phi_4960_: f32;
    var phi_4962_: f32;
    var phi_4964_: f32;
    var phi_4966_: f32;
    var phi_4968_: f32;
    var phi_4970_: f32;
    var phi_4959_: u32;
    var phi_21395_: f32;
    var phi_21408_: f32;
    var phi_21438_: f32;
    var phi_21451_: f32;
    var phi_21511_: f32;
    var phi_21524_: f32;
    var phi_21554_: f32;
    var phi_21567_: f32;
    var phi_21627_: f32;
    var phi_21640_: f32;
    var phi_21670_: f32;
    var phi_21683_: f32;
    var phi_21743_: f32;
    var phi_21756_: f32;
    var phi_21786_: f32;
    var phi_21799_: f32;
    var phi_5085_: f32;
    var phi_5086_: f32;
    var phi_5087_: bool;
    var phi_5118_: f32;
    var phi_5121_: u32;
    var phi_5122_: u32;
    var phi_21875_: f32;
    var phi_21888_: f32;
    var phi_21918_: f32;
    var phi_21931_: f32;
    var phi_21991_: f32;
    var phi_22004_: f32;
    var phi_22034_: f32;
    var phi_22047_: f32;
    var phi_22107_: f32;
    var phi_22120_: f32;
    var phi_22150_: f32;
    var phi_22163_: f32;
    var phi_22223_: f32;
    var phi_22236_: f32;
    var phi_22266_: f32;
    var phi_22279_: f32;
    var phi_5236_: f32;
    var phi_5237_: f32;
    var phi_5238_: bool;
    var phi_5119_: f32;
    var local_70: f32;
    var phi_5295_: f32;
    var phi_5296_: f32;
    var phi_5297_: f32;
    var phi_5298_: f32;
    var phi_5299_: f32;
    var phi_5300_: f32;
    var phi_5301_: f32;
    var phi_4956_: f32;
    var phi_4961_: f32;
    var phi_4963_: f32;
    var phi_4965_: f32;
    var phi_4967_: f32;
    var phi_4969_: f32;
    var phi_4971_: f32;
    var local_71: f32;
    var local_72: f32;
    var local_73: f32;
    var local_74: f32;
    var local_75: f32;
    var local_76: f32;
    var phi_22353_: vec2<f32>;
    var phi_22393_: vec2<f32>;
    var phi_5409_: f32;
    var phi_5412_: u32;
    var phi_5414_: f32;
    var phi_5416_: f32;
    var phi_5418_: f32;
    var phi_5420_: f32;
    var phi_5422_: f32;
    var phi_5424_: f32;
    var phi_5413_: u32;
    var phi_22618_: f32;
    var phi_22631_: f32;
    var phi_22661_: f32;
    var phi_22674_: f32;
    var phi_22734_: f32;
    var phi_22747_: f32;
    var phi_22777_: f32;
    var phi_22790_: f32;
    var phi_22850_: f32;
    var phi_22863_: f32;
    var phi_22893_: f32;
    var phi_22906_: f32;
    var phi_22966_: f32;
    var phi_22979_: f32;
    var phi_23009_: f32;
    var phi_23022_: f32;
    var phi_5539_: f32;
    var phi_5540_: f32;
    var phi_5541_: bool;
    var phi_5572_: f32;
    var phi_5575_: u32;
    var phi_5576_: u32;
    var phi_23098_: f32;
    var phi_23111_: f32;
    var phi_23141_: f32;
    var phi_23154_: f32;
    var phi_23214_: f32;
    var phi_23227_: f32;
    var phi_23257_: f32;
    var phi_23270_: f32;
    var phi_23330_: f32;
    var phi_23343_: f32;
    var phi_23373_: f32;
    var phi_23386_: f32;
    var phi_23446_: f32;
    var phi_23459_: f32;
    var phi_23489_: f32;
    var phi_23502_: f32;
    var phi_5690_: f32;
    var phi_5691_: f32;
    var phi_5692_: bool;
    var phi_5573_: f32;
    var local_77: f32;
    var phi_5749_: f32;
    var phi_5750_: f32;
    var phi_5751_: f32;
    var phi_5752_: f32;
    var phi_5753_: f32;
    var phi_5754_: f32;
    var phi_5755_: f32;
    var phi_5410_: f32;
    var phi_5415_: f32;
    var phi_5417_: f32;
    var phi_5419_: f32;
    var phi_5421_: f32;
    var phi_5423_: f32;
    var phi_5425_: f32;
    var local_78: f32;
    var local_79: f32;
    var local_80: f32;
    var local_81: f32;
    var local_82: f32;
    var local_83: f32;
    var phi_23576_: vec2<f32>;
    var phi_23616_: vec2<f32>;
    var phi_5863_: f32;
    var phi_5866_: u32;
    var phi_5868_: f32;
    var phi_5870_: f32;
    var phi_5872_: f32;
    var phi_5874_: f32;
    var phi_5876_: f32;
    var phi_5878_: f32;
    var phi_5867_: u32;
    var phi_23841_: f32;
    var phi_23854_: f32;
    var phi_23884_: f32;
    var phi_23897_: f32;
    var phi_23957_: f32;
    var phi_23970_: f32;
    var phi_24000_: f32;
    var phi_24013_: f32;
    var phi_24073_: f32;
    var phi_24086_: f32;
    var phi_24116_: f32;
    var phi_24129_: f32;
    var phi_24189_: f32;
    var phi_24202_: f32;
    var phi_24232_: f32;
    var phi_24245_: f32;
    var phi_5993_: f32;
    var phi_5994_: f32;
    var phi_5995_: bool;
    var phi_6026_: f32;
    var phi_6029_: u32;
    var phi_6030_: u32;
    var phi_24321_: f32;
    var phi_24334_: f32;
    var phi_24364_: f32;
    var phi_24377_: f32;
    var phi_24437_: f32;
    var phi_24450_: f32;
    var phi_24480_: f32;
    var phi_24493_: f32;
    var phi_24553_: f32;
    var phi_24566_: f32;
    var phi_24596_: f32;
    var phi_24609_: f32;
    var phi_24669_: f32;
    var phi_24682_: f32;
    var phi_24712_: f32;
    var phi_24725_: f32;
    var phi_6144_: f32;
    var phi_6145_: f32;
    var phi_6146_: bool;
    var phi_6027_: f32;
    var local_84: f32;
    var phi_6203_: f32;
    var phi_6204_: f32;
    var phi_6205_: f32;
    var phi_6206_: f32;
    var phi_6207_: f32;
    var phi_6208_: f32;
    var phi_6209_: f32;
    var phi_5864_: f32;
    var phi_5869_: f32;
    var phi_5871_: f32;
    var phi_5873_: f32;
    var phi_5875_: f32;
    var phi_5877_: f32;
    var phi_5879_: f32;
    var local_85: f32;
    var local_86: f32;
    var local_87: f32;
    var local_88: f32;
    var local_89: f32;
    var local_90: f32;
    var phi_24799_: vec2<f32>;
    var phi_24839_: vec2<f32>;
    var phi_6317_: f32;
    var phi_6320_: u32;
    var phi_6322_: f32;
    var phi_6324_: f32;
    var phi_6326_: f32;
    var phi_6328_: f32;
    var phi_6330_: f32;
    var phi_6332_: f32;
    var phi_6321_: u32;
    var phi_25064_: f32;
    var phi_25077_: f32;
    var phi_25107_: f32;
    var phi_25120_: f32;
    var phi_25180_: f32;
    var phi_25193_: f32;
    var phi_25223_: f32;
    var phi_25236_: f32;
    var phi_25296_: f32;
    var phi_25309_: f32;
    var phi_25339_: f32;
    var phi_25352_: f32;
    var phi_25412_: f32;
    var phi_25425_: f32;
    var phi_25455_: f32;
    var phi_25468_: f32;
    var phi_6447_: f32;
    var phi_6448_: f32;
    var phi_6449_: bool;
    var phi_6480_: f32;
    var phi_6483_: u32;
    var phi_6484_: u32;
    var phi_25544_: f32;
    var phi_25557_: f32;
    var phi_25587_: f32;
    var phi_25600_: f32;
    var phi_25660_: f32;
    var phi_25673_: f32;
    var phi_25703_: f32;
    var phi_25716_: f32;
    var phi_25776_: f32;
    var phi_25789_: f32;
    var phi_25819_: f32;
    var phi_25832_: f32;
    var phi_25892_: f32;
    var phi_25905_: f32;
    var phi_25935_: f32;
    var phi_25948_: f32;
    var phi_6598_: f32;
    var phi_6599_: f32;
    var phi_6600_: bool;
    var phi_6481_: f32;
    var local_91: f32;
    var phi_6657_: f32;
    var phi_6658_: f32;
    var phi_6659_: f32;
    var phi_6660_: f32;
    var phi_6661_: f32;
    var phi_6662_: f32;
    var phi_6663_: f32;
    var phi_6318_: f32;
    var phi_6323_: f32;
    var phi_6325_: f32;
    var phi_6327_: f32;
    var phi_6329_: f32;
    var phi_6331_: f32;
    var phi_6333_: f32;
    var local_92: f32;
    var local_93: f32;
    var local_94: f32;
    var local_95: f32;
    var local_96: f32;
    var local_97: f32;
    var phi_26022_: vec2<f32>;
    var phi_26062_: vec2<f32>;
    var phi_6771_: f32;
    var phi_6774_: u32;
    var phi_6776_: f32;
    var phi_6778_: f32;
    var phi_6780_: f32;
    var phi_6782_: f32;
    var phi_6784_: f32;
    var phi_6786_: f32;
    var phi_6775_: u32;
    var phi_26287_: f32;
    var phi_26300_: f32;
    var phi_26330_: f32;
    var phi_26343_: f32;
    var phi_26403_: f32;
    var phi_26416_: f32;
    var phi_26446_: f32;
    var phi_26459_: f32;
    var phi_26519_: f32;
    var phi_26532_: f32;
    var phi_26562_: f32;
    var phi_26575_: f32;
    var phi_26635_: f32;
    var phi_26648_: f32;
    var phi_26678_: f32;
    var phi_26691_: f32;
    var phi_6901_: f32;
    var phi_6902_: f32;
    var phi_6903_: bool;
    var phi_6934_: f32;
    var phi_6937_: u32;
    var phi_6938_: u32;
    var phi_26767_: f32;
    var phi_26780_: f32;
    var phi_26810_: f32;
    var phi_26823_: f32;
    var phi_26883_: f32;
    var phi_26896_: f32;
    var phi_26926_: f32;
    var phi_26939_: f32;
    var phi_26999_: f32;
    var phi_27012_: f32;
    var phi_27042_: f32;
    var phi_27055_: f32;
    var phi_27115_: f32;
    var phi_27128_: f32;
    var phi_27158_: f32;
    var phi_27171_: f32;
    var phi_7052_: f32;
    var phi_7053_: f32;
    var phi_7054_: bool;
    var phi_6935_: f32;
    var local_98: f32;
    var phi_7111_: f32;
    var phi_7112_: f32;
    var phi_7113_: f32;
    var phi_7114_: f32;
    var phi_7115_: f32;
    var phi_7116_: f32;
    var phi_7117_: f32;
    var phi_6772_: f32;
    var phi_6777_: f32;
    var phi_6779_: f32;
    var phi_6781_: f32;
    var phi_6783_: f32;
    var phi_6785_: f32;
    var phi_6787_: f32;
    var local_99: f32;
    var local_100: f32;
    var local_101: f32;
    var local_102: f32;
    var local_103: f32;
    var local_104: f32;
    var phi_27245_: vec2<f32>;
    var phi_27285_: vec2<f32>;
    var phi_7225_: f32;
    var phi_7228_: u32;
    var phi_7230_: f32;
    var phi_7232_: f32;
    var phi_7234_: f32;
    var phi_7236_: f32;
    var phi_7238_: f32;
    var phi_7240_: f32;
    var phi_7229_: u32;
    var phi_27510_: f32;
    var phi_27523_: f32;
    var phi_27553_: f32;
    var phi_27566_: f32;
    var phi_27626_: f32;
    var phi_27639_: f32;
    var phi_27669_: f32;
    var phi_27682_: f32;
    var phi_27742_: f32;
    var phi_27755_: f32;
    var phi_27785_: f32;
    var phi_27798_: f32;
    var phi_27858_: f32;
    var phi_27871_: f32;
    var phi_27901_: f32;
    var phi_27914_: f32;
    var phi_7355_: f32;
    var phi_7356_: f32;
    var phi_7357_: bool;
    var phi_7388_: f32;
    var phi_7391_: u32;
    var phi_7392_: u32;
    var phi_27990_: f32;
    var phi_28003_: f32;
    var phi_28033_: f32;
    var phi_28046_: f32;
    var phi_28106_: f32;
    var phi_28119_: f32;
    var phi_28149_: f32;
    var phi_28162_: f32;
    var phi_28222_: f32;
    var phi_28235_: f32;
    var phi_28265_: f32;
    var phi_28278_: f32;
    var phi_28338_: f32;
    var phi_28351_: f32;
    var phi_28381_: f32;
    var phi_28394_: f32;
    var phi_7506_: f32;
    var phi_7507_: f32;
    var phi_7508_: bool;
    var phi_7389_: f32;
    var local_105: f32;
    var phi_7565_: f32;
    var phi_7566_: f32;
    var phi_7567_: f32;
    var phi_7568_: f32;
    var phi_7569_: f32;
    var phi_7570_: f32;
    var phi_7571_: f32;
    var phi_7226_: f32;
    var phi_7231_: f32;
    var phi_7233_: f32;
    var phi_7235_: f32;
    var phi_7237_: f32;
    var phi_7239_: f32;
    var phi_7241_: f32;
    var local_106: f32;
    var local_107: f32;
    var local_108: f32;
    var local_109: f32;
    var local_110: f32;
    var local_111: f32;
    var phi_28468_: vec2<f32>;
    var phi_28508_: vec2<f32>;
    var phi_7679_: f32;
    var phi_7682_: u32;
    var phi_7684_: f32;
    var phi_7686_: f32;
    var phi_7688_: f32;
    var phi_7690_: f32;
    var phi_7692_: f32;
    var phi_7694_: f32;
    var phi_7683_: u32;
    var phi_28733_: f32;
    var phi_28746_: f32;
    var phi_28776_: f32;
    var phi_28789_: f32;
    var phi_28849_: f32;
    var phi_28862_: f32;
    var phi_28892_: f32;
    var phi_28905_: f32;
    var phi_28965_: f32;
    var phi_28978_: f32;
    var phi_29008_: f32;
    var phi_29021_: f32;
    var phi_29081_: f32;
    var phi_29094_: f32;
    var phi_29124_: f32;
    var phi_29137_: f32;
    var phi_7809_: f32;
    var phi_7810_: f32;
    var phi_7811_: bool;
    var phi_7842_: f32;
    var phi_7845_: u32;
    var phi_7846_: u32;
    var phi_29213_: f32;
    var phi_29226_: f32;
    var phi_29256_: f32;
    var phi_29269_: f32;
    var phi_29329_: f32;
    var phi_29342_: f32;
    var phi_29372_: f32;
    var phi_29385_: f32;
    var phi_29445_: f32;
    var phi_29458_: f32;
    var phi_29488_: f32;
    var phi_29501_: f32;
    var phi_29561_: f32;
    var phi_29574_: f32;
    var phi_29604_: f32;
    var phi_29617_: f32;
    var phi_7960_: f32;
    var phi_7961_: f32;
    var phi_7962_: bool;
    var phi_7843_: f32;
    var local_112: f32;
    var phi_8019_: f32;
    var phi_8020_: f32;
    var phi_8021_: f32;
    var phi_8022_: f32;
    var phi_8023_: f32;
    var phi_8024_: f32;
    var phi_8025_: f32;
    var phi_7680_: f32;
    var phi_7685_: f32;
    var phi_7687_: f32;
    var phi_7689_: f32;
    var phi_7691_: f32;
    var phi_7693_: f32;
    var phi_7695_: f32;
    var local_113: f32;
    var local_114: f32;
    var local_115: f32;
    var local_116: f32;
    var local_117: f32;
    var local_118: f32;

    let _e107 = global;
    let _e110 = f32(_e107.x);
    let _e117 = global_1.member.member_3[1u];
    let _e119 = fma(_e117, 4f, -(f32(_e107.y)));
    let _e120 = global_1.member.member_3;
    let _e130 = (fma((_e110 / (_e120.x * 4f)), 2f, -1f) * 3.1415927f);
    let _e131 = (fma((1f - (_e119 / (_e120.y * 4f))), 2f, -1f) * 1.5707964f);
    let _e133 = cos(_e131);
    let _e135 = sin(_e131);
    let _e136 = (cos(_e130) * _e133);
    let _e137 = (sin(_e130) * _e133);
    let _e144 = (vec3<f32>(_e136, _e135, _e137) * (1f / sqrt(fma(_e137, _e137, fma(_e136, _e136, (_e135 * _e135))))));
    let _e152 = floor((_e119 * 0.125f));
    let _e155 = fma(floor((_e110 * 0.125f)), 0.5f, (_e152 * (_e152 * 0.75f)));
    let _e159 = floor((_e119 * 0.25f));
    let _e162 = fma(floor((_e110 * 0.25f)), 0.5f, (_e159 * (_e159 * 0.75f)));
    let _e167 = floor((0.5f * _e119));
    let _e170 = fma(floor((0.5f * _e110)), 0.5f, (_e167 * (_e167 * 0.75f)));
    let _e175 = floor(_e119);
    let _e178 = fma(floor(_e110), 0.5f, (_e175 * (_e175 * 0.75f)));
    let _e181 = fma(fma(fma((_e155 - trunc(_e155)), 0.25f, (_e162 - trunc(_e162))), 0.25f, (_e170 - trunc(_e170))), 0.25f, (_e178 - trunc(_e178)));
    let _e187 = fma(0.93934745f, _e144.z, fma(-0.30521265f, _e144.x, (0.1564345f * _e144.y)));
    let _e189 = max(fma(_e144.y, 2f, -0.01f), 0.01f);
    let _e190 = (100000f / _e189);
    let _e191 = (vec3<f32>(0.0000032f, 0.0000055f, 0.0000105f) * _e190);
    let _e193 = (vec3<f32>(0.0000032f, 0.0000055f, 0.0000105f) * (-100000f / _e189));
    let _e195 = exp2(_e193.x);
    let _e197 = exp2(_e193.y);
    let _e199 = exp2(_e193.z);
    let _e224 = (vec3<f32>(0.0000005f, 0.0000005f, 0.0000005f) * _e190);
    let _e226 = exp2((-0.3f / _e189));
    let _e234 = (0.25f * (fma(-(_e226), _e226, 1f) * pow(fma((_e226 * -2f), _e187, fma(_e226, _e226, 1f)), -1.5f)));
    let _e238 = (vec3<f32>(0.0000027f, 0.000005f, 0.00001f) * _e190);
    let _e240 = (0.375f * fma(_e187, _e187, 1f));
    let _e251 = ((_e187 - 0.9999f) * 33288.13f);
    let _e253 = select(_e251, 0f, (_e251 < 0f));
    let _e255 = select(_e253, 1f, (_e253 > 1f));
    let _e258 = ((_e255 * _e255) * fma(-2f, _e255, 3f));
    let _e268 = (fma(fma(_e224.x, _e234, (_e238.x * _e240)), (abs((0.4807763f - _e195)) / (abs(((1.0565623f - _e191.x) * 0.6931472f)) + 0.00000001f)), ((_e258 * _e195) * 2.5f)) * 2.5f);
    let _e269 = (fma(fma(_e224.y, _e234, (_e238.y * _e240)), (abs((0.28401393f - _e197)) / (abs(((1.8159665f - _e191.y) * 0.6931472f)) + 0.00000001f)), ((_e258 * _e197) * 2.5f)) * 2.5f);
    let _e270 = (fma(fma(_e224.z, _e234, (_e238.z * _e240)), (abs((0.09044314f - _e199)) / (abs(((3.466845f - _e191.z) * 0.6931472f)) + 0.00000001f)), ((_e258 * _e199) * 2.5f)) * 2.5f);
    let _e271 = (6371000f * _e144.y);
    let _e273 = (fma(_e271, _e271, 40610030000000f) - 40589643000000f);
    let _e274 = (_e273 < 0f);
    if _e274 {
        phi_8899_ = vec2<f32>(-1f, -1f);
    } else {
        phi_8899_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e279 = phi_8899_;
    let _e282 = (fma(_e271, _e271, 40616403000000f) - 40589643000000f);
    let _e283 = (_e282 < 0f);
    if _e283 {
        phi_8939_ = vec2<f32>(-1f, -1f);
    } else {
        phi_8939_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e288 = phi_8939_;
    let _e290 = (_e144.x * _e279.y);
    let _e291 = (_e144.y * _e279.y);
    let _e292 = (_e144.z * _e279.y);
    let _e296 = -(_e144.x);
    let _e297 = fma(_e296, _e279.y, (_e144.x + _e288.y));
    let _e298 = -(_e144.y);
    let _e299 = fma(_e298, _e279.y, (_e144.y + _e288.y));
    let _e300 = -(_e144.z);
    let _e301 = fma(_e300, _e279.y, (_e144.z + _e288.y));
    let _e302 = (_e297 * 0.0625f);
    let _e303 = (_e299 * 0.0625f);
    let _e304 = (_e301 * 0.0625f);
    let _e317 = fma(pow(fma(0.8f, _e187, 1.16f), -1.5f), 0.08399999f, (pow(fma(-1.2800001f, _e187, 1.4096f), -1.5f) * 0.08856f));
    let _e330 = ((abs(-0.4137501f) + 0.001f) / (abs(0.62089235f) + 0.001f));
    let _e331 = ((abs(-0.54164517f) + 0.001f) / (abs(1.0671587f) + 0.001f));
    let _e332 = ((abs(-0.6032463f) + 0.001f) / (abs(2.037303f) + 0.001f));
    phi_418_ = 1f;
    phi_421_ = 0u;
    phi_423_ = fma(_e302, _e181, _e290);
    phi_425_ = fma(_e303, _e181, _e291);
    phi_427_ = fma(_e304, _e181, _e292);
    phi_429_ = 0f;
    phi_431_ = 0f;
    phi_433_ = 0f;
    loop {
        let _e334 = phi_418_;
        let _e336 = phi_421_;
        let _e338 = phi_423_;
        let _e340 = phi_425_;
        let _e342 = phi_427_;
        let _e344 = phi_429_;
        let _e346 = phi_431_;
        let _e348 = phi_433_;
        local_1 = _e334;
        local_2 = _e344;
        local_3 = _e334;
        local_4 = _e346;
        local_5 = _e334;
        local_6 = _e348;
        let _e349 = (_e336 < 16u);
        if _e349 {
            phi_422_ = (_e336 + 1u);
        } else {
            phi_422_ = _e336;
        }
        let _e352 = phi_422_;
        if _e349 {
            let _e353 = (_e340 + 6371000f);
            let _e357 = sqrt(fma(_e342, _e342, fma(_e338, _e338, (_e353 * _e353))));
            let _e358 = (_e357 - 6371000f);
            if (_e358 < 1600f) {
                phi_549_ = f32();
                phi_550_ = true;
            } else {
                let _e360 = (_e358 > 2100f);
                if _e360 {
                    phi_548_ = f32();
                } else {
                    let _e364 = global_2.member.member[0u];
                    let _e365 = (_e364 * 0.02f);
                    let _e366 = fma(_e338, 0.001f, _e365);
                    let _e367 = fma(_e342, 0.001f, _e365);
                    let _e368 = floor(_e367);
                    let _e369 = (_e367 - _e368);
                    let _e370 = (_e368 * 0.265625f);
                    let _e371 = fma(_e366, 0.015625f, _e370);
                    let _e372 = fma(_e358, 0.000015625f, _e370);
                    if (_e371 > 0f) {
                        phi_9165_ = (_e371 % 1f);
                    } else {
                        phi_9165_ = (1f - (-(_e371) % 1f));
                    }
                    let _e379 = phi_9165_;
                    if (_e372 > 0f) {
                        phi_9178_ = (_e372 % 1f);
                    } else {
                        phi_9178_ = (1f - (-(_e372) % 1f));
                    }
                    let _e386 = phi_9178_;
                    let _e388 = textureSampleLevel(global_3, global_4, vec2<f32>(_e379, _e386), 0f);
                    let _e390 = (_e371 + 0.265625f);
                    let _e391 = (_e372 + 0.265625f);
                    if (_e390 > 0f) {
                        phi_9208_ = (_e390 % 1f);
                    } else {
                        phi_9208_ = (1f - ((-0.265625f - _e371) % 1f));
                    }
                    let _e398 = phi_9208_;
                    if (_e391 > 0f) {
                        phi_9221_ = (_e391 % 1f);
                    } else {
                        phi_9221_ = (1f - ((-0.265625f - _e372) % 1f));
                    }
                    let _e405 = phi_9221_;
                    let _e407 = textureSampleLevel(global_3, global_4, vec2<f32>(_e398, _e405), 0f);
                    let _e412 = fma(_e364, 0.02f, 2f);
                    let _e415 = floor((_e367 * _e412));
                    let _e417 = fma(_e367, _e412, -(_e415));
                    let _e418 = (_e415 * 0.265625f);
                    let _e419 = fma((_e366 * _e412), 0.015625f, _e418);
                    let _e420 = fma(_e358, 0.00003125f, _e418);
                    if (_e419 > 0f) {
                        phi_9281_ = (_e419 % 1f);
                    } else {
                        phi_9281_ = (1f - (-(_e419) % 1f));
                    }
                    let _e427 = phi_9281_;
                    if (_e420 > 0f) {
                        phi_9294_ = (_e420 % 1f);
                    } else {
                        phi_9294_ = (1f - (-(_e420) % 1f));
                    }
                    let _e434 = phi_9294_;
                    let _e436 = textureSampleLevel(global_3, global_4, vec2<f32>(_e427, _e434), 0f);
                    let _e438 = (_e419 + 0.265625f);
                    let _e439 = (_e420 + 0.265625f);
                    if (_e438 > 0f) {
                        phi_9324_ = (_e438 % 1f);
                    } else {
                        phi_9324_ = (1f - ((-0.265625f - _e419) % 1f));
                    }
                    let _e446 = phi_9324_;
                    if (_e439 > 0f) {
                        phi_9337_ = (_e439 % 1f);
                    } else {
                        phi_9337_ = (1f - ((-0.265625f - _e420) % 1f));
                    }
                    let _e453 = phi_9337_;
                    let _e455 = textureSampleLevel(global_3, global_4, vec2<f32>(_e446, _e453), 0f);
                    let _e463 = fma(-(_e364), 0.02f, 7f);
                    let _e466 = floor((_e367 * _e463));
                    let _e468 = fma(_e367, _e463, -(_e466));
                    let _e469 = (_e466 * 0.265625f);
                    let _e470 = fma((_e366 * _e463), 0.015625f, _e469);
                    let _e471 = fma(_e358, 0.000109375f, _e469);
                    if (_e470 > 0f) {
                        phi_9397_ = (_e470 % 1f);
                    } else {
                        phi_9397_ = (1f - (-(_e470) % 1f));
                    }
                    let _e478 = phi_9397_;
                    if (_e471 > 0f) {
                        phi_9410_ = (_e471 % 1f);
                    } else {
                        phi_9410_ = (1f - (-(_e471) % 1f));
                    }
                    let _e485 = phi_9410_;
                    let _e487 = textureSampleLevel(global_3, global_4, vec2<f32>(_e478, _e485), 0f);
                    let _e489 = (_e470 + 0.265625f);
                    let _e490 = (_e471 + 0.265625f);
                    if (_e489 > 0f) {
                        phi_9440_ = (_e489 % 1f);
                    } else {
                        phi_9440_ = (1f - ((-0.265625f - _e470) % 1f));
                    }
                    let _e497 = phi_9440_;
                    if (_e490 > 0f) {
                        phi_9453_ = (_e490 % 1f);
                    } else {
                        phi_9453_ = (1f - ((-0.265625f - _e471) % 1f));
                    }
                    let _e504 = phi_9453_;
                    let _e506 = textureSampleLevel(global_3, global_4, vec2<f32>(_e497, _e504), 0f);
                    let _e513 = fma(_e364, 0.02f, _e367);
                    let _e515 = floor((_e513 * 16f));
                    let _e517 = fma(_e513, 16f, -(_e515));
                    let _e518 = (_e515 * 0.265625f);
                    let _e519 = fma(fma(_e364, 0.02f, _e366), 0.25f, _e518);
                    let _e520 = fma(_e358, 0.00025f, _e518);
                    if (_e519 > 0f) {
                        phi_9513_ = (_e519 % 1f);
                    } else {
                        phi_9513_ = (1f - (-(_e519) % 1f));
                    }
                    let _e527 = phi_9513_;
                    if (_e520 > 0f) {
                        phi_9526_ = (_e520 % 1f);
                    } else {
                        phi_9526_ = (1f - (-(_e520) % 1f));
                    }
                    let _e534 = phi_9526_;
                    let _e536 = textureSampleLevel(global_3, global_4, vec2<f32>(_e527, _e534), 0f);
                    let _e538 = (_e519 + 0.265625f);
                    let _e539 = (_e520 + 0.265625f);
                    if (_e538 > 0f) {
                        phi_9556_ = (_e538 % 1f);
                    } else {
                        phi_9556_ = (1f - ((-0.265625f - _e519) % 1f));
                    }
                    let _e546 = phi_9556_;
                    if (_e539 > 0f) {
                        phi_9569_ = (_e539 % 1f);
                    } else {
                        phi_9569_ = (1f - ((-0.265625f - _e520) % 1f));
                    }
                    let _e553 = phi_9569_;
                    let _e555 = textureSampleLevel(global_3, global_4, vec2<f32>(_e546, _e553), 0f);
                    let _e561 = (_e357 - 6372600f);
                    let _e569 = ((fma(fma(_e536.x, (1f - _e517), (_e555.x * _e517)), 0.0625f, fma(fma(_e487.x, (1f - _e468), (_e506.x * _e468)), 0.125f, fma(fma(_e388.x, (1f - _e369), (_e407.x * _e369)), 0.5f, (fma(_e436.x, (1f - _e417), (_e455.x * _e417)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e571 = select(_e569, 0f, (_e569 < 0f));
                    let _e573 = select(_e571, 1f, (_e571 > 1f));
                    phi_548_ = ((((_e573 * _e573) * fma(-2f, _e573, 3f)) * ((1f - exp2((-0.01f * _e561))) * exp2((-0.004f * _e561)))) * 0.03f);
                }
                let _e580 = phi_548_;
                phi_549_ = _e580;
                phi_550_ = _e360;
            }
            let _e582 = phi_549_;
            let _e584 = phi_550_;
            let _e586 = (select(_e582, 0f, _e584) * sqrt(fma(_e304, _e304, fma(_e302, _e302, (_e303 * _e303)))));
            if (_e586 <= 0f) {
                phi_758_ = _e334;
                phi_759_ = _e338;
                phi_760_ = _e340;
                phi_761_ = _e342;
                phi_762_ = _e344;
                phi_763_ = _e346;
                phi_764_ = _e348;
            } else {
                let _e590 = fma(exp2((-1.6013916f * _e586)), -0.9009009f, 0.9009009f);
                let _e593 = (1f - exp2((_e586 * -1.3862944f)));
                let _e594 = (-9.537895f + _e338);
                let _e595 = (29.354609f + _e342);
                phi_581_ = 0f;
                phi_584_ = 0u;
                loop {
                    let _e597 = phi_581_;
                    let _e599 = phi_584_;
                    local = _e597;
                    let _e600 = (_e599 < 8u);
                    if _e600 {
                        phi_585_ = (_e599 + 1u);
                    } else {
                        phi_585_ = _e599;
                    }
                    let _e603 = phi_585_;
                    if _e600 {
                        let _e604 = (_e340 + 6371005f);
                        let _e608 = sqrt(fma(_e595, _e595, fma(_e594, _e594, (_e604 * _e604))));
                        let _e609 = (_e608 - 6371000f);
                        if (_e609 < 1600f) {
                            phi_700_ = f32();
                            phi_701_ = true;
                        } else {
                            let _e611 = (_e609 > 2100f);
                            if _e611 {
                                phi_699_ = f32();
                            } else {
                                let _e615 = global_2.member.member[0u];
                                let _e616 = (_e615 * 0.02f);
                                let _e617 = fma(_e594, 0.001f, _e616);
                                let _e618 = fma(_e595, 0.001f, _e616);
                                let _e619 = floor(_e618);
                                let _e620 = (_e618 - _e619);
                                let _e621 = (_e619 * 0.265625f);
                                let _e622 = fma(_e617, 0.015625f, _e621);
                                let _e623 = fma(_e609, 0.000015625f, _e621);
                                if (_e622 > 0f) {
                                    phi_9645_ = (_e622 % 1f);
                                } else {
                                    phi_9645_ = (1f - (-(_e622) % 1f));
                                }
                                let _e630 = phi_9645_;
                                if (_e623 > 0f) {
                                    phi_9658_ = (_e623 % 1f);
                                } else {
                                    phi_9658_ = (1f - (-(_e623) % 1f));
                                }
                                let _e637 = phi_9658_;
                                let _e639 = textureSampleLevel(global_3, global_4, vec2<f32>(_e630, _e637), 0f);
                                let _e641 = (_e622 + 0.265625f);
                                let _e642 = (_e623 + 0.265625f);
                                if (_e641 > 0f) {
                                    phi_9688_ = (_e641 % 1f);
                                } else {
                                    phi_9688_ = (1f - ((-0.265625f - _e622) % 1f));
                                }
                                let _e649 = phi_9688_;
                                if (_e642 > 0f) {
                                    phi_9701_ = (_e642 % 1f);
                                } else {
                                    phi_9701_ = (1f - ((-0.265625f - _e623) % 1f));
                                }
                                let _e656 = phi_9701_;
                                let _e658 = textureSampleLevel(global_3, global_4, vec2<f32>(_e649, _e656), 0f);
                                let _e663 = fma(_e615, 0.02f, 2f);
                                let _e666 = floor((_e618 * _e663));
                                let _e668 = fma(_e618, _e663, -(_e666));
                                let _e669 = (_e666 * 0.265625f);
                                let _e670 = fma((_e617 * _e663), 0.015625f, _e669);
                                let _e671 = fma(_e609, 0.00003125f, _e669);
                                if (_e670 > 0f) {
                                    phi_9761_ = (_e670 % 1f);
                                } else {
                                    phi_9761_ = (1f - (-(_e670) % 1f));
                                }
                                let _e678 = phi_9761_;
                                if (_e671 > 0f) {
                                    phi_9774_ = (_e671 % 1f);
                                } else {
                                    phi_9774_ = (1f - (-(_e671) % 1f));
                                }
                                let _e685 = phi_9774_;
                                let _e687 = textureSampleLevel(global_3, global_4, vec2<f32>(_e678, _e685), 0f);
                                let _e689 = (_e670 + 0.265625f);
                                let _e690 = (_e671 + 0.265625f);
                                if (_e689 > 0f) {
                                    phi_9804_ = (_e689 % 1f);
                                } else {
                                    phi_9804_ = (1f - ((-0.265625f - _e670) % 1f));
                                }
                                let _e697 = phi_9804_;
                                if (_e690 > 0f) {
                                    phi_9817_ = (_e690 % 1f);
                                } else {
                                    phi_9817_ = (1f - ((-0.265625f - _e671) % 1f));
                                }
                                let _e704 = phi_9817_;
                                let _e706 = textureSampleLevel(global_3, global_4, vec2<f32>(_e697, _e704), 0f);
                                let _e714 = fma(-(_e615), 0.02f, 7f);
                                let _e717 = floor((_e618 * _e714));
                                let _e719 = fma(_e618, _e714, -(_e717));
                                let _e720 = (_e717 * 0.265625f);
                                let _e721 = fma((_e617 * _e714), 0.015625f, _e720);
                                let _e722 = fma(_e609, 0.000109375f, _e720);
                                if (_e721 > 0f) {
                                    phi_9877_ = (_e721 % 1f);
                                } else {
                                    phi_9877_ = (1f - (-(_e721) % 1f));
                                }
                                let _e729 = phi_9877_;
                                if (_e722 > 0f) {
                                    phi_9890_ = (_e722 % 1f);
                                } else {
                                    phi_9890_ = (1f - (-(_e722) % 1f));
                                }
                                let _e736 = phi_9890_;
                                let _e738 = textureSampleLevel(global_3, global_4, vec2<f32>(_e729, _e736), 0f);
                                let _e740 = (_e721 + 0.265625f);
                                let _e741 = (_e722 + 0.265625f);
                                if (_e740 > 0f) {
                                    phi_9920_ = (_e740 % 1f);
                                } else {
                                    phi_9920_ = (1f - ((-0.265625f - _e721) % 1f));
                                }
                                let _e748 = phi_9920_;
                                if (_e741 > 0f) {
                                    phi_9933_ = (_e741 % 1f);
                                } else {
                                    phi_9933_ = (1f - ((-0.265625f - _e722) % 1f));
                                }
                                let _e755 = phi_9933_;
                                let _e757 = textureSampleLevel(global_3, global_4, vec2<f32>(_e748, _e755), 0f);
                                let _e764 = fma(_e615, 0.02f, _e618);
                                let _e766 = floor((_e764 * 16f));
                                let _e768 = fma(_e764, 16f, -(_e766));
                                let _e769 = (_e766 * 0.265625f);
                                let _e770 = fma(fma(_e615, 0.02f, _e617), 0.25f, _e769);
                                let _e771 = fma(_e609, 0.00025f, _e769);
                                if (_e770 > 0f) {
                                    phi_9993_ = (_e770 % 1f);
                                } else {
                                    phi_9993_ = (1f - (-(_e770) % 1f));
                                }
                                let _e778 = phi_9993_;
                                if (_e771 > 0f) {
                                    phi_10006_ = (_e771 % 1f);
                                } else {
                                    phi_10006_ = (1f - (-(_e771) % 1f));
                                }
                                let _e785 = phi_10006_;
                                let _e787 = textureSampleLevel(global_3, global_4, vec2<f32>(_e778, _e785), 0f);
                                let _e789 = (_e770 + 0.265625f);
                                let _e790 = (_e771 + 0.265625f);
                                if (_e789 > 0f) {
                                    phi_10036_ = (_e789 % 1f);
                                } else {
                                    phi_10036_ = (1f - ((-0.265625f - _e770) % 1f));
                                }
                                let _e797 = phi_10036_;
                                if (_e790 > 0f) {
                                    phi_10049_ = (_e790 % 1f);
                                } else {
                                    phi_10049_ = (1f - ((-0.265625f - _e771) % 1f));
                                }
                                let _e804 = phi_10049_;
                                let _e806 = textureSampleLevel(global_3, global_4, vec2<f32>(_e797, _e804), 0f);
                                let _e812 = (_e608 - 6372600f);
                                let _e820 = ((fma(fma(_e787.x, (1f - _e768), (_e806.x * _e768)), 0.0625f, fma(fma(_e738.x, (1f - _e719), (_e757.x * _e719)), 0.125f, fma(fma(_e639.x, (1f - _e620), (_e658.x * _e620)), 0.5f, (fma(_e687.x, (1f - _e668), (_e706.x * _e668)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e822 = select(_e820, 0f, (_e820 < 0f));
                                let _e824 = select(_e822, 1f, (_e822 > 1f));
                                phi_699_ = ((((_e824 * _e824) * fma(-2f, _e824, 3f)) * ((1f - exp2((-0.01f * _e812))) * exp2((-0.004f * _e812)))) * 0.03f);
                            }
                            let _e831 = phi_699_;
                            phi_700_ = _e831;
                            phi_701_ = _e611;
                        }
                        let _e833 = phi_700_;
                        let _e835 = phi_701_;
                        phi_582_ = (_e597 + select(_e833, 0f, _e835));
                    } else {
                        phi_582_ = f32();
                    }
                    let _e839 = phi_582_;
                    continue;
                    continuing {
                        phi_581_ = _e839;
                        phi_584_ = _e603;
                        break if !(_e600);
                    }
                }
                let _e842 = local;
                let _e844 = exp2((_e842 * -62.5f));
                phi_758_ = (_e334 * exp2(-(_e586)));
                phi_759_ = fma(_e297, 0.0625f, _e338);
                phi_760_ = fma(_e299, 0.0625f, _e340);
                phi_761_ = fma(_e301, 0.0625f, _e342);
                phi_762_ = fma(((fma((((0.4807763f * _e844) * _e593) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e590) * 3.1415927f), _e334, _e344);
                phi_763_ = fma(((fma((((0.28401393f * _e844) * _e593) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e590) * 3.1415927f), _e334, _e346);
                phi_764_ = fma(((fma((((0.09044314f * _e844) * _e593) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e590) * 3.1415927f), _e334, _e348);
            }
            let _e876 = phi_758_;
            let _e878 = phi_759_;
            let _e880 = phi_760_;
            let _e882 = phi_761_;
            let _e884 = phi_762_;
            let _e886 = phi_763_;
            let _e888 = phi_764_;
            phi_419_ = _e876;
            phi_424_ = _e878;
            phi_426_ = _e880;
            phi_428_ = _e882;
            phi_430_ = _e884;
            phi_432_ = _e886;
            phi_434_ = _e888;
        } else {
            phi_419_ = f32();
            phi_424_ = f32();
            phi_426_ = f32();
            phi_428_ = f32();
            phi_430_ = f32();
            phi_432_ = f32();
            phi_434_ = f32();
        }
        let _e890 = phi_419_;
        let _e892 = phi_424_;
        let _e894 = phi_426_;
        let _e896 = phi_428_;
        let _e898 = phi_430_;
        let _e900 = phi_432_;
        let _e902 = phi_434_;
        continue;
        continuing {
            phi_418_ = _e890;
            phi_421_ = _e352;
            phi_423_ = _e892;
            phi_425_ = _e894;
            phi_427_ = _e896;
            phi_429_ = _e898;
            phi_431_ = _e900;
            phi_433_ = _e902;
            break if !(_e349);
        }
    }
    let _e905 = local_1;
    let _e907 = local_2;
    let _e910 = local_3;
    let _e912 = local_4;
    let _e915 = local_5;
    let _e917 = local_6;
    let _e923 = (sqrt(fma(_e292, _e292, fma(_e290, _e290, (_e291 * _e291)))) * 0.00001f);
    let _e925 = select(_e923, 0f, (_e923 < 0f));
    let _e927 = select(_e925, 1f, (_e925 > 1f));
    let _e928 = (1f - _e927);
    let _e932 = fma(fma(_e268, _e905, _e907), _e928, (_e268 * _e927));
    let _e933 = fma(fma(_e269, _e910, _e912), _e928, (_e269 * _e927));
    let _e934 = fma(fma(_e270, _e915, _e917), _e928, (_e270 * _e927));
    if _e274 {
        phi_10123_ = vec2<f32>(-1f, -1f);
    } else {
        phi_10123_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e939 = phi_10123_;
    if _e283 {
        phi_10163_ = vec2<f32>(-1f, -1f);
    } else {
        phi_10163_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e945 = phi_10163_;
    let _e947 = (_e144.x * _e939.y);
    let _e948 = (_e144.y * _e939.y);
    let _e949 = (_e144.z * _e939.y);
    let _e953 = fma(_e296, _e939.y, (_e144.x + _e945.y));
    let _e954 = fma(_e298, _e939.y, (_e144.y + _e945.y));
    let _e955 = fma(_e300, _e939.y, (_e144.z + _e945.y));
    let _e956 = (_e953 * 0.0625f);
    let _e957 = (_e954 * 0.0625f);
    let _e958 = (_e955 * 0.0625f);
    phi_869_ = 1f;
    phi_872_ = 0u;
    phi_874_ = fma(_e956, _e181, _e947);
    phi_876_ = fma(_e957, _e181, _e948);
    phi_878_ = fma(_e958, _e181, _e949);
    phi_880_ = 0f;
    phi_882_ = 0f;
    phi_884_ = 0f;
    loop {
        let _e967 = phi_869_;
        let _e969 = phi_872_;
        let _e971 = phi_874_;
        let _e973 = phi_876_;
        let _e975 = phi_878_;
        let _e977 = phi_880_;
        let _e979 = phi_882_;
        let _e981 = phi_884_;
        local_8 = _e967;
        local_9 = _e977;
        local_10 = _e967;
        local_11 = _e979;
        local_12 = _e967;
        local_13 = _e981;
        let _e982 = (_e969 < 16u);
        if _e982 {
            phi_873_ = (_e969 + 1u);
        } else {
            phi_873_ = _e969;
        }
        let _e985 = phi_873_;
        if _e982 {
            let _e986 = (_e973 + 6371000f);
            let _e990 = sqrt(fma(_e975, _e975, fma(_e971, _e971, (_e986 * _e986))));
            let _e991 = (_e990 - 6371000f);
            if (_e991 < 1600f) {
                phi_1000_ = f32();
                phi_1001_ = true;
            } else {
                let _e993 = (_e991 > 2100f);
                if _e993 {
                    phi_999_ = f32();
                } else {
                    let _e997 = global_2.member.member[0u];
                    let _e998 = (_e997 * 0.02f);
                    let _e999 = fma(_e971, 0.001f, _e998);
                    let _e1000 = fma(_e975, 0.001f, _e998);
                    let _e1001 = floor(_e1000);
                    let _e1002 = (_e1000 - _e1001);
                    let _e1003 = (_e1001 * 0.265625f);
                    let _e1004 = fma(_e999, 0.015625f, _e1003);
                    let _e1005 = fma(_e991, 0.000015625f, _e1003);
                    if (_e1004 > 0f) {
                        phi_10388_ = (_e1004 % 1f);
                    } else {
                        phi_10388_ = (1f - (-(_e1004) % 1f));
                    }
                    let _e1012 = phi_10388_;
                    if (_e1005 > 0f) {
                        phi_10401_ = (_e1005 % 1f);
                    } else {
                        phi_10401_ = (1f - (-(_e1005) % 1f));
                    }
                    let _e1019 = phi_10401_;
                    let _e1021 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1012, _e1019), 0f);
                    let _e1023 = (_e1004 + 0.265625f);
                    let _e1024 = (_e1005 + 0.265625f);
                    if (_e1023 > 0f) {
                        phi_10431_ = (_e1023 % 1f);
                    } else {
                        phi_10431_ = (1f - ((-0.265625f - _e1004) % 1f));
                    }
                    let _e1031 = phi_10431_;
                    if (_e1024 > 0f) {
                        phi_10444_ = (_e1024 % 1f);
                    } else {
                        phi_10444_ = (1f - ((-0.265625f - _e1005) % 1f));
                    }
                    let _e1038 = phi_10444_;
                    let _e1040 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1031, _e1038), 0f);
                    let _e1045 = fma(_e997, 0.02f, 2f);
                    let _e1048 = floor((_e1000 * _e1045));
                    let _e1050 = fma(_e1000, _e1045, -(_e1048));
                    let _e1051 = (_e1048 * 0.265625f);
                    let _e1052 = fma((_e999 * _e1045), 0.015625f, _e1051);
                    let _e1053 = fma(_e991, 0.00003125f, _e1051);
                    if (_e1052 > 0f) {
                        phi_10504_ = (_e1052 % 1f);
                    } else {
                        phi_10504_ = (1f - (-(_e1052) % 1f));
                    }
                    let _e1060 = phi_10504_;
                    if (_e1053 > 0f) {
                        phi_10517_ = (_e1053 % 1f);
                    } else {
                        phi_10517_ = (1f - (-(_e1053) % 1f));
                    }
                    let _e1067 = phi_10517_;
                    let _e1069 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1060, _e1067), 0f);
                    let _e1071 = (_e1052 + 0.265625f);
                    let _e1072 = (_e1053 + 0.265625f);
                    if (_e1071 > 0f) {
                        phi_10547_ = (_e1071 % 1f);
                    } else {
                        phi_10547_ = (1f - ((-0.265625f - _e1052) % 1f));
                    }
                    let _e1079 = phi_10547_;
                    if (_e1072 > 0f) {
                        phi_10560_ = (_e1072 % 1f);
                    } else {
                        phi_10560_ = (1f - ((-0.265625f - _e1053) % 1f));
                    }
                    let _e1086 = phi_10560_;
                    let _e1088 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1079, _e1086), 0f);
                    let _e1096 = fma(-(_e997), 0.02f, 7f);
                    let _e1099 = floor((_e1000 * _e1096));
                    let _e1101 = fma(_e1000, _e1096, -(_e1099));
                    let _e1102 = (_e1099 * 0.265625f);
                    let _e1103 = fma((_e999 * _e1096), 0.015625f, _e1102);
                    let _e1104 = fma(_e991, 0.000109375f, _e1102);
                    if (_e1103 > 0f) {
                        phi_10620_ = (_e1103 % 1f);
                    } else {
                        phi_10620_ = (1f - (-(_e1103) % 1f));
                    }
                    let _e1111 = phi_10620_;
                    if (_e1104 > 0f) {
                        phi_10633_ = (_e1104 % 1f);
                    } else {
                        phi_10633_ = (1f - (-(_e1104) % 1f));
                    }
                    let _e1118 = phi_10633_;
                    let _e1120 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1111, _e1118), 0f);
                    let _e1122 = (_e1103 + 0.265625f);
                    let _e1123 = (_e1104 + 0.265625f);
                    if (_e1122 > 0f) {
                        phi_10663_ = (_e1122 % 1f);
                    } else {
                        phi_10663_ = (1f - ((-0.265625f - _e1103) % 1f));
                    }
                    let _e1130 = phi_10663_;
                    if (_e1123 > 0f) {
                        phi_10676_ = (_e1123 % 1f);
                    } else {
                        phi_10676_ = (1f - ((-0.265625f - _e1104) % 1f));
                    }
                    let _e1137 = phi_10676_;
                    let _e1139 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1130, _e1137), 0f);
                    let _e1146 = fma(_e997, 0.02f, _e1000);
                    let _e1148 = floor((_e1146 * 16f));
                    let _e1150 = fma(_e1146, 16f, -(_e1148));
                    let _e1151 = (_e1148 * 0.265625f);
                    let _e1152 = fma(fma(_e997, 0.02f, _e999), 0.25f, _e1151);
                    let _e1153 = fma(_e991, 0.00025f, _e1151);
                    if (_e1152 > 0f) {
                        phi_10736_ = (_e1152 % 1f);
                    } else {
                        phi_10736_ = (1f - (-(_e1152) % 1f));
                    }
                    let _e1160 = phi_10736_;
                    if (_e1153 > 0f) {
                        phi_10749_ = (_e1153 % 1f);
                    } else {
                        phi_10749_ = (1f - (-(_e1153) % 1f));
                    }
                    let _e1167 = phi_10749_;
                    let _e1169 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1160, _e1167), 0f);
                    let _e1171 = (_e1152 + 0.265625f);
                    let _e1172 = (_e1153 + 0.265625f);
                    if (_e1171 > 0f) {
                        phi_10779_ = (_e1171 % 1f);
                    } else {
                        phi_10779_ = (1f - ((-0.265625f - _e1152) % 1f));
                    }
                    let _e1179 = phi_10779_;
                    if (_e1172 > 0f) {
                        phi_10792_ = (_e1172 % 1f);
                    } else {
                        phi_10792_ = (1f - ((-0.265625f - _e1153) % 1f));
                    }
                    let _e1186 = phi_10792_;
                    let _e1188 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1179, _e1186), 0f);
                    let _e1194 = (_e990 - 6372600f);
                    let _e1202 = ((fma(fma(_e1169.x, (1f - _e1150), (_e1188.x * _e1150)), 0.0625f, fma(fma(_e1120.x, (1f - _e1101), (_e1139.x * _e1101)), 0.125f, fma(fma(_e1021.x, (1f - _e1002), (_e1040.x * _e1002)), 0.5f, (fma(_e1069.x, (1f - _e1050), (_e1088.x * _e1050)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e1204 = select(_e1202, 0f, (_e1202 < 0f));
                    let _e1206 = select(_e1204, 1f, (_e1204 > 1f));
                    phi_999_ = ((((_e1206 * _e1206) * fma(-2f, _e1206, 3f)) * ((1f - exp2((-0.01f * _e1194))) * exp2((-0.004f * _e1194)))) * 0.03f);
                }
                let _e1213 = phi_999_;
                phi_1000_ = _e1213;
                phi_1001_ = _e993;
            }
            let _e1215 = phi_1000_;
            let _e1217 = phi_1001_;
            let _e1219 = (select(_e1215, 0f, _e1217) * sqrt(fma(_e958, _e958, fma(_e956, _e956, (_e957 * _e957)))));
            if (_e1219 <= 0f) {
                phi_1209_ = _e967;
                phi_1210_ = _e971;
                phi_1211_ = _e973;
                phi_1212_ = _e975;
                phi_1213_ = _e977;
                phi_1214_ = _e979;
                phi_1215_ = _e981;
            } else {
                let _e1223 = fma(exp2((-1.6013916f * _e1219)), -0.9009009f, 0.9009009f);
                let _e1226 = (1f - exp2((_e1219 * -1.3862944f)));
                let _e1227 = (-9.537895f + _e971);
                let _e1228 = (29.354609f + _e975);
                phi_1032_ = 0f;
                phi_1035_ = 0u;
                loop {
                    let _e1230 = phi_1032_;
                    let _e1232 = phi_1035_;
                    local_7 = _e1230;
                    let _e1233 = (_e1232 < 8u);
                    if _e1233 {
                        phi_1036_ = (_e1232 + 1u);
                    } else {
                        phi_1036_ = _e1232;
                    }
                    let _e1236 = phi_1036_;
                    if _e1233 {
                        let _e1237 = (_e973 + 6371005f);
                        let _e1241 = sqrt(fma(_e1228, _e1228, fma(_e1227, _e1227, (_e1237 * _e1237))));
                        let _e1242 = (_e1241 - 6371000f);
                        if (_e1242 < 1600f) {
                            phi_1151_ = f32();
                            phi_1152_ = true;
                        } else {
                            let _e1244 = (_e1242 > 2100f);
                            if _e1244 {
                                phi_1150_ = f32();
                            } else {
                                let _e1248 = global_2.member.member[0u];
                                let _e1249 = (_e1248 * 0.02f);
                                let _e1250 = fma(_e1227, 0.001f, _e1249);
                                let _e1251 = fma(_e1228, 0.001f, _e1249);
                                let _e1252 = floor(_e1251);
                                let _e1253 = (_e1251 - _e1252);
                                let _e1254 = (_e1252 * 0.265625f);
                                let _e1255 = fma(_e1250, 0.015625f, _e1254);
                                let _e1256 = fma(_e1242, 0.000015625f, _e1254);
                                if (_e1255 > 0f) {
                                    phi_10868_ = (_e1255 % 1f);
                                } else {
                                    phi_10868_ = (1f - (-(_e1255) % 1f));
                                }
                                let _e1263 = phi_10868_;
                                if (_e1256 > 0f) {
                                    phi_10881_ = (_e1256 % 1f);
                                } else {
                                    phi_10881_ = (1f - (-(_e1256) % 1f));
                                }
                                let _e1270 = phi_10881_;
                                let _e1272 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1263, _e1270), 0f);
                                let _e1274 = (_e1255 + 0.265625f);
                                let _e1275 = (_e1256 + 0.265625f);
                                if (_e1274 > 0f) {
                                    phi_10911_ = (_e1274 % 1f);
                                } else {
                                    phi_10911_ = (1f - ((-0.265625f - _e1255) % 1f));
                                }
                                let _e1282 = phi_10911_;
                                if (_e1275 > 0f) {
                                    phi_10924_ = (_e1275 % 1f);
                                } else {
                                    phi_10924_ = (1f - ((-0.265625f - _e1256) % 1f));
                                }
                                let _e1289 = phi_10924_;
                                let _e1291 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1282, _e1289), 0f);
                                let _e1296 = fma(_e1248, 0.02f, 2f);
                                let _e1299 = floor((_e1251 * _e1296));
                                let _e1301 = fma(_e1251, _e1296, -(_e1299));
                                let _e1302 = (_e1299 * 0.265625f);
                                let _e1303 = fma((_e1250 * _e1296), 0.015625f, _e1302);
                                let _e1304 = fma(_e1242, 0.00003125f, _e1302);
                                if (_e1303 > 0f) {
                                    phi_10984_ = (_e1303 % 1f);
                                } else {
                                    phi_10984_ = (1f - (-(_e1303) % 1f));
                                }
                                let _e1311 = phi_10984_;
                                if (_e1304 > 0f) {
                                    phi_10997_ = (_e1304 % 1f);
                                } else {
                                    phi_10997_ = (1f - (-(_e1304) % 1f));
                                }
                                let _e1318 = phi_10997_;
                                let _e1320 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1311, _e1318), 0f);
                                let _e1322 = (_e1303 + 0.265625f);
                                let _e1323 = (_e1304 + 0.265625f);
                                if (_e1322 > 0f) {
                                    phi_11027_ = (_e1322 % 1f);
                                } else {
                                    phi_11027_ = (1f - ((-0.265625f - _e1303) % 1f));
                                }
                                let _e1330 = phi_11027_;
                                if (_e1323 > 0f) {
                                    phi_11040_ = (_e1323 % 1f);
                                } else {
                                    phi_11040_ = (1f - ((-0.265625f - _e1304) % 1f));
                                }
                                let _e1337 = phi_11040_;
                                let _e1339 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1330, _e1337), 0f);
                                let _e1347 = fma(-(_e1248), 0.02f, 7f);
                                let _e1350 = floor((_e1251 * _e1347));
                                let _e1352 = fma(_e1251, _e1347, -(_e1350));
                                let _e1353 = (_e1350 * 0.265625f);
                                let _e1354 = fma((_e1250 * _e1347), 0.015625f, _e1353);
                                let _e1355 = fma(_e1242, 0.000109375f, _e1353);
                                if (_e1354 > 0f) {
                                    phi_11100_ = (_e1354 % 1f);
                                } else {
                                    phi_11100_ = (1f - (-(_e1354) % 1f));
                                }
                                let _e1362 = phi_11100_;
                                if (_e1355 > 0f) {
                                    phi_11113_ = (_e1355 % 1f);
                                } else {
                                    phi_11113_ = (1f - (-(_e1355) % 1f));
                                }
                                let _e1369 = phi_11113_;
                                let _e1371 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1362, _e1369), 0f);
                                let _e1373 = (_e1354 + 0.265625f);
                                let _e1374 = (_e1355 + 0.265625f);
                                if (_e1373 > 0f) {
                                    phi_11143_ = (_e1373 % 1f);
                                } else {
                                    phi_11143_ = (1f - ((-0.265625f - _e1354) % 1f));
                                }
                                let _e1381 = phi_11143_;
                                if (_e1374 > 0f) {
                                    phi_11156_ = (_e1374 % 1f);
                                } else {
                                    phi_11156_ = (1f - ((-0.265625f - _e1355) % 1f));
                                }
                                let _e1388 = phi_11156_;
                                let _e1390 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1381, _e1388), 0f);
                                let _e1397 = fma(_e1248, 0.02f, _e1251);
                                let _e1399 = floor((_e1397 * 16f));
                                let _e1401 = fma(_e1397, 16f, -(_e1399));
                                let _e1402 = (_e1399 * 0.265625f);
                                let _e1403 = fma(fma(_e1248, 0.02f, _e1250), 0.25f, _e1402);
                                let _e1404 = fma(_e1242, 0.00025f, _e1402);
                                if (_e1403 > 0f) {
                                    phi_11216_ = (_e1403 % 1f);
                                } else {
                                    phi_11216_ = (1f - (-(_e1403) % 1f));
                                }
                                let _e1411 = phi_11216_;
                                if (_e1404 > 0f) {
                                    phi_11229_ = (_e1404 % 1f);
                                } else {
                                    phi_11229_ = (1f - (-(_e1404) % 1f));
                                }
                                let _e1418 = phi_11229_;
                                let _e1420 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1411, _e1418), 0f);
                                let _e1422 = (_e1403 + 0.265625f);
                                let _e1423 = (_e1404 + 0.265625f);
                                if (_e1422 > 0f) {
                                    phi_11259_ = (_e1422 % 1f);
                                } else {
                                    phi_11259_ = (1f - ((-0.265625f - _e1403) % 1f));
                                }
                                let _e1430 = phi_11259_;
                                if (_e1423 > 0f) {
                                    phi_11272_ = (_e1423 % 1f);
                                } else {
                                    phi_11272_ = (1f - ((-0.265625f - _e1404) % 1f));
                                }
                                let _e1437 = phi_11272_;
                                let _e1439 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1430, _e1437), 0f);
                                let _e1445 = (_e1241 - 6372600f);
                                let _e1453 = ((fma(fma(_e1420.x, (1f - _e1401), (_e1439.x * _e1401)), 0.0625f, fma(fma(_e1371.x, (1f - _e1352), (_e1390.x * _e1352)), 0.125f, fma(fma(_e1272.x, (1f - _e1253), (_e1291.x * _e1253)), 0.5f, (fma(_e1320.x, (1f - _e1301), (_e1339.x * _e1301)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e1455 = select(_e1453, 0f, (_e1453 < 0f));
                                let _e1457 = select(_e1455, 1f, (_e1455 > 1f));
                                phi_1150_ = ((((_e1457 * _e1457) * fma(-2f, _e1457, 3f)) * ((1f - exp2((-0.01f * _e1445))) * exp2((-0.004f * _e1445)))) * 0.03f);
                            }
                            let _e1464 = phi_1150_;
                            phi_1151_ = _e1464;
                            phi_1152_ = _e1244;
                        }
                        let _e1466 = phi_1151_;
                        let _e1468 = phi_1152_;
                        phi_1033_ = (_e1230 + select(_e1466, 0f, _e1468));
                    } else {
                        phi_1033_ = f32();
                    }
                    let _e1472 = phi_1033_;
                    continue;
                    continuing {
                        phi_1032_ = _e1472;
                        phi_1035_ = _e1236;
                        break if !(_e1233);
                    }
                }
                let _e1475 = local_7;
                let _e1477 = exp2((_e1475 * -62.5f));
                phi_1209_ = (_e967 * exp2(-(_e1219)));
                phi_1210_ = fma(_e953, 0.0625f, _e971);
                phi_1211_ = fma(_e954, 0.0625f, _e973);
                phi_1212_ = fma(_e955, 0.0625f, _e975);
                phi_1213_ = fma(((fma((((0.4807763f * _e1477) * _e1226) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e1223) * 3.1415927f), _e967, _e977);
                phi_1214_ = fma(((fma((((0.28401393f * _e1477) * _e1226) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e1223) * 3.1415927f), _e967, _e979);
                phi_1215_ = fma(((fma((((0.09044314f * _e1477) * _e1226) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e1223) * 3.1415927f), _e967, _e981);
            }
            let _e1509 = phi_1209_;
            let _e1511 = phi_1210_;
            let _e1513 = phi_1211_;
            let _e1515 = phi_1212_;
            let _e1517 = phi_1213_;
            let _e1519 = phi_1214_;
            let _e1521 = phi_1215_;
            phi_870_ = _e1509;
            phi_875_ = _e1511;
            phi_877_ = _e1513;
            phi_879_ = _e1515;
            phi_881_ = _e1517;
            phi_883_ = _e1519;
            phi_885_ = _e1521;
        } else {
            phi_870_ = f32();
            phi_875_ = f32();
            phi_877_ = f32();
            phi_879_ = f32();
            phi_881_ = f32();
            phi_883_ = f32();
            phi_885_ = f32();
        }
        let _e1523 = phi_870_;
        let _e1525 = phi_875_;
        let _e1527 = phi_877_;
        let _e1529 = phi_879_;
        let _e1531 = phi_881_;
        let _e1533 = phi_883_;
        let _e1535 = phi_885_;
        continue;
        continuing {
            phi_869_ = _e1523;
            phi_872_ = _e985;
            phi_874_ = _e1525;
            phi_876_ = _e1527;
            phi_878_ = _e1529;
            phi_880_ = _e1531;
            phi_882_ = _e1533;
            phi_884_ = _e1535;
            break if !(_e982);
        }
    }
    let _e1538 = local_8;
    let _e1540 = local_9;
    let _e1543 = local_10;
    let _e1545 = local_11;
    let _e1548 = local_12;
    let _e1550 = local_13;
    let _e1556 = (sqrt(fma(_e949, _e949, fma(_e947, _e947, (_e948 * _e948)))) * 0.00001f);
    let _e1558 = select(_e1556, 0f, (_e1556 < 0f));
    let _e1560 = select(_e1558, 1f, (_e1558 > 1f));
    let _e1561 = (1f - _e1560);
    let _e1565 = fma(fma(_e932, _e1538, _e1540), _e1561, (_e932 * _e1560));
    let _e1566 = fma(fma(_e933, _e1543, _e1545), _e1561, (_e933 * _e1560));
    let _e1567 = fma(fma(_e934, _e1548, _e1550), _e1561, (_e934 * _e1560));
    if _e274 {
        phi_11346_ = vec2<f32>(-1f, -1f);
    } else {
        phi_11346_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e1572 = phi_11346_;
    if _e283 {
        phi_11386_ = vec2<f32>(-1f, -1f);
    } else {
        phi_11386_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e1578 = phi_11386_;
    let _e1580 = (_e144.x * _e1572.y);
    let _e1581 = (_e144.y * _e1572.y);
    let _e1582 = (_e144.z * _e1572.y);
    let _e1586 = fma(_e296, _e1572.y, (_e144.x + _e1578.y));
    let _e1587 = fma(_e298, _e1572.y, (_e144.y + _e1578.y));
    let _e1588 = fma(_e300, _e1572.y, (_e144.z + _e1578.y));
    let _e1589 = (_e1586 * 0.0625f);
    let _e1590 = (_e1587 * 0.0625f);
    let _e1591 = (_e1588 * 0.0625f);
    phi_1323_ = 1f;
    phi_1326_ = 0u;
    phi_1328_ = fma(_e1589, _e181, _e1580);
    phi_1330_ = fma(_e1590, _e181, _e1581);
    phi_1332_ = fma(_e1591, _e181, _e1582);
    phi_1334_ = 0f;
    phi_1336_ = 0f;
    phi_1338_ = 0f;
    loop {
        let _e1600 = phi_1323_;
        let _e1602 = phi_1326_;
        let _e1604 = phi_1328_;
        let _e1606 = phi_1330_;
        let _e1608 = phi_1332_;
        let _e1610 = phi_1334_;
        let _e1612 = phi_1336_;
        let _e1614 = phi_1338_;
        local_15 = _e1600;
        local_16 = _e1610;
        local_17 = _e1600;
        local_18 = _e1612;
        local_19 = _e1600;
        local_20 = _e1614;
        let _e1615 = (_e1602 < 16u);
        if _e1615 {
            phi_1327_ = (_e1602 + 1u);
        } else {
            phi_1327_ = _e1602;
        }
        let _e1618 = phi_1327_;
        if _e1615 {
            let _e1619 = (_e1606 + 6371000f);
            let _e1623 = sqrt(fma(_e1608, _e1608, fma(_e1604, _e1604, (_e1619 * _e1619))));
            let _e1624 = (_e1623 - 6371000f);
            if (_e1624 < 1600f) {
                phi_1454_ = f32();
                phi_1455_ = true;
            } else {
                let _e1626 = (_e1624 > 2100f);
                if _e1626 {
                    phi_1453_ = f32();
                } else {
                    let _e1630 = global_2.member.member[0u];
                    let _e1631 = (_e1630 * 0.02f);
                    let _e1632 = fma(_e1604, 0.001f, _e1631);
                    let _e1633 = fma(_e1608, 0.001f, _e1631);
                    let _e1634 = floor(_e1633);
                    let _e1635 = (_e1633 - _e1634);
                    let _e1636 = (_e1634 * 0.265625f);
                    let _e1637 = fma(_e1632, 0.015625f, _e1636);
                    let _e1638 = fma(_e1624, 0.000015625f, _e1636);
                    if (_e1637 > 0f) {
                        phi_11611_ = (_e1637 % 1f);
                    } else {
                        phi_11611_ = (1f - (-(_e1637) % 1f));
                    }
                    let _e1645 = phi_11611_;
                    if (_e1638 > 0f) {
                        phi_11624_ = (_e1638 % 1f);
                    } else {
                        phi_11624_ = (1f - (-(_e1638) % 1f));
                    }
                    let _e1652 = phi_11624_;
                    let _e1654 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1645, _e1652), 0f);
                    let _e1656 = (_e1637 + 0.265625f);
                    let _e1657 = (_e1638 + 0.265625f);
                    if (_e1656 > 0f) {
                        phi_11654_ = (_e1656 % 1f);
                    } else {
                        phi_11654_ = (1f - ((-0.265625f - _e1637) % 1f));
                    }
                    let _e1664 = phi_11654_;
                    if (_e1657 > 0f) {
                        phi_11667_ = (_e1657 % 1f);
                    } else {
                        phi_11667_ = (1f - ((-0.265625f - _e1638) % 1f));
                    }
                    let _e1671 = phi_11667_;
                    let _e1673 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1664, _e1671), 0f);
                    let _e1678 = fma(_e1630, 0.02f, 2f);
                    let _e1681 = floor((_e1633 * _e1678));
                    let _e1683 = fma(_e1633, _e1678, -(_e1681));
                    let _e1684 = (_e1681 * 0.265625f);
                    let _e1685 = fma((_e1632 * _e1678), 0.015625f, _e1684);
                    let _e1686 = fma(_e1624, 0.00003125f, _e1684);
                    if (_e1685 > 0f) {
                        phi_11727_ = (_e1685 % 1f);
                    } else {
                        phi_11727_ = (1f - (-(_e1685) % 1f));
                    }
                    let _e1693 = phi_11727_;
                    if (_e1686 > 0f) {
                        phi_11740_ = (_e1686 % 1f);
                    } else {
                        phi_11740_ = (1f - (-(_e1686) % 1f));
                    }
                    let _e1700 = phi_11740_;
                    let _e1702 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1693, _e1700), 0f);
                    let _e1704 = (_e1685 + 0.265625f);
                    let _e1705 = (_e1686 + 0.265625f);
                    if (_e1704 > 0f) {
                        phi_11770_ = (_e1704 % 1f);
                    } else {
                        phi_11770_ = (1f - ((-0.265625f - _e1685) % 1f));
                    }
                    let _e1712 = phi_11770_;
                    if (_e1705 > 0f) {
                        phi_11783_ = (_e1705 % 1f);
                    } else {
                        phi_11783_ = (1f - ((-0.265625f - _e1686) % 1f));
                    }
                    let _e1719 = phi_11783_;
                    let _e1721 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1712, _e1719), 0f);
                    let _e1729 = fma(-(_e1630), 0.02f, 7f);
                    let _e1732 = floor((_e1633 * _e1729));
                    let _e1734 = fma(_e1633, _e1729, -(_e1732));
                    let _e1735 = (_e1732 * 0.265625f);
                    let _e1736 = fma((_e1632 * _e1729), 0.015625f, _e1735);
                    let _e1737 = fma(_e1624, 0.000109375f, _e1735);
                    if (_e1736 > 0f) {
                        phi_11843_ = (_e1736 % 1f);
                    } else {
                        phi_11843_ = (1f - (-(_e1736) % 1f));
                    }
                    let _e1744 = phi_11843_;
                    if (_e1737 > 0f) {
                        phi_11856_ = (_e1737 % 1f);
                    } else {
                        phi_11856_ = (1f - (-(_e1737) % 1f));
                    }
                    let _e1751 = phi_11856_;
                    let _e1753 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1744, _e1751), 0f);
                    let _e1755 = (_e1736 + 0.265625f);
                    let _e1756 = (_e1737 + 0.265625f);
                    if (_e1755 > 0f) {
                        phi_11886_ = (_e1755 % 1f);
                    } else {
                        phi_11886_ = (1f - ((-0.265625f - _e1736) % 1f));
                    }
                    let _e1763 = phi_11886_;
                    if (_e1756 > 0f) {
                        phi_11899_ = (_e1756 % 1f);
                    } else {
                        phi_11899_ = (1f - ((-0.265625f - _e1737) % 1f));
                    }
                    let _e1770 = phi_11899_;
                    let _e1772 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1763, _e1770), 0f);
                    let _e1779 = fma(_e1630, 0.02f, _e1633);
                    let _e1781 = floor((_e1779 * 16f));
                    let _e1783 = fma(_e1779, 16f, -(_e1781));
                    let _e1784 = (_e1781 * 0.265625f);
                    let _e1785 = fma(fma(_e1630, 0.02f, _e1632), 0.25f, _e1784);
                    let _e1786 = fma(_e1624, 0.00025f, _e1784);
                    if (_e1785 > 0f) {
                        phi_11959_ = (_e1785 % 1f);
                    } else {
                        phi_11959_ = (1f - (-(_e1785) % 1f));
                    }
                    let _e1793 = phi_11959_;
                    if (_e1786 > 0f) {
                        phi_11972_ = (_e1786 % 1f);
                    } else {
                        phi_11972_ = (1f - (-(_e1786) % 1f));
                    }
                    let _e1800 = phi_11972_;
                    let _e1802 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1793, _e1800), 0f);
                    let _e1804 = (_e1785 + 0.265625f);
                    let _e1805 = (_e1786 + 0.265625f);
                    if (_e1804 > 0f) {
                        phi_12002_ = (_e1804 % 1f);
                    } else {
                        phi_12002_ = (1f - ((-0.265625f - _e1785) % 1f));
                    }
                    let _e1812 = phi_12002_;
                    if (_e1805 > 0f) {
                        phi_12015_ = (_e1805 % 1f);
                    } else {
                        phi_12015_ = (1f - ((-0.265625f - _e1786) % 1f));
                    }
                    let _e1819 = phi_12015_;
                    let _e1821 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1812, _e1819), 0f);
                    let _e1827 = (_e1623 - 6372600f);
                    let _e1835 = ((fma(fma(_e1802.x, (1f - _e1783), (_e1821.x * _e1783)), 0.0625f, fma(fma(_e1753.x, (1f - _e1734), (_e1772.x * _e1734)), 0.125f, fma(fma(_e1654.x, (1f - _e1635), (_e1673.x * _e1635)), 0.5f, (fma(_e1702.x, (1f - _e1683), (_e1721.x * _e1683)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e1837 = select(_e1835, 0f, (_e1835 < 0f));
                    let _e1839 = select(_e1837, 1f, (_e1837 > 1f));
                    phi_1453_ = ((((_e1839 * _e1839) * fma(-2f, _e1839, 3f)) * ((1f - exp2((-0.01f * _e1827))) * exp2((-0.004f * _e1827)))) * 0.03f);
                }
                let _e1846 = phi_1453_;
                phi_1454_ = _e1846;
                phi_1455_ = _e1626;
            }
            let _e1848 = phi_1454_;
            let _e1850 = phi_1455_;
            let _e1852 = (select(_e1848, 0f, _e1850) * sqrt(fma(_e1591, _e1591, fma(_e1589, _e1589, (_e1590 * _e1590)))));
            if (_e1852 <= 0f) {
                phi_1663_ = _e1600;
                phi_1664_ = _e1604;
                phi_1665_ = _e1606;
                phi_1666_ = _e1608;
                phi_1667_ = _e1610;
                phi_1668_ = _e1612;
                phi_1669_ = _e1614;
            } else {
                let _e1856 = fma(exp2((-1.6013916f * _e1852)), -0.9009009f, 0.9009009f);
                let _e1859 = (1f - exp2((_e1852 * -1.3862944f)));
                let _e1860 = (-9.537895f + _e1604);
                let _e1861 = (29.354609f + _e1608);
                phi_1486_ = 0f;
                phi_1489_ = 0u;
                loop {
                    let _e1863 = phi_1486_;
                    let _e1865 = phi_1489_;
                    local_14 = _e1863;
                    let _e1866 = (_e1865 < 8u);
                    if _e1866 {
                        phi_1490_ = (_e1865 + 1u);
                    } else {
                        phi_1490_ = _e1865;
                    }
                    let _e1869 = phi_1490_;
                    if _e1866 {
                        let _e1870 = (_e1606 + 6371005f);
                        let _e1874 = sqrt(fma(_e1861, _e1861, fma(_e1860, _e1860, (_e1870 * _e1870))));
                        let _e1875 = (_e1874 - 6371000f);
                        if (_e1875 < 1600f) {
                            phi_1605_ = f32();
                            phi_1606_ = true;
                        } else {
                            let _e1877 = (_e1875 > 2100f);
                            if _e1877 {
                                phi_1604_ = f32();
                            } else {
                                let _e1881 = global_2.member.member[0u];
                                let _e1882 = (_e1881 * 0.02f);
                                let _e1883 = fma(_e1860, 0.001f, _e1882);
                                let _e1884 = fma(_e1861, 0.001f, _e1882);
                                let _e1885 = floor(_e1884);
                                let _e1886 = (_e1884 - _e1885);
                                let _e1887 = (_e1885 * 0.265625f);
                                let _e1888 = fma(_e1883, 0.015625f, _e1887);
                                let _e1889 = fma(_e1875, 0.000015625f, _e1887);
                                if (_e1888 > 0f) {
                                    phi_12091_ = (_e1888 % 1f);
                                } else {
                                    phi_12091_ = (1f - (-(_e1888) % 1f));
                                }
                                let _e1896 = phi_12091_;
                                if (_e1889 > 0f) {
                                    phi_12104_ = (_e1889 % 1f);
                                } else {
                                    phi_12104_ = (1f - (-(_e1889) % 1f));
                                }
                                let _e1903 = phi_12104_;
                                let _e1905 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1896, _e1903), 0f);
                                let _e1907 = (_e1888 + 0.265625f);
                                let _e1908 = (_e1889 + 0.265625f);
                                if (_e1907 > 0f) {
                                    phi_12134_ = (_e1907 % 1f);
                                } else {
                                    phi_12134_ = (1f - ((-0.265625f - _e1888) % 1f));
                                }
                                let _e1915 = phi_12134_;
                                if (_e1908 > 0f) {
                                    phi_12147_ = (_e1908 % 1f);
                                } else {
                                    phi_12147_ = (1f - ((-0.265625f - _e1889) % 1f));
                                }
                                let _e1922 = phi_12147_;
                                let _e1924 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1915, _e1922), 0f);
                                let _e1929 = fma(_e1881, 0.02f, 2f);
                                let _e1932 = floor((_e1884 * _e1929));
                                let _e1934 = fma(_e1884, _e1929, -(_e1932));
                                let _e1935 = (_e1932 * 0.265625f);
                                let _e1936 = fma((_e1883 * _e1929), 0.015625f, _e1935);
                                let _e1937 = fma(_e1875, 0.00003125f, _e1935);
                                if (_e1936 > 0f) {
                                    phi_12207_ = (_e1936 % 1f);
                                } else {
                                    phi_12207_ = (1f - (-(_e1936) % 1f));
                                }
                                let _e1944 = phi_12207_;
                                if (_e1937 > 0f) {
                                    phi_12220_ = (_e1937 % 1f);
                                } else {
                                    phi_12220_ = (1f - (-(_e1937) % 1f));
                                }
                                let _e1951 = phi_12220_;
                                let _e1953 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1944, _e1951), 0f);
                                let _e1955 = (_e1936 + 0.265625f);
                                let _e1956 = (_e1937 + 0.265625f);
                                if (_e1955 > 0f) {
                                    phi_12250_ = (_e1955 % 1f);
                                } else {
                                    phi_12250_ = (1f - ((-0.265625f - _e1936) % 1f));
                                }
                                let _e1963 = phi_12250_;
                                if (_e1956 > 0f) {
                                    phi_12263_ = (_e1956 % 1f);
                                } else {
                                    phi_12263_ = (1f - ((-0.265625f - _e1937) % 1f));
                                }
                                let _e1970 = phi_12263_;
                                let _e1972 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1963, _e1970), 0f);
                                let _e1980 = fma(-(_e1881), 0.02f, 7f);
                                let _e1983 = floor((_e1884 * _e1980));
                                let _e1985 = fma(_e1884, _e1980, -(_e1983));
                                let _e1986 = (_e1983 * 0.265625f);
                                let _e1987 = fma((_e1883 * _e1980), 0.015625f, _e1986);
                                let _e1988 = fma(_e1875, 0.000109375f, _e1986);
                                if (_e1987 > 0f) {
                                    phi_12323_ = (_e1987 % 1f);
                                } else {
                                    phi_12323_ = (1f - (-(_e1987) % 1f));
                                }
                                let _e1995 = phi_12323_;
                                if (_e1988 > 0f) {
                                    phi_12336_ = (_e1988 % 1f);
                                } else {
                                    phi_12336_ = (1f - (-(_e1988) % 1f));
                                }
                                let _e2002 = phi_12336_;
                                let _e2004 = textureSampleLevel(global_3, global_4, vec2<f32>(_e1995, _e2002), 0f);
                                let _e2006 = (_e1987 + 0.265625f);
                                let _e2007 = (_e1988 + 0.265625f);
                                if (_e2006 > 0f) {
                                    phi_12366_ = (_e2006 % 1f);
                                } else {
                                    phi_12366_ = (1f - ((-0.265625f - _e1987) % 1f));
                                }
                                let _e2014 = phi_12366_;
                                if (_e2007 > 0f) {
                                    phi_12379_ = (_e2007 % 1f);
                                } else {
                                    phi_12379_ = (1f - ((-0.265625f - _e1988) % 1f));
                                }
                                let _e2021 = phi_12379_;
                                let _e2023 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2014, _e2021), 0f);
                                let _e2030 = fma(_e1881, 0.02f, _e1884);
                                let _e2032 = floor((_e2030 * 16f));
                                let _e2034 = fma(_e2030, 16f, -(_e2032));
                                let _e2035 = (_e2032 * 0.265625f);
                                let _e2036 = fma(fma(_e1881, 0.02f, _e1883), 0.25f, _e2035);
                                let _e2037 = fma(_e1875, 0.00025f, _e2035);
                                if (_e2036 > 0f) {
                                    phi_12439_ = (_e2036 % 1f);
                                } else {
                                    phi_12439_ = (1f - (-(_e2036) % 1f));
                                }
                                let _e2044 = phi_12439_;
                                if (_e2037 > 0f) {
                                    phi_12452_ = (_e2037 % 1f);
                                } else {
                                    phi_12452_ = (1f - (-(_e2037) % 1f));
                                }
                                let _e2051 = phi_12452_;
                                let _e2053 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2044, _e2051), 0f);
                                let _e2055 = (_e2036 + 0.265625f);
                                let _e2056 = (_e2037 + 0.265625f);
                                if (_e2055 > 0f) {
                                    phi_12482_ = (_e2055 % 1f);
                                } else {
                                    phi_12482_ = (1f - ((-0.265625f - _e2036) % 1f));
                                }
                                let _e2063 = phi_12482_;
                                if (_e2056 > 0f) {
                                    phi_12495_ = (_e2056 % 1f);
                                } else {
                                    phi_12495_ = (1f - ((-0.265625f - _e2037) % 1f));
                                }
                                let _e2070 = phi_12495_;
                                let _e2072 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2063, _e2070), 0f);
                                let _e2078 = (_e1874 - 6372600f);
                                let _e2086 = ((fma(fma(_e2053.x, (1f - _e2034), (_e2072.x * _e2034)), 0.0625f, fma(fma(_e2004.x, (1f - _e1985), (_e2023.x * _e1985)), 0.125f, fma(fma(_e1905.x, (1f - _e1886), (_e1924.x * _e1886)), 0.5f, (fma(_e1953.x, (1f - _e1934), (_e1972.x * _e1934)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e2088 = select(_e2086, 0f, (_e2086 < 0f));
                                let _e2090 = select(_e2088, 1f, (_e2088 > 1f));
                                phi_1604_ = ((((_e2090 * _e2090) * fma(-2f, _e2090, 3f)) * ((1f - exp2((-0.01f * _e2078))) * exp2((-0.004f * _e2078)))) * 0.03f);
                            }
                            let _e2097 = phi_1604_;
                            phi_1605_ = _e2097;
                            phi_1606_ = _e1877;
                        }
                        let _e2099 = phi_1605_;
                        let _e2101 = phi_1606_;
                        phi_1487_ = (_e1863 + select(_e2099, 0f, _e2101));
                    } else {
                        phi_1487_ = f32();
                    }
                    let _e2105 = phi_1487_;
                    continue;
                    continuing {
                        phi_1486_ = _e2105;
                        phi_1489_ = _e1869;
                        break if !(_e1866);
                    }
                }
                let _e2108 = local_14;
                let _e2110 = exp2((_e2108 * -62.5f));
                phi_1663_ = (_e1600 * exp2(-(_e1852)));
                phi_1664_ = fma(_e1586, 0.0625f, _e1604);
                phi_1665_ = fma(_e1587, 0.0625f, _e1606);
                phi_1666_ = fma(_e1588, 0.0625f, _e1608);
                phi_1667_ = fma(((fma((((0.4807763f * _e2110) * _e1859) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e1856) * 3.1415927f), _e1600, _e1610);
                phi_1668_ = fma(((fma((((0.28401393f * _e2110) * _e1859) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e1856) * 3.1415927f), _e1600, _e1612);
                phi_1669_ = fma(((fma((((0.09044314f * _e2110) * _e1859) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e1856) * 3.1415927f), _e1600, _e1614);
            }
            let _e2142 = phi_1663_;
            let _e2144 = phi_1664_;
            let _e2146 = phi_1665_;
            let _e2148 = phi_1666_;
            let _e2150 = phi_1667_;
            let _e2152 = phi_1668_;
            let _e2154 = phi_1669_;
            phi_1324_ = _e2142;
            phi_1329_ = _e2144;
            phi_1331_ = _e2146;
            phi_1333_ = _e2148;
            phi_1335_ = _e2150;
            phi_1337_ = _e2152;
            phi_1339_ = _e2154;
        } else {
            phi_1324_ = f32();
            phi_1329_ = f32();
            phi_1331_ = f32();
            phi_1333_ = f32();
            phi_1335_ = f32();
            phi_1337_ = f32();
            phi_1339_ = f32();
        }
        let _e2156 = phi_1324_;
        let _e2158 = phi_1329_;
        let _e2160 = phi_1331_;
        let _e2162 = phi_1333_;
        let _e2164 = phi_1335_;
        let _e2166 = phi_1337_;
        let _e2168 = phi_1339_;
        continue;
        continuing {
            phi_1323_ = _e2156;
            phi_1326_ = _e1618;
            phi_1328_ = _e2158;
            phi_1330_ = _e2160;
            phi_1332_ = _e2162;
            phi_1334_ = _e2164;
            phi_1336_ = _e2166;
            phi_1338_ = _e2168;
            break if !(_e1615);
        }
    }
    let _e2171 = local_15;
    let _e2173 = local_16;
    let _e2176 = local_17;
    let _e2178 = local_18;
    let _e2181 = local_19;
    let _e2183 = local_20;
    let _e2189 = (sqrt(fma(_e1582, _e1582, fma(_e1580, _e1580, (_e1581 * _e1581)))) * 0.00001f);
    let _e2191 = select(_e2189, 0f, (_e2189 < 0f));
    let _e2193 = select(_e2191, 1f, (_e2191 > 1f));
    let _e2194 = (1f - _e2193);
    let _e2198 = fma(fma(_e1565, _e2171, _e2173), _e2194, (_e1565 * _e2193));
    let _e2199 = fma(fma(_e1566, _e2176, _e2178), _e2194, (_e1566 * _e2193));
    let _e2200 = fma(fma(_e1567, _e2181, _e2183), _e2194, (_e1567 * _e2193));
    if _e274 {
        phi_12569_ = vec2<f32>(-1f, -1f);
    } else {
        phi_12569_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e2205 = phi_12569_;
    if _e283 {
        phi_12609_ = vec2<f32>(-1f, -1f);
    } else {
        phi_12609_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e2211 = phi_12609_;
    let _e2213 = (_e144.x * _e2205.y);
    let _e2214 = (_e144.y * _e2205.y);
    let _e2215 = (_e144.z * _e2205.y);
    let _e2219 = fma(_e296, _e2205.y, (_e144.x + _e2211.y));
    let _e2220 = fma(_e298, _e2205.y, (_e144.y + _e2211.y));
    let _e2221 = fma(_e300, _e2205.y, (_e144.z + _e2211.y));
    let _e2222 = (_e2219 * 0.0625f);
    let _e2223 = (_e2220 * 0.0625f);
    let _e2224 = (_e2221 * 0.0625f);
    phi_1777_ = 1f;
    phi_1780_ = 0u;
    phi_1782_ = fma(_e2222, _e181, _e2213);
    phi_1784_ = fma(_e2223, _e181, _e2214);
    phi_1786_ = fma(_e2224, _e181, _e2215);
    phi_1788_ = 0f;
    phi_1790_ = 0f;
    phi_1792_ = 0f;
    loop {
        let _e2233 = phi_1777_;
        let _e2235 = phi_1780_;
        let _e2237 = phi_1782_;
        let _e2239 = phi_1784_;
        let _e2241 = phi_1786_;
        let _e2243 = phi_1788_;
        let _e2245 = phi_1790_;
        let _e2247 = phi_1792_;
        local_22 = _e2233;
        local_23 = _e2243;
        local_24 = _e2233;
        local_25 = _e2245;
        local_26 = _e2233;
        local_27 = _e2247;
        let _e2248 = (_e2235 < 16u);
        if _e2248 {
            phi_1781_ = (_e2235 + 1u);
        } else {
            phi_1781_ = _e2235;
        }
        let _e2251 = phi_1781_;
        if _e2248 {
            let _e2252 = (_e2239 + 6371000f);
            let _e2256 = sqrt(fma(_e2241, _e2241, fma(_e2237, _e2237, (_e2252 * _e2252))));
            let _e2257 = (_e2256 - 6371000f);
            if (_e2257 < 1600f) {
                phi_1908_ = f32();
                phi_1909_ = true;
            } else {
                let _e2259 = (_e2257 > 2100f);
                if _e2259 {
                    phi_1907_ = f32();
                } else {
                    let _e2263 = global_2.member.member[0u];
                    let _e2264 = (_e2263 * 0.02f);
                    let _e2265 = fma(_e2237, 0.001f, _e2264);
                    let _e2266 = fma(_e2241, 0.001f, _e2264);
                    let _e2267 = floor(_e2266);
                    let _e2268 = (_e2266 - _e2267);
                    let _e2269 = (_e2267 * 0.265625f);
                    let _e2270 = fma(_e2265, 0.015625f, _e2269);
                    let _e2271 = fma(_e2257, 0.000015625f, _e2269);
                    if (_e2270 > 0f) {
                        phi_12834_ = (_e2270 % 1f);
                    } else {
                        phi_12834_ = (1f - (-(_e2270) % 1f));
                    }
                    let _e2278 = phi_12834_;
                    if (_e2271 > 0f) {
                        phi_12847_ = (_e2271 % 1f);
                    } else {
                        phi_12847_ = (1f - (-(_e2271) % 1f));
                    }
                    let _e2285 = phi_12847_;
                    let _e2287 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2278, _e2285), 0f);
                    let _e2289 = (_e2270 + 0.265625f);
                    let _e2290 = (_e2271 + 0.265625f);
                    if (_e2289 > 0f) {
                        phi_12877_ = (_e2289 % 1f);
                    } else {
                        phi_12877_ = (1f - ((-0.265625f - _e2270) % 1f));
                    }
                    let _e2297 = phi_12877_;
                    if (_e2290 > 0f) {
                        phi_12890_ = (_e2290 % 1f);
                    } else {
                        phi_12890_ = (1f - ((-0.265625f - _e2271) % 1f));
                    }
                    let _e2304 = phi_12890_;
                    let _e2306 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2297, _e2304), 0f);
                    let _e2311 = fma(_e2263, 0.02f, 2f);
                    let _e2314 = floor((_e2266 * _e2311));
                    let _e2316 = fma(_e2266, _e2311, -(_e2314));
                    let _e2317 = (_e2314 * 0.265625f);
                    let _e2318 = fma((_e2265 * _e2311), 0.015625f, _e2317);
                    let _e2319 = fma(_e2257, 0.00003125f, _e2317);
                    if (_e2318 > 0f) {
                        phi_12950_ = (_e2318 % 1f);
                    } else {
                        phi_12950_ = (1f - (-(_e2318) % 1f));
                    }
                    let _e2326 = phi_12950_;
                    if (_e2319 > 0f) {
                        phi_12963_ = (_e2319 % 1f);
                    } else {
                        phi_12963_ = (1f - (-(_e2319) % 1f));
                    }
                    let _e2333 = phi_12963_;
                    let _e2335 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2326, _e2333), 0f);
                    let _e2337 = (_e2318 + 0.265625f);
                    let _e2338 = (_e2319 + 0.265625f);
                    if (_e2337 > 0f) {
                        phi_12993_ = (_e2337 % 1f);
                    } else {
                        phi_12993_ = (1f - ((-0.265625f - _e2318) % 1f));
                    }
                    let _e2345 = phi_12993_;
                    if (_e2338 > 0f) {
                        phi_13006_ = (_e2338 % 1f);
                    } else {
                        phi_13006_ = (1f - ((-0.265625f - _e2319) % 1f));
                    }
                    let _e2352 = phi_13006_;
                    let _e2354 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2345, _e2352), 0f);
                    let _e2362 = fma(-(_e2263), 0.02f, 7f);
                    let _e2365 = floor((_e2266 * _e2362));
                    let _e2367 = fma(_e2266, _e2362, -(_e2365));
                    let _e2368 = (_e2365 * 0.265625f);
                    let _e2369 = fma((_e2265 * _e2362), 0.015625f, _e2368);
                    let _e2370 = fma(_e2257, 0.000109375f, _e2368);
                    if (_e2369 > 0f) {
                        phi_13066_ = (_e2369 % 1f);
                    } else {
                        phi_13066_ = (1f - (-(_e2369) % 1f));
                    }
                    let _e2377 = phi_13066_;
                    if (_e2370 > 0f) {
                        phi_13079_ = (_e2370 % 1f);
                    } else {
                        phi_13079_ = (1f - (-(_e2370) % 1f));
                    }
                    let _e2384 = phi_13079_;
                    let _e2386 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2377, _e2384), 0f);
                    let _e2388 = (_e2369 + 0.265625f);
                    let _e2389 = (_e2370 + 0.265625f);
                    if (_e2388 > 0f) {
                        phi_13109_ = (_e2388 % 1f);
                    } else {
                        phi_13109_ = (1f - ((-0.265625f - _e2369) % 1f));
                    }
                    let _e2396 = phi_13109_;
                    if (_e2389 > 0f) {
                        phi_13122_ = (_e2389 % 1f);
                    } else {
                        phi_13122_ = (1f - ((-0.265625f - _e2370) % 1f));
                    }
                    let _e2403 = phi_13122_;
                    let _e2405 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2396, _e2403), 0f);
                    let _e2412 = fma(_e2263, 0.02f, _e2266);
                    let _e2414 = floor((_e2412 * 16f));
                    let _e2416 = fma(_e2412, 16f, -(_e2414));
                    let _e2417 = (_e2414 * 0.265625f);
                    let _e2418 = fma(fma(_e2263, 0.02f, _e2265), 0.25f, _e2417);
                    let _e2419 = fma(_e2257, 0.00025f, _e2417);
                    if (_e2418 > 0f) {
                        phi_13182_ = (_e2418 % 1f);
                    } else {
                        phi_13182_ = (1f - (-(_e2418) % 1f));
                    }
                    let _e2426 = phi_13182_;
                    if (_e2419 > 0f) {
                        phi_13195_ = (_e2419 % 1f);
                    } else {
                        phi_13195_ = (1f - (-(_e2419) % 1f));
                    }
                    let _e2433 = phi_13195_;
                    let _e2435 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2426, _e2433), 0f);
                    let _e2437 = (_e2418 + 0.265625f);
                    let _e2438 = (_e2419 + 0.265625f);
                    if (_e2437 > 0f) {
                        phi_13225_ = (_e2437 % 1f);
                    } else {
                        phi_13225_ = (1f - ((-0.265625f - _e2418) % 1f));
                    }
                    let _e2445 = phi_13225_;
                    if (_e2438 > 0f) {
                        phi_13238_ = (_e2438 % 1f);
                    } else {
                        phi_13238_ = (1f - ((-0.265625f - _e2419) % 1f));
                    }
                    let _e2452 = phi_13238_;
                    let _e2454 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2445, _e2452), 0f);
                    let _e2460 = (_e2256 - 6372600f);
                    let _e2468 = ((fma(fma(_e2435.x, (1f - _e2416), (_e2454.x * _e2416)), 0.0625f, fma(fma(_e2386.x, (1f - _e2367), (_e2405.x * _e2367)), 0.125f, fma(fma(_e2287.x, (1f - _e2268), (_e2306.x * _e2268)), 0.5f, (fma(_e2335.x, (1f - _e2316), (_e2354.x * _e2316)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e2470 = select(_e2468, 0f, (_e2468 < 0f));
                    let _e2472 = select(_e2470, 1f, (_e2470 > 1f));
                    phi_1907_ = ((((_e2472 * _e2472) * fma(-2f, _e2472, 3f)) * ((1f - exp2((-0.01f * _e2460))) * exp2((-0.004f * _e2460)))) * 0.03f);
                }
                let _e2479 = phi_1907_;
                phi_1908_ = _e2479;
                phi_1909_ = _e2259;
            }
            let _e2481 = phi_1908_;
            let _e2483 = phi_1909_;
            let _e2485 = (select(_e2481, 0f, _e2483) * sqrt(fma(_e2224, _e2224, fma(_e2222, _e2222, (_e2223 * _e2223)))));
            if (_e2485 <= 0f) {
                phi_2117_ = _e2233;
                phi_2118_ = _e2237;
                phi_2119_ = _e2239;
                phi_2120_ = _e2241;
                phi_2121_ = _e2243;
                phi_2122_ = _e2245;
                phi_2123_ = _e2247;
            } else {
                let _e2489 = fma(exp2((-1.6013916f * _e2485)), -0.9009009f, 0.9009009f);
                let _e2492 = (1f - exp2((_e2485 * -1.3862944f)));
                let _e2493 = (-9.537895f + _e2237);
                let _e2494 = (29.354609f + _e2241);
                phi_1940_ = 0f;
                phi_1943_ = 0u;
                loop {
                    let _e2496 = phi_1940_;
                    let _e2498 = phi_1943_;
                    local_21 = _e2496;
                    let _e2499 = (_e2498 < 8u);
                    if _e2499 {
                        phi_1944_ = (_e2498 + 1u);
                    } else {
                        phi_1944_ = _e2498;
                    }
                    let _e2502 = phi_1944_;
                    if _e2499 {
                        let _e2503 = (_e2239 + 6371005f);
                        let _e2507 = sqrt(fma(_e2494, _e2494, fma(_e2493, _e2493, (_e2503 * _e2503))));
                        let _e2508 = (_e2507 - 6371000f);
                        if (_e2508 < 1600f) {
                            phi_2059_ = f32();
                            phi_2060_ = true;
                        } else {
                            let _e2510 = (_e2508 > 2100f);
                            if _e2510 {
                                phi_2058_ = f32();
                            } else {
                                let _e2514 = global_2.member.member[0u];
                                let _e2515 = (_e2514 * 0.02f);
                                let _e2516 = fma(_e2493, 0.001f, _e2515);
                                let _e2517 = fma(_e2494, 0.001f, _e2515);
                                let _e2518 = floor(_e2517);
                                let _e2519 = (_e2517 - _e2518);
                                let _e2520 = (_e2518 * 0.265625f);
                                let _e2521 = fma(_e2516, 0.015625f, _e2520);
                                let _e2522 = fma(_e2508, 0.000015625f, _e2520);
                                if (_e2521 > 0f) {
                                    phi_13314_ = (_e2521 % 1f);
                                } else {
                                    phi_13314_ = (1f - (-(_e2521) % 1f));
                                }
                                let _e2529 = phi_13314_;
                                if (_e2522 > 0f) {
                                    phi_13327_ = (_e2522 % 1f);
                                } else {
                                    phi_13327_ = (1f - (-(_e2522) % 1f));
                                }
                                let _e2536 = phi_13327_;
                                let _e2538 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2529, _e2536), 0f);
                                let _e2540 = (_e2521 + 0.265625f);
                                let _e2541 = (_e2522 + 0.265625f);
                                if (_e2540 > 0f) {
                                    phi_13357_ = (_e2540 % 1f);
                                } else {
                                    phi_13357_ = (1f - ((-0.265625f - _e2521) % 1f));
                                }
                                let _e2548 = phi_13357_;
                                if (_e2541 > 0f) {
                                    phi_13370_ = (_e2541 % 1f);
                                } else {
                                    phi_13370_ = (1f - ((-0.265625f - _e2522) % 1f));
                                }
                                let _e2555 = phi_13370_;
                                let _e2557 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2548, _e2555), 0f);
                                let _e2562 = fma(_e2514, 0.02f, 2f);
                                let _e2565 = floor((_e2517 * _e2562));
                                let _e2567 = fma(_e2517, _e2562, -(_e2565));
                                let _e2568 = (_e2565 * 0.265625f);
                                let _e2569 = fma((_e2516 * _e2562), 0.015625f, _e2568);
                                let _e2570 = fma(_e2508, 0.00003125f, _e2568);
                                if (_e2569 > 0f) {
                                    phi_13430_ = (_e2569 % 1f);
                                } else {
                                    phi_13430_ = (1f - (-(_e2569) % 1f));
                                }
                                let _e2577 = phi_13430_;
                                if (_e2570 > 0f) {
                                    phi_13443_ = (_e2570 % 1f);
                                } else {
                                    phi_13443_ = (1f - (-(_e2570) % 1f));
                                }
                                let _e2584 = phi_13443_;
                                let _e2586 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2577, _e2584), 0f);
                                let _e2588 = (_e2569 + 0.265625f);
                                let _e2589 = (_e2570 + 0.265625f);
                                if (_e2588 > 0f) {
                                    phi_13473_ = (_e2588 % 1f);
                                } else {
                                    phi_13473_ = (1f - ((-0.265625f - _e2569) % 1f));
                                }
                                let _e2596 = phi_13473_;
                                if (_e2589 > 0f) {
                                    phi_13486_ = (_e2589 % 1f);
                                } else {
                                    phi_13486_ = (1f - ((-0.265625f - _e2570) % 1f));
                                }
                                let _e2603 = phi_13486_;
                                let _e2605 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2596, _e2603), 0f);
                                let _e2613 = fma(-(_e2514), 0.02f, 7f);
                                let _e2616 = floor((_e2517 * _e2613));
                                let _e2618 = fma(_e2517, _e2613, -(_e2616));
                                let _e2619 = (_e2616 * 0.265625f);
                                let _e2620 = fma((_e2516 * _e2613), 0.015625f, _e2619);
                                let _e2621 = fma(_e2508, 0.000109375f, _e2619);
                                if (_e2620 > 0f) {
                                    phi_13546_ = (_e2620 % 1f);
                                } else {
                                    phi_13546_ = (1f - (-(_e2620) % 1f));
                                }
                                let _e2628 = phi_13546_;
                                if (_e2621 > 0f) {
                                    phi_13559_ = (_e2621 % 1f);
                                } else {
                                    phi_13559_ = (1f - (-(_e2621) % 1f));
                                }
                                let _e2635 = phi_13559_;
                                let _e2637 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2628, _e2635), 0f);
                                let _e2639 = (_e2620 + 0.265625f);
                                let _e2640 = (_e2621 + 0.265625f);
                                if (_e2639 > 0f) {
                                    phi_13589_ = (_e2639 % 1f);
                                } else {
                                    phi_13589_ = (1f - ((-0.265625f - _e2620) % 1f));
                                }
                                let _e2647 = phi_13589_;
                                if (_e2640 > 0f) {
                                    phi_13602_ = (_e2640 % 1f);
                                } else {
                                    phi_13602_ = (1f - ((-0.265625f - _e2621) % 1f));
                                }
                                let _e2654 = phi_13602_;
                                let _e2656 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2647, _e2654), 0f);
                                let _e2663 = fma(_e2514, 0.02f, _e2517);
                                let _e2665 = floor((_e2663 * 16f));
                                let _e2667 = fma(_e2663, 16f, -(_e2665));
                                let _e2668 = (_e2665 * 0.265625f);
                                let _e2669 = fma(fma(_e2514, 0.02f, _e2516), 0.25f, _e2668);
                                let _e2670 = fma(_e2508, 0.00025f, _e2668);
                                if (_e2669 > 0f) {
                                    phi_13662_ = (_e2669 % 1f);
                                } else {
                                    phi_13662_ = (1f - (-(_e2669) % 1f));
                                }
                                let _e2677 = phi_13662_;
                                if (_e2670 > 0f) {
                                    phi_13675_ = (_e2670 % 1f);
                                } else {
                                    phi_13675_ = (1f - (-(_e2670) % 1f));
                                }
                                let _e2684 = phi_13675_;
                                let _e2686 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2677, _e2684), 0f);
                                let _e2688 = (_e2669 + 0.265625f);
                                let _e2689 = (_e2670 + 0.265625f);
                                if (_e2688 > 0f) {
                                    phi_13705_ = (_e2688 % 1f);
                                } else {
                                    phi_13705_ = (1f - ((-0.265625f - _e2669) % 1f));
                                }
                                let _e2696 = phi_13705_;
                                if (_e2689 > 0f) {
                                    phi_13718_ = (_e2689 % 1f);
                                } else {
                                    phi_13718_ = (1f - ((-0.265625f - _e2670) % 1f));
                                }
                                let _e2703 = phi_13718_;
                                let _e2705 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2696, _e2703), 0f);
                                let _e2711 = (_e2507 - 6372600f);
                                let _e2719 = ((fma(fma(_e2686.x, (1f - _e2667), (_e2705.x * _e2667)), 0.0625f, fma(fma(_e2637.x, (1f - _e2618), (_e2656.x * _e2618)), 0.125f, fma(fma(_e2538.x, (1f - _e2519), (_e2557.x * _e2519)), 0.5f, (fma(_e2586.x, (1f - _e2567), (_e2605.x * _e2567)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e2721 = select(_e2719, 0f, (_e2719 < 0f));
                                let _e2723 = select(_e2721, 1f, (_e2721 > 1f));
                                phi_2058_ = ((((_e2723 * _e2723) * fma(-2f, _e2723, 3f)) * ((1f - exp2((-0.01f * _e2711))) * exp2((-0.004f * _e2711)))) * 0.03f);
                            }
                            let _e2730 = phi_2058_;
                            phi_2059_ = _e2730;
                            phi_2060_ = _e2510;
                        }
                        let _e2732 = phi_2059_;
                        let _e2734 = phi_2060_;
                        phi_1941_ = (_e2496 + select(_e2732, 0f, _e2734));
                    } else {
                        phi_1941_ = f32();
                    }
                    let _e2738 = phi_1941_;
                    continue;
                    continuing {
                        phi_1940_ = _e2738;
                        phi_1943_ = _e2502;
                        break if !(_e2499);
                    }
                }
                let _e2741 = local_21;
                let _e2743 = exp2((_e2741 * -62.5f));
                phi_2117_ = (_e2233 * exp2(-(_e2485)));
                phi_2118_ = fma(_e2219, 0.0625f, _e2237);
                phi_2119_ = fma(_e2220, 0.0625f, _e2239);
                phi_2120_ = fma(_e2221, 0.0625f, _e2241);
                phi_2121_ = fma(((fma((((0.4807763f * _e2743) * _e2492) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e2489) * 3.1415927f), _e2233, _e2243);
                phi_2122_ = fma(((fma((((0.28401393f * _e2743) * _e2492) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e2489) * 3.1415927f), _e2233, _e2245);
                phi_2123_ = fma(((fma((((0.09044314f * _e2743) * _e2492) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e2489) * 3.1415927f), _e2233, _e2247);
            }
            let _e2775 = phi_2117_;
            let _e2777 = phi_2118_;
            let _e2779 = phi_2119_;
            let _e2781 = phi_2120_;
            let _e2783 = phi_2121_;
            let _e2785 = phi_2122_;
            let _e2787 = phi_2123_;
            phi_1778_ = _e2775;
            phi_1783_ = _e2777;
            phi_1785_ = _e2779;
            phi_1787_ = _e2781;
            phi_1789_ = _e2783;
            phi_1791_ = _e2785;
            phi_1793_ = _e2787;
        } else {
            phi_1778_ = f32();
            phi_1783_ = f32();
            phi_1785_ = f32();
            phi_1787_ = f32();
            phi_1789_ = f32();
            phi_1791_ = f32();
            phi_1793_ = f32();
        }
        let _e2789 = phi_1778_;
        let _e2791 = phi_1783_;
        let _e2793 = phi_1785_;
        let _e2795 = phi_1787_;
        let _e2797 = phi_1789_;
        let _e2799 = phi_1791_;
        let _e2801 = phi_1793_;
        continue;
        continuing {
            phi_1777_ = _e2789;
            phi_1780_ = _e2251;
            phi_1782_ = _e2791;
            phi_1784_ = _e2793;
            phi_1786_ = _e2795;
            phi_1788_ = _e2797;
            phi_1790_ = _e2799;
            phi_1792_ = _e2801;
            break if !(_e2248);
        }
    }
    let _e2804 = local_22;
    let _e2806 = local_23;
    let _e2809 = local_24;
    let _e2811 = local_25;
    let _e2814 = local_26;
    let _e2816 = local_27;
    let _e2822 = (sqrt(fma(_e2215, _e2215, fma(_e2213, _e2213, (_e2214 * _e2214)))) * 0.00001f);
    let _e2824 = select(_e2822, 0f, (_e2822 < 0f));
    let _e2826 = select(_e2824, 1f, (_e2824 > 1f));
    let _e2827 = (1f - _e2826);
    let _e2831 = fma(fma(_e2198, _e2804, _e2806), _e2827, (_e2198 * _e2826));
    let _e2832 = fma(fma(_e2199, _e2809, _e2811), _e2827, (_e2199 * _e2826));
    let _e2833 = fma(fma(_e2200, _e2814, _e2816), _e2827, (_e2200 * _e2826));
    if _e274 {
        phi_13792_ = vec2<f32>(-1f, -1f);
    } else {
        phi_13792_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e2838 = phi_13792_;
    if _e283 {
        phi_13832_ = vec2<f32>(-1f, -1f);
    } else {
        phi_13832_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e2844 = phi_13832_;
    let _e2846 = (_e144.x * _e2838.y);
    let _e2847 = (_e144.y * _e2838.y);
    let _e2848 = (_e144.z * _e2838.y);
    let _e2852 = fma(_e296, _e2838.y, (_e144.x + _e2844.y));
    let _e2853 = fma(_e298, _e2838.y, (_e144.y + _e2844.y));
    let _e2854 = fma(_e300, _e2838.y, (_e144.z + _e2844.y));
    let _e2855 = (_e2852 * 0.0625f);
    let _e2856 = (_e2853 * 0.0625f);
    let _e2857 = (_e2854 * 0.0625f);
    phi_2231_ = 1f;
    phi_2234_ = 0u;
    phi_2236_ = fma(_e2855, _e181, _e2846);
    phi_2238_ = fma(_e2856, _e181, _e2847);
    phi_2240_ = fma(_e2857, _e181, _e2848);
    phi_2242_ = 0f;
    phi_2244_ = 0f;
    phi_2246_ = 0f;
    loop {
        let _e2866 = phi_2231_;
        let _e2868 = phi_2234_;
        let _e2870 = phi_2236_;
        let _e2872 = phi_2238_;
        let _e2874 = phi_2240_;
        let _e2876 = phi_2242_;
        let _e2878 = phi_2244_;
        let _e2880 = phi_2246_;
        local_29 = _e2866;
        local_30 = _e2876;
        local_31 = _e2866;
        local_32 = _e2878;
        local_33 = _e2866;
        local_34 = _e2880;
        let _e2881 = (_e2868 < 16u);
        if _e2881 {
            phi_2235_ = (_e2868 + 1u);
        } else {
            phi_2235_ = _e2868;
        }
        let _e2884 = phi_2235_;
        if _e2881 {
            let _e2885 = (_e2872 + 6371000f);
            let _e2889 = sqrt(fma(_e2874, _e2874, fma(_e2870, _e2870, (_e2885 * _e2885))));
            let _e2890 = (_e2889 - 6371000f);
            if (_e2890 < 1600f) {
                phi_2362_ = f32();
                phi_2363_ = true;
            } else {
                let _e2892 = (_e2890 > 2100f);
                if _e2892 {
                    phi_2361_ = f32();
                } else {
                    let _e2896 = global_2.member.member[0u];
                    let _e2897 = (_e2896 * 0.02f);
                    let _e2898 = fma(_e2870, 0.001f, _e2897);
                    let _e2899 = fma(_e2874, 0.001f, _e2897);
                    let _e2900 = floor(_e2899);
                    let _e2901 = (_e2899 - _e2900);
                    let _e2902 = (_e2900 * 0.265625f);
                    let _e2903 = fma(_e2898, 0.015625f, _e2902);
                    let _e2904 = fma(_e2890, 0.000015625f, _e2902);
                    if (_e2903 > 0f) {
                        phi_14057_ = (_e2903 % 1f);
                    } else {
                        phi_14057_ = (1f - (-(_e2903) % 1f));
                    }
                    let _e2911 = phi_14057_;
                    if (_e2904 > 0f) {
                        phi_14070_ = (_e2904 % 1f);
                    } else {
                        phi_14070_ = (1f - (-(_e2904) % 1f));
                    }
                    let _e2918 = phi_14070_;
                    let _e2920 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2911, _e2918), 0f);
                    let _e2922 = (_e2903 + 0.265625f);
                    let _e2923 = (_e2904 + 0.265625f);
                    if (_e2922 > 0f) {
                        phi_14100_ = (_e2922 % 1f);
                    } else {
                        phi_14100_ = (1f - ((-0.265625f - _e2903) % 1f));
                    }
                    let _e2930 = phi_14100_;
                    if (_e2923 > 0f) {
                        phi_14113_ = (_e2923 % 1f);
                    } else {
                        phi_14113_ = (1f - ((-0.265625f - _e2904) % 1f));
                    }
                    let _e2937 = phi_14113_;
                    let _e2939 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2930, _e2937), 0f);
                    let _e2944 = fma(_e2896, 0.02f, 2f);
                    let _e2947 = floor((_e2899 * _e2944));
                    let _e2949 = fma(_e2899, _e2944, -(_e2947));
                    let _e2950 = (_e2947 * 0.265625f);
                    let _e2951 = fma((_e2898 * _e2944), 0.015625f, _e2950);
                    let _e2952 = fma(_e2890, 0.00003125f, _e2950);
                    if (_e2951 > 0f) {
                        phi_14173_ = (_e2951 % 1f);
                    } else {
                        phi_14173_ = (1f - (-(_e2951) % 1f));
                    }
                    let _e2959 = phi_14173_;
                    if (_e2952 > 0f) {
                        phi_14186_ = (_e2952 % 1f);
                    } else {
                        phi_14186_ = (1f - (-(_e2952) % 1f));
                    }
                    let _e2966 = phi_14186_;
                    let _e2968 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2959, _e2966), 0f);
                    let _e2970 = (_e2951 + 0.265625f);
                    let _e2971 = (_e2952 + 0.265625f);
                    if (_e2970 > 0f) {
                        phi_14216_ = (_e2970 % 1f);
                    } else {
                        phi_14216_ = (1f - ((-0.265625f - _e2951) % 1f));
                    }
                    let _e2978 = phi_14216_;
                    if (_e2971 > 0f) {
                        phi_14229_ = (_e2971 % 1f);
                    } else {
                        phi_14229_ = (1f - ((-0.265625f - _e2952) % 1f));
                    }
                    let _e2985 = phi_14229_;
                    let _e2987 = textureSampleLevel(global_3, global_4, vec2<f32>(_e2978, _e2985), 0f);
                    let _e2995 = fma(-(_e2896), 0.02f, 7f);
                    let _e2998 = floor((_e2899 * _e2995));
                    let _e3000 = fma(_e2899, _e2995, -(_e2998));
                    let _e3001 = (_e2998 * 0.265625f);
                    let _e3002 = fma((_e2898 * _e2995), 0.015625f, _e3001);
                    let _e3003 = fma(_e2890, 0.000109375f, _e3001);
                    if (_e3002 > 0f) {
                        phi_14289_ = (_e3002 % 1f);
                    } else {
                        phi_14289_ = (1f - (-(_e3002) % 1f));
                    }
                    let _e3010 = phi_14289_;
                    if (_e3003 > 0f) {
                        phi_14302_ = (_e3003 % 1f);
                    } else {
                        phi_14302_ = (1f - (-(_e3003) % 1f));
                    }
                    let _e3017 = phi_14302_;
                    let _e3019 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3010, _e3017), 0f);
                    let _e3021 = (_e3002 + 0.265625f);
                    let _e3022 = (_e3003 + 0.265625f);
                    if (_e3021 > 0f) {
                        phi_14332_ = (_e3021 % 1f);
                    } else {
                        phi_14332_ = (1f - ((-0.265625f - _e3002) % 1f));
                    }
                    let _e3029 = phi_14332_;
                    if (_e3022 > 0f) {
                        phi_14345_ = (_e3022 % 1f);
                    } else {
                        phi_14345_ = (1f - ((-0.265625f - _e3003) % 1f));
                    }
                    let _e3036 = phi_14345_;
                    let _e3038 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3029, _e3036), 0f);
                    let _e3045 = fma(_e2896, 0.02f, _e2899);
                    let _e3047 = floor((_e3045 * 16f));
                    let _e3049 = fma(_e3045, 16f, -(_e3047));
                    let _e3050 = (_e3047 * 0.265625f);
                    let _e3051 = fma(fma(_e2896, 0.02f, _e2898), 0.25f, _e3050);
                    let _e3052 = fma(_e2890, 0.00025f, _e3050);
                    if (_e3051 > 0f) {
                        phi_14405_ = (_e3051 % 1f);
                    } else {
                        phi_14405_ = (1f - (-(_e3051) % 1f));
                    }
                    let _e3059 = phi_14405_;
                    if (_e3052 > 0f) {
                        phi_14418_ = (_e3052 % 1f);
                    } else {
                        phi_14418_ = (1f - (-(_e3052) % 1f));
                    }
                    let _e3066 = phi_14418_;
                    let _e3068 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3059, _e3066), 0f);
                    let _e3070 = (_e3051 + 0.265625f);
                    let _e3071 = (_e3052 + 0.265625f);
                    if (_e3070 > 0f) {
                        phi_14448_ = (_e3070 % 1f);
                    } else {
                        phi_14448_ = (1f - ((-0.265625f - _e3051) % 1f));
                    }
                    let _e3078 = phi_14448_;
                    if (_e3071 > 0f) {
                        phi_14461_ = (_e3071 % 1f);
                    } else {
                        phi_14461_ = (1f - ((-0.265625f - _e3052) % 1f));
                    }
                    let _e3085 = phi_14461_;
                    let _e3087 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3078, _e3085), 0f);
                    let _e3093 = (_e2889 - 6372600f);
                    let _e3101 = ((fma(fma(_e3068.x, (1f - _e3049), (_e3087.x * _e3049)), 0.0625f, fma(fma(_e3019.x, (1f - _e3000), (_e3038.x * _e3000)), 0.125f, fma(fma(_e2920.x, (1f - _e2901), (_e2939.x * _e2901)), 0.5f, (fma(_e2968.x, (1f - _e2949), (_e2987.x * _e2949)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e3103 = select(_e3101, 0f, (_e3101 < 0f));
                    let _e3105 = select(_e3103, 1f, (_e3103 > 1f));
                    phi_2361_ = ((((_e3105 * _e3105) * fma(-2f, _e3105, 3f)) * ((1f - exp2((-0.01f * _e3093))) * exp2((-0.004f * _e3093)))) * 0.03f);
                }
                let _e3112 = phi_2361_;
                phi_2362_ = _e3112;
                phi_2363_ = _e2892;
            }
            let _e3114 = phi_2362_;
            let _e3116 = phi_2363_;
            let _e3118 = (select(_e3114, 0f, _e3116) * sqrt(fma(_e2857, _e2857, fma(_e2855, _e2855, (_e2856 * _e2856)))));
            if (_e3118 <= 0f) {
                phi_2571_ = _e2866;
                phi_2572_ = _e2870;
                phi_2573_ = _e2872;
                phi_2574_ = _e2874;
                phi_2575_ = _e2876;
                phi_2576_ = _e2878;
                phi_2577_ = _e2880;
            } else {
                let _e3122 = fma(exp2((-1.6013916f * _e3118)), -0.9009009f, 0.9009009f);
                let _e3125 = (1f - exp2((_e3118 * -1.3862944f)));
                let _e3126 = (-9.537895f + _e2870);
                let _e3127 = (29.354609f + _e2874);
                phi_2394_ = 0f;
                phi_2397_ = 0u;
                loop {
                    let _e3129 = phi_2394_;
                    let _e3131 = phi_2397_;
                    local_28 = _e3129;
                    let _e3132 = (_e3131 < 8u);
                    if _e3132 {
                        phi_2398_ = (_e3131 + 1u);
                    } else {
                        phi_2398_ = _e3131;
                    }
                    let _e3135 = phi_2398_;
                    if _e3132 {
                        let _e3136 = (_e2872 + 6371005f);
                        let _e3140 = sqrt(fma(_e3127, _e3127, fma(_e3126, _e3126, (_e3136 * _e3136))));
                        let _e3141 = (_e3140 - 6371000f);
                        if (_e3141 < 1600f) {
                            phi_2513_ = f32();
                            phi_2514_ = true;
                        } else {
                            let _e3143 = (_e3141 > 2100f);
                            if _e3143 {
                                phi_2512_ = f32();
                            } else {
                                let _e3147 = global_2.member.member[0u];
                                let _e3148 = (_e3147 * 0.02f);
                                let _e3149 = fma(_e3126, 0.001f, _e3148);
                                let _e3150 = fma(_e3127, 0.001f, _e3148);
                                let _e3151 = floor(_e3150);
                                let _e3152 = (_e3150 - _e3151);
                                let _e3153 = (_e3151 * 0.265625f);
                                let _e3154 = fma(_e3149, 0.015625f, _e3153);
                                let _e3155 = fma(_e3141, 0.000015625f, _e3153);
                                if (_e3154 > 0f) {
                                    phi_14537_ = (_e3154 % 1f);
                                } else {
                                    phi_14537_ = (1f - (-(_e3154) % 1f));
                                }
                                let _e3162 = phi_14537_;
                                if (_e3155 > 0f) {
                                    phi_14550_ = (_e3155 % 1f);
                                } else {
                                    phi_14550_ = (1f - (-(_e3155) % 1f));
                                }
                                let _e3169 = phi_14550_;
                                let _e3171 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3162, _e3169), 0f);
                                let _e3173 = (_e3154 + 0.265625f);
                                let _e3174 = (_e3155 + 0.265625f);
                                if (_e3173 > 0f) {
                                    phi_14580_ = (_e3173 % 1f);
                                } else {
                                    phi_14580_ = (1f - ((-0.265625f - _e3154) % 1f));
                                }
                                let _e3181 = phi_14580_;
                                if (_e3174 > 0f) {
                                    phi_14593_ = (_e3174 % 1f);
                                } else {
                                    phi_14593_ = (1f - ((-0.265625f - _e3155) % 1f));
                                }
                                let _e3188 = phi_14593_;
                                let _e3190 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3181, _e3188), 0f);
                                let _e3195 = fma(_e3147, 0.02f, 2f);
                                let _e3198 = floor((_e3150 * _e3195));
                                let _e3200 = fma(_e3150, _e3195, -(_e3198));
                                let _e3201 = (_e3198 * 0.265625f);
                                let _e3202 = fma((_e3149 * _e3195), 0.015625f, _e3201);
                                let _e3203 = fma(_e3141, 0.00003125f, _e3201);
                                if (_e3202 > 0f) {
                                    phi_14653_ = (_e3202 % 1f);
                                } else {
                                    phi_14653_ = (1f - (-(_e3202) % 1f));
                                }
                                let _e3210 = phi_14653_;
                                if (_e3203 > 0f) {
                                    phi_14666_ = (_e3203 % 1f);
                                } else {
                                    phi_14666_ = (1f - (-(_e3203) % 1f));
                                }
                                let _e3217 = phi_14666_;
                                let _e3219 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3210, _e3217), 0f);
                                let _e3221 = (_e3202 + 0.265625f);
                                let _e3222 = (_e3203 + 0.265625f);
                                if (_e3221 > 0f) {
                                    phi_14696_ = (_e3221 % 1f);
                                } else {
                                    phi_14696_ = (1f - ((-0.265625f - _e3202) % 1f));
                                }
                                let _e3229 = phi_14696_;
                                if (_e3222 > 0f) {
                                    phi_14709_ = (_e3222 % 1f);
                                } else {
                                    phi_14709_ = (1f - ((-0.265625f - _e3203) % 1f));
                                }
                                let _e3236 = phi_14709_;
                                let _e3238 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3229, _e3236), 0f);
                                let _e3246 = fma(-(_e3147), 0.02f, 7f);
                                let _e3249 = floor((_e3150 * _e3246));
                                let _e3251 = fma(_e3150, _e3246, -(_e3249));
                                let _e3252 = (_e3249 * 0.265625f);
                                let _e3253 = fma((_e3149 * _e3246), 0.015625f, _e3252);
                                let _e3254 = fma(_e3141, 0.000109375f, _e3252);
                                if (_e3253 > 0f) {
                                    phi_14769_ = (_e3253 % 1f);
                                } else {
                                    phi_14769_ = (1f - (-(_e3253) % 1f));
                                }
                                let _e3261 = phi_14769_;
                                if (_e3254 > 0f) {
                                    phi_14782_ = (_e3254 % 1f);
                                } else {
                                    phi_14782_ = (1f - (-(_e3254) % 1f));
                                }
                                let _e3268 = phi_14782_;
                                let _e3270 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3261, _e3268), 0f);
                                let _e3272 = (_e3253 + 0.265625f);
                                let _e3273 = (_e3254 + 0.265625f);
                                if (_e3272 > 0f) {
                                    phi_14812_ = (_e3272 % 1f);
                                } else {
                                    phi_14812_ = (1f - ((-0.265625f - _e3253) % 1f));
                                }
                                let _e3280 = phi_14812_;
                                if (_e3273 > 0f) {
                                    phi_14825_ = (_e3273 % 1f);
                                } else {
                                    phi_14825_ = (1f - ((-0.265625f - _e3254) % 1f));
                                }
                                let _e3287 = phi_14825_;
                                let _e3289 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3280, _e3287), 0f);
                                let _e3296 = fma(_e3147, 0.02f, _e3150);
                                let _e3298 = floor((_e3296 * 16f));
                                let _e3300 = fma(_e3296, 16f, -(_e3298));
                                let _e3301 = (_e3298 * 0.265625f);
                                let _e3302 = fma(fma(_e3147, 0.02f, _e3149), 0.25f, _e3301);
                                let _e3303 = fma(_e3141, 0.00025f, _e3301);
                                if (_e3302 > 0f) {
                                    phi_14885_ = (_e3302 % 1f);
                                } else {
                                    phi_14885_ = (1f - (-(_e3302) % 1f));
                                }
                                let _e3310 = phi_14885_;
                                if (_e3303 > 0f) {
                                    phi_14898_ = (_e3303 % 1f);
                                } else {
                                    phi_14898_ = (1f - (-(_e3303) % 1f));
                                }
                                let _e3317 = phi_14898_;
                                let _e3319 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3310, _e3317), 0f);
                                let _e3321 = (_e3302 + 0.265625f);
                                let _e3322 = (_e3303 + 0.265625f);
                                if (_e3321 > 0f) {
                                    phi_14928_ = (_e3321 % 1f);
                                } else {
                                    phi_14928_ = (1f - ((-0.265625f - _e3302) % 1f));
                                }
                                let _e3329 = phi_14928_;
                                if (_e3322 > 0f) {
                                    phi_14941_ = (_e3322 % 1f);
                                } else {
                                    phi_14941_ = (1f - ((-0.265625f - _e3303) % 1f));
                                }
                                let _e3336 = phi_14941_;
                                let _e3338 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3329, _e3336), 0f);
                                let _e3344 = (_e3140 - 6372600f);
                                let _e3352 = ((fma(fma(_e3319.x, (1f - _e3300), (_e3338.x * _e3300)), 0.0625f, fma(fma(_e3270.x, (1f - _e3251), (_e3289.x * _e3251)), 0.125f, fma(fma(_e3171.x, (1f - _e3152), (_e3190.x * _e3152)), 0.5f, (fma(_e3219.x, (1f - _e3200), (_e3238.x * _e3200)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e3354 = select(_e3352, 0f, (_e3352 < 0f));
                                let _e3356 = select(_e3354, 1f, (_e3354 > 1f));
                                phi_2512_ = ((((_e3356 * _e3356) * fma(-2f, _e3356, 3f)) * ((1f - exp2((-0.01f * _e3344))) * exp2((-0.004f * _e3344)))) * 0.03f);
                            }
                            let _e3363 = phi_2512_;
                            phi_2513_ = _e3363;
                            phi_2514_ = _e3143;
                        }
                        let _e3365 = phi_2513_;
                        let _e3367 = phi_2514_;
                        phi_2395_ = (_e3129 + select(_e3365, 0f, _e3367));
                    } else {
                        phi_2395_ = f32();
                    }
                    let _e3371 = phi_2395_;
                    continue;
                    continuing {
                        phi_2394_ = _e3371;
                        phi_2397_ = _e3135;
                        break if !(_e3132);
                    }
                }
                let _e3374 = local_28;
                let _e3376 = exp2((_e3374 * -62.5f));
                phi_2571_ = (_e2866 * exp2(-(_e3118)));
                phi_2572_ = fma(_e2852, 0.0625f, _e2870);
                phi_2573_ = fma(_e2853, 0.0625f, _e2872);
                phi_2574_ = fma(_e2854, 0.0625f, _e2874);
                phi_2575_ = fma(((fma((((0.4807763f * _e3376) * _e3125) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e3122) * 3.1415927f), _e2866, _e2876);
                phi_2576_ = fma(((fma((((0.28401393f * _e3376) * _e3125) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e3122) * 3.1415927f), _e2866, _e2878);
                phi_2577_ = fma(((fma((((0.09044314f * _e3376) * _e3125) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e3122) * 3.1415927f), _e2866, _e2880);
            }
            let _e3408 = phi_2571_;
            let _e3410 = phi_2572_;
            let _e3412 = phi_2573_;
            let _e3414 = phi_2574_;
            let _e3416 = phi_2575_;
            let _e3418 = phi_2576_;
            let _e3420 = phi_2577_;
            phi_2232_ = _e3408;
            phi_2237_ = _e3410;
            phi_2239_ = _e3412;
            phi_2241_ = _e3414;
            phi_2243_ = _e3416;
            phi_2245_ = _e3418;
            phi_2247_ = _e3420;
        } else {
            phi_2232_ = f32();
            phi_2237_ = f32();
            phi_2239_ = f32();
            phi_2241_ = f32();
            phi_2243_ = f32();
            phi_2245_ = f32();
            phi_2247_ = f32();
        }
        let _e3422 = phi_2232_;
        let _e3424 = phi_2237_;
        let _e3426 = phi_2239_;
        let _e3428 = phi_2241_;
        let _e3430 = phi_2243_;
        let _e3432 = phi_2245_;
        let _e3434 = phi_2247_;
        continue;
        continuing {
            phi_2231_ = _e3422;
            phi_2234_ = _e2884;
            phi_2236_ = _e3424;
            phi_2238_ = _e3426;
            phi_2240_ = _e3428;
            phi_2242_ = _e3430;
            phi_2244_ = _e3432;
            phi_2246_ = _e3434;
            break if !(_e2881);
        }
    }
    let _e3437 = local_29;
    let _e3439 = local_30;
    let _e3442 = local_31;
    let _e3444 = local_32;
    let _e3447 = local_33;
    let _e3449 = local_34;
    let _e3455 = (sqrt(fma(_e2848, _e2848, fma(_e2846, _e2846, (_e2847 * _e2847)))) * 0.00001f);
    let _e3457 = select(_e3455, 0f, (_e3455 < 0f));
    let _e3459 = select(_e3457, 1f, (_e3457 > 1f));
    let _e3460 = (1f - _e3459);
    let _e3464 = fma(fma(_e2831, _e3437, _e3439), _e3460, (_e2831 * _e3459));
    let _e3465 = fma(fma(_e2832, _e3442, _e3444), _e3460, (_e2832 * _e3459));
    let _e3466 = fma(fma(_e2833, _e3447, _e3449), _e3460, (_e2833 * _e3459));
    if _e274 {
        phi_15015_ = vec2<f32>(-1f, -1f);
    } else {
        phi_15015_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e3471 = phi_15015_;
    if _e283 {
        phi_15055_ = vec2<f32>(-1f, -1f);
    } else {
        phi_15055_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e3477 = phi_15055_;
    let _e3479 = (_e144.x * _e3471.y);
    let _e3480 = (_e144.y * _e3471.y);
    let _e3481 = (_e144.z * _e3471.y);
    let _e3485 = fma(_e296, _e3471.y, (_e144.x + _e3477.y));
    let _e3486 = fma(_e298, _e3471.y, (_e144.y + _e3477.y));
    let _e3487 = fma(_e300, _e3471.y, (_e144.z + _e3477.y));
    let _e3488 = (_e3485 * 0.0625f);
    let _e3489 = (_e3486 * 0.0625f);
    let _e3490 = (_e3487 * 0.0625f);
    phi_2685_ = 1f;
    phi_2688_ = 0u;
    phi_2690_ = fma(_e3488, _e181, _e3479);
    phi_2692_ = fma(_e3489, _e181, _e3480);
    phi_2694_ = fma(_e3490, _e181, _e3481);
    phi_2696_ = 0f;
    phi_2698_ = 0f;
    phi_2700_ = 0f;
    loop {
        let _e3499 = phi_2685_;
        let _e3501 = phi_2688_;
        let _e3503 = phi_2690_;
        let _e3505 = phi_2692_;
        let _e3507 = phi_2694_;
        let _e3509 = phi_2696_;
        let _e3511 = phi_2698_;
        let _e3513 = phi_2700_;
        local_36 = _e3499;
        local_37 = _e3509;
        local_38 = _e3499;
        local_39 = _e3511;
        local_40 = _e3499;
        local_41 = _e3513;
        let _e3514 = (_e3501 < 16u);
        if _e3514 {
            phi_2689_ = (_e3501 + 1u);
        } else {
            phi_2689_ = _e3501;
        }
        let _e3517 = phi_2689_;
        if _e3514 {
            let _e3518 = (_e3505 + 6371000f);
            let _e3522 = sqrt(fma(_e3507, _e3507, fma(_e3503, _e3503, (_e3518 * _e3518))));
            let _e3523 = (_e3522 - 6371000f);
            if (_e3523 < 1600f) {
                phi_2816_ = f32();
                phi_2817_ = true;
            } else {
                let _e3525 = (_e3523 > 2100f);
                if _e3525 {
                    phi_2815_ = f32();
                } else {
                    let _e3529 = global_2.member.member[0u];
                    let _e3530 = (_e3529 * 0.02f);
                    let _e3531 = fma(_e3503, 0.001f, _e3530);
                    let _e3532 = fma(_e3507, 0.001f, _e3530);
                    let _e3533 = floor(_e3532);
                    let _e3534 = (_e3532 - _e3533);
                    let _e3535 = (_e3533 * 0.265625f);
                    let _e3536 = fma(_e3531, 0.015625f, _e3535);
                    let _e3537 = fma(_e3523, 0.000015625f, _e3535);
                    if (_e3536 > 0f) {
                        phi_15280_ = (_e3536 % 1f);
                    } else {
                        phi_15280_ = (1f - (-(_e3536) % 1f));
                    }
                    let _e3544 = phi_15280_;
                    if (_e3537 > 0f) {
                        phi_15293_ = (_e3537 % 1f);
                    } else {
                        phi_15293_ = (1f - (-(_e3537) % 1f));
                    }
                    let _e3551 = phi_15293_;
                    let _e3553 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3544, _e3551), 0f);
                    let _e3555 = (_e3536 + 0.265625f);
                    let _e3556 = (_e3537 + 0.265625f);
                    if (_e3555 > 0f) {
                        phi_15323_ = (_e3555 % 1f);
                    } else {
                        phi_15323_ = (1f - ((-0.265625f - _e3536) % 1f));
                    }
                    let _e3563 = phi_15323_;
                    if (_e3556 > 0f) {
                        phi_15336_ = (_e3556 % 1f);
                    } else {
                        phi_15336_ = (1f - ((-0.265625f - _e3537) % 1f));
                    }
                    let _e3570 = phi_15336_;
                    let _e3572 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3563, _e3570), 0f);
                    let _e3577 = fma(_e3529, 0.02f, 2f);
                    let _e3580 = floor((_e3532 * _e3577));
                    let _e3582 = fma(_e3532, _e3577, -(_e3580));
                    let _e3583 = (_e3580 * 0.265625f);
                    let _e3584 = fma((_e3531 * _e3577), 0.015625f, _e3583);
                    let _e3585 = fma(_e3523, 0.00003125f, _e3583);
                    if (_e3584 > 0f) {
                        phi_15396_ = (_e3584 % 1f);
                    } else {
                        phi_15396_ = (1f - (-(_e3584) % 1f));
                    }
                    let _e3592 = phi_15396_;
                    if (_e3585 > 0f) {
                        phi_15409_ = (_e3585 % 1f);
                    } else {
                        phi_15409_ = (1f - (-(_e3585) % 1f));
                    }
                    let _e3599 = phi_15409_;
                    let _e3601 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3592, _e3599), 0f);
                    let _e3603 = (_e3584 + 0.265625f);
                    let _e3604 = (_e3585 + 0.265625f);
                    if (_e3603 > 0f) {
                        phi_15439_ = (_e3603 % 1f);
                    } else {
                        phi_15439_ = (1f - ((-0.265625f - _e3584) % 1f));
                    }
                    let _e3611 = phi_15439_;
                    if (_e3604 > 0f) {
                        phi_15452_ = (_e3604 % 1f);
                    } else {
                        phi_15452_ = (1f - ((-0.265625f - _e3585) % 1f));
                    }
                    let _e3618 = phi_15452_;
                    let _e3620 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3611, _e3618), 0f);
                    let _e3628 = fma(-(_e3529), 0.02f, 7f);
                    let _e3631 = floor((_e3532 * _e3628));
                    let _e3633 = fma(_e3532, _e3628, -(_e3631));
                    let _e3634 = (_e3631 * 0.265625f);
                    let _e3635 = fma((_e3531 * _e3628), 0.015625f, _e3634);
                    let _e3636 = fma(_e3523, 0.000109375f, _e3634);
                    if (_e3635 > 0f) {
                        phi_15512_ = (_e3635 % 1f);
                    } else {
                        phi_15512_ = (1f - (-(_e3635) % 1f));
                    }
                    let _e3643 = phi_15512_;
                    if (_e3636 > 0f) {
                        phi_15525_ = (_e3636 % 1f);
                    } else {
                        phi_15525_ = (1f - (-(_e3636) % 1f));
                    }
                    let _e3650 = phi_15525_;
                    let _e3652 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3643, _e3650), 0f);
                    let _e3654 = (_e3635 + 0.265625f);
                    let _e3655 = (_e3636 + 0.265625f);
                    if (_e3654 > 0f) {
                        phi_15555_ = (_e3654 % 1f);
                    } else {
                        phi_15555_ = (1f - ((-0.265625f - _e3635) % 1f));
                    }
                    let _e3662 = phi_15555_;
                    if (_e3655 > 0f) {
                        phi_15568_ = (_e3655 % 1f);
                    } else {
                        phi_15568_ = (1f - ((-0.265625f - _e3636) % 1f));
                    }
                    let _e3669 = phi_15568_;
                    let _e3671 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3662, _e3669), 0f);
                    let _e3678 = fma(_e3529, 0.02f, _e3532);
                    let _e3680 = floor((_e3678 * 16f));
                    let _e3682 = fma(_e3678, 16f, -(_e3680));
                    let _e3683 = (_e3680 * 0.265625f);
                    let _e3684 = fma(fma(_e3529, 0.02f, _e3531), 0.25f, _e3683);
                    let _e3685 = fma(_e3523, 0.00025f, _e3683);
                    if (_e3684 > 0f) {
                        phi_15628_ = (_e3684 % 1f);
                    } else {
                        phi_15628_ = (1f - (-(_e3684) % 1f));
                    }
                    let _e3692 = phi_15628_;
                    if (_e3685 > 0f) {
                        phi_15641_ = (_e3685 % 1f);
                    } else {
                        phi_15641_ = (1f - (-(_e3685) % 1f));
                    }
                    let _e3699 = phi_15641_;
                    let _e3701 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3692, _e3699), 0f);
                    let _e3703 = (_e3684 + 0.265625f);
                    let _e3704 = (_e3685 + 0.265625f);
                    if (_e3703 > 0f) {
                        phi_15671_ = (_e3703 % 1f);
                    } else {
                        phi_15671_ = (1f - ((-0.265625f - _e3684) % 1f));
                    }
                    let _e3711 = phi_15671_;
                    if (_e3704 > 0f) {
                        phi_15684_ = (_e3704 % 1f);
                    } else {
                        phi_15684_ = (1f - ((-0.265625f - _e3685) % 1f));
                    }
                    let _e3718 = phi_15684_;
                    let _e3720 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3711, _e3718), 0f);
                    let _e3726 = (_e3522 - 6372600f);
                    let _e3734 = ((fma(fma(_e3701.x, (1f - _e3682), (_e3720.x * _e3682)), 0.0625f, fma(fma(_e3652.x, (1f - _e3633), (_e3671.x * _e3633)), 0.125f, fma(fma(_e3553.x, (1f - _e3534), (_e3572.x * _e3534)), 0.5f, (fma(_e3601.x, (1f - _e3582), (_e3620.x * _e3582)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e3736 = select(_e3734, 0f, (_e3734 < 0f));
                    let _e3738 = select(_e3736, 1f, (_e3736 > 1f));
                    phi_2815_ = ((((_e3738 * _e3738) * fma(-2f, _e3738, 3f)) * ((1f - exp2((-0.01f * _e3726))) * exp2((-0.004f * _e3726)))) * 0.03f);
                }
                let _e3745 = phi_2815_;
                phi_2816_ = _e3745;
                phi_2817_ = _e3525;
            }
            let _e3747 = phi_2816_;
            let _e3749 = phi_2817_;
            let _e3751 = (select(_e3747, 0f, _e3749) * sqrt(fma(_e3490, _e3490, fma(_e3488, _e3488, (_e3489 * _e3489)))));
            if (_e3751 <= 0f) {
                phi_3025_ = _e3499;
                phi_3026_ = _e3503;
                phi_3027_ = _e3505;
                phi_3028_ = _e3507;
                phi_3029_ = _e3509;
                phi_3030_ = _e3511;
                phi_3031_ = _e3513;
            } else {
                let _e3755 = fma(exp2((-1.6013916f * _e3751)), -0.9009009f, 0.9009009f);
                let _e3758 = (1f - exp2((_e3751 * -1.3862944f)));
                let _e3759 = (-9.537895f + _e3503);
                let _e3760 = (29.354609f + _e3507);
                phi_2848_ = 0f;
                phi_2851_ = 0u;
                loop {
                    let _e3762 = phi_2848_;
                    let _e3764 = phi_2851_;
                    local_35 = _e3762;
                    let _e3765 = (_e3764 < 8u);
                    if _e3765 {
                        phi_2852_ = (_e3764 + 1u);
                    } else {
                        phi_2852_ = _e3764;
                    }
                    let _e3768 = phi_2852_;
                    if _e3765 {
                        let _e3769 = (_e3505 + 6371005f);
                        let _e3773 = sqrt(fma(_e3760, _e3760, fma(_e3759, _e3759, (_e3769 * _e3769))));
                        let _e3774 = (_e3773 - 6371000f);
                        if (_e3774 < 1600f) {
                            phi_2967_ = f32();
                            phi_2968_ = true;
                        } else {
                            let _e3776 = (_e3774 > 2100f);
                            if _e3776 {
                                phi_2966_ = f32();
                            } else {
                                let _e3780 = global_2.member.member[0u];
                                let _e3781 = (_e3780 * 0.02f);
                                let _e3782 = fma(_e3759, 0.001f, _e3781);
                                let _e3783 = fma(_e3760, 0.001f, _e3781);
                                let _e3784 = floor(_e3783);
                                let _e3785 = (_e3783 - _e3784);
                                let _e3786 = (_e3784 * 0.265625f);
                                let _e3787 = fma(_e3782, 0.015625f, _e3786);
                                let _e3788 = fma(_e3774, 0.000015625f, _e3786);
                                if (_e3787 > 0f) {
                                    phi_15760_ = (_e3787 % 1f);
                                } else {
                                    phi_15760_ = (1f - (-(_e3787) % 1f));
                                }
                                let _e3795 = phi_15760_;
                                if (_e3788 > 0f) {
                                    phi_15773_ = (_e3788 % 1f);
                                } else {
                                    phi_15773_ = (1f - (-(_e3788) % 1f));
                                }
                                let _e3802 = phi_15773_;
                                let _e3804 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3795, _e3802), 0f);
                                let _e3806 = (_e3787 + 0.265625f);
                                let _e3807 = (_e3788 + 0.265625f);
                                if (_e3806 > 0f) {
                                    phi_15803_ = (_e3806 % 1f);
                                } else {
                                    phi_15803_ = (1f - ((-0.265625f - _e3787) % 1f));
                                }
                                let _e3814 = phi_15803_;
                                if (_e3807 > 0f) {
                                    phi_15816_ = (_e3807 % 1f);
                                } else {
                                    phi_15816_ = (1f - ((-0.265625f - _e3788) % 1f));
                                }
                                let _e3821 = phi_15816_;
                                let _e3823 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3814, _e3821), 0f);
                                let _e3828 = fma(_e3780, 0.02f, 2f);
                                let _e3831 = floor((_e3783 * _e3828));
                                let _e3833 = fma(_e3783, _e3828, -(_e3831));
                                let _e3834 = (_e3831 * 0.265625f);
                                let _e3835 = fma((_e3782 * _e3828), 0.015625f, _e3834);
                                let _e3836 = fma(_e3774, 0.00003125f, _e3834);
                                if (_e3835 > 0f) {
                                    phi_15876_ = (_e3835 % 1f);
                                } else {
                                    phi_15876_ = (1f - (-(_e3835) % 1f));
                                }
                                let _e3843 = phi_15876_;
                                if (_e3836 > 0f) {
                                    phi_15889_ = (_e3836 % 1f);
                                } else {
                                    phi_15889_ = (1f - (-(_e3836) % 1f));
                                }
                                let _e3850 = phi_15889_;
                                let _e3852 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3843, _e3850), 0f);
                                let _e3854 = (_e3835 + 0.265625f);
                                let _e3855 = (_e3836 + 0.265625f);
                                if (_e3854 > 0f) {
                                    phi_15919_ = (_e3854 % 1f);
                                } else {
                                    phi_15919_ = (1f - ((-0.265625f - _e3835) % 1f));
                                }
                                let _e3862 = phi_15919_;
                                if (_e3855 > 0f) {
                                    phi_15932_ = (_e3855 % 1f);
                                } else {
                                    phi_15932_ = (1f - ((-0.265625f - _e3836) % 1f));
                                }
                                let _e3869 = phi_15932_;
                                let _e3871 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3862, _e3869), 0f);
                                let _e3879 = fma(-(_e3780), 0.02f, 7f);
                                let _e3882 = floor((_e3783 * _e3879));
                                let _e3884 = fma(_e3783, _e3879, -(_e3882));
                                let _e3885 = (_e3882 * 0.265625f);
                                let _e3886 = fma((_e3782 * _e3879), 0.015625f, _e3885);
                                let _e3887 = fma(_e3774, 0.000109375f, _e3885);
                                if (_e3886 > 0f) {
                                    phi_15992_ = (_e3886 % 1f);
                                } else {
                                    phi_15992_ = (1f - (-(_e3886) % 1f));
                                }
                                let _e3894 = phi_15992_;
                                if (_e3887 > 0f) {
                                    phi_16005_ = (_e3887 % 1f);
                                } else {
                                    phi_16005_ = (1f - (-(_e3887) % 1f));
                                }
                                let _e3901 = phi_16005_;
                                let _e3903 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3894, _e3901), 0f);
                                let _e3905 = (_e3886 + 0.265625f);
                                let _e3906 = (_e3887 + 0.265625f);
                                if (_e3905 > 0f) {
                                    phi_16035_ = (_e3905 % 1f);
                                } else {
                                    phi_16035_ = (1f - ((-0.265625f - _e3886) % 1f));
                                }
                                let _e3913 = phi_16035_;
                                if (_e3906 > 0f) {
                                    phi_16048_ = (_e3906 % 1f);
                                } else {
                                    phi_16048_ = (1f - ((-0.265625f - _e3887) % 1f));
                                }
                                let _e3920 = phi_16048_;
                                let _e3922 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3913, _e3920), 0f);
                                let _e3929 = fma(_e3780, 0.02f, _e3783);
                                let _e3931 = floor((_e3929 * 16f));
                                let _e3933 = fma(_e3929, 16f, -(_e3931));
                                let _e3934 = (_e3931 * 0.265625f);
                                let _e3935 = fma(fma(_e3780, 0.02f, _e3782), 0.25f, _e3934);
                                let _e3936 = fma(_e3774, 0.00025f, _e3934);
                                if (_e3935 > 0f) {
                                    phi_16108_ = (_e3935 % 1f);
                                } else {
                                    phi_16108_ = (1f - (-(_e3935) % 1f));
                                }
                                let _e3943 = phi_16108_;
                                if (_e3936 > 0f) {
                                    phi_16121_ = (_e3936 % 1f);
                                } else {
                                    phi_16121_ = (1f - (-(_e3936) % 1f));
                                }
                                let _e3950 = phi_16121_;
                                let _e3952 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3943, _e3950), 0f);
                                let _e3954 = (_e3935 + 0.265625f);
                                let _e3955 = (_e3936 + 0.265625f);
                                if (_e3954 > 0f) {
                                    phi_16151_ = (_e3954 % 1f);
                                } else {
                                    phi_16151_ = (1f - ((-0.265625f - _e3935) % 1f));
                                }
                                let _e3962 = phi_16151_;
                                if (_e3955 > 0f) {
                                    phi_16164_ = (_e3955 % 1f);
                                } else {
                                    phi_16164_ = (1f - ((-0.265625f - _e3936) % 1f));
                                }
                                let _e3969 = phi_16164_;
                                let _e3971 = textureSampleLevel(global_3, global_4, vec2<f32>(_e3962, _e3969), 0f);
                                let _e3977 = (_e3773 - 6372600f);
                                let _e3985 = ((fma(fma(_e3952.x, (1f - _e3933), (_e3971.x * _e3933)), 0.0625f, fma(fma(_e3903.x, (1f - _e3884), (_e3922.x * _e3884)), 0.125f, fma(fma(_e3804.x, (1f - _e3785), (_e3823.x * _e3785)), 0.5f, (fma(_e3852.x, (1f - _e3833), (_e3871.x * _e3833)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e3987 = select(_e3985, 0f, (_e3985 < 0f));
                                let _e3989 = select(_e3987, 1f, (_e3987 > 1f));
                                phi_2966_ = ((((_e3989 * _e3989) * fma(-2f, _e3989, 3f)) * ((1f - exp2((-0.01f * _e3977))) * exp2((-0.004f * _e3977)))) * 0.03f);
                            }
                            let _e3996 = phi_2966_;
                            phi_2967_ = _e3996;
                            phi_2968_ = _e3776;
                        }
                        let _e3998 = phi_2967_;
                        let _e4000 = phi_2968_;
                        phi_2849_ = (_e3762 + select(_e3998, 0f, _e4000));
                    } else {
                        phi_2849_ = f32();
                    }
                    let _e4004 = phi_2849_;
                    continue;
                    continuing {
                        phi_2848_ = _e4004;
                        phi_2851_ = _e3768;
                        break if !(_e3765);
                    }
                }
                let _e4007 = local_35;
                let _e4009 = exp2((_e4007 * -62.5f));
                phi_3025_ = (_e3499 * exp2(-(_e3751)));
                phi_3026_ = fma(_e3485, 0.0625f, _e3503);
                phi_3027_ = fma(_e3486, 0.0625f, _e3505);
                phi_3028_ = fma(_e3487, 0.0625f, _e3507);
                phi_3029_ = fma(((fma((((0.4807763f * _e4009) * _e3758) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e3755) * 3.1415927f), _e3499, _e3509);
                phi_3030_ = fma(((fma((((0.28401393f * _e4009) * _e3758) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e3755) * 3.1415927f), _e3499, _e3511);
                phi_3031_ = fma(((fma((((0.09044314f * _e4009) * _e3758) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e3755) * 3.1415927f), _e3499, _e3513);
            }
            let _e4041 = phi_3025_;
            let _e4043 = phi_3026_;
            let _e4045 = phi_3027_;
            let _e4047 = phi_3028_;
            let _e4049 = phi_3029_;
            let _e4051 = phi_3030_;
            let _e4053 = phi_3031_;
            phi_2686_ = _e4041;
            phi_2691_ = _e4043;
            phi_2693_ = _e4045;
            phi_2695_ = _e4047;
            phi_2697_ = _e4049;
            phi_2699_ = _e4051;
            phi_2701_ = _e4053;
        } else {
            phi_2686_ = f32();
            phi_2691_ = f32();
            phi_2693_ = f32();
            phi_2695_ = f32();
            phi_2697_ = f32();
            phi_2699_ = f32();
            phi_2701_ = f32();
        }
        let _e4055 = phi_2686_;
        let _e4057 = phi_2691_;
        let _e4059 = phi_2693_;
        let _e4061 = phi_2695_;
        let _e4063 = phi_2697_;
        let _e4065 = phi_2699_;
        let _e4067 = phi_2701_;
        continue;
        continuing {
            phi_2685_ = _e4055;
            phi_2688_ = _e3517;
            phi_2690_ = _e4057;
            phi_2692_ = _e4059;
            phi_2694_ = _e4061;
            phi_2696_ = _e4063;
            phi_2698_ = _e4065;
            phi_2700_ = _e4067;
            break if !(_e3514);
        }
    }
    let _e4070 = local_36;
    let _e4072 = local_37;
    let _e4075 = local_38;
    let _e4077 = local_39;
    let _e4080 = local_40;
    let _e4082 = local_41;
    let _e4088 = (sqrt(fma(_e3481, _e3481, fma(_e3479, _e3479, (_e3480 * _e3480)))) * 0.00001f);
    let _e4090 = select(_e4088, 0f, (_e4088 < 0f));
    let _e4092 = select(_e4090, 1f, (_e4090 > 1f));
    let _e4093 = (1f - _e4092);
    let _e4097 = fma(fma(_e3464, _e4070, _e4072), _e4093, (_e3464 * _e4092));
    let _e4098 = fma(fma(_e3465, _e4075, _e4077), _e4093, (_e3465 * _e4092));
    let _e4099 = fma(fma(_e3466, _e4080, _e4082), _e4093, (_e3466 * _e4092));
    if _e274 {
        phi_16238_ = vec2<f32>(-1f, -1f);
    } else {
        phi_16238_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e4104 = phi_16238_;
    if _e283 {
        phi_16278_ = vec2<f32>(-1f, -1f);
    } else {
        phi_16278_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e4110 = phi_16278_;
    let _e4112 = (_e144.x * _e4104.y);
    let _e4113 = (_e144.y * _e4104.y);
    let _e4114 = (_e144.z * _e4104.y);
    let _e4118 = fma(_e296, _e4104.y, (_e144.x + _e4110.y));
    let _e4119 = fma(_e298, _e4104.y, (_e144.y + _e4110.y));
    let _e4120 = fma(_e300, _e4104.y, (_e144.z + _e4110.y));
    let _e4121 = (_e4118 * 0.0625f);
    let _e4122 = (_e4119 * 0.0625f);
    let _e4123 = (_e4120 * 0.0625f);
    phi_3139_ = 1f;
    phi_3142_ = 0u;
    phi_3144_ = fma(_e4121, _e181, _e4112);
    phi_3146_ = fma(_e4122, _e181, _e4113);
    phi_3148_ = fma(_e4123, _e181, _e4114);
    phi_3150_ = 0f;
    phi_3152_ = 0f;
    phi_3154_ = 0f;
    loop {
        let _e4132 = phi_3139_;
        let _e4134 = phi_3142_;
        let _e4136 = phi_3144_;
        let _e4138 = phi_3146_;
        let _e4140 = phi_3148_;
        let _e4142 = phi_3150_;
        let _e4144 = phi_3152_;
        let _e4146 = phi_3154_;
        local_43 = _e4132;
        local_44 = _e4142;
        local_45 = _e4132;
        local_46 = _e4144;
        local_47 = _e4132;
        local_48 = _e4146;
        let _e4147 = (_e4134 < 16u);
        if _e4147 {
            phi_3143_ = (_e4134 + 1u);
        } else {
            phi_3143_ = _e4134;
        }
        let _e4150 = phi_3143_;
        if _e4147 {
            let _e4151 = (_e4138 + 6371000f);
            let _e4155 = sqrt(fma(_e4140, _e4140, fma(_e4136, _e4136, (_e4151 * _e4151))));
            let _e4156 = (_e4155 - 6371000f);
            if (_e4156 < 1600f) {
                phi_3270_ = f32();
                phi_3271_ = true;
            } else {
                let _e4158 = (_e4156 > 2100f);
                if _e4158 {
                    phi_3269_ = f32();
                } else {
                    let _e4162 = global_2.member.member[0u];
                    let _e4163 = (_e4162 * 0.02f);
                    let _e4164 = fma(_e4136, 0.001f, _e4163);
                    let _e4165 = fma(_e4140, 0.001f, _e4163);
                    let _e4166 = floor(_e4165);
                    let _e4167 = (_e4165 - _e4166);
                    let _e4168 = (_e4166 * 0.265625f);
                    let _e4169 = fma(_e4164, 0.015625f, _e4168);
                    let _e4170 = fma(_e4156, 0.000015625f, _e4168);
                    if (_e4169 > 0f) {
                        phi_16503_ = (_e4169 % 1f);
                    } else {
                        phi_16503_ = (1f - (-(_e4169) % 1f));
                    }
                    let _e4177 = phi_16503_;
                    if (_e4170 > 0f) {
                        phi_16516_ = (_e4170 % 1f);
                    } else {
                        phi_16516_ = (1f - (-(_e4170) % 1f));
                    }
                    let _e4184 = phi_16516_;
                    let _e4186 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4177, _e4184), 0f);
                    let _e4188 = (_e4169 + 0.265625f);
                    let _e4189 = (_e4170 + 0.265625f);
                    if (_e4188 > 0f) {
                        phi_16546_ = (_e4188 % 1f);
                    } else {
                        phi_16546_ = (1f - ((-0.265625f - _e4169) % 1f));
                    }
                    let _e4196 = phi_16546_;
                    if (_e4189 > 0f) {
                        phi_16559_ = (_e4189 % 1f);
                    } else {
                        phi_16559_ = (1f - ((-0.265625f - _e4170) % 1f));
                    }
                    let _e4203 = phi_16559_;
                    let _e4205 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4196, _e4203), 0f);
                    let _e4210 = fma(_e4162, 0.02f, 2f);
                    let _e4213 = floor((_e4165 * _e4210));
                    let _e4215 = fma(_e4165, _e4210, -(_e4213));
                    let _e4216 = (_e4213 * 0.265625f);
                    let _e4217 = fma((_e4164 * _e4210), 0.015625f, _e4216);
                    let _e4218 = fma(_e4156, 0.00003125f, _e4216);
                    if (_e4217 > 0f) {
                        phi_16619_ = (_e4217 % 1f);
                    } else {
                        phi_16619_ = (1f - (-(_e4217) % 1f));
                    }
                    let _e4225 = phi_16619_;
                    if (_e4218 > 0f) {
                        phi_16632_ = (_e4218 % 1f);
                    } else {
                        phi_16632_ = (1f - (-(_e4218) % 1f));
                    }
                    let _e4232 = phi_16632_;
                    let _e4234 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4225, _e4232), 0f);
                    let _e4236 = (_e4217 + 0.265625f);
                    let _e4237 = (_e4218 + 0.265625f);
                    if (_e4236 > 0f) {
                        phi_16662_ = (_e4236 % 1f);
                    } else {
                        phi_16662_ = (1f - ((-0.265625f - _e4217) % 1f));
                    }
                    let _e4244 = phi_16662_;
                    if (_e4237 > 0f) {
                        phi_16675_ = (_e4237 % 1f);
                    } else {
                        phi_16675_ = (1f - ((-0.265625f - _e4218) % 1f));
                    }
                    let _e4251 = phi_16675_;
                    let _e4253 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4244, _e4251), 0f);
                    let _e4261 = fma(-(_e4162), 0.02f, 7f);
                    let _e4264 = floor((_e4165 * _e4261));
                    let _e4266 = fma(_e4165, _e4261, -(_e4264));
                    let _e4267 = (_e4264 * 0.265625f);
                    let _e4268 = fma((_e4164 * _e4261), 0.015625f, _e4267);
                    let _e4269 = fma(_e4156, 0.000109375f, _e4267);
                    if (_e4268 > 0f) {
                        phi_16735_ = (_e4268 % 1f);
                    } else {
                        phi_16735_ = (1f - (-(_e4268) % 1f));
                    }
                    let _e4276 = phi_16735_;
                    if (_e4269 > 0f) {
                        phi_16748_ = (_e4269 % 1f);
                    } else {
                        phi_16748_ = (1f - (-(_e4269) % 1f));
                    }
                    let _e4283 = phi_16748_;
                    let _e4285 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4276, _e4283), 0f);
                    let _e4287 = (_e4268 + 0.265625f);
                    let _e4288 = (_e4269 + 0.265625f);
                    if (_e4287 > 0f) {
                        phi_16778_ = (_e4287 % 1f);
                    } else {
                        phi_16778_ = (1f - ((-0.265625f - _e4268) % 1f));
                    }
                    let _e4295 = phi_16778_;
                    if (_e4288 > 0f) {
                        phi_16791_ = (_e4288 % 1f);
                    } else {
                        phi_16791_ = (1f - ((-0.265625f - _e4269) % 1f));
                    }
                    let _e4302 = phi_16791_;
                    let _e4304 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4295, _e4302), 0f);
                    let _e4311 = fma(_e4162, 0.02f, _e4165);
                    let _e4313 = floor((_e4311 * 16f));
                    let _e4315 = fma(_e4311, 16f, -(_e4313));
                    let _e4316 = (_e4313 * 0.265625f);
                    let _e4317 = fma(fma(_e4162, 0.02f, _e4164), 0.25f, _e4316);
                    let _e4318 = fma(_e4156, 0.00025f, _e4316);
                    if (_e4317 > 0f) {
                        phi_16851_ = (_e4317 % 1f);
                    } else {
                        phi_16851_ = (1f - (-(_e4317) % 1f));
                    }
                    let _e4325 = phi_16851_;
                    if (_e4318 > 0f) {
                        phi_16864_ = (_e4318 % 1f);
                    } else {
                        phi_16864_ = (1f - (-(_e4318) % 1f));
                    }
                    let _e4332 = phi_16864_;
                    let _e4334 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4325, _e4332), 0f);
                    let _e4336 = (_e4317 + 0.265625f);
                    let _e4337 = (_e4318 + 0.265625f);
                    if (_e4336 > 0f) {
                        phi_16894_ = (_e4336 % 1f);
                    } else {
                        phi_16894_ = (1f - ((-0.265625f - _e4317) % 1f));
                    }
                    let _e4344 = phi_16894_;
                    if (_e4337 > 0f) {
                        phi_16907_ = (_e4337 % 1f);
                    } else {
                        phi_16907_ = (1f - ((-0.265625f - _e4318) % 1f));
                    }
                    let _e4351 = phi_16907_;
                    let _e4353 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4344, _e4351), 0f);
                    let _e4359 = (_e4155 - 6372600f);
                    let _e4367 = ((fma(fma(_e4334.x, (1f - _e4315), (_e4353.x * _e4315)), 0.0625f, fma(fma(_e4285.x, (1f - _e4266), (_e4304.x * _e4266)), 0.125f, fma(fma(_e4186.x, (1f - _e4167), (_e4205.x * _e4167)), 0.5f, (fma(_e4234.x, (1f - _e4215), (_e4253.x * _e4215)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e4369 = select(_e4367, 0f, (_e4367 < 0f));
                    let _e4371 = select(_e4369, 1f, (_e4369 > 1f));
                    phi_3269_ = ((((_e4371 * _e4371) * fma(-2f, _e4371, 3f)) * ((1f - exp2((-0.01f * _e4359))) * exp2((-0.004f * _e4359)))) * 0.03f);
                }
                let _e4378 = phi_3269_;
                phi_3270_ = _e4378;
                phi_3271_ = _e4158;
            }
            let _e4380 = phi_3270_;
            let _e4382 = phi_3271_;
            let _e4384 = (select(_e4380, 0f, _e4382) * sqrt(fma(_e4123, _e4123, fma(_e4121, _e4121, (_e4122 * _e4122)))));
            if (_e4384 <= 0f) {
                phi_3479_ = _e4132;
                phi_3480_ = _e4136;
                phi_3481_ = _e4138;
                phi_3482_ = _e4140;
                phi_3483_ = _e4142;
                phi_3484_ = _e4144;
                phi_3485_ = _e4146;
            } else {
                let _e4388 = fma(exp2((-1.6013916f * _e4384)), -0.9009009f, 0.9009009f);
                let _e4391 = (1f - exp2((_e4384 * -1.3862944f)));
                let _e4392 = (-9.537895f + _e4136);
                let _e4393 = (29.354609f + _e4140);
                phi_3302_ = 0f;
                phi_3305_ = 0u;
                loop {
                    let _e4395 = phi_3302_;
                    let _e4397 = phi_3305_;
                    local_42 = _e4395;
                    let _e4398 = (_e4397 < 8u);
                    if _e4398 {
                        phi_3306_ = (_e4397 + 1u);
                    } else {
                        phi_3306_ = _e4397;
                    }
                    let _e4401 = phi_3306_;
                    if _e4398 {
                        let _e4402 = (_e4138 + 6371005f);
                        let _e4406 = sqrt(fma(_e4393, _e4393, fma(_e4392, _e4392, (_e4402 * _e4402))));
                        let _e4407 = (_e4406 - 6371000f);
                        if (_e4407 < 1600f) {
                            phi_3421_ = f32();
                            phi_3422_ = true;
                        } else {
                            let _e4409 = (_e4407 > 2100f);
                            if _e4409 {
                                phi_3420_ = f32();
                            } else {
                                let _e4413 = global_2.member.member[0u];
                                let _e4414 = (_e4413 * 0.02f);
                                let _e4415 = fma(_e4392, 0.001f, _e4414);
                                let _e4416 = fma(_e4393, 0.001f, _e4414);
                                let _e4417 = floor(_e4416);
                                let _e4418 = (_e4416 - _e4417);
                                let _e4419 = (_e4417 * 0.265625f);
                                let _e4420 = fma(_e4415, 0.015625f, _e4419);
                                let _e4421 = fma(_e4407, 0.000015625f, _e4419);
                                if (_e4420 > 0f) {
                                    phi_16983_ = (_e4420 % 1f);
                                } else {
                                    phi_16983_ = (1f - (-(_e4420) % 1f));
                                }
                                let _e4428 = phi_16983_;
                                if (_e4421 > 0f) {
                                    phi_16996_ = (_e4421 % 1f);
                                } else {
                                    phi_16996_ = (1f - (-(_e4421) % 1f));
                                }
                                let _e4435 = phi_16996_;
                                let _e4437 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4428, _e4435), 0f);
                                let _e4439 = (_e4420 + 0.265625f);
                                let _e4440 = (_e4421 + 0.265625f);
                                if (_e4439 > 0f) {
                                    phi_17026_ = (_e4439 % 1f);
                                } else {
                                    phi_17026_ = (1f - ((-0.265625f - _e4420) % 1f));
                                }
                                let _e4447 = phi_17026_;
                                if (_e4440 > 0f) {
                                    phi_17039_ = (_e4440 % 1f);
                                } else {
                                    phi_17039_ = (1f - ((-0.265625f - _e4421) % 1f));
                                }
                                let _e4454 = phi_17039_;
                                let _e4456 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4447, _e4454), 0f);
                                let _e4461 = fma(_e4413, 0.02f, 2f);
                                let _e4464 = floor((_e4416 * _e4461));
                                let _e4466 = fma(_e4416, _e4461, -(_e4464));
                                let _e4467 = (_e4464 * 0.265625f);
                                let _e4468 = fma((_e4415 * _e4461), 0.015625f, _e4467);
                                let _e4469 = fma(_e4407, 0.00003125f, _e4467);
                                if (_e4468 > 0f) {
                                    phi_17099_ = (_e4468 % 1f);
                                } else {
                                    phi_17099_ = (1f - (-(_e4468) % 1f));
                                }
                                let _e4476 = phi_17099_;
                                if (_e4469 > 0f) {
                                    phi_17112_ = (_e4469 % 1f);
                                } else {
                                    phi_17112_ = (1f - (-(_e4469) % 1f));
                                }
                                let _e4483 = phi_17112_;
                                let _e4485 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4476, _e4483), 0f);
                                let _e4487 = (_e4468 + 0.265625f);
                                let _e4488 = (_e4469 + 0.265625f);
                                if (_e4487 > 0f) {
                                    phi_17142_ = (_e4487 % 1f);
                                } else {
                                    phi_17142_ = (1f - ((-0.265625f - _e4468) % 1f));
                                }
                                let _e4495 = phi_17142_;
                                if (_e4488 > 0f) {
                                    phi_17155_ = (_e4488 % 1f);
                                } else {
                                    phi_17155_ = (1f - ((-0.265625f - _e4469) % 1f));
                                }
                                let _e4502 = phi_17155_;
                                let _e4504 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4495, _e4502), 0f);
                                let _e4512 = fma(-(_e4413), 0.02f, 7f);
                                let _e4515 = floor((_e4416 * _e4512));
                                let _e4517 = fma(_e4416, _e4512, -(_e4515));
                                let _e4518 = (_e4515 * 0.265625f);
                                let _e4519 = fma((_e4415 * _e4512), 0.015625f, _e4518);
                                let _e4520 = fma(_e4407, 0.000109375f, _e4518);
                                if (_e4519 > 0f) {
                                    phi_17215_ = (_e4519 % 1f);
                                } else {
                                    phi_17215_ = (1f - (-(_e4519) % 1f));
                                }
                                let _e4527 = phi_17215_;
                                if (_e4520 > 0f) {
                                    phi_17228_ = (_e4520 % 1f);
                                } else {
                                    phi_17228_ = (1f - (-(_e4520) % 1f));
                                }
                                let _e4534 = phi_17228_;
                                let _e4536 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4527, _e4534), 0f);
                                let _e4538 = (_e4519 + 0.265625f);
                                let _e4539 = (_e4520 + 0.265625f);
                                if (_e4538 > 0f) {
                                    phi_17258_ = (_e4538 % 1f);
                                } else {
                                    phi_17258_ = (1f - ((-0.265625f - _e4519) % 1f));
                                }
                                let _e4546 = phi_17258_;
                                if (_e4539 > 0f) {
                                    phi_17271_ = (_e4539 % 1f);
                                } else {
                                    phi_17271_ = (1f - ((-0.265625f - _e4520) % 1f));
                                }
                                let _e4553 = phi_17271_;
                                let _e4555 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4546, _e4553), 0f);
                                let _e4562 = fma(_e4413, 0.02f, _e4416);
                                let _e4564 = floor((_e4562 * 16f));
                                let _e4566 = fma(_e4562, 16f, -(_e4564));
                                let _e4567 = (_e4564 * 0.265625f);
                                let _e4568 = fma(fma(_e4413, 0.02f, _e4415), 0.25f, _e4567);
                                let _e4569 = fma(_e4407, 0.00025f, _e4567);
                                if (_e4568 > 0f) {
                                    phi_17331_ = (_e4568 % 1f);
                                } else {
                                    phi_17331_ = (1f - (-(_e4568) % 1f));
                                }
                                let _e4576 = phi_17331_;
                                if (_e4569 > 0f) {
                                    phi_17344_ = (_e4569 % 1f);
                                } else {
                                    phi_17344_ = (1f - (-(_e4569) % 1f));
                                }
                                let _e4583 = phi_17344_;
                                let _e4585 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4576, _e4583), 0f);
                                let _e4587 = (_e4568 + 0.265625f);
                                let _e4588 = (_e4569 + 0.265625f);
                                if (_e4587 > 0f) {
                                    phi_17374_ = (_e4587 % 1f);
                                } else {
                                    phi_17374_ = (1f - ((-0.265625f - _e4568) % 1f));
                                }
                                let _e4595 = phi_17374_;
                                if (_e4588 > 0f) {
                                    phi_17387_ = (_e4588 % 1f);
                                } else {
                                    phi_17387_ = (1f - ((-0.265625f - _e4569) % 1f));
                                }
                                let _e4602 = phi_17387_;
                                let _e4604 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4595, _e4602), 0f);
                                let _e4610 = (_e4406 - 6372600f);
                                let _e4618 = ((fma(fma(_e4585.x, (1f - _e4566), (_e4604.x * _e4566)), 0.0625f, fma(fma(_e4536.x, (1f - _e4517), (_e4555.x * _e4517)), 0.125f, fma(fma(_e4437.x, (1f - _e4418), (_e4456.x * _e4418)), 0.5f, (fma(_e4485.x, (1f - _e4466), (_e4504.x * _e4466)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e4620 = select(_e4618, 0f, (_e4618 < 0f));
                                let _e4622 = select(_e4620, 1f, (_e4620 > 1f));
                                phi_3420_ = ((((_e4622 * _e4622) * fma(-2f, _e4622, 3f)) * ((1f - exp2((-0.01f * _e4610))) * exp2((-0.004f * _e4610)))) * 0.03f);
                            }
                            let _e4629 = phi_3420_;
                            phi_3421_ = _e4629;
                            phi_3422_ = _e4409;
                        }
                        let _e4631 = phi_3421_;
                        let _e4633 = phi_3422_;
                        phi_3303_ = (_e4395 + select(_e4631, 0f, _e4633));
                    } else {
                        phi_3303_ = f32();
                    }
                    let _e4637 = phi_3303_;
                    continue;
                    continuing {
                        phi_3302_ = _e4637;
                        phi_3305_ = _e4401;
                        break if !(_e4398);
                    }
                }
                let _e4640 = local_42;
                let _e4642 = exp2((_e4640 * -62.5f));
                phi_3479_ = (_e4132 * exp2(-(_e4384)));
                phi_3480_ = fma(_e4118, 0.0625f, _e4136);
                phi_3481_ = fma(_e4119, 0.0625f, _e4138);
                phi_3482_ = fma(_e4120, 0.0625f, _e4140);
                phi_3483_ = fma(((fma((((0.4807763f * _e4642) * _e4391) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e4388) * 3.1415927f), _e4132, _e4142);
                phi_3484_ = fma(((fma((((0.28401393f * _e4642) * _e4391) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e4388) * 3.1415927f), _e4132, _e4144);
                phi_3485_ = fma(((fma((((0.09044314f * _e4642) * _e4391) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e4388) * 3.1415927f), _e4132, _e4146);
            }
            let _e4674 = phi_3479_;
            let _e4676 = phi_3480_;
            let _e4678 = phi_3481_;
            let _e4680 = phi_3482_;
            let _e4682 = phi_3483_;
            let _e4684 = phi_3484_;
            let _e4686 = phi_3485_;
            phi_3140_ = _e4674;
            phi_3145_ = _e4676;
            phi_3147_ = _e4678;
            phi_3149_ = _e4680;
            phi_3151_ = _e4682;
            phi_3153_ = _e4684;
            phi_3155_ = _e4686;
        } else {
            phi_3140_ = f32();
            phi_3145_ = f32();
            phi_3147_ = f32();
            phi_3149_ = f32();
            phi_3151_ = f32();
            phi_3153_ = f32();
            phi_3155_ = f32();
        }
        let _e4688 = phi_3140_;
        let _e4690 = phi_3145_;
        let _e4692 = phi_3147_;
        let _e4694 = phi_3149_;
        let _e4696 = phi_3151_;
        let _e4698 = phi_3153_;
        let _e4700 = phi_3155_;
        continue;
        continuing {
            phi_3139_ = _e4688;
            phi_3142_ = _e4150;
            phi_3144_ = _e4690;
            phi_3146_ = _e4692;
            phi_3148_ = _e4694;
            phi_3150_ = _e4696;
            phi_3152_ = _e4698;
            phi_3154_ = _e4700;
            break if !(_e4147);
        }
    }
    let _e4703 = local_43;
    let _e4705 = local_44;
    let _e4708 = local_45;
    let _e4710 = local_46;
    let _e4713 = local_47;
    let _e4715 = local_48;
    let _e4721 = (sqrt(fma(_e4114, _e4114, fma(_e4112, _e4112, (_e4113 * _e4113)))) * 0.00001f);
    let _e4723 = select(_e4721, 0f, (_e4721 < 0f));
    let _e4725 = select(_e4723, 1f, (_e4723 > 1f));
    let _e4726 = (1f - _e4725);
    let _e4730 = fma(fma(_e4097, _e4703, _e4705), _e4726, (_e4097 * _e4725));
    let _e4731 = fma(fma(_e4098, _e4708, _e4710), _e4726, (_e4098 * _e4725));
    let _e4732 = fma(fma(_e4099, _e4713, _e4715), _e4726, (_e4099 * _e4725));
    if _e274 {
        phi_17461_ = vec2<f32>(-1f, -1f);
    } else {
        phi_17461_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e4737 = phi_17461_;
    if _e283 {
        phi_17501_ = vec2<f32>(-1f, -1f);
    } else {
        phi_17501_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e4743 = phi_17501_;
    let _e4745 = (_e144.x * _e4737.y);
    let _e4746 = (_e144.y * _e4737.y);
    let _e4747 = (_e144.z * _e4737.y);
    let _e4751 = fma(_e296, _e4737.y, (_e144.x + _e4743.y));
    let _e4752 = fma(_e298, _e4737.y, (_e144.y + _e4743.y));
    let _e4753 = fma(_e300, _e4737.y, (_e144.z + _e4743.y));
    let _e4754 = (_e4751 * 0.0625f);
    let _e4755 = (_e4752 * 0.0625f);
    let _e4756 = (_e4753 * 0.0625f);
    phi_3593_ = 1f;
    phi_3596_ = 0u;
    phi_3598_ = fma(_e4754, _e181, _e4745);
    phi_3600_ = fma(_e4755, _e181, _e4746);
    phi_3602_ = fma(_e4756, _e181, _e4747);
    phi_3604_ = 0f;
    phi_3606_ = 0f;
    phi_3608_ = 0f;
    loop {
        let _e4765 = phi_3593_;
        let _e4767 = phi_3596_;
        let _e4769 = phi_3598_;
        let _e4771 = phi_3600_;
        let _e4773 = phi_3602_;
        let _e4775 = phi_3604_;
        let _e4777 = phi_3606_;
        let _e4779 = phi_3608_;
        local_50 = _e4765;
        local_51 = _e4775;
        local_52 = _e4765;
        local_53 = _e4777;
        local_54 = _e4765;
        local_55 = _e4779;
        let _e4780 = (_e4767 < 16u);
        if _e4780 {
            phi_3597_ = (_e4767 + 1u);
        } else {
            phi_3597_ = _e4767;
        }
        let _e4783 = phi_3597_;
        if _e4780 {
            let _e4784 = (_e4771 + 6371000f);
            let _e4788 = sqrt(fma(_e4773, _e4773, fma(_e4769, _e4769, (_e4784 * _e4784))));
            let _e4789 = (_e4788 - 6371000f);
            if (_e4789 < 1600f) {
                phi_3724_ = f32();
                phi_3725_ = true;
            } else {
                let _e4791 = (_e4789 > 2100f);
                if _e4791 {
                    phi_3723_ = f32();
                } else {
                    let _e4795 = global_2.member.member[0u];
                    let _e4796 = (_e4795 * 0.02f);
                    let _e4797 = fma(_e4769, 0.001f, _e4796);
                    let _e4798 = fma(_e4773, 0.001f, _e4796);
                    let _e4799 = floor(_e4798);
                    let _e4800 = (_e4798 - _e4799);
                    let _e4801 = (_e4799 * 0.265625f);
                    let _e4802 = fma(_e4797, 0.015625f, _e4801);
                    let _e4803 = fma(_e4789, 0.000015625f, _e4801);
                    if (_e4802 > 0f) {
                        phi_17726_ = (_e4802 % 1f);
                    } else {
                        phi_17726_ = (1f - (-(_e4802) % 1f));
                    }
                    let _e4810 = phi_17726_;
                    if (_e4803 > 0f) {
                        phi_17739_ = (_e4803 % 1f);
                    } else {
                        phi_17739_ = (1f - (-(_e4803) % 1f));
                    }
                    let _e4817 = phi_17739_;
                    let _e4819 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4810, _e4817), 0f);
                    let _e4821 = (_e4802 + 0.265625f);
                    let _e4822 = (_e4803 + 0.265625f);
                    if (_e4821 > 0f) {
                        phi_17769_ = (_e4821 % 1f);
                    } else {
                        phi_17769_ = (1f - ((-0.265625f - _e4802) % 1f));
                    }
                    let _e4829 = phi_17769_;
                    if (_e4822 > 0f) {
                        phi_17782_ = (_e4822 % 1f);
                    } else {
                        phi_17782_ = (1f - ((-0.265625f - _e4803) % 1f));
                    }
                    let _e4836 = phi_17782_;
                    let _e4838 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4829, _e4836), 0f);
                    let _e4843 = fma(_e4795, 0.02f, 2f);
                    let _e4846 = floor((_e4798 * _e4843));
                    let _e4848 = fma(_e4798, _e4843, -(_e4846));
                    let _e4849 = (_e4846 * 0.265625f);
                    let _e4850 = fma((_e4797 * _e4843), 0.015625f, _e4849);
                    let _e4851 = fma(_e4789, 0.00003125f, _e4849);
                    if (_e4850 > 0f) {
                        phi_17842_ = (_e4850 % 1f);
                    } else {
                        phi_17842_ = (1f - (-(_e4850) % 1f));
                    }
                    let _e4858 = phi_17842_;
                    if (_e4851 > 0f) {
                        phi_17855_ = (_e4851 % 1f);
                    } else {
                        phi_17855_ = (1f - (-(_e4851) % 1f));
                    }
                    let _e4865 = phi_17855_;
                    let _e4867 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4858, _e4865), 0f);
                    let _e4869 = (_e4850 + 0.265625f);
                    let _e4870 = (_e4851 + 0.265625f);
                    if (_e4869 > 0f) {
                        phi_17885_ = (_e4869 % 1f);
                    } else {
                        phi_17885_ = (1f - ((-0.265625f - _e4850) % 1f));
                    }
                    let _e4877 = phi_17885_;
                    if (_e4870 > 0f) {
                        phi_17898_ = (_e4870 % 1f);
                    } else {
                        phi_17898_ = (1f - ((-0.265625f - _e4851) % 1f));
                    }
                    let _e4884 = phi_17898_;
                    let _e4886 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4877, _e4884), 0f);
                    let _e4894 = fma(-(_e4795), 0.02f, 7f);
                    let _e4897 = floor((_e4798 * _e4894));
                    let _e4899 = fma(_e4798, _e4894, -(_e4897));
                    let _e4900 = (_e4897 * 0.265625f);
                    let _e4901 = fma((_e4797 * _e4894), 0.015625f, _e4900);
                    let _e4902 = fma(_e4789, 0.000109375f, _e4900);
                    if (_e4901 > 0f) {
                        phi_17958_ = (_e4901 % 1f);
                    } else {
                        phi_17958_ = (1f - (-(_e4901) % 1f));
                    }
                    let _e4909 = phi_17958_;
                    if (_e4902 > 0f) {
                        phi_17971_ = (_e4902 % 1f);
                    } else {
                        phi_17971_ = (1f - (-(_e4902) % 1f));
                    }
                    let _e4916 = phi_17971_;
                    let _e4918 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4909, _e4916), 0f);
                    let _e4920 = (_e4901 + 0.265625f);
                    let _e4921 = (_e4902 + 0.265625f);
                    if (_e4920 > 0f) {
                        phi_18001_ = (_e4920 % 1f);
                    } else {
                        phi_18001_ = (1f - ((-0.265625f - _e4901) % 1f));
                    }
                    let _e4928 = phi_18001_;
                    if (_e4921 > 0f) {
                        phi_18014_ = (_e4921 % 1f);
                    } else {
                        phi_18014_ = (1f - ((-0.265625f - _e4902) % 1f));
                    }
                    let _e4935 = phi_18014_;
                    let _e4937 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4928, _e4935), 0f);
                    let _e4944 = fma(_e4795, 0.02f, _e4798);
                    let _e4946 = floor((_e4944 * 16f));
                    let _e4948 = fma(_e4944, 16f, -(_e4946));
                    let _e4949 = (_e4946 * 0.265625f);
                    let _e4950 = fma(fma(_e4795, 0.02f, _e4797), 0.25f, _e4949);
                    let _e4951 = fma(_e4789, 0.00025f, _e4949);
                    if (_e4950 > 0f) {
                        phi_18074_ = (_e4950 % 1f);
                    } else {
                        phi_18074_ = (1f - (-(_e4950) % 1f));
                    }
                    let _e4958 = phi_18074_;
                    if (_e4951 > 0f) {
                        phi_18087_ = (_e4951 % 1f);
                    } else {
                        phi_18087_ = (1f - (-(_e4951) % 1f));
                    }
                    let _e4965 = phi_18087_;
                    let _e4967 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4958, _e4965), 0f);
                    let _e4969 = (_e4950 + 0.265625f);
                    let _e4970 = (_e4951 + 0.265625f);
                    if (_e4969 > 0f) {
                        phi_18117_ = (_e4969 % 1f);
                    } else {
                        phi_18117_ = (1f - ((-0.265625f - _e4950) % 1f));
                    }
                    let _e4977 = phi_18117_;
                    if (_e4970 > 0f) {
                        phi_18130_ = (_e4970 % 1f);
                    } else {
                        phi_18130_ = (1f - ((-0.265625f - _e4951) % 1f));
                    }
                    let _e4984 = phi_18130_;
                    let _e4986 = textureSampleLevel(global_3, global_4, vec2<f32>(_e4977, _e4984), 0f);
                    let _e4992 = (_e4788 - 6372600f);
                    let _e5000 = ((fma(fma(_e4967.x, (1f - _e4948), (_e4986.x * _e4948)), 0.0625f, fma(fma(_e4918.x, (1f - _e4899), (_e4937.x * _e4899)), 0.125f, fma(fma(_e4819.x, (1f - _e4800), (_e4838.x * _e4800)), 0.5f, (fma(_e4867.x, (1f - _e4848), (_e4886.x * _e4848)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e5002 = select(_e5000, 0f, (_e5000 < 0f));
                    let _e5004 = select(_e5002, 1f, (_e5002 > 1f));
                    phi_3723_ = ((((_e5004 * _e5004) * fma(-2f, _e5004, 3f)) * ((1f - exp2((-0.01f * _e4992))) * exp2((-0.004f * _e4992)))) * 0.03f);
                }
                let _e5011 = phi_3723_;
                phi_3724_ = _e5011;
                phi_3725_ = _e4791;
            }
            let _e5013 = phi_3724_;
            let _e5015 = phi_3725_;
            let _e5017 = (select(_e5013, 0f, _e5015) * sqrt(fma(_e4756, _e4756, fma(_e4754, _e4754, (_e4755 * _e4755)))));
            if (_e5017 <= 0f) {
                phi_3933_ = _e4765;
                phi_3934_ = _e4769;
                phi_3935_ = _e4771;
                phi_3936_ = _e4773;
                phi_3937_ = _e4775;
                phi_3938_ = _e4777;
                phi_3939_ = _e4779;
            } else {
                let _e5021 = fma(exp2((-1.6013916f * _e5017)), -0.9009009f, 0.9009009f);
                let _e5024 = (1f - exp2((_e5017 * -1.3862944f)));
                let _e5025 = (-9.537895f + _e4769);
                let _e5026 = (29.354609f + _e4773);
                phi_3756_ = 0f;
                phi_3759_ = 0u;
                loop {
                    let _e5028 = phi_3756_;
                    let _e5030 = phi_3759_;
                    local_49 = _e5028;
                    let _e5031 = (_e5030 < 8u);
                    if _e5031 {
                        phi_3760_ = (_e5030 + 1u);
                    } else {
                        phi_3760_ = _e5030;
                    }
                    let _e5034 = phi_3760_;
                    if _e5031 {
                        let _e5035 = (_e4771 + 6371005f);
                        let _e5039 = sqrt(fma(_e5026, _e5026, fma(_e5025, _e5025, (_e5035 * _e5035))));
                        let _e5040 = (_e5039 - 6371000f);
                        if (_e5040 < 1600f) {
                            phi_3875_ = f32();
                            phi_3876_ = true;
                        } else {
                            let _e5042 = (_e5040 > 2100f);
                            if _e5042 {
                                phi_3874_ = f32();
                            } else {
                                let _e5046 = global_2.member.member[0u];
                                let _e5047 = (_e5046 * 0.02f);
                                let _e5048 = fma(_e5025, 0.001f, _e5047);
                                let _e5049 = fma(_e5026, 0.001f, _e5047);
                                let _e5050 = floor(_e5049);
                                let _e5051 = (_e5049 - _e5050);
                                let _e5052 = (_e5050 * 0.265625f);
                                let _e5053 = fma(_e5048, 0.015625f, _e5052);
                                let _e5054 = fma(_e5040, 0.000015625f, _e5052);
                                if (_e5053 > 0f) {
                                    phi_18206_ = (_e5053 % 1f);
                                } else {
                                    phi_18206_ = (1f - (-(_e5053) % 1f));
                                }
                                let _e5061 = phi_18206_;
                                if (_e5054 > 0f) {
                                    phi_18219_ = (_e5054 % 1f);
                                } else {
                                    phi_18219_ = (1f - (-(_e5054) % 1f));
                                }
                                let _e5068 = phi_18219_;
                                let _e5070 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5061, _e5068), 0f);
                                let _e5072 = (_e5053 + 0.265625f);
                                let _e5073 = (_e5054 + 0.265625f);
                                if (_e5072 > 0f) {
                                    phi_18249_ = (_e5072 % 1f);
                                } else {
                                    phi_18249_ = (1f - ((-0.265625f - _e5053) % 1f));
                                }
                                let _e5080 = phi_18249_;
                                if (_e5073 > 0f) {
                                    phi_18262_ = (_e5073 % 1f);
                                } else {
                                    phi_18262_ = (1f - ((-0.265625f - _e5054) % 1f));
                                }
                                let _e5087 = phi_18262_;
                                let _e5089 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5080, _e5087), 0f);
                                let _e5094 = fma(_e5046, 0.02f, 2f);
                                let _e5097 = floor((_e5049 * _e5094));
                                let _e5099 = fma(_e5049, _e5094, -(_e5097));
                                let _e5100 = (_e5097 * 0.265625f);
                                let _e5101 = fma((_e5048 * _e5094), 0.015625f, _e5100);
                                let _e5102 = fma(_e5040, 0.00003125f, _e5100);
                                if (_e5101 > 0f) {
                                    phi_18322_ = (_e5101 % 1f);
                                } else {
                                    phi_18322_ = (1f - (-(_e5101) % 1f));
                                }
                                let _e5109 = phi_18322_;
                                if (_e5102 > 0f) {
                                    phi_18335_ = (_e5102 % 1f);
                                } else {
                                    phi_18335_ = (1f - (-(_e5102) % 1f));
                                }
                                let _e5116 = phi_18335_;
                                let _e5118 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5109, _e5116), 0f);
                                let _e5120 = (_e5101 + 0.265625f);
                                let _e5121 = (_e5102 + 0.265625f);
                                if (_e5120 > 0f) {
                                    phi_18365_ = (_e5120 % 1f);
                                } else {
                                    phi_18365_ = (1f - ((-0.265625f - _e5101) % 1f));
                                }
                                let _e5128 = phi_18365_;
                                if (_e5121 > 0f) {
                                    phi_18378_ = (_e5121 % 1f);
                                } else {
                                    phi_18378_ = (1f - ((-0.265625f - _e5102) % 1f));
                                }
                                let _e5135 = phi_18378_;
                                let _e5137 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5128, _e5135), 0f);
                                let _e5145 = fma(-(_e5046), 0.02f, 7f);
                                let _e5148 = floor((_e5049 * _e5145));
                                let _e5150 = fma(_e5049, _e5145, -(_e5148));
                                let _e5151 = (_e5148 * 0.265625f);
                                let _e5152 = fma((_e5048 * _e5145), 0.015625f, _e5151);
                                let _e5153 = fma(_e5040, 0.000109375f, _e5151);
                                if (_e5152 > 0f) {
                                    phi_18438_ = (_e5152 % 1f);
                                } else {
                                    phi_18438_ = (1f - (-(_e5152) % 1f));
                                }
                                let _e5160 = phi_18438_;
                                if (_e5153 > 0f) {
                                    phi_18451_ = (_e5153 % 1f);
                                } else {
                                    phi_18451_ = (1f - (-(_e5153) % 1f));
                                }
                                let _e5167 = phi_18451_;
                                let _e5169 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5160, _e5167), 0f);
                                let _e5171 = (_e5152 + 0.265625f);
                                let _e5172 = (_e5153 + 0.265625f);
                                if (_e5171 > 0f) {
                                    phi_18481_ = (_e5171 % 1f);
                                } else {
                                    phi_18481_ = (1f - ((-0.265625f - _e5152) % 1f));
                                }
                                let _e5179 = phi_18481_;
                                if (_e5172 > 0f) {
                                    phi_18494_ = (_e5172 % 1f);
                                } else {
                                    phi_18494_ = (1f - ((-0.265625f - _e5153) % 1f));
                                }
                                let _e5186 = phi_18494_;
                                let _e5188 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5179, _e5186), 0f);
                                let _e5195 = fma(_e5046, 0.02f, _e5049);
                                let _e5197 = floor((_e5195 * 16f));
                                let _e5199 = fma(_e5195, 16f, -(_e5197));
                                let _e5200 = (_e5197 * 0.265625f);
                                let _e5201 = fma(fma(_e5046, 0.02f, _e5048), 0.25f, _e5200);
                                let _e5202 = fma(_e5040, 0.00025f, _e5200);
                                if (_e5201 > 0f) {
                                    phi_18554_ = (_e5201 % 1f);
                                } else {
                                    phi_18554_ = (1f - (-(_e5201) % 1f));
                                }
                                let _e5209 = phi_18554_;
                                if (_e5202 > 0f) {
                                    phi_18567_ = (_e5202 % 1f);
                                } else {
                                    phi_18567_ = (1f - (-(_e5202) % 1f));
                                }
                                let _e5216 = phi_18567_;
                                let _e5218 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5209, _e5216), 0f);
                                let _e5220 = (_e5201 + 0.265625f);
                                let _e5221 = (_e5202 + 0.265625f);
                                if (_e5220 > 0f) {
                                    phi_18597_ = (_e5220 % 1f);
                                } else {
                                    phi_18597_ = (1f - ((-0.265625f - _e5201) % 1f));
                                }
                                let _e5228 = phi_18597_;
                                if (_e5221 > 0f) {
                                    phi_18610_ = (_e5221 % 1f);
                                } else {
                                    phi_18610_ = (1f - ((-0.265625f - _e5202) % 1f));
                                }
                                let _e5235 = phi_18610_;
                                let _e5237 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5228, _e5235), 0f);
                                let _e5243 = (_e5039 - 6372600f);
                                let _e5251 = ((fma(fma(_e5218.x, (1f - _e5199), (_e5237.x * _e5199)), 0.0625f, fma(fma(_e5169.x, (1f - _e5150), (_e5188.x * _e5150)), 0.125f, fma(fma(_e5070.x, (1f - _e5051), (_e5089.x * _e5051)), 0.5f, (fma(_e5118.x, (1f - _e5099), (_e5137.x * _e5099)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e5253 = select(_e5251, 0f, (_e5251 < 0f));
                                let _e5255 = select(_e5253, 1f, (_e5253 > 1f));
                                phi_3874_ = ((((_e5255 * _e5255) * fma(-2f, _e5255, 3f)) * ((1f - exp2((-0.01f * _e5243))) * exp2((-0.004f * _e5243)))) * 0.03f);
                            }
                            let _e5262 = phi_3874_;
                            phi_3875_ = _e5262;
                            phi_3876_ = _e5042;
                        }
                        let _e5264 = phi_3875_;
                        let _e5266 = phi_3876_;
                        phi_3757_ = (_e5028 + select(_e5264, 0f, _e5266));
                    } else {
                        phi_3757_ = f32();
                    }
                    let _e5270 = phi_3757_;
                    continue;
                    continuing {
                        phi_3756_ = _e5270;
                        phi_3759_ = _e5034;
                        break if !(_e5031);
                    }
                }
                let _e5273 = local_49;
                let _e5275 = exp2((_e5273 * -62.5f));
                phi_3933_ = (_e4765 * exp2(-(_e5017)));
                phi_3934_ = fma(_e4751, 0.0625f, _e4769);
                phi_3935_ = fma(_e4752, 0.0625f, _e4771);
                phi_3936_ = fma(_e4753, 0.0625f, _e4773);
                phi_3937_ = fma(((fma((((0.4807763f * _e5275) * _e5024) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e5021) * 3.1415927f), _e4765, _e4775);
                phi_3938_ = fma(((fma((((0.28401393f * _e5275) * _e5024) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e5021) * 3.1415927f), _e4765, _e4777);
                phi_3939_ = fma(((fma((((0.09044314f * _e5275) * _e5024) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e5021) * 3.1415927f), _e4765, _e4779);
            }
            let _e5307 = phi_3933_;
            let _e5309 = phi_3934_;
            let _e5311 = phi_3935_;
            let _e5313 = phi_3936_;
            let _e5315 = phi_3937_;
            let _e5317 = phi_3938_;
            let _e5319 = phi_3939_;
            phi_3594_ = _e5307;
            phi_3599_ = _e5309;
            phi_3601_ = _e5311;
            phi_3603_ = _e5313;
            phi_3605_ = _e5315;
            phi_3607_ = _e5317;
            phi_3609_ = _e5319;
        } else {
            phi_3594_ = f32();
            phi_3599_ = f32();
            phi_3601_ = f32();
            phi_3603_ = f32();
            phi_3605_ = f32();
            phi_3607_ = f32();
            phi_3609_ = f32();
        }
        let _e5321 = phi_3594_;
        let _e5323 = phi_3599_;
        let _e5325 = phi_3601_;
        let _e5327 = phi_3603_;
        let _e5329 = phi_3605_;
        let _e5331 = phi_3607_;
        let _e5333 = phi_3609_;
        continue;
        continuing {
            phi_3593_ = _e5321;
            phi_3596_ = _e4783;
            phi_3598_ = _e5323;
            phi_3600_ = _e5325;
            phi_3602_ = _e5327;
            phi_3604_ = _e5329;
            phi_3606_ = _e5331;
            phi_3608_ = _e5333;
            break if !(_e4780);
        }
    }
    let _e5336 = local_50;
    let _e5338 = local_51;
    let _e5341 = local_52;
    let _e5343 = local_53;
    let _e5346 = local_54;
    let _e5348 = local_55;
    let _e5354 = (sqrt(fma(_e4747, _e4747, fma(_e4745, _e4745, (_e4746 * _e4746)))) * 0.00001f);
    let _e5356 = select(_e5354, 0f, (_e5354 < 0f));
    let _e5358 = select(_e5356, 1f, (_e5356 > 1f));
    let _e5359 = (1f - _e5358);
    let _e5363 = fma(fma(_e4730, _e5336, _e5338), _e5359, (_e4730 * _e5358));
    let _e5364 = fma(fma(_e4731, _e5341, _e5343), _e5359, (_e4731 * _e5358));
    let _e5365 = fma(fma(_e4732, _e5346, _e5348), _e5359, (_e4732 * _e5358));
    if _e274 {
        phi_18684_ = vec2<f32>(-1f, -1f);
    } else {
        phi_18684_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e5370 = phi_18684_;
    if _e283 {
        phi_18724_ = vec2<f32>(-1f, -1f);
    } else {
        phi_18724_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e5376 = phi_18724_;
    let _e5378 = (_e144.x * _e5370.y);
    let _e5379 = (_e144.y * _e5370.y);
    let _e5380 = (_e144.z * _e5370.y);
    let _e5384 = fma(_e296, _e5370.y, (_e144.x + _e5376.y));
    let _e5385 = fma(_e298, _e5370.y, (_e144.y + _e5376.y));
    let _e5386 = fma(_e300, _e5370.y, (_e144.z + _e5376.y));
    let _e5387 = (_e5384 * 0.0625f);
    let _e5388 = (_e5385 * 0.0625f);
    let _e5389 = (_e5386 * 0.0625f);
    phi_4047_ = 1f;
    phi_4050_ = 0u;
    phi_4052_ = fma(_e5387, _e181, _e5378);
    phi_4054_ = fma(_e5388, _e181, _e5379);
    phi_4056_ = fma(_e5389, _e181, _e5380);
    phi_4058_ = 0f;
    phi_4060_ = 0f;
    phi_4062_ = 0f;
    loop {
        let _e5398 = phi_4047_;
        let _e5400 = phi_4050_;
        let _e5402 = phi_4052_;
        let _e5404 = phi_4054_;
        let _e5406 = phi_4056_;
        let _e5408 = phi_4058_;
        let _e5410 = phi_4060_;
        let _e5412 = phi_4062_;
        local_57 = _e5398;
        local_58 = _e5408;
        local_59 = _e5398;
        local_60 = _e5410;
        local_61 = _e5398;
        local_62 = _e5412;
        let _e5413 = (_e5400 < 16u);
        if _e5413 {
            phi_4051_ = (_e5400 + 1u);
        } else {
            phi_4051_ = _e5400;
        }
        let _e5416 = phi_4051_;
        if _e5413 {
            let _e5417 = (_e5404 + 6371000f);
            let _e5421 = sqrt(fma(_e5406, _e5406, fma(_e5402, _e5402, (_e5417 * _e5417))));
            let _e5422 = (_e5421 - 6371000f);
            if (_e5422 < 1600f) {
                phi_4178_ = f32();
                phi_4179_ = true;
            } else {
                let _e5424 = (_e5422 > 2100f);
                if _e5424 {
                    phi_4177_ = f32();
                } else {
                    let _e5428 = global_2.member.member[0u];
                    let _e5429 = (_e5428 * 0.02f);
                    let _e5430 = fma(_e5402, 0.001f, _e5429);
                    let _e5431 = fma(_e5406, 0.001f, _e5429);
                    let _e5432 = floor(_e5431);
                    let _e5433 = (_e5431 - _e5432);
                    let _e5434 = (_e5432 * 0.265625f);
                    let _e5435 = fma(_e5430, 0.015625f, _e5434);
                    let _e5436 = fma(_e5422, 0.000015625f, _e5434);
                    if (_e5435 > 0f) {
                        phi_18949_ = (_e5435 % 1f);
                    } else {
                        phi_18949_ = (1f - (-(_e5435) % 1f));
                    }
                    let _e5443 = phi_18949_;
                    if (_e5436 > 0f) {
                        phi_18962_ = (_e5436 % 1f);
                    } else {
                        phi_18962_ = (1f - (-(_e5436) % 1f));
                    }
                    let _e5450 = phi_18962_;
                    let _e5452 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5443, _e5450), 0f);
                    let _e5454 = (_e5435 + 0.265625f);
                    let _e5455 = (_e5436 + 0.265625f);
                    if (_e5454 > 0f) {
                        phi_18992_ = (_e5454 % 1f);
                    } else {
                        phi_18992_ = (1f - ((-0.265625f - _e5435) % 1f));
                    }
                    let _e5462 = phi_18992_;
                    if (_e5455 > 0f) {
                        phi_19005_ = (_e5455 % 1f);
                    } else {
                        phi_19005_ = (1f - ((-0.265625f - _e5436) % 1f));
                    }
                    let _e5469 = phi_19005_;
                    let _e5471 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5462, _e5469), 0f);
                    let _e5476 = fma(_e5428, 0.02f, 2f);
                    let _e5479 = floor((_e5431 * _e5476));
                    let _e5481 = fma(_e5431, _e5476, -(_e5479));
                    let _e5482 = (_e5479 * 0.265625f);
                    let _e5483 = fma((_e5430 * _e5476), 0.015625f, _e5482);
                    let _e5484 = fma(_e5422, 0.00003125f, _e5482);
                    if (_e5483 > 0f) {
                        phi_19065_ = (_e5483 % 1f);
                    } else {
                        phi_19065_ = (1f - (-(_e5483) % 1f));
                    }
                    let _e5491 = phi_19065_;
                    if (_e5484 > 0f) {
                        phi_19078_ = (_e5484 % 1f);
                    } else {
                        phi_19078_ = (1f - (-(_e5484) % 1f));
                    }
                    let _e5498 = phi_19078_;
                    let _e5500 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5491, _e5498), 0f);
                    let _e5502 = (_e5483 + 0.265625f);
                    let _e5503 = (_e5484 + 0.265625f);
                    if (_e5502 > 0f) {
                        phi_19108_ = (_e5502 % 1f);
                    } else {
                        phi_19108_ = (1f - ((-0.265625f - _e5483) % 1f));
                    }
                    let _e5510 = phi_19108_;
                    if (_e5503 > 0f) {
                        phi_19121_ = (_e5503 % 1f);
                    } else {
                        phi_19121_ = (1f - ((-0.265625f - _e5484) % 1f));
                    }
                    let _e5517 = phi_19121_;
                    let _e5519 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5510, _e5517), 0f);
                    let _e5527 = fma(-(_e5428), 0.02f, 7f);
                    let _e5530 = floor((_e5431 * _e5527));
                    let _e5532 = fma(_e5431, _e5527, -(_e5530));
                    let _e5533 = (_e5530 * 0.265625f);
                    let _e5534 = fma((_e5430 * _e5527), 0.015625f, _e5533);
                    let _e5535 = fma(_e5422, 0.000109375f, _e5533);
                    if (_e5534 > 0f) {
                        phi_19181_ = (_e5534 % 1f);
                    } else {
                        phi_19181_ = (1f - (-(_e5534) % 1f));
                    }
                    let _e5542 = phi_19181_;
                    if (_e5535 > 0f) {
                        phi_19194_ = (_e5535 % 1f);
                    } else {
                        phi_19194_ = (1f - (-(_e5535) % 1f));
                    }
                    let _e5549 = phi_19194_;
                    let _e5551 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5542, _e5549), 0f);
                    let _e5553 = (_e5534 + 0.265625f);
                    let _e5554 = (_e5535 + 0.265625f);
                    if (_e5553 > 0f) {
                        phi_19224_ = (_e5553 % 1f);
                    } else {
                        phi_19224_ = (1f - ((-0.265625f - _e5534) % 1f));
                    }
                    let _e5561 = phi_19224_;
                    if (_e5554 > 0f) {
                        phi_19237_ = (_e5554 % 1f);
                    } else {
                        phi_19237_ = (1f - ((-0.265625f - _e5535) % 1f));
                    }
                    let _e5568 = phi_19237_;
                    let _e5570 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5561, _e5568), 0f);
                    let _e5577 = fma(_e5428, 0.02f, _e5431);
                    let _e5579 = floor((_e5577 * 16f));
                    let _e5581 = fma(_e5577, 16f, -(_e5579));
                    let _e5582 = (_e5579 * 0.265625f);
                    let _e5583 = fma(fma(_e5428, 0.02f, _e5430), 0.25f, _e5582);
                    let _e5584 = fma(_e5422, 0.00025f, _e5582);
                    if (_e5583 > 0f) {
                        phi_19297_ = (_e5583 % 1f);
                    } else {
                        phi_19297_ = (1f - (-(_e5583) % 1f));
                    }
                    let _e5591 = phi_19297_;
                    if (_e5584 > 0f) {
                        phi_19310_ = (_e5584 % 1f);
                    } else {
                        phi_19310_ = (1f - (-(_e5584) % 1f));
                    }
                    let _e5598 = phi_19310_;
                    let _e5600 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5591, _e5598), 0f);
                    let _e5602 = (_e5583 + 0.265625f);
                    let _e5603 = (_e5584 + 0.265625f);
                    if (_e5602 > 0f) {
                        phi_19340_ = (_e5602 % 1f);
                    } else {
                        phi_19340_ = (1f - ((-0.265625f - _e5583) % 1f));
                    }
                    let _e5610 = phi_19340_;
                    if (_e5603 > 0f) {
                        phi_19353_ = (_e5603 % 1f);
                    } else {
                        phi_19353_ = (1f - ((-0.265625f - _e5584) % 1f));
                    }
                    let _e5617 = phi_19353_;
                    let _e5619 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5610, _e5617), 0f);
                    let _e5625 = (_e5421 - 6372600f);
                    let _e5633 = ((fma(fma(_e5600.x, (1f - _e5581), (_e5619.x * _e5581)), 0.0625f, fma(fma(_e5551.x, (1f - _e5532), (_e5570.x * _e5532)), 0.125f, fma(fma(_e5452.x, (1f - _e5433), (_e5471.x * _e5433)), 0.5f, (fma(_e5500.x, (1f - _e5481), (_e5519.x * _e5481)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e5635 = select(_e5633, 0f, (_e5633 < 0f));
                    let _e5637 = select(_e5635, 1f, (_e5635 > 1f));
                    phi_4177_ = ((((_e5637 * _e5637) * fma(-2f, _e5637, 3f)) * ((1f - exp2((-0.01f * _e5625))) * exp2((-0.004f * _e5625)))) * 0.03f);
                }
                let _e5644 = phi_4177_;
                phi_4178_ = _e5644;
                phi_4179_ = _e5424;
            }
            let _e5646 = phi_4178_;
            let _e5648 = phi_4179_;
            let _e5650 = (select(_e5646, 0f, _e5648) * sqrt(fma(_e5389, _e5389, fma(_e5387, _e5387, (_e5388 * _e5388)))));
            if (_e5650 <= 0f) {
                phi_4387_ = _e5398;
                phi_4388_ = _e5402;
                phi_4389_ = _e5404;
                phi_4390_ = _e5406;
                phi_4391_ = _e5408;
                phi_4392_ = _e5410;
                phi_4393_ = _e5412;
            } else {
                let _e5654 = fma(exp2((-1.6013916f * _e5650)), -0.9009009f, 0.9009009f);
                let _e5657 = (1f - exp2((_e5650 * -1.3862944f)));
                let _e5658 = (-9.537895f + _e5402);
                let _e5659 = (29.354609f + _e5406);
                phi_4210_ = 0f;
                phi_4213_ = 0u;
                loop {
                    let _e5661 = phi_4210_;
                    let _e5663 = phi_4213_;
                    local_56 = _e5661;
                    let _e5664 = (_e5663 < 8u);
                    if _e5664 {
                        phi_4214_ = (_e5663 + 1u);
                    } else {
                        phi_4214_ = _e5663;
                    }
                    let _e5667 = phi_4214_;
                    if _e5664 {
                        let _e5668 = (_e5404 + 6371005f);
                        let _e5672 = sqrt(fma(_e5659, _e5659, fma(_e5658, _e5658, (_e5668 * _e5668))));
                        let _e5673 = (_e5672 - 6371000f);
                        if (_e5673 < 1600f) {
                            phi_4329_ = f32();
                            phi_4330_ = true;
                        } else {
                            let _e5675 = (_e5673 > 2100f);
                            if _e5675 {
                                phi_4328_ = f32();
                            } else {
                                let _e5679 = global_2.member.member[0u];
                                let _e5680 = (_e5679 * 0.02f);
                                let _e5681 = fma(_e5658, 0.001f, _e5680);
                                let _e5682 = fma(_e5659, 0.001f, _e5680);
                                let _e5683 = floor(_e5682);
                                let _e5684 = (_e5682 - _e5683);
                                let _e5685 = (_e5683 * 0.265625f);
                                let _e5686 = fma(_e5681, 0.015625f, _e5685);
                                let _e5687 = fma(_e5673, 0.000015625f, _e5685);
                                if (_e5686 > 0f) {
                                    phi_19429_ = (_e5686 % 1f);
                                } else {
                                    phi_19429_ = (1f - (-(_e5686) % 1f));
                                }
                                let _e5694 = phi_19429_;
                                if (_e5687 > 0f) {
                                    phi_19442_ = (_e5687 % 1f);
                                } else {
                                    phi_19442_ = (1f - (-(_e5687) % 1f));
                                }
                                let _e5701 = phi_19442_;
                                let _e5703 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5694, _e5701), 0f);
                                let _e5705 = (_e5686 + 0.265625f);
                                let _e5706 = (_e5687 + 0.265625f);
                                if (_e5705 > 0f) {
                                    phi_19472_ = (_e5705 % 1f);
                                } else {
                                    phi_19472_ = (1f - ((-0.265625f - _e5686) % 1f));
                                }
                                let _e5713 = phi_19472_;
                                if (_e5706 > 0f) {
                                    phi_19485_ = (_e5706 % 1f);
                                } else {
                                    phi_19485_ = (1f - ((-0.265625f - _e5687) % 1f));
                                }
                                let _e5720 = phi_19485_;
                                let _e5722 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5713, _e5720), 0f);
                                let _e5727 = fma(_e5679, 0.02f, 2f);
                                let _e5730 = floor((_e5682 * _e5727));
                                let _e5732 = fma(_e5682, _e5727, -(_e5730));
                                let _e5733 = (_e5730 * 0.265625f);
                                let _e5734 = fma((_e5681 * _e5727), 0.015625f, _e5733);
                                let _e5735 = fma(_e5673, 0.00003125f, _e5733);
                                if (_e5734 > 0f) {
                                    phi_19545_ = (_e5734 % 1f);
                                } else {
                                    phi_19545_ = (1f - (-(_e5734) % 1f));
                                }
                                let _e5742 = phi_19545_;
                                if (_e5735 > 0f) {
                                    phi_19558_ = (_e5735 % 1f);
                                } else {
                                    phi_19558_ = (1f - (-(_e5735) % 1f));
                                }
                                let _e5749 = phi_19558_;
                                let _e5751 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5742, _e5749), 0f);
                                let _e5753 = (_e5734 + 0.265625f);
                                let _e5754 = (_e5735 + 0.265625f);
                                if (_e5753 > 0f) {
                                    phi_19588_ = (_e5753 % 1f);
                                } else {
                                    phi_19588_ = (1f - ((-0.265625f - _e5734) % 1f));
                                }
                                let _e5761 = phi_19588_;
                                if (_e5754 > 0f) {
                                    phi_19601_ = (_e5754 % 1f);
                                } else {
                                    phi_19601_ = (1f - ((-0.265625f - _e5735) % 1f));
                                }
                                let _e5768 = phi_19601_;
                                let _e5770 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5761, _e5768), 0f);
                                let _e5778 = fma(-(_e5679), 0.02f, 7f);
                                let _e5781 = floor((_e5682 * _e5778));
                                let _e5783 = fma(_e5682, _e5778, -(_e5781));
                                let _e5784 = (_e5781 * 0.265625f);
                                let _e5785 = fma((_e5681 * _e5778), 0.015625f, _e5784);
                                let _e5786 = fma(_e5673, 0.000109375f, _e5784);
                                if (_e5785 > 0f) {
                                    phi_19661_ = (_e5785 % 1f);
                                } else {
                                    phi_19661_ = (1f - (-(_e5785) % 1f));
                                }
                                let _e5793 = phi_19661_;
                                if (_e5786 > 0f) {
                                    phi_19674_ = (_e5786 % 1f);
                                } else {
                                    phi_19674_ = (1f - (-(_e5786) % 1f));
                                }
                                let _e5800 = phi_19674_;
                                let _e5802 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5793, _e5800), 0f);
                                let _e5804 = (_e5785 + 0.265625f);
                                let _e5805 = (_e5786 + 0.265625f);
                                if (_e5804 > 0f) {
                                    phi_19704_ = (_e5804 % 1f);
                                } else {
                                    phi_19704_ = (1f - ((-0.265625f - _e5785) % 1f));
                                }
                                let _e5812 = phi_19704_;
                                if (_e5805 > 0f) {
                                    phi_19717_ = (_e5805 % 1f);
                                } else {
                                    phi_19717_ = (1f - ((-0.265625f - _e5786) % 1f));
                                }
                                let _e5819 = phi_19717_;
                                let _e5821 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5812, _e5819), 0f);
                                let _e5828 = fma(_e5679, 0.02f, _e5682);
                                let _e5830 = floor((_e5828 * 16f));
                                let _e5832 = fma(_e5828, 16f, -(_e5830));
                                let _e5833 = (_e5830 * 0.265625f);
                                let _e5834 = fma(fma(_e5679, 0.02f, _e5681), 0.25f, _e5833);
                                let _e5835 = fma(_e5673, 0.00025f, _e5833);
                                if (_e5834 > 0f) {
                                    phi_19777_ = (_e5834 % 1f);
                                } else {
                                    phi_19777_ = (1f - (-(_e5834) % 1f));
                                }
                                let _e5842 = phi_19777_;
                                if (_e5835 > 0f) {
                                    phi_19790_ = (_e5835 % 1f);
                                } else {
                                    phi_19790_ = (1f - (-(_e5835) % 1f));
                                }
                                let _e5849 = phi_19790_;
                                let _e5851 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5842, _e5849), 0f);
                                let _e5853 = (_e5834 + 0.265625f);
                                let _e5854 = (_e5835 + 0.265625f);
                                if (_e5853 > 0f) {
                                    phi_19820_ = (_e5853 % 1f);
                                } else {
                                    phi_19820_ = (1f - ((-0.265625f - _e5834) % 1f));
                                }
                                let _e5861 = phi_19820_;
                                if (_e5854 > 0f) {
                                    phi_19833_ = (_e5854 % 1f);
                                } else {
                                    phi_19833_ = (1f - ((-0.265625f - _e5835) % 1f));
                                }
                                let _e5868 = phi_19833_;
                                let _e5870 = textureSampleLevel(global_3, global_4, vec2<f32>(_e5861, _e5868), 0f);
                                let _e5876 = (_e5672 - 6372600f);
                                let _e5884 = ((fma(fma(_e5851.x, (1f - _e5832), (_e5870.x * _e5832)), 0.0625f, fma(fma(_e5802.x, (1f - _e5783), (_e5821.x * _e5783)), 0.125f, fma(fma(_e5703.x, (1f - _e5684), (_e5722.x * _e5684)), 0.5f, (fma(_e5751.x, (1f - _e5732), (_e5770.x * _e5732)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e5886 = select(_e5884, 0f, (_e5884 < 0f));
                                let _e5888 = select(_e5886, 1f, (_e5886 > 1f));
                                phi_4328_ = ((((_e5888 * _e5888) * fma(-2f, _e5888, 3f)) * ((1f - exp2((-0.01f * _e5876))) * exp2((-0.004f * _e5876)))) * 0.03f);
                            }
                            let _e5895 = phi_4328_;
                            phi_4329_ = _e5895;
                            phi_4330_ = _e5675;
                        }
                        let _e5897 = phi_4329_;
                        let _e5899 = phi_4330_;
                        phi_4211_ = (_e5661 + select(_e5897, 0f, _e5899));
                    } else {
                        phi_4211_ = f32();
                    }
                    let _e5903 = phi_4211_;
                    continue;
                    continuing {
                        phi_4210_ = _e5903;
                        phi_4213_ = _e5667;
                        break if !(_e5664);
                    }
                }
                let _e5906 = local_56;
                let _e5908 = exp2((_e5906 * -62.5f));
                phi_4387_ = (_e5398 * exp2(-(_e5650)));
                phi_4388_ = fma(_e5384, 0.0625f, _e5402);
                phi_4389_ = fma(_e5385, 0.0625f, _e5404);
                phi_4390_ = fma(_e5386, 0.0625f, _e5406);
                phi_4391_ = fma(((fma((((0.4807763f * _e5908) * _e5657) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e5654) * 3.1415927f), _e5398, _e5408);
                phi_4392_ = fma(((fma((((0.28401393f * _e5908) * _e5657) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e5654) * 3.1415927f), _e5398, _e5410);
                phi_4393_ = fma(((fma((((0.09044314f * _e5908) * _e5657) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e5654) * 3.1415927f), _e5398, _e5412);
            }
            let _e5940 = phi_4387_;
            let _e5942 = phi_4388_;
            let _e5944 = phi_4389_;
            let _e5946 = phi_4390_;
            let _e5948 = phi_4391_;
            let _e5950 = phi_4392_;
            let _e5952 = phi_4393_;
            phi_4048_ = _e5940;
            phi_4053_ = _e5942;
            phi_4055_ = _e5944;
            phi_4057_ = _e5946;
            phi_4059_ = _e5948;
            phi_4061_ = _e5950;
            phi_4063_ = _e5952;
        } else {
            phi_4048_ = f32();
            phi_4053_ = f32();
            phi_4055_ = f32();
            phi_4057_ = f32();
            phi_4059_ = f32();
            phi_4061_ = f32();
            phi_4063_ = f32();
        }
        let _e5954 = phi_4048_;
        let _e5956 = phi_4053_;
        let _e5958 = phi_4055_;
        let _e5960 = phi_4057_;
        let _e5962 = phi_4059_;
        let _e5964 = phi_4061_;
        let _e5966 = phi_4063_;
        continue;
        continuing {
            phi_4047_ = _e5954;
            phi_4050_ = _e5416;
            phi_4052_ = _e5956;
            phi_4054_ = _e5958;
            phi_4056_ = _e5960;
            phi_4058_ = _e5962;
            phi_4060_ = _e5964;
            phi_4062_ = _e5966;
            break if !(_e5413);
        }
    }
    let _e5969 = local_57;
    let _e5971 = local_58;
    let _e5974 = local_59;
    let _e5976 = local_60;
    let _e5979 = local_61;
    let _e5981 = local_62;
    let _e5987 = (sqrt(fma(_e5380, _e5380, fma(_e5378, _e5378, (_e5379 * _e5379)))) * 0.00001f);
    let _e5989 = select(_e5987, 0f, (_e5987 < 0f));
    let _e5991 = select(_e5989, 1f, (_e5989 > 1f));
    let _e5992 = (1f - _e5991);
    let _e5996 = fma(fma(_e5363, _e5969, _e5971), _e5992, (_e5363 * _e5991));
    let _e5997 = fma(fma(_e5364, _e5974, _e5976), _e5992, (_e5364 * _e5991));
    let _e5998 = fma(fma(_e5365, _e5979, _e5981), _e5992, (_e5365 * _e5991));
    if _e274 {
        phi_19907_ = vec2<f32>(-1f, -1f);
    } else {
        phi_19907_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e6003 = phi_19907_;
    if _e283 {
        phi_19947_ = vec2<f32>(-1f, -1f);
    } else {
        phi_19947_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e6009 = phi_19947_;
    let _e6011 = (_e144.x * _e6003.y);
    let _e6012 = (_e144.y * _e6003.y);
    let _e6013 = (_e144.z * _e6003.y);
    let _e6017 = fma(_e296, _e6003.y, (_e144.x + _e6009.y));
    let _e6018 = fma(_e298, _e6003.y, (_e144.y + _e6009.y));
    let _e6019 = fma(_e300, _e6003.y, (_e144.z + _e6009.y));
    let _e6020 = (_e6017 * 0.0625f);
    let _e6021 = (_e6018 * 0.0625f);
    let _e6022 = (_e6019 * 0.0625f);
    phi_4501_ = 1f;
    phi_4504_ = 0u;
    phi_4506_ = fma(_e6020, _e181, _e6011);
    phi_4508_ = fma(_e6021, _e181, _e6012);
    phi_4510_ = fma(_e6022, _e181, _e6013);
    phi_4512_ = 0f;
    phi_4514_ = 0f;
    phi_4516_ = 0f;
    loop {
        let _e6031 = phi_4501_;
        let _e6033 = phi_4504_;
        let _e6035 = phi_4506_;
        let _e6037 = phi_4508_;
        let _e6039 = phi_4510_;
        let _e6041 = phi_4512_;
        let _e6043 = phi_4514_;
        let _e6045 = phi_4516_;
        local_64 = _e6031;
        local_65 = _e6041;
        local_66 = _e6031;
        local_67 = _e6043;
        local_68 = _e6031;
        local_69 = _e6045;
        let _e6046 = (_e6033 < 16u);
        if _e6046 {
            phi_4505_ = (_e6033 + 1u);
        } else {
            phi_4505_ = _e6033;
        }
        let _e6049 = phi_4505_;
        if _e6046 {
            let _e6050 = (_e6037 + 6371000f);
            let _e6054 = sqrt(fma(_e6039, _e6039, fma(_e6035, _e6035, (_e6050 * _e6050))));
            let _e6055 = (_e6054 - 6371000f);
            if (_e6055 < 1600f) {
                phi_4632_ = f32();
                phi_4633_ = true;
            } else {
                let _e6057 = (_e6055 > 2100f);
                if _e6057 {
                    phi_4631_ = f32();
                } else {
                    let _e6061 = global_2.member.member[0u];
                    let _e6062 = (_e6061 * 0.02f);
                    let _e6063 = fma(_e6035, 0.001f, _e6062);
                    let _e6064 = fma(_e6039, 0.001f, _e6062);
                    let _e6065 = floor(_e6064);
                    let _e6066 = (_e6064 - _e6065);
                    let _e6067 = (_e6065 * 0.265625f);
                    let _e6068 = fma(_e6063, 0.015625f, _e6067);
                    let _e6069 = fma(_e6055, 0.000015625f, _e6067);
                    if (_e6068 > 0f) {
                        phi_20172_ = (_e6068 % 1f);
                    } else {
                        phi_20172_ = (1f - (-(_e6068) % 1f));
                    }
                    let _e6076 = phi_20172_;
                    if (_e6069 > 0f) {
                        phi_20185_ = (_e6069 % 1f);
                    } else {
                        phi_20185_ = (1f - (-(_e6069) % 1f));
                    }
                    let _e6083 = phi_20185_;
                    let _e6085 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6076, _e6083), 0f);
                    let _e6087 = (_e6068 + 0.265625f);
                    let _e6088 = (_e6069 + 0.265625f);
                    if (_e6087 > 0f) {
                        phi_20215_ = (_e6087 % 1f);
                    } else {
                        phi_20215_ = (1f - ((-0.265625f - _e6068) % 1f));
                    }
                    let _e6095 = phi_20215_;
                    if (_e6088 > 0f) {
                        phi_20228_ = (_e6088 % 1f);
                    } else {
                        phi_20228_ = (1f - ((-0.265625f - _e6069) % 1f));
                    }
                    let _e6102 = phi_20228_;
                    let _e6104 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6095, _e6102), 0f);
                    let _e6109 = fma(_e6061, 0.02f, 2f);
                    let _e6112 = floor((_e6064 * _e6109));
                    let _e6114 = fma(_e6064, _e6109, -(_e6112));
                    let _e6115 = (_e6112 * 0.265625f);
                    let _e6116 = fma((_e6063 * _e6109), 0.015625f, _e6115);
                    let _e6117 = fma(_e6055, 0.00003125f, _e6115);
                    if (_e6116 > 0f) {
                        phi_20288_ = (_e6116 % 1f);
                    } else {
                        phi_20288_ = (1f - (-(_e6116) % 1f));
                    }
                    let _e6124 = phi_20288_;
                    if (_e6117 > 0f) {
                        phi_20301_ = (_e6117 % 1f);
                    } else {
                        phi_20301_ = (1f - (-(_e6117) % 1f));
                    }
                    let _e6131 = phi_20301_;
                    let _e6133 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6124, _e6131), 0f);
                    let _e6135 = (_e6116 + 0.265625f);
                    let _e6136 = (_e6117 + 0.265625f);
                    if (_e6135 > 0f) {
                        phi_20331_ = (_e6135 % 1f);
                    } else {
                        phi_20331_ = (1f - ((-0.265625f - _e6116) % 1f));
                    }
                    let _e6143 = phi_20331_;
                    if (_e6136 > 0f) {
                        phi_20344_ = (_e6136 % 1f);
                    } else {
                        phi_20344_ = (1f - ((-0.265625f - _e6117) % 1f));
                    }
                    let _e6150 = phi_20344_;
                    let _e6152 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6143, _e6150), 0f);
                    let _e6160 = fma(-(_e6061), 0.02f, 7f);
                    let _e6163 = floor((_e6064 * _e6160));
                    let _e6165 = fma(_e6064, _e6160, -(_e6163));
                    let _e6166 = (_e6163 * 0.265625f);
                    let _e6167 = fma((_e6063 * _e6160), 0.015625f, _e6166);
                    let _e6168 = fma(_e6055, 0.000109375f, _e6166);
                    if (_e6167 > 0f) {
                        phi_20404_ = (_e6167 % 1f);
                    } else {
                        phi_20404_ = (1f - (-(_e6167) % 1f));
                    }
                    let _e6175 = phi_20404_;
                    if (_e6168 > 0f) {
                        phi_20417_ = (_e6168 % 1f);
                    } else {
                        phi_20417_ = (1f - (-(_e6168) % 1f));
                    }
                    let _e6182 = phi_20417_;
                    let _e6184 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6175, _e6182), 0f);
                    let _e6186 = (_e6167 + 0.265625f);
                    let _e6187 = (_e6168 + 0.265625f);
                    if (_e6186 > 0f) {
                        phi_20447_ = (_e6186 % 1f);
                    } else {
                        phi_20447_ = (1f - ((-0.265625f - _e6167) % 1f));
                    }
                    let _e6194 = phi_20447_;
                    if (_e6187 > 0f) {
                        phi_20460_ = (_e6187 % 1f);
                    } else {
                        phi_20460_ = (1f - ((-0.265625f - _e6168) % 1f));
                    }
                    let _e6201 = phi_20460_;
                    let _e6203 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6194, _e6201), 0f);
                    let _e6210 = fma(_e6061, 0.02f, _e6064);
                    let _e6212 = floor((_e6210 * 16f));
                    let _e6214 = fma(_e6210, 16f, -(_e6212));
                    let _e6215 = (_e6212 * 0.265625f);
                    let _e6216 = fma(fma(_e6061, 0.02f, _e6063), 0.25f, _e6215);
                    let _e6217 = fma(_e6055, 0.00025f, _e6215);
                    if (_e6216 > 0f) {
                        phi_20520_ = (_e6216 % 1f);
                    } else {
                        phi_20520_ = (1f - (-(_e6216) % 1f));
                    }
                    let _e6224 = phi_20520_;
                    if (_e6217 > 0f) {
                        phi_20533_ = (_e6217 % 1f);
                    } else {
                        phi_20533_ = (1f - (-(_e6217) % 1f));
                    }
                    let _e6231 = phi_20533_;
                    let _e6233 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6224, _e6231), 0f);
                    let _e6235 = (_e6216 + 0.265625f);
                    let _e6236 = (_e6217 + 0.265625f);
                    if (_e6235 > 0f) {
                        phi_20563_ = (_e6235 % 1f);
                    } else {
                        phi_20563_ = (1f - ((-0.265625f - _e6216) % 1f));
                    }
                    let _e6243 = phi_20563_;
                    if (_e6236 > 0f) {
                        phi_20576_ = (_e6236 % 1f);
                    } else {
                        phi_20576_ = (1f - ((-0.265625f - _e6217) % 1f));
                    }
                    let _e6250 = phi_20576_;
                    let _e6252 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6243, _e6250), 0f);
                    let _e6258 = (_e6054 - 6372600f);
                    let _e6266 = ((fma(fma(_e6233.x, (1f - _e6214), (_e6252.x * _e6214)), 0.0625f, fma(fma(_e6184.x, (1f - _e6165), (_e6203.x * _e6165)), 0.125f, fma(fma(_e6085.x, (1f - _e6066), (_e6104.x * _e6066)), 0.5f, (fma(_e6133.x, (1f - _e6114), (_e6152.x * _e6114)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e6268 = select(_e6266, 0f, (_e6266 < 0f));
                    let _e6270 = select(_e6268, 1f, (_e6268 > 1f));
                    phi_4631_ = ((((_e6270 * _e6270) * fma(-2f, _e6270, 3f)) * ((1f - exp2((-0.01f * _e6258))) * exp2((-0.004f * _e6258)))) * 0.03f);
                }
                let _e6277 = phi_4631_;
                phi_4632_ = _e6277;
                phi_4633_ = _e6057;
            }
            let _e6279 = phi_4632_;
            let _e6281 = phi_4633_;
            let _e6283 = (select(_e6279, 0f, _e6281) * sqrt(fma(_e6022, _e6022, fma(_e6020, _e6020, (_e6021 * _e6021)))));
            if (_e6283 <= 0f) {
                phi_4841_ = _e6031;
                phi_4842_ = _e6035;
                phi_4843_ = _e6037;
                phi_4844_ = _e6039;
                phi_4845_ = _e6041;
                phi_4846_ = _e6043;
                phi_4847_ = _e6045;
            } else {
                let _e6287 = fma(exp2((-1.6013916f * _e6283)), -0.9009009f, 0.9009009f);
                let _e6290 = (1f - exp2((_e6283 * -1.3862944f)));
                let _e6291 = (-9.537895f + _e6035);
                let _e6292 = (29.354609f + _e6039);
                phi_4664_ = 0f;
                phi_4667_ = 0u;
                loop {
                    let _e6294 = phi_4664_;
                    let _e6296 = phi_4667_;
                    local_63 = _e6294;
                    let _e6297 = (_e6296 < 8u);
                    if _e6297 {
                        phi_4668_ = (_e6296 + 1u);
                    } else {
                        phi_4668_ = _e6296;
                    }
                    let _e6300 = phi_4668_;
                    if _e6297 {
                        let _e6301 = (_e6037 + 6371005f);
                        let _e6305 = sqrt(fma(_e6292, _e6292, fma(_e6291, _e6291, (_e6301 * _e6301))));
                        let _e6306 = (_e6305 - 6371000f);
                        if (_e6306 < 1600f) {
                            phi_4783_ = f32();
                            phi_4784_ = true;
                        } else {
                            let _e6308 = (_e6306 > 2100f);
                            if _e6308 {
                                phi_4782_ = f32();
                            } else {
                                let _e6312 = global_2.member.member[0u];
                                let _e6313 = (_e6312 * 0.02f);
                                let _e6314 = fma(_e6291, 0.001f, _e6313);
                                let _e6315 = fma(_e6292, 0.001f, _e6313);
                                let _e6316 = floor(_e6315);
                                let _e6317 = (_e6315 - _e6316);
                                let _e6318 = (_e6316 * 0.265625f);
                                let _e6319 = fma(_e6314, 0.015625f, _e6318);
                                let _e6320 = fma(_e6306, 0.000015625f, _e6318);
                                if (_e6319 > 0f) {
                                    phi_20652_ = (_e6319 % 1f);
                                } else {
                                    phi_20652_ = (1f - (-(_e6319) % 1f));
                                }
                                let _e6327 = phi_20652_;
                                if (_e6320 > 0f) {
                                    phi_20665_ = (_e6320 % 1f);
                                } else {
                                    phi_20665_ = (1f - (-(_e6320) % 1f));
                                }
                                let _e6334 = phi_20665_;
                                let _e6336 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6327, _e6334), 0f);
                                let _e6338 = (_e6319 + 0.265625f);
                                let _e6339 = (_e6320 + 0.265625f);
                                if (_e6338 > 0f) {
                                    phi_20695_ = (_e6338 % 1f);
                                } else {
                                    phi_20695_ = (1f - ((-0.265625f - _e6319) % 1f));
                                }
                                let _e6346 = phi_20695_;
                                if (_e6339 > 0f) {
                                    phi_20708_ = (_e6339 % 1f);
                                } else {
                                    phi_20708_ = (1f - ((-0.265625f - _e6320) % 1f));
                                }
                                let _e6353 = phi_20708_;
                                let _e6355 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6346, _e6353), 0f);
                                let _e6360 = fma(_e6312, 0.02f, 2f);
                                let _e6363 = floor((_e6315 * _e6360));
                                let _e6365 = fma(_e6315, _e6360, -(_e6363));
                                let _e6366 = (_e6363 * 0.265625f);
                                let _e6367 = fma((_e6314 * _e6360), 0.015625f, _e6366);
                                let _e6368 = fma(_e6306, 0.00003125f, _e6366);
                                if (_e6367 > 0f) {
                                    phi_20768_ = (_e6367 % 1f);
                                } else {
                                    phi_20768_ = (1f - (-(_e6367) % 1f));
                                }
                                let _e6375 = phi_20768_;
                                if (_e6368 > 0f) {
                                    phi_20781_ = (_e6368 % 1f);
                                } else {
                                    phi_20781_ = (1f - (-(_e6368) % 1f));
                                }
                                let _e6382 = phi_20781_;
                                let _e6384 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6375, _e6382), 0f);
                                let _e6386 = (_e6367 + 0.265625f);
                                let _e6387 = (_e6368 + 0.265625f);
                                if (_e6386 > 0f) {
                                    phi_20811_ = (_e6386 % 1f);
                                } else {
                                    phi_20811_ = (1f - ((-0.265625f - _e6367) % 1f));
                                }
                                let _e6394 = phi_20811_;
                                if (_e6387 > 0f) {
                                    phi_20824_ = (_e6387 % 1f);
                                } else {
                                    phi_20824_ = (1f - ((-0.265625f - _e6368) % 1f));
                                }
                                let _e6401 = phi_20824_;
                                let _e6403 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6394, _e6401), 0f);
                                let _e6411 = fma(-(_e6312), 0.02f, 7f);
                                let _e6414 = floor((_e6315 * _e6411));
                                let _e6416 = fma(_e6315, _e6411, -(_e6414));
                                let _e6417 = (_e6414 * 0.265625f);
                                let _e6418 = fma((_e6314 * _e6411), 0.015625f, _e6417);
                                let _e6419 = fma(_e6306, 0.000109375f, _e6417);
                                if (_e6418 > 0f) {
                                    phi_20884_ = (_e6418 % 1f);
                                } else {
                                    phi_20884_ = (1f - (-(_e6418) % 1f));
                                }
                                let _e6426 = phi_20884_;
                                if (_e6419 > 0f) {
                                    phi_20897_ = (_e6419 % 1f);
                                } else {
                                    phi_20897_ = (1f - (-(_e6419) % 1f));
                                }
                                let _e6433 = phi_20897_;
                                let _e6435 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6426, _e6433), 0f);
                                let _e6437 = (_e6418 + 0.265625f);
                                let _e6438 = (_e6419 + 0.265625f);
                                if (_e6437 > 0f) {
                                    phi_20927_ = (_e6437 % 1f);
                                } else {
                                    phi_20927_ = (1f - ((-0.265625f - _e6418) % 1f));
                                }
                                let _e6445 = phi_20927_;
                                if (_e6438 > 0f) {
                                    phi_20940_ = (_e6438 % 1f);
                                } else {
                                    phi_20940_ = (1f - ((-0.265625f - _e6419) % 1f));
                                }
                                let _e6452 = phi_20940_;
                                let _e6454 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6445, _e6452), 0f);
                                let _e6461 = fma(_e6312, 0.02f, _e6315);
                                let _e6463 = floor((_e6461 * 16f));
                                let _e6465 = fma(_e6461, 16f, -(_e6463));
                                let _e6466 = (_e6463 * 0.265625f);
                                let _e6467 = fma(fma(_e6312, 0.02f, _e6314), 0.25f, _e6466);
                                let _e6468 = fma(_e6306, 0.00025f, _e6466);
                                if (_e6467 > 0f) {
                                    phi_21000_ = (_e6467 % 1f);
                                } else {
                                    phi_21000_ = (1f - (-(_e6467) % 1f));
                                }
                                let _e6475 = phi_21000_;
                                if (_e6468 > 0f) {
                                    phi_21013_ = (_e6468 % 1f);
                                } else {
                                    phi_21013_ = (1f - (-(_e6468) % 1f));
                                }
                                let _e6482 = phi_21013_;
                                let _e6484 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6475, _e6482), 0f);
                                let _e6486 = (_e6467 + 0.265625f);
                                let _e6487 = (_e6468 + 0.265625f);
                                if (_e6486 > 0f) {
                                    phi_21043_ = (_e6486 % 1f);
                                } else {
                                    phi_21043_ = (1f - ((-0.265625f - _e6467) % 1f));
                                }
                                let _e6494 = phi_21043_;
                                if (_e6487 > 0f) {
                                    phi_21056_ = (_e6487 % 1f);
                                } else {
                                    phi_21056_ = (1f - ((-0.265625f - _e6468) % 1f));
                                }
                                let _e6501 = phi_21056_;
                                let _e6503 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6494, _e6501), 0f);
                                let _e6509 = (_e6305 - 6372600f);
                                let _e6517 = ((fma(fma(_e6484.x, (1f - _e6465), (_e6503.x * _e6465)), 0.0625f, fma(fma(_e6435.x, (1f - _e6416), (_e6454.x * _e6416)), 0.125f, fma(fma(_e6336.x, (1f - _e6317), (_e6355.x * _e6317)), 0.5f, (fma(_e6384.x, (1f - _e6365), (_e6403.x * _e6365)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e6519 = select(_e6517, 0f, (_e6517 < 0f));
                                let _e6521 = select(_e6519, 1f, (_e6519 > 1f));
                                phi_4782_ = ((((_e6521 * _e6521) * fma(-2f, _e6521, 3f)) * ((1f - exp2((-0.01f * _e6509))) * exp2((-0.004f * _e6509)))) * 0.03f);
                            }
                            let _e6528 = phi_4782_;
                            phi_4783_ = _e6528;
                            phi_4784_ = _e6308;
                        }
                        let _e6530 = phi_4783_;
                        let _e6532 = phi_4784_;
                        phi_4665_ = (_e6294 + select(_e6530, 0f, _e6532));
                    } else {
                        phi_4665_ = f32();
                    }
                    let _e6536 = phi_4665_;
                    continue;
                    continuing {
                        phi_4664_ = _e6536;
                        phi_4667_ = _e6300;
                        break if !(_e6297);
                    }
                }
                let _e6539 = local_63;
                let _e6541 = exp2((_e6539 * -62.5f));
                phi_4841_ = (_e6031 * exp2(-(_e6283)));
                phi_4842_ = fma(_e6017, 0.0625f, _e6035);
                phi_4843_ = fma(_e6018, 0.0625f, _e6037);
                phi_4844_ = fma(_e6019, 0.0625f, _e6039);
                phi_4845_ = fma(((fma((((0.4807763f * _e6541) * _e6290) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e6287) * 3.1415927f), _e6031, _e6041);
                phi_4846_ = fma(((fma((((0.28401393f * _e6541) * _e6290) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e6287) * 3.1415927f), _e6031, _e6043);
                phi_4847_ = fma(((fma((((0.09044314f * _e6541) * _e6290) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e6287) * 3.1415927f), _e6031, _e6045);
            }
            let _e6573 = phi_4841_;
            let _e6575 = phi_4842_;
            let _e6577 = phi_4843_;
            let _e6579 = phi_4844_;
            let _e6581 = phi_4845_;
            let _e6583 = phi_4846_;
            let _e6585 = phi_4847_;
            phi_4502_ = _e6573;
            phi_4507_ = _e6575;
            phi_4509_ = _e6577;
            phi_4511_ = _e6579;
            phi_4513_ = _e6581;
            phi_4515_ = _e6583;
            phi_4517_ = _e6585;
        } else {
            phi_4502_ = f32();
            phi_4507_ = f32();
            phi_4509_ = f32();
            phi_4511_ = f32();
            phi_4513_ = f32();
            phi_4515_ = f32();
            phi_4517_ = f32();
        }
        let _e6587 = phi_4502_;
        let _e6589 = phi_4507_;
        let _e6591 = phi_4509_;
        let _e6593 = phi_4511_;
        let _e6595 = phi_4513_;
        let _e6597 = phi_4515_;
        let _e6599 = phi_4517_;
        continue;
        continuing {
            phi_4501_ = _e6587;
            phi_4504_ = _e6049;
            phi_4506_ = _e6589;
            phi_4508_ = _e6591;
            phi_4510_ = _e6593;
            phi_4512_ = _e6595;
            phi_4514_ = _e6597;
            phi_4516_ = _e6599;
            break if !(_e6046);
        }
    }
    let _e6602 = local_64;
    let _e6604 = local_65;
    let _e6607 = local_66;
    let _e6609 = local_67;
    let _e6612 = local_68;
    let _e6614 = local_69;
    let _e6620 = (sqrt(fma(_e6013, _e6013, fma(_e6011, _e6011, (_e6012 * _e6012)))) * 0.00001f);
    let _e6622 = select(_e6620, 0f, (_e6620 < 0f));
    let _e6624 = select(_e6622, 1f, (_e6622 > 1f));
    let _e6625 = (1f - _e6624);
    let _e6629 = fma(fma(_e5996, _e6602, _e6604), _e6625, (_e5996 * _e6624));
    let _e6630 = fma(fma(_e5997, _e6607, _e6609), _e6625, (_e5997 * _e6624));
    let _e6631 = fma(fma(_e5998, _e6612, _e6614), _e6625, (_e5998 * _e6624));
    if _e274 {
        phi_21130_ = vec2<f32>(-1f, -1f);
    } else {
        phi_21130_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e6636 = phi_21130_;
    if _e283 {
        phi_21170_ = vec2<f32>(-1f, -1f);
    } else {
        phi_21170_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e6642 = phi_21170_;
    let _e6644 = (_e144.x * _e6636.y);
    let _e6645 = (_e144.y * _e6636.y);
    let _e6646 = (_e144.z * _e6636.y);
    let _e6650 = fma(_e296, _e6636.y, (_e144.x + _e6642.y));
    let _e6651 = fma(_e298, _e6636.y, (_e144.y + _e6642.y));
    let _e6652 = fma(_e300, _e6636.y, (_e144.z + _e6642.y));
    let _e6653 = (_e6650 * 0.0625f);
    let _e6654 = (_e6651 * 0.0625f);
    let _e6655 = (_e6652 * 0.0625f);
    phi_4955_ = 1f;
    phi_4958_ = 0u;
    phi_4960_ = fma(_e6653, _e181, _e6644);
    phi_4962_ = fma(_e6654, _e181, _e6645);
    phi_4964_ = fma(_e6655, _e181, _e6646);
    phi_4966_ = 0f;
    phi_4968_ = 0f;
    phi_4970_ = 0f;
    loop {
        let _e6664 = phi_4955_;
        let _e6666 = phi_4958_;
        let _e6668 = phi_4960_;
        let _e6670 = phi_4962_;
        let _e6672 = phi_4964_;
        let _e6674 = phi_4966_;
        let _e6676 = phi_4968_;
        let _e6678 = phi_4970_;
        local_71 = _e6664;
        local_72 = _e6674;
        local_73 = _e6664;
        local_74 = _e6676;
        local_75 = _e6664;
        local_76 = _e6678;
        let _e6679 = (_e6666 < 16u);
        if _e6679 {
            phi_4959_ = (_e6666 + 1u);
        } else {
            phi_4959_ = _e6666;
        }
        let _e6682 = phi_4959_;
        if _e6679 {
            let _e6683 = (_e6670 + 6371000f);
            let _e6687 = sqrt(fma(_e6672, _e6672, fma(_e6668, _e6668, (_e6683 * _e6683))));
            let _e6688 = (_e6687 - 6371000f);
            if (_e6688 < 1600f) {
                phi_5086_ = f32();
                phi_5087_ = true;
            } else {
                let _e6690 = (_e6688 > 2100f);
                if _e6690 {
                    phi_5085_ = f32();
                } else {
                    let _e6694 = global_2.member.member[0u];
                    let _e6695 = (_e6694 * 0.02f);
                    let _e6696 = fma(_e6668, 0.001f, _e6695);
                    let _e6697 = fma(_e6672, 0.001f, _e6695);
                    let _e6698 = floor(_e6697);
                    let _e6699 = (_e6697 - _e6698);
                    let _e6700 = (_e6698 * 0.265625f);
                    let _e6701 = fma(_e6696, 0.015625f, _e6700);
                    let _e6702 = fma(_e6688, 0.000015625f, _e6700);
                    if (_e6701 > 0f) {
                        phi_21395_ = (_e6701 % 1f);
                    } else {
                        phi_21395_ = (1f - (-(_e6701) % 1f));
                    }
                    let _e6709 = phi_21395_;
                    if (_e6702 > 0f) {
                        phi_21408_ = (_e6702 % 1f);
                    } else {
                        phi_21408_ = (1f - (-(_e6702) % 1f));
                    }
                    let _e6716 = phi_21408_;
                    let _e6718 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6709, _e6716), 0f);
                    let _e6720 = (_e6701 + 0.265625f);
                    let _e6721 = (_e6702 + 0.265625f);
                    if (_e6720 > 0f) {
                        phi_21438_ = (_e6720 % 1f);
                    } else {
                        phi_21438_ = (1f - ((-0.265625f - _e6701) % 1f));
                    }
                    let _e6728 = phi_21438_;
                    if (_e6721 > 0f) {
                        phi_21451_ = (_e6721 % 1f);
                    } else {
                        phi_21451_ = (1f - ((-0.265625f - _e6702) % 1f));
                    }
                    let _e6735 = phi_21451_;
                    let _e6737 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6728, _e6735), 0f);
                    let _e6742 = fma(_e6694, 0.02f, 2f);
                    let _e6745 = floor((_e6697 * _e6742));
                    let _e6747 = fma(_e6697, _e6742, -(_e6745));
                    let _e6748 = (_e6745 * 0.265625f);
                    let _e6749 = fma((_e6696 * _e6742), 0.015625f, _e6748);
                    let _e6750 = fma(_e6688, 0.00003125f, _e6748);
                    if (_e6749 > 0f) {
                        phi_21511_ = (_e6749 % 1f);
                    } else {
                        phi_21511_ = (1f - (-(_e6749) % 1f));
                    }
                    let _e6757 = phi_21511_;
                    if (_e6750 > 0f) {
                        phi_21524_ = (_e6750 % 1f);
                    } else {
                        phi_21524_ = (1f - (-(_e6750) % 1f));
                    }
                    let _e6764 = phi_21524_;
                    let _e6766 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6757, _e6764), 0f);
                    let _e6768 = (_e6749 + 0.265625f);
                    let _e6769 = (_e6750 + 0.265625f);
                    if (_e6768 > 0f) {
                        phi_21554_ = (_e6768 % 1f);
                    } else {
                        phi_21554_ = (1f - ((-0.265625f - _e6749) % 1f));
                    }
                    let _e6776 = phi_21554_;
                    if (_e6769 > 0f) {
                        phi_21567_ = (_e6769 % 1f);
                    } else {
                        phi_21567_ = (1f - ((-0.265625f - _e6750) % 1f));
                    }
                    let _e6783 = phi_21567_;
                    let _e6785 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6776, _e6783), 0f);
                    let _e6793 = fma(-(_e6694), 0.02f, 7f);
                    let _e6796 = floor((_e6697 * _e6793));
                    let _e6798 = fma(_e6697, _e6793, -(_e6796));
                    let _e6799 = (_e6796 * 0.265625f);
                    let _e6800 = fma((_e6696 * _e6793), 0.015625f, _e6799);
                    let _e6801 = fma(_e6688, 0.000109375f, _e6799);
                    if (_e6800 > 0f) {
                        phi_21627_ = (_e6800 % 1f);
                    } else {
                        phi_21627_ = (1f - (-(_e6800) % 1f));
                    }
                    let _e6808 = phi_21627_;
                    if (_e6801 > 0f) {
                        phi_21640_ = (_e6801 % 1f);
                    } else {
                        phi_21640_ = (1f - (-(_e6801) % 1f));
                    }
                    let _e6815 = phi_21640_;
                    let _e6817 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6808, _e6815), 0f);
                    let _e6819 = (_e6800 + 0.265625f);
                    let _e6820 = (_e6801 + 0.265625f);
                    if (_e6819 > 0f) {
                        phi_21670_ = (_e6819 % 1f);
                    } else {
                        phi_21670_ = (1f - ((-0.265625f - _e6800) % 1f));
                    }
                    let _e6827 = phi_21670_;
                    if (_e6820 > 0f) {
                        phi_21683_ = (_e6820 % 1f);
                    } else {
                        phi_21683_ = (1f - ((-0.265625f - _e6801) % 1f));
                    }
                    let _e6834 = phi_21683_;
                    let _e6836 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6827, _e6834), 0f);
                    let _e6843 = fma(_e6694, 0.02f, _e6697);
                    let _e6845 = floor((_e6843 * 16f));
                    let _e6847 = fma(_e6843, 16f, -(_e6845));
                    let _e6848 = (_e6845 * 0.265625f);
                    let _e6849 = fma(fma(_e6694, 0.02f, _e6696), 0.25f, _e6848);
                    let _e6850 = fma(_e6688, 0.00025f, _e6848);
                    if (_e6849 > 0f) {
                        phi_21743_ = (_e6849 % 1f);
                    } else {
                        phi_21743_ = (1f - (-(_e6849) % 1f));
                    }
                    let _e6857 = phi_21743_;
                    if (_e6850 > 0f) {
                        phi_21756_ = (_e6850 % 1f);
                    } else {
                        phi_21756_ = (1f - (-(_e6850) % 1f));
                    }
                    let _e6864 = phi_21756_;
                    let _e6866 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6857, _e6864), 0f);
                    let _e6868 = (_e6849 + 0.265625f);
                    let _e6869 = (_e6850 + 0.265625f);
                    if (_e6868 > 0f) {
                        phi_21786_ = (_e6868 % 1f);
                    } else {
                        phi_21786_ = (1f - ((-0.265625f - _e6849) % 1f));
                    }
                    let _e6876 = phi_21786_;
                    if (_e6869 > 0f) {
                        phi_21799_ = (_e6869 % 1f);
                    } else {
                        phi_21799_ = (1f - ((-0.265625f - _e6850) % 1f));
                    }
                    let _e6883 = phi_21799_;
                    let _e6885 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6876, _e6883), 0f);
                    let _e6891 = (_e6687 - 6372600f);
                    let _e6899 = ((fma(fma(_e6866.x, (1f - _e6847), (_e6885.x * _e6847)), 0.0625f, fma(fma(_e6817.x, (1f - _e6798), (_e6836.x * _e6798)), 0.125f, fma(fma(_e6718.x, (1f - _e6699), (_e6737.x * _e6699)), 0.5f, (fma(_e6766.x, (1f - _e6747), (_e6785.x * _e6747)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e6901 = select(_e6899, 0f, (_e6899 < 0f));
                    let _e6903 = select(_e6901, 1f, (_e6901 > 1f));
                    phi_5085_ = ((((_e6903 * _e6903) * fma(-2f, _e6903, 3f)) * ((1f - exp2((-0.01f * _e6891))) * exp2((-0.004f * _e6891)))) * 0.03f);
                }
                let _e6910 = phi_5085_;
                phi_5086_ = _e6910;
                phi_5087_ = _e6690;
            }
            let _e6912 = phi_5086_;
            let _e6914 = phi_5087_;
            let _e6916 = (select(_e6912, 0f, _e6914) * sqrt(fma(_e6655, _e6655, fma(_e6653, _e6653, (_e6654 * _e6654)))));
            if (_e6916 <= 0f) {
                phi_5295_ = _e6664;
                phi_5296_ = _e6668;
                phi_5297_ = _e6670;
                phi_5298_ = _e6672;
                phi_5299_ = _e6674;
                phi_5300_ = _e6676;
                phi_5301_ = _e6678;
            } else {
                let _e6920 = fma(exp2((-1.6013916f * _e6916)), -0.9009009f, 0.9009009f);
                let _e6923 = (1f - exp2((_e6916 * -1.3862944f)));
                let _e6924 = (-9.537895f + _e6668);
                let _e6925 = (29.354609f + _e6672);
                phi_5118_ = 0f;
                phi_5121_ = 0u;
                loop {
                    let _e6927 = phi_5118_;
                    let _e6929 = phi_5121_;
                    local_70 = _e6927;
                    let _e6930 = (_e6929 < 8u);
                    if _e6930 {
                        phi_5122_ = (_e6929 + 1u);
                    } else {
                        phi_5122_ = _e6929;
                    }
                    let _e6933 = phi_5122_;
                    if _e6930 {
                        let _e6934 = (_e6670 + 6371005f);
                        let _e6938 = sqrt(fma(_e6925, _e6925, fma(_e6924, _e6924, (_e6934 * _e6934))));
                        let _e6939 = (_e6938 - 6371000f);
                        if (_e6939 < 1600f) {
                            phi_5237_ = f32();
                            phi_5238_ = true;
                        } else {
                            let _e6941 = (_e6939 > 2100f);
                            if _e6941 {
                                phi_5236_ = f32();
                            } else {
                                let _e6945 = global_2.member.member[0u];
                                let _e6946 = (_e6945 * 0.02f);
                                let _e6947 = fma(_e6924, 0.001f, _e6946);
                                let _e6948 = fma(_e6925, 0.001f, _e6946);
                                let _e6949 = floor(_e6948);
                                let _e6950 = (_e6948 - _e6949);
                                let _e6951 = (_e6949 * 0.265625f);
                                let _e6952 = fma(_e6947, 0.015625f, _e6951);
                                let _e6953 = fma(_e6939, 0.000015625f, _e6951);
                                if (_e6952 > 0f) {
                                    phi_21875_ = (_e6952 % 1f);
                                } else {
                                    phi_21875_ = (1f - (-(_e6952) % 1f));
                                }
                                let _e6960 = phi_21875_;
                                if (_e6953 > 0f) {
                                    phi_21888_ = (_e6953 % 1f);
                                } else {
                                    phi_21888_ = (1f - (-(_e6953) % 1f));
                                }
                                let _e6967 = phi_21888_;
                                let _e6969 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6960, _e6967), 0f);
                                let _e6971 = (_e6952 + 0.265625f);
                                let _e6972 = (_e6953 + 0.265625f);
                                if (_e6971 > 0f) {
                                    phi_21918_ = (_e6971 % 1f);
                                } else {
                                    phi_21918_ = (1f - ((-0.265625f - _e6952) % 1f));
                                }
                                let _e6979 = phi_21918_;
                                if (_e6972 > 0f) {
                                    phi_21931_ = (_e6972 % 1f);
                                } else {
                                    phi_21931_ = (1f - ((-0.265625f - _e6953) % 1f));
                                }
                                let _e6986 = phi_21931_;
                                let _e6988 = textureSampleLevel(global_3, global_4, vec2<f32>(_e6979, _e6986), 0f);
                                let _e6993 = fma(_e6945, 0.02f, 2f);
                                let _e6996 = floor((_e6948 * _e6993));
                                let _e6998 = fma(_e6948, _e6993, -(_e6996));
                                let _e6999 = (_e6996 * 0.265625f);
                                let _e7000 = fma((_e6947 * _e6993), 0.015625f, _e6999);
                                let _e7001 = fma(_e6939, 0.00003125f, _e6999);
                                if (_e7000 > 0f) {
                                    phi_21991_ = (_e7000 % 1f);
                                } else {
                                    phi_21991_ = (1f - (-(_e7000) % 1f));
                                }
                                let _e7008 = phi_21991_;
                                if (_e7001 > 0f) {
                                    phi_22004_ = (_e7001 % 1f);
                                } else {
                                    phi_22004_ = (1f - (-(_e7001) % 1f));
                                }
                                let _e7015 = phi_22004_;
                                let _e7017 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7008, _e7015), 0f);
                                let _e7019 = (_e7000 + 0.265625f);
                                let _e7020 = (_e7001 + 0.265625f);
                                if (_e7019 > 0f) {
                                    phi_22034_ = (_e7019 % 1f);
                                } else {
                                    phi_22034_ = (1f - ((-0.265625f - _e7000) % 1f));
                                }
                                let _e7027 = phi_22034_;
                                if (_e7020 > 0f) {
                                    phi_22047_ = (_e7020 % 1f);
                                } else {
                                    phi_22047_ = (1f - ((-0.265625f - _e7001) % 1f));
                                }
                                let _e7034 = phi_22047_;
                                let _e7036 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7027, _e7034), 0f);
                                let _e7044 = fma(-(_e6945), 0.02f, 7f);
                                let _e7047 = floor((_e6948 * _e7044));
                                let _e7049 = fma(_e6948, _e7044, -(_e7047));
                                let _e7050 = (_e7047 * 0.265625f);
                                let _e7051 = fma((_e6947 * _e7044), 0.015625f, _e7050);
                                let _e7052 = fma(_e6939, 0.000109375f, _e7050);
                                if (_e7051 > 0f) {
                                    phi_22107_ = (_e7051 % 1f);
                                } else {
                                    phi_22107_ = (1f - (-(_e7051) % 1f));
                                }
                                let _e7059 = phi_22107_;
                                if (_e7052 > 0f) {
                                    phi_22120_ = (_e7052 % 1f);
                                } else {
                                    phi_22120_ = (1f - (-(_e7052) % 1f));
                                }
                                let _e7066 = phi_22120_;
                                let _e7068 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7059, _e7066), 0f);
                                let _e7070 = (_e7051 + 0.265625f);
                                let _e7071 = (_e7052 + 0.265625f);
                                if (_e7070 > 0f) {
                                    phi_22150_ = (_e7070 % 1f);
                                } else {
                                    phi_22150_ = (1f - ((-0.265625f - _e7051) % 1f));
                                }
                                let _e7078 = phi_22150_;
                                if (_e7071 > 0f) {
                                    phi_22163_ = (_e7071 % 1f);
                                } else {
                                    phi_22163_ = (1f - ((-0.265625f - _e7052) % 1f));
                                }
                                let _e7085 = phi_22163_;
                                let _e7087 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7078, _e7085), 0f);
                                let _e7094 = fma(_e6945, 0.02f, _e6948);
                                let _e7096 = floor((_e7094 * 16f));
                                let _e7098 = fma(_e7094, 16f, -(_e7096));
                                let _e7099 = (_e7096 * 0.265625f);
                                let _e7100 = fma(fma(_e6945, 0.02f, _e6947), 0.25f, _e7099);
                                let _e7101 = fma(_e6939, 0.00025f, _e7099);
                                if (_e7100 > 0f) {
                                    phi_22223_ = (_e7100 % 1f);
                                } else {
                                    phi_22223_ = (1f - (-(_e7100) % 1f));
                                }
                                let _e7108 = phi_22223_;
                                if (_e7101 > 0f) {
                                    phi_22236_ = (_e7101 % 1f);
                                } else {
                                    phi_22236_ = (1f - (-(_e7101) % 1f));
                                }
                                let _e7115 = phi_22236_;
                                let _e7117 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7108, _e7115), 0f);
                                let _e7119 = (_e7100 + 0.265625f);
                                let _e7120 = (_e7101 + 0.265625f);
                                if (_e7119 > 0f) {
                                    phi_22266_ = (_e7119 % 1f);
                                } else {
                                    phi_22266_ = (1f - ((-0.265625f - _e7100) % 1f));
                                }
                                let _e7127 = phi_22266_;
                                if (_e7120 > 0f) {
                                    phi_22279_ = (_e7120 % 1f);
                                } else {
                                    phi_22279_ = (1f - ((-0.265625f - _e7101) % 1f));
                                }
                                let _e7134 = phi_22279_;
                                let _e7136 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7127, _e7134), 0f);
                                let _e7142 = (_e6938 - 6372600f);
                                let _e7150 = ((fma(fma(_e7117.x, (1f - _e7098), (_e7136.x * _e7098)), 0.0625f, fma(fma(_e7068.x, (1f - _e7049), (_e7087.x * _e7049)), 0.125f, fma(fma(_e6969.x, (1f - _e6950), (_e6988.x * _e6950)), 0.5f, (fma(_e7017.x, (1f - _e6998), (_e7036.x * _e6998)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e7152 = select(_e7150, 0f, (_e7150 < 0f));
                                let _e7154 = select(_e7152, 1f, (_e7152 > 1f));
                                phi_5236_ = ((((_e7154 * _e7154) * fma(-2f, _e7154, 3f)) * ((1f - exp2((-0.01f * _e7142))) * exp2((-0.004f * _e7142)))) * 0.03f);
                            }
                            let _e7161 = phi_5236_;
                            phi_5237_ = _e7161;
                            phi_5238_ = _e6941;
                        }
                        let _e7163 = phi_5237_;
                        let _e7165 = phi_5238_;
                        phi_5119_ = (_e6927 + select(_e7163, 0f, _e7165));
                    } else {
                        phi_5119_ = f32();
                    }
                    let _e7169 = phi_5119_;
                    continue;
                    continuing {
                        phi_5118_ = _e7169;
                        phi_5121_ = _e6933;
                        break if !(_e6930);
                    }
                }
                let _e7172 = local_70;
                let _e7174 = exp2((_e7172 * -62.5f));
                phi_5295_ = (_e6664 * exp2(-(_e6916)));
                phi_5296_ = fma(_e6650, 0.0625f, _e6668);
                phi_5297_ = fma(_e6651, 0.0625f, _e6670);
                phi_5298_ = fma(_e6652, 0.0625f, _e6672);
                phi_5299_ = fma(((fma((((0.4807763f * _e7174) * _e6923) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e6920) * 3.1415927f), _e6664, _e6674);
                phi_5300_ = fma(((fma((((0.28401393f * _e7174) * _e6923) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e6920) * 3.1415927f), _e6664, _e6676);
                phi_5301_ = fma(((fma((((0.09044314f * _e7174) * _e6923) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e6920) * 3.1415927f), _e6664, _e6678);
            }
            let _e7206 = phi_5295_;
            let _e7208 = phi_5296_;
            let _e7210 = phi_5297_;
            let _e7212 = phi_5298_;
            let _e7214 = phi_5299_;
            let _e7216 = phi_5300_;
            let _e7218 = phi_5301_;
            phi_4956_ = _e7206;
            phi_4961_ = _e7208;
            phi_4963_ = _e7210;
            phi_4965_ = _e7212;
            phi_4967_ = _e7214;
            phi_4969_ = _e7216;
            phi_4971_ = _e7218;
        } else {
            phi_4956_ = f32();
            phi_4961_ = f32();
            phi_4963_ = f32();
            phi_4965_ = f32();
            phi_4967_ = f32();
            phi_4969_ = f32();
            phi_4971_ = f32();
        }
        let _e7220 = phi_4956_;
        let _e7222 = phi_4961_;
        let _e7224 = phi_4963_;
        let _e7226 = phi_4965_;
        let _e7228 = phi_4967_;
        let _e7230 = phi_4969_;
        let _e7232 = phi_4971_;
        continue;
        continuing {
            phi_4955_ = _e7220;
            phi_4958_ = _e6682;
            phi_4960_ = _e7222;
            phi_4962_ = _e7224;
            phi_4964_ = _e7226;
            phi_4966_ = _e7228;
            phi_4968_ = _e7230;
            phi_4970_ = _e7232;
            break if !(_e6679);
        }
    }
    let _e7235 = local_71;
    let _e7237 = local_72;
    let _e7240 = local_73;
    let _e7242 = local_74;
    let _e7245 = local_75;
    let _e7247 = local_76;
    let _e7253 = (sqrt(fma(_e6646, _e6646, fma(_e6644, _e6644, (_e6645 * _e6645)))) * 0.00001f);
    let _e7255 = select(_e7253, 0f, (_e7253 < 0f));
    let _e7257 = select(_e7255, 1f, (_e7255 > 1f));
    let _e7258 = (1f - _e7257);
    let _e7262 = fma(fma(_e6629, _e7235, _e7237), _e7258, (_e6629 * _e7257));
    let _e7263 = fma(fma(_e6630, _e7240, _e7242), _e7258, (_e6630 * _e7257));
    let _e7264 = fma(fma(_e6631, _e7245, _e7247), _e7258, (_e6631 * _e7257));
    if _e274 {
        phi_22353_ = vec2<f32>(-1f, -1f);
    } else {
        phi_22353_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e7269 = phi_22353_;
    if _e283 {
        phi_22393_ = vec2<f32>(-1f, -1f);
    } else {
        phi_22393_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e7275 = phi_22393_;
    let _e7277 = (_e144.x * _e7269.y);
    let _e7278 = (_e144.y * _e7269.y);
    let _e7279 = (_e144.z * _e7269.y);
    let _e7283 = fma(_e296, _e7269.y, (_e144.x + _e7275.y));
    let _e7284 = fma(_e298, _e7269.y, (_e144.y + _e7275.y));
    let _e7285 = fma(_e300, _e7269.y, (_e144.z + _e7275.y));
    let _e7286 = (_e7283 * 0.0625f);
    let _e7287 = (_e7284 * 0.0625f);
    let _e7288 = (_e7285 * 0.0625f);
    phi_5409_ = 1f;
    phi_5412_ = 0u;
    phi_5414_ = fma(_e7286, _e181, _e7277);
    phi_5416_ = fma(_e7287, _e181, _e7278);
    phi_5418_ = fma(_e7288, _e181, _e7279);
    phi_5420_ = 0f;
    phi_5422_ = 0f;
    phi_5424_ = 0f;
    loop {
        let _e7297 = phi_5409_;
        let _e7299 = phi_5412_;
        let _e7301 = phi_5414_;
        let _e7303 = phi_5416_;
        let _e7305 = phi_5418_;
        let _e7307 = phi_5420_;
        let _e7309 = phi_5422_;
        let _e7311 = phi_5424_;
        local_78 = _e7297;
        local_79 = _e7307;
        local_80 = _e7297;
        local_81 = _e7309;
        local_82 = _e7297;
        local_83 = _e7311;
        let _e7312 = (_e7299 < 16u);
        if _e7312 {
            phi_5413_ = (_e7299 + 1u);
        } else {
            phi_5413_ = _e7299;
        }
        let _e7315 = phi_5413_;
        if _e7312 {
            let _e7316 = (_e7303 + 6371000f);
            let _e7320 = sqrt(fma(_e7305, _e7305, fma(_e7301, _e7301, (_e7316 * _e7316))));
            let _e7321 = (_e7320 - 6371000f);
            if (_e7321 < 1600f) {
                phi_5540_ = f32();
                phi_5541_ = true;
            } else {
                let _e7323 = (_e7321 > 2100f);
                if _e7323 {
                    phi_5539_ = f32();
                } else {
                    let _e7327 = global_2.member.member[0u];
                    let _e7328 = (_e7327 * 0.02f);
                    let _e7329 = fma(_e7301, 0.001f, _e7328);
                    let _e7330 = fma(_e7305, 0.001f, _e7328);
                    let _e7331 = floor(_e7330);
                    let _e7332 = (_e7330 - _e7331);
                    let _e7333 = (_e7331 * 0.265625f);
                    let _e7334 = fma(_e7329, 0.015625f, _e7333);
                    let _e7335 = fma(_e7321, 0.000015625f, _e7333);
                    if (_e7334 > 0f) {
                        phi_22618_ = (_e7334 % 1f);
                    } else {
                        phi_22618_ = (1f - (-(_e7334) % 1f));
                    }
                    let _e7342 = phi_22618_;
                    if (_e7335 > 0f) {
                        phi_22631_ = (_e7335 % 1f);
                    } else {
                        phi_22631_ = (1f - (-(_e7335) % 1f));
                    }
                    let _e7349 = phi_22631_;
                    let _e7351 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7342, _e7349), 0f);
                    let _e7353 = (_e7334 + 0.265625f);
                    let _e7354 = (_e7335 + 0.265625f);
                    if (_e7353 > 0f) {
                        phi_22661_ = (_e7353 % 1f);
                    } else {
                        phi_22661_ = (1f - ((-0.265625f - _e7334) % 1f));
                    }
                    let _e7361 = phi_22661_;
                    if (_e7354 > 0f) {
                        phi_22674_ = (_e7354 % 1f);
                    } else {
                        phi_22674_ = (1f - ((-0.265625f - _e7335) % 1f));
                    }
                    let _e7368 = phi_22674_;
                    let _e7370 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7361, _e7368), 0f);
                    let _e7375 = fma(_e7327, 0.02f, 2f);
                    let _e7378 = floor((_e7330 * _e7375));
                    let _e7380 = fma(_e7330, _e7375, -(_e7378));
                    let _e7381 = (_e7378 * 0.265625f);
                    let _e7382 = fma((_e7329 * _e7375), 0.015625f, _e7381);
                    let _e7383 = fma(_e7321, 0.00003125f, _e7381);
                    if (_e7382 > 0f) {
                        phi_22734_ = (_e7382 % 1f);
                    } else {
                        phi_22734_ = (1f - (-(_e7382) % 1f));
                    }
                    let _e7390 = phi_22734_;
                    if (_e7383 > 0f) {
                        phi_22747_ = (_e7383 % 1f);
                    } else {
                        phi_22747_ = (1f - (-(_e7383) % 1f));
                    }
                    let _e7397 = phi_22747_;
                    let _e7399 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7390, _e7397), 0f);
                    let _e7401 = (_e7382 + 0.265625f);
                    let _e7402 = (_e7383 + 0.265625f);
                    if (_e7401 > 0f) {
                        phi_22777_ = (_e7401 % 1f);
                    } else {
                        phi_22777_ = (1f - ((-0.265625f - _e7382) % 1f));
                    }
                    let _e7409 = phi_22777_;
                    if (_e7402 > 0f) {
                        phi_22790_ = (_e7402 % 1f);
                    } else {
                        phi_22790_ = (1f - ((-0.265625f - _e7383) % 1f));
                    }
                    let _e7416 = phi_22790_;
                    let _e7418 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7409, _e7416), 0f);
                    let _e7426 = fma(-(_e7327), 0.02f, 7f);
                    let _e7429 = floor((_e7330 * _e7426));
                    let _e7431 = fma(_e7330, _e7426, -(_e7429));
                    let _e7432 = (_e7429 * 0.265625f);
                    let _e7433 = fma((_e7329 * _e7426), 0.015625f, _e7432);
                    let _e7434 = fma(_e7321, 0.000109375f, _e7432);
                    if (_e7433 > 0f) {
                        phi_22850_ = (_e7433 % 1f);
                    } else {
                        phi_22850_ = (1f - (-(_e7433) % 1f));
                    }
                    let _e7441 = phi_22850_;
                    if (_e7434 > 0f) {
                        phi_22863_ = (_e7434 % 1f);
                    } else {
                        phi_22863_ = (1f - (-(_e7434) % 1f));
                    }
                    let _e7448 = phi_22863_;
                    let _e7450 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7441, _e7448), 0f);
                    let _e7452 = (_e7433 + 0.265625f);
                    let _e7453 = (_e7434 + 0.265625f);
                    if (_e7452 > 0f) {
                        phi_22893_ = (_e7452 % 1f);
                    } else {
                        phi_22893_ = (1f - ((-0.265625f - _e7433) % 1f));
                    }
                    let _e7460 = phi_22893_;
                    if (_e7453 > 0f) {
                        phi_22906_ = (_e7453 % 1f);
                    } else {
                        phi_22906_ = (1f - ((-0.265625f - _e7434) % 1f));
                    }
                    let _e7467 = phi_22906_;
                    let _e7469 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7460, _e7467), 0f);
                    let _e7476 = fma(_e7327, 0.02f, _e7330);
                    let _e7478 = floor((_e7476 * 16f));
                    let _e7480 = fma(_e7476, 16f, -(_e7478));
                    let _e7481 = (_e7478 * 0.265625f);
                    let _e7482 = fma(fma(_e7327, 0.02f, _e7329), 0.25f, _e7481);
                    let _e7483 = fma(_e7321, 0.00025f, _e7481);
                    if (_e7482 > 0f) {
                        phi_22966_ = (_e7482 % 1f);
                    } else {
                        phi_22966_ = (1f - (-(_e7482) % 1f));
                    }
                    let _e7490 = phi_22966_;
                    if (_e7483 > 0f) {
                        phi_22979_ = (_e7483 % 1f);
                    } else {
                        phi_22979_ = (1f - (-(_e7483) % 1f));
                    }
                    let _e7497 = phi_22979_;
                    let _e7499 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7490, _e7497), 0f);
                    let _e7501 = (_e7482 + 0.265625f);
                    let _e7502 = (_e7483 + 0.265625f);
                    if (_e7501 > 0f) {
                        phi_23009_ = (_e7501 % 1f);
                    } else {
                        phi_23009_ = (1f - ((-0.265625f - _e7482) % 1f));
                    }
                    let _e7509 = phi_23009_;
                    if (_e7502 > 0f) {
                        phi_23022_ = (_e7502 % 1f);
                    } else {
                        phi_23022_ = (1f - ((-0.265625f - _e7483) % 1f));
                    }
                    let _e7516 = phi_23022_;
                    let _e7518 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7509, _e7516), 0f);
                    let _e7524 = (_e7320 - 6372600f);
                    let _e7532 = ((fma(fma(_e7499.x, (1f - _e7480), (_e7518.x * _e7480)), 0.0625f, fma(fma(_e7450.x, (1f - _e7431), (_e7469.x * _e7431)), 0.125f, fma(fma(_e7351.x, (1f - _e7332), (_e7370.x * _e7332)), 0.5f, (fma(_e7399.x, (1f - _e7380), (_e7418.x * _e7380)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e7534 = select(_e7532, 0f, (_e7532 < 0f));
                    let _e7536 = select(_e7534, 1f, (_e7534 > 1f));
                    phi_5539_ = ((((_e7536 * _e7536) * fma(-2f, _e7536, 3f)) * ((1f - exp2((-0.01f * _e7524))) * exp2((-0.004f * _e7524)))) * 0.03f);
                }
                let _e7543 = phi_5539_;
                phi_5540_ = _e7543;
                phi_5541_ = _e7323;
            }
            let _e7545 = phi_5540_;
            let _e7547 = phi_5541_;
            let _e7549 = (select(_e7545, 0f, _e7547) * sqrt(fma(_e7288, _e7288, fma(_e7286, _e7286, (_e7287 * _e7287)))));
            if (_e7549 <= 0f) {
                phi_5749_ = _e7297;
                phi_5750_ = _e7301;
                phi_5751_ = _e7303;
                phi_5752_ = _e7305;
                phi_5753_ = _e7307;
                phi_5754_ = _e7309;
                phi_5755_ = _e7311;
            } else {
                let _e7553 = fma(exp2((-1.6013916f * _e7549)), -0.9009009f, 0.9009009f);
                let _e7556 = (1f - exp2((_e7549 * -1.3862944f)));
                let _e7557 = (-9.537895f + _e7301);
                let _e7558 = (29.354609f + _e7305);
                phi_5572_ = 0f;
                phi_5575_ = 0u;
                loop {
                    let _e7560 = phi_5572_;
                    let _e7562 = phi_5575_;
                    local_77 = _e7560;
                    let _e7563 = (_e7562 < 8u);
                    if _e7563 {
                        phi_5576_ = (_e7562 + 1u);
                    } else {
                        phi_5576_ = _e7562;
                    }
                    let _e7566 = phi_5576_;
                    if _e7563 {
                        let _e7567 = (_e7303 + 6371005f);
                        let _e7571 = sqrt(fma(_e7558, _e7558, fma(_e7557, _e7557, (_e7567 * _e7567))));
                        let _e7572 = (_e7571 - 6371000f);
                        if (_e7572 < 1600f) {
                            phi_5691_ = f32();
                            phi_5692_ = true;
                        } else {
                            let _e7574 = (_e7572 > 2100f);
                            if _e7574 {
                                phi_5690_ = f32();
                            } else {
                                let _e7578 = global_2.member.member[0u];
                                let _e7579 = (_e7578 * 0.02f);
                                let _e7580 = fma(_e7557, 0.001f, _e7579);
                                let _e7581 = fma(_e7558, 0.001f, _e7579);
                                let _e7582 = floor(_e7581);
                                let _e7583 = (_e7581 - _e7582);
                                let _e7584 = (_e7582 * 0.265625f);
                                let _e7585 = fma(_e7580, 0.015625f, _e7584);
                                let _e7586 = fma(_e7572, 0.000015625f, _e7584);
                                if (_e7585 > 0f) {
                                    phi_23098_ = (_e7585 % 1f);
                                } else {
                                    phi_23098_ = (1f - (-(_e7585) % 1f));
                                }
                                let _e7593 = phi_23098_;
                                if (_e7586 > 0f) {
                                    phi_23111_ = (_e7586 % 1f);
                                } else {
                                    phi_23111_ = (1f - (-(_e7586) % 1f));
                                }
                                let _e7600 = phi_23111_;
                                let _e7602 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7593, _e7600), 0f);
                                let _e7604 = (_e7585 + 0.265625f);
                                let _e7605 = (_e7586 + 0.265625f);
                                if (_e7604 > 0f) {
                                    phi_23141_ = (_e7604 % 1f);
                                } else {
                                    phi_23141_ = (1f - ((-0.265625f - _e7585) % 1f));
                                }
                                let _e7612 = phi_23141_;
                                if (_e7605 > 0f) {
                                    phi_23154_ = (_e7605 % 1f);
                                } else {
                                    phi_23154_ = (1f - ((-0.265625f - _e7586) % 1f));
                                }
                                let _e7619 = phi_23154_;
                                let _e7621 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7612, _e7619), 0f);
                                let _e7626 = fma(_e7578, 0.02f, 2f);
                                let _e7629 = floor((_e7581 * _e7626));
                                let _e7631 = fma(_e7581, _e7626, -(_e7629));
                                let _e7632 = (_e7629 * 0.265625f);
                                let _e7633 = fma((_e7580 * _e7626), 0.015625f, _e7632);
                                let _e7634 = fma(_e7572, 0.00003125f, _e7632);
                                if (_e7633 > 0f) {
                                    phi_23214_ = (_e7633 % 1f);
                                } else {
                                    phi_23214_ = (1f - (-(_e7633) % 1f));
                                }
                                let _e7641 = phi_23214_;
                                if (_e7634 > 0f) {
                                    phi_23227_ = (_e7634 % 1f);
                                } else {
                                    phi_23227_ = (1f - (-(_e7634) % 1f));
                                }
                                let _e7648 = phi_23227_;
                                let _e7650 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7641, _e7648), 0f);
                                let _e7652 = (_e7633 + 0.265625f);
                                let _e7653 = (_e7634 + 0.265625f);
                                if (_e7652 > 0f) {
                                    phi_23257_ = (_e7652 % 1f);
                                } else {
                                    phi_23257_ = (1f - ((-0.265625f - _e7633) % 1f));
                                }
                                let _e7660 = phi_23257_;
                                if (_e7653 > 0f) {
                                    phi_23270_ = (_e7653 % 1f);
                                } else {
                                    phi_23270_ = (1f - ((-0.265625f - _e7634) % 1f));
                                }
                                let _e7667 = phi_23270_;
                                let _e7669 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7660, _e7667), 0f);
                                let _e7677 = fma(-(_e7578), 0.02f, 7f);
                                let _e7680 = floor((_e7581 * _e7677));
                                let _e7682 = fma(_e7581, _e7677, -(_e7680));
                                let _e7683 = (_e7680 * 0.265625f);
                                let _e7684 = fma((_e7580 * _e7677), 0.015625f, _e7683);
                                let _e7685 = fma(_e7572, 0.000109375f, _e7683);
                                if (_e7684 > 0f) {
                                    phi_23330_ = (_e7684 % 1f);
                                } else {
                                    phi_23330_ = (1f - (-(_e7684) % 1f));
                                }
                                let _e7692 = phi_23330_;
                                if (_e7685 > 0f) {
                                    phi_23343_ = (_e7685 % 1f);
                                } else {
                                    phi_23343_ = (1f - (-(_e7685) % 1f));
                                }
                                let _e7699 = phi_23343_;
                                let _e7701 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7692, _e7699), 0f);
                                let _e7703 = (_e7684 + 0.265625f);
                                let _e7704 = (_e7685 + 0.265625f);
                                if (_e7703 > 0f) {
                                    phi_23373_ = (_e7703 % 1f);
                                } else {
                                    phi_23373_ = (1f - ((-0.265625f - _e7684) % 1f));
                                }
                                let _e7711 = phi_23373_;
                                if (_e7704 > 0f) {
                                    phi_23386_ = (_e7704 % 1f);
                                } else {
                                    phi_23386_ = (1f - ((-0.265625f - _e7685) % 1f));
                                }
                                let _e7718 = phi_23386_;
                                let _e7720 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7711, _e7718), 0f);
                                let _e7727 = fma(_e7578, 0.02f, _e7581);
                                let _e7729 = floor((_e7727 * 16f));
                                let _e7731 = fma(_e7727, 16f, -(_e7729));
                                let _e7732 = (_e7729 * 0.265625f);
                                let _e7733 = fma(fma(_e7578, 0.02f, _e7580), 0.25f, _e7732);
                                let _e7734 = fma(_e7572, 0.00025f, _e7732);
                                if (_e7733 > 0f) {
                                    phi_23446_ = (_e7733 % 1f);
                                } else {
                                    phi_23446_ = (1f - (-(_e7733) % 1f));
                                }
                                let _e7741 = phi_23446_;
                                if (_e7734 > 0f) {
                                    phi_23459_ = (_e7734 % 1f);
                                } else {
                                    phi_23459_ = (1f - (-(_e7734) % 1f));
                                }
                                let _e7748 = phi_23459_;
                                let _e7750 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7741, _e7748), 0f);
                                let _e7752 = (_e7733 + 0.265625f);
                                let _e7753 = (_e7734 + 0.265625f);
                                if (_e7752 > 0f) {
                                    phi_23489_ = (_e7752 % 1f);
                                } else {
                                    phi_23489_ = (1f - ((-0.265625f - _e7733) % 1f));
                                }
                                let _e7760 = phi_23489_;
                                if (_e7753 > 0f) {
                                    phi_23502_ = (_e7753 % 1f);
                                } else {
                                    phi_23502_ = (1f - ((-0.265625f - _e7734) % 1f));
                                }
                                let _e7767 = phi_23502_;
                                let _e7769 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7760, _e7767), 0f);
                                let _e7775 = (_e7571 - 6372600f);
                                let _e7783 = ((fma(fma(_e7750.x, (1f - _e7731), (_e7769.x * _e7731)), 0.0625f, fma(fma(_e7701.x, (1f - _e7682), (_e7720.x * _e7682)), 0.125f, fma(fma(_e7602.x, (1f - _e7583), (_e7621.x * _e7583)), 0.5f, (fma(_e7650.x, (1f - _e7631), (_e7669.x * _e7631)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e7785 = select(_e7783, 0f, (_e7783 < 0f));
                                let _e7787 = select(_e7785, 1f, (_e7785 > 1f));
                                phi_5690_ = ((((_e7787 * _e7787) * fma(-2f, _e7787, 3f)) * ((1f - exp2((-0.01f * _e7775))) * exp2((-0.004f * _e7775)))) * 0.03f);
                            }
                            let _e7794 = phi_5690_;
                            phi_5691_ = _e7794;
                            phi_5692_ = _e7574;
                        }
                        let _e7796 = phi_5691_;
                        let _e7798 = phi_5692_;
                        phi_5573_ = (_e7560 + select(_e7796, 0f, _e7798));
                    } else {
                        phi_5573_ = f32();
                    }
                    let _e7802 = phi_5573_;
                    continue;
                    continuing {
                        phi_5572_ = _e7802;
                        phi_5575_ = _e7566;
                        break if !(_e7563);
                    }
                }
                let _e7805 = local_77;
                let _e7807 = exp2((_e7805 * -62.5f));
                phi_5749_ = (_e7297 * exp2(-(_e7549)));
                phi_5750_ = fma(_e7283, 0.0625f, _e7301);
                phi_5751_ = fma(_e7284, 0.0625f, _e7303);
                phi_5752_ = fma(_e7285, 0.0625f, _e7305);
                phi_5753_ = fma(((fma((((0.4807763f * _e7807) * _e7556) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e7553) * 3.1415927f), _e7297, _e7307);
                phi_5754_ = fma(((fma((((0.28401393f * _e7807) * _e7556) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e7553) * 3.1415927f), _e7297, _e7309);
                phi_5755_ = fma(((fma((((0.09044314f * _e7807) * _e7556) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e7553) * 3.1415927f), _e7297, _e7311);
            }
            let _e7839 = phi_5749_;
            let _e7841 = phi_5750_;
            let _e7843 = phi_5751_;
            let _e7845 = phi_5752_;
            let _e7847 = phi_5753_;
            let _e7849 = phi_5754_;
            let _e7851 = phi_5755_;
            phi_5410_ = _e7839;
            phi_5415_ = _e7841;
            phi_5417_ = _e7843;
            phi_5419_ = _e7845;
            phi_5421_ = _e7847;
            phi_5423_ = _e7849;
            phi_5425_ = _e7851;
        } else {
            phi_5410_ = f32();
            phi_5415_ = f32();
            phi_5417_ = f32();
            phi_5419_ = f32();
            phi_5421_ = f32();
            phi_5423_ = f32();
            phi_5425_ = f32();
        }
        let _e7853 = phi_5410_;
        let _e7855 = phi_5415_;
        let _e7857 = phi_5417_;
        let _e7859 = phi_5419_;
        let _e7861 = phi_5421_;
        let _e7863 = phi_5423_;
        let _e7865 = phi_5425_;
        continue;
        continuing {
            phi_5409_ = _e7853;
            phi_5412_ = _e7315;
            phi_5414_ = _e7855;
            phi_5416_ = _e7857;
            phi_5418_ = _e7859;
            phi_5420_ = _e7861;
            phi_5422_ = _e7863;
            phi_5424_ = _e7865;
            break if !(_e7312);
        }
    }
    let _e7868 = local_78;
    let _e7870 = local_79;
    let _e7873 = local_80;
    let _e7875 = local_81;
    let _e7878 = local_82;
    let _e7880 = local_83;
    let _e7886 = (sqrt(fma(_e7279, _e7279, fma(_e7277, _e7277, (_e7278 * _e7278)))) * 0.00001f);
    let _e7888 = select(_e7886, 0f, (_e7886 < 0f));
    let _e7890 = select(_e7888, 1f, (_e7888 > 1f));
    let _e7891 = (1f - _e7890);
    let _e7895 = fma(fma(_e7262, _e7868, _e7870), _e7891, (_e7262 * _e7890));
    let _e7896 = fma(fma(_e7263, _e7873, _e7875), _e7891, (_e7263 * _e7890));
    let _e7897 = fma(fma(_e7264, _e7878, _e7880), _e7891, (_e7264 * _e7890));
    if _e274 {
        phi_23576_ = vec2<f32>(-1f, -1f);
    } else {
        phi_23576_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e7902 = phi_23576_;
    if _e283 {
        phi_23616_ = vec2<f32>(-1f, -1f);
    } else {
        phi_23616_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e7908 = phi_23616_;
    let _e7910 = (_e144.x * _e7902.y);
    let _e7911 = (_e144.y * _e7902.y);
    let _e7912 = (_e144.z * _e7902.y);
    let _e7916 = fma(_e296, _e7902.y, (_e144.x + _e7908.y));
    let _e7917 = fma(_e298, _e7902.y, (_e144.y + _e7908.y));
    let _e7918 = fma(_e300, _e7902.y, (_e144.z + _e7908.y));
    let _e7919 = (_e7916 * 0.0625f);
    let _e7920 = (_e7917 * 0.0625f);
    let _e7921 = (_e7918 * 0.0625f);
    phi_5863_ = 1f;
    phi_5866_ = 0u;
    phi_5868_ = fma(_e7919, _e181, _e7910);
    phi_5870_ = fma(_e7920, _e181, _e7911);
    phi_5872_ = fma(_e7921, _e181, _e7912);
    phi_5874_ = 0f;
    phi_5876_ = 0f;
    phi_5878_ = 0f;
    loop {
        let _e7930 = phi_5863_;
        let _e7932 = phi_5866_;
        let _e7934 = phi_5868_;
        let _e7936 = phi_5870_;
        let _e7938 = phi_5872_;
        let _e7940 = phi_5874_;
        let _e7942 = phi_5876_;
        let _e7944 = phi_5878_;
        local_85 = _e7930;
        local_86 = _e7940;
        local_87 = _e7930;
        local_88 = _e7942;
        local_89 = _e7930;
        local_90 = _e7944;
        let _e7945 = (_e7932 < 16u);
        if _e7945 {
            phi_5867_ = (_e7932 + 1u);
        } else {
            phi_5867_ = _e7932;
        }
        let _e7948 = phi_5867_;
        if _e7945 {
            let _e7949 = (_e7936 + 6371000f);
            let _e7953 = sqrt(fma(_e7938, _e7938, fma(_e7934, _e7934, (_e7949 * _e7949))));
            let _e7954 = (_e7953 - 6371000f);
            if (_e7954 < 1600f) {
                phi_5994_ = f32();
                phi_5995_ = true;
            } else {
                let _e7956 = (_e7954 > 2100f);
                if _e7956 {
                    phi_5993_ = f32();
                } else {
                    let _e7960 = global_2.member.member[0u];
                    let _e7961 = (_e7960 * 0.02f);
                    let _e7962 = fma(_e7934, 0.001f, _e7961);
                    let _e7963 = fma(_e7938, 0.001f, _e7961);
                    let _e7964 = floor(_e7963);
                    let _e7965 = (_e7963 - _e7964);
                    let _e7966 = (_e7964 * 0.265625f);
                    let _e7967 = fma(_e7962, 0.015625f, _e7966);
                    let _e7968 = fma(_e7954, 0.000015625f, _e7966);
                    if (_e7967 > 0f) {
                        phi_23841_ = (_e7967 % 1f);
                    } else {
                        phi_23841_ = (1f - (-(_e7967) % 1f));
                    }
                    let _e7975 = phi_23841_;
                    if (_e7968 > 0f) {
                        phi_23854_ = (_e7968 % 1f);
                    } else {
                        phi_23854_ = (1f - (-(_e7968) % 1f));
                    }
                    let _e7982 = phi_23854_;
                    let _e7984 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7975, _e7982), 0f);
                    let _e7986 = (_e7967 + 0.265625f);
                    let _e7987 = (_e7968 + 0.265625f);
                    if (_e7986 > 0f) {
                        phi_23884_ = (_e7986 % 1f);
                    } else {
                        phi_23884_ = (1f - ((-0.265625f - _e7967) % 1f));
                    }
                    let _e7994 = phi_23884_;
                    if (_e7987 > 0f) {
                        phi_23897_ = (_e7987 % 1f);
                    } else {
                        phi_23897_ = (1f - ((-0.265625f - _e7968) % 1f));
                    }
                    let _e8001 = phi_23897_;
                    let _e8003 = textureSampleLevel(global_3, global_4, vec2<f32>(_e7994, _e8001), 0f);
                    let _e8008 = fma(_e7960, 0.02f, 2f);
                    let _e8011 = floor((_e7963 * _e8008));
                    let _e8013 = fma(_e7963, _e8008, -(_e8011));
                    let _e8014 = (_e8011 * 0.265625f);
                    let _e8015 = fma((_e7962 * _e8008), 0.015625f, _e8014);
                    let _e8016 = fma(_e7954, 0.00003125f, _e8014);
                    if (_e8015 > 0f) {
                        phi_23957_ = (_e8015 % 1f);
                    } else {
                        phi_23957_ = (1f - (-(_e8015) % 1f));
                    }
                    let _e8023 = phi_23957_;
                    if (_e8016 > 0f) {
                        phi_23970_ = (_e8016 % 1f);
                    } else {
                        phi_23970_ = (1f - (-(_e8016) % 1f));
                    }
                    let _e8030 = phi_23970_;
                    let _e8032 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8023, _e8030), 0f);
                    let _e8034 = (_e8015 + 0.265625f);
                    let _e8035 = (_e8016 + 0.265625f);
                    if (_e8034 > 0f) {
                        phi_24000_ = (_e8034 % 1f);
                    } else {
                        phi_24000_ = (1f - ((-0.265625f - _e8015) % 1f));
                    }
                    let _e8042 = phi_24000_;
                    if (_e8035 > 0f) {
                        phi_24013_ = (_e8035 % 1f);
                    } else {
                        phi_24013_ = (1f - ((-0.265625f - _e8016) % 1f));
                    }
                    let _e8049 = phi_24013_;
                    let _e8051 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8042, _e8049), 0f);
                    let _e8059 = fma(-(_e7960), 0.02f, 7f);
                    let _e8062 = floor((_e7963 * _e8059));
                    let _e8064 = fma(_e7963, _e8059, -(_e8062));
                    let _e8065 = (_e8062 * 0.265625f);
                    let _e8066 = fma((_e7962 * _e8059), 0.015625f, _e8065);
                    let _e8067 = fma(_e7954, 0.000109375f, _e8065);
                    if (_e8066 > 0f) {
                        phi_24073_ = (_e8066 % 1f);
                    } else {
                        phi_24073_ = (1f - (-(_e8066) % 1f));
                    }
                    let _e8074 = phi_24073_;
                    if (_e8067 > 0f) {
                        phi_24086_ = (_e8067 % 1f);
                    } else {
                        phi_24086_ = (1f - (-(_e8067) % 1f));
                    }
                    let _e8081 = phi_24086_;
                    let _e8083 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8074, _e8081), 0f);
                    let _e8085 = (_e8066 + 0.265625f);
                    let _e8086 = (_e8067 + 0.265625f);
                    if (_e8085 > 0f) {
                        phi_24116_ = (_e8085 % 1f);
                    } else {
                        phi_24116_ = (1f - ((-0.265625f - _e8066) % 1f));
                    }
                    let _e8093 = phi_24116_;
                    if (_e8086 > 0f) {
                        phi_24129_ = (_e8086 % 1f);
                    } else {
                        phi_24129_ = (1f - ((-0.265625f - _e8067) % 1f));
                    }
                    let _e8100 = phi_24129_;
                    let _e8102 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8093, _e8100), 0f);
                    let _e8109 = fma(_e7960, 0.02f, _e7963);
                    let _e8111 = floor((_e8109 * 16f));
                    let _e8113 = fma(_e8109, 16f, -(_e8111));
                    let _e8114 = (_e8111 * 0.265625f);
                    let _e8115 = fma(fma(_e7960, 0.02f, _e7962), 0.25f, _e8114);
                    let _e8116 = fma(_e7954, 0.00025f, _e8114);
                    if (_e8115 > 0f) {
                        phi_24189_ = (_e8115 % 1f);
                    } else {
                        phi_24189_ = (1f - (-(_e8115) % 1f));
                    }
                    let _e8123 = phi_24189_;
                    if (_e8116 > 0f) {
                        phi_24202_ = (_e8116 % 1f);
                    } else {
                        phi_24202_ = (1f - (-(_e8116) % 1f));
                    }
                    let _e8130 = phi_24202_;
                    let _e8132 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8123, _e8130), 0f);
                    let _e8134 = (_e8115 + 0.265625f);
                    let _e8135 = (_e8116 + 0.265625f);
                    if (_e8134 > 0f) {
                        phi_24232_ = (_e8134 % 1f);
                    } else {
                        phi_24232_ = (1f - ((-0.265625f - _e8115) % 1f));
                    }
                    let _e8142 = phi_24232_;
                    if (_e8135 > 0f) {
                        phi_24245_ = (_e8135 % 1f);
                    } else {
                        phi_24245_ = (1f - ((-0.265625f - _e8116) % 1f));
                    }
                    let _e8149 = phi_24245_;
                    let _e8151 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8142, _e8149), 0f);
                    let _e8157 = (_e7953 - 6372600f);
                    let _e8165 = ((fma(fma(_e8132.x, (1f - _e8113), (_e8151.x * _e8113)), 0.0625f, fma(fma(_e8083.x, (1f - _e8064), (_e8102.x * _e8064)), 0.125f, fma(fma(_e7984.x, (1f - _e7965), (_e8003.x * _e7965)), 0.5f, (fma(_e8032.x, (1f - _e8013), (_e8051.x * _e8013)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e8167 = select(_e8165, 0f, (_e8165 < 0f));
                    let _e8169 = select(_e8167, 1f, (_e8167 > 1f));
                    phi_5993_ = ((((_e8169 * _e8169) * fma(-2f, _e8169, 3f)) * ((1f - exp2((-0.01f * _e8157))) * exp2((-0.004f * _e8157)))) * 0.03f);
                }
                let _e8176 = phi_5993_;
                phi_5994_ = _e8176;
                phi_5995_ = _e7956;
            }
            let _e8178 = phi_5994_;
            let _e8180 = phi_5995_;
            let _e8182 = (select(_e8178, 0f, _e8180) * sqrt(fma(_e7921, _e7921, fma(_e7919, _e7919, (_e7920 * _e7920)))));
            if (_e8182 <= 0f) {
                phi_6203_ = _e7930;
                phi_6204_ = _e7934;
                phi_6205_ = _e7936;
                phi_6206_ = _e7938;
                phi_6207_ = _e7940;
                phi_6208_ = _e7942;
                phi_6209_ = _e7944;
            } else {
                let _e8186 = fma(exp2((-1.6013916f * _e8182)), -0.9009009f, 0.9009009f);
                let _e8189 = (1f - exp2((_e8182 * -1.3862944f)));
                let _e8190 = (-9.537895f + _e7934);
                let _e8191 = (29.354609f + _e7938);
                phi_6026_ = 0f;
                phi_6029_ = 0u;
                loop {
                    let _e8193 = phi_6026_;
                    let _e8195 = phi_6029_;
                    local_84 = _e8193;
                    let _e8196 = (_e8195 < 8u);
                    if _e8196 {
                        phi_6030_ = (_e8195 + 1u);
                    } else {
                        phi_6030_ = _e8195;
                    }
                    let _e8199 = phi_6030_;
                    if _e8196 {
                        let _e8200 = (_e7936 + 6371005f);
                        let _e8204 = sqrt(fma(_e8191, _e8191, fma(_e8190, _e8190, (_e8200 * _e8200))));
                        let _e8205 = (_e8204 - 6371000f);
                        if (_e8205 < 1600f) {
                            phi_6145_ = f32();
                            phi_6146_ = true;
                        } else {
                            let _e8207 = (_e8205 > 2100f);
                            if _e8207 {
                                phi_6144_ = f32();
                            } else {
                                let _e8211 = global_2.member.member[0u];
                                let _e8212 = (_e8211 * 0.02f);
                                let _e8213 = fma(_e8190, 0.001f, _e8212);
                                let _e8214 = fma(_e8191, 0.001f, _e8212);
                                let _e8215 = floor(_e8214);
                                let _e8216 = (_e8214 - _e8215);
                                let _e8217 = (_e8215 * 0.265625f);
                                let _e8218 = fma(_e8213, 0.015625f, _e8217);
                                let _e8219 = fma(_e8205, 0.000015625f, _e8217);
                                if (_e8218 > 0f) {
                                    phi_24321_ = (_e8218 % 1f);
                                } else {
                                    phi_24321_ = (1f - (-(_e8218) % 1f));
                                }
                                let _e8226 = phi_24321_;
                                if (_e8219 > 0f) {
                                    phi_24334_ = (_e8219 % 1f);
                                } else {
                                    phi_24334_ = (1f - (-(_e8219) % 1f));
                                }
                                let _e8233 = phi_24334_;
                                let _e8235 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8226, _e8233), 0f);
                                let _e8237 = (_e8218 + 0.265625f);
                                let _e8238 = (_e8219 + 0.265625f);
                                if (_e8237 > 0f) {
                                    phi_24364_ = (_e8237 % 1f);
                                } else {
                                    phi_24364_ = (1f - ((-0.265625f - _e8218) % 1f));
                                }
                                let _e8245 = phi_24364_;
                                if (_e8238 > 0f) {
                                    phi_24377_ = (_e8238 % 1f);
                                } else {
                                    phi_24377_ = (1f - ((-0.265625f - _e8219) % 1f));
                                }
                                let _e8252 = phi_24377_;
                                let _e8254 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8245, _e8252), 0f);
                                let _e8259 = fma(_e8211, 0.02f, 2f);
                                let _e8262 = floor((_e8214 * _e8259));
                                let _e8264 = fma(_e8214, _e8259, -(_e8262));
                                let _e8265 = (_e8262 * 0.265625f);
                                let _e8266 = fma((_e8213 * _e8259), 0.015625f, _e8265);
                                let _e8267 = fma(_e8205, 0.00003125f, _e8265);
                                if (_e8266 > 0f) {
                                    phi_24437_ = (_e8266 % 1f);
                                } else {
                                    phi_24437_ = (1f - (-(_e8266) % 1f));
                                }
                                let _e8274 = phi_24437_;
                                if (_e8267 > 0f) {
                                    phi_24450_ = (_e8267 % 1f);
                                } else {
                                    phi_24450_ = (1f - (-(_e8267) % 1f));
                                }
                                let _e8281 = phi_24450_;
                                let _e8283 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8274, _e8281), 0f);
                                let _e8285 = (_e8266 + 0.265625f);
                                let _e8286 = (_e8267 + 0.265625f);
                                if (_e8285 > 0f) {
                                    phi_24480_ = (_e8285 % 1f);
                                } else {
                                    phi_24480_ = (1f - ((-0.265625f - _e8266) % 1f));
                                }
                                let _e8293 = phi_24480_;
                                if (_e8286 > 0f) {
                                    phi_24493_ = (_e8286 % 1f);
                                } else {
                                    phi_24493_ = (1f - ((-0.265625f - _e8267) % 1f));
                                }
                                let _e8300 = phi_24493_;
                                let _e8302 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8293, _e8300), 0f);
                                let _e8310 = fma(-(_e8211), 0.02f, 7f);
                                let _e8313 = floor((_e8214 * _e8310));
                                let _e8315 = fma(_e8214, _e8310, -(_e8313));
                                let _e8316 = (_e8313 * 0.265625f);
                                let _e8317 = fma((_e8213 * _e8310), 0.015625f, _e8316);
                                let _e8318 = fma(_e8205, 0.000109375f, _e8316);
                                if (_e8317 > 0f) {
                                    phi_24553_ = (_e8317 % 1f);
                                } else {
                                    phi_24553_ = (1f - (-(_e8317) % 1f));
                                }
                                let _e8325 = phi_24553_;
                                if (_e8318 > 0f) {
                                    phi_24566_ = (_e8318 % 1f);
                                } else {
                                    phi_24566_ = (1f - (-(_e8318) % 1f));
                                }
                                let _e8332 = phi_24566_;
                                let _e8334 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8325, _e8332), 0f);
                                let _e8336 = (_e8317 + 0.265625f);
                                let _e8337 = (_e8318 + 0.265625f);
                                if (_e8336 > 0f) {
                                    phi_24596_ = (_e8336 % 1f);
                                } else {
                                    phi_24596_ = (1f - ((-0.265625f - _e8317) % 1f));
                                }
                                let _e8344 = phi_24596_;
                                if (_e8337 > 0f) {
                                    phi_24609_ = (_e8337 % 1f);
                                } else {
                                    phi_24609_ = (1f - ((-0.265625f - _e8318) % 1f));
                                }
                                let _e8351 = phi_24609_;
                                let _e8353 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8344, _e8351), 0f);
                                let _e8360 = fma(_e8211, 0.02f, _e8214);
                                let _e8362 = floor((_e8360 * 16f));
                                let _e8364 = fma(_e8360, 16f, -(_e8362));
                                let _e8365 = (_e8362 * 0.265625f);
                                let _e8366 = fma(fma(_e8211, 0.02f, _e8213), 0.25f, _e8365);
                                let _e8367 = fma(_e8205, 0.00025f, _e8365);
                                if (_e8366 > 0f) {
                                    phi_24669_ = (_e8366 % 1f);
                                } else {
                                    phi_24669_ = (1f - (-(_e8366) % 1f));
                                }
                                let _e8374 = phi_24669_;
                                if (_e8367 > 0f) {
                                    phi_24682_ = (_e8367 % 1f);
                                } else {
                                    phi_24682_ = (1f - (-(_e8367) % 1f));
                                }
                                let _e8381 = phi_24682_;
                                let _e8383 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8374, _e8381), 0f);
                                let _e8385 = (_e8366 + 0.265625f);
                                let _e8386 = (_e8367 + 0.265625f);
                                if (_e8385 > 0f) {
                                    phi_24712_ = (_e8385 % 1f);
                                } else {
                                    phi_24712_ = (1f - ((-0.265625f - _e8366) % 1f));
                                }
                                let _e8393 = phi_24712_;
                                if (_e8386 > 0f) {
                                    phi_24725_ = (_e8386 % 1f);
                                } else {
                                    phi_24725_ = (1f - ((-0.265625f - _e8367) % 1f));
                                }
                                let _e8400 = phi_24725_;
                                let _e8402 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8393, _e8400), 0f);
                                let _e8408 = (_e8204 - 6372600f);
                                let _e8416 = ((fma(fma(_e8383.x, (1f - _e8364), (_e8402.x * _e8364)), 0.0625f, fma(fma(_e8334.x, (1f - _e8315), (_e8353.x * _e8315)), 0.125f, fma(fma(_e8235.x, (1f - _e8216), (_e8254.x * _e8216)), 0.5f, (fma(_e8283.x, (1f - _e8264), (_e8302.x * _e8264)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e8418 = select(_e8416, 0f, (_e8416 < 0f));
                                let _e8420 = select(_e8418, 1f, (_e8418 > 1f));
                                phi_6144_ = ((((_e8420 * _e8420) * fma(-2f, _e8420, 3f)) * ((1f - exp2((-0.01f * _e8408))) * exp2((-0.004f * _e8408)))) * 0.03f);
                            }
                            let _e8427 = phi_6144_;
                            phi_6145_ = _e8427;
                            phi_6146_ = _e8207;
                        }
                        let _e8429 = phi_6145_;
                        let _e8431 = phi_6146_;
                        phi_6027_ = (_e8193 + select(_e8429, 0f, _e8431));
                    } else {
                        phi_6027_ = f32();
                    }
                    let _e8435 = phi_6027_;
                    continue;
                    continuing {
                        phi_6026_ = _e8435;
                        phi_6029_ = _e8199;
                        break if !(_e8196);
                    }
                }
                let _e8438 = local_84;
                let _e8440 = exp2((_e8438 * -62.5f));
                phi_6203_ = (_e7930 * exp2(-(_e8182)));
                phi_6204_ = fma(_e7916, 0.0625f, _e7934);
                phi_6205_ = fma(_e7917, 0.0625f, _e7936);
                phi_6206_ = fma(_e7918, 0.0625f, _e7938);
                phi_6207_ = fma(((fma((((0.4807763f * _e8440) * _e8189) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e8186) * 3.1415927f), _e7930, _e7940);
                phi_6208_ = fma(((fma((((0.28401393f * _e8440) * _e8189) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e8186) * 3.1415927f), _e7930, _e7942);
                phi_6209_ = fma(((fma((((0.09044314f * _e8440) * _e8189) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e8186) * 3.1415927f), _e7930, _e7944);
            }
            let _e8472 = phi_6203_;
            let _e8474 = phi_6204_;
            let _e8476 = phi_6205_;
            let _e8478 = phi_6206_;
            let _e8480 = phi_6207_;
            let _e8482 = phi_6208_;
            let _e8484 = phi_6209_;
            phi_5864_ = _e8472;
            phi_5869_ = _e8474;
            phi_5871_ = _e8476;
            phi_5873_ = _e8478;
            phi_5875_ = _e8480;
            phi_5877_ = _e8482;
            phi_5879_ = _e8484;
        } else {
            phi_5864_ = f32();
            phi_5869_ = f32();
            phi_5871_ = f32();
            phi_5873_ = f32();
            phi_5875_ = f32();
            phi_5877_ = f32();
            phi_5879_ = f32();
        }
        let _e8486 = phi_5864_;
        let _e8488 = phi_5869_;
        let _e8490 = phi_5871_;
        let _e8492 = phi_5873_;
        let _e8494 = phi_5875_;
        let _e8496 = phi_5877_;
        let _e8498 = phi_5879_;
        continue;
        continuing {
            phi_5863_ = _e8486;
            phi_5866_ = _e7948;
            phi_5868_ = _e8488;
            phi_5870_ = _e8490;
            phi_5872_ = _e8492;
            phi_5874_ = _e8494;
            phi_5876_ = _e8496;
            phi_5878_ = _e8498;
            break if !(_e7945);
        }
    }
    let _e8501 = local_85;
    let _e8503 = local_86;
    let _e8506 = local_87;
    let _e8508 = local_88;
    let _e8511 = local_89;
    let _e8513 = local_90;
    let _e8519 = (sqrt(fma(_e7912, _e7912, fma(_e7910, _e7910, (_e7911 * _e7911)))) * 0.00001f);
    let _e8521 = select(_e8519, 0f, (_e8519 < 0f));
    let _e8523 = select(_e8521, 1f, (_e8521 > 1f));
    let _e8524 = (1f - _e8523);
    let _e8528 = fma(fma(_e7895, _e8501, _e8503), _e8524, (_e7895 * _e8523));
    let _e8529 = fma(fma(_e7896, _e8506, _e8508), _e8524, (_e7896 * _e8523));
    let _e8530 = fma(fma(_e7897, _e8511, _e8513), _e8524, (_e7897 * _e8523));
    if _e274 {
        phi_24799_ = vec2<f32>(-1f, -1f);
    } else {
        phi_24799_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e8535 = phi_24799_;
    if _e283 {
        phi_24839_ = vec2<f32>(-1f, -1f);
    } else {
        phi_24839_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e8541 = phi_24839_;
    let _e8543 = (_e144.x * _e8535.y);
    let _e8544 = (_e144.y * _e8535.y);
    let _e8545 = (_e144.z * _e8535.y);
    let _e8549 = fma(_e296, _e8535.y, (_e144.x + _e8541.y));
    let _e8550 = fma(_e298, _e8535.y, (_e144.y + _e8541.y));
    let _e8551 = fma(_e300, _e8535.y, (_e144.z + _e8541.y));
    let _e8552 = (_e8549 * 0.0625f);
    let _e8553 = (_e8550 * 0.0625f);
    let _e8554 = (_e8551 * 0.0625f);
    phi_6317_ = 1f;
    phi_6320_ = 0u;
    phi_6322_ = fma(_e8552, _e181, _e8543);
    phi_6324_ = fma(_e8553, _e181, _e8544);
    phi_6326_ = fma(_e8554, _e181, _e8545);
    phi_6328_ = 0f;
    phi_6330_ = 0f;
    phi_6332_ = 0f;
    loop {
        let _e8563 = phi_6317_;
        let _e8565 = phi_6320_;
        let _e8567 = phi_6322_;
        let _e8569 = phi_6324_;
        let _e8571 = phi_6326_;
        let _e8573 = phi_6328_;
        let _e8575 = phi_6330_;
        let _e8577 = phi_6332_;
        local_92 = _e8563;
        local_93 = _e8573;
        local_94 = _e8563;
        local_95 = _e8575;
        local_96 = _e8563;
        local_97 = _e8577;
        let _e8578 = (_e8565 < 16u);
        if _e8578 {
            phi_6321_ = (_e8565 + 1u);
        } else {
            phi_6321_ = _e8565;
        }
        let _e8581 = phi_6321_;
        if _e8578 {
            let _e8582 = (_e8569 + 6371000f);
            let _e8586 = sqrt(fma(_e8571, _e8571, fma(_e8567, _e8567, (_e8582 * _e8582))));
            let _e8587 = (_e8586 - 6371000f);
            if (_e8587 < 1600f) {
                phi_6448_ = f32();
                phi_6449_ = true;
            } else {
                let _e8589 = (_e8587 > 2100f);
                if _e8589 {
                    phi_6447_ = f32();
                } else {
                    let _e8593 = global_2.member.member[0u];
                    let _e8594 = (_e8593 * 0.02f);
                    let _e8595 = fma(_e8567, 0.001f, _e8594);
                    let _e8596 = fma(_e8571, 0.001f, _e8594);
                    let _e8597 = floor(_e8596);
                    let _e8598 = (_e8596 - _e8597);
                    let _e8599 = (_e8597 * 0.265625f);
                    let _e8600 = fma(_e8595, 0.015625f, _e8599);
                    let _e8601 = fma(_e8587, 0.000015625f, _e8599);
                    if (_e8600 > 0f) {
                        phi_25064_ = (_e8600 % 1f);
                    } else {
                        phi_25064_ = (1f - (-(_e8600) % 1f));
                    }
                    let _e8608 = phi_25064_;
                    if (_e8601 > 0f) {
                        phi_25077_ = (_e8601 % 1f);
                    } else {
                        phi_25077_ = (1f - (-(_e8601) % 1f));
                    }
                    let _e8615 = phi_25077_;
                    let _e8617 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8608, _e8615), 0f);
                    let _e8619 = (_e8600 + 0.265625f);
                    let _e8620 = (_e8601 + 0.265625f);
                    if (_e8619 > 0f) {
                        phi_25107_ = (_e8619 % 1f);
                    } else {
                        phi_25107_ = (1f - ((-0.265625f - _e8600) % 1f));
                    }
                    let _e8627 = phi_25107_;
                    if (_e8620 > 0f) {
                        phi_25120_ = (_e8620 % 1f);
                    } else {
                        phi_25120_ = (1f - ((-0.265625f - _e8601) % 1f));
                    }
                    let _e8634 = phi_25120_;
                    let _e8636 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8627, _e8634), 0f);
                    let _e8641 = fma(_e8593, 0.02f, 2f);
                    let _e8644 = floor((_e8596 * _e8641));
                    let _e8646 = fma(_e8596, _e8641, -(_e8644));
                    let _e8647 = (_e8644 * 0.265625f);
                    let _e8648 = fma((_e8595 * _e8641), 0.015625f, _e8647);
                    let _e8649 = fma(_e8587, 0.00003125f, _e8647);
                    if (_e8648 > 0f) {
                        phi_25180_ = (_e8648 % 1f);
                    } else {
                        phi_25180_ = (1f - (-(_e8648) % 1f));
                    }
                    let _e8656 = phi_25180_;
                    if (_e8649 > 0f) {
                        phi_25193_ = (_e8649 % 1f);
                    } else {
                        phi_25193_ = (1f - (-(_e8649) % 1f));
                    }
                    let _e8663 = phi_25193_;
                    let _e8665 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8656, _e8663), 0f);
                    let _e8667 = (_e8648 + 0.265625f);
                    let _e8668 = (_e8649 + 0.265625f);
                    if (_e8667 > 0f) {
                        phi_25223_ = (_e8667 % 1f);
                    } else {
                        phi_25223_ = (1f - ((-0.265625f - _e8648) % 1f));
                    }
                    let _e8675 = phi_25223_;
                    if (_e8668 > 0f) {
                        phi_25236_ = (_e8668 % 1f);
                    } else {
                        phi_25236_ = (1f - ((-0.265625f - _e8649) % 1f));
                    }
                    let _e8682 = phi_25236_;
                    let _e8684 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8675, _e8682), 0f);
                    let _e8692 = fma(-(_e8593), 0.02f, 7f);
                    let _e8695 = floor((_e8596 * _e8692));
                    let _e8697 = fma(_e8596, _e8692, -(_e8695));
                    let _e8698 = (_e8695 * 0.265625f);
                    let _e8699 = fma((_e8595 * _e8692), 0.015625f, _e8698);
                    let _e8700 = fma(_e8587, 0.000109375f, _e8698);
                    if (_e8699 > 0f) {
                        phi_25296_ = (_e8699 % 1f);
                    } else {
                        phi_25296_ = (1f - (-(_e8699) % 1f));
                    }
                    let _e8707 = phi_25296_;
                    if (_e8700 > 0f) {
                        phi_25309_ = (_e8700 % 1f);
                    } else {
                        phi_25309_ = (1f - (-(_e8700) % 1f));
                    }
                    let _e8714 = phi_25309_;
                    let _e8716 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8707, _e8714), 0f);
                    let _e8718 = (_e8699 + 0.265625f);
                    let _e8719 = (_e8700 + 0.265625f);
                    if (_e8718 > 0f) {
                        phi_25339_ = (_e8718 % 1f);
                    } else {
                        phi_25339_ = (1f - ((-0.265625f - _e8699) % 1f));
                    }
                    let _e8726 = phi_25339_;
                    if (_e8719 > 0f) {
                        phi_25352_ = (_e8719 % 1f);
                    } else {
                        phi_25352_ = (1f - ((-0.265625f - _e8700) % 1f));
                    }
                    let _e8733 = phi_25352_;
                    let _e8735 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8726, _e8733), 0f);
                    let _e8742 = fma(_e8593, 0.02f, _e8596);
                    let _e8744 = floor((_e8742 * 16f));
                    let _e8746 = fma(_e8742, 16f, -(_e8744));
                    let _e8747 = (_e8744 * 0.265625f);
                    let _e8748 = fma(fma(_e8593, 0.02f, _e8595), 0.25f, _e8747);
                    let _e8749 = fma(_e8587, 0.00025f, _e8747);
                    if (_e8748 > 0f) {
                        phi_25412_ = (_e8748 % 1f);
                    } else {
                        phi_25412_ = (1f - (-(_e8748) % 1f));
                    }
                    let _e8756 = phi_25412_;
                    if (_e8749 > 0f) {
                        phi_25425_ = (_e8749 % 1f);
                    } else {
                        phi_25425_ = (1f - (-(_e8749) % 1f));
                    }
                    let _e8763 = phi_25425_;
                    let _e8765 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8756, _e8763), 0f);
                    let _e8767 = (_e8748 + 0.265625f);
                    let _e8768 = (_e8749 + 0.265625f);
                    if (_e8767 > 0f) {
                        phi_25455_ = (_e8767 % 1f);
                    } else {
                        phi_25455_ = (1f - ((-0.265625f - _e8748) % 1f));
                    }
                    let _e8775 = phi_25455_;
                    if (_e8768 > 0f) {
                        phi_25468_ = (_e8768 % 1f);
                    } else {
                        phi_25468_ = (1f - ((-0.265625f - _e8749) % 1f));
                    }
                    let _e8782 = phi_25468_;
                    let _e8784 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8775, _e8782), 0f);
                    let _e8790 = (_e8586 - 6372600f);
                    let _e8798 = ((fma(fma(_e8765.x, (1f - _e8746), (_e8784.x * _e8746)), 0.0625f, fma(fma(_e8716.x, (1f - _e8697), (_e8735.x * _e8697)), 0.125f, fma(fma(_e8617.x, (1f - _e8598), (_e8636.x * _e8598)), 0.5f, (fma(_e8665.x, (1f - _e8646), (_e8684.x * _e8646)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e8800 = select(_e8798, 0f, (_e8798 < 0f));
                    let _e8802 = select(_e8800, 1f, (_e8800 > 1f));
                    phi_6447_ = ((((_e8802 * _e8802) * fma(-2f, _e8802, 3f)) * ((1f - exp2((-0.01f * _e8790))) * exp2((-0.004f * _e8790)))) * 0.03f);
                }
                let _e8809 = phi_6447_;
                phi_6448_ = _e8809;
                phi_6449_ = _e8589;
            }
            let _e8811 = phi_6448_;
            let _e8813 = phi_6449_;
            let _e8815 = (select(_e8811, 0f, _e8813) * sqrt(fma(_e8554, _e8554, fma(_e8552, _e8552, (_e8553 * _e8553)))));
            if (_e8815 <= 0f) {
                phi_6657_ = _e8563;
                phi_6658_ = _e8567;
                phi_6659_ = _e8569;
                phi_6660_ = _e8571;
                phi_6661_ = _e8573;
                phi_6662_ = _e8575;
                phi_6663_ = _e8577;
            } else {
                let _e8819 = fma(exp2((-1.6013916f * _e8815)), -0.9009009f, 0.9009009f);
                let _e8822 = (1f - exp2((_e8815 * -1.3862944f)));
                let _e8823 = (-9.537895f + _e8567);
                let _e8824 = (29.354609f + _e8571);
                phi_6480_ = 0f;
                phi_6483_ = 0u;
                loop {
                    let _e8826 = phi_6480_;
                    let _e8828 = phi_6483_;
                    local_91 = _e8826;
                    let _e8829 = (_e8828 < 8u);
                    if _e8829 {
                        phi_6484_ = (_e8828 + 1u);
                    } else {
                        phi_6484_ = _e8828;
                    }
                    let _e8832 = phi_6484_;
                    if _e8829 {
                        let _e8833 = (_e8569 + 6371005f);
                        let _e8837 = sqrt(fma(_e8824, _e8824, fma(_e8823, _e8823, (_e8833 * _e8833))));
                        let _e8838 = (_e8837 - 6371000f);
                        if (_e8838 < 1600f) {
                            phi_6599_ = f32();
                            phi_6600_ = true;
                        } else {
                            let _e8840 = (_e8838 > 2100f);
                            if _e8840 {
                                phi_6598_ = f32();
                            } else {
                                let _e8844 = global_2.member.member[0u];
                                let _e8845 = (_e8844 * 0.02f);
                                let _e8846 = fma(_e8823, 0.001f, _e8845);
                                let _e8847 = fma(_e8824, 0.001f, _e8845);
                                let _e8848 = floor(_e8847);
                                let _e8849 = (_e8847 - _e8848);
                                let _e8850 = (_e8848 * 0.265625f);
                                let _e8851 = fma(_e8846, 0.015625f, _e8850);
                                let _e8852 = fma(_e8838, 0.000015625f, _e8850);
                                if (_e8851 > 0f) {
                                    phi_25544_ = (_e8851 % 1f);
                                } else {
                                    phi_25544_ = (1f - (-(_e8851) % 1f));
                                }
                                let _e8859 = phi_25544_;
                                if (_e8852 > 0f) {
                                    phi_25557_ = (_e8852 % 1f);
                                } else {
                                    phi_25557_ = (1f - (-(_e8852) % 1f));
                                }
                                let _e8866 = phi_25557_;
                                let _e8868 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8859, _e8866), 0f);
                                let _e8870 = (_e8851 + 0.265625f);
                                let _e8871 = (_e8852 + 0.265625f);
                                if (_e8870 > 0f) {
                                    phi_25587_ = (_e8870 % 1f);
                                } else {
                                    phi_25587_ = (1f - ((-0.265625f - _e8851) % 1f));
                                }
                                let _e8878 = phi_25587_;
                                if (_e8871 > 0f) {
                                    phi_25600_ = (_e8871 % 1f);
                                } else {
                                    phi_25600_ = (1f - ((-0.265625f - _e8852) % 1f));
                                }
                                let _e8885 = phi_25600_;
                                let _e8887 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8878, _e8885), 0f);
                                let _e8892 = fma(_e8844, 0.02f, 2f);
                                let _e8895 = floor((_e8847 * _e8892));
                                let _e8897 = fma(_e8847, _e8892, -(_e8895));
                                let _e8898 = (_e8895 * 0.265625f);
                                let _e8899 = fma((_e8846 * _e8892), 0.015625f, _e8898);
                                let _e8900 = fma(_e8838, 0.00003125f, _e8898);
                                if (_e8899 > 0f) {
                                    phi_25660_ = (_e8899 % 1f);
                                } else {
                                    phi_25660_ = (1f - (-(_e8899) % 1f));
                                }
                                let _e8907 = phi_25660_;
                                if (_e8900 > 0f) {
                                    phi_25673_ = (_e8900 % 1f);
                                } else {
                                    phi_25673_ = (1f - (-(_e8900) % 1f));
                                }
                                let _e8914 = phi_25673_;
                                let _e8916 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8907, _e8914), 0f);
                                let _e8918 = (_e8899 + 0.265625f);
                                let _e8919 = (_e8900 + 0.265625f);
                                if (_e8918 > 0f) {
                                    phi_25703_ = (_e8918 % 1f);
                                } else {
                                    phi_25703_ = (1f - ((-0.265625f - _e8899) % 1f));
                                }
                                let _e8926 = phi_25703_;
                                if (_e8919 > 0f) {
                                    phi_25716_ = (_e8919 % 1f);
                                } else {
                                    phi_25716_ = (1f - ((-0.265625f - _e8900) % 1f));
                                }
                                let _e8933 = phi_25716_;
                                let _e8935 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8926, _e8933), 0f);
                                let _e8943 = fma(-(_e8844), 0.02f, 7f);
                                let _e8946 = floor((_e8847 * _e8943));
                                let _e8948 = fma(_e8847, _e8943, -(_e8946));
                                let _e8949 = (_e8946 * 0.265625f);
                                let _e8950 = fma((_e8846 * _e8943), 0.015625f, _e8949);
                                let _e8951 = fma(_e8838, 0.000109375f, _e8949);
                                if (_e8950 > 0f) {
                                    phi_25776_ = (_e8950 % 1f);
                                } else {
                                    phi_25776_ = (1f - (-(_e8950) % 1f));
                                }
                                let _e8958 = phi_25776_;
                                if (_e8951 > 0f) {
                                    phi_25789_ = (_e8951 % 1f);
                                } else {
                                    phi_25789_ = (1f - (-(_e8951) % 1f));
                                }
                                let _e8965 = phi_25789_;
                                let _e8967 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8958, _e8965), 0f);
                                let _e8969 = (_e8950 + 0.265625f);
                                let _e8970 = (_e8951 + 0.265625f);
                                if (_e8969 > 0f) {
                                    phi_25819_ = (_e8969 % 1f);
                                } else {
                                    phi_25819_ = (1f - ((-0.265625f - _e8950) % 1f));
                                }
                                let _e8977 = phi_25819_;
                                if (_e8970 > 0f) {
                                    phi_25832_ = (_e8970 % 1f);
                                } else {
                                    phi_25832_ = (1f - ((-0.265625f - _e8951) % 1f));
                                }
                                let _e8984 = phi_25832_;
                                let _e8986 = textureSampleLevel(global_3, global_4, vec2<f32>(_e8977, _e8984), 0f);
                                let _e8993 = fma(_e8844, 0.02f, _e8847);
                                let _e8995 = floor((_e8993 * 16f));
                                let _e8997 = fma(_e8993, 16f, -(_e8995));
                                let _e8998 = (_e8995 * 0.265625f);
                                let _e8999 = fma(fma(_e8844, 0.02f, _e8846), 0.25f, _e8998);
                                let _e9000 = fma(_e8838, 0.00025f, _e8998);
                                if (_e8999 > 0f) {
                                    phi_25892_ = (_e8999 % 1f);
                                } else {
                                    phi_25892_ = (1f - (-(_e8999) % 1f));
                                }
                                let _e9007 = phi_25892_;
                                if (_e9000 > 0f) {
                                    phi_25905_ = (_e9000 % 1f);
                                } else {
                                    phi_25905_ = (1f - (-(_e9000) % 1f));
                                }
                                let _e9014 = phi_25905_;
                                let _e9016 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9007, _e9014), 0f);
                                let _e9018 = (_e8999 + 0.265625f);
                                let _e9019 = (_e9000 + 0.265625f);
                                if (_e9018 > 0f) {
                                    phi_25935_ = (_e9018 % 1f);
                                } else {
                                    phi_25935_ = (1f - ((-0.265625f - _e8999) % 1f));
                                }
                                let _e9026 = phi_25935_;
                                if (_e9019 > 0f) {
                                    phi_25948_ = (_e9019 % 1f);
                                } else {
                                    phi_25948_ = (1f - ((-0.265625f - _e9000) % 1f));
                                }
                                let _e9033 = phi_25948_;
                                let _e9035 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9026, _e9033), 0f);
                                let _e9041 = (_e8837 - 6372600f);
                                let _e9049 = ((fma(fma(_e9016.x, (1f - _e8997), (_e9035.x * _e8997)), 0.0625f, fma(fma(_e8967.x, (1f - _e8948), (_e8986.x * _e8948)), 0.125f, fma(fma(_e8868.x, (1f - _e8849), (_e8887.x * _e8849)), 0.5f, (fma(_e8916.x, (1f - _e8897), (_e8935.x * _e8897)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e9051 = select(_e9049, 0f, (_e9049 < 0f));
                                let _e9053 = select(_e9051, 1f, (_e9051 > 1f));
                                phi_6598_ = ((((_e9053 * _e9053) * fma(-2f, _e9053, 3f)) * ((1f - exp2((-0.01f * _e9041))) * exp2((-0.004f * _e9041)))) * 0.03f);
                            }
                            let _e9060 = phi_6598_;
                            phi_6599_ = _e9060;
                            phi_6600_ = _e8840;
                        }
                        let _e9062 = phi_6599_;
                        let _e9064 = phi_6600_;
                        phi_6481_ = (_e8826 + select(_e9062, 0f, _e9064));
                    } else {
                        phi_6481_ = f32();
                    }
                    let _e9068 = phi_6481_;
                    continue;
                    continuing {
                        phi_6480_ = _e9068;
                        phi_6483_ = _e8832;
                        break if !(_e8829);
                    }
                }
                let _e9071 = local_91;
                let _e9073 = exp2((_e9071 * -62.5f));
                phi_6657_ = (_e8563 * exp2(-(_e8815)));
                phi_6658_ = fma(_e8549, 0.0625f, _e8567);
                phi_6659_ = fma(_e8550, 0.0625f, _e8569);
                phi_6660_ = fma(_e8551, 0.0625f, _e8571);
                phi_6661_ = fma(((fma((((0.4807763f * _e9073) * _e8822) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e8819) * 3.1415927f), _e8563, _e8573);
                phi_6662_ = fma(((fma((((0.28401393f * _e9073) * _e8822) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e8819) * 3.1415927f), _e8563, _e8575);
                phi_6663_ = fma(((fma((((0.09044314f * _e9073) * _e8822) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e8819) * 3.1415927f), _e8563, _e8577);
            }
            let _e9105 = phi_6657_;
            let _e9107 = phi_6658_;
            let _e9109 = phi_6659_;
            let _e9111 = phi_6660_;
            let _e9113 = phi_6661_;
            let _e9115 = phi_6662_;
            let _e9117 = phi_6663_;
            phi_6318_ = _e9105;
            phi_6323_ = _e9107;
            phi_6325_ = _e9109;
            phi_6327_ = _e9111;
            phi_6329_ = _e9113;
            phi_6331_ = _e9115;
            phi_6333_ = _e9117;
        } else {
            phi_6318_ = f32();
            phi_6323_ = f32();
            phi_6325_ = f32();
            phi_6327_ = f32();
            phi_6329_ = f32();
            phi_6331_ = f32();
            phi_6333_ = f32();
        }
        let _e9119 = phi_6318_;
        let _e9121 = phi_6323_;
        let _e9123 = phi_6325_;
        let _e9125 = phi_6327_;
        let _e9127 = phi_6329_;
        let _e9129 = phi_6331_;
        let _e9131 = phi_6333_;
        continue;
        continuing {
            phi_6317_ = _e9119;
            phi_6320_ = _e8581;
            phi_6322_ = _e9121;
            phi_6324_ = _e9123;
            phi_6326_ = _e9125;
            phi_6328_ = _e9127;
            phi_6330_ = _e9129;
            phi_6332_ = _e9131;
            break if !(_e8578);
        }
    }
    let _e9134 = local_92;
    let _e9136 = local_93;
    let _e9139 = local_94;
    let _e9141 = local_95;
    let _e9144 = local_96;
    let _e9146 = local_97;
    let _e9152 = (sqrt(fma(_e8545, _e8545, fma(_e8543, _e8543, (_e8544 * _e8544)))) * 0.00001f);
    let _e9154 = select(_e9152, 0f, (_e9152 < 0f));
    let _e9156 = select(_e9154, 1f, (_e9154 > 1f));
    let _e9157 = (1f - _e9156);
    let _e9161 = fma(fma(_e8528, _e9134, _e9136), _e9157, (_e8528 * _e9156));
    let _e9162 = fma(fma(_e8529, _e9139, _e9141), _e9157, (_e8529 * _e9156));
    let _e9163 = fma(fma(_e8530, _e9144, _e9146), _e9157, (_e8530 * _e9156));
    if _e274 {
        phi_26022_ = vec2<f32>(-1f, -1f);
    } else {
        phi_26022_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e9168 = phi_26022_;
    if _e283 {
        phi_26062_ = vec2<f32>(-1f, -1f);
    } else {
        phi_26062_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e9174 = phi_26062_;
    let _e9176 = (_e144.x * _e9168.y);
    let _e9177 = (_e144.y * _e9168.y);
    let _e9178 = (_e144.z * _e9168.y);
    let _e9182 = fma(_e296, _e9168.y, (_e144.x + _e9174.y));
    let _e9183 = fma(_e298, _e9168.y, (_e144.y + _e9174.y));
    let _e9184 = fma(_e300, _e9168.y, (_e144.z + _e9174.y));
    let _e9185 = (_e9182 * 0.0625f);
    let _e9186 = (_e9183 * 0.0625f);
    let _e9187 = (_e9184 * 0.0625f);
    phi_6771_ = 1f;
    phi_6774_ = 0u;
    phi_6776_ = fma(_e9185, _e181, _e9176);
    phi_6778_ = fma(_e9186, _e181, _e9177);
    phi_6780_ = fma(_e9187, _e181, _e9178);
    phi_6782_ = 0f;
    phi_6784_ = 0f;
    phi_6786_ = 0f;
    loop {
        let _e9196 = phi_6771_;
        let _e9198 = phi_6774_;
        let _e9200 = phi_6776_;
        let _e9202 = phi_6778_;
        let _e9204 = phi_6780_;
        let _e9206 = phi_6782_;
        let _e9208 = phi_6784_;
        let _e9210 = phi_6786_;
        local_99 = _e9196;
        local_100 = _e9206;
        local_101 = _e9196;
        local_102 = _e9208;
        local_103 = _e9196;
        local_104 = _e9210;
        let _e9211 = (_e9198 < 16u);
        if _e9211 {
            phi_6775_ = (_e9198 + 1u);
        } else {
            phi_6775_ = _e9198;
        }
        let _e9214 = phi_6775_;
        if _e9211 {
            let _e9215 = (_e9202 + 6371000f);
            let _e9219 = sqrt(fma(_e9204, _e9204, fma(_e9200, _e9200, (_e9215 * _e9215))));
            let _e9220 = (_e9219 - 6371000f);
            if (_e9220 < 1600f) {
                phi_6902_ = f32();
                phi_6903_ = true;
            } else {
                let _e9222 = (_e9220 > 2100f);
                if _e9222 {
                    phi_6901_ = f32();
                } else {
                    let _e9226 = global_2.member.member[0u];
                    let _e9227 = (_e9226 * 0.02f);
                    let _e9228 = fma(_e9200, 0.001f, _e9227);
                    let _e9229 = fma(_e9204, 0.001f, _e9227);
                    let _e9230 = floor(_e9229);
                    let _e9231 = (_e9229 - _e9230);
                    let _e9232 = (_e9230 * 0.265625f);
                    let _e9233 = fma(_e9228, 0.015625f, _e9232);
                    let _e9234 = fma(_e9220, 0.000015625f, _e9232);
                    if (_e9233 > 0f) {
                        phi_26287_ = (_e9233 % 1f);
                    } else {
                        phi_26287_ = (1f - (-(_e9233) % 1f));
                    }
                    let _e9241 = phi_26287_;
                    if (_e9234 > 0f) {
                        phi_26300_ = (_e9234 % 1f);
                    } else {
                        phi_26300_ = (1f - (-(_e9234) % 1f));
                    }
                    let _e9248 = phi_26300_;
                    let _e9250 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9241, _e9248), 0f);
                    let _e9252 = (_e9233 + 0.265625f);
                    let _e9253 = (_e9234 + 0.265625f);
                    if (_e9252 > 0f) {
                        phi_26330_ = (_e9252 % 1f);
                    } else {
                        phi_26330_ = (1f - ((-0.265625f - _e9233) % 1f));
                    }
                    let _e9260 = phi_26330_;
                    if (_e9253 > 0f) {
                        phi_26343_ = (_e9253 % 1f);
                    } else {
                        phi_26343_ = (1f - ((-0.265625f - _e9234) % 1f));
                    }
                    let _e9267 = phi_26343_;
                    let _e9269 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9260, _e9267), 0f);
                    let _e9274 = fma(_e9226, 0.02f, 2f);
                    let _e9277 = floor((_e9229 * _e9274));
                    let _e9279 = fma(_e9229, _e9274, -(_e9277));
                    let _e9280 = (_e9277 * 0.265625f);
                    let _e9281 = fma((_e9228 * _e9274), 0.015625f, _e9280);
                    let _e9282 = fma(_e9220, 0.00003125f, _e9280);
                    if (_e9281 > 0f) {
                        phi_26403_ = (_e9281 % 1f);
                    } else {
                        phi_26403_ = (1f - (-(_e9281) % 1f));
                    }
                    let _e9289 = phi_26403_;
                    if (_e9282 > 0f) {
                        phi_26416_ = (_e9282 % 1f);
                    } else {
                        phi_26416_ = (1f - (-(_e9282) % 1f));
                    }
                    let _e9296 = phi_26416_;
                    let _e9298 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9289, _e9296), 0f);
                    let _e9300 = (_e9281 + 0.265625f);
                    let _e9301 = (_e9282 + 0.265625f);
                    if (_e9300 > 0f) {
                        phi_26446_ = (_e9300 % 1f);
                    } else {
                        phi_26446_ = (1f - ((-0.265625f - _e9281) % 1f));
                    }
                    let _e9308 = phi_26446_;
                    if (_e9301 > 0f) {
                        phi_26459_ = (_e9301 % 1f);
                    } else {
                        phi_26459_ = (1f - ((-0.265625f - _e9282) % 1f));
                    }
                    let _e9315 = phi_26459_;
                    let _e9317 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9308, _e9315), 0f);
                    let _e9325 = fma(-(_e9226), 0.02f, 7f);
                    let _e9328 = floor((_e9229 * _e9325));
                    let _e9330 = fma(_e9229, _e9325, -(_e9328));
                    let _e9331 = (_e9328 * 0.265625f);
                    let _e9332 = fma((_e9228 * _e9325), 0.015625f, _e9331);
                    let _e9333 = fma(_e9220, 0.000109375f, _e9331);
                    if (_e9332 > 0f) {
                        phi_26519_ = (_e9332 % 1f);
                    } else {
                        phi_26519_ = (1f - (-(_e9332) % 1f));
                    }
                    let _e9340 = phi_26519_;
                    if (_e9333 > 0f) {
                        phi_26532_ = (_e9333 % 1f);
                    } else {
                        phi_26532_ = (1f - (-(_e9333) % 1f));
                    }
                    let _e9347 = phi_26532_;
                    let _e9349 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9340, _e9347), 0f);
                    let _e9351 = (_e9332 + 0.265625f);
                    let _e9352 = (_e9333 + 0.265625f);
                    if (_e9351 > 0f) {
                        phi_26562_ = (_e9351 % 1f);
                    } else {
                        phi_26562_ = (1f - ((-0.265625f - _e9332) % 1f));
                    }
                    let _e9359 = phi_26562_;
                    if (_e9352 > 0f) {
                        phi_26575_ = (_e9352 % 1f);
                    } else {
                        phi_26575_ = (1f - ((-0.265625f - _e9333) % 1f));
                    }
                    let _e9366 = phi_26575_;
                    let _e9368 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9359, _e9366), 0f);
                    let _e9375 = fma(_e9226, 0.02f, _e9229);
                    let _e9377 = floor((_e9375 * 16f));
                    let _e9379 = fma(_e9375, 16f, -(_e9377));
                    let _e9380 = (_e9377 * 0.265625f);
                    let _e9381 = fma(fma(_e9226, 0.02f, _e9228), 0.25f, _e9380);
                    let _e9382 = fma(_e9220, 0.00025f, _e9380);
                    if (_e9381 > 0f) {
                        phi_26635_ = (_e9381 % 1f);
                    } else {
                        phi_26635_ = (1f - (-(_e9381) % 1f));
                    }
                    let _e9389 = phi_26635_;
                    if (_e9382 > 0f) {
                        phi_26648_ = (_e9382 % 1f);
                    } else {
                        phi_26648_ = (1f - (-(_e9382) % 1f));
                    }
                    let _e9396 = phi_26648_;
                    let _e9398 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9389, _e9396), 0f);
                    let _e9400 = (_e9381 + 0.265625f);
                    let _e9401 = (_e9382 + 0.265625f);
                    if (_e9400 > 0f) {
                        phi_26678_ = (_e9400 % 1f);
                    } else {
                        phi_26678_ = (1f - ((-0.265625f - _e9381) % 1f));
                    }
                    let _e9408 = phi_26678_;
                    if (_e9401 > 0f) {
                        phi_26691_ = (_e9401 % 1f);
                    } else {
                        phi_26691_ = (1f - ((-0.265625f - _e9382) % 1f));
                    }
                    let _e9415 = phi_26691_;
                    let _e9417 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9408, _e9415), 0f);
                    let _e9423 = (_e9219 - 6372600f);
                    let _e9431 = ((fma(fma(_e9398.x, (1f - _e9379), (_e9417.x * _e9379)), 0.0625f, fma(fma(_e9349.x, (1f - _e9330), (_e9368.x * _e9330)), 0.125f, fma(fma(_e9250.x, (1f - _e9231), (_e9269.x * _e9231)), 0.5f, (fma(_e9298.x, (1f - _e9279), (_e9317.x * _e9279)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e9433 = select(_e9431, 0f, (_e9431 < 0f));
                    let _e9435 = select(_e9433, 1f, (_e9433 > 1f));
                    phi_6901_ = ((((_e9435 * _e9435) * fma(-2f, _e9435, 3f)) * ((1f - exp2((-0.01f * _e9423))) * exp2((-0.004f * _e9423)))) * 0.03f);
                }
                let _e9442 = phi_6901_;
                phi_6902_ = _e9442;
                phi_6903_ = _e9222;
            }
            let _e9444 = phi_6902_;
            let _e9446 = phi_6903_;
            let _e9448 = (select(_e9444, 0f, _e9446) * sqrt(fma(_e9187, _e9187, fma(_e9185, _e9185, (_e9186 * _e9186)))));
            if (_e9448 <= 0f) {
                phi_7111_ = _e9196;
                phi_7112_ = _e9200;
                phi_7113_ = _e9202;
                phi_7114_ = _e9204;
                phi_7115_ = _e9206;
                phi_7116_ = _e9208;
                phi_7117_ = _e9210;
            } else {
                let _e9452 = fma(exp2((-1.6013916f * _e9448)), -0.9009009f, 0.9009009f);
                let _e9455 = (1f - exp2((_e9448 * -1.3862944f)));
                let _e9456 = (-9.537895f + _e9200);
                let _e9457 = (29.354609f + _e9204);
                phi_6934_ = 0f;
                phi_6937_ = 0u;
                loop {
                    let _e9459 = phi_6934_;
                    let _e9461 = phi_6937_;
                    local_98 = _e9459;
                    let _e9462 = (_e9461 < 8u);
                    if _e9462 {
                        phi_6938_ = (_e9461 + 1u);
                    } else {
                        phi_6938_ = _e9461;
                    }
                    let _e9465 = phi_6938_;
                    if _e9462 {
                        let _e9466 = (_e9202 + 6371005f);
                        let _e9470 = sqrt(fma(_e9457, _e9457, fma(_e9456, _e9456, (_e9466 * _e9466))));
                        let _e9471 = (_e9470 - 6371000f);
                        if (_e9471 < 1600f) {
                            phi_7053_ = f32();
                            phi_7054_ = true;
                        } else {
                            let _e9473 = (_e9471 > 2100f);
                            if _e9473 {
                                phi_7052_ = f32();
                            } else {
                                let _e9477 = global_2.member.member[0u];
                                let _e9478 = (_e9477 * 0.02f);
                                let _e9479 = fma(_e9456, 0.001f, _e9478);
                                let _e9480 = fma(_e9457, 0.001f, _e9478);
                                let _e9481 = floor(_e9480);
                                let _e9482 = (_e9480 - _e9481);
                                let _e9483 = (_e9481 * 0.265625f);
                                let _e9484 = fma(_e9479, 0.015625f, _e9483);
                                let _e9485 = fma(_e9471, 0.000015625f, _e9483);
                                if (_e9484 > 0f) {
                                    phi_26767_ = (_e9484 % 1f);
                                } else {
                                    phi_26767_ = (1f - (-(_e9484) % 1f));
                                }
                                let _e9492 = phi_26767_;
                                if (_e9485 > 0f) {
                                    phi_26780_ = (_e9485 % 1f);
                                } else {
                                    phi_26780_ = (1f - (-(_e9485) % 1f));
                                }
                                let _e9499 = phi_26780_;
                                let _e9501 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9492, _e9499), 0f);
                                let _e9503 = (_e9484 + 0.265625f);
                                let _e9504 = (_e9485 + 0.265625f);
                                if (_e9503 > 0f) {
                                    phi_26810_ = (_e9503 % 1f);
                                } else {
                                    phi_26810_ = (1f - ((-0.265625f - _e9484) % 1f));
                                }
                                let _e9511 = phi_26810_;
                                if (_e9504 > 0f) {
                                    phi_26823_ = (_e9504 % 1f);
                                } else {
                                    phi_26823_ = (1f - ((-0.265625f - _e9485) % 1f));
                                }
                                let _e9518 = phi_26823_;
                                let _e9520 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9511, _e9518), 0f);
                                let _e9525 = fma(_e9477, 0.02f, 2f);
                                let _e9528 = floor((_e9480 * _e9525));
                                let _e9530 = fma(_e9480, _e9525, -(_e9528));
                                let _e9531 = (_e9528 * 0.265625f);
                                let _e9532 = fma((_e9479 * _e9525), 0.015625f, _e9531);
                                let _e9533 = fma(_e9471, 0.00003125f, _e9531);
                                if (_e9532 > 0f) {
                                    phi_26883_ = (_e9532 % 1f);
                                } else {
                                    phi_26883_ = (1f - (-(_e9532) % 1f));
                                }
                                let _e9540 = phi_26883_;
                                if (_e9533 > 0f) {
                                    phi_26896_ = (_e9533 % 1f);
                                } else {
                                    phi_26896_ = (1f - (-(_e9533) % 1f));
                                }
                                let _e9547 = phi_26896_;
                                let _e9549 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9540, _e9547), 0f);
                                let _e9551 = (_e9532 + 0.265625f);
                                let _e9552 = (_e9533 + 0.265625f);
                                if (_e9551 > 0f) {
                                    phi_26926_ = (_e9551 % 1f);
                                } else {
                                    phi_26926_ = (1f - ((-0.265625f - _e9532) % 1f));
                                }
                                let _e9559 = phi_26926_;
                                if (_e9552 > 0f) {
                                    phi_26939_ = (_e9552 % 1f);
                                } else {
                                    phi_26939_ = (1f - ((-0.265625f - _e9533) % 1f));
                                }
                                let _e9566 = phi_26939_;
                                let _e9568 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9559, _e9566), 0f);
                                let _e9576 = fma(-(_e9477), 0.02f, 7f);
                                let _e9579 = floor((_e9480 * _e9576));
                                let _e9581 = fma(_e9480, _e9576, -(_e9579));
                                let _e9582 = (_e9579 * 0.265625f);
                                let _e9583 = fma((_e9479 * _e9576), 0.015625f, _e9582);
                                let _e9584 = fma(_e9471, 0.000109375f, _e9582);
                                if (_e9583 > 0f) {
                                    phi_26999_ = (_e9583 % 1f);
                                } else {
                                    phi_26999_ = (1f - (-(_e9583) % 1f));
                                }
                                let _e9591 = phi_26999_;
                                if (_e9584 > 0f) {
                                    phi_27012_ = (_e9584 % 1f);
                                } else {
                                    phi_27012_ = (1f - (-(_e9584) % 1f));
                                }
                                let _e9598 = phi_27012_;
                                let _e9600 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9591, _e9598), 0f);
                                let _e9602 = (_e9583 + 0.265625f);
                                let _e9603 = (_e9584 + 0.265625f);
                                if (_e9602 > 0f) {
                                    phi_27042_ = (_e9602 % 1f);
                                } else {
                                    phi_27042_ = (1f - ((-0.265625f - _e9583) % 1f));
                                }
                                let _e9610 = phi_27042_;
                                if (_e9603 > 0f) {
                                    phi_27055_ = (_e9603 % 1f);
                                } else {
                                    phi_27055_ = (1f - ((-0.265625f - _e9584) % 1f));
                                }
                                let _e9617 = phi_27055_;
                                let _e9619 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9610, _e9617), 0f);
                                let _e9626 = fma(_e9477, 0.02f, _e9480);
                                let _e9628 = floor((_e9626 * 16f));
                                let _e9630 = fma(_e9626, 16f, -(_e9628));
                                let _e9631 = (_e9628 * 0.265625f);
                                let _e9632 = fma(fma(_e9477, 0.02f, _e9479), 0.25f, _e9631);
                                let _e9633 = fma(_e9471, 0.00025f, _e9631);
                                if (_e9632 > 0f) {
                                    phi_27115_ = (_e9632 % 1f);
                                } else {
                                    phi_27115_ = (1f - (-(_e9632) % 1f));
                                }
                                let _e9640 = phi_27115_;
                                if (_e9633 > 0f) {
                                    phi_27128_ = (_e9633 % 1f);
                                } else {
                                    phi_27128_ = (1f - (-(_e9633) % 1f));
                                }
                                let _e9647 = phi_27128_;
                                let _e9649 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9640, _e9647), 0f);
                                let _e9651 = (_e9632 + 0.265625f);
                                let _e9652 = (_e9633 + 0.265625f);
                                if (_e9651 > 0f) {
                                    phi_27158_ = (_e9651 % 1f);
                                } else {
                                    phi_27158_ = (1f - ((-0.265625f - _e9632) % 1f));
                                }
                                let _e9659 = phi_27158_;
                                if (_e9652 > 0f) {
                                    phi_27171_ = (_e9652 % 1f);
                                } else {
                                    phi_27171_ = (1f - ((-0.265625f - _e9633) % 1f));
                                }
                                let _e9666 = phi_27171_;
                                let _e9668 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9659, _e9666), 0f);
                                let _e9674 = (_e9470 - 6372600f);
                                let _e9682 = ((fma(fma(_e9649.x, (1f - _e9630), (_e9668.x * _e9630)), 0.0625f, fma(fma(_e9600.x, (1f - _e9581), (_e9619.x * _e9581)), 0.125f, fma(fma(_e9501.x, (1f - _e9482), (_e9520.x * _e9482)), 0.5f, (fma(_e9549.x, (1f - _e9530), (_e9568.x * _e9530)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e9684 = select(_e9682, 0f, (_e9682 < 0f));
                                let _e9686 = select(_e9684, 1f, (_e9684 > 1f));
                                phi_7052_ = ((((_e9686 * _e9686) * fma(-2f, _e9686, 3f)) * ((1f - exp2((-0.01f * _e9674))) * exp2((-0.004f * _e9674)))) * 0.03f);
                            }
                            let _e9693 = phi_7052_;
                            phi_7053_ = _e9693;
                            phi_7054_ = _e9473;
                        }
                        let _e9695 = phi_7053_;
                        let _e9697 = phi_7054_;
                        phi_6935_ = (_e9459 + select(_e9695, 0f, _e9697));
                    } else {
                        phi_6935_ = f32();
                    }
                    let _e9701 = phi_6935_;
                    continue;
                    continuing {
                        phi_6934_ = _e9701;
                        phi_6937_ = _e9465;
                        break if !(_e9462);
                    }
                }
                let _e9704 = local_98;
                let _e9706 = exp2((_e9704 * -62.5f));
                phi_7111_ = (_e9196 * exp2(-(_e9448)));
                phi_7112_ = fma(_e9182, 0.0625f, _e9200);
                phi_7113_ = fma(_e9183, 0.0625f, _e9202);
                phi_7114_ = fma(_e9184, 0.0625f, _e9204);
                phi_7115_ = fma(((fma((((0.4807763f * _e9706) * _e9455) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e9452) * 3.1415927f), _e9196, _e9206);
                phi_7116_ = fma(((fma((((0.28401393f * _e9706) * _e9455) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e9452) * 3.1415927f), _e9196, _e9208);
                phi_7117_ = fma(((fma((((0.09044314f * _e9706) * _e9455) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e9452) * 3.1415927f), _e9196, _e9210);
            }
            let _e9738 = phi_7111_;
            let _e9740 = phi_7112_;
            let _e9742 = phi_7113_;
            let _e9744 = phi_7114_;
            let _e9746 = phi_7115_;
            let _e9748 = phi_7116_;
            let _e9750 = phi_7117_;
            phi_6772_ = _e9738;
            phi_6777_ = _e9740;
            phi_6779_ = _e9742;
            phi_6781_ = _e9744;
            phi_6783_ = _e9746;
            phi_6785_ = _e9748;
            phi_6787_ = _e9750;
        } else {
            phi_6772_ = f32();
            phi_6777_ = f32();
            phi_6779_ = f32();
            phi_6781_ = f32();
            phi_6783_ = f32();
            phi_6785_ = f32();
            phi_6787_ = f32();
        }
        let _e9752 = phi_6772_;
        let _e9754 = phi_6777_;
        let _e9756 = phi_6779_;
        let _e9758 = phi_6781_;
        let _e9760 = phi_6783_;
        let _e9762 = phi_6785_;
        let _e9764 = phi_6787_;
        continue;
        continuing {
            phi_6771_ = _e9752;
            phi_6774_ = _e9214;
            phi_6776_ = _e9754;
            phi_6778_ = _e9756;
            phi_6780_ = _e9758;
            phi_6782_ = _e9760;
            phi_6784_ = _e9762;
            phi_6786_ = _e9764;
            break if !(_e9211);
        }
    }
    let _e9767 = local_99;
    let _e9769 = local_100;
    let _e9772 = local_101;
    let _e9774 = local_102;
    let _e9777 = local_103;
    let _e9779 = local_104;
    let _e9785 = (sqrt(fma(_e9178, _e9178, fma(_e9176, _e9176, (_e9177 * _e9177)))) * 0.00001f);
    let _e9787 = select(_e9785, 0f, (_e9785 < 0f));
    let _e9789 = select(_e9787, 1f, (_e9787 > 1f));
    let _e9790 = (1f - _e9789);
    let _e9794 = fma(fma(_e9161, _e9767, _e9769), _e9790, (_e9161 * _e9789));
    let _e9795 = fma(fma(_e9162, _e9772, _e9774), _e9790, (_e9162 * _e9789));
    let _e9796 = fma(fma(_e9163, _e9777, _e9779), _e9790, (_e9163 * _e9789));
    if _e274 {
        phi_27245_ = vec2<f32>(-1f, -1f);
    } else {
        phi_27245_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e9801 = phi_27245_;
    if _e283 {
        phi_27285_ = vec2<f32>(-1f, -1f);
    } else {
        phi_27285_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e9807 = phi_27285_;
    let _e9809 = (_e144.x * _e9801.y);
    let _e9810 = (_e144.y * _e9801.y);
    let _e9811 = (_e144.z * _e9801.y);
    let _e9815 = fma(_e296, _e9801.y, (_e144.x + _e9807.y));
    let _e9816 = fma(_e298, _e9801.y, (_e144.y + _e9807.y));
    let _e9817 = fma(_e300, _e9801.y, (_e144.z + _e9807.y));
    let _e9818 = (_e9815 * 0.0625f);
    let _e9819 = (_e9816 * 0.0625f);
    let _e9820 = (_e9817 * 0.0625f);
    phi_7225_ = 1f;
    phi_7228_ = 0u;
    phi_7230_ = fma(_e9818, _e181, _e9809);
    phi_7232_ = fma(_e9819, _e181, _e9810);
    phi_7234_ = fma(_e9820, _e181, _e9811);
    phi_7236_ = 0f;
    phi_7238_ = 0f;
    phi_7240_ = 0f;
    loop {
        let _e9829 = phi_7225_;
        let _e9831 = phi_7228_;
        let _e9833 = phi_7230_;
        let _e9835 = phi_7232_;
        let _e9837 = phi_7234_;
        let _e9839 = phi_7236_;
        let _e9841 = phi_7238_;
        let _e9843 = phi_7240_;
        local_106 = _e9829;
        local_107 = _e9839;
        local_108 = _e9829;
        local_109 = _e9841;
        local_110 = _e9829;
        local_111 = _e9843;
        let _e9844 = (_e9831 < 16u);
        if _e9844 {
            phi_7229_ = (_e9831 + 1u);
        } else {
            phi_7229_ = _e9831;
        }
        let _e9847 = phi_7229_;
        if _e9844 {
            let _e9848 = (_e9835 + 6371000f);
            let _e9852 = sqrt(fma(_e9837, _e9837, fma(_e9833, _e9833, (_e9848 * _e9848))));
            let _e9853 = (_e9852 - 6371000f);
            if (_e9853 < 1600f) {
                phi_7356_ = f32();
                phi_7357_ = true;
            } else {
                let _e9855 = (_e9853 > 2100f);
                if _e9855 {
                    phi_7355_ = f32();
                } else {
                    let _e9859 = global_2.member.member[0u];
                    let _e9860 = (_e9859 * 0.02f);
                    let _e9861 = fma(_e9833, 0.001f, _e9860);
                    let _e9862 = fma(_e9837, 0.001f, _e9860);
                    let _e9863 = floor(_e9862);
                    let _e9864 = (_e9862 - _e9863);
                    let _e9865 = (_e9863 * 0.265625f);
                    let _e9866 = fma(_e9861, 0.015625f, _e9865);
                    let _e9867 = fma(_e9853, 0.000015625f, _e9865);
                    if (_e9866 > 0f) {
                        phi_27510_ = (_e9866 % 1f);
                    } else {
                        phi_27510_ = (1f - (-(_e9866) % 1f));
                    }
                    let _e9874 = phi_27510_;
                    if (_e9867 > 0f) {
                        phi_27523_ = (_e9867 % 1f);
                    } else {
                        phi_27523_ = (1f - (-(_e9867) % 1f));
                    }
                    let _e9881 = phi_27523_;
                    let _e9883 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9874, _e9881), 0f);
                    let _e9885 = (_e9866 + 0.265625f);
                    let _e9886 = (_e9867 + 0.265625f);
                    if (_e9885 > 0f) {
                        phi_27553_ = (_e9885 % 1f);
                    } else {
                        phi_27553_ = (1f - ((-0.265625f - _e9866) % 1f));
                    }
                    let _e9893 = phi_27553_;
                    if (_e9886 > 0f) {
                        phi_27566_ = (_e9886 % 1f);
                    } else {
                        phi_27566_ = (1f - ((-0.265625f - _e9867) % 1f));
                    }
                    let _e9900 = phi_27566_;
                    let _e9902 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9893, _e9900), 0f);
                    let _e9907 = fma(_e9859, 0.02f, 2f);
                    let _e9910 = floor((_e9862 * _e9907));
                    let _e9912 = fma(_e9862, _e9907, -(_e9910));
                    let _e9913 = (_e9910 * 0.265625f);
                    let _e9914 = fma((_e9861 * _e9907), 0.015625f, _e9913);
                    let _e9915 = fma(_e9853, 0.00003125f, _e9913);
                    if (_e9914 > 0f) {
                        phi_27626_ = (_e9914 % 1f);
                    } else {
                        phi_27626_ = (1f - (-(_e9914) % 1f));
                    }
                    let _e9922 = phi_27626_;
                    if (_e9915 > 0f) {
                        phi_27639_ = (_e9915 % 1f);
                    } else {
                        phi_27639_ = (1f - (-(_e9915) % 1f));
                    }
                    let _e9929 = phi_27639_;
                    let _e9931 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9922, _e9929), 0f);
                    let _e9933 = (_e9914 + 0.265625f);
                    let _e9934 = (_e9915 + 0.265625f);
                    if (_e9933 > 0f) {
                        phi_27669_ = (_e9933 % 1f);
                    } else {
                        phi_27669_ = (1f - ((-0.265625f - _e9914) % 1f));
                    }
                    let _e9941 = phi_27669_;
                    if (_e9934 > 0f) {
                        phi_27682_ = (_e9934 % 1f);
                    } else {
                        phi_27682_ = (1f - ((-0.265625f - _e9915) % 1f));
                    }
                    let _e9948 = phi_27682_;
                    let _e9950 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9941, _e9948), 0f);
                    let _e9958 = fma(-(_e9859), 0.02f, 7f);
                    let _e9961 = floor((_e9862 * _e9958));
                    let _e9963 = fma(_e9862, _e9958, -(_e9961));
                    let _e9964 = (_e9961 * 0.265625f);
                    let _e9965 = fma((_e9861 * _e9958), 0.015625f, _e9964);
                    let _e9966 = fma(_e9853, 0.000109375f, _e9964);
                    if (_e9965 > 0f) {
                        phi_27742_ = (_e9965 % 1f);
                    } else {
                        phi_27742_ = (1f - (-(_e9965) % 1f));
                    }
                    let _e9973 = phi_27742_;
                    if (_e9966 > 0f) {
                        phi_27755_ = (_e9966 % 1f);
                    } else {
                        phi_27755_ = (1f - (-(_e9966) % 1f));
                    }
                    let _e9980 = phi_27755_;
                    let _e9982 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9973, _e9980), 0f);
                    let _e9984 = (_e9965 + 0.265625f);
                    let _e9985 = (_e9966 + 0.265625f);
                    if (_e9984 > 0f) {
                        phi_27785_ = (_e9984 % 1f);
                    } else {
                        phi_27785_ = (1f - ((-0.265625f - _e9965) % 1f));
                    }
                    let _e9992 = phi_27785_;
                    if (_e9985 > 0f) {
                        phi_27798_ = (_e9985 % 1f);
                    } else {
                        phi_27798_ = (1f - ((-0.265625f - _e9966) % 1f));
                    }
                    let _e9999 = phi_27798_;
                    let _e10001 = textureSampleLevel(global_3, global_4, vec2<f32>(_e9992, _e9999), 0f);
                    let _e10008 = fma(_e9859, 0.02f, _e9862);
                    let _e10010 = floor((_e10008 * 16f));
                    let _e10012 = fma(_e10008, 16f, -(_e10010));
                    let _e10013 = (_e10010 * 0.265625f);
                    let _e10014 = fma(fma(_e9859, 0.02f, _e9861), 0.25f, _e10013);
                    let _e10015 = fma(_e9853, 0.00025f, _e10013);
                    if (_e10014 > 0f) {
                        phi_27858_ = (_e10014 % 1f);
                    } else {
                        phi_27858_ = (1f - (-(_e10014) % 1f));
                    }
                    let _e10022 = phi_27858_;
                    if (_e10015 > 0f) {
                        phi_27871_ = (_e10015 % 1f);
                    } else {
                        phi_27871_ = (1f - (-(_e10015) % 1f));
                    }
                    let _e10029 = phi_27871_;
                    let _e10031 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10022, _e10029), 0f);
                    let _e10033 = (_e10014 + 0.265625f);
                    let _e10034 = (_e10015 + 0.265625f);
                    if (_e10033 > 0f) {
                        phi_27901_ = (_e10033 % 1f);
                    } else {
                        phi_27901_ = (1f - ((-0.265625f - _e10014) % 1f));
                    }
                    let _e10041 = phi_27901_;
                    if (_e10034 > 0f) {
                        phi_27914_ = (_e10034 % 1f);
                    } else {
                        phi_27914_ = (1f - ((-0.265625f - _e10015) % 1f));
                    }
                    let _e10048 = phi_27914_;
                    let _e10050 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10041, _e10048), 0f);
                    let _e10056 = (_e9852 - 6372600f);
                    let _e10064 = ((fma(fma(_e10031.x, (1f - _e10012), (_e10050.x * _e10012)), 0.0625f, fma(fma(_e9982.x, (1f - _e9963), (_e10001.x * _e9963)), 0.125f, fma(fma(_e9883.x, (1f - _e9864), (_e9902.x * _e9864)), 0.5f, (fma(_e9931.x, (1f - _e9912), (_e9950.x * _e9912)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e10066 = select(_e10064, 0f, (_e10064 < 0f));
                    let _e10068 = select(_e10066, 1f, (_e10066 > 1f));
                    phi_7355_ = ((((_e10068 * _e10068) * fma(-2f, _e10068, 3f)) * ((1f - exp2((-0.01f * _e10056))) * exp2((-0.004f * _e10056)))) * 0.03f);
                }
                let _e10075 = phi_7355_;
                phi_7356_ = _e10075;
                phi_7357_ = _e9855;
            }
            let _e10077 = phi_7356_;
            let _e10079 = phi_7357_;
            let _e10081 = (select(_e10077, 0f, _e10079) * sqrt(fma(_e9820, _e9820, fma(_e9818, _e9818, (_e9819 * _e9819)))));
            if (_e10081 <= 0f) {
                phi_7565_ = _e9829;
                phi_7566_ = _e9833;
                phi_7567_ = _e9835;
                phi_7568_ = _e9837;
                phi_7569_ = _e9839;
                phi_7570_ = _e9841;
                phi_7571_ = _e9843;
            } else {
                let _e10085 = fma(exp2((-1.6013916f * _e10081)), -0.9009009f, 0.9009009f);
                let _e10088 = (1f - exp2((_e10081 * -1.3862944f)));
                let _e10089 = (-9.537895f + _e9833);
                let _e10090 = (29.354609f + _e9837);
                phi_7388_ = 0f;
                phi_7391_ = 0u;
                loop {
                    let _e10092 = phi_7388_;
                    let _e10094 = phi_7391_;
                    local_105 = _e10092;
                    let _e10095 = (_e10094 < 8u);
                    if _e10095 {
                        phi_7392_ = (_e10094 + 1u);
                    } else {
                        phi_7392_ = _e10094;
                    }
                    let _e10098 = phi_7392_;
                    if _e10095 {
                        let _e10099 = (_e9835 + 6371005f);
                        let _e10103 = sqrt(fma(_e10090, _e10090, fma(_e10089, _e10089, (_e10099 * _e10099))));
                        let _e10104 = (_e10103 - 6371000f);
                        if (_e10104 < 1600f) {
                            phi_7507_ = f32();
                            phi_7508_ = true;
                        } else {
                            let _e10106 = (_e10104 > 2100f);
                            if _e10106 {
                                phi_7506_ = f32();
                            } else {
                                let _e10110 = global_2.member.member[0u];
                                let _e10111 = (_e10110 * 0.02f);
                                let _e10112 = fma(_e10089, 0.001f, _e10111);
                                let _e10113 = fma(_e10090, 0.001f, _e10111);
                                let _e10114 = floor(_e10113);
                                let _e10115 = (_e10113 - _e10114);
                                let _e10116 = (_e10114 * 0.265625f);
                                let _e10117 = fma(_e10112, 0.015625f, _e10116);
                                let _e10118 = fma(_e10104, 0.000015625f, _e10116);
                                if (_e10117 > 0f) {
                                    phi_27990_ = (_e10117 % 1f);
                                } else {
                                    phi_27990_ = (1f - (-(_e10117) % 1f));
                                }
                                let _e10125 = phi_27990_;
                                if (_e10118 > 0f) {
                                    phi_28003_ = (_e10118 % 1f);
                                } else {
                                    phi_28003_ = (1f - (-(_e10118) % 1f));
                                }
                                let _e10132 = phi_28003_;
                                let _e10134 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10125, _e10132), 0f);
                                let _e10136 = (_e10117 + 0.265625f);
                                let _e10137 = (_e10118 + 0.265625f);
                                if (_e10136 > 0f) {
                                    phi_28033_ = (_e10136 % 1f);
                                } else {
                                    phi_28033_ = (1f - ((-0.265625f - _e10117) % 1f));
                                }
                                let _e10144 = phi_28033_;
                                if (_e10137 > 0f) {
                                    phi_28046_ = (_e10137 % 1f);
                                } else {
                                    phi_28046_ = (1f - ((-0.265625f - _e10118) % 1f));
                                }
                                let _e10151 = phi_28046_;
                                let _e10153 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10144, _e10151), 0f);
                                let _e10158 = fma(_e10110, 0.02f, 2f);
                                let _e10161 = floor((_e10113 * _e10158));
                                let _e10163 = fma(_e10113, _e10158, -(_e10161));
                                let _e10164 = (_e10161 * 0.265625f);
                                let _e10165 = fma((_e10112 * _e10158), 0.015625f, _e10164);
                                let _e10166 = fma(_e10104, 0.00003125f, _e10164);
                                if (_e10165 > 0f) {
                                    phi_28106_ = (_e10165 % 1f);
                                } else {
                                    phi_28106_ = (1f - (-(_e10165) % 1f));
                                }
                                let _e10173 = phi_28106_;
                                if (_e10166 > 0f) {
                                    phi_28119_ = (_e10166 % 1f);
                                } else {
                                    phi_28119_ = (1f - (-(_e10166) % 1f));
                                }
                                let _e10180 = phi_28119_;
                                let _e10182 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10173, _e10180), 0f);
                                let _e10184 = (_e10165 + 0.265625f);
                                let _e10185 = (_e10166 + 0.265625f);
                                if (_e10184 > 0f) {
                                    phi_28149_ = (_e10184 % 1f);
                                } else {
                                    phi_28149_ = (1f - ((-0.265625f - _e10165) % 1f));
                                }
                                let _e10192 = phi_28149_;
                                if (_e10185 > 0f) {
                                    phi_28162_ = (_e10185 % 1f);
                                } else {
                                    phi_28162_ = (1f - ((-0.265625f - _e10166) % 1f));
                                }
                                let _e10199 = phi_28162_;
                                let _e10201 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10192, _e10199), 0f);
                                let _e10209 = fma(-(_e10110), 0.02f, 7f);
                                let _e10212 = floor((_e10113 * _e10209));
                                let _e10214 = fma(_e10113, _e10209, -(_e10212));
                                let _e10215 = (_e10212 * 0.265625f);
                                let _e10216 = fma((_e10112 * _e10209), 0.015625f, _e10215);
                                let _e10217 = fma(_e10104, 0.000109375f, _e10215);
                                if (_e10216 > 0f) {
                                    phi_28222_ = (_e10216 % 1f);
                                } else {
                                    phi_28222_ = (1f - (-(_e10216) % 1f));
                                }
                                let _e10224 = phi_28222_;
                                if (_e10217 > 0f) {
                                    phi_28235_ = (_e10217 % 1f);
                                } else {
                                    phi_28235_ = (1f - (-(_e10217) % 1f));
                                }
                                let _e10231 = phi_28235_;
                                let _e10233 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10224, _e10231), 0f);
                                let _e10235 = (_e10216 + 0.265625f);
                                let _e10236 = (_e10217 + 0.265625f);
                                if (_e10235 > 0f) {
                                    phi_28265_ = (_e10235 % 1f);
                                } else {
                                    phi_28265_ = (1f - ((-0.265625f - _e10216) % 1f));
                                }
                                let _e10243 = phi_28265_;
                                if (_e10236 > 0f) {
                                    phi_28278_ = (_e10236 % 1f);
                                } else {
                                    phi_28278_ = (1f - ((-0.265625f - _e10217) % 1f));
                                }
                                let _e10250 = phi_28278_;
                                let _e10252 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10243, _e10250), 0f);
                                let _e10259 = fma(_e10110, 0.02f, _e10113);
                                let _e10261 = floor((_e10259 * 16f));
                                let _e10263 = fma(_e10259, 16f, -(_e10261));
                                let _e10264 = (_e10261 * 0.265625f);
                                let _e10265 = fma(fma(_e10110, 0.02f, _e10112), 0.25f, _e10264);
                                let _e10266 = fma(_e10104, 0.00025f, _e10264);
                                if (_e10265 > 0f) {
                                    phi_28338_ = (_e10265 % 1f);
                                } else {
                                    phi_28338_ = (1f - (-(_e10265) % 1f));
                                }
                                let _e10273 = phi_28338_;
                                if (_e10266 > 0f) {
                                    phi_28351_ = (_e10266 % 1f);
                                } else {
                                    phi_28351_ = (1f - (-(_e10266) % 1f));
                                }
                                let _e10280 = phi_28351_;
                                let _e10282 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10273, _e10280), 0f);
                                let _e10284 = (_e10265 + 0.265625f);
                                let _e10285 = (_e10266 + 0.265625f);
                                if (_e10284 > 0f) {
                                    phi_28381_ = (_e10284 % 1f);
                                } else {
                                    phi_28381_ = (1f - ((-0.265625f - _e10265) % 1f));
                                }
                                let _e10292 = phi_28381_;
                                if (_e10285 > 0f) {
                                    phi_28394_ = (_e10285 % 1f);
                                } else {
                                    phi_28394_ = (1f - ((-0.265625f - _e10266) % 1f));
                                }
                                let _e10299 = phi_28394_;
                                let _e10301 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10292, _e10299), 0f);
                                let _e10307 = (_e10103 - 6372600f);
                                let _e10315 = ((fma(fma(_e10282.x, (1f - _e10263), (_e10301.x * _e10263)), 0.0625f, fma(fma(_e10233.x, (1f - _e10214), (_e10252.x * _e10214)), 0.125f, fma(fma(_e10134.x, (1f - _e10115), (_e10153.x * _e10115)), 0.5f, (fma(_e10182.x, (1f - _e10163), (_e10201.x * _e10163)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e10317 = select(_e10315, 0f, (_e10315 < 0f));
                                let _e10319 = select(_e10317, 1f, (_e10317 > 1f));
                                phi_7506_ = ((((_e10319 * _e10319) * fma(-2f, _e10319, 3f)) * ((1f - exp2((-0.01f * _e10307))) * exp2((-0.004f * _e10307)))) * 0.03f);
                            }
                            let _e10326 = phi_7506_;
                            phi_7507_ = _e10326;
                            phi_7508_ = _e10106;
                        }
                        let _e10328 = phi_7507_;
                        let _e10330 = phi_7508_;
                        phi_7389_ = (_e10092 + select(_e10328, 0f, _e10330));
                    } else {
                        phi_7389_ = f32();
                    }
                    let _e10334 = phi_7389_;
                    continue;
                    continuing {
                        phi_7388_ = _e10334;
                        phi_7391_ = _e10098;
                        break if !(_e10095);
                    }
                }
                let _e10337 = local_105;
                let _e10339 = exp2((_e10337 * -62.5f));
                phi_7565_ = (_e9829 * exp2(-(_e10081)));
                phi_7566_ = fma(_e9815, 0.0625f, _e9833);
                phi_7567_ = fma(_e9816, 0.0625f, _e9835);
                phi_7568_ = fma(_e9817, 0.0625f, _e9837);
                phi_7569_ = fma(((fma((((0.4807763f * _e10339) * _e10088) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e10085) * 3.1415927f), _e9829, _e9839);
                phi_7570_ = fma(((fma((((0.28401393f * _e10339) * _e10088) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e10085) * 3.1415927f), _e9829, _e9841);
                phi_7571_ = fma(((fma((((0.09044314f * _e10339) * _e10088) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e10085) * 3.1415927f), _e9829, _e9843);
            }
            let _e10371 = phi_7565_;
            let _e10373 = phi_7566_;
            let _e10375 = phi_7567_;
            let _e10377 = phi_7568_;
            let _e10379 = phi_7569_;
            let _e10381 = phi_7570_;
            let _e10383 = phi_7571_;
            phi_7226_ = _e10371;
            phi_7231_ = _e10373;
            phi_7233_ = _e10375;
            phi_7235_ = _e10377;
            phi_7237_ = _e10379;
            phi_7239_ = _e10381;
            phi_7241_ = _e10383;
        } else {
            phi_7226_ = f32();
            phi_7231_ = f32();
            phi_7233_ = f32();
            phi_7235_ = f32();
            phi_7237_ = f32();
            phi_7239_ = f32();
            phi_7241_ = f32();
        }
        let _e10385 = phi_7226_;
        let _e10387 = phi_7231_;
        let _e10389 = phi_7233_;
        let _e10391 = phi_7235_;
        let _e10393 = phi_7237_;
        let _e10395 = phi_7239_;
        let _e10397 = phi_7241_;
        continue;
        continuing {
            phi_7225_ = _e10385;
            phi_7228_ = _e9847;
            phi_7230_ = _e10387;
            phi_7232_ = _e10389;
            phi_7234_ = _e10391;
            phi_7236_ = _e10393;
            phi_7238_ = _e10395;
            phi_7240_ = _e10397;
            break if !(_e9844);
        }
    }
    let _e10400 = local_106;
    let _e10402 = local_107;
    let _e10405 = local_108;
    let _e10407 = local_109;
    let _e10410 = local_110;
    let _e10412 = local_111;
    let _e10418 = (sqrt(fma(_e9811, _e9811, fma(_e9809, _e9809, (_e9810 * _e9810)))) * 0.00001f);
    let _e10420 = select(_e10418, 0f, (_e10418 < 0f));
    let _e10422 = select(_e10420, 1f, (_e10420 > 1f));
    let _e10423 = (1f - _e10422);
    let _e10427 = fma(fma(_e9794, _e10400, _e10402), _e10423, (_e9794 * _e10422));
    let _e10428 = fma(fma(_e9795, _e10405, _e10407), _e10423, (_e9795 * _e10422));
    let _e10429 = fma(fma(_e9796, _e10410, _e10412), _e10423, (_e9796 * _e10422));
    if _e274 {
        phi_28468_ = vec2<f32>(-1f, -1f);
    } else {
        phi_28468_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e273)));
    }
    let _e10434 = phi_28468_;
    if _e283 {
        phi_28508_ = vec2<f32>(-1f, -1f);
    } else {
        phi_28508_ = vec2<f32>(f32(), fma(_e144.y, -6371000f, sqrt(_e282)));
    }
    let _e10440 = phi_28508_;
    let _e10442 = (_e144.x * _e10434.y);
    let _e10443 = (_e144.y * _e10434.y);
    let _e10444 = (_e144.z * _e10434.y);
    let _e10448 = fma(_e296, _e10434.y, (_e144.x + _e10440.y));
    let _e10449 = fma(_e298, _e10434.y, (_e144.y + _e10440.y));
    let _e10450 = fma(_e300, _e10434.y, (_e144.z + _e10440.y));
    let _e10451 = (_e10448 * 0.0625f);
    let _e10452 = (_e10449 * 0.0625f);
    let _e10453 = (_e10450 * 0.0625f);
    phi_7679_ = 1f;
    phi_7682_ = 0u;
    phi_7684_ = fma(_e10451, _e181, _e10442);
    phi_7686_ = fma(_e10452, _e181, _e10443);
    phi_7688_ = fma(_e10453, _e181, _e10444);
    phi_7690_ = 0f;
    phi_7692_ = 0f;
    phi_7694_ = 0f;
    loop {
        let _e10462 = phi_7679_;
        let _e10464 = phi_7682_;
        let _e10466 = phi_7684_;
        let _e10468 = phi_7686_;
        let _e10470 = phi_7688_;
        let _e10472 = phi_7690_;
        let _e10474 = phi_7692_;
        let _e10476 = phi_7694_;
        local_113 = _e10462;
        local_114 = _e10472;
        local_115 = _e10462;
        local_116 = _e10474;
        local_117 = _e10462;
        local_118 = _e10476;
        let _e10477 = (_e10464 < 16u);
        if _e10477 {
            phi_7683_ = (_e10464 + 1u);
        } else {
            phi_7683_ = _e10464;
        }
        let _e10480 = phi_7683_;
        if _e10477 {
            let _e10481 = (_e10468 + 6371000f);
            let _e10485 = sqrt(fma(_e10470, _e10470, fma(_e10466, _e10466, (_e10481 * _e10481))));
            let _e10486 = (_e10485 - 6371000f);
            if (_e10486 < 1600f) {
                phi_7810_ = f32();
                phi_7811_ = true;
            } else {
                let _e10488 = (_e10486 > 2100f);
                if _e10488 {
                    phi_7809_ = f32();
                } else {
                    let _e10492 = global_2.member.member[0u];
                    let _e10493 = (_e10492 * 0.02f);
                    let _e10494 = fma(_e10466, 0.001f, _e10493);
                    let _e10495 = fma(_e10470, 0.001f, _e10493);
                    let _e10496 = floor(_e10495);
                    let _e10497 = (_e10495 - _e10496);
                    let _e10498 = (_e10496 * 0.265625f);
                    let _e10499 = fma(_e10494, 0.015625f, _e10498);
                    let _e10500 = fma(_e10486, 0.000015625f, _e10498);
                    if (_e10499 > 0f) {
                        phi_28733_ = (_e10499 % 1f);
                    } else {
                        phi_28733_ = (1f - (-(_e10499) % 1f));
                    }
                    let _e10507 = phi_28733_;
                    if (_e10500 > 0f) {
                        phi_28746_ = (_e10500 % 1f);
                    } else {
                        phi_28746_ = (1f - (-(_e10500) % 1f));
                    }
                    let _e10514 = phi_28746_;
                    let _e10516 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10507, _e10514), 0f);
                    let _e10518 = (_e10499 + 0.265625f);
                    let _e10519 = (_e10500 + 0.265625f);
                    if (_e10518 > 0f) {
                        phi_28776_ = (_e10518 % 1f);
                    } else {
                        phi_28776_ = (1f - ((-0.265625f - _e10499) % 1f));
                    }
                    let _e10526 = phi_28776_;
                    if (_e10519 > 0f) {
                        phi_28789_ = (_e10519 % 1f);
                    } else {
                        phi_28789_ = (1f - ((-0.265625f - _e10500) % 1f));
                    }
                    let _e10533 = phi_28789_;
                    let _e10535 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10526, _e10533), 0f);
                    let _e10540 = fma(_e10492, 0.02f, 2f);
                    let _e10543 = floor((_e10495 * _e10540));
                    let _e10545 = fma(_e10495, _e10540, -(_e10543));
                    let _e10546 = (_e10543 * 0.265625f);
                    let _e10547 = fma((_e10494 * _e10540), 0.015625f, _e10546);
                    let _e10548 = fma(_e10486, 0.00003125f, _e10546);
                    if (_e10547 > 0f) {
                        phi_28849_ = (_e10547 % 1f);
                    } else {
                        phi_28849_ = (1f - (-(_e10547) % 1f));
                    }
                    let _e10555 = phi_28849_;
                    if (_e10548 > 0f) {
                        phi_28862_ = (_e10548 % 1f);
                    } else {
                        phi_28862_ = (1f - (-(_e10548) % 1f));
                    }
                    let _e10562 = phi_28862_;
                    let _e10564 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10555, _e10562), 0f);
                    let _e10566 = (_e10547 + 0.265625f);
                    let _e10567 = (_e10548 + 0.265625f);
                    if (_e10566 > 0f) {
                        phi_28892_ = (_e10566 % 1f);
                    } else {
                        phi_28892_ = (1f - ((-0.265625f - _e10547) % 1f));
                    }
                    let _e10574 = phi_28892_;
                    if (_e10567 > 0f) {
                        phi_28905_ = (_e10567 % 1f);
                    } else {
                        phi_28905_ = (1f - ((-0.265625f - _e10548) % 1f));
                    }
                    let _e10581 = phi_28905_;
                    let _e10583 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10574, _e10581), 0f);
                    let _e10591 = fma(-(_e10492), 0.02f, 7f);
                    let _e10594 = floor((_e10495 * _e10591));
                    let _e10596 = fma(_e10495, _e10591, -(_e10594));
                    let _e10597 = (_e10594 * 0.265625f);
                    let _e10598 = fma((_e10494 * _e10591), 0.015625f, _e10597);
                    let _e10599 = fma(_e10486, 0.000109375f, _e10597);
                    if (_e10598 > 0f) {
                        phi_28965_ = (_e10598 % 1f);
                    } else {
                        phi_28965_ = (1f - (-(_e10598) % 1f));
                    }
                    let _e10606 = phi_28965_;
                    if (_e10599 > 0f) {
                        phi_28978_ = (_e10599 % 1f);
                    } else {
                        phi_28978_ = (1f - (-(_e10599) % 1f));
                    }
                    let _e10613 = phi_28978_;
                    let _e10615 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10606, _e10613), 0f);
                    let _e10617 = (_e10598 + 0.265625f);
                    let _e10618 = (_e10599 + 0.265625f);
                    if (_e10617 > 0f) {
                        phi_29008_ = (_e10617 % 1f);
                    } else {
                        phi_29008_ = (1f - ((-0.265625f - _e10598) % 1f));
                    }
                    let _e10625 = phi_29008_;
                    if (_e10618 > 0f) {
                        phi_29021_ = (_e10618 % 1f);
                    } else {
                        phi_29021_ = (1f - ((-0.265625f - _e10599) % 1f));
                    }
                    let _e10632 = phi_29021_;
                    let _e10634 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10625, _e10632), 0f);
                    let _e10641 = fma(_e10492, 0.02f, _e10495);
                    let _e10643 = floor((_e10641 * 16f));
                    let _e10645 = fma(_e10641, 16f, -(_e10643));
                    let _e10646 = (_e10643 * 0.265625f);
                    let _e10647 = fma(fma(_e10492, 0.02f, _e10494), 0.25f, _e10646);
                    let _e10648 = fma(_e10486, 0.00025f, _e10646);
                    if (_e10647 > 0f) {
                        phi_29081_ = (_e10647 % 1f);
                    } else {
                        phi_29081_ = (1f - (-(_e10647) % 1f));
                    }
                    let _e10655 = phi_29081_;
                    if (_e10648 > 0f) {
                        phi_29094_ = (_e10648 % 1f);
                    } else {
                        phi_29094_ = (1f - (-(_e10648) % 1f));
                    }
                    let _e10662 = phi_29094_;
                    let _e10664 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10655, _e10662), 0f);
                    let _e10666 = (_e10647 + 0.265625f);
                    let _e10667 = (_e10648 + 0.265625f);
                    if (_e10666 > 0f) {
                        phi_29124_ = (_e10666 % 1f);
                    } else {
                        phi_29124_ = (1f - ((-0.265625f - _e10647) % 1f));
                    }
                    let _e10674 = phi_29124_;
                    if (_e10667 > 0f) {
                        phi_29137_ = (_e10667 % 1f);
                    } else {
                        phi_29137_ = (1f - ((-0.265625f - _e10648) % 1f));
                    }
                    let _e10681 = phi_29137_;
                    let _e10683 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10674, _e10681), 0f);
                    let _e10689 = (_e10485 - 6372600f);
                    let _e10697 = ((fma(fma(_e10664.x, (1f - _e10645), (_e10683.x * _e10645)), 0.0625f, fma(fma(_e10615.x, (1f - _e10596), (_e10634.x * _e10596)), 0.125f, fma(fma(_e10516.x, (1f - _e10497), (_e10535.x * _e10497)), 0.5f, (fma(_e10564.x, (1f - _e10545), (_e10583.x * _e10545)) * 0.25f)))) - 0.55f) * 19.999996f);
                    let _e10699 = select(_e10697, 0f, (_e10697 < 0f));
                    let _e10701 = select(_e10699, 1f, (_e10699 > 1f));
                    phi_7809_ = ((((_e10701 * _e10701) * fma(-2f, _e10701, 3f)) * ((1f - exp2((-0.01f * _e10689))) * exp2((-0.004f * _e10689)))) * 0.03f);
                }
                let _e10708 = phi_7809_;
                phi_7810_ = _e10708;
                phi_7811_ = _e10488;
            }
            let _e10710 = phi_7810_;
            let _e10712 = phi_7811_;
            let _e10714 = (select(_e10710, 0f, _e10712) * sqrt(fma(_e10453, _e10453, fma(_e10451, _e10451, (_e10452 * _e10452)))));
            if (_e10714 <= 0f) {
                phi_8019_ = _e10462;
                phi_8020_ = _e10466;
                phi_8021_ = _e10468;
                phi_8022_ = _e10470;
                phi_8023_ = _e10472;
                phi_8024_ = _e10474;
                phi_8025_ = _e10476;
            } else {
                let _e10718 = fma(exp2((-1.6013916f * _e10714)), -0.9009009f, 0.9009009f);
                let _e10721 = (1f - exp2((_e10714 * -1.3862944f)));
                let _e10722 = (-9.537895f + _e10466);
                let _e10723 = (29.354609f + _e10470);
                phi_7842_ = 0f;
                phi_7845_ = 0u;
                loop {
                    let _e10725 = phi_7842_;
                    let _e10727 = phi_7845_;
                    local_112 = _e10725;
                    let _e10728 = (_e10727 < 8u);
                    if _e10728 {
                        phi_7846_ = (_e10727 + 1u);
                    } else {
                        phi_7846_ = _e10727;
                    }
                    let _e10731 = phi_7846_;
                    if _e10728 {
                        let _e10732 = (_e10468 + 6371005f);
                        let _e10736 = sqrt(fma(_e10723, _e10723, fma(_e10722, _e10722, (_e10732 * _e10732))));
                        let _e10737 = (_e10736 - 6371000f);
                        if (_e10737 < 1600f) {
                            phi_7961_ = f32();
                            phi_7962_ = true;
                        } else {
                            let _e10739 = (_e10737 > 2100f);
                            if _e10739 {
                                phi_7960_ = f32();
                            } else {
                                let _e10743 = global_2.member.member[0u];
                                let _e10744 = (_e10743 * 0.02f);
                                let _e10745 = fma(_e10722, 0.001f, _e10744);
                                let _e10746 = fma(_e10723, 0.001f, _e10744);
                                let _e10747 = floor(_e10746);
                                let _e10748 = (_e10746 - _e10747);
                                let _e10749 = (_e10747 * 0.265625f);
                                let _e10750 = fma(_e10745, 0.015625f, _e10749);
                                let _e10751 = fma(_e10737, 0.000015625f, _e10749);
                                if (_e10750 > 0f) {
                                    phi_29213_ = (_e10750 % 1f);
                                } else {
                                    phi_29213_ = (1f - (-(_e10750) % 1f));
                                }
                                let _e10758 = phi_29213_;
                                if (_e10751 > 0f) {
                                    phi_29226_ = (_e10751 % 1f);
                                } else {
                                    phi_29226_ = (1f - (-(_e10751) % 1f));
                                }
                                let _e10765 = phi_29226_;
                                let _e10767 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10758, _e10765), 0f);
                                let _e10769 = (_e10750 + 0.265625f);
                                let _e10770 = (_e10751 + 0.265625f);
                                if (_e10769 > 0f) {
                                    phi_29256_ = (_e10769 % 1f);
                                } else {
                                    phi_29256_ = (1f - ((-0.265625f - _e10750) % 1f));
                                }
                                let _e10777 = phi_29256_;
                                if (_e10770 > 0f) {
                                    phi_29269_ = (_e10770 % 1f);
                                } else {
                                    phi_29269_ = (1f - ((-0.265625f - _e10751) % 1f));
                                }
                                let _e10784 = phi_29269_;
                                let _e10786 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10777, _e10784), 0f);
                                let _e10791 = fma(_e10743, 0.02f, 2f);
                                let _e10794 = floor((_e10746 * _e10791));
                                let _e10796 = fma(_e10746, _e10791, -(_e10794));
                                let _e10797 = (_e10794 * 0.265625f);
                                let _e10798 = fma((_e10745 * _e10791), 0.015625f, _e10797);
                                let _e10799 = fma(_e10737, 0.00003125f, _e10797);
                                if (_e10798 > 0f) {
                                    phi_29329_ = (_e10798 % 1f);
                                } else {
                                    phi_29329_ = (1f - (-(_e10798) % 1f));
                                }
                                let _e10806 = phi_29329_;
                                if (_e10799 > 0f) {
                                    phi_29342_ = (_e10799 % 1f);
                                } else {
                                    phi_29342_ = (1f - (-(_e10799) % 1f));
                                }
                                let _e10813 = phi_29342_;
                                let _e10815 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10806, _e10813), 0f);
                                let _e10817 = (_e10798 + 0.265625f);
                                let _e10818 = (_e10799 + 0.265625f);
                                if (_e10817 > 0f) {
                                    phi_29372_ = (_e10817 % 1f);
                                } else {
                                    phi_29372_ = (1f - ((-0.265625f - _e10798) % 1f));
                                }
                                let _e10825 = phi_29372_;
                                if (_e10818 > 0f) {
                                    phi_29385_ = (_e10818 % 1f);
                                } else {
                                    phi_29385_ = (1f - ((-0.265625f - _e10799) % 1f));
                                }
                                let _e10832 = phi_29385_;
                                let _e10834 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10825, _e10832), 0f);
                                let _e10842 = fma(-(_e10743), 0.02f, 7f);
                                let _e10845 = floor((_e10746 * _e10842));
                                let _e10847 = fma(_e10746, _e10842, -(_e10845));
                                let _e10848 = (_e10845 * 0.265625f);
                                let _e10849 = fma((_e10745 * _e10842), 0.015625f, _e10848);
                                let _e10850 = fma(_e10737, 0.000109375f, _e10848);
                                if (_e10849 > 0f) {
                                    phi_29445_ = (_e10849 % 1f);
                                } else {
                                    phi_29445_ = (1f - (-(_e10849) % 1f));
                                }
                                let _e10857 = phi_29445_;
                                if (_e10850 > 0f) {
                                    phi_29458_ = (_e10850 % 1f);
                                } else {
                                    phi_29458_ = (1f - (-(_e10850) % 1f));
                                }
                                let _e10864 = phi_29458_;
                                let _e10866 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10857, _e10864), 0f);
                                let _e10868 = (_e10849 + 0.265625f);
                                let _e10869 = (_e10850 + 0.265625f);
                                if (_e10868 > 0f) {
                                    phi_29488_ = (_e10868 % 1f);
                                } else {
                                    phi_29488_ = (1f - ((-0.265625f - _e10849) % 1f));
                                }
                                let _e10876 = phi_29488_;
                                if (_e10869 > 0f) {
                                    phi_29501_ = (_e10869 % 1f);
                                } else {
                                    phi_29501_ = (1f - ((-0.265625f - _e10850) % 1f));
                                }
                                let _e10883 = phi_29501_;
                                let _e10885 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10876, _e10883), 0f);
                                let _e10892 = fma(_e10743, 0.02f, _e10746);
                                let _e10894 = floor((_e10892 * 16f));
                                let _e10896 = fma(_e10892, 16f, -(_e10894));
                                let _e10897 = (_e10894 * 0.265625f);
                                let _e10898 = fma(fma(_e10743, 0.02f, _e10745), 0.25f, _e10897);
                                let _e10899 = fma(_e10737, 0.00025f, _e10897);
                                if (_e10898 > 0f) {
                                    phi_29561_ = (_e10898 % 1f);
                                } else {
                                    phi_29561_ = (1f - (-(_e10898) % 1f));
                                }
                                let _e10906 = phi_29561_;
                                if (_e10899 > 0f) {
                                    phi_29574_ = (_e10899 % 1f);
                                } else {
                                    phi_29574_ = (1f - (-(_e10899) % 1f));
                                }
                                let _e10913 = phi_29574_;
                                let _e10915 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10906, _e10913), 0f);
                                let _e10917 = (_e10898 + 0.265625f);
                                let _e10918 = (_e10899 + 0.265625f);
                                if (_e10917 > 0f) {
                                    phi_29604_ = (_e10917 % 1f);
                                } else {
                                    phi_29604_ = (1f - ((-0.265625f - _e10898) % 1f));
                                }
                                let _e10925 = phi_29604_;
                                if (_e10918 > 0f) {
                                    phi_29617_ = (_e10918 % 1f);
                                } else {
                                    phi_29617_ = (1f - ((-0.265625f - _e10899) % 1f));
                                }
                                let _e10932 = phi_29617_;
                                let _e10934 = textureSampleLevel(global_3, global_4, vec2<f32>(_e10925, _e10932), 0f);
                                let _e10940 = (_e10736 - 6372600f);
                                let _e10948 = ((fma(fma(_e10915.x, (1f - _e10896), (_e10934.x * _e10896)), 0.0625f, fma(fma(_e10866.x, (1f - _e10847), (_e10885.x * _e10847)), 0.125f, fma(fma(_e10767.x, (1f - _e10748), (_e10786.x * _e10748)), 0.5f, (fma(_e10815.x, (1f - _e10796), (_e10834.x * _e10796)) * 0.25f)))) - 0.55f) * 19.999996f);
                                let _e10950 = select(_e10948, 0f, (_e10948 < 0f));
                                let _e10952 = select(_e10950, 1f, (_e10950 > 1f));
                                phi_7960_ = ((((_e10952 * _e10952) * fma(-2f, _e10952, 3f)) * ((1f - exp2((-0.01f * _e10940))) * exp2((-0.004f * _e10940)))) * 0.03f);
                            }
                            let _e10959 = phi_7960_;
                            phi_7961_ = _e10959;
                            phi_7962_ = _e10739;
                        }
                        let _e10961 = phi_7961_;
                        let _e10963 = phi_7962_;
                        phi_7843_ = (_e10725 + select(_e10961, 0f, _e10963));
                    } else {
                        phi_7843_ = f32();
                    }
                    let _e10967 = phi_7843_;
                    continue;
                    continuing {
                        phi_7842_ = _e10967;
                        phi_7845_ = _e10731;
                        break if !(_e10728);
                    }
                }
                let _e10970 = local_112;
                let _e10972 = exp2((_e10970 * -62.5f));
                phi_8019_ = (_e10462 * exp2(-(_e10714)));
                phi_8020_ = fma(_e10448, 0.0625f, _e10466);
                phi_8021_ = fma(_e10449, 0.0625f, _e10468);
                phi_8022_ = fma(_e10450, 0.0625f, _e10470);
                phi_8023_ = fma(((fma((((0.4807763f * _e10972) * _e10721) * _e317), 3.926991f, (_e330 * 0.011371779f)) * _e10718) * 3.1415927f), _e10462, _e10472);
                phi_8024_ = fma(((fma((((0.28401393f * _e10972) * _e10721) * _e317), 3.926991f, (_e331 * 0.019994339f)) * _e10718) * 3.1415927f), _e10462, _e10474);
                phi_8025_ = fma(((fma((((0.09044314f * _e10972) * _e10721) * _e317), 3.926991f, (_e332 * 0.038739033f)) * _e10718) * 3.1415927f), _e10462, _e10476);
            }
            let _e11004 = phi_8019_;
            let _e11006 = phi_8020_;
            let _e11008 = phi_8021_;
            let _e11010 = phi_8022_;
            let _e11012 = phi_8023_;
            let _e11014 = phi_8024_;
            let _e11016 = phi_8025_;
            phi_7680_ = _e11004;
            phi_7685_ = _e11006;
            phi_7687_ = _e11008;
            phi_7689_ = _e11010;
            phi_7691_ = _e11012;
            phi_7693_ = _e11014;
            phi_7695_ = _e11016;
        } else {
            phi_7680_ = f32();
            phi_7685_ = f32();
            phi_7687_ = f32();
            phi_7689_ = f32();
            phi_7691_ = f32();
            phi_7693_ = f32();
            phi_7695_ = f32();
        }
        let _e11018 = phi_7680_;
        let _e11020 = phi_7685_;
        let _e11022 = phi_7687_;
        let _e11024 = phi_7689_;
        let _e11026 = phi_7691_;
        let _e11028 = phi_7693_;
        let _e11030 = phi_7695_;
        continue;
        continuing {
            phi_7679_ = _e11018;
            phi_7682_ = _e10480;
            phi_7684_ = _e11020;
            phi_7686_ = _e11022;
            phi_7688_ = _e11024;
            phi_7690_ = _e11026;
            phi_7692_ = _e11028;
            phi_7694_ = _e11030;
            break if !(_e10477);
        }
    }
    let _e11033 = local_113;
    let _e11035 = local_114;
    let _e11038 = local_115;
    let _e11040 = local_116;
    let _e11043 = local_117;
    let _e11045 = local_118;
    let _e11051 = (sqrt(fma(_e10444, _e10444, fma(_e10442, _e10442, (_e10443 * _e10443)))) * 0.00001f);
    let _e11053 = select(_e11051, 0f, (_e11051 < 0f));
    let _e11055 = select(_e11053, 1f, (_e11053 > 1f));
    let _e11056 = (1f - _e11055);
    textureStore(global_5, vec2<u32>(_e107.x, _e107.y), vec4<f32>(fma(fma(_e10427, _e11033, _e11035), _e11056, (_e10427 * _e11055)), fma(fma(_e10428, _e11038, _e11040), _e11056, (_e10428 * _e11055)), fma(fma(_e10429, _e11043, _e11045), _e11056, (_e10429 * _e11055)), 1f));
    return;
}

@compute @workgroup_size(1, 1, 1) 
fn atmosphereatmosphere(@builtin(global_invocation_id) param: vec3<u32>) {
    global = param;
    function();
}
