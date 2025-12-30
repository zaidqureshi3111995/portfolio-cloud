pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
        SONARQUBE = 'SonarQube-Server' // Manage Jenkins -> System mein yahi naam hona chahiye
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
                    // Check karo Tools mein name 'SonarQube Scanner' hi hai na?
                    def scannerHome = tool 'SonarQube Scanner'
                    withSonarQubeEnv("${SONARQUBE}") {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                // Humne jo ID credentials mein banayi thi wo use karo
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