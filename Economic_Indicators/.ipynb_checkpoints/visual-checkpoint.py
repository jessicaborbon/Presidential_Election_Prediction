import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings

# Suppress specific Seaborn future warning
warnings.filterwarnings("ignore", message="When grouping with a length-1 list-like")

# Load the merged and simplified economic data
file_path_econ = '/Users/syedshahid/Documents/Project 4/Current/merged_simplified_data.csv'
data_econ = pd.read_csv(file_path_econ, low_memory=False)

# Clean the 'Value' column by removing commas and converting to numeric
data_econ['Value'] = pd.to_numeric(data_econ['Value'].str.replace(',', ''), errors='coerce')

# Normalize the 'Value' column for each economic indicator
data_econ['Normalized Value'] = data_econ.groupby('Economic Indicator')['Value'].transform(lambda x: (x - x.min()) / (x.max() - x.min()))

# --- Bar Plot: Normalized Economic Indicators for Each Election Year ---

plt.figure(figsize=(12, 8))

# Create a bar plot with Economic Indicators on the x-axis and normalized values on the y-axis, grouped by Year
sns.barplot(x="Economic Indicator", y="Normalized Value", hue="Year", data=data_econ, palette="coolwarm")

# Add titles and labels
plt.title("Economic Indicators Across Election Years (Normalized Bar Plot)", fontsize=16)
plt.xlabel("Economic Indicator", fontsize=14)
plt.ylabel("Normalized Value (0 to 1)", fontsize=14)

plt.tight_layout()

# Save the bar plot
plt.savefig('/Users/syedshahid/Documents/Project 4/Current/economic_indicators_barplot_normalized.png')
plt.show()

# Load the merged election results data
file_path_election = '/Users/syedshahid/Documents/Project 4/Current/merged_election_results_cleaned.csv'
data_election = pd.read_csv(file_path_election, low_memory=False)

# Clean the 'total_votes' column by removing commas and converting to numeric
data_election['total_votes'] = pd.to_numeric(data_election['total_votes'].str.replace(',', ''), errors='coerce')

# Set the color palette for the party
party_palette = {'Republican': 'red', 'Democrat': 'blue'}

plt.figure(figsize=(16, 10))  # Increase figure size for readability
sns.barplot(x="state", y="total_votes", hue="party", data=data_election, palette=party_palette)

# Add titles and labels
plt.title("Total Votes by Party for Each State (2008, 2012, 2016, 2020)", fontsize=16)
plt.xlabel("State", fontsize=14)
plt.ylabel("Total Votes", fontsize=14)

# Rotate the x-axis labels for better readability
plt.xticks(rotation=90)

# Add comma formatting to the y-axis for readability
plt.gca().get_yaxis().set_major_formatter(plt.matplotlib.ticker.FuncFormatter(lambda x, _: f'{int(x):,}'))

plt.tight_layout()

# Save the bar chart for the election data
plt.savefig('/Users/syedshahid/Documents/Project 4/Current/election_total_votes_bar_chart.png')
plt.show()