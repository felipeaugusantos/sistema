unit untCotacaoDiariaCombustiveis;

interface

uses
  Classes, StrUtils, SysUtils, Uni, UniClientDataSet, UniDataSetProvider, DB,
  Forms;

type
  TCotacaoDiariaCombustiveis = Class(TComponent)
  private
    FQuery  : TUniQuery;
    FDtaCot : String;
    FVlrGas : Double;
    FVlrEta : Double;
    FVlrDie : Double;
    FVlrS10 : Double;
    FCodEmp : String;

    procedure pAfterOpen(ADataSet: TDataSet);

  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    property qryCadCmb : TUniQuery read FQuery;

    property strDtaCot : String    Read FDtaCot Write FDtaCot;
    property fltVlrGas : Double    Read FVlrGas Write FVlrGas;
    property fltVlrEta : Double    Read FVlrEta Write FVlrEta;
    property fltVlrDie : Double    Read FVlrDie Write FVlrDie;
    property fltVlrS10 : Double    Read FVlrS10 Write FVlrS10;
    property strCodEmp : String    Read FCodEmp Write FCodEmp;

  end;

implementation

uses
  untFuncoesSimples;

{ TCotacaoDiariaCombustiveis }

constructor TCotacaoDiariaCombustiveis.Create(Owner: TComponent);
begin
  inherited;

  FQuery := fCriaQuery(Self);

  FQuery.SQL.Text  := ' SELECT * FROM CADCMB WHERE FALSE ';
  FQuery.AfterOpen := pAfterOpen;
end;

destructor TCotacaoDiariaCombustiveis.Destroy;
begin
  if Assigned(FQuery) then
    FreeAndNil(FQuery);

  inherited;
end;

procedure TCotacaoDiariaCombustiveis.pAfterOpen(ADataSet: TDataSet);
begin
  (ADataSet.FieldByName('CMB_DTACOT') As TDateTimeField).DisplayFormat := 'dd/mm/yyyy';
  (ADataSet.FieldByName('CMB_DTACOT') As TDateTimeField).EditMask      := '!99/99/0000;1;_';

  (ADataSet.FieldByName('CMB_VLRGAS') As TFloatField).DisplayFormat := '#,##0.000';
  (ADataSet.FieldByName('CMB_VLRGAS') As TFloatField).EditFormat    := '###0.000';

  (ADataSet.FieldByName('CMB_VLRETA') As TFloatField).DisplayFormat := '#,##0.000';
  (ADataSet.FieldByName('CMB_VLRETA') As TFloatField).EditFormat    := '###0.000';

  (ADataSet.FieldByName('CMB_VLRDIE') As TFloatField).DisplayFormat := '#,##0.000';
  (ADataSet.FieldByName('CMB_VLRDIE') As TFloatField).EditFormat    := '###0.000';

  (ADataSet.FieldByName('CMB_VLRS10') As TFloatField).DisplayFormat := '#,##0.000';
  (ADataSet.FieldByName('CMB_VLRS10') As TFloatField).EditFormat    := '###0.000';
end;

end.
