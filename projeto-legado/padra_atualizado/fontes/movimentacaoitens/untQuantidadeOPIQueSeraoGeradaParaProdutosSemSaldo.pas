unit untQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesSimples, EditFocus, untZClient;

type
  TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo = class(TfrmPaiEdit)
    Label1: TLabel;
    btnConfirma: TBitBtnLocked;
    edtQuantidade: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    FDataSet: TZClient;
    FCodIte : String;
    FCodCor : String;

    { Private declarations }

  public
    { Public declarations }

    property DataSet: TZClient read FDataSet write FDataSet;
    property strCodIte: String read FCodIte write FCodIte;
    property strCodCor: String read FCodCor write FCodCor;

  end;

var
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo: TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo;

implementation

{$R *.dfm}

procedure TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.btnConfirmaClick(
  Sender: TObject);
Var
  i: Integer;
  strCodIte,
  strCodCor,
  strNomIte,
  strNomCor: String;
  fltSaldos,
  fltQtdTotAcumulado,
  fltQTDTOT: Double;
begin
  inherited;
  If fEmptyStr(edtQuantidade.Text) Then
  Begin
    pMensagemOK('Informe uma quantidade para geração da OPI!');
    Exit;
  End;

  i:= strToInt(edtQuantidade.Text);
  If FDataSet <> Nil Then
  Begin

    strCodIte:= FDataSet.FieldByName('CODITE').AsString;
    strCodCor:= FDataSet.FieldByName('CODCOR').AsString;
    strNomIte:= FDataSet.FieldByName('NOMITE').AsString;
    strNomCor:= FDataSet.FieldByName('NOMCOR').AsString;
    fltSaldos:= FDataSet.FieldByName('SALDOS').AsFloat;
    fltQtdTotAcumulado:= (FDataSet.FieldByName('QTDTOTACUMULADO').AsFloat / i);
    fltQTDTOT:= (FDataSet.FieldByName('QTDTOT').AsFloat / i);

    FDataSet.First;
    While Not(FDataSet.Eof) Do
    Begin
      If FDataSet.Locate('CODITE;CODCOR', VarArrayOf([FCodIte, FCodCor]), []) Then
        FDataSet.Delete;
      FDataSet.Next;
    End;

    for i := 0 to i - 1 do
    Begin
      FDataSet.Insert;
      FDataSet.FieldByName('CODITE').AsString:= strCodIte;
      FDataSet.FieldByName('CODCOR').AsString:= strCodCor;
      FDataSet.FieldByName('NOMITE').AsString:= strNomIte;
      FDataSet.FieldByName('NOMCOR').AsString:= strNomCor;
      FDataSet.FieldByName('SALDOS').AsFloat := fltSaldos;
      FDataSet.FieldByName('QTDTOTACUMULADO').AsFloat:= fltQtdTotAcumulado;
      FDataSet.FieldByName('QTDTOT').AsFloat := fltQtdTot;
      FDataSet.FieldByName('DETALHE').AsString:= '';
      FDataSet.Post;
    End;


  End;

end;

procedure TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.FormCreate(
  Sender: TObject);
begin
  inherited;

  FCodIte :='';
  FCodCor :='';

  FDataSet:= Nil;

end;

procedure TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.FormDestroy(
  Sender: TObject);
begin
  inherited;
  //FreeAndNil(FDataSet);
end;

procedure TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.FormShow(
  Sender: TObject);
begin
  inherited;
  pSetFocus(edtQuantidade);
end;

end.
