unit untQckChqTransf;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiQck, RLReport, RLParser, RLPreviewForm, DB;

type
  TfrmQckChqTransf = class(TfrmPaiQck)
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    lblDataCampo: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel8: TRLLabel;
    RLBand1: TRLBand;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    rllEmpresa: TRLLabel;
    rllEmpDestino: TRLLabel;
    RLDBText1: TRLDBText;
    rdbDtaVen: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText2: TRLDBText;
    dtsCheque: TDataSource;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText10BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rdbDtaVenBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel15BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel16BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
  private
    curValor, curValorTot: Currency;
    intNumChq, intNumChqTot: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untFuncoesGenerica, untfuncoesSimples;

{$R *.dfm}

procedure TfrmQckChqTransf.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmQckChqTransf.RLDBText10BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
  Var strNomCli: String;
begin
  inherited;
  strNomCli := fRetNomCliente(dtsCheque.DataSet.FieldByName('CHQ_CODCLI').AsString);
  Text := dtsCheque.DataSet.FieldByName('CHQ_CODCLI').AsString + '-' + strNomCli;
end;

procedure TfrmQckChqTransf.rdbDtaVenBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FormatDateTime('dd/mm/yyyy', dtsCheque.DataSet.FieldByName('CHQ_DTACAD').AsDateTime);
end;

procedure TfrmQckChqTransf.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text        := FloatToStrF(dtsCheque.DataSet.FieldByName('CHQ_VALCHQ').AsCurrency,ffNumber,15,2);
  curValor    := curValor + dtsCheque.DataSet.FieldByName('CHQ_VALCHQ').AsCurrency;
  curValorTot := curValorTot + dtsCheque.DataSet.FieldByName('CHQ_VALCHQ').AsCurrency;
  Inc(intNumChq);
  Inc(intNumChqTot);
end;

procedure TfrmQckChqTransf.RLLabel15BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text         := IntToStr(intNumChqTot) + ' Cheque(s)';
  intNumChqTot := 0;
end;

procedure TfrmQckChqTransf.RLLabel16BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text        := FloatToStrF(curValorTot,ffNumber,15,2);
  curValorTot := 0;
end;

procedure TfrmQckChqTransf.RLDBText4BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := fFormataFone(dtsCheque.DataSet.FieldByName('CHQ_TELEMI').AsString);
end;

end.
