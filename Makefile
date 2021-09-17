all: clippy build test

build:
	cargo build --verbose --all

test:
	cargo test --verbose --all

clippy:
	cargo clippy --all --all-targets --all-features -- -D warnings

lambda_zip: clippy test
	cargo build --release --target x86_64-unknown-linux-musl
	cp ./target/x86_64-unknown-linux-musl/release/rust_aws_lambda ./bootstrap && zip lambda.zip bootstrap && rm bootstrap
