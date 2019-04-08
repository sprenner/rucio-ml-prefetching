import datetime


class LRUCacheCustom:
    def __init__(self, max_size):
        self.cache = {}
        self.max_cache_size_bytes = max_size
        self.cache_size_bytes = 0

    def __contains__(self, key):
        return key in self.cache

    def update(self, key, value):
        if float(value['filesize'] > float(self.max_cache_size_bytes)):
            raise Exception("File too big for cache.")
        if key not in self.cache:
            while (self.cache_size_bytes + float(value['filesize'])) > self.max_cache_size_bytes:
                self.remove()
        self.cache[key] = {'time_accessed': datetime.datetime.now(), 'value': value, 'prediction': value['prediction']}
        self.cache_size_bytes += value['filesize']

    """def remove(self):
        remove_entry = None
        for key in self.cache:
            if self.cache[key]['prediction'] == 0.0:
                remove_entry = key
                break
            else:
                for key in self.cache:
                    if remove_entry is None:
                        remove_entry = key
                    elif self.cache[key]['time_accessed'] < self.cache[remove_entry]['time_accessed']:
                        remove_entry = key
        self.cache_size_bytes -= self.cache[remove_entry]["value"]["filesize"]
        self.cache.pop(remove_entry)"""

    def remove(self):
        remove_entry = None
        for key in self.cache:
            if self.cache[key]['prediction'] == 0.0:
                remove_entry = key
                break
        if remove_entry is None:
            for key in self.cache:
                if remove_entry is None:
                    remove_entry = key
                elif self.cache[key]['time_accessed'] < self.cache[remove_entry]['time_accessed']:
                    remove_entry = key
        self.cache_size_bytes -= self.cache[remove_entry]["value"]["filesize"]
        self.cache.pop(remove_entry)

    def get_size_bytes(self):
        return self.cache_size_bytes

    def get_max_size_bytes(self):
        return self.max_cache_size_bytes


