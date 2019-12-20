package tool;

import haxe.macro.Context;
import haxe.macro.Expr;
using Lambda;

/**
 * 
 * @source https://code.haxe.org/category/macros/add-parameters-as-fields.html
 * @author Mark Knol
 */
class Macro {

	macro static public function ParamAssign():Expr {
		// Grab the variables accessible in the context the macro was called.
		var locals = Context.getLocalVars();
		var fields = Context.getLocalClass().get().fields.get();

		var exprs:Array<Expr> = [];
		for (local in locals.keys()) {
			var sPrivateFieldName = '_'+local;
			if (fields.exists(function(field) return field.name == sPrivateFieldName )) {
				exprs.push(macro this.$sPrivateFieldName = $i{local});
			} else {
				throw new Error(Context.getLocalClass() + " has no field " + sPrivateFieldName, Context.currentPos());
			}
		}
		// Generates a block expression from the given expression array 
		return macro $b{exprs};
	}
}