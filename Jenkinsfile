pipeline {
    agent any

    environment {
        AWS_SERVER = "ubuntu@51.20.252.245"  // IP-адреса AWS-сервера
        APP_NAME = "myapp"  // Назва контейнера
        IMAGE_NAME = "myapp-image"  // Назва Docker-образу
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'git@github.com:mrden4ikkk/18_E_LEARN.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Save & Transfer Image') {
            steps {
                script {
                    sh "docker save ${IMAGE_NAME} | gzip > ${IMAGE_NAME}.tar.gz"
                    sh "scp -i /path/to/aws-key.pem ${IMAGE_NAME}.tar.gz ${AWS_SERVER}:/home/ubuntu/"
                }
            }
        }

        stage('Deploy on AWS') {
            steps {
                script {
                    sh """
                        ssh -i /path/to/aws-key.pem ${AWS_SERVER} << EOF
                        docker stop ${APP_NAME} || true
                        docker rm ${APP_NAME} || true
                        docker rmi ${IMAGE_NAME} || true
                        docker load < /home/ubuntu/${IMAGE_NAME}.tar.gz
                        docker run -d --name ${APP_NAME} -p 80:80 ${IMAGE_NAME}
                        EOF
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
