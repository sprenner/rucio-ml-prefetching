set job.name read-traces;
REGISTER rucioudfs.jar
REGISTER udfs.py USING jython AS udfs;
REGISTER /usr/lib/pig/lib/json-simple-1.1.jar;
REGISTER /usr/lib/pig/piggybank.jar;
REGISTER /usr/lib/pig/lib/avro.jar;
REGISTER /usr/lib/avro/avro-mapred.jar;

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

filter_et = FILTER reduce_fields BY eventtype == 'download' AND clientState != 'ALREADY_DONE' AND dataset != 'None' AND dataset != '' AND dataset != '[null]' AND (STARTSWITH(dataset, 'data') OR STARTSWITH(dataset, 'mc'));

ordered_data = ORDER filter_et BY traceTimeentryUnix ASC;

reduce_fields_final = FOREACH ordered_data GENERATE uuid, account, dataset, filename, eventtype, clientState, udfs.toDay((int)traceTimeentryUnix) as day, traceTimeentryUnix, filesize;

store reduce_fields_final into '/user/sprenner/traces_april_clean.csv' using PigStorage('\t');

