from pyspark.sql import SparkSession
import cProfile
import pstats

spark = SparkSession.builder.appName("demo").getOrCreate()

with cProfile.Profile() as pr:
    df = spark.createDataFrame(
        [
            ("sue", 32),
            ("li", 3),
            ("bob", 75),
            ("heo", 13),
        ],
        ["first_name", "age"],
    )

results = pstats.Stats(pr)
results.sort_stats(pstats.SortKey.TIME)
results.print_stats()

results.dump_stats("result.prof")

df.show()

from pyspark.sql.functions import col, when

df1 = df.withColumn(
    "life_stage",
    when(col("age") < 13, "child")
    .when(col("age").between(13, 19), "teenager")
    .otherwise("adult"),
)

df1.show()

df1.where(col("life_stage").isin(["teenager", "adult"])).show()

from pyspark.sql.functions import avg

df1.select(avg("age")).show()

spark.sql("select avg(age) from {df1}", df1=df1).show()

spark.sql("select life_stage, avg(age) from {df1} group by life_stage", df1=df1).show()


## SPark SQL ##

# Persist the data
df1.write.saveAsTable("some_people")

spark.sql("select * from some_people").show()

# use cProfile for specfic function
## cProfile.run('')


