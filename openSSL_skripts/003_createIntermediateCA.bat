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

		
	ECHO PKI-X509 - Create INTERMEDIATE Certificate Authority (CA)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:
	
	cd /d %_ROOTPATH%	

	if exist %cd%\%_INTER%\%_INTERCONFIG% (		
						
		ECHO.
		ECHO # Creating INTERMEDIATE CA ..
		::ECHO # Do NOT forget to define a commonName (CN) ..				
		ECHO CREATE key .. 
		::  Create key
		openssl genrsa -aes256 -out %cd%\%_INTER%\private\intermediate.key.pem 4096
		ECHO CREATE CSR ..
		::  Create CSR 
		openssl req -config %cd%\%_INTER%\%_INTERCONFIG% -new -sha256  -key %cd%\%_INTER%\private\intermediate.key.pem  -out %cd%\%_INTER%\csr\intermediate.csr.pem
		::  Sign CSR by Root CA 
		openssl ca -config openssl.cfg -extensions v3_intermediate_ca -days 3650 -notext -md sha256  -in %cd%\%_INTER%\csr\intermediate.csr.pem  -out %cd%\%_INTER%\certs\intermediate.cert.pem

		::  Create a Chain Of Trust :: 
		ECHO.
		ECHO # Creating a CHAIN OF TRUST ..		
		type %cd%\%_INTER%\certs\intermediate.cert.pem %cd%\certs\ca.cert.pem > %cd%\%_INTER%\certs\ca-chain.cert.pem
		
		ECHO    .. OK!
		ECHO.
		ECHO # Now you are able to create SERVER and CLIENT certificates and sign them with your INTERMEDIATE CA!
		ECHO.  	
		
	) else (
		ECHO    .. Error! File '%cd%\%_INTER%\%_INTERCONFIG%' does not exist or is missing valid paths!
		ECHO.
		ECHO # Please try again.		
	)

 :: Go back to original directory
	cd /d %_ORIGINDIR%
	
	  

pause


