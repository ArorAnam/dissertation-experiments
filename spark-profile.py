import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, rand
import cProfile
import pstats
from memory_profiler import profile

# Function to be memory profiled
@profile
def process_data(sdf):
    def plus_one(pdf: pd.DataFrame) -> pd.DataFrame:
        return pdf.apply(lambda x: x + 1, axis=1)

    res = sdf.groupby("id").applyInPandas(plus_one, schema=sdf.schema)
    return res.collect()

def main():
    # Initialize Spark Session
    spark = SparkSession.builder.appName("demo").getOrCreate()

    # Create DataFrame
    sdf = spark.range(0, 8 * 1000).withColumn(
            'id', (col('id') % 8).cast('integer')  # 1000 rows x 8 groups (if group by 'id')
            ).withColumn('v', rand())

    # Profiling
    profiler = cProfile.Profile()
    profiler.enable()

    process_data(sdf)

    profiler.disable()
    stats = pstats.Stats(profiler).sort_stats('cumtime')
    stats.print_stats()

    # Stop Spark Session
    spark.stop()

if __name__ == "__main__":
    main()
