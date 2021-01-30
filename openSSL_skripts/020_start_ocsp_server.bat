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

		
	ECHO PKI-X509 - Start the OCSP responder
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

    SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:

    ECHO # Now please type the name of the previously created OCSP responder certificate (e.g. 'ocsp.myDomain.com').
	SET /P _OCSPCERT= Type, then press ENTER:

    ECHO # Now please type the port number which should be assigned to the OCSP responder service (e.g. '2560').
	SET /P _PORT= Type, then press ENTER:


    :: Starting the OCSP responders service :: 
    ECHO.
    ECHO # Starting the OCSP responders service ..
    ECHO # .. Do NOT close this window! ..

    openssl ocsp -index %_ROOTPATH%\%_INTER%\index.txt -port %_PORT% -rkey %_ROOTPATH%\%_INTER%\private\%_OCSPCERT%.key.pem -rsigner %_ROOTPATH%\%_INTER%\certs\%_OCSPCERT%.cert.pem -CA %_ROOTPATH%\%_INTER%\certs\ca-chain.cert.pem -text 


    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!        
	ECHO.	  

 pause

