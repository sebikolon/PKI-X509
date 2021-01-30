::
:: ***************************************************************************************
::
::		sebikolon PKI-X509
::		https://sbuechler.de
::		https://github.com/sebikolon/PKI-X509
::
::		Latest release: January 2021	
::
:: ***************************************************************************************
::

@ECHO OFF

		
	ECHO PKI-X509 - Check the OCSP status of a certificate against the OCSP responder.
    ECHO            This only works, if the OCSP responder service is running.
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

 	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:

    ECHO # Now please type the port number that the OCSP responder is listening to (e.g. '2560').
	SET /P _PORT= Type, then press ENTER:

    ECHO # Now please type the name of certificate which status you want to check (e.g. 'client').
	SET /P _CERTNAME= Type, then press ENTER:


    openssl ocsp -CAfile %_ROOTPATH%/%_INTER%/certs/ca-chain.cert.pem -url http://127.0.0.1:%_PORT% -resp_text  -issuer %_ROOTPATH%/%_INTER%/certs/intermediate.cert.pem  -cert %_ROOTPATH%/%_INTER%/certs/%_CERTNAME%.cert.pem

	ECHO.	  

 pause    