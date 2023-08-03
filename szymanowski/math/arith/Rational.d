module szymanowski.math.arith.Rational;
import std.math;

struct Rational
{
	public:
	int num = 0;
	int denom = 1;

	// TODO: one constructor had denom that figured out its reduction
	// of fractions

	bool Reduce()
	{
		return true;
	};

	Rational Dup()
	{
		Rational to_ret = {num, denom};
		return to_ret;
	};
	
	static Rational Fraction(int n, int d)
	{
		Rational to_ret = {n, d};
		to_ret.Reduce();
		return to_ret;
	};
	static Rational FromQuant(real d, int quant)
	{
		Rational to_ret = {cast(int) round(d * quant), quant};
		to_ret.Reduce();
		return to_ret;
	};
	static Rational FromQuant(real d)
	{
		return Rational.FromQuant(d, DEFAULT_QUANT);
	};
	static Rational FromRational(Rational r, int quant)
	{
		int qu = (quant < 0) ? -quant : quant;
		Rational to_ret = r.Dup();
		int sign = 1;
		if (to_ret.num < 0) {
			sign = -1;
			to_ret.num = -to_ret.num;
		}

		long q = (to_ret.num * qu) / to_ret.denom;
		long s = (to_ret.num * qu) % to_ret.denom;
		if (s * 2 > to_ret.denom) {
			q++;
		}
		to_ret.num = sign * cast(int) q;
		to_ret.denom = quant;
		to_ret.Reduce();

		return to_ret;
	};
	static Rational FromString(string s)
	{
		Rational to_ret;
		return to_ret;
	};

	private:
	const static int INITIAL_DEFAULT_QUANT = 128 * 3 * 5;
	static int DEFAULT_QUANT = 128 * 3 * 5;
};