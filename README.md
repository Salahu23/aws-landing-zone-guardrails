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
