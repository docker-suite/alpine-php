pipeline {

    agent { label 'docker-agent' }

    stages {
        stage ( "Building PHP 7.1") {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh "make build php=7.1 alpine=3.11"
                        sh "make push php=7.1"
                    }
                }
            }
        }

        stage ( "Building PHP 7.2") {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh "make build php=7.2 alpine=3.12"
                        sh "make push php=7.2"
                    }
                }
            }
        }

        stage ( "Building PHP 7.3") {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh "make build php=7.3 alpine=3.12"
                        sh "make push php=7.3"
                    }
                }
            }
        }

        stage ( "Building PHP 7.4") {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh "make build php=7.4 alpine=3.14"
                        sh "make push php=7.4"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'make remove'
            }
        }
        cleanup {
            cleanWs()
        }
    }
}
