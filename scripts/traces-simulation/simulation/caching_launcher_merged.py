from __future__ import print_function
import simpy
import datetime
import math
import sys
from lru_db import LRUCache, DoublyLinkedNode
from lru_db_custom import LRUCacheCustom
import argparse

def convert_size(size_bytes):
   if size_bytes == 0:
       return "0B"
   size_name = ("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB")
   i = int(math.floor(math.log(size_bytes, 1024)))
   p = math.pow(1024, i)
   s = round(size_bytes / p, 2)
   return "%s %s" % (s, size_name[i])

def trace(env, lines, cache, restriction, policy):
    cache_hits_total = 0
    hits_dict = {}
    count = 0
    bytes_requested = 0
    bytes_served = 0
    too_big = 0
    hour_list = []

    for line in lines.readlines():
        count += 1
        line_split = line.split("\t")
        key = line_split[4] + ':' + line_split[5]
        date = None
        bytes_requested += float(line_split[10])
        date_string = line_split[8]
        hour = datetime.datetime.fromtimestamp(float(line_split[9])).hour    
        current_date = datetime.datetime.strptime(date_string,'%Y-%m-%d')
        if current_date != date:
            date = current_date

        if restriction is not None:
            model_decision = False
            predicted = line_split[11]
           
            if str(resctriction) == 'forest':
                if int(float(predicted)) == 1:
                    model_decision = True
            elif str(restriction) == 'linear':
                if float(predicted) > 2.0:
                    model_decision = True
        else:
            model_decision = True
        
        if model_decision:
            if key in cache:
                cache_hits_total += 1
                bytes_served += float(line_split[10])
                if not date in hits_dict:
                    hits_dict[date] = 1
                else:
                    hits_dict[date] += 1
                continue
            else:
                # only update cache if file fits in cache
                if float(line_split[10]) <= float(cache.get_max_size_bytes()):
                    if policy == 'rf':
                        value = {"line": line, "filesize": float(line_split[10]), "prediction": float(line_split[11])}
                    else:
                        value = {"line": line, "filesize": float(line_split[10])}
                    cache.update(key, value)
                else:
                    too_big += 1
                    #print(str(line_split[8]) + "<=" + str(cache.get_max_size_bytes()) + ": " + str(float(line_split[8]) <= float(cache.get_max_size_bytes()))) 
        yield env.timeout(1)

    print("\ncache hits total: " + str(cache_hits_total))
    print("cache size: " + str(convert_size(cache.get_size_bytes())))
    if count == 0:
        print('Hit radio is zero, counts is zero.')
    else:
        print("hit ratio: " + str(float(cache_hits_total)/count))
    if bytes_requested == 0:
        print('No bytes requested.')
    else:
        print("Byte Hit Rate: " + str(float(bytes_served)/float(bytes_requested)))
    print("Files too big for cache: " + str(too_big) + "\n")

    for key in sorted(hits_dict.iterkeys()):
    	print ("%s: %s" % (key, hits_dict[key]))
    print("\n")

def main():
    #print(chr(27) + "[2J") #clear screen
    #print("\033[1;1H")
    parser = argparse.ArgumentParser(description = "Description for my parser")
    parser.add_argument("-i", "--input", help = "Input argument to define traces file", required = True, default = None)
    parser.add_argument("-c", "--cache", help = "Define which caching model to use", required = False, default = None)
    parser.add_argument("-p", "--prefetch", help = "Define if smart or regular prefetching", required = False, default = None) 
    parser.add_argument("-o", "--order", help = "Define if ordered or unordered", required = False, default = None)
    parser.add_argument("-r", "--restriction", help = "Define if cache should be restricted by the model", required = False, default = None)

    argument = parser.parse_args()
    print(str(argument.input))
    print(str(argument.cache))
    print(str(argument.prefetch))
    print(str(argument.order))
    print(str(argument.restriction))

    sizes_april_ordered = [3639877422,18199387111,36398774223,181993871114,363987742229,1819938711143,3639877422286,7279754844572,10919632266859,14559509689145,18199387111431,21839264533717,25479141956003,29119019378290,32758896800576]
    sizes_april_unordered = [5496847982,27484239912,54968479824,274842399120,549684798240,2748423991201,5496847982402,10993695964805,16490543947207,21987391929610,27484239912012,32981087894414,38477935876817,43974783859219,49471631841622] 
    sizes_mai_ordered = [20959532135,104797660674,209595321348,1047976606740,2095953213479,10479766067396,20959532134793,41919064269585,62878596404378,83838128539170,104797660673963,125757192808756,146716724943548,167676257078341,188635789213133]
    sizes_mai_unordered = [20959532135,104797660674,209595321348,1047976606740,2095953213479,10479766067396,20959532134793,41919064269585,62878596404378,83838128539170,104797660673963,125757192808756,146716724943548,167676257078341,188635789213133]

    print("PYTHON CACHE SIMULATOR")
    print("...")

    if argument.order == 'april_ordered':
        sizes = sizes_april_ordered
    elif argument.order == 'april_unordered':
        sizes = sizes_april_unordered
    elif argument.order == 'mai_ordered':
        sizes = sizes_mai_ordered
    elif argument.order == 'mai_unordered':
        sizes = sizes_mai_unordered
    else:
        raise Exception('No order argument given!')
    
    for size in sizes: 
        traces = open(str(argument.input), 'r')
        if argument.cache is None or str(argument.cache).lower() == 'lru':
            cache = LRUCache(size)
            policy = 'lru'
        elif str(argument.cache).lower() == 'rf':
            cache = LRUCacheCustom(size)
            policy = 'rf'
        else: 
            raise Exception('No valid caching policy given.')
        print("Cache size: " + convert_size(size))
        env = simpy.Environment()
        env.process(trace(env, traces, cache, argument.restriction, policy))
        if argument.restriction is None:
            print('No restriction given.')
        env.run()
        traces.close() 
         

if __name__ == "__main__":
        main()
