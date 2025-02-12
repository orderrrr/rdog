pub fn render_debug_ray(// mut dconf: ResMut<DebugConfig>,
    // config: ResMut<Config>,
    // mut gizmos: Gizmos,
    // q_windows: Query<&Window, With<PrimaryWindow>>,
    // mouse: Res<ButtonInput<MouseButton>>,
    // cameras: Query<(&Projection, &Transform, &Camera, &PanOrbitState)>,
) {
    // if !config.ray_debug {
    //     return;
    // }
    // if let Ok((p, t, c, _)) = cameras.get_single() {
    //     if mouse.just_pressed(MouseButton::Left) {
    //         dconf.i += 1;
    //
    //         dconf.ndc = t.compute_matrix() * p.get_clip_from_view().inverse();
    //         dconf.uv = q_windows.get_single().unwrap().cursor_position().unwrap();
    //
    //         if dconf.i >= 8 {
    //             dconf.i = 0;
    //         }
    //     }
    //
    //     let vs = c.physical_viewport_size().unwrap();
    //     let c = C::new_blank(vs.as_vec2().extend(0.0).extend(0.0));
    //     let g = Globals {
    //         time: Vec2::ZERO,
    //         seed: UVec2::ZERO,
    //     };
    //     let p = PassParams::new(Vec2::ZERO, 8, 8, 0);
    //     let m: Vec<Material> = config
    //         .material_tree
    //         .mats
    //         .iter()
    //         .map(|x| x.to_shader())
    //         .collect();
    //     let l: Vec<rdog_lib::Light> = config
    //         .light_tree
    //         .lights
    //         .iter()
    //         .map(|x| x.to_shader())
    //         .collect();
    //
    //     let scene = Scene::new(&c, &g, &m, &l, &p, 4, true, true, true);
    //
    //     let mut ray = Ray::ray(vs.as_vec2(), dconf.ndc, dconf.uv, UVec2::splat(0), 0);
    //     let mut prev_ray = ray.clone();
    //
    //     for _ in 0..8 {
    //         let h = scene.debug_rt(&mut ray);
    //         // if dconf.i == i {
    //         gizmos.arrow(prev_ray.o, ray.o, if h.i { RED } else { BLUE });
    //         // }
    //         prev_ray = ray.clone();
    //     }
    // }
}

// pub trait DebugRt {
//     fn debug_rt(&self, r: &mut Ray) -> Hit;
// }
//
// impl DebugRt for Scene<'_> {
//     fn debug_rt(&self, r: &mut Ray) -> Hit {
//         let h = self.trace(r);
//         r.mv(h.d);
//
//         {
//             if h.d > TMAX {
//                 return h;
//             }
//             if h.m.emissive() > 0.0 {
//                 return h;
//             }
//         }
//
//         let l = h.scatter(self, r);
//
//         r.dir(l.dir);
//
//         return h;
//     }
// }
