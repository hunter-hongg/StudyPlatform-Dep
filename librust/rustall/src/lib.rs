use rand_chacha::{ChaCha20Rng, rand_core::SeedableRng};
use rand::Rng;
use std::ffi::c_int;

// libFFI_Rust_Rand
#[unsafe(no_mangle)]
pub unsafe extern "C" fn getrnd(min: c_int, max: c_int) -> c_int {
    let mut rng = ChaCha20Rng::from_entropy();
    rng.gen_range(min..max) 
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn getrnds(min: c_int, max: c_int, size: c_int) -> *mut c_int {
    let mut vec = vec![0; size as usize];
    for (_i,x) in vec.iter_mut().enumerate() {
        *x = unsafe{ getrnd(min,max) as c_int } ;
    }
    vec.leak().as_mut_ptr()
}

// libFFI_Rust_BaoShiChouJiang1
#[unsafe(no_mangle)]
pub unsafe extern "C" fn BaoShiChouJiang1_GetAnswer() -> c_int {
    unsafe{
    let ans = getrnd(0 as c_int,100 as c_int);
    match ans {
        0..5 => 0, 
        5..25 => 1, 
        25..50 => 2,
        _ => 3,
    }
    }
}
