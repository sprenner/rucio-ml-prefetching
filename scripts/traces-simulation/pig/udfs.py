import hashlib
import datetime

@outputSchema("id:chararray")
def generate_id(scope, name, rse, created_at):
    s = "%s_%s_%s_%d" % (scope, name, rse, created_at)

    m = hashlib.md5()
    m.update(s)
    return str(m.hexdigest())

@outputSchema("d:datetime")
def todatetime(i):
    return datetime.datetime.fromtimestamp(i/1000);

@outputSchema("date:chararray")
def toDay(timestamp):
    return datetime.datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d')

@outputSchema("date:chararray")
def toMonth(timestamp):
    return datetime.datetime.fromtimestamp(timestamp).strftime('%Y-%m')

@outputSchema("name:chararray")
def extract_name(did):
    if (':' in did):
        return did.split(':')[1]
    return did

@outputSchema("datatype:chararray")
def get_datatype(name):
    splits = name.split('.')
    if splits >= 5:
        return splits[4]
    return None

@outputSchema("scope:chararray")
def extract_scope(did):
    if (':' in did):
        return did.split(':')[0]

    items = did.split('.')
    if (len(items) <= 0):
        return 'null'

    scope = items[0]
    if (did.startswith('user') or did.startswith('group')):
        scope = items[0] + '.' + items[1]
    return scope

@outputSchema("user:chararray")
def check_user(user):
    if ('\n' in user):
        return user.split('\n')[1]
    return user
