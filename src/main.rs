use std::{error::Error, io::Cursor};
use firedetection_preprocessing::{apply_hsv_filter, Config};
use image::{ImageReader, Rgb};
use opencv::{core::{min, split, Mat, Point, Size, Vector, BORDER_CONSTANT}, highgui::{self, imshow}, imgcodecs::{imread, IMREAD_COLOR}, imgproc::{erode, get_structuring_element, morphology_default_border_value, MORPH_RECT}};
use std::{env, process};

use anyhow::Result; // Automatically handle the error types


// fn main() -> Result<()> { // Note, this is anyhow::Result
//     highgui::named_window("window", highgui::WINDOW_FULLSCREEN)?;
//     let mut cam = videoio::VideoCapture::new(0, videoio::CAP_ANY)?;
//     let mut frame = Mat::default(); // This array will store the web-cam data


//     loop {
//         cam.read(&mut frame)?;
//         highgui::imshow("window", &frame)?;
//         let key = highgui::wait_key(1)?;
//         if key == 113 { // quit with q
//             break;
//         }
//     }
//     Ok(())
// }



fn main() -> Result<()> {
    let config = match Config::build(env::args()) {
        Ok(config) => config,
        Err(msg) => {
            eprintln!("{msg}");
            process::exit(1);
        }
    };

    highgui::named_window("window", highgui::WINDOW_FULLSCREEN)?;
    let image = imread(&config.image_path.clone(), IMREAD_COLOR)?;
    let mut channels: Vector<Mat> = Vec::with_capacity(3).into();
    split(&image, &mut channels)?;

    let mut temp: Mat = Mat::default();
    let mut dc: Mat = Mat::default();
    let mut processed: Mat = Mat::default();
    min(&channels.get(0)?, &channels.get(1)?, &mut temp)?;
    min(&temp, &channels.get(2)?, &mut dc)?;

    let kernel = get_structuring_element(MORPH_RECT, Size::new(15,15), Point::new(-1,-1))?;
    erode(&dc, &mut processed, &kernel, Point::new(-1,-1), 1, BORDER_CONSTANT, morphology_default_border_value()?)?;

    loop {
        highgui::imshow("red", &processed)?;
        highgui::imshow("window", &image)?;
        let key = highgui::wait_key(1)?;
        if key == 113 { // quit with q
            break;
        }
    }

    let mut img = ImageReader::open(config.image_path.clone()).unwrap().decode().unwrap().to_rgb8();
    apply_hsv_filter(&mut img, vec![(20.0, 47.0), (50.0, 255.0), (50.0, 255.0)]);
    img.save("temp.png").unwrap();
    Ok(())
}
