extern crate spirv_builder;

use spirv_builder::{Capability, MetadataPrintout, SpirvBuilder};
use std::env;
use std::error::Error;
use std::path::{Path, PathBuf};
use std::{fs, io};

fn main() -> Result<(), Box<dyn Error>> {
    let crate_path = Path::new(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .unwrap()
        .join("rdog_shaders");

    println!("SPIRV BUILD...");
    println!("path to crate: {:?}", crate_path);

    let result = SpirvBuilder::new(&crate_path, "spirv-unknown-spv1.5")
        .multimodule(true)
        .print_metadata(MetadataPrintout::DependencyOnly)
        .capability(Capability::Int8)
        .extra_arg("--spirt-passes=reduce,fuse_selects")
        .build()?;

    for (shader_name, shader_path) in result.module.unwrap_multi() {
        let shader_id = shader_name.replace("::", "_");
        let shader_id = shader_id.strip_suffix("_main").unwrap_or(&shader_id);

        println!(
            "cargo:rustc-env=rdog_shaders::{}.path={}",
            shader_id,
            shader_path.display()
        );

        println!(
            "cargo:rustc-env=rdog_shaders::{}.entry_point={}",
            shader_id, shader_name,
        );
    }

    copy_dir_all(
        PathBuf::from(
            crate_path
                .clone()
                .into_os_string()
                .to_str()
                .unwrap()
                .to_owned()
                + "/../../target/spirv-builder/spirv-unknown-spv1.5/release/deps/rdog_shaders.spvs",
        ),
        PathBuf::from(
            crate_path.into_os_string().to_str().unwrap().to_owned()
                + "/../../crates/rdog/assets/shaders/rdog_shaders.spvs",
        ),
    )
    .unwrap();

    Ok(())
}

fn copy_dir_all(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> io::Result<()> {
    fs::create_dir_all(&dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let ty = entry.file_type()?;
        if ty.is_dir() {
            copy_dir_all(entry.path(), dst.as_ref().join(entry.file_name()))?;
        } else {
            fs::copy(entry.path(), dst.as_ref().join(entry.file_name()))?;
        }
    }
    Ok(())
}
