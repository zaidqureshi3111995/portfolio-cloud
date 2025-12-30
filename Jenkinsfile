pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
        SONARQUBE = 'SonarQube-Server'
        DOCKER_SERVER = 'ubuntu@<DOCKER_PUBLIC_IP>' 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: "${REPO_URL}"
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                sshagent(['docker-credentials']) { 
                    sh """
                    # 1. Copy files from Jenkins to Docker Server
                    scp -o StrictHostKeyChecking=no portfolio.html Dockerfile ${DOCKER_SERVER}:/home/ubuntu/
                    
                    # 2. Build and Run on Docker Server
                    ssh -o StrictHostKeyChecking=no ${DOCKER_SERVER} '
                        docker build -t portfolio-app .
                        docker stop portfolio-app || true
                        docker rm portfolio-app || true
                        docker run -d -p 80:80 --name portfolio-app portfolio-app
                    '
                    """
                }
            }
        }
    }
}