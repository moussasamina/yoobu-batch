pipeline {
    agent any

    stages{
        stage("Checkout"){
            steps {
                echo 'REcupération'
            }
        }
        stage("Install"){
            steps {
                echo 'Installation des deps'
            }
        }
        stage("Test"){
            steps {
                echo 'Demarrer les tests'
            }
        }
        stage("Build"){
            steps {
                echo 'Build'
            }
        }
    }

    post{
        success{

        }
        failure{

        }
    }
}