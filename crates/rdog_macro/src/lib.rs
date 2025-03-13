use proc_macro::TokenStream;
use quote::quote;
use syn::{parse_macro_input, Data, DeriveInput, Fields};

#[proc_macro_derive(TrackChanges)]
pub fn track_changes_derive(input: TokenStream) -> TokenStream {
    let input = parse_macro_input!(input as DeriveInput);
    let name = &input.ident;

    // Extract field names
    let fields = match &input.data {
        Data::Struct(data) => match &data.fields {
            Fields::Named(fields) => fields
                .named
                .iter()
                .map(|f| f.ident.as_ref().unwrap())
                .collect::<Vec<_>>(),
            _ => panic!("TrackChanges only works on structs with named fields"),
        },
        _ => panic!("TrackChanges only works on structs"),
    };

    // Generate implementation
    let expanded = quote! {
        impl #name {
            pub fn track_changes(&self, other: &#name) -> Vec<(String, String)> {
                let mut changes = Vec::new();

                #(
                    if self.#fields != other.#fields {
                        changes.push((
                            stringify!(#fields).to_string(),
                            format!("{:?} -> {:?}", self.#fields, other.#fields)
                        ));
                    }
                )*

                changes
            }
        }
    };

    TokenStream::from(expanded)
}
