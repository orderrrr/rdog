use log::info;

macro_rules! shaders {
    ([ $( $name:ident, )* ]) => {
        #[derive(Debug)]
        pub struct Shaders {
            $( pub $name: (wgpu::ShaderModule, &'static str), )*
        }

        impl Shaders {
            pub fn new(device: &wgpu::Device) -> Self {
                $(
                    info!("Initializing shader: {}", stringify!($name));

                    let module = wgpu::include_spirv!(
                        env!(concat!("rdog_shaders::", stringify!($name), ".path"))
                    );

                    // Safety: fingers crossed™
                    //
                    // We do our best, but our shaders are so array-intensive
                    // that adding the checks decreases performance by 33%, so
                    // it's pretty much a no-go.
                    let module = unsafe {
                        device.create_shader_module_unchecked(module)
                    };

                    let entry_point = env!(concat!("rdog_shaders::", stringify!($name), ".entry_point"));

                    let $name = (module, entry_point);
                )*

                Self {
                    $($name,)*
                }
            }
        }
    };
}

shaders!([sub_ray, atmosphere, ray_vs, ray_fs,]);
