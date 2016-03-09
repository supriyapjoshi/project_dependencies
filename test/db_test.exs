defmodule DbTemplate do
  use ExUnit.CaseTemplate
  alias Neo4j.Sips, as: Neo4j
  setup do
    Neo4j.query(Neo4j.conn, "match(n:Class) detach delete n")
  end
end

defmodule DBTest do
  use DbTemplate
  doctest DB
  alias Neo4j.Sips, as: Neo4j
  test "I can create a node in the database" do
    expected = [%{"m"=>%{"name"=>"com.bla.bla"}}]
    fetch_cypher = """
          MATCH(m:Class {name:'com.bla.bla'}) return m
          """
    DB.insert("com.bla.bla")
    m = Neo4j.query!(Neo4j.conn, fetch_cypher)
    assert m == expected
  end

  test "I can add a relationship between two nodes which exist" do
    expected = [%{"m" => %{"name" => "com.bar.foo"}}]
     fetch_cypher = """
    MATCH(n:Class {name:'com.bla.bla'})-->(m:Class) return m
      """
    node = 'com.bla.bla'
    rel = ['com.bar.foo']
    DB.insert(node,rel)
    m = Neo4j.query!(Neo4j.conn, fetch_cypher)
    assert m == expected
  end

  test "I can add multiple relationships between for a node" do
    expected = [%{"m" => %{"name" => "com.foo.foo"}}, %{"m" => %{"name" => "com.foo.bar"}}, %{"m" => %{"name" => "com.bla.bar"}}]
    fetch_cypher = """
    MATCH(n:Class {name:'com.bla.bla'}) -->(m:Class) return m
    """
    node = "com.bla.bla"
    rel = ["com.bla.bar","com.foo.bar","com.foo.foo"]
    DB.insert(node,rel)
    m = Neo4j.query!(Neo4j.conn,fetch_cypher)
    assert m == expected
  end
end
