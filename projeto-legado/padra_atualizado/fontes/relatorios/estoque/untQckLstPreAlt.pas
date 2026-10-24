unit untQckLstPreAlt;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiQck, RLReport, RLParser, RLPreviewForm, Data.DB,
  untIFuncoes;

type
  TfrmQckLstPreAlt = class(TfrmPaiQck)
    RLLabel1: TRLLabel;
    rllDesIte: TRLLabel;
    rllCodOpe: TRLLabel;
    rllHorAlt: TRLLabel;
    rllTitCustoAnt: TRLLabel;
    rllTitCustoAtu: TRLLabel;
    rllTitCusto: TRLLabel;
    rllMarAnt1: TRLLabel;
    rllMarAtu1: TRLLabel;
    rllTitMarBr1: TRLLabel;
    rllPreAnt1: TRLLabel;
    rllPreAtu1: TRLLabel;
    rllTitPreVe1: TRLLabel;
    rllMarAnt2: TRLLabel;
    rllMarAtu2: TRLLabel;
    rllTitMarBr2: TRLLabel;
    rldMarAnt2: TRLDBText;
    rdbHorAlt: TRLDBText;
    rdbCodOpe: TRLDBText;
    rdbDesIte: TRLDBText;
    RLDBText6: TRLDBText;
    rldMarAtu2: TRLDBText;
    rldPreAtu1: TRLDBText;
    rldPreAnt1: TRLDBText;
    rdbCustoAnt: TRLDBText;
    rdbCustoAtu: TRLDBText;
    rldMarAnt1: TRLDBText;
    rldMarAtu1: TRLDBText;
    rldPreAnt2: TRLDBText;
    rldPreAtu2: TRLDBText;
    rllTitPreVe2: TRLLabel;
    rllPreAnt2: TRLLabel;
    rllPreAtu2: TRLLabel;
    rlbRegistros: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    rllTitMarBr3: TRLLabel;
    rllMarAnt3: TRLLabel;
    rllMarAtu3: TRLLabel;
    rldMarAtu3: TRLDBText;
    rldMarAnt3: TRLDBText;
    rllTitPreVe3: TRLLabel;
    rllPreAtu3: TRLLabel;
    rllPreAnt3: TRLLabel;
    rldPreAtu3: TRLDBText;
    rldPreAnt3: TRLDBText;
    rllProduto: TRLLabel;
    RLDBText23: TRLDBText;
    RLDBText22: TRLDBText;
    rlbPreVen: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    rlbTituloResumido: TRLBand;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel38: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    rlbTituloFor: TRLBand;
    RLLabel5: TRLLabel;
    rllDesIte2: TRLLabel;
    rllDatAlt: TRLLabel;
    rllCodOpe2: TRLLabel;
    rllTitCustoAnt2: TRLLabel;
    rllTitCustoAtu2: TRLLabel;
    rllTitCusto2: TRLLabel;
    rllMarAntFor1: TRLLabel;
    rllMarAtuFor1: TRLLabel;
    rllTitMarBrFor1: TRLLabel;
    rllPreAntFor1: TRLLabel;
    rllPreAtuFor1: TRLLabel;
    rllTitPreVeFor1: TRLLabel;
    rllMarAntFor2: TRLLabel;
    rllMarAtuFor2: TRLLabel;
    rllTitMarBrFor2: TRLLabel;
    rllTitPreVeFor2: TRLLabel;
    rllPreAntFor2: TRLLabel;
    rllPreAtuFor2: TRLLabel;
    rllTitMarBrFor3: TRLLabel;
    rllMarAntFor3: TRLLabel;
    rllMarAtuFor3: TRLLabel;
    rllTitPreVeFor3: TRLLabel;
    rllPreAtuFor3: TRLLabel;
    rllPreAntFor3: TRLLabel;
    rlbGrupoOpe: TRLGroup;
    RLBand2: TRLBand;
    rlbDetalheFor: TRLBand;
    rldMarAntFor2: TRLDBText;
    rdbCodOpe2: TRLDBText;
    rdbDatAlt: TRLDBText;
    rdbDesIte2: TRLDBText;
    RLDBText11: TRLDBText;
    rldMarAtuFor2: TRLDBText;
    rldPreAtuFor1: TRLDBText;
    rldPreAntFor1: TRLDBText;
    rdbCustoAnt2: TRLDBText;
    rdbCustoAtu2: TRLDBText;
    rldMarAntFor1: TRLDBText;
    rldMarAtuFor1: TRLDBText;
    rldPreAntFor2: TRLDBText;
    rldPreAtuFor2: TRLDBText;
    rldMarAtuFor3: TRLDBText;
    rldMarAntFor3: TRLDBText;
    rldPreAtuFor3: TRLDBText;
    rldPreAntFor3: TRLDBText;
    RLBand4: TRLBand;
    RLLabel43: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    rllRefTitulo: TRLLabel;
    rllRefTitFor: TRLLabel;
    rllRefTitRes: TRLLabel;
    rlbRefDetGru: TRLDBText;
    rlbRefDetFor: TRLDBText;
    rlbRefDet: TRLDBText;
    rllDescricao: TRLLabel;
    rllRefere: TRLLabel;
    rllFornecedor: TRLLabel;
    rllDigitador: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText12: TRLDBText;
    RLLabel14: TRLLabel;
    rllFornec: TRLLabel;
    rllMarca: TRLLabel;
    rdbFornec: TRLDBText;
    rdbMarca: TRLDBText;
    rllOriTitulo: TRLLabel;
    rllOriTitFor: TRLLabel;
    rllOriTitRes: TRLLabel;
    rdbNomFrmGru: TRLDBText;
    rdbNomFrmFor: TRLDBText;
    rdbNomFrm: TRLDBText;
    dtsRelatorio: TDataSource;
    rllLocIni: TRLLabel;
    rllLocFisica: TRLLabel;
    rllLocFisicaFor: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    rllLocFisRes: TRLLabel;
    RLDBText4: TRLDBText;
    rllLocFin: TRLLabel;
    rllTitCompra: TRLLabel;
    rllTitCompraAnt: TRLLabel;
    rllTitCompraAtu: TRLLabel;
    rllTitCompra2: TRLLabel;
    rllTitCompraAnt2: TRLLabel;
    rllTitCompraAtu2: TRLLabel;
    rdbCompraAnt: TRLDBText;
    rdbCompraAtu: TRLDBText;
    rdbCompraAnt2: TRLDBText;
    rdbCompraAtu2: TRLDBText;
    procedure rlbRegistrosBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbGrupoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLSystemInfo1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbPreVenBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel43BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetalheForAfterPrint(Sender: TObject);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    dtaDatAlt: TDateTime;
    strForAlt: String;
  public
    { Public declarations }
    intPreUsa: integer;

    blnImpCus,
    blnImpMar,
    blnImpVen,
    blnImpCom: Boolean;
  end;

