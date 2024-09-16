use std::{error::Error, io::Cursor};
use firedetection_preprocessing::{apply_hsv_filter, Config};
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

    let mut img = ImageReader::open(config.image_path.clone()).unwrap().decode().unwrap().to_rgb8();
    apply_hsv_filter(&mut img, vec![(20.0, 40.0), (50.0, 255.0), (50.0, 255.0)]);
    img.save("temp.png").unwrap();
}
