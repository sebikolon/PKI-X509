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

		
	ECHO PKI-X509 - Prepare INTERMEDIATE Certification Authority (CA)
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.
	
	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate
    SET _INTERCONFIG=openssl_inter.cfg
	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _BASISPFAD= Type, then press ENTER:

    ::  Create an intermediate CA ::
    ECHO.
	ECHO # Creating INTERMEDIATE CA and according files ..    
    mkdir %_BASISPFAD%\%_INTER%
    cd %_BASISPFAD%\%_INTER%
    
    if exist certs (
		echo    '%_BASISPFAD%\%_INTER%\certs' already exists. Skipping .. 
	) else (
		mkdir certs
	)
	
	if exist crl (
		echo    '%_BASISPFAD%\%_INTER%\crl' already exists. Skipping .. 
	) else (
		mkdir crl
	)
	
	if exist newcerts (
		echo    '%_BASISPFAD%\%_INTER%\newcerts' already exists. Skipping .. 
	) else (
		mkdir newcerts
	)
	
	if exist private (
		echo    '%_BASISPFAD%\%_INTER%\private' already exists. Skipping .. 
	) else (
		mkdir private
	)
	
	if exist csr (
		echo    '%_BASISPFAD%\%_INTER%\csr' already exists. Skipping .. 
	) else (
		mkdir csr
	)

	:: Container that holds PKI structure
	if exist index.txt (
		echo    '%_BASISPFAD%\%_INTER%\index.txt' already exists. Skipping .. 
	) else (
		type NUL > index.txt
	)
	
	:: File that holds latest serial number
	if exist serial (
		echo    '%_BASISPFAD%\%_INTER%\serial' already exists. Skipping .. 
	) else (
		echo 01 > serial
	)    

    :: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
	ECHO.
	ECHO # In order to proceed, please copy the file ''%_INTERCONFIG%' into folder '%_BASISPFAD%\%_INTER%' and adjust the paths within this file!
	ECHO.    

pause