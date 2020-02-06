# PKI-X509
This repository contains *ready-to-run* batch scripts.

 Use them to create **your own PKI (Public Key Infrastructure)** including Root-CA, Intermediate-CA, OCSP-Respnder and a client certificate generator. You can issue as many certificates as desired. 
 
 Please make sure to keep your private keys (Root-CA, Intermediate CA) **top-secret**.

## Configuration

The files

- `openssl.cfg`
- `openssl_inter.cfg`

must be adjusted before usage at the following places:


`openssl.cfg`:
```
  [ ROOTCA ]
  dir = c:/path_to_baseDir
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
  dir = c:/path_to_baseDir/intermediate
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
