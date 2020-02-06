@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate

echo Führen Sie dieses Skript für jedes Zertifikat aus, für das Sie einen Keystore erhalten möchten.

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Erstellen Sie einen Keystore für das entsprechende Schlüsselpaar. Geben Sie den Namen des zuvor erstellen Zertifikats an (Z.B. server):
SET /P _KEYSTORENAME= Geben Sie den Namen des neuen Keystores an:

cd %_BASISPFAD%

::  Erstellen eines PKCS12 Keystores :: 
echo #### Erstellen eines PKCS12 Keystores und Konvertierung zu JKS #### 

if exist %_INTER%\keystores (
	echo Verzeichnis bereits vorhanden.
) else (
    mkdir %_INTER%\keystores
	echo Verzeichnis wurde erstellt.
)

openssl pkcs12 -export -in %_INTER%\certs\%_CERTNAME%.cert.pem -inkey %_INTER%\private\%_CERTNAME%.key.pem -chain -CAfile %_INTER%\certs\ca-chain.cert.pem -name %_KEYSTORENAME% -out %_INTER%\keystores\%_KEYSTORENAME%.p12


::  Erstellen eines Java-Keystores auf Basis des .p12-Keystores :: 
 "c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" -importkeystore -destkeystore %_INTER%\keystores\%_KEYSTORENAME%.jks -srckeystore %_INTER%\keystores\%_KEYSTORENAME%.p12 -srcstoretype PKCS12

:: Import der CA Trust Chain
"c:\Program Files\Java\jre1.8.0_172\bin\keytool.exe" -import -file %_INTER%\certs\ca-chain.cert.pem -alias ca-chain -keystore %_INTER%\keystores\%_KEYSTORENAME%.jks
 
:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%
 
 echo Erfolg!

 pause