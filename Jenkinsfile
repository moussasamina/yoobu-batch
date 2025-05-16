pipeline {
    agent any

    environment {
        YB_WP_DB_URL = credentials('wp-db-url')
        YB_LOGISTIC_DB_URL = credentials('logistic-db-url')
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
<<<<<<< HEAD
=======
                    echo YOOBU_LOGISTIC_API_URL=%SAMINA_LOGISTIC_API_URL%/ > .env
>>>>>>> 7b846048d56ba0603a2ddd21a9864726d299b881
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
