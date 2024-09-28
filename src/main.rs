use std::{error::Error, io::Cursor};
use firedetection_preprocessing::{apply_hsv_filter, Config};
use image::{ImageReader, Rgb};
use std::{env, process};

use anyhow::Result; // Automatically handle the error types
use opencv::{
    prelude::*,
    videoio,
    highgui
}; // Note, the namespace of OpenCV is changed (to better or worse). It is no longer one enormous.


fn main() -> Result<()> { // Note, this is anyhow::Result
    // Open a GUI window
    highgui::named_window("window", highgui::WINDOW_FULLSCREEN)?;
    // Open the web-camera (assuming you have one)
    let mut cam = videoio::VideoCapture::new(0, videoio::CAP_ANY)?;
    let mut frame = Mat::default(); // This array will store the web-cam data
    // Read the camera
    // and display in the window
    loop {
        cam.read(&mut frame)?;
        highgui::imshow("window", &frame)?;
        let key = highgui::wait_key(1)?;
        if key == 113 { // quit with q
            break;
        }
    }
    Ok(())
}



// fn main() {
//     let config = match Config::build(env::args()) {
//         Ok(config) => config,
//         Err(msg) => {
//             eprintln!("{msg}");
//             process::exit(1);
//         }
//     };

//     let mut img = ImageReader::open(config.image_path.clone()).unwrap().decode().unwrap().to_rgb8();
//     apply_hsv_filter(&mut img, vec![(20.0, 40.0), (50.0, 255.0), (50.0, 255.0)]);
//     img.save("temp.png").unwrap();
// }
