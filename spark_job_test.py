from pyspark.sql import SparkSession

def main():
    # Initialize Spark Session
    spark = SparkSession.builder.appName("BasicTest").getOrCreate()

    # Create a simple DataFrame
    data = [("John", 10), ("Jane", 20), ("Doe", 30)]
    columns = ["Name", "Age"]
    df = spark.createDataFrame(data, columns)

    # Perform a simple transformation
    transformed_df = df.withColumn("AgeTimesTwo", df["Age"] * 2)

    # Collect the result
    result = transformed_df.collect()

    # Print the result
    for row in result:
        print(row)

    # Stop the SparkSession
    spark.stop()

if __name__ == "__main__":
    main()
