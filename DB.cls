/**
* Apex database layer for managed packages to simplify and enforce FLS
*
*	Author: @aldoforce
* Github: github.com/aldoforce/apex-db-manager
* License: GNU GPLv2 http://www.gnu.org/licenses/gpl-2.0.html
*
**/
public with sharing class DB {

	/** Insert operation **********************************************************/
	public static void inserter(SObject[] pSObjects) {
		if ( pSObjects != null && pSObjects.size() > 0 )
			if ( pSObjects[0].getSObjectType().getDescribe().isCreateable() ) 
				//dml
				insert pSObjects;
			else
				DB.raiseException(pSObjects[0], 'inserter');					
	}

	public static void inserter(SObject pSObject) {
		DB.inserter(
			new SObject[]{ pSObject }
		);
	}

	/** Update operation **********************************************************/
	public static void updater(SObject[] pSObjects) {
		if ( pSObjects != null && pSObjects.size() > 0 )
			if ( pSObjects[0].getSObjectType().getDescribe().isUpdateable() ) 
				//dml
				update pSObjects;
			else
				DB.raiseException(pSObjects[0], 'updater');					
	}

	public static void updater(SObject pSObject) {
		DB.updater(
			new SObject[]{ pSObject }
		);
	}

	/** Upsert operation **********************************************************/
	public static void upserter(SObject[] pSObjects) {
		if ( pSObjects != null && pSObjects.size() > 0 )
			if ( 	pSObjects[0].getSObjectType().getDescribe().isCreateable() && 
						pSObjects[0].getSObjectType().getDescribe().isUpdateable() ) 
				//dml
				upsert pSObjects;
			else
				DB.raiseException(pSObjects[0], 'upsert');				
	}

	public static void upserter(SObject pSObject) {
		DB.upserter(
			new SObject[]{ pSObject }
		);
	}

	/** generic exception ********************************************************/
	private static void raiseException(SObject pSObject, String pOperation) {
		throw new DBException(
			String.format(
				'The {0} operation is not allowed because the SObject "{1}" is not accessible for the running user/context',
				new String[] { 
					pOperation,
					pSObject.getSObjectType().getDescribe().getName()
				}
			)
		);			
	}

	/** DB inner exception *******************************************************/
	public class DBException extends Exception{}

}