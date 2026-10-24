unit LalaMove.Cities;

interface

type
  TLalaMoveDimension = class
  private
    Fvalue: string;
    Funit: string;
  public
    property value: string read Fvalue write Fvalue;
    property &unit: string read Funit write Funit;
  end;

  TLalaMoveDimensions = class
  private
    Flength: TLalaMoveDimension;
    Fwidth: TLalaMoveDimension;
    Fheight: TLalaMoveDimension;
  public
    property length: TLalaMoveDimension read Flength write Flength;
    property width: TLalaMoveDimension read Fwidth write Fwidth;
    property height: TLalaMoveDimension read Fheight write Fheight;
  End;

  TLalaMoveSpecialRequest = class
  private
    Fname: string;
    Fdescription: string;
    Fparent_type: string;
    Fmax_selection: integer;
    Feffective_time: string;
    Foffline_time: string;
  public
    property name: string read Fname write Fname;
    property description: string read Fdescription write Fdescription;
    property parent_type: string read Fparent_type write Fparent_type;
    property max_selection: integer read Fmax_selection write Fmax_selection;
    property effective_time: string read Feffective_time write Feffective_time;
    property offline_time: string read Foffline_time write Foffline_time;
  End;

  TLalaMoveService = class
  private
    Fkey: string;
    Fdescription: string;
    Fdimensions: TLalaMoveDimensions;
    Fload: TLalaMoveDimension;
    FspecialRequests: TArray<TLalaMoveSpecialRequest>;
  public
    property key: string read Fkey write Fkey;
    property description: string read Fdescription write Fdescription;
    property dimensions: TLalaMoveDimensions read Fdimensions write Fdimensions;
    property load: TLalaMoveDimension read Fload write Fload;
    property specialRequests: TArray<TLalaMoveSpecialRequest> read FspecialRequests write FspecialRequests;
  End;

  TLalaMoveCity = class
  private
    Flocode: string;
    Fname: string;
    Fservices: TArray<TLalaMoveService>;
  public
    property locode: string read Flocode write Flocode;
    property name: string read Fname write Fname;
    property services: TArray<TLalaMoveService> read Fservices write Fservices;
  End;

  TLalaMoveCities = class
  private
    Fdata : TArray<TLalaMoveCity>;
  public
    property data: TArray<TLalaMoveCity> read Fdata write Fdata;
  End;

implementation

end.
