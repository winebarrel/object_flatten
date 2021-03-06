require 'spec_helper'

describe ObjectFlatten do
  subject { ObjectFlatten.flatten(obj, options) }

  let(:obj) { described_class }
  let(:options) { {} }

  context({}) do
    it do
      is_expected.to eq []
    end
  end

  context("foo"=>"bar") do
    it do
      is_expected.to eq [
        {"foo"=>"bar"}
      ]
    end
  end

  context("foo"=>"bar", "bar"=>"zoo") do
    it do
      is_expected.to eq [
        {"foo"=>"bar"},
        {"bar"=>"zoo"}
      ]
    end
  end

  context("foo"=>["bar", "zoo"]) do
    it do
      is_expected.to eq [
        {"foo"=>"bar"},
        {"foo"=>"zoo"}
      ]
    end
  end

  context("foo"=>{"bar1"=>"zoo", "bar2"=>"baz"}) do
    it do
      is_expected.to eq [
        {"foo.bar1"=>"zoo"},
        {"foo.bar2"=>"baz"}
      ]
    end
  end

  context("foo"=>{"bar1"=>"zoo", "bar2"=>"baz"}) do
    let(:options) { {separator: '/'} }

    it do
      is_expected.to eq [
        {"foo/bar1"=>"zoo"},
        {"foo/bar2"=>"baz"}
      ]
    end
  end

  context("f oo"=>{"b-ar1"=>"z o o", "b ar2"=>"b a z"}) do
    let(:options) { {tr: [' -', '__']} }

    it do
      is_expected.to eq [
        {"f_oo.b_ar1"=>"z o o"},
        {"f_oo.b_ar2"=>"b a z"}
      ]
    end
  end

  context(foo: {bar1: 1, bar2: 2}) do
    it do
      is_expected.to eq [
        {"foo.bar1"=>1},
        {"foo.bar2"=>2}
      ]
    end
  end

  context("foo1"=>{"bar1"=>"zoo", "bar2"=>"baz"},
          "foo2"=>{"bar"=>["zoo","baz"], "zoo"=>"baz"}) do
    it do
      is_expected.to eq [
        {"foo1.bar1"=>"zoo"},
        {"foo1.bar2"=>"baz"},
        {"foo2.bar"=>"zoo"},
        {"foo2.bar"=>"baz"},
        {"foo2.zoo"=>"baz"}
      ]
    end
  end

  context("foo1"=>{"bar"=>{"zoo1"=>"baz", "zoo2"=>"baz"}},
          "foo2"=>{"bar"=>{"zoo"=>["baz1","baz2"]}}) do
    it do
      is_expected.to eq [
        {"foo1.bar.zoo1"=>"baz"},
        {"foo1.bar.zoo2"=>"baz"},
        {"foo2.bar.zoo"=>"baz1"},
        {"foo2.bar.zoo"=>"baz2"}
      ]
    end
  end

  context(["foo", "bar", "zoo"]) do
    it do
      expect {
        subject
      }.to raise_error(TypeError)
    end
  end
end
