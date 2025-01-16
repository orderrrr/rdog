extern crate spirv_builder;

use spirv_builder::{Capability, MetadataPrintout, SpirvBuilder};
use std::env;
use std::error::Error;
use std::path::{Path, PathBuf};

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

    uu_cp_recursive(
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
                + "/../../crates/rdog/assets/shaders",
        ),
    );

    Ok(())
}

// Equal to coreutils `cp -r src dst`
fn uu_cp_recursive(src: PathBuf, dst: PathBuf) {
    let options = uu_cp::Options {
        attributes: uu_cp::Attributes::NONE,
        attributes_only: false,
        copy_contents: false,
        cli_dereference: false,
        copy_mode: uu_cp::CopyMode::Copy,
        dereference: true,
        one_file_system: false,
        parents: false,
        update: uu_cp::UpdateMode::ReplaceAll,
        debug: false,
        verbose: false,
        strip_trailing_slashes: false,
        reflink_mode: uu_cp::ReflinkMode::Auto,
        sparse_mode: uu_cp::SparseMode::Auto,
        backup: uu_cp::BackupMode::NoBackup,
        backup_suffix: "~".to_owned(),
        no_target_dir: false,
        overwrite: uu_cp::OverwriteMode::Clobber(uu_cp::ClobberMode::Standard),
        recursive: true, // !
        target_dir: None,
        progress_bar: false,
    };
    uu_cp::copy(&[src], &dst, &options).unwrap();
}
