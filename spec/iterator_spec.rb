require File.expand_path(File.dirname(__FILE__) + "/../lib/iterator")

describe Iterator do
  before(:each) do
    @integers = [1,2,3,4,5]
    @strings = ['Felipe','Mesquita','felipemesquita.com', 'fmesquitacunha@gmail.com']
  end

  describe "patch'ed arrays" do
    it "should return an iterator from the arrays" do
      @integers.iterator.should be_an_instance_of(Iterator)
    end

    it "should inject an array into the iterator" do
      @strings.iterator.array.should == @strings
    end
  end

  it "should iterate over array" do
    it = @strings.iterator
    i = 0
    while it.has_next?
      current = it.next_element
      current.should == @strings[i]
      i += 1
    end
  end

  describe "validating possibilities" do
    before(:each) do
      @iterator = @integers.iterator
      while @iterator.has_next?
        @iterator.next_element
      end
    end

    it "returns nil if next_element is called from the last element" do
      expect(@iterator.next_element).to be_nil
    end

    it "should raise an error if a previous element is called from the first element" do
      lambda {
        it = @integers.iterator
        it.next_element
        it.previous
      }.should raise_error
    end

    it "raises an error if the current element is called without initializing the iterator by calling next_element" do
      expect { @integers.iterator.current }.to raise_error(/There is no current element/)
    end
  end
end
