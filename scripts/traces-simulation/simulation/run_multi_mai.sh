#!/usr/bin/bash
echo 'simulation mai 2018'
if [ ! -f simulation_outputs/mai_lru_ordered.txt ]; then
   python caching_launcher_merged.py -i models/forest_mai_official_hourly_ordered_prefetching80_numTrees300_seed1234_cache01.csv -c lru -o mai_ordered  > simulation_outputs/mai_lru_ordered.txt
   echo 'mai_lru_ordered.txt done.'
else
   echo 'mai_lru_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_rf_ordered.txt ]; then
   python caching_launcher_merged.py -i models/forest_mai_official_hourly_ordered_prefetching80_numTrees300_seed1234_cache01.csv -c rf -o mai_ordered  > simulation_outputs/mai_lru_rf_ordered.txt
   echo 'mai_lru_rf_ordered.txt done.'
else
   echo 'mai_lru_rf_ordered.txt found - skipping.'
fi

#if [ ! -f simulation_outputs/mai_lru_random.txt ]; then
#   python caching_launcher_merged.py -i models/forest_mai_official_hourly_prefetching80_numTrees300_seed1234_cache01.csv -c lru -o mai_unordered  > simulation_outputs/mai_lru_random.txt
#else
#   echo 'mai_lru_random.txt found - skipping.'
#fi
#if [ ! -f simulation_outputs/mai_lru_rf_random.txt ]; then 
#   python caching_launcher_merged.py -i models/forest_mai_official_hourly_prefetching80_numTrees300_seed1234_cache01.csv -c rf -o mai_unordered  > simulation_outputs/mai_lru_rf_random.txt
#else
#   echo 'mai_lru_rf_random.txt found - skipping.'
#fi
#echo 'lru+rf finished'

if [ ! -f simulation_outputs/mai_lru_pre80_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching80_numTrees300_seed1234_cache01.csv -o mai_ordered -t 80 > simulation_outputs/mai_lru_pre80_ordered.txt
   echo 'mai_lru_pre80_ordered.txt done.'
else
   echo 'mai_lru_pre80_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_pre80smart_ordered.txt ]; then 
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching80_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart > simulation_outputs/mai_lru_pre80smart_ordered.txt
   echo 'mai_lru_pre80smart_ordered.txt done.'
else
   echo 'mai_lru_pre80smart_ordered.txt found - skipping.'
fi 
if [ ! -f simulation_outputs/mai_lru_rf_pre80smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching80_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart -c rf > simulation_outputs/mai_lru_rf_pre80smart_ordered.txt
   echo 'mai_lru_rf_pre80smart_ordered.txt done.'
else
   echo 'mai_lru_rf_pre80smart_ordered.txt found - skipping.'
fi

#if [ ! -f simulation_outputs/mai_lru_pre80_random.txt ]; then
#   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_prefetching80_numTrees300_seed1234_cache01.csv -o mai_unordered -t 80 > simulation_outputs/mai_lru_pre80_random.txt
#else
#   echo 'mai_lru_pre80_random.txt found - skipping.'
#fi
#if [ ! -f simulation_outputs/mai_lru_pre80smart_random.txt ]; then
#   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_prefetching80_numTrees300_seed1234_cache01.csv -o mai_unordered -p smart -t 80 > simulation_outputs/mai_lru_pre80smart_random.txt
#else
#   echo 'mai_lru_pre80smart_random.txt found - skipping.'
#fi
   #python caching_launcher_custom_lookup.py -i models/forest_mai_official_hourly_prefetching80_numTrees300_seed1234_cache01.csv -o mai_unordered -p smart -t 80 > simulation_outputs/mai_lru_rf_pre80smart_random.txt

#echo 'lru+pre80 random finished'

if [ ! -f simulation_outputs/mai_lru_pre50_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o mai_ordered -t 50 > simulation_outputs/mai_lru_pre50_ordered.txt
   echo 'mai_lru_pre50_ordered.txt done.'
else
   echo 'mai_lru_pre50_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_pre50smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart > simulation_outputs/mai_lru_pre50smart_ordered.txt
   echo 'mai_lru_pre50smart_ordered.txt done.'
else
   echo 'mai_lru_pre50smart_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_rf_pre50smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart -c rf > simulation_outputs/mai_lru_rf_pre50smart_ordered.txt
   echo 'mai_lru_rf_pre50smart_ordered.txt done.'
else
   echo 'mai_lru_rf_pre50smart_ordered.txt found - skipping.'
fi

#if [ ! -f simulation_outputs/mai_lru_pre50_random.txt ]; then
#   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o mai_unordered -t 50 > simulation_outputs/mai_lru_pre50_random.txt
#else
#   echo 'mai_lru_pre50_random.txt not found - skipping.'
#fi
#if [ ! -f simulation_outputs/mai_lru_pre50smart_random.txt ]; then
#   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o mai_unordered -p smart -t 50 > simulation_outputs/mai_lru_pre50smart_random.txt
#else
#   echo 'mai_lru_pre50smart_random.txt not found - skipping.'
#fi
   #python caching_launcher_custom_lookup.py -i models/forest_mai_official_hourly_prefetching50_numTrees300_seed1234_cache01.csv -o mai_unordered -p smart -t 50 > simulation_outputs/mai_lru_rf_pre50smart_random.txt

#echo 'lru+pre50 random finished'

if [ ! -f simulation_outputs/mai_lru_pre15_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o mai_ordered -t 15 > simulation_outputs/mai_lru_pre15_ordered.txt
   echo 'mai_lru_pre15_ordered.txt done.'
else
   echo 'mai_lru_pre15_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_pre15smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart > simulation_outputs/mai_lru_pre15smart_ordered.txt
   echo 'mai_lru_pre15smart_ordered.txt done.'
else
   echo 'mai_lru_pre15smart_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_rf_pre15smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching15_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart -c rf > simulation_outputs/mai_lru_rf_pre15smart_ordered.txt
   echo 'mai_lru_rf_pre15smart_ordered.txt done.'
else
   echo 'mai_lru_rf_pre15smart_ordered.txt found - skipping.'
fi

if [ ! -f simulation_outputs/mai_lru_pre30_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching30_numTrees300_seed1234_cache01.csv -o mai_ordered -t 30 > simulation_outputs/mai_lru_pre30_ordered.txt
   echo 'mai_lru_pre30_ordered.txt done.'
else
   echo 'mai_lru_pre30_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_pre30smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching30_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart > simulation_outputs/mai_lru_pre30smart_ordered.txt
   echo 'mai_lru_pre30smart_ordered.txt done.'
else
   echo 'mai_lru_pre30smart_ordered.txt found - skipping.'
fi
if [ ! -f simulation_outputs/mai_lru_rf_pre30smart_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching30_numTrees300_seed1234_cache01.csv -o mai_ordered -p smart -c rf > simulation_outputs/mai_lru_rf_pre30smart_ordered.txt
   echo 'mai_lru_rf_pre30smart_ordered.txt done.'
else
   echo 'mai_lru_rf_pre30smart_ordered.txt found - skipping.'
fi


if [ ! -f simulation_outputs/mai_lru_preAll_ordered.txt ]; then
   python caching_launcher_lookup_merged.py -i models/forest_mai_official_hourly_ordered_prefetching50_numTrees300_seed1234_cache01.csv -o mai_ordered -t -1 > simulation_outputs/mai_lru_preAll_ordered.txt
   echo 'mai_lru_preAll_ordered.txt done.'
else
   echo 'mai_lru_preAll_ordered.txt found - skipping.'
fi
