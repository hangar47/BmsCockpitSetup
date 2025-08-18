pipeline {
  agent  { label 'cloud-arm64' }
  stages {
    stage('Create Package') {
      steps {
        dir("bms-cockpit") {
          sh '''
            if [ "$SNAPSHOT" = "1" ]; then
                SNAP=$(date -u +%Y%m%dT%H%M%SZ)
                GIT_SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "nogit")
                VERSION="~dev.${SNAP}.${GIT_SHA}"
            else
                VERSION=""
            fi

            sed "s/@VERSION@/${VERSION}/" DEBIAN/control.in > DEBIAN/control
            chmod 755 DEBIAN/postinst DEBIAN/postrm DEBIAN/prerm
          '''
        } 
        sh '''
          set -e
          dpkg-deb --build bms-cockpit
        '''        
      }
    }
    stage('Publish Package') {
//       when {
//         expression {
//           return env.BRANCH_NAME == 'develop' || env.BRANCH_NAME == 'master'
//         }
//       }
      steps {
        dir("build") {
          sh '''
            set -e
            DEB_FILE=$(ls -1 *.deb | head -n1)
            echo "Found package: $DEB_FILE"
            sudo -u jenkins -H bash -lc '
              aptly mirror update gtiremote
              aptly repo import gtiremote gtirepo "Name (~ .*)"
              aptly repo add gtirepo "'"$DEB_FILE"'"
              aptly -passphrase-file=/home/jenkins/gpg_sec.txt publish update bookworm s3:gtirepo:
            '
          '''
        }
      }
    }
  }
}
