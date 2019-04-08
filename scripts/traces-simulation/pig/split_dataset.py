@outputSchema('project:chararray')
def get_project(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[0]
        else:
            return "None"
    except:
        return "Null"

@outputSchema('run_number:chararray')
def get_run_number(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[1]
        else:
            return "None"
    except:
        return "Null"

@outputSchema('stream_name:chararray')
def get_stream_name(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[2]
        else:
            return "None"
    except:
        return "Null"

@outputSchema('prod_step:chararray')
def get_prod_step(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[3]
        else:
            return "None"
    except:
        return "Null"

@outputSchema('datatype:chararray')
def get_datatype(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[4]
        else:
            return "None"
    except:
        return "Null"

@outputSchema('dataset_version:chararray')
def get_dataset_version(dataset):
    try:
        if (dataset.startswith('data') or dataset.startswith('mc')):
            return dataset.split('.')[5]
        else:
            return "None"
    except:
        return "Null"
