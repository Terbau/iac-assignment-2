# iac-assignment-2

My solution for the IAC compulsory assignment 2

Link to github repo: https://github.com/Terbau/iac-assignment-2

## Prerequisites

You need to be logged into a service principal. The easiest way to get this to work is by exporting the environment variables below (with correct values) to the current terminal session:

```
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

## Getting started

This project uses workspaces. Create, select and manage workspaces using the `terraform workspace` command. Being in a new workspace will setup a completely new environment. The ones used for github is `prod`, `staging` and `dev`.

## How to start the backend

First you need to configure the backend variables in variables.tf. Then:

1. `cd backend`
2. `terraform init`
3. `terraform plan`
4. `terraform apply`

## How to run the main app

Be sure to be in the root folder of this repository and make sure that the backend values in `terraform.tf` matches your deployed backend values from earlier. Then:

1. `terraform init`
2. `terraform plan`
3. `terraform apply`

To verify that everything works, navigate to `http://<gateway_public_ip_address>` and see that the content is `Hello world`.

## How to destory resources

`terraform destroy`
