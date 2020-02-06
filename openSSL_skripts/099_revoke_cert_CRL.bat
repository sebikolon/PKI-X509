@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _CERTNAME= Geben Sie den Dateinamen des zu sperrenden Zertifikats an (Z.B. user01):

openssl ca -config %_BASISPFAD%\%_INTER%\%_INTERCONFIG% -revoke %_BASISPFAD%\%_INTER%\certs\%_CERTNAME%.cert.pem

::  Erneuern einer CRL :: 
echo #### Erneuern der CRL ####
openssl ca -config %_BASISPFAD%\%_INTER%\%_INTERCONFIG%  -gencrl -out %_BASISPFAD%\%_INTER%\crl\intermediate.crl.pem

:: Wechsle zurück zum Ursprungsverzeichnis
cd %_ORIGINDIR%

echo Erfolg!

pause