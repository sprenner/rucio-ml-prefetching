import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.patches as mpatches
from matplotlib.legend_handler import HandlerBase
from matplotlib.text import Text
import pandas as pd
import seaborn as sns
from datetime import datetime
from matplotlib import rcParams

pd.set_option('display.max_columns', None)
pd.set_option('display.max_colwidth', -1)
print(str(datetime.now()) + ': reading csv...')
df = pd.read_csv('traces_april_processed.csv', delimiter='\t')
df.columns = ['uuid', 'account', 'dataset', 'filename', 'eventType', 'clientState', 'day', 'traceTimeentryUnix', 'filesize', 'project', 'run_number', 'stream_name', 'prod_step', 'datatype', 'dataset_version', 'dataset_counts', 'hits']
print(df.head(n=5))
#df['account'].value_counts().plot(kind='bar')

print(str(datetime.now()) + ': start plotting...')
#plt.figure(figsize=(12,8))
#sns_plot = sns.countplot(x="account", data=df, palette="Greens_d",
#              order=pd.value_counts(df['account']).iloc[:10].index)
#plt.title('Top ten accounts')

plt.figure(figsize=(15,15))
ncount = df.shape[0]
categorical = ['account', 'dataset','clientState', 'eventType', 'filename', 'traceTimeentryUnix', 'uuid', 'project', 'stream_name', 'prod_step', 'datatype', 'dataset_version']
fig, ax = plt.subplots()

class TextHandler(HandlerBase):
    def create_artists(self, legend, tup ,xdescent, ydescent,
                        width, height, fontsize,trans):
        tx = Text(width/2.,height/2,tup[0], fontsize=fontsize,
                  ha="center", va="center", color=tup[1], fontweight="bold")
        return [tx]
    

def draw(attr):
    print(str(datetime.now()) + ': drawing ' + attr + '_plot...')
    
    # clear figure
    plt.gcf().clear()
    #rcParams.update({'figure.autolayout': True})
    idx = pd.value_counts(df[attr]).iloc[:10].index
    ax = sns.countplot(x=attr, data=df, palette="Greens_d", order=idx)
    #plt.title(attr + ' top 10', y=1.08)
    plt.xlabel(attr + ' top 10')
   
    # Make twin axis
    ax2=ax.twinx()

    # Switch so count axis is on right, frequency on left
    ax2.yaxis.tick_left()
    ax.yaxis.tick_right()

    # Also switch the labels over
    ax.yaxis.set_label_position('right')
    ax2.yaxis.set_label_position('left')

    ax2.set_ylabel('Frequency [%]')

    for p in ax.patches:
        x=p.get_bbox().get_points()[:,0]
        y=p.get_bbox().get_points()[1,1]
        ax.annotate('{:.1f}%'.format(100.*y/ncount), (x.mean(), y), 
                ha='center', va='bottom') # set the alignment of the text

    # Use a LinearLocator to ensure the correct number of ticks
    ax.yaxis.set_major_locator(ticker.LinearLocator(11))

    # Fix the frequency range to 0-100
    ax2.set_ylim(0,100)
    ax.set_ylim(0,ncount)

    # And use a MultipleLocator to ensure a tick spacing of 10
    ax2.yaxis.set_major_locator(ticker.MultipleLocator(10))

    # Need to turn the grid on ax2 off, otherwise the gridlines end up on top of the bars
    ax2.grid(None)
    
    top_ten_list = list(idx.values)

    handltext = []

    for idx, val in enumerate(top_ten_list):
        handltext.append(u"\u25A0" + " " + str(idx + 1) + ":")  
 
    labels = ax.get_xticklabels()

    labeldic = dict(zip(handltext, labels))
    labels = [(labeldic[h].get_text()) if len(labeldic[h].get_text()) < 60 else labeldic[h].get_text()[0:61] + "..." for h in handltext]
    handles = [(h,c.get_fc()) for h,c in zip(handltext,ax.patches)]

    ax.legend(handles, labels, handler_map={tuple : TextHandler()}, bbox_to_anchor=(-0.1, 1.20, 1., .102), loc=3, ncol=1, mode="expand", borderaxespad=0., frameon=False, edgecolor='white') 
    ax.set_xticklabels('')
    fig.subplots_adjust(top=0.75)

    #ax.figure.tight_layout()
    #ax2.figure.tight_layout()
    #ax.set_xticklabels(ax.get_xticklabels(), rotation=30, ha='right')
    #rcParams.update({'figure.autolayout': True})
    plt.tight_layout()
    plt.savefig(attr+ '_plot.png')

for elem in categorical:
    draw(elem)

print(str(datetime.now()) + ': finished')
