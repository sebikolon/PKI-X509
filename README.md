# PKI-X509
This repository contains *ready-to-run* batch scripts.

 Use them to create **your own PKI (Public Key Infrastructure)** including 
 - Creation of **Root-CA** (issues the Intermediate CA)
 - Creation of *several* **Intermediate-CAs** (issues server/client/OCSP certificates)
 - Issuing **Server/Client** certificates (By default in *.pem* format)
 - Creation of an **OCSP**-Responder (Incl. checking the validity of certificates)
 - **Converting** certificates from *.pem* to *.crt* format
 - **Revoking** certificates using an OCSP responder or a CRL (Certificate Revocation List)
 - Creating **#PKCS12 keystores** including certificates and the entire *trust of chain*

Hint: In the scripts, server and client/user certificates will all be issued by the *Intermediate CA* (not directly by the root CA). 
The *Intermediate CA* is capable to issue as many client/user certificates as desired. Of course, **several** *Intermediate CA*s can be created in order to structure your PKI in a more granular way!
 
 Please make sure to keep your private keys (Especially Root-CA and Intermediate CAs) **top-secret** all the time.

## Prerequisites
The batch scripts are using a Windows portation of [OpenSSL](https://www.openssl.org/).

1.  Download the latest version (e.g. [Win64 OpenSSL v3.0.3 Light](https://slproweb.com/products/Win32OpenSSL.html "Win64 OpenSSL")) and install it
 
2. Make sure to add the *bin* path to your user/system PATH variable: `C:\Program Files (x86)\OpenSSL-Win64\bin` so the scripts are able to detect your openSSL binary on runtime

## Configuration
The files

- `openssl.cfg`
- `openssl_inter.cfg`

contain default values which are required for *OpenSSL* to work. They might be adjusted before creating the PKI. Apply your changes at least the following places:

`openssl.cfg` (will issue only the *Intermediate CA*):
```
  [ req_distinguished_name ]
  0.organizationName_default  = myCompany
```

`openssl_inter.cfg` (will issue server/client certificates):
```
  [ req_distinguished_name ]
  0.organizationName_default  = myCompany
  [ usr_cert ]
  nsComment = "User certificate"
  [ server_cert ]
  nsComment = "Server certificate"
  crlDistributionPoints = URI:https://url/to/intermediate.crl.pem
  ```
  
Optional: If you want to use **Multivalued-RDNs**, add them in file `openssl_inter.cfg`:
```
[ policy_loose ]
newAttribute = optional
```

## Usage
The scripts are sorted by their prefixes.

Start *setting up your PKI* by executing the scripts *000_* to *003_* one-by-one. Take care when running them again within the same root folder - you will overwrite existing files!

The otherö scripts can be run as often as you want to, e.g. to issue 1 server and several user certificates, or to revoke them.
