# Dockerfile source code for windows based container with SQL Server 2019 support (simple)

The base docker image: mcr.microsoft.com/windows/servercore:ltsc2019

## What Dockerfile does:

Dockerfile installs Windows Server ltsc2019 image as container base. After that the only thing that happen is install of Windows SQL Server 2019 (Developer, Enterprise edition). 


1.) Create diretory
```powershell
mkdir custom-mssql-win-server
cd custom-mssql-win-server
```

Pull code from gihub:
```powershell
git clone https://github.com/krregg/docker-mssql19-win-server.git
```

Build image
```powershell
docker build -t repo/name:version .
```

Create and test container
```powershell
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Password02!" -p 1433:1433 --name sql -d -h sql repo/name:version
```

Get container IP address
```powershell
$ipconfig = docker exec sql ipconfig
$ipconfig.Get(8).split()[-1]
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
