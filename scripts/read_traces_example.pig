set job.name read-traces;
REGISTER rucioudfs.jar
REGISTER udfs.py USING jython AS udfs;
REGISTER /usr/lib/pig/lib/json-simple-1.1.jar;
REGISTER /usr/lib/pig/piggybank.jar;
REGISTER /usr/lib/pig/lib/avro.jar;
REGISTER /usr/lib/avro/avro-mapred.jar;

rucio_traces = LOAD '/user/rucio01/traces/traces.2018-04-2*' USING rucioudfs.TracesLoader() as (
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
reduce_fields = FOREACH rucio_traces GENERATE uuid, eventType as eventtype, clientState, udfs.toDay((int)traceTimeentryUnix) as day;

filter_et = FILTER reduce_fields BY eventtype == 'get_sm_a';

group_eventtype = GROUP filter_et BY (day, clientState);

count_day = FOREACH group_eventtype GENERATE group.day as day, group.clientState as clientState, COUNT(filter_et) as c;

order_day = ORDER count_day BY day ASC;

DUMP order_day;

