@ECHO OFF

SET _ORIGINDIR=%cd%
SET _INTER=intermediate
SET _INTERCONFIG=openssl_inter.cfg

SET /P _BASISPFAD= Geben Sie das zuvor angelegte Basisverzeichnis an (Z.B. C:\test):
SET /P _OCSPCERT= Geben Sie den Namen des zuvor erstellten OCSP-Zertifikat an (Z.B. 'ocsp.localhost'):
SET /P _PORT= Geben Sie den Port an, unter dem der OCSP-Responder erreichbar sein soll (Z.B. 2560):

:: Starten des OCSP-Responders :: 
echo #### Starten des OCSP-Responders #### 

openssl ocsp -index %_BASISPFAD%\%_INTER%\index.txt -port %_PORT% -rkey %_BASISPFAD%\%_INTER%\private\%_OCSPCERT%.key.pem -rsigner %_BASISPFAD%\%_INTER%\certs\%_OCSPCERT%.cert.pem -CA %_BASISPFAD%\%_INTER%\certs\ca-chain.cert.pem -text 
