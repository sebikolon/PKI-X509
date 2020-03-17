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

		
	ECHO PKI-X509 - Create ROOT Certification Authority (CA)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.
	
	SET _ORIGINDIR=%cd%
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:
	
	cd /d %_BASISPFAD%
	
	ECHO.
	ECHO # Creating ROOT CA and according files ..
	
	if exist openssl.cfg (
		
		REM if exist private/ca.key.pem (
		REM 	SET /P _OVERWRITECAKEY Do you really want to overwrite the existing private key of your ROOT CA [Y/N]?
		REM 	if %_OVERWRITECAKEY% NEQ N (
		REM 		:: Go back to original directory
		REM 		cd %_ORIGINDIR% 
		REM 		exit /b 0
		REM )
		openssl genrsa -aes256 -out private\ca.key.pem 4096	
		openssl req -config openssl.cfg  -key private\ca.key.pem  -new -x509 -days 7300 -sha256 -extensions v3_ca  -out certs\ca.cert.pem 
	
		ECHO.
		ECHO    .. OK!
		ECHO # In order to proceed with the creation of the intermediate CA, please run next script!
		ECHO.
	) else (
		ECHO    .. Error! File '%_BASISPFAD%\openssl.cfg' does not exist or is missing valid paths!
		ECHO.
		ECHO # Please try again.
		ECHO.
	)

	:: Go back to original directory
	cd %_ORIGINDIR%

pause



