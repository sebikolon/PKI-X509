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
		
		
	ECHO PKI-X509 - Prepare PKI structure and ROOT Certification Authority (CA)
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
		echo    '%cd%\certs' already exists. Skipping .. 
	) else (
		mkdir certs
	)
	
	if exist crl (
		echo    '%cd%\crl' already exists. Skipping .. 
	) else (
		mkdir crl
	)
	
	if exist newcerts (
		echo    '%cd%\newcerts' already exists. Skipping .. 
	) else (
		mkdir newcerts
	)
	
	if exist private (
		echo    '%cd%\private' already exists. Skipping .. 
	) else (
		mkdir private
	)
	
	if exist csr (
		echo    '%cd%\csr' already exists. Skipping .. 
	) else (
		mkdir csr
	)

	:: Container that holds PKI structure
	if exist index.txt (
		echo    '%cd%\index.txt' already exists. Skipping .. 
	) else (
		type NUL > index.txt
	)
	
	:: File that holds latest serial number
	if exist serial (
		echo    '%cd%\serial' already exists. Skipping .. 
	) else (
		echo 01 > serial
	)

	:: Copy ROOT CA config file
	xcopy /y %_ORIGINDIR%\openssl.cfg %cd%

	:: Replace placeholder path by valid path
	(for /f "tokens=* delims==" %%a in (%_ORIGINDIR%\openssl.cfg) do (
    if "%%a" == "dir               = C:/<path_to_your_pki_dir>" (
            echo dir               = %_BASISPFAD%

    ) else (
        echo %%a
    )    
	))> %cd%\openssl.cfg
	

	ECHO.
	ECHO    .. OK!
	ECHO # In order to proceed with the creation of the ROOT CA, please run next script!
	ECHO.

	:: Go back to original directory
	cd /d %_ORIGINDIR%
pause