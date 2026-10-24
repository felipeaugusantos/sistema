unit LalaMove.Quotation;

interface

type
  TLalaMoveItem = class
  private
    Fquantity: string;
    Fweight: string;
    Fcategories: TArray<string>;
    FhandlingInstructions: TArray<string>;
  public
    property quantity: string read Fquantity write Fquantity;
    property weight: string read Fweight write Fweight;
    property categories: TArray<string> read Fcategories write Fcategories;
    property handlingInstructions: TArray<string> read FhandlingInstructions write FhandlingInstructions;
  End;

  TLalaMoveCoordinate = class
  private
    Flat: string;
    Flng: string;
  public
    property lat: string read Flat write Flat;
    property lng: string read Flng write Flng;
  End;

  TLalaMoveStop = class
  private
    Fcoordinates: TLalaMoveCoordinate;
    Faddress: string;
  public
    property coordinates: TLalaMoveCoordinate read Fcoordinates write Fcoordinates;
    property address: string read Faddress write Faddress;
  End;

  TLalaMoveQuotation = class
  private
    FserviceType: string;
    FspecialRequests: TArray<string>;
    Flanguage: string;
    Fstops: TArray<TLalaMoveStop>;
    Fitem: TLalaMoveItem;
    FisRouteOptimized: boolean;
    FscheduleAt: string;
  public
    property serviceType: string read FserviceType write FserviceType;
    property specialRequests: TArray<string> read FspecialRequests write FspecialRequests;
    property language: string read Flanguage write Flanguage;
    property stops: TArray<TLalaMoveStop> read Fstops write Fstops;
    property item: TLalaMoveItem read Fitem write Fitem;
    property isRouteOptimized: boolean read FisRouteOptimized write FisRouteOptimized;
    property scheduleAt: string read FscheduleAt write FscheduleAt;
  End;

  TLalaMoveGetQuotation = class
  private
    Fdata: TLalaMoveQuotation;
  public
    property data: TLalaMoveQuotation read Fdata write Fdata;
  End;

  TLalaMovePriceBreakdown = class
  private
    Fbase: string;
    FspecialRequests: string;
    Fvat: string;
    FtotalBeforeOptimization: string;
    FtotalExcludePriorityFee: string;
    Ftotal: string;
    Fcurrency: string;
  public
    property base: string read Fbase write Fbase;
    property specialRequests: string read FspecialRequests write FspecialRequests;
    property vat: string read Fvat write Fvat;
    property totalBeforeOptimization: string read FtotalBeforeOptimization write FtotalBeforeOptimization;
    property totalExcludePriorityFee: string read FtotalExcludePriorityFee write FtotalExcludePriorityFee;
    property total: string read Ftotal write Ftotal;
    property currency: string read Fcurrency write Fcurrency;
  End;

  TLalaMoveQuotationCreated = class
  private
    FserviceType: string;
    FspecialRequests: TArray<string>;
    Flanguage: string;
    Fstops: TArray<TLalaMoveStop>;
    Fitem: TLalaMoveItem;
    FisRouteOptimized: boolean;
    FquotationId : string;
    FpriceBreakdown: TLalaMovePriceBreakdown;
  public
    property serviceType: string read FserviceType write FserviceType;
    property specialRequests: TArray<string> read FspecialRequests write FspecialRequests;
    property language: string read Flanguage write Flanguage;
    property stops: TArray<TLalaMoveStop> read Fstops write Fstops;
    property item: TLalaMoveItem read Fitem write Fitem;
    property isRouteOptimized: boolean read FisRouteOptimized write FisRouteOptimized;
    property quotationId: string read FquotationId write FquotationId;
    property priceBreakdown: TLalaMovePriceBreakdown read FpriceBreakdown write FpriceBreakdown;
  End;

  TLalaMoveGetQuotationCreated = class
  private
    Fdata: TLalaMoveQuotationCreated;
  public
    property data: TLalaMoveQuotationCreated read Fdata write Fdata;
  End;

implementation

end.
