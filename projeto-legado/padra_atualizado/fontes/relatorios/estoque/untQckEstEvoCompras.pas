unit untQckEstEvoCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiQck, RLPreviewForm, RLParser, RLReport, Data.DB;

type
  TfrmQckEstEvoCompras = class(TfrmPaiQck)
    rllLinhaGrupoHeader: TRLLabel;
    rllProdutoHeader: TRLLabel;
    rllUnidadeHeader: TRLLabel;
    rllFornecedorHeader: TRLLabel;
    rllProduto: TRLLabel;
    rllMes6: TRLLabel;
    rllMes7: TRLLabel;
    rllMes8: TRLLabel;
    rllMes9: TRLLabel;
    rllMes10: TRLLabel;
    rllMes11: TRLLabel;
    rllMes12: TRLLabel;
    rllTotDta: TRLLabel;
    rdbQuebra: TRLDBText;
    rdbCodIte: TRLDBText;
    rdbDta0012: TRLDBText;
    rdbTotDta: TRLDBText;
    rllTotais: TRLLabel;
    rdbTotDta6: TRLDBResult;
    rdbTotDta7: TRLDBResult;
    rdbTotDta8: TRLDBResult;
    rdbTotDta9: TRLDBResult;
    rdbTotDta10: TRLDBResult;
    rdbTotDta11: TRLDBResult;
    rdbTotDta12: TRLDBResult;
    rdbTotDtaTot: TRLDBResult;
    rlbTotalGeral: TRLBand;
    rllTotal5: TRLLabel;
    rdbGerDta6: TRLDBResult;
    rdbGerDta7: TRLDBResult;
    rdbGerDta8: TRLDBResult;
    rdbGerDta9: TRLDBResult;
    rdbGerDta10: TRLDBResult;
    rdbGerDta11: TRLDBResult;
    rdbGerDta12: TRLDBResult;
    rdbTotDtaGer: TRLDBResult;
    rdbCodIte2: TRLDBText;
    rdbDta006_2: TRLDBText;
    rdbDta007_2: TRLDBText;
    rdbDta008_2: TRLDBText;
    rdbDta009_2: TRLDBText;
    rdbDta0010_2: TRLDBText;
    rdbDta0011_2: TRLDBText;
    rdbDta0012_2: TRLDBText;
    rdbTotDta_2: TRLDBText;
    rllEmpresaHeader: TRLLabel;
    rllMes4: TRLLabel;
    rllMes3: TRLLabel;
    rllMes2: TRLLabel;
    rllMes5: TRLLabel;
    rllMes1: TRLLabel;
    rdbTotDta2: TRLDBResult;
    rdbTotDta3: TRLDBResult;
    rdbTotDta4: TRLDBResult;
    rdbTotDta5: TRLDBResult;
    rdbTotDta1: TRLDBResult;
    rdbDta001_2: TRLDBText;
    rdbDta002_2: TRLDBText;
    rdbDta003_2: TRLDBText;
    rdbDta004_2: TRLDBText;
    rdbDta005_2: TRLDBText;
    rdbGerDta1: TRLDBResult;
    rdbGerDta2: TRLDBResult;
    rdbGerDta3: TRLDBResult;
    rdbGerDta4: TRLDBResult;
    rdbGerDta5: TRLDBResult;
    rdbDta006: TRLDBText;
    rdbDta007: TRLDBText;
    rdbDta008: TRLDBText;
    rdbDta009: TRLDBText;
    rdbDta0010: TRLDBText;
    rdbDta0011: TRLDBText;
    rdbDta002: TRLDBText;
    rdbDta003: TRLDBText;
    rdbDta005: TRLDBText;
    rdbDta004: TRLDBText;
    rdbDta001: TRLDBText;
    rllMarcaHeader: TRLLabel;
    rlgLinha: TRLGroup;
    rltLinha: TRLBand;
    RLDBText1: TRLDBText;
    RLGroup1: TRLGroup;
    RLBand1: TRLBand;
    RLDBText2: TRLDBText;
    rlbResumoGrupo2: TRLBand;
    RLLabel1: TRLLabel;
    rdg_TotG006: TRLDBResult;
    rdg_TotG007: TRLDBResult;
    rdg_TotG008: TRLDBResult;
    rdg_TotG009: TRLDBResult;
    rdg_TotG010: TRLDBResult;
    rdg_TotG011: TRLDBResult;
    rdg_TotG012: TRLDBResult;
    rdbTotDtaGruTot: TRLDBResult;
    rdg_TotG002: TRLDBResult;
    rdg_TotG003: TRLDBResult;
    rdg_TotG004: TRLDBResult;
    rdg_TotG005: TRLDBResult;
    rdg_TotG001: TRLDBResult;
    rlbResumoLinha: TRLBand;
    RLLabel3: TRLLabel;
    rdg_TotL006: TRLDBResult;
    rdg_TotL007: TRLDBResult;
    rdg_TotL008: TRLDBResult;
    rdg_TotL009: TRLDBResult;
    rdg_TotL010: TRLDBResult;
    rdg_TotL011: TRLDBResult;
    rdg_TotL012: TRLDBResult;
    rdbTotDtaLinTot: TRLDBResult;
    rdg_TotL002: TRLDBResult;
    rdg_TotL003: TRLDBResult;
    rdg_TotL004: TRLDBResult;
    rdg_TotL005: TRLDBResult;
    rdg_TotL001: TRLDBResult;
    rlbDetGrupo: TRLBand;
    RLDBText3: TRLDBText;
    rdg_Mes012: TRLDBText;
    rdbTotDtaGru: TRLDBText;
    rdg_Mes006: TRLDBText;
    rdg_Mes007: TRLDBText;
    rdg_Mes008: TRLDBText;
    rdg_Mes009: TRLDBText;
    rdg_Mes010: TRLDBText;
    rdg_Mes011: TRLDBText;
    rdg_Mes002: TRLDBText;
    rdg_Mes003: TRLDBText;
    rdg_Mes005: TRLDBText;
    rdg_Mes004: TRLDBText;
    rdg_Mes001: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    dtsRelatorio: TDataSource;
    rllGrupoCompra: TRLLabel;
    procedure rdbCodIteBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllNomeRelatorioBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllFornecedorHeaderBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllLinhaGrupoHeaderBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllProdutoHeaderBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllUnidadeHeaderBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllEmpresaHeaderBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllMarcaHeaderBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllGrupoCompraBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

    strNomRelatorio : String;
    strFornecedor   : String;
    strLinhaGrupo   : String;
    strNomProduto   : String;
    strNomUnidade   : String;
    strLinhaEmpr    : String;
    strLinhaMarca   : String;
    strGruCmp       : String;
    intOpcao        : Integer;

  end;

