import matplotlib
matplotlib.use('Agg')
import sys
import pandas as pd
import matplotlib.pyplot as plt

if len(sys.argv) == 0:
    print("No input argument given. Please pass filename as found in current folder as param.")
else:
    prediction_input = sys.argv[1]
    print(prediction_input)
    plt.rcParams['agg.path.chunksize'] = 10000

    df_pd = pd.read_csv(str(prediction_input), delimiter='\t')
    df_pd.columns = ['hits', 'prediction']
    print(df_pd.head(n=5))

    df_pd = df_pd.sort_values('prediction')
    df_pd = df_pd.reset_index(drop=True)
    plot = df_pd.plot(figsize=(16,10))

    fig = plot.get_figure()
    fig.savefig(prediction_input.replace(".csv", "") + '.png')
