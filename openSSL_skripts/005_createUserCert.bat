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

		
	ECHO PKI-X509 - Create user certificates
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

    SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:

    ECHO # Now please choose the name of your new client certificate (e.g. 'myClientCert').
	SET /P _CERTNAME= Type, then press ENTER:

    ECHO # Now please choose the name of the owner of the certificate (e.g. 'John Doe').
	SET /P _CNNAME= Type, then press ENTER:


    ::  Create a client certificate :: 
    ECHO.
	ECHO # Creating a client certificate ..  
    cd /d %_ROOTPATH%

     ::  Create a key pair :: 
    openssl genrsa  -out %_INTER%\private\%_CERTNAME%.key.pem 2048

    :: Multivalued: "/C=DE/serialNumber=$SERIALNUMBER+GN=$VORNAME+SN=$NACHNAME+CN=$VORNAME $NACHNAME"

    :: Create a CSR (Certificate Signing Request)
    openssl req -config %_INTER%\%_INTERCONFIG%  -multivalue-rdn -subj "/C=DE/ST=Deutschland/CN=%_CNNAME%"  -key %_INTER%\private\%_CERTNAME%.key.pem  -new -sha256 -out %_INTER%\csr\%_CERTNAME%.csr.pem

    :: Sign a certificate, based on the CSR
    openssl ca -config %_INTER%\%_INTERCONFIG%  -extensions usr_cert -days 375 -notext -md sha256  -in %_INTER%\csr\%_CERTNAME%.csr.pem  -out %_INTER%\certs\%_CERTNAME%.cert.pem

    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
	ECHO.	  

pause