var
  frmQckEstEvoCompras: TfrmQckEstEvoCompras;

implementation

{$R *.dfm}

procedure TfrmQckEstEvoCompras.rdbCodIteBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If intOpcao = 4 Then
    Text := Text + '-' + dtsRelatorio.dataSet.FieldByName('NOMFOR').AsString
  Else
    Text := Text + '-' + dtsRelatorio.dataSet.FieldByName('DESITE').AsString;

end;

procedure TfrmQckEstEvoCompras.rllNomeRelatorioBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strNomRelatorio;

end;

procedure TfrmQckEstEvoCompras.rllFornecedorHeaderBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  inherited;

   Text := strFornecedor;

end;

procedure TfrmQckEstEvoCompras.rllGrupoCompraBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := strGruCmp;
end;

procedure TfrmQckEstEvoCompras.rllLinhaGrupoHeaderBeforePrint(
  Sender: TObject; var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strLinhaGrupo;
   
end;

procedure TfrmQckEstEvoCompras.rllProdutoHeaderBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strNomProduto;
  
end;

procedure TfrmQckEstEvoCompras.rllUnidadeHeaderBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strNomUnidade;
   
end;

procedure TfrmQckEstEvoCompras.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := strOrdem;

end;

procedure TfrmQckEstEvoCompras.rllEmpresaHeaderBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strLinhaEmpr;
end;

procedure TfrmQckEstEvoCompras.rllMarcaHeaderBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strLinhaMarca;
end;

end.

