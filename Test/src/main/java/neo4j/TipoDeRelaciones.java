package neo4j;

import org.neo4j.graphdb.RelationshipType;

public enum TipoDeRelaciones implements RelationshipType {
	ES_AMIGO_DE, ENVIA_MENSAJE, RECIBE_MENSAJE
}