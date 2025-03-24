use super::{render::CameraController, CameraHandle};
use std::collections::HashMap;
use std::sync::RwLock;

#[derive(Debug)]
pub struct RenderControllers {
    cameras: RwLock<HashMap<CameraHandle, CameraController>>,
    pub next_id: std::sync::atomic::AtomicUsize,
}

impl Default for RenderControllers {
    fn default() -> Self {
        Self {
            cameras: RwLock::new(HashMap::new()),
            next_id: std::sync::atomic::AtomicUsize::new(0),
        }
    }
}

impl RenderControllers {
    pub fn add(&self, camera: CameraController) -> CameraHandle {
        let handle = CameraHandle::new(
            self.next_id
                .fetch_add(1, std::sync::atomic::Ordering::SeqCst),
        );
        self.cameras.write().unwrap().insert(handle, camera);
        handle
    }

    pub fn next_handle(&self) -> CameraHandle {
        CameraHandle::new(
            self.next_id
                .fetch_add(1, std::sync::atomic::Ordering::SeqCst),
        )
    }

    pub fn insert(&self, handle: CameraHandle, camera: CameraController) -> CameraHandle {
        self.cameras.write().unwrap().insert(handle, camera);
        handle
    }

    pub fn get(
        &self,
        camera_handle: CameraHandle,
    ) -> impl std::ops::Deref<Target = CameraController> + '_ {
        std::sync::RwLockReadGuard::map(self.cameras.read().unwrap(), |cameras| {
            cameras
                .get(&camera_handle)
                .unwrap_or_else(|| panic!("camera does not exist: {:?}", camera_handle))
        })
    }

    pub fn get_first(&self) -> impl std::ops::Deref<Target = CameraController> + '_ {
        std::sync::RwLockReadGuard::map(self.cameras.read().unwrap(), |cameras| {
            cameras.get(&CameraHandle::new(0)).unwrap()
        })
    }

    pub fn get_mut(
        &self,
        camera_handle: CameraHandle,
    ) -> impl std::ops::DerefMut<Target = CameraController> + '_ {
        std::sync::RwLockWriteGuard::map(self.cameras.write().unwrap(), |cameras| {
            cameras
                .get_mut(&camera_handle)
                .unwrap_or_else(|| panic!("camera does not exist: {:?}", camera_handle))
        })
    }

    pub fn iter_mut(
        &self,
    ) -> Vec<(
        CameraHandle,
        impl std::ops::DerefMut<Target = CameraController> + '_,
    )> {
        let handles: Vec<CameraHandle> = self.cameras.read().unwrap().keys().cloned().collect();
        handles
            .into_iter()
            .map(|handle| (handle, self.get_mut(handle)))
            .collect()
    }

    pub fn remove(&self, camera_handle: CameraHandle) {
        self.cameras.write().unwrap().remove(&camera_handle);
    }
}
