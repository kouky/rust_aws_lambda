# Rust AWS Lambda Example

## Compile on a Mac

    rustup target add x86_64-unknown-linux-musl
    brew install filosottile/musl-cross/musl-cross
    mkdir .cargo
    echo $'[target.x86_64-unknown-linux-musl]\nlinker = "x86_64-linux-musl-gcc"' > .cargo/config
    cargo build --release --target x86_64-unknown-linux-musl
    cp ./target/x86_64-unknown-linux-musl/release/rust_aws_lambda ./bootstrap && zip lambda.zip bootstrap && rm bootstrap

## Provision AWS Infra

Set `aws_profile` default in `variables.tf` file.

    cd infra
    terraform init
    terraform apply

## Invoke

    aws lambda invoke --function-name rust_lambda \
    --profile michael-personal \
    --region us-west-2 \
    --cli-binary-format raw-in-base64-out \
    --payload '{"firstName": "world"}' response.json 
