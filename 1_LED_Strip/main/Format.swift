// 2024-09-12 Paul Solt
// There is a bug in Embedded Swift support that cannot print floating point
// values, so this function is a workaround to print those values for debugging
// You can get more precision by multiplying by factor of 10 greater than 100

func format(double: Double) -> String {
    let int = Int(double)
    let frac = Int((double - Double(int)) * 100)
    return "\(int).\(frac)"
}
