module szymanowski.math.arith.matrix;

// TODO: use templateing for matrix unless the rings have different 
// implementations;
class Matrix
{
	public:

	uint RowCount() const
	{
		return rows;
	};
	abstract void RowCount(uint val);

	uint ColumnCount() const
	{
		return columns;
	};
	abstract void ColumnCount(uint val);

	abstract int ToZeroMatrix();
	abstract int ToZero(int row, int col);
	abstract int ToOne(int row, int col);
	abstract int ToUnitMatrix();
	abstract int Rank() const;
	
	abstract bool IsConstant();
	abstract bool IsZeroMatrix();
	abstract bool IsUnit();
	final bool IsSquare()
	{
		return rows == columns;
	};
	abstract bool IsRegularMatrix();
	abstract bool IsZero(uint row, uint col);
	abstract bool IsOne(uint row, uint col);
	bool IsZeroRow(uint r)
	{
		for (uint i = 0; i < ColumnCount; i++) {
			if (!IsZero(r, i)) {
				return false;
			}
		}
		return true;
	};
	bool IsZeroColumn(uint c)
	{
		for (uint j = 0; j < RowCount; j++) {
			if (!IsZero(j, c)) {
				return false;
			}
		}
		return true;
	};
	final bool IsSameSize(ref Matrix m) {
		return rows == m.rows && columns == m.columns;
	};
	final static bool IsSameSize(ref Matrix m1, ref Matrix m2)
	{
		return m1.IsSameSize(m2);
	};
	final bool IsProductPossible(ref Matrix m)
	{
		return columns == m.rows;
	};
	final static bool IsProductPossible(ref Matrix m1, ref Matrix m2)
	{
		return m1.IsProductPossible(m2);
	};

	abstract string ToString();
	// abstract bool equals(Object object);
	// requires reflection

	// odd way of writing code int CompareTo(Matrix object)

	protected:
	this(uint rows, uint columns)
	in {
		assert(rows >= 0);
		assert(columns >= 0);
	} do {
		this.rows = rows;
		this.columns = columns;
	};

	uint rows;
	uint columns;
};