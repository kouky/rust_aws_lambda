# Rust AWS Lambda Example

## Configure your Mac to build targets for Amazon Linux 

    rustup target add x86_64-unknown-linux-musl
    brew install filosottile/musl-cross/musl-cross
    mkdir .cargo
    echo $'[target.x86_64-unknown-linux-musl]\nlinker = "x86_64-linux-musl-gcc"' > .cargo/config

## Configure Terraform 

Set `aws_profile` default in `variables.tf` file to match your aws-credentials.

    cd infra
    terrform init

## Compile target for Amazon Linux

    make lambda_zip

## Deploy

    cd infra
    terraform apply

## Invoke Lambda

    aws lambda invoke --function-name rust_lambda \
    --profile michael-personal \
    --region us-west-2 \
    --cli-binary-format raw-in-base64-out \
    --payload '{"command": "hello_world"}' response.json 
