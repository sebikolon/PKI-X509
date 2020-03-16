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
	

	if exist %_BASISPFAD%\%_INTER%\%_INTERCONFIG% (		
		cd %_BASISPFAD%
		
		ECHO.
		ECHO # Creating INTERMEDIATE CA ..
		ECHO # Do NOT forget to define a commonName (CN)! ..				
		::  Create key
		openssl genrsa -aes256 -out %_INTER%\private\intermediate.key.pem 4096
		::  Create CSR 
		openssl req -config %_INTER%\%_INTERCONFIG% -new -sha256  -key %_INTER%\private\intermediate.key.pem  -out %_INTER%\csr\intermediate.csr.pem
		::  Sign CSR by Root CA 
		openssl ca -config openssl.cfg -extensions v3_intermediate_ca -days 3650 -notext -md sha256  -in %_INTER%\csr\intermediate.csr.pem  -out %_INTER%\certs\intermediate.cert.pem

		::  Create a Chain Of Trust :: 
		ECHO.
		ECHO # Creating a CHAIN OF TRUST ..		
		type %_INTER%\certs\intermediate.cert.pem certs\ca.cert.pem > %_INTER%\certs\ca-chain.cert.pem
		
		ECHO    .. OK!
		ECHO.
		ECHO # Now you are able to create SERVER and CLIENT certificates and sign them with your INTERMEDIATE CA!
		ECHO.  	
		
	) else (
		ECHO    .. Error! File '%_BASISPFAD%\%_INTER%\%_INTERCONFIG%' does not exist or is missing valid paths!
		ECHO.
		ECHO # Please try again.		
	)

 :: Go back to original directory
	cd %_ORIGINDIR%
	
	  

pause


