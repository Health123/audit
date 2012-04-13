require 'spec_helper'

describe Audit do
  it "should be valid" do
    Audit.should be_a(Module)
  end
end