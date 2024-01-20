from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("TestApp").getOrCreate()
df = spark.createDataFrame([{"hello": "world"}])
df.show()
spark.stop()

