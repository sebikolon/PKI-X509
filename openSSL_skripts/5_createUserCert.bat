@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Geben Sie den Dateinamen des neuen Zertifikats an (Z.B. user01):
SET /P _PRAXIS= Geben Sie den Namen des Zertifikatsbesitzers an (Z.B. Praxis01):

::  Erstellen eines User-Zertifikats :: 
echo #### Erstellen eines User-Zertifikats ####
cd %_BASISPFAD%
:: Erstellen eines Schlüsselpaars
openssl genrsa  -out %_INTER%\private\%_CERTNAME%.key.pem 2048

:: Multivalued: "/C=DE/serialNumber=$SERIALNUMBER+GN=$VORNAME+SN=$NACHNAME+CN=$VORNAME $NACHNAME"

:: Erstellen einer CSR
openssl req -config %_INTER%\%_INTERCONFIG%  -multivalue-rdn -subj "/C=DE/ST=Deutschland/CN=%_PRAXIS%"  -key %_INTER%\private\%_CERTNAME%.key.pem  -new -sha256 -out %_INTER%\csr\%_CERTNAME%.csr.pem

:: Ausstellen eines Zertifikats auf Basis der CSR
openssl ca -config %_INTER%\%_INTERCONFIG%  -extensions usr_cert -days 375 -notext -md sha256  -in %_INTER%\csr\%_CERTNAME%.csr.pem  -out %_INTER%\certs\%_CERTNAME%.cert.pem

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg!

pause
