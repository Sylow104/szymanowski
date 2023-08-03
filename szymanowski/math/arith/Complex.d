module szymanowski.math.arith.Complex;
import std.math;
import std.conv;

class ComplexException : Exception
{
	this(string func)
	{
		super(func ~ " -- exception on Complex struct");
	};
};

struct Complex
{
	real re = 0;
	real im = 0;

	int CompareTo(Complex c)
	{
		if (re < c.re) return -1;
		if (re > c.re) return 1;
		if (im < c.im) return -1;
		if (im > c.im) return 1;
		return 0;
	};
	string ToString()
	{
		return text(re) ~ "+i" ~ text(im);
	};

	int ReInt() const
	{
		return cast(int) round(re);
	};
	long ReLong() const
	{
		return cast(long) round(re);
	};
	float ReFloat() const
	{
		return cast(float) re;
	};
	double ReDouble() const
	{
		return cast(double) re;
	};

	Complex Conjugate()
	{
		return Complex(this.re, -this.im);
	};
	Complex Inverse()
	{
		real d = pow(re, 2) + pow(im, 2);
		return Conjugate()/d;
	};
	Complex Invert()
	{
		real d = pow(re, 2) + pow(im, 2);
		return Complex(re/d, -im/d);
	};
	Complex Sqrt()
	{
		real m = sqrt(this.Abs());
		real a = this.Arg()/2;
		return FromPolar(m, a);
	};
	Complex Log()
	{
		real a = log(this.Abs());
		real b = this.Arg();
		return Complex(a,b);
	};
	Complex Exp()
	{
		return Complex(exp(re), im);
	};
	Complex Expt(Complex c)
	{
		real a1 = this.Abs();
		real b1 = this.Arg();
		Complex c1 = (c * log(a1)).Exp();
		Complex c2 = (Complex(0, b1) * c).Exp();
		return (c1 * c2);
	};
	Complex Sin()
	{
		Complex a = Complex(0, 1);
		a *= this;
		a = a.Exp();

		Complex b = Complex(0, -1);
		b *= this;
		b = b.Exp();

		a -= b;
		a /= Complex(0, 2);

		return a;
	};
	Complex Cos()
	{
		Complex a = Complex(0, 1);
		a *= this;
		a = a.Exp();

		Complex b = Complex(0, -1);
		b *= this;
		b = b.Exp();

		a += b;
		a /= Complex(2, 0);

		return a;
	};
	Complex Tan()
	{
		Complex a = Complex(0, 2);
		a *= this;
		a = a.Exp();

		Complex b = a;
		a.re--;
		b.im++;

		b *= Complex(0, 1);
		a /= b;
		return a;
	};
	Complex Asin()
	{
		Complex a = this * this;
		a = -a;
		a += 1;
		a = a.Sqrt();
		a += this * Complex(0, 1);
		a = a.Log();
		a *= Complex(0, 1);
		a = -a;
		return a;
	};
	Complex Acos()
	{
		Complex a = this * this;
		a = -a;
		a += 1;
		a = a.Sqrt();
		a += this * Complex(0, 1);
		a = a.Log();
		a *= Complex(0, 1);
		a += PI/2;

		return a;
	};
	Complex Atan(Complex c)
	{
		// Unimplemented: TODO
		return Complex(0, 0);
	};

	real Abs()
	{
		return sqrt(pow(re, 2) + pow(im, 2));
	};
	real Arg()
	{
		return atan2(im, re);
	};
	

	bool IsZero()
	{
		return (re == 0) && (im == 0);
	};
	bool IsOne()
	{
		return (re == 1) && (im == 1);
	};
	bool IsReal()
	{
		return (im == 0);
	};

	// for this library, use operator overloading here
	// we have two types, Complex overload and double overload
	Complex opBinary(string op)(Complex m)
	{
		Complex to_ret;
		switch (op) {
			case "+":
				to_ret.re = this.re + m.re;
				to_ret.im = this.im + m.im;
				break;
			case "-":
				to_ret.re = this.re - m.re;
				to_ret.im = this.im - m.im;
				break;
			case "*":
				to_ret.re = ReMult(this, m);
				to_ret.im = ImMult(this, m);
				break;
			case "/":
				to_ret.re = ReDiv(this, m);
				to_ret.im = ReDiv(this, m);
				break;
			default:
				throw new ComplexException("opBinary: '" ~ op ~ "'");
		}

		return to_ret;
	};

	Complex opBinary(string op)(real d)
	{
		Complex cast_in = Complex(d, 0);
		Complex to_ret = mixin("this" ~ op ~ "cast_in");
		return to_ret;
	};

	ref Complex opOpAssign(string op)(Complex m)
	{
		switch (op) {
			case "+=":
				re += m.re;
				im += m.im;
				break;
			case "-=":
				re -= m.re;
				im -= m.im;
				break;
			case "*=":
				re = ReMult(this, m);
				im = ImMult(this, m);
				break;
			case "/=":
				re = ReDiv(this, m);
				im = ImDiv(this, m);
				break;
			default:
				throw new ComplexException("opOpAssign: '" ~ op ~ "'");
		}
		return this;
	};

	ref Complex opOpAssign(string op)(real d)
	{
		Complex cast_in = Complex(d, 0);
		this = mixin("this" ~ op ~ "cast_in");
		return this;
	};

	Complex opUnary(string op)()
	{
		Complex to_ret;
		switch (op) {
			case "-":
				to_ret.re = -re;
				to_ret.im = -im;
				break;
			default:
				throw new ComplexException("opUnary: '" ~ op ~ "'");
		}
		return to_ret;
	};

	static Complex FromPolar(real r, double phi)
	{
		return Complex(r * cos(phi), r * sin(phi));
	};
	static Complex Zero()
	{
		return Complex(0);
	};
	static Complex One()
	{
		return Complex(1);
	};
	static Complex FromString(string to_parse)
	{
		Complex to_ret;
		return to_ret;
	};

	private:
	static real ReMult(ref Complex c1, ref Complex c2)
	{
		return ((c1.re * c2.re) - (c1.im * c2.im));
	};
	static real ImMult(ref Complex c1, ref Complex c2)
	{
		return ((c1.re * c2.im) - (c1.im * c2.re));
	};

	static real QuotDiv(ref Complex c1, ref Complex c2)
	{
		return ((pow(c2.re, 2) + pow(c2.im, 2)));
	};
	static real ReDiv(ref Complex c1, ref Complex c2)
	{
		return (((c1.re * c2.re) + (c1.im * c2.im))
			/ QuotDiv(c1, c2));
	};
	static real ImDiv(ref Complex c1, ref Complex c2)
	{
		return (((c1.im * c2.re) - (c1.re * c2.im))
			/ QuotDiv(c1, c2));
	};

	// Functions that are not ported
	// public static Complex parseComplex(string s);
	// public Object clone();
	// public int hashCode();
	// public Complex Atan(Complex c);
	
};

unittest
{
	Complex a = Complex(4, 1);
	Complex b = Complex(1, 2);

	Complex c = a + b;
	assert(c.re == 5);
	assert(c.im == 3);
	
	Complex d = a - b;
	assert(d.re == 3);
	assert(d.im == -1);

	Complex e = a - 2.5;
	assert(e.re == 1.5);
	assert(e.im == 1);
};