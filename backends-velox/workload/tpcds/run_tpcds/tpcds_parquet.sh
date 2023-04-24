#please choose right os system jar
GLUTEN_JAR=/workspaces/gluten/package/target/gluten-package-0.5.0-SNAPSHOT-3.2.jar
SPARK_HOME=/workspaces/gluten/storage/spark322/
cat tpcds_parquet.scala | ${SPARK_HOME}/bin/spark-shell \
  --master local[50] --deploy-mode client \
  --conf spark.plugins=io.glutenproject.GlutenPlugin \
  --conf spark.gluten.sql.columnar.backend.lib=velox \
  --conf spark.driver.extraClassPath=${GLUTEN_JAR} \
  --conf spark.executor.extraClassPath=${GLUTEN_JAR} \
  --conf spark.memory.offHeap.enabled=true \
  --conf spark.memory.offHeap.size=2g \
  --conf spark.gluten.sql.columnar.forceshuffledhashjoin=true \
  --conf spark.shuffle.manager=org.apache.spark.shuffle.sort.ColumnarShuffleManager \
  --num-executors 3 \
  --executor-cores 3 \
  --driver-memory 50g \
  --executor-memory 50g \
  --conf spark.executor.memoryOverhead=2g \
  --conf spark.driver.maxResultSize=4g \
  --conf spark.local.dir=/storage/spark_shuffle
