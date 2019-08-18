require 'test_helper'

class BaseSqlAssemblerTest < ActiveSupport::TestCase

  test 'assemble' do
    a = BaseSqlAssembler.new 's'
    assert a.sql_string == 's'
  end

  test 'assemble by iterator' do
    a = BaseSqlAssembler.new ['s1','s2','s3']

    assert a.sql_string == 's1,s2,s3'
    a1 = BaseSqlAssembler.new ['s1','s2','s3',:conjunction=>' and ']
    assert a1.sql_string == 's1 and s2 and s3'
  end

  test 'assemble in template' do
    a = BaseSqlAssembler.new(template: 'on :x do :y when :z', x: 'a',   y: 'b', z: 'c' )
    assert a.sql_string == 'on a do b when c'
  end

 test 'integration assembler test' do
    f = ['field1','field2','field3']
    t = ['table1']
    v = ['val1',['val21','val22'],'val3']
    w1 = BaseSqlAssembler.new(template: ':field=:value', field: f[0] ,value: v[0]) 
    w2 = BaseSqlAssembler.new(template: ':field between :min and :max', field: f[1] , min: v[1][0], max: v[1][1]) 
    w3 = BaseSqlAssembler.new(template: ':field in(:values)', field: f[2] , values: '1,2,3') 
    f1 = BaseSqlAssembler.new f
    w =  BaseSqlAssembler.new [w1,w2,w3,:conjunction=>' and ']
    a = BaseSqlAssembler.new(template: 'select :fields from :tables where :where'  ,fields: f1,tables: t[0] , where: w )

    assert w1.sql_string == 'field1=val1'
    assert f1.sql_string == 'field1,field2,field3'
p a.sql_string
    assert a.sql_string == 'select field1,field2,field3 from table1 where field1=val1 and field2 between val21 and val22 and field3 in(1,2,3)'
 end
end
