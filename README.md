# Weight-Tracker-APP-Ansible

# What is the resoult of this Ansible playbook?
With this ansible playbook you can run the Weight Tracker app on the azure resources Automatic.


1. Connect to the ansible VM you have in your environment. (The user name and password are the same as the one you used to create the VM, you can find them in the `.tfvars` files and your Terraform output.)
2. Clone this repo to your machine- `git clone https://github.com/ItayDevops/Weight-Tracker-APP-Ansible`.
3. [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)
4. Run the command `export ANSIBLE_HOST_KEY_CHECKING=False` to enable connection to the hosts machines with user name and password.
5. Add the file `inventory`. The file should contain this data:
    ```
    <vm1 ip> host="<vm1 ip>"
    <vm2 ip> host="<vm2 ip>"
    etc...


You should add this file to your `.gitigonre` because it contains secret data.
(The user name and password are the same as the one you used to create the VM, you can find them in the `.tfvars` files on your Terraform pfoject, or in the terraform output)

6. In `ansible` directory add the file `vars`. This file should contain this data:
    ```
    # the host variable is in the inventory file
    pghost: "<your postgresql service address>
    pg_username: "<postgresql username>"
    pg_password: "<postgresql password>"
    LB_ip: "<your load balancer public ip address>"
    okta_url: "<your okta url>"
    okta_client_id: "<your okta client id>"
    okta_client_secret: "<your okta client secret>"
    ansible_connection: "ssh"
    ansible_port: "22"
    ansible_user: "<user name>" 
    ansible_ssh_pass: "<password>"

You should add this file to your `.gitigonre` because it contains secret data.
(The postgres user name and password are the same as the one you used to create the service, you can find them in the `.tfvars` files on your Terraform pfoject, or in the terraform output)

7. Add the load balancer public ip to your okta app sign-in redirect URIs.

8. Run the command `ansible-playbook -i inventory weightTrackerPlayBook.yaml`.
