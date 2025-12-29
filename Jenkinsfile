pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
        SONARQUBE = 'SonarQube-Server'             // Jenkins me configured SonarQube server name
        DOCKER_SERVER = 'ubuntu@<DOCKER_PUBLIC_IP>' // Docker EC2 public IP + user
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: "${REPO_URL}", credentialsId: 'github-credentials'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE}") {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                sshagent(['docker-credentials']) {  // Jenkins me add SSH key credentials for Docker server
                    sh """
                    ssh ${DOCKER_SERVER} '
                        cd /home/ubuntu
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

    post {
        success {
            echo '✅ Build, Test & Deploy Successful!'
        }
        failure {
            echo '❌ Build Failed!'
        }
    }
}
