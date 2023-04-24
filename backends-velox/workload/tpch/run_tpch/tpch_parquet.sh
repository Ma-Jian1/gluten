#please choose right os system jar
GLUTEN_JAR=/workspaces/gluten/package/target/gluten-velox-bundle-spark3.2_2.12-ubuntu_22.04-0.5.0-SNAPSHOT.jar
# GLUTEN_JAR=/workspaces/gluten/package/target/gluten-velox-bundle-spark3.2_2.12-ubuntu_22.04-0.5.0-SNAPSHOT.jar,https://github.com/oap-project/gluten/releases/download/0.5.0/gluten-thirdparty-lib-ubuntu-20.04.jar 
SPARK_HOME=/workspaces/gluten/storage/spark322/
  # --conf "spark.driver.extraJavaOptions=-Dhttp.proxyHost=child-prc.intel.com -Dhttp.proxyPort=913 -Dhttps.proxyHost=child-prc.intel.com -Dhttps.proxyPort=913" \
cat tpch_parquet.scala | ${SPARK_HOME}/bin/spark-shell \
  --master local[50] --deploy-mode client \
  --conf spark.plugins=io.glutenproject.GlutenPlugin \
  --conf spark.gluten.sql.columnar.backend.lib=velox \
  --conf spark.driver.extraClassPath=${GLUTEN_JAR} \
  --conf spark.executor.extraClassPath=${GLUTEN_JAR} \
  --conf spark.gluten.sql.columnar.forceshuffledhashjoin=true \
  --conf spark.shuffle.manager=org.apache.spark.shuffle.sort.ColumnarShuffleManager \
  --driver-memory 50g \
  --num-executors 3 \
  --executor-cores 3 \
  --executor-memory 2g \
  --conf spark.memory.offHeap.enabled=true \
  --conf spark.memory.offHeap.size=50g \
  --conf spark.executor.memoryOverhead=500m \
  --conf spark.local.dir=/storage/spark_shuffle \
  --conf spark.driver.maxResultSize=500m
