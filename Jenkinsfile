pipeline {
    agent any
    environment {
        TEST_HOST = "${params.HOST}"
        TEST_USER = "${params.USER_NAME}"
        TEST_PASS = "${params.USER_PASS}"
    }

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                echo "Deploying Ceph Node Pre-reqs on: $TEST_HOST"
                sh '''#!/usr/bin/env bash
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST cat /root/test_jenkins
                // Stop Autofs and Puppet
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOSTsystemctl stop autofs.service puppet.service
                // Stop Autofs and Puppet
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOSTsystemctl disable autofs.service puppet.service
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Verifying...'
                echo "Verifying Ceph Node Pre-reqs on: $TEST_HOST"
                sh '''#!/usr/bin/env bash
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST cat /root/test_jenkins
                // Testing if services are stopped
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOSTsystemctl status autofs.service puppet.service
                '''
            }
        }
        
    }
}
