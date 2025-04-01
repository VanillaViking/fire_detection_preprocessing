use std::{error::Error, io::Cursor};
use firedetection_preprocessing::{apply_hsv_filter, Config};
use image::{ImageReader, Rgb};
use opencv::{core::{min, split, Mat, Point, Size, Vector, BORDER_CONSTANT}, highgui::{self, imshow}, imgcodecs::{imread, IMREAD_COLOR}, imgproc::{canny, cvt_color, dilate, erode, get_structuring_element, morphology_default_border_value, COLOR_BGR2GRAY, MORPH_RECT}};
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

    let mut src_gray: Mat = Mat::default();
    cvt_color(&image, &mut src_gray, COLOR_BGR2GRAY, 0);

    // let mut temp: Mat = Mat::default();
    // let mut dc: Mat = Mat::default();
    // let mut processed: Mat = Mat::default();
    // min(&channels.get(0)?, &channels.get(1)?, &mut temp)?;
    // min(&temp, &channels.get(2)?, &mut dc)?;
    // let kernel = get_structuring_element(MORPH_RECT, Size::new(15,15), Point::new(-1,-1))?;
    // erode(&dc, &mut processed, &kernel, Point::new(-1,-1), 1, BORDER_CONSTANT, morphology_default_border_value()?)?;

    let mut upperThreshold = 100;
    let mut lowerThreshold = 20;


    loop {

        let mut grad: Mat = Mat::default();
        let mut dilated_grad: Mat = Mat::default();
        let dilation = get_structuring_element(MORPH_RECT, Size::new(5, 5), Point::new(-1,-1))?;
        canny(&src_gray, &mut grad, lowerThreshold as f64, upperThreshold as f64, 3, false);
        dilate(&grad, &mut dilated_grad, &dilation, Point::new(-1,-1), 1, BORDER_CONSTANT, morphology_default_border_value()?);

        highgui::imshow("dil", &dilated_grad)?;
        highgui::imshow("window", &image)?;
        let key = highgui::wait_key(0)? as u8 as char;
        if key == 'q' { // quit with q
            break;
        }
    }

    let mut img = ImageReader::open(config.image_path.clone()).unwrap().decode().unwrap().to_rgb8();
    apply_hsv_filter(&mut img, vec![(180.0, 230.0), (5.0, 255.0), (30.0, 255.0)]);
    img.save("temp.png").unwrap();
    Ok(())
}
