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
    return ({"name":model.get(index, EnumProvider.NameRole),
                "code":model.get(index, EnumProvider.CodeRole),
                "color_val":model.get(index, EnumProvider.ColorNameRole),
                "value":model.get(index, EnumProvider.ValueRole)
            })
}

// Index - index from main list 0 or 1
// Settings - QSettings subclass
function elemFromSettings(index, settings, engine) {
    var path_string = "main/" + engine + "/" + index
    var name = settings.value(path_string + "/name", "Tap to select currency")
    var val = settings.value(path_string + "/value", "NaN")
    console.log("Reading value for index: " + index + " - " + val)
    var colorCode = settings.value(path_string + "/colorCode", "#888")
    var code = settings.value(path_string + "/code", "UND")

    return ({"name":name,
                "value":parseFloat(val),
                "color_val":colorCode,
                "code":code
            })
}

// index - currency model index
// model - currency model
// settings - QSettings subclass
// root_index - inex from root model to store to
function writeToSettings(index, model, settings, root_index) {
    var path_string = "main/" + model.parser + "/" + root_index
    settings.setValue(path_string + "/name", model.get(index, EnumProvider.NameRole))
    settings.setValue(path_string + "/value", model.get(index, EnumProvider.ValueRole))
    settings.setValue(path_string + "/colorCode", model.get(index, EnumProvider.ColorNameRole))
    settings.setValue(path_string + "/code", model.get(index, EnumProvider.CodeRole))
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

//settings helper
function sts_hlpr(settings) {
    this.settings = settings
}

function engine(p_engine) {
    this.engine = p_engine
    return this
}

function index(index) {
    this.index = index
    return this
}

sts_hlpr.prototype.engine = engine
engine.prototype.index = index

engine.prototype.path = function() {
    return "main/" + this.engine
}

index.prototype.path = function() {
    return __proto__.path + "/" + index
}

index.prototype.name = function() {
    return this.settings(this.path + "/name", "NaN")
}

function make_path() {
    var i, res
    res = "main/"
    for (i = 0; i < arguments.length; i++) {
        res += arguments[i]
        if (i < arguments.length - 1) {
            res += "/"
        }
    }
    return res
}


