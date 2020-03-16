::
:: ***************************************************************************************
::
::		sebikolon PKI-X509
::		https://sbuechler.de
::		https://github.com/sebikolon/PKI-X509
::
::		Last Release: 16 March 2020	
::
:: ***************************************************************************************
::

@ECHO OFF

		
	ECHO PKI-X509 - Prepare Certification Authority (CA)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

    SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:

    ECHO # Now please choose the name of your new server certificate (e.g. 'myServerCert').
	SET /P _CERTNAME= Type, then press ENTER:

    ::  Create a server certificate :: 
    ECHO.
	ECHO # Creating a server certificate ..    
    cd %_BASISPFAD%

    :: Workaround: Create an 'index.txt.attr' file
    echo unique_subject = yes/no > %_INTER%\index.txt.attr

    :: Create a key pair
    openssl genrsa  -out %_INTER%\private\%_CERTNAME%.key.pem 2048
    :: Create a CSR (Certificate Signing Request)
    openssl req -config %_INTER%\%_INTERCONFIG%  -key %_INTER%\private\%_CERTNAME%.key.pem  -new -sha256 -out %_INTER%\csr\%_CERTNAME%.csr.pem
    :: Sign a certificate, based on the CSR
    openssl ca -config %_INTER%\%_INTERCONFIG%  -extensions server_cert -days 375 -notext -md sha256  -in %_INTER%\csr\%_CERTNAME%.csr.pem  -out %_INTER%\certs\%_CERTNAME%.cert.pem

    ::  Create a CRL (Certificate Revocation List) :: 
    ECHO # Creating a CRL (Certificate Revocation List) ..
    if exist %_INTER%\crlnumber (
        ECHO # CRL already exists. Skipping ..	    
    ) else (        
        echo 1000 > %_INTER%\crlnumber
        openssl ca -config %_INTER%\%_INTERCONFIG%  -gencrl -out %_INTER%\crl\intermediate.crl.pem
    )

    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
	ECHO.
	ECHO # Now you can proceed by creating client certificates!
	ECHO.    

pause
