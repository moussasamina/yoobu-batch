pipeline {
    agent any

    environment {
        // SAMINA_LOGISTIC_API_URL = credentials('samina-logistic-api-url')
        SAMINA_LOGISTIC_API_URL = '127.0.0.1:3001'
    }

    stages {
        stage('Checkout') {
            steps {
                git(
                    branch: 'main',
                    url: 'https://github.com/codeangel223/batch-sync-yb-db.git'
                )
            }
        }
        stage('Install') {
            steps {
                bat 'npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Démarrer les tests'
            }
        }
        stage('Build') {
            steps {
                bat '''
                    echo YOOBU_LOGISTIC_API_URL=http://%SAMINA_LOGISTIC_API_URL%/api/sync-db > .env
                    npm run build
                '''
            }
        }
        stage('Process') {
            steps {
                bat 'npm start'
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécuté avec succès.'
        }
        failure {
            echo 'Échec du pipeline.'
        }
    }
}
