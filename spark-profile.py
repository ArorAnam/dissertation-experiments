import cProfile
import pandas as pd
from pyspark.sql import SparkSession
import pstats
from pyspark.sql.functions import col, rand

spark = SparkSession.builder.appName("demo").getOrCreate()

with cProfile.Profile() as pr:
    sdf = spark.range(0, 8 * 1000).withColumn(
            'id', (col('id') % 8).cast('integer') # 1000 rows x 8 groups (if group by 'id')
            ).withColumn('v', rand())
    
    def plus_one(pdf: pd.DataFrame) -> pd.DataFrame:
        return pdf.apply(lambda x: x + 1, axis=1)

    res = sdf.groupby("id").applyInPandas(plus_one, schema=sdf.schema)
    res.collect()


results = pstats.Stats(pr)
results.sort_stats(pstats.SortKey.TIME)
results.print_stats()
# use:: tuna results.prof
results.dump_stats("results_spark.prof")
