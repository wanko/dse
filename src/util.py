from clingo.symbol import Function, Number, SymbolType, Tuple_
def copy_symbol(symbol):
    # functions
    if symbol.type == SymbolType.Function:
        return Function(symbol.name, [copy_symbol(x) for x in symbol.arguments])

    # constants
    if symbol.type == SymbolType.String:
        return Function(symbol.name)

    # numbers
    if symbol.type == SymbolType.Number:
        return Number(symbol.number)

    raise RuntimeError("Not a symbol!")