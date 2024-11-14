use std::collections::HashMap;

use super::{render::CameraController, CameraHandle};

#[derive(Debug, Default)]
pub struct RenderControllers {
    cameras: HashMap<CameraHandle, CameraController>,
    next_id: usize,
}

impl RenderControllers {
    pub fn add(&mut self, camera: CameraController) -> CameraHandle {
        let handle = CameraHandle::new(self.next_id);

        self.cameras.insert(handle, camera);
        self.next_id += 1;

        handle
    }

    pub fn get(&self, camera_handle: CameraHandle) -> &CameraController {
        self.cameras.get(&camera_handle).unwrap_or_else(|| {
            panic!("camera does not exist: {:?}", camera_handle)
        })
    }

    pub fn get_mut(
        &mut self,
        camera_handle: CameraHandle,
    ) -> &mut CameraController {
        self.cameras.get_mut(&camera_handle).unwrap_or_else(|| {
            panic!("camera does not exist: {:?}", camera_handle)
        })
    }

    pub fn iter_mut(
        &mut self,
    ) -> impl Iterator<Item = &mut CameraController> + '_ {
        self.cameras.values_mut()
    }

    pub fn remove(&mut self, camera_handle: CameraHandle) {
        self.cameras.remove(&camera_handle);
    }
}
