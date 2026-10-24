unit untNotaFiscalImportValoresDiverg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, untTypesSistema;

type
  TTypeValores = (vlrMercadorias, vlrII, vlrIPI, vlrPIS, vlrCOFINS, txSiscomex,
    txAFRMM, vlrICMS);

type
  TfrmNotaFiscalImportValoresDiverg = class(TfrmPaiConfirma)
    dtsGrid: TDataSource;
    cxGrid: TcxGridCitel;
    cxGridTBV: TcxGridDBTableViewCitel;
    cxGridTBVDESITE: TcxGridDBColumn;
    cxGridTBVVLR_DI: TcxGridDBColumn;
    cxGridTBVVLR_NF: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridTBVUNIDAD: TcxGridDBColumn;
    cxGridTBVCODITE: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cdsDiverg: TUniClientDataSet;
    procedure pCriaDataSetDiverg;
  public
    { Public declarations }
    intIndex: Integer;
    cdsItens_DI: TUniClientDataSet;
    procedure pCarregaValores;
    function fExisteRegistrosDivergentes: Boolean;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untFuncFat;

{ TfrmNotaFiscalImportValoresDiverg }

procedure TfrmNotaFiscalImportValoresDiverg.FormCreate(Sender: TObject);
begin
  inherited;

  cdsDiverg := TUniClientDataSet.Create(Self);
  pCriaDataSetDiverg;
end;

procedure TfrmNotaFiscalImportValoresDiverg.FormDestroy(Sender: TObject);
begin
  inherited;

  dtsGrid.Dataset := Nil;
  FreeAndNil(cdsDiverg);
end;

procedure TfrmNotaFiscalImportValoresDiverg.FormShow(Sender: TObject);
begin
  inherited;
  dtsGrid.Dataset := cdsDiverg;
end;

procedure TfrmNotaFiscalImportValoresDiverg.pCarregaValores;
var
  strCampoDI,
  strCampoNF: String;
  tpValor: TTypeValores;
  prcScroll: TprcScroll;
begin
  tpValor := TTypeValores(intIndex);

  case tpValor of
    vlrMercadorias:
      begin
        strCampoDI := 'PCD_TOTITE_ORI';
        strCampoNF := 'ITE_TOTITE';
        Self.Caption := 'Valores Divergentes - Vlr. Mercadorias';
      end;
    vlrII:
      begin
        strCampoDI := 'XML_II_VII_ORI';
        strCampoNF := 'ITE_VAL_II';
        Self.Caption := 'Valores Divergentes - Vlr. Imposto de Importação';
      end;
    vlrIPI:
      begin
        strCampoDI := 'PCD_TOTIPI_ORI';
        strCampoNF := 'ITE_VALIPI';
        Self.Caption := 'Valores Divergentes - Vlr. IPI';
      end;
    vlrPIS:
      begin
        strCampoDI := 'PCD_VALPIS_ORI';
        strCampoNF := 'ITE_VALPIS';
        Self.Caption := 'Valores Divergentes - Vlr. PIS';
      end;
    vlrCOFINS:
      begin
        strCampoDI := 'PCD_VALCOF_ORI';
        strCampoNF := 'ITE_VALCOF';
        Self.Caption := 'Valores Divergentes - Vlr. COFINS';
      end;
    txSiscomex: ;
    txAFRMM:
      begin
        strCampoDI := 'XML_VAFRMM_ORI';
        strCampoNF := 'ITE_VAFRMM';
        Self.Caption := 'Valores Divergentes - Taxa AFRMM';
      end;
    vlrICMS:
      begin
        strCampoDI := 'PCD_VALICM_ORI';
        strCampoNF := 'ITE_VALICM';
        Self.Caption := 'Valores Divergentes - Vlr. ICMS Incorporado';
      end;
  end;

  pDisableControls(cdsItens_DI, prcScroll);
  cdsItens_DI.First;

  while not cdsItens_DI.Eof do
  begin
    cdsVenda.Locate('AUTOINCREM', cdsItens_DI.FieldByName('XML_INDEX_').AsInteger, []);

    if (fFormataFloat(cdsVenda.FieldByName(strCampoNF).AsFloat, 2) <> fFormataFloat(cdsItens_DI.FieldByName(strCampoDI).AsFloat, 2)) then
    begin
      cdsDiverg.Append;
      cdsDiverg.FieldByName('CODITE').AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
      cdsDiverg.FieldByName('DESITE').AsString := cdsVenda.FieldByName('ITE_DESITE').AsString;
      cdsDiverg.FieldByName('UNIDAD').AsString := cdsVenda.FieldByName('ITE_UNIDAD').AsString;
      cdsDiverg.FieldByName('VLR_DI').AsFloat  := cdsItens_DI.FieldByName(strCampoDI).AsFloat;
      cdsDiverg.FieldByName('VLR_NF').AsFloat  := cdsVenda.FieldByName(strCampoNF).AsFloat;
      cdsDiverg.Post;
    end;

    cdsItens_DI.Next;
  end;

  cdsItens_DI.First;
  pEnableControls(cdsItens_DI, prcScroll);
end;

procedure TfrmNotaFiscalImportValoresDiverg.pCriaDataSetDiverg;
begin
  cdsDiverg.FieldDefs.Add('CODITE', ftString, 5);
  cdsDiverg.FieldDefs.Add('DESITE', ftString, 70);
  cdsDiverg.FieldDefs.Add('UNIDAD', ftString, 2);
  cdsDiverg.FieldDefs.Add('VLR_DI', ftFloat);
  cdsDiverg.FieldDefs.Add('VLR_NF', ftFloat);
  cdsDiverg.CreateDataSet;

  (cdsDiverg.FieldByName('VLR_DI') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDiverg.FieldByName('VLR_DI') As TFloatField).EditFormat    := fMskDigitos(2);

  (cdsDiverg.FieldByName('VLR_NF') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDiverg.FieldByName('VLR_NF') As TFloatField).EditFormat    := fMskDigitos(2);
end;

function TfrmNotaFiscalImportValoresDiverg.fExisteRegistrosDivergentes: Boolean;
begin
  Result := not cdsDiverg.IsEmpty;
end;

end.