var
  frmQckLstPreAlt: TfrmQckLstPreAlt;

implementation

uses untfuncoesFactory;

{$R *.dfm}

procedure TfrmQckLstPreAlt.rlbRegistrosBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'TOTAL DE PRODUTOS LISTADOS REFERENTE AO DIA (-' +
  FormatDateTime('dd-mm-yyyy', dtaDatAlt) + '-) :';
end;

procedure TfrmQckLstPreAlt.rlbGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  dtaDatAlt := dtsRelatorio.DataSet.FieldByName('DTAALT').AsDateTime;
  strForAlt := dtsRelatorio.DataSet.FieldByName('CODFOR').AsString;
end;

procedure TfrmQckLstPreAlt.RLSystemInfo1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := fPadL(Text, 6, '0');
end;

procedure TfrmQckLstPreAlt.rlbPreVenBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Case intPreUsa Of
    1: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE1ATU').AsFloat);
    2: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE2ATU').AsFloat);
    3: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE3ATU').AsFloat);
    4: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE4ATU').AsFloat);
    5: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE5ATU').AsFloat);
    6: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE6ATU').AsFloat);
    7: Text := FormatFloat('#,##0.0000',dtsRelatorio.DataSet.FieldByName('VE7ATU').AsFloat);
  End;

end;

procedure TfrmQckLstPreAlt.RLLabel43BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'TOTAL DE PRODUTOS LISTADOS REFERENTE AO FORNECEDOR (-' +
  fPadR(strForAlt + '-' + fRetNomFornecedor(strForAlt), 41) + '-) :';
end;

