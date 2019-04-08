class DoublyLinkedNode:
    def __init__(self, prev, key, item, next):
        self.prev = prev
        self.key = key
        self.item = item
        self.next = next

class LRUCache:
    """ An LRU cache of a given size caching calls to a given function """


    def __init__(self, max_size_bytes):
        self.max_size_bytes = max_size_bytes
        self.size_bytes = 0
        self.hash = {}
        self.list_front = None
        self.list_end = None

    def __contains__(self, key):
        return key in self.hash

    def update(self, key, value):
        """ Get the value associated with a certain key from the cache """

        if key in self.hash:
            self.from_cache(key)
            return True
        else:
            if float(value['filesize']) > float(self.max_size_bytes):
                raise Exception("File too big for cache.")
            while (self.size_bytes + float(value['filesize'])) > self.max_size_bytes:
                self.kick_item()
            self.insert_item(key, value)
            return False  

    def from_cache(self, key):
        """ Look up a key known to be in the cache. """

        node = self.hash[key]
        assert node.key == key, "Node for LRU key has different key"

        if node.prev is None:
            # it's already in front
            pass
        else:
            # Link the nodes around it to each other
            node.prev.next = node.next
            if node.next is not None:
                node.next.prev = node.prev
            else: # Node was at the list_end
                self.list_end = node.prev

            # Link the node to the front
            node.next = self.list_front
            self.list_front.prev = node
            node.prev = None
            self.list_front = node

        return node.item


    def kick_item(self):
        """ Kick an item from the cache, making room for a new item """
        last = self.list_end
        if last is None: # Same error as [].pop()
            raise IndexError("Can't kick item from empty cache")

        # Unlink from list
        self.list_end = last.prev
        if last.prev is not None:
            last.prev.next = None
        self.size_bytes -= float(self.hash[last.key].item['filesize'])
        # Delete from hash table
        del self.hash[last.key]
        last.prev = last.next = None # For GC purposes


    def insert_item(self, key, item):
        if float(item['filesize']) > self.max_size_bytes:
            raise Exception("File too big for cache.")    
        
        node = DoublyLinkedNode(None, key, item, None)

        # Link node into place
        node.next = self.list_front
        if self.list_front is not None:
            self.list_front.prev = node
        self.list_front = node

        if self.list_end is None:
            self.list_end = node

        # Add to hash table
        self.hash[key] = node
        self.size_bytes += float(item['filesize'])
        #print(self.hash)


    def get_max_size_bytes(self):
        return self.max_size_bytes


    def get_size_bytes(self):
        return self.size_bytes
