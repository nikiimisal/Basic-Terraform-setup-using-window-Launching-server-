# Launching an EC2 Instance Using Terraform on Windows (Updated Full Guide)

---

## 1. Launch an EC2 Instance Manually (For Understanding Only)

Before using Terraform, launch one EC2 instance manually to understand the basics.

1. Go to AWS Console → EC2 → Launch Instance  
2. Choose **Amazon Linux**  
3. Name the instance:  
   ```
   terraform-demo
   ```
4. Ensure **Port 22 (SSH)** is open  
5. If needed, open additional ports like **88**  
6. Launch the instance  
7. Connect to it using SSH  

Once inside the Linux terminal, you can change hostname (only for your understanding):

```
sudo hostnamectl hostname terraform
```

Terraform does NOT need this, but it helps you identify your server.

---

## 2. Install Terraform on Windows

1. Go to the official Terraform website [click here](https://developer.hashicorp.com/terraform/install#windows) 
2. Download Windows ZIP file  
3. Unzip it  
4. Select the folder where you want to keep `Terraform`  
5. If Terraform shows errors during installation, set the PATH manually:

Press:
```
Windows + R
```

Type:
```
sysdm.cpl
```

Go to:
- **Advanced**
- **Environment Variables**
- Under *System Variables* → select **Path**
- Click **Edit**
- Add the folder path where Terraform is located
- Save

After adding PATH, open PowerShell as Administrator:

```
terraform --version
```

If version appears, Terraform is installed successfully.

---

## 3. Install AWS CLI on Windows (Optional)

Search: “AWS CLI Windows installer”  
Download → Install → Finish.

Verify:
```
aws --version
```

---

## 4. Create IAM User for Terraform

Go to AWS Console → IAM → Users

1. Create a user named:
```
terraform
```
2. Give it permissions:
```
AdministratorAccess
```
3. Create an **Access Key**  
4. Choose option: **Command Line Interface (CLI)**  
5. Confirm and download the keys

---

## 5. Configure AWS Credentials in Windows

Open any terminal (PowerShell, Git Bash, VS Code terminal):

```
aws configure
```

Enter:
- Access Key  
- Secret Key  
- Region (Example: ap-south-1)  
- Output format:   

---

## 6. Create Your Terraform Project (Using VS Code)

1. Create a folder:
```
terraform-ec2
```
2. Right-click →  Show more option → Click → Open git bash here → type → code . ; exit     #(this command will let you go to VS code)
3. Create a file: (In VS-Code)
```
ec2.tf
```

Inside, you will write the Terraform code.

Basic reference code or any other info related to ec2 launch can be found by searching:

  terraform aws ec2  [click here](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)or[click here](https://registry.terraform.io/providers/hashicorp/aws/6.3.0/docs/resources/instance)

on the official Terraform site.

---

## 7. Example Terraform Code for EC2 Instance

Paste this inside `ec2.tf`:

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-windows-demo"
  }
}
```

Note: Use the correct AMI for your region.

---

## 8. Run Terraform Lifecycle (Init → Plan → Apply)

Terraform always follows this fixed cycle:

### Step 1: Initialize Terraform
```
terraform init
```
Run only **one time**, unless you change the provider.

### Step 2: Terraform Plan (Blueprint)
```
terraform plan
```

This shows what resources Terraform will create.

### Step 3: Terraform Apply (Create EC2)
```
terraform apply
```

Terraform will ask:
```
yes/no?
```

Type:
```
yes
```

Your EC2 instance will now be launched successfully.

---

## 9. Confirm the EC2 Launch

Go to:
AWS Console → EC2 → Instances

You will see your Terraform-created EC2 instance running.

---

## Summary

In this guide you learned:

- How to launch EC2 manually for understanding  
- How to check ports like 22 and 88  
- How to change Linux hostname  
- How to install Terraform on Windows  
- How to fix PATH issues using sysdm.cpl  
- How to install AWS CLI  
- How to create IAM user & Access Keys  
- How to configure AWS CLI credentials  
- How to set up VS Code for Terraform  
- How to write EC2 Terraform code  
- How to run Terraform init → plan → apply  
- How to verify EC2 launch  

You are now ready to deploy infrastructure using Terraform from Windows.

