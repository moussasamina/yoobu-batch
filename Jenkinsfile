pipeline {
    agent any

    environment {
        YB_WP_DB_URL = credentials('wp-db-url')
        YB_LOGISTIC_DB_URL = credentials('logistic-db-url')
    }

    stages {
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
                    npm run build
                '''
            }
        }
        stage('Process') {
            steps {
                bat 'npm run sync:db'
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