procedure TfrmQckLstPreAlt.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  // COMPRA
  If Not blnImpCom Then
  Begin
    rllTitCompra.Visible     := blnImpCom;
    rllTitCompraAnt.Visible  := blnImpCom;
    rllTitCompraAtu.Visible  := blnImpCom;

    rllTitCompra2.Visible    := blnImpCom;
    rllTitCompraAnt2.Visible := blnImpCom;
    rllTitCompraAtu2.Visible := blnImpCom;

    rdbCompraAnt.Visible     := blnImpCom;
    rdbCompraAtu.Visible     := blnImpCom;

    rdbCompraAnt2.Visible    := blnImpCom;
    rdbCompraAtu2.Visible    := blnImpCom;
  End;

  // CUSTO
  If Not blnImpCus Then
  Begin
    rllTitCusto.Visible     := blnImpCus;
    rllTitCustoAnt.Visible  := blnImpCus;
    rllTitCustoAtu.Visible  := blnImpCus;

    rllTitCusto2.Visible    := blnImpCus;
    rllTitCustoAnt2.Visible := blnImpCus;
    rllTitCustoAtu2.Visible := blnImpCus;

    rdbCustoAnt.Visible     := blnImpCus;
    rdbCustoAtu.Visible     := blnImpCus;

    rdbCustoAnt2.Visible    := blnImpCus;
    rdbCustoAtu2.Visible    := blnImpCus;
  End;
  // MARGEM
  If Not blnImpMar Then
  Begin
    rllTitMarBr1.Visible    := blnImpMar;
    rllMarAnt1.Visible      := blnImpMar;
    rllMarAtu1.Visible      := blnImpMar;

    rllTitMarBrFor1.Visible := blnImpMar;
    rllMarAntFor1.Visible   := blnImpMar;
    rllMarAtuFor1.Visible   := blnImpMar;

    rldMarAnt1.Visible      := blnImpMar;
    rldMarAtu1.Visible      := blnImpMar;

    rldMarAntFor1.Visible   := blnImpMar;
    rldMarAtuFor1.Visible   := blnImpMar;

    rllTitMarBr2.Visible    := blnImpMar;
    rllMarAnt2.Visible      := blnImpMar;
    rllMarAtu2.Visible      := blnImpMar;

    rldMarAnt2.Visible      := blnImpMar;
    rldMarAtu2.Visible      := blnImpMar;

    rllTitMarBrFor2.Visible := blnImpMar;
    rllMarAntFor2.Visible   := blnImpMar;
    rllMarAtuFor2.Visible   := blnImpMar;

    rldMarAntFor2.Visible   := blnImpMar;
    rldMarAtuFor2.Visible   := blnImpMar;

    rllTitMarBr3.Visible    := blnImpMar;
    rllMarAnt3.Visible      := blnImpMar;
    rllMarAtu3.Visible      := blnImpMar;

    rllTitMarBrFor3.Visible := blnImpMar;
    rllMarAntFor3.Visible   := blnImpMar;
    rllMarAtuFor3.Visible   := blnImpMar;

    rldMarAnt3.Visible      := blnImpMar;
    rldMarAtu3.Visible      := blnImpMar;

    rldMarAntFor3.Visible   := blnImpMar;
    rldMarAtuFor3.Visible   := blnImpMar;
  End;
  // VENDA
  If Not blnImpVen  Then
  Begin
    rllTitPreVe1.Visible    := blnImpVen;
    rllPreAnt1.Visible      := blnImpVen;
    rllPreAtu1.Visible      := blnImpVen;

    rllTitPreVeFor1.Visible := blnImpVen;
    rllPreAntFor1.Visible   := blnImpVen;
    rllPreAtuFor1.Visible   := blnImpVen;

    rldPreAnt1.Visible      := blnImpVen;
    rldPreAtu1.Visible      := blnImpVen;

    rldPreAntFor1.Visible   := blnImpVen;
    rldPreAtuFor1.Visible   := blnImpVen;

    rllTitPreVe2.Visible    := blnImpVen;
    rllPreAnt2.Visible      := blnImpVen;
    rllPreAtu2.Visible      := blnImpVen;

    rldPreAnt2.Visible      := blnImpVen;
    rldPreAtu2.Visible      := blnImpVen;

    rllTitPreVeFor2.Visible := blnImpVen;
    rllPreAntFor2.Visible   := blnImpVen;
    rllPreAtuFor2.Visible   := blnImpVen;

    rldPreAntFor2.Visible   := blnImpVen;
    rldPreAtuFor2.Visible   := blnImpVen;

    rllTitPreVe3.Visible    := blnImpVen;
    rllPreAnt3.Visible      := blnImpVen;
    rllPreAtu3.Visible      := blnImpVen;

    rllTitPreVeFor3.Visible := blnImpVen;
    rllPreAntFor3.Visible   := blnImpVen;
    rllPreAtuFor3.Visible   := blnImpVen;

    rldPreAtu3.Visible      := blnImpVen;
    rldPreAnt3.Visible      := blnImpVen;

    rldPreAntFor3.Visible   := blnImpVen;
    rldPreAtuFor3.Visible   := blnImpVen;
  End;
end;

procedure TfrmQckLstPreAlt.rlbDetalheForAfterPrint(Sender: TObject);
begin
  inherited;
  If (rlbDetalheFor.Color = Cor1) Then
    rlbDetalheFor.Color := Cor2
  Else
    rlbDetalheFor.Color := Cor1;
end;

end.

