# Terraform to create a Three zone OCP cluster on PowerVS
By using this automation you understand you will incur in costs of all deployed infrastructure done by the automation. It your fully responsibility to pay for these costs if using the code in this project.

IBM Power Systems Virtual Server (PowerVS) is a powerful and flexible platform for running enterprise workloads in the cloud. It combines the strengths of IBM Power Systems hardware with the agility and scalability of cloud computing. 
This projects helps you create an Openshift on 3 datacenters that are at least 10km apart from each other. This is something difficult to achieve on a normal active/DR datacenter or colo but can be achieved in PowerVS.
The Automation creates everything redundant on at least two zones, so you can be running even with an entire zone out.

## Prerequisites:
Before beginning the installation process, ensure that you have the following prerequisites:
You do not need to own a Power Server beforehand you create the cluster, the installation program and the terraform binaries will run on Linux, Mac on amd64 or arm64, besides the Linux on Power option. All tests were made on an amd64 Mac.

1) An active IBM Cloud account with access to PowerVS.
2) Sufficient resource quotas and permissions to create resource groups, authorizations, VPCs, load balancers, pDNS, PowerVS instances and network resources for this to work I would advise you to use an Admin account API key that can be destroyed right after deployment.
### If you are doing it with automatically the pre3zoneocp:
3) Clone the helper project on the parent directory together with 3zoneocp
4) Fix the variables (more on it on the next topic).
5) Run `terraform init` and then `terraform apply` on the pre3zoneocp.

### If you are doing it manually:
3) OpenShift's installation files and tools, including the OpenShift installer and command-line interface (CLI). Make sure you download it from the ppc64le mirror, even if installing from a windows or mac: https://mirror.openshift.com/pub/openshift-v4/ppc64le/clients/ocp/stable-4.12/
4) We do use proxy for this installation so be aware to add the proxy lines to your install-config.yaml file, make sure to bypass proxy with noProxy adding all the internal CIDRs and also add your internal network as appropriate. The proxy will be hardcoded as `http://proxy.<ClusterName>.<ClusterDomain>:8080` because we automated the creation of two proxies in two different zones, the load balancer for it, and the DNS entries needed so the installation occurs automatically. Bellow an example of the install-config.yaml file for this setup that matches with the default values existing in the vars.tf.

```
apiVersion: v1
baseDomain: example.com
proxy:
  httpProxy: http://proxy.ocp.example.com:8080
  httpsProxy: http://proxy.ocp.example.com:8080
  noProxy: .ocp.example.com,api.ocp.example.com,api-int.ocp.example.com,10.0.101.0/24,10.0.102.0/24,10.0.103.0/24,192.168.101.0/24,192.168.102.0/24,192.168.103.0/24
compute: 
- hyperthreading: Enabled 
  name: worker
  replicas: 3 
  architecture: ppc64le
controlPlane: 
  hyperthreading: Enabled 
  name: master
  replicas: 3 
  architecture: ppc64le
metadata:
  name: test 
networking:
  clusterNetwork:
  - cidr: 10.128.0.0/14 
    hostPrefix: 23 
  networkType: OVNKubernetes 
  serviceNetwork: 
  - 172.30.0.0/16
platform:
  none: {} 
fips: false 
pullSecret: '{"auths": ...}' 
sshKey: 'ssh-ed25519 AAAA...' 
```
5) Create the ignition files using "openshift-install" tool more info on this here:
   https://docs.openshift.com/container-platform/4.15/installing/installing_ibm_power/installing-ibm-power.html#installation-user-infra-generate-k8s-manifest-ignition_installing-ibm-power

If you don't know how to download it, look here: https://docs.openshift.com/container-platform/4.15/installing/installing_ibm_power/installing-ibm-power.html#installation-obtaining-installer_installing-ibm-power



## What do I need to change:
You only need to change the vars.tf file and, additionally if you prefer, you can create a "terraform.tfvars" file with your content that will be ignored by git on pushes and pulls.

You can change all CIDRs for the VPCs and PowerVS network, you can change the OpenShift version for the OVA image to be automatically downloaded into your PowerVS boot images. You can change the cluster name and domain for your cluster and as if it were on-premisses it does not need to be a valid domain to install to work, so it is also safe for PoCs, you just need to make sure the name resolution of the client accessing the cluster points correctly to the CNAMEs of the load balancers the client has access to. If you want a publicly available cluster you do need to use a domain you own and point the CNAME for the external load balancer after the installation finishes.

If you are using the pre3zoneocp, set your architecture and os, it does not matter if you are doing a manual ignition creation.

## To install
You can run `terraform init` and then `terraform apply`. The installation takes about 2h to finish. You will need to approve the Certificate signing requests just like any other UPI installs, if you don't know how to do it look here: https://docs.openshift.com/container-platform/4.15/installing/installing_ibm_power/installing-ibm-power.html#installation-approve-csrs_installing-ibm-power

If you prefer not to look at the docs, assuming you have the oc client on your path, you can try:
```
oc get csr |grep Pending |awk '{print $1}' |xargs oc adm certificate approve
```

If you have issues on the first run just do it once more. If it fails anyway destroy all with `terraform destroy` and retry the `terraform apply`

## After you install
Remove everything that we use for the bootstrap. The ignition will be automatically deleted in one day. But I do advise you to destroy these targets by the end of the installation:
```
terraform state rm module.ocp_inst_reboot_powervs1_ctr.ibm_pi_instance_action.reboot_non_worker\[\"bootstrap\"\]
terraform state rm module.powervs1.module.ocp_instance\[\"bootstrap\"\].ibm_pi_instance.instance
terraform destroy --target module.boot_ignition
```
After this commands you will have removed the cloud object storage and authorizations needed to download the bootstrap ignition and removed the bootstrap server from the terraform state. You can get to the IBM Cloud UI and just Delete the Bootstrap server, so you reduce your cost.
