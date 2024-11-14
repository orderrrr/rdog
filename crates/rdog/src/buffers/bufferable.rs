use std::slice;
use bytemuck::Pod;
use rdog_lib::{self as gpu, camera::Camera};

/// Object that can be sent into the GPU
pub trait Bufferable {
    fn data(&self) -> &[u8];

    fn size(&self) -> usize {
        self.data().len()
    }
}

impl Bufferable for u32 {
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(slice::from_ref(self))
    }
}

impl Bufferable for u64 {
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(slice::from_ref(self))
    }
}

impl Bufferable for f32 {
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(slice::from_ref(self))
    }
}

impl Bufferable for Camera {
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(slice::from_ref(self))
    }
}

impl Bufferable for gpu::Time {
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(slice::from_ref(self))
    }
}

// impl Bufferable for gpu::World {
//     fn data(&self) -> &[u8] {
//         bytemuck::cast_slice(slice::from_ref(self))
//     }
// }

impl<T> Bufferable for &[T]
where
    T: Pod,
{
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(self)
    }
}

impl<T> Bufferable for Vec<T>
where
    T: Pod,
{
    fn data(&self) -> &[u8] {
        bytemuck::cast_slice(self)
    }
}
