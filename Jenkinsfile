pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zaidqureshi3111995/portfolio-cloud'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: "${REPO_URL}", credentialsId: 'github-credentials'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "SonarQube Stage (will configure later)"
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                echo "Docker Stage (will configure later)"
            }
        }
    }

    post {
        success {
            echo 'Build Success!'
        }
        failure {
            echo 'Build Failed!'
        }
    }
}
