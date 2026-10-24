unit untQckCadFichaFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, RLParser, DB, Uni, RLPreviewForm;

type
  TfrmQckCadFichaFornecedor = class(TForm)
    qckPagina: TRLReport;
    rlbTitulo: TRLBand;
    RLDraw14: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw1: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw38: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw30: TRLDraw;
    RLDraw29: TRLDraw;
    RLDraw28: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw16: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw13: TRLDraw;
    RLDraw12: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw7: TRLDraw;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLDraw42: TRLDraw;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLDraw5: TRLDraw;
    RLDraw2: TRLDraw;
    RLLabel5: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel1: TRLLabel;
    rldbEndere: TRLDBText;
    rldbNomeFan: TRLDBText;
    rldbCodFor: TRLDBText;
    rldbDtaCad: TRLDBText;
    rldbBairro: TRLDBText;
    rldbNomeCid: TRLDBText;
    rldbEstado: TRLDBText;
    rldbCep: TRLDBText;
    rldbCGC: TRLDBText;
    rldbIncricao: TRLDBText;
    rldbFone01: TRLDBText;
    rldbFone02: TRLDBText;
    rldbFax: TRLDBText;
    rldbContato: TRLDBText;
    rldbEmail: TRLDBText;
    rldbHomep: TRLDBText;
    rldbAtividade: TRLDBText;
    rldbCndPag: TRLDBText;
    RLDraw6: TRLDraw;
    RLLabel2: TRLLabel;
    rldbCaipos: TRLDBText;
    RLDraw8: TRLDraw;
    rldbNome: TRLDBText;
    RLLabel3: TRLLabel;
    RLDraw9: TRLDraw;
    RLLabel7: TRLLabel;
    RLLabel4: TRLLabel;
    rldb0800: TRLDBText;
    RLDraw15: TRLDraw;
    RLLabel6: TRLLabel;
    rldbNumRG: TRLDBText;
    rldbCodTra: TRLDBText;
    rldbCusto: TRLDBText;
    rldbMatRev: TRLDBText;
    rldbObserv: TRLDBMemo;
    rldbConCon: TRLDBText;
    rldbPerCon: TRLDBText;
    RLExpressionParser1: TRLExpressionParser;
    RLLabel13: TRLLabel;
    rldbStatus: TRLDBText;
    dtsRelatorio: TDataSource;
    RLDraw20: TRLDraw;
    rllENDNUM: TRLLabel;
    rldbENDNUM: TRLDBText;
    rpsSetup: TRLPreviewSetup;
    procedure rldbMatRevBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryRelatorio: TUniQuery;
  end;


implementation

uses  untFuncoesGenerica;

{$R *.dfm}

procedure TfrmQckCadFichaFornecedor.FormCreate(Sender: TObject);
begin
  rldbFone01.DisplayMask := fRetMascaraFonePais;
  rldbFone02.DisplayMask := fRetMascaraFonePais;
  rldbFax.DisplayMask    := fRetMascaraFonePais;
end;

procedure TfrmQckCadFichaFornecedor.rldbMatRevBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  If Text = 'I' Then
    Text := 'Indústria'
  Else If Text = 'C' Then
    Text := 'Comércio'
  Else If Text = 'R' Then
    Text := 'Revenda';
end;

end.
