use std::{collections::HashMap, error::Error};
use image::{ImageReader, Rgb};
use rand::Rng;
use rand::seq::SliceRandom;

#[derive(Debug)]
pub struct Config {
    pub image_path: String, 
}

impl Config {
    pub fn build(mut args: impl Iterator<Item = String>) -> Result<Config, &'static str> {
        args.next(); 

        let image_path = match args.next() {
            Some(value) => value,
            None => return Err("no input file path provided"),
        };

        Ok(Config {
            image_path
        })
    }
}

pub fn apply_hsv_filter(img: &mut image::ImageBuffer<Rgb<u8>, Vec<u8>>, color_region: Vec<(f32, f32)>) {
    img.enumerate_pixels_mut()
        .for_each(|pixel| {
            if is_in_range(pixel.2, &color_region) == false {
                *pixel.2 = Rgb([0,0,0]);
            }
    });
}

// might benefit from caching
pub fn is_in_range(rgb: &Rgb<u8>, color_region: &Vec<(f32, f32)>) -> bool {
    let r = rgb[0] as f32 / 255.0;
    let g = rgb[1] as f32 / 255.0;
    let b = rgb[2] as f32 / 255.0;

    let max = r.max(g).max(b);
    let min = r.min(g).min(b);
    let delta = max - min;

    let h = if delta == 0.0 {
        0.0
    } else if max == r {
        60.0 * (((g - b) / delta) % 6.0)
    } else if max == g {
        60.0 * (((b - r) / delta) + 2.0)
    } else {
        60.0 * (((r - g) / delta) + 4.0)
    };

    let hue = if h < 0.0 { h + 360.0 } else { h };
    let saturation = if max == 0.0 { 0.0 } else { (delta / max) * 100.0};
    let value = max * 100.0;

    if hue < color_region[0].0 || hue > color_region[0].1 {
        return false;
    }
    if saturation < color_region[1].0 || hue > color_region[1].1 {
        return false;
    }
    if value < color_region[2].0 || hue > color_region[2].1 {
        return false;
    }

    return true;

}
