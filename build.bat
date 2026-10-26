rd /S /Q dist

call docker build -t omg-fork-build . && ^
docker create --name omg-fork-build-extract omg-fork-build && ^
docker cp omg-fork-build-extract:/workspace/org.omg.sysml.site/target ./dist && ^
docker cp omg-fork-build-extract:/workspace/sysml.library ./dist && ^
docker rm omg-fork-build-extract

