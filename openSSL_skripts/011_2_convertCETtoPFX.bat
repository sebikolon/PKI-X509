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

		
	ECHO PKI-X509 - Convert certificate from .CET to .PFX
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

 	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:

    ECHO # Now please choose the name of the certificate to be converted (e.g. 'myClientCert').
	SET /P _CERTNAME= Type, then press ENTER:


    :: Convert the certificate from CET to PFX :: 
    ECHO.
    ECHO # Converting the certificate from .CET to .PFX ..

    openssl pkcs12 –export -out %_ROOTPATH%\%_INTER%\certs\%_CERTNAME%.PFX –inkey %_ROOTPATH%\%_INTER%\private\%_CERTNAME%.key -in %_ROOTPATH%\%_INTER%\certs\%_CERTNAME%.cer 

    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
    ECHO # The converted certificate was stored here: '%_ROOTPATH%\%_INTER%\certs\%_CERTNAME%.PFX'
	ECHO.	  

 pause