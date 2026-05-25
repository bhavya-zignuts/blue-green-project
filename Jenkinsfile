// pipeline {

//     agent any

//     environment {
//         DOCKER_HUB = 'bhavyatank13'
//         IMAGE_TAG = "${BUILD_NUMBER}"
//         APP_SERVER = 'ubuntu@13.201.98.127'
//     }

//     stages {

//         stage('Build Frontend Image') {
//             steps {
//                 sh '''
//                 docker build -t $DOCKER_HUB/frontend-app:$IMAGE_TAG ./frontend
//                 '''
//             }
//         }

//         stage('Build Backend Image') {
//             steps {
//                 sh '''
//                 docker build -t $DOCKER_HUB/backend-app:$IMAGE_TAG ./backend
//                 '''
//             }
//         }

//         stage('Docker Login') {
//             steps {

//                 withCredentials([
//                     usernamePassword(
//                         credentialsId: 'dockerhub-creds',
//                         usernameVariable: 'DOCKER_USER',
//                         passwordVariable: 'DOCKER_PASS'
//                     )
//                 ]) {

//                     sh '''
//                     echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
//                     '''
//                 }
//             }
//         }

//         stage('Push Frontend Image') {
//             steps {
//                 sh '''
//                 docker push $DOCKER_HUB/frontend-app:$IMAGE_TAG
//                 '''
//             }
//         }

//         stage('Push Backend Image') {
//             steps {
//                 sh '''
//                 docker push $DOCKER_HUB/backend-app:$IMAGE_TAG
//                 '''
//             }
//         }

//     }
// }




pipeline {

    agent any

    environment {
        DOCKER_HUB = 'bhavyatank13'
        IMAGE_TAG = "${BUILD_NUMBER}"
        APP_SERVER = 'ubuntu@13.201.98.127'
    }

    stages {

        stage('Build Frontend Image') {
            steps {
                sh '''
                docker build -t $DOCKER_HUB/frontend-app:$IMAGE_TAG ./frontend
                '''
            }
        }

        stage('Build Backend Image') {
            steps {
                sh '''
                docker build -t $DOCKER_HUB/backend-app:$IMAGE_TAG ./backend
                '''
            }
        }

        stage('Docker Login') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {

                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh '''
                docker push $DOCKER_HUB/frontend-app:$IMAGE_TAG
                '''
            }
        }

        stage('Push Backend Image') {
            steps {
                sh '''
                docker push $DOCKER_HUB/backend-app:$IMAGE_TAG
                '''
            }
        }

        stage('Deploy Green') {
            steps {

                sh """
                ssh -o StrictHostKeyChecking=no $APP_SERVER '

                export TAG=$IMAGE_TAG

                cd /opt/blue-green-deployment

                docker compose -f docker-compose.green.yml up -d
                '
                """
            }
        }

        stage('Health Check') {
            steps {

                sh """
                ssh -o StrictHostKeyChecking=no $APP_SERVER '

                sleep 10

                curl -f http://localhost:3002/health
                '
                """
            }
        }

        stage('Switch Traffic') {
            steps {

                sh """
                ssh -o StrictHostKeyChecking=no $APP_SERVER '

                sudo cp /opt/blue-green-deployment/nginx/green.conf /etc/nginx/sites-available/default

                sudo nginx -t

                sudo systemctl reload nginx
                '
                """
            }
        }

        stage('Remove Blue') {
            steps {

                sh """
                ssh -o StrictHostKeyChecking=no $APP_SERVER '

                docker rm -f frontend-blue backend-blue || true
                '
                """
            }
        }
    }
}