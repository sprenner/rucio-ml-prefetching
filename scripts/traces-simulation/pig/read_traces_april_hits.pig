set job.name read-traces;
REGISTER rucioudfs.jar
REGISTER udfs.py USING jython AS udfs;
REGISTER /usr/lib/pig/lib/json-simple-1.1.jar;
REGISTER /usr/lib/pig/piggybank.jar;
REGISTER /usr/lib/pig/lib/avro.jar;
REGISTER /usr/lib/avro/avro-mapred.jar;
REGISTER split_dataset.py USING jython AS split_d;

rucio_traces = LOAD '/user/rucio01/traces/traces.2018-04-*' USING rucioudfs.TracesLoader() as (
 account: chararray,
 appid: chararray,
 catStart: double,
 clientState: chararray,
 dataset: chararray,
 datasetScope: chararray,
 duid: chararray,
 eventType: chararray,
 eventVersion: chararray,
 filename: chararray,
 filesize: long,
 guid: chararray,
 hostname: chararray,
 ip: chararray,
 localSite: chararray,
 protocol: chararray,
 relativeStart: double,
 remoteSite: chararray,
 scope: chararray,
 stateReason: chararray,
 suspicious: chararray,
 timeEnd: double,
 timeStart: double,
 traceId: chararray,
 traceIp: chararray,
 traceTimeentry: chararray,
 traceTimeentryUnix: double,
 transferEnd: double,
 transferStart: double,
 url: chararray,
 usr: chararray,
 usrdn: chararray,
 uuid: chararray,
 validateStart: double,
 version: long
);

-- get rid of unused fields in traces
reduce_fields = FOREACH rucio_traces GENERATE uuid, account, dataset, filename, eventType as eventtype, clientState, traceTimeentryUnix, filesize;

filter_et = FILTER reduce_fields BY eventtype == 'download';

--ordered_data = ORDER filter_et BY traceTimeentryUnix ASC;

reduce_fields_final = FOREACH filter_et GENERATE uuid, account, dataset, filename, eventtype, clientState, udfs.toDay((int)traceTimeentryUnix) as day, traceTimeentryUnix, filesize, split_d.get_project(dataset) as project, split_d.get_run_number(dataset) as run_number, split_d.get_stream_name(dataset) as stream_name, split_d.get_prod_step(dataset) as prod_step , split_d.get_datatype(dataset) as datatype, split_d.get_dataset_version(dataset) as dataset_version;

-- create temporary table for hits

hits_fields = FOREACH reduce_fields_final GENERATE dataset as dataset_counts;
grouped_hits_fields = GROUP hits_fields BY dataset_counts;
counted = FOREACH grouped_hits_fields GENERATE group as dataset_counts, COUNT_STAR(hits_fields) as cnt;
result_hits =  FOREACH counted GENERATE dataset_counts, cnt;

-- join
result_join = JOIN reduce_fields_final BY dataset LEFT OUTER, result_hits BY dataset_counts;

--order
result_ordered = ORDER result_join BY traceTimeentryUnix ASC;
store result_ordered into '/user/sprenner/traces_april_processed.csv' using PigStorage('\t');

