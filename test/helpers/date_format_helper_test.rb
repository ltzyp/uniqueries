require 'test_helper'

class DateFormatHelperTest < ActiveSupport::TestCase

  setup do
    class DateLanguageStub <DateFormatHelper::DateLanguageBasic  # ? why need namespace here
      def self.formatters; [Year]; end;
      def pattern; 'a%Yb'; end;
    end
    DateFormatHelper.setDateLanguage(DateLanguageStub)  # why string don't work?
  end

  test "first date format basic test" do
 
    h = DateFormatHelper.new(['2019'])
    assert h.process =="a2019b"                         # want correct name for the method - format?
  end

  test "second date format abstract test" do
 
    h = DateFormatHelper.new(['209'])
    assert h.process =="a209b"                         
  end
end

class DateFormatHelperSQLiteTest < ActiveSupport::TestCase

  setup do
    DateFormatHelper.setDateLanguage(DateLanguageSQLite) 
  end

  test "first date format SQLite test" do
 
    h = DateFormatHelper.new(['2019','12','3','1','22','5'])
    assert h.process =="datetime('2019-12-03-01-22-05')"                         
  end

 test " date format default year test" do
 
    h = DateFormatHelper.new(['','1','3','1','22','5'])
    assert h.process =="datetime('2019-01-03-01-22-05')"                         
  end

 test " date format month range test" do
 
    h = DateFormatHelper.new(['2019','','3','1','22','5'])
    assert h.process =="datetime('2019-01-03-01-22-05')"                         
  end

 test " date format day range test" do
 
    h = DateFormatHelper.new(['2019','11','','1','22','5'])
    assert h.process =="datetime('2019-11-01-01-22-05')"                         
  end

 test "first date format default minute test" do
 
    h = DateFormatHelper.new(['2019','12','3','1'])
    assert h.process =="datetime('2019-12-03-01-00-00')"                         
  end
end

=begin
include date_format_SQLite
  test "date format SQLite test" do
    r = DateFormatHelper::Register.new
    r.value= '2019'; r.formatter= DateFormatHelper::Year.new
    assert r.formatter.print(r.value,DateFormatHelper::SQLite.new)=="datetime('2019-%M-%D-%H-%I-%S')" 
  end
=end
  

=begin
   test "short input string" do 
      {"2008.05.06"=>"datetime('2008-05-06')",
        "2018.5"=>"datetime('2018-05-01')"
      }.each_pair do | k, v |  
        assert DateFormatHelper.process( k )== v

      end
   end
=end




