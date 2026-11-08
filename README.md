# AWS Governed Landing Zone

At most clients I've worked with, compliance lives in documents. Someone
writes a policy, and an auditor checks it once a year. I wanted to see what
happens when the environment enforces the rules itself: a risky change gets
blocked or flagged automatically, and there's a record of it either way.

Built on my own time in a personal AWS account. In progress, not
production-ready.

## What this builds
- [ ] An AWS Organizations setup with separate accounts for security,
      logging, workloads, and a sandbox
- [ ] Service Control Policies that lock down root, restrict regions, and
      block public S3 buckets
- [ ] Role-based access with permission boundaries and single sign-on
- [ ] A GitHub Actions pipeline that signs in with OIDC (no stored keys)
      and runs a policy check on every pull request
- [ ] AWS Config rules, with automatic fixes for some violations
- [ ] A table mapping each control to NIST 800-53

## How to deploy

### Prerequisites
- Terraform 1.10 or later
- AWS CLI v2, signed in with short-lived credentials (`aws login` or `aws configure sso`). No long-lived access keys.

### 1. Bootstrap the state bucket (one time)
```
cd bootstrap
terraform init
terraform apply
```
This creates an encrypted, versioned S3 bucket with public access blocked. Its own state stays local, because the bucket has to exist before it can store state.

### 2. Deploy the landing zone
```
cd landing-zone
terraform init
terraform plan
terraform apply
```
State is stored in the S3 bucket with native S3 state locking (`use_lockfile = true`), so two applies can't run at the same time.

### Tear down
```
cd landing-zone
terraform destroy
```
The state bucket has `prevent_destroy` set and is meant to stay.

### Design notes
- The state bucket currently lives in the management account. Best practice is to keep the management account nearly empty, since Service Control Policies don't apply to it. This will move once a dedicated account exists.
