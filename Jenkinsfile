pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    def buildTool = 'dotnet'
                    sh "${buildTool} build 18_E_LEARN.sln"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    def testTool = 'dotnet'
                    sh "${testTool} test 18_E_LEARN.sln"
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    def dockerImage = '18_e_learn_image'
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    def dockerImage = '18_e_learn_image'
                    sh "docker run -d -p 8080:80 ${dockerImage}"
                }
            }
        }
    }
}
