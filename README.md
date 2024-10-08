#  Blue/Green 배포
## Blue/Green 배포 란?

**설명**:

-   **두 개의 환경**: 두 개의 환경(블루와 그린)을 운영하여, 한 환경에서는 현재 버전이 실행되고, 다른 환경에서는 새 버전이 실행됩니다.
-   **트래픽 전환**: 새 버전의 테스트가 완료된 후, 트래픽을 기존 환경에서 새 환경으로 전환하여 사용자에게 새 버전을 제공합니다.

**장점**:

-   **간단한 롤백**: 문제가 발생하면 트래픽을 기존 환경으로 쉽게 되돌릴 수 있어 롤백이 간단합니다.
-   **테스트 용이**: 새로운 버전이 완전히 테스트된 후 트래픽을 전환할 수 있어 안정성이 높습니다.

**단점**:

-   **자원 소모**: 두 개의 환경을 동시에 운영하므로 자원이 두 배로 소모될 수 있습니다.
-   **배포 비용**: 인프라를 두 배로 유지해야 하므로 비용이 증가할 수 있습니다.

**배포**:

-   **블루 환경**: 현재 운영 중인 버전의 시스템.
-   **그린 환경**: 새 버전이 배포된 테스트 환경.
-   트래픽이 블루 환경에서 그린 환경으로 전환됩니다.
-   문제 발생 시, 트래픽을 블루 환경으로 다시 전환할 수 있습니다.

| **초기 상태:** |  |  |  |  |
| --- | --- | --- | --- | --- |
| **\[ 블루 환경 (구 버전) \]** | **←** | **트래픽** | **→** | **\[ 사용자 \]** |
| **배포 중:** |  |  |  |  |
| **\[ 블루 환경 (구 버전) \]** | **←** | **일부 트래픽** | **→** | **\[ 사용자 \]** |
| **\[ 그린 환경 (신 버전) \]** | **←** | **일부 트래픽** | **→** | **\[ 사용자 \]** |
| **배포 완료:** |  |  |  |  |
| **\[ 그린 환경 (신 버전) \]** | **←** | **트래픽** | **→** | **\[ 사용자 \]** |

## 파일 구조
```shell
blue-green
    │   # 실제 배포 Shell 파일
    ├─  deploy.sh 
    │   # 이미지 생성 Dockerfile
    ├─  Dockerfile 
    │   # docker-compose
    ├─  docker-compose.blue.yml 
    ├─  docker-compose.green.yml
    │   # nginx.conf 파일
    ├─  nginx-blue.conf
    ├─  nginx-green.conf
    │   # Gradle 파일
    ├─  build.gradle.kts
    ├─  logs
    │     ├─ blue-green.log
    │     └─ blue-green.log.2024-09-07.0.gz
    ├─src
    │  ├─ main
    │  │  └─ kotlin
    │  │      └─ com
    │  │          └─ bg
    │  │              └─ bluegreen
    │  │                  ├─  BlueGreenApplication.kt
    │  │                  └─  controller
    │  │                        └─ IndexController.kt
    │  └─resources
    │      ├─ application.yml
    │      ├─ static
    │      └─ templates
    └─test
        └─ kotlin
            └─ com
              └─ bg
                  └─ bluegreen
                      └─  BlueGreenApplicationTests.kt
```
