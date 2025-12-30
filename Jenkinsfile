pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
        SONARQUBE = 'SonarQube-Server' 
        DOCKER_SERVER = 'ubuntu@172.31.26.188' 
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
                    // Tool name must match exactly what you saved in Manage Jenkins -> Tools
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=portfolio-cloud \
                        -Dsonar.projectName=portfolio-cloud \
                        -Dsonar.sources=.
                        """
                    }
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                sshagent(['docker-server-ssh']) { 
                    sh """
                    # 1. Copy files to Docker Server
                    scp -o StrictHostKeyChecking=no portfolio.html Dockerfile ${DOCKER_SERVER}:/home/ubuntu/
                    
                    # 2. Build and Run on Docker Server
                    ssh -o StrictHostKeyChecking=no ${DOCKER_SERVER} '
                        cd /home/ubuntu/
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