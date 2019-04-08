#!/usr/bin/bash

python caching_launcher_lookup.py -i models/forest_april_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o april_ordered -t 50 > simulation_outputs/april_lru_pre50_ordered.txt
python caching_launcher_lookup.py -i models/forest_april_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o april_ordered -p smart -t 50 > simulation_outputs/april_lru_pre50smart_ordered.txt
python caching_launcher_custom_lookup.py -i models/forest_april_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o april_ordered -p smart -t 50 > simulation_outputs/april_lru_rf_pre50smart_ordered.txt

python caching_launcher_lookup.py -i models/forest_april_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o april_unordered -t 50 > simulation_outputs/april_lru_pre50_random.txt
python caching_launcher_lookup.py -i models/forest_april_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o april_unordered -p smart -t 50 > simulation_outputs/april_lru_pre50smart_random.txt
python caching_launcher_custom_lookup.py -i models/forest_april_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o april_unordered -p smart -t 50 > simulation_outputs/april_lru_rf_pre50smart_random.txt

if [ ! -f simulation_outputs/april/april_lru_pre15_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_april_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o april_ordered -t 15 > simulation_outputs/april/april_lru_pre15_ordered.txt
   echo 'april_lru_pre15_ordered.txt done.'
else
   echo 'april_lru_pre15_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/april/april_lru_pre15smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_april_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o april_ordered -p smart > simulation_outputs/april/april_lru_pre15smart_ordered.txt
   echo 'april_lru_pre15smart_ordered.txt done.'
else
   echo 'april_lru_pre15smart_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/april/april_lru_rf_pre15smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_april_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o april_ordered -p smart -c rf > simulation_outputs/april/april_lru_rf_pre15smart_ordered.txt
   echo 'april_lru_rf_pre15smart_ordered.txt done.'
else
   echo 'april_lru_rf_pre15smart_ordered.txt found - skipping.'
fi
