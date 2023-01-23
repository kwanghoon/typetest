defmodule Typetest do
  @moduledoc """
  Documentation for `Typetest`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Typetest.hello()
      :world

  """

  ## Structured types

  # error1 = [1, "two", :three]

  @spec ok1 :: [integer]
  def ok1 do [1, 2, 3] end

  @spec ok2 :: [[integer]]
  def ok2 do [[1,2],[3,4],[5,6]] end

  @spec ok3 :: %{age: 12, name: <<_::32>>}
  def ok3 do %{:age => 12, :name => "John"} end

  # error2 = %{1 => 12,:name => "John" }

  @spec ok4 :: {12, <<_::32>>}
  def ok4 do {12, "John"}  end

  @spec ok5 :: [number, ...]
  def ok5 do [1, 1.5, 2] end

  @spec ok6 :: %{1 => <<_::24>>, optional(float) => <<_::96>>}
  def ok6 do %{1 => "one", 1.5 => "one dot five" }  end


  ## Expressions

  def ok7 do
    true and false
    true and (0 < 1)
    # true or 1

    ("hi" > 5.0) or false
    # ("hi" > 5.0) * 3

    case 1 > 0 do
      true -> 1
      false -> 1.5
    end # 1

    case 1 + 2 do
      2 -> "This is wrong"
      3 -> "This is right"
    end # "This is right"

    # case 1 + 2 do
    #   "tres" -> "This is wrong"
    #   3 -> "This is right"
    # end # wrong

    # case 1 + 2 do
    #   1 -> :wrong
    #   3 -> "This is right"
    # end # wrong
  end

  ## Function specifications

  @spec func1(integer) :: float
  def func1(x) do
    x * 42.0
  end

  @spec ok8 :: float
  def ok8 do
    func1(2)
    func1(2.0)  # Todo: All type checks have passed???
    # func1("2")
  end

  @spec func2(any) :: boolean
  def func2(x) do
      x == x
  end

  def ok9 do
    func2(1)   # true
    func2("one")   # true
    func2([1, 2, 3])   # true
  end

  @spec func3([integer]) :: integer
  def func3([]) do
    0
  end

  def func3([head|tail]) do
    head + func3(tail)
  end

  def ok10 do
    func3([])   # 0
    func3([1, 2, 3])   # 3

    # func3(["1", "2", "3"])   # wrong
    # func3([:one, :two, :three])   # wrong
    # func3([1, :two, "three"])   # wrong
  end

  @spec func4([any]) :: integer
  def func4([]) do
      0
  end

  def func4([head|tail]) do
      1 + func4(tail)
  end

  def ok11 do
    func4([])   # 0
    func4([1, 2, 3])   # 3
    func4(["1", "2", "3"])   # 3
    func4([:one, :two, :three])   # 3

    # func4([1, :two, "three"])   # wrong
  end


  @spec func5(%{atom => atom}) :: boolean
  def func5(map) do
      map[:key1] == :one
  end

  def ok12 do
    func5(%{:key1=>:three, :key2=>:three, :key3=>"three"})   # false
    func5(%{:key1=>:one, :key2=>:two, :key3=>"three"})   # true

    func5(%{"1"=>:one, "two"=>:two})   # wrong -> keys are not atoms # Todo: All type checks have passed???
    # func5(%{:key1=>:one, "two"=>:two, 3=>:three})   # wrong -> keys have different types
    # func5(%{})   # wrong -> has less key-value pairs # Todo: runtime error???
  end


  @spec func6(%{none => any}) :: boolean
  def func6(map) do
      map[:key1] == :one
  end

  def ok13 do
    func6(%{"one"=>:one, "two"=>2, "three"=>"three"})   # false
    func6(%{"one"=>1, "two"=>2, "three"=>3})   # false
    func6(%{:key1=>:one, :key2=>2, :key3=>"three"})   # true
    func6(%{:key1=>:one, :key2=>:two, :key3=>:three})   # false

    # func6(%{1=>:one, :two=>2, "three"=>"three"})   # wrong -> keys have different types
    # func6(%{})   # wrong -> has less key-value pairs # Todo: runtime error???
  end

  # @spec func8([any]) :: any
  # def func8(list) do
  #     [head | tail] = list  # Todo: error: _ {:list, _} Parameters does not match type specification ???
  #     head
  # end

  # def ok14 do
  #   func8(["one", "two", "three"])   # "one"
  #   func8([1, 2, 3])   # 1
  #   func8([:one, :two, :three])   # :one
  #   func8([[1,2,3], [4,5,6], [7,8,9]])   # [1,2,3]
  # end

  # @spec func9([any]) :: [any]
  # def func9(list) do
  #     [head | tail] = list   # Todo: error: _ {:list, _} Parameters does not match type specification
  #     tail
  # end

  # def ok15 do
  #   func9([1])   # []
  #   func9([1,2])   # [2]
  #   func9([1.1, 2.0])   # [2.0]
  #   func9(["one", "two", "three"])   # ["two", "three"]
  #   func9([:one, :two])   # [:two]
  #   func9([{1,"one"}, {2,"two"}, {3,"three"}])   # [{2,"two"}, {3,"three"}]
  #   func9([%{1 => 3}, %{2 => "4"}, %{3 => :cinco}])   # [%{2 => "4"}, %{3 => :cinco}]
  # end

  # def ok16 do
  #   func3(func9([0,1]))   # 2
  #   func3(func9(['a', 'b']))   # runtime error
  # end

  def ok17 do
    # id(8) + 10

    # "hello" <> Main.fact(9)  # runtime error
    # id(8) and true           # runtime error
  end
end
