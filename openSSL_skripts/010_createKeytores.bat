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

		
	ECHO PKI-X509 - Create PKCS12 keystores 
	ECHO Copyright MIT
	ECHO https://sbuechler.de
	ECHO.

 	SET _ORIGINDIR=%cd%
    SET _INTER=intermediate

	ECHO # Run this script for each certificate, you want to create a keystore for.

	ECHO # Please choose the base directory you defined before (e.g. 'C:\myPKI').
	SET /P _ROOTPATH= Type, then press ENTER:

    ECHO # Now please choose the name of your previously created client certificate (e.g. 'myClientCert').
	SET /P _CERTNAME= Type, then press ENTER:

    ECHO # Now please choose the name of the new keystore (e.g. 'myClientKeystore').
	SET /P _KEYSTORENAME= Type, then press ENTER:


	cd /d %_ROOTPATH%

	:: Create a new PKCS12 keystore :: 
	echo # Creating a PKCS12 keystore ..
	if exist %_INTER%\keystores (
		ECHO.
		echo # Directory '%_ROOTPATH%\%_INTER%\keystores' already exists ..
	) else (
		mkdir %_INTER%\keystores
		ECHO.
		echo # Directory '%_ROOTPATH%\%_INTER%\keystores' was successfully created ..
	)
	openssl pkcs12 -export -in %_INTER%\certs\%_CERTNAME%.cert.pem -inkey %_INTER%\private\%_CERTNAME%.key.pem -chain -CAfile %_INTER%\certs\ca-chain.cert.pem -name %_KEYSTORENAME% -out %_INTER%\keystores\%_KEYSTORENAME%.p12

	:: Create a Java keystore, based on the .p12 keystore ::
	if exist "c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" ( 
		ECHO.
		echo # Converting to a JKS keystore ..
	 	"c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" -importkeystore -destkeystore %_INTER%\keystores\%_KEYSTORENAME%.jks -srckeystore %_INTER%\keystores\%_KEYSTORENAME%.p12 -srcstoretype PKCS12
	) else (
		ECHO.
		ECHO # Tool 'keytool.exe' located under 'c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe' could not be found.
	)

	:: Import of the CA Trust Chain
	if exist "c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" ( 
		ECHO.
		echo # Importing the CA trust chain to the JKS keystore ..
		"c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" -import -file %_INTER%\certs\ca-chain.cert.pem -alias ca-chain -keystore %_INTER%\keystores\%_KEYSTORENAME%.jks
	) else (
		ECHO.
		ECHO # Tool 'keytool.exe' located under 'c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe' could not be found.
	)

	:: Go back to original directory
	cd %_ORIGINDIR%

	ECHO    .. OK!
	ECHO.	  

 pause