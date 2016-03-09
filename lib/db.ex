defmodule DB do
  alias Neo4j.Sips, as: Neo4j
  def insert(class) do
    cypher = "CREATE (:Class {name: '#{class}'})"
    Neo4j.query(Neo4j.conn, cypher)
  end

  def insert(class,[rel | []]) do
      addRelationship(class,rel)
  end
  defp addRelationship(class,rel) do
    cypher = """
        MERGE (node:Class {name: '#{class}'})
        MERGE (rel:Class {name: '#{rel}'})
        MERGE(node) - [:USES] ->(rel)
    """
    Neo4j.query(Neo4j.conn,cypher)
  end
  def insert(class,[head | tail]) do
    addRelationship(class,head)
    insert(class,tail)
  end
end
