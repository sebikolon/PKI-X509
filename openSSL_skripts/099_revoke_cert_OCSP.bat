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

		
	ECHO PKI-X509 - Revokes a signed certificate using an OCSP responder service (without a CRL)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

 	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:

    ECHO # Now please type the name of certificate which you want to revoke (e.g. 'client').
	SET /P _CERTNAME= Type, then press ENTER:


    :: Revoke the certificate
    ECHO.
    ECHO # Revoking the certificate ..
    openssl ca -config %_BASISPFAD%\%_INTER%\%_INTERCONFIG% -revoke %_BASISPFAD%\%_INTER%\certs\%_CERTNAME%.cert.pem

    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
    ECHO # The certificate ' %_BASISPFAD%\%_INTER%\certs\%_CERTNAME%.cert.pem' was revoked.
	ECHO.	  

 pause