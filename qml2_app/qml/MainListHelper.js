function version() {
    return 2.0;
}

function calculate(val1, val2, count) {
    console.log("val1: " + val1 + "; val2: " + val2 + "; text: " + count)
    var result = val1 * count / val2 //from_formatted(text)
    console.log("calculate result:" + result)
    return result
}

function to_formatted(arg) {
    var result = NaN
    if (arg !== NaN) {
        result = arg.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ')
    }

    return result
}

function from_formatted(arg) {
    arg = arg.toString()
    return parseFloat(arg.replace(/\s/g,''))
}

function elemFromParams(index, model) {
    console.log("elemFromParams-> : ", model.get(index, EnumProvider.ColorNameRole))
    return ({"name":model.get(index, EnumProvider.NameRole),
                "code":model.get(index, EnumProvider.CodeRole),
                "color_val":model.get(index, EnumProvider.ColorNameRole),
                "value":model.get(index, EnumProvider.ValueRole)
            })
}

function Model_context(model, index, countText) {
//    console.assert(typeof countText == "stirng")
    this.model = model;
    this.index = index;
    this.other_index = index ? 0 : 1
    this.count = from_formatted(countText)
}

Model_context.prototype.cur_val = function() {
    return this.model.get(this.index).value
}

Model_context.prototype.other_val = function() {
    return this.model.get(this.other_index).value
}

Model_context.prototype.calculate = function() {
    return calculate(this.cur_val(), this.other_val(), this.count)
}

Model_context.prototype.formatted_calc = function() {
    return to_formatted(this.calculate())
}


