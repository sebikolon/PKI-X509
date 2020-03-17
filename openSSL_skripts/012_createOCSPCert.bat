::
:: ***************************************************************************************
::
::		sebikolon PKI-X509
::		https://sbuechler.de
::		https://github.com/sebikolon/PKI-X509
::
::		Last Release: 17 March 2020	
::
:: ***************************************************************************************
::

@ECHO OFF

		
	ECHO PKI-X509 - Create an OCSP responder certificate
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

 	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:

    ECHO # Now please choose the name of the OCSP responder certificate (e.g. 'ocsp.myDomain.com').
	SET /P _CERTNAME= Type, then press ENTER:


    :: Create an OCSP responder certificate :: 
    ECHO.
    ECHO # Creating an OCSP responder certificate ..
    cd %_BASISPFAD%

    :: Create a key pair
    openssl genrsa -aes256 -out %_INTER%/private/%_CERTNAME%.key.pem 4096

    :: Create a CSR
    openssl req -config %_INTER%/%_INTERCONFIG% -new -sha256      -key %_INTER%/private/%_CERTNAME%.key.pem  -out %_INTER%/csr/%_CERTNAME%.csr.pem
	  
    :: Sign the OCSP certificate, based on the CSR
    openssl ca -config %_INTER%/%_INTERCONFIG%       -extensions ocsp -days 375 -notext -md sha256       -in %_INTER%/csr/%_CERTNAME%.csr.pem       -out %_INTER%/certs/%_CERTNAME%.cert.pem
	  
    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
    ECHO # The converted certificate was stored here: '%_INTER%/certs/%_CERTNAME%.cert.pem'
	ECHO.	  

 pause
