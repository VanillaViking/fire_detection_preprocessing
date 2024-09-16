use std::{error::Error, io::Cursor};
use firedetection_preprocessing::Config;
use image::{ImageReader, Rgb};
use std::{env, process};


fn main() {
    let config = match Config::build(env::args()) {
        Ok(config) => config,
        Err(msg) => {
            eprintln!("{msg}");
            process::exit(1);
        }
    };


    let img = ImageReader::open(config.image_path.clone()).unwrap().decode().unwrap().to_rgb8();

}
