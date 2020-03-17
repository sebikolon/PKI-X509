# PKI-X509
This repository contains *ready-to-run* batch scripts.

 Use them to create **your own PKI (Public Key Infrastructure)** including 
 - Creation of **Root-CA** (issues the Intermediate CA)
 - Creation of *several* **Intermediate-CAs** (issues server/client/OCSP certificates)
 - Running an **OCSP**-Responder (Incl. checking the validity of certificates)
 - Issuing **Server/Client** certificates
 - **Converting** certificates from *PEM* to *CRT* format
 - **Revoking** certificates using an OCSP responder or a CRL (Certificate Revocation List)
 - Creating **#PKCS12 keystores** including certificates and the entire *trust of chain*

Your *Intermediate CA* is capable to issue as many client certificates as desired. Of course you can create **several** Intermediate CAs in order to structure your PKI!
 
 Please make sure to keep your private keys (Especially Root-CA and Intermediate CAs) **top-secret**.

## Prerequisites
The batch scripts are using a Windows portation of [OpenSSL](https://www.openssl.org/).

1.  Download it [Win32 OpenSSL v1.1.1.d.exe](https://slproweb.com/download/Win32OpenSSL-1_1_1d.exe "Win32 OpenSSL v1.1.1.d") and install it
 
2. Make sure to add the *bin* path to your user/system PATH variable: `C:\Program Files (x86)\OpenSSL-Win32\bin` so the scripts can find your openSSL binary

## Configuration
The files

- `openssl.cfg`
- `openssl_inter.cfg`

must be adjusted before creating the PKI at the following places:

`openssl.cfg`:
```
  [ ROOTCA ]
  dir = C:/<path_to_your_pki_dir>
  [ req_distinguished_name ]
  0.organizationName_default  = MyEmployer
  [ usr_cert ]
  nsComment = "MyComment"
  [ server_cert ]
  nsComment = "MyComment"
```

`openssl_inter.cfg`:
```
  [ INTERMEDIATECA ]
  dir = C:/<path_to_your_pki_dir>/intermediate
  [ req_distinguished_name ]
  0.organizationName_default  = MyEmployer
  [ usr_cert ]
  nsComment = "MyComment"
  [ server_cert ]
  nsComment = "MyComment"
  crlDistributionPoints = URI:https://url/to/intermediate.crl.pem
  ```
  
If you want to use **Multivalued-RDNs**, add them in file `openssl_inter.cfg`:
```
[ policy_loose ]
newAttribute = optional
```

## Usage
The scripts are sorted by their prefixes. 

*Setup your PKI* by executing the scripts *000_* to *003_* one-by-one. Take care when running them again within the same base folder - you will overwrite existing files!

The remaining scripts can be run as often as you want to.
