## 多家公司代理人相同

```
match p=(m:CAccount)-[r1]-(n)-[r2:CAgent]->(x)<-[r3]-(y) where id(m) in $ids and type(r1)<>'PAY' and type(r3)='CAgent'  return p limit 20;
```

## 相同地址
```
match p=(m:CAccount)-[r1]-(n)-[r2:Location]->(x)<-[r3:Location]-(y) where id(m) in $ids and type(r1)<>'PAY'  return p limit 20;
```
## 相同联系方式

```
match p=(m:CAccount)-[r1]-(n)-[r2:Contact]->(x)<-[r3:Contact]-(y) where id(m) in $ids and type(r1)<>'PAY'  return p limit 20;
```
## 交易对手复杂
```
match p=(m:CAccount)-[r1:PAY]-(n) where id(m) in $ids return p limit 20;
```

## 散进散出
```
MATCH (c:CAccount) -[r:PAY]-() WHERE ID(c) in $ids
WITH collect({rd:timestamp(r.TRADE_DATE),rl:apoc.date.add(timestamp(r.TRADE_DATE), 'ms', 10, 'd') }) as tms
UNWIND tms AS tm
optional MATCH (c2:CAccount)<-[r2:PAY]-()
WHERE ID(c2) in $ids
AND tm.rd <= timestamp(r2.TRADE_DATE) 
AND tm.rl >= timestamp(r2.TRADE_DATE)
optional MATCH (c3:CAccount)-[r3:PAY]->()
WHERE ID(c3) in $ids 
AND tm.rd <= timestamp(r3.TRADE_DATE) 
AND tm.rl >= timestamp(r3.TRADE_DATE)
WITH
{tm:tm,
r2:size(collect(r2)),
r3:size(collect(r3)),
amount_r2:sum(tofloat(r2.AMOUNT_CNY)),
amount_r3:sum(tofloat(r3.AMOUNT_CNY)),
r2_id:collect(id(r2)),
r3_id:collect(id(r3))} AS result
where result.r2>0 and result.r3>0 and 0.9<=result.r2/result.r3<=1.1 and 0<=(result.amount_r2-result.amount_r3)/result.amount_r3<=0.1
match p=()-[x]-() where id(x) in result.r2_id or  id(x) in  result.r3_id
return p

```