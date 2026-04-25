pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                sh 'docker build -t backend-app ./backend'
            }
        }

        stage('Deploy') {
            steps {
                sh 'kubectl apply -f k8s/'
                sh 'kubectl rollout status deployment/backend'
            }
        }
    }

    post {
        success {
            echo '✅ Deploy exitoso'
        }
        failure {
            echo '❌ Pipeline fallido'
        }
    }
}