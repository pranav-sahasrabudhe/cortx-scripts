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
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST systemctl stop autofs.service puppet.service
                // Stop Autofs and Puppet
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST systemctl disable autofs.service puppet.service
                // Create teuthology user
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST sudo adduser teuthology --gecos "Teuthology,1,2,3" --disabled-password
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST echo "teuthology:seagate1" | sudo chpasswd
                // Create teuthworker user
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST sudo adduser teuthworker --gecos "Teuthworker,4,5,6" --disabled-password
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST echo "teuthworker:seagate1" | sudo chpasswd
                // chapsswd for default Ubuntu user
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST echo "ubuntu:seagate1" | sudo chpasswd
                // Run perl command for fstab attrib
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST 'perl -pe 'if (m{^([^#]\\S*\\s+/\\s+\\S+\\s+)(\\S+)\(\\s+.*)$}) { $_="$1$2,user_xattr$3\\n" unless $2=~m{(^|,)user_xattr(,|$)}; }' -i.bak /etc/fstab'
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
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST systemctl status autofs.service puppet.service
                '''
            }
        }
        
    }
}
