pipeline {
    agent any

    environment {
        SONARQUBE = 'SonarQube-Server'
        DOCKER_SERVER = 'Docker-Server'
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Assuming SonarQube Scanner is configured in Jenkins
                withSonarQubeEnv('SonarQube-Server') {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                sshagent(['docker-credentials']) {
                    sh '''
                        ssh ubuntu@<DOCKER_SERVER_PUBLIC_IP> '
                        cd /home/ubuntu
                        docker build -t portfolio-app .
                        docker run -d -p 80:80 portfolio-app
                        '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build & Deploy Success!'
        }
        failure {
            echo 'Build Failed!'
        }
    }
}
