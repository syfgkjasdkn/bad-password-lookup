#[macro_use]
extern crate rustler;
#[macro_use]
extern crate lazy_static;
extern crate fst;

use fst::{Set, SetBuilder};
use rustler::resource::ResourceArc;
use rustler::{thread, Encoder, Env, NifResult, Term};
use std::fs::File;
use std::io::{BufRead, BufReader};
// use std::sync::Mutex;

mod atoms {
    rustler_atoms! {
        atom ok;
    }
}

struct SetResource(Set);

rustler_export_nifs! {
    "Elixir.FST",
    [
        ("from_file", 1, from_file),
        ("contains?", 2, contains)
    ],
    Some(load)
}

fn load(env: Env, _info: Term) -> bool {
    resource_struct_init!(SetResource, env);
    true
}

fn from_file<'a>(caller: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let path: String = args[0].decode()?;

    thread::spawn::<thread::ThreadSpawner, _>(caller, move |env| {
        let file_handle = File::open(path).unwrap();
        let mut set_builder = SetBuilder::memory();
        for word in BufReader::new(&file_handle).lines() {
            set_builder.insert(word.unwrap()).unwrap();
        }
        let fst_bytes = set_builder.into_inner().unwrap();
        let set = Set::from_bytes(fst_bytes).unwrap();

        let resource = ResourceArc::new(SetResource(set));

        (atoms::ok(), resource).encode(env)
    });

    Ok(atoms::ok().encode(caller))
}

fn contains<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let resource: ResourceArc<SetResource> = args[0].decode()?;
    let set = &resource.0;
    let query: String = args[1].decode()?;
    Ok(set.contains(query).encode(env))
}
