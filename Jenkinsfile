pipeline {
    agent any
    stages {
        stage('Base__RUN!') {
            steps {
                sh 'sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Qwerty-1" -p 1433:1433 --name 18_E_LEARN2 --hostname sql1 -d mcr.microsoft.com/mssql/server:2022-latest'
            }
        }
        stage('Docker-build-front') {
            steps {
                sh 'sudo docker build -t front .'
            }
        }
        stage('docker run front') {
            steps {
                sh 'sudo docker run -d -p 0.0.0.0:80:80 front'
            }
        }

    }
}
