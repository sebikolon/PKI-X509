::
:: ***************************************************************************************
::
::		sebikolon PKI-X509
::		https://sbuechler.de
::		https://github.com/sebikolon/PKI-X509
::
::		Last Release: 06 March 2020	
::
:: ***************************************************************************************
::

@ECHO OFF

		
	ECHO PKI-X509 - Prepare Certification Authority (CA)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.


	SET _ORIGINDIR=%cd%
	ECHO # Please choose the new base directory, where all data belonging to your PKI will be stored (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:
	
	ECHO.
	ECHO # Creating directories and default files ..
	
	:: Create the base directory and sub folders
	if exist %_BASISPFAD% (
		echo    '%_BASISPFAD%' already exists. Skipping .. 
	) else (
		mkdir %_BASISPFAD%
	)
	cd /d %_BASISPFAD%
	
	if exist certs (
		echo    '%_BASISPFAD%\certs' already exists. Skipping .. 
	) else (
		mkdir certs
	)
	
	if exist crl (
		echo    '%_BASISPFAD%\crl' already exists. Skipping .. 
	) else (
		mkdir crl
	)
	
	if exist newcerts (
		echo    '%_BASISPFAD%\newcerts' already exists. Skipping .. 
	) else (
		mkdir newcerts
	)
	
	if exist private (
		echo    '%_BASISPFAD%\private' already exists. Skipping .. 
	) else (
		mkdir private
	)
	
	if exist csr (
		echo    '%_BASISPFAD%\csr' already exists. Skipping .. 
	) else (
		mkdir csr
	)

	:: Container that holds PKI structure
	if exist index.txt (
		echo    '%_BASISPFAD%\index.txt' already exists. Skipping .. 
	) else (
		type NUL > index.txt
	)
	
	:: File that holds latest serial number
	if exist serial (
		echo    '%_BASISPFAD%\serial' already exists. Skipping .. 
	) else (
		echo 01 > serial
	)


	:: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
	ECHO.
	ECHO # In order to proceed, please copy the file 'openssl.cfg' into folder '%_BASISPFAD%' and adjust the paths within this file!
	ECHO.

pause