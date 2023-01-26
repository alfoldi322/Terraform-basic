Simple infrastructure defined in Terraform

03 01 2023 

- Add routing for private subnet > NAT & public subnet > IGW (modules/network)
- Add required providers (main.tf)
- Remove elastic ip for database (modules/database)

09 01 

- Reconstruct the project file structure
- Modify module import (main.tf)
- Add ping rule all instance for test

11 01 

- Fix env variables for provider
- Add dependency on network for instances
- Fix routing (modules/network)


23 01

- Add output variables
- Remove provider from root main.tf using aws profile instead

26 01
- Update instances AMI
- Import resources to one module to another (main.tf)
- Infrastructure start without error