@SET CURRENT_DATE=%date:~0,4%%date:~6,2%%date:~10,2%
REM @SET BUILD_TAG=nightly-%CURRENT_DATE%
REM @SET METADATA_TAG=%CURRENT_DATE%

@SET BUILD_TAG=20261001
@SET METADATA_TAG=20261001

@echo BUILD_TAG=%BUILD_TAG%
@echo METADATA_TAG=%METADATA_TAG% 
mvnw -B clean verify --file pom.xml -Dsysml.build-tag=%BUILD_TAG% -Dsysml.metadata-tag=%METADATA_TAG%

mvnw -B package -DskipTests=true