FROM mcr.microsoft.com/windows/servercore:ltsc2019

# copy installation files
ADD ./source/ c:/data/

# install MSSQL 2019
RUN C:/data/SQL2019/setup.exe /Q /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SECURITYMODE=SQL /SAPWD="Password02!" /SQLSVCACCOUNT="NT AUTHORITY\System" /AGTSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /IACCEPTSQLSERVERLICENSETERMS=1 /TCPENABLED=1 /UPDATEENABLED=False

# remove the sources
RUN powershell -Command (Remove-Item -Path C:/data/SQL2019/ -Recurse -Force) 

# set service to automatic
RUN powershell -Command (set-service MSSQLSERVER -StartupType Automatic)

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Copy Start.ps1 to image on root directory
ADD ./start.ps1 /

# Set current working directory for script execution
WORKDIR /
ENV SA_PASSWORD = "Password02!"
ENV ACCEPT_EULA = "Y"
ENV attach_dbs = "[{'dbName':'db','dbFiles': ['c:/data/source/BACKUP/db_Data.MDF', 'c:/data/source/BACKUP/db_Log.LDF']}]"

# run start.ps1
CMD ./start.ps1 -ACCEPT_EULA "Y" -Verbose