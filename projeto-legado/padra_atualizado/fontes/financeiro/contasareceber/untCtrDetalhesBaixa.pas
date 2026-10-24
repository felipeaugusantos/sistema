unit untCtrDetalhesBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni;

Type
  TDadosBaixa = class
    ASeqCon,
    ACodEmp,
    ACodCli: String;
  end;

type
  TfrmCtrDetalhesBaixa = class(TfrmPai)
    pnlGeral: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    btnSelChAvi: TBitBtnLocked;
    btnSelChPre: TBitBtnLocked;
    btnSelCartao: TBitBtnLocked;
    edtDinheiro: TEditFocus;
    edtChequeAVista: TEditFocus;
    edtChequePre: TEditFocus;
    edtCartao: TEditFocus;
    edtOrdemPgto: TEditFocus;
    edtFinanciamento: TEditFocus;
    Label22: TLabel;
    edtValRec: TEditFocus;
    Label5: TLabel;
    edtValJur: TEditFocus;
    Label7: TLabel;
    edtValDes: TEditFocus;
    lblValCob: TLabel;
    edtValCob: TEditFocus;
    procedure btnSelChAviClick(Sender: TObject);
    procedure btnSelChPreClick(Sender: TObject);
    procedure btnSelCartaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    LDadosBaixa:TDadosBaixa;
    function RetornaDadosDaBaixa: TDadosBaixa;

  public
    dtsCtaReceber: TDataSet;
  end;

var
  frmCtrDetalhesBaixa: TfrmCtrDetalhesBaixa;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{ TfrmCtrDetalhesBaixa }

procedure TfrmCtrDetalhesBaixa.btnSelCartaoClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(84, 5387, [],
                        ['SEQCON','CODEMP','CODCLI'],
                        [LDadosBaixa.ASeqCon, LDadosBaixa.ACodEmp, LDadosBaixa.ACodCli],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCtrDetalhesBaixa.btnSelChAviClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(86, 5389, [],
                        ['SEQCON','CODEMP'],
                        [LDadosBaixa.ASeqCon, LDadosBaixa.ACodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCtrDetalhesBaixa.btnSelChPreClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(85, 5388, [],
                        ['SEQCON','CODEMP'],
                        [LDadosBaixa.ASeqCon, LDadosBaixa.ACodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCtrDetalhesBaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(LDadosBaixa);
end;

procedure TfrmCtrDetalhesBaixa.FormShow(Sender: TObject);
begin
  inherited;
  edtDinheiro.Text      := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_DINHEI').AsFloat);
  edtChequeAVista.Text  := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_CHQAVI').AsFloat);
  edtChequePre.Text     := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_CHQPRE').AsFloat);
  edtCartao.Text        := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_CARTAO').AsFloat);
  edtOrdemPgto.Text     := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_ORDPAG').AsFloat);
  edtFinanciamento.Text := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_VALFIN').AsFloat);

  edtValRec.Text := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_VALREC').AsFloat);
  edtValJur.Text := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_VALJUR').AsFloat);
  edtValDes.Text := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_VALDES').AsFloat);
  edtValCob.Text := FormatFloat('#,##0.00', dtsCtaReceber.FieldByName('CTR_VALCOB').AsFloat);
  LDadosBaixa := RetornaDadosDaBaixa;
end;

function TfrmCtrDetalhesBaixa.RetornaDadosDaBaixa: TDadosBaixa;
  Var
    qryAux : TUniQuery;
begin
  Result := TDadosBaixa.Create;
  Result.ACodEmp := dtsCtaReceber.FieldByName('CTR_EMPBAI').AsString;
  Result.ASeqCon := dtsCtaReceber.FieldByName('CTR_SEQCON').AsString;
  Result.ACodCli := dtsCtaReceber.FieldByName('CTR_CODCLI').AsString;

  If Not dtsCtaReceber.FieldByName('CTR_ADTCLI').AsString.Equals('S') Then
    Exit;

  Try
    qryAux := fCriaQuery(Nil);
    With qryAux,SQL Do
    Begin
      Add('SELECT ADTCRE.ADT_SEQCON, ADTCRE.ADT_EMPLAN, ADTCRE.ADT_CODCLI ');
      Add('FROM CADREC ');
      Add('INNER JOIN ADTCLI ON CTR_SEQCON = ADT_SEQCON ');
      Add('INNER JOIN ADTCLI AS ADTCRE ON ADTCRE.ADT_TIPLAN = "C" ');
                                  Add('AND ADTCLI.ADT_NUMDOC = ADTCRE.ADT_NUMDOC ');
                                  Add('AND ADTCLI.ADT_ESPDOC = ADTCRE.ADT_ESPDOC ');
                                  Add('AND ADTCLI.ADT_CODEMP = ADTCRE.ADT_CODEMP ');
                                  Add('AND ADTCLI.ADT_CODCLI = ADTCRE.ADT_CODCLI ');
                                  Add('AND ADTCRE.ADT_ESTORN = "N" ');
      Add('WHERE CADREC.CTR_NUMDUP = :NUMDUP ');
      Add('AND CADREC.CTR_CODCLI = :CODCLI ');
      Add('AND CADREC.CTR_CODEMP = :CODEMP ');
      Add('AND CADREC.CTR_ESPDOC = :ESPDOC ');
      Add('AND CADREC.CTR_PARCEL = :PARCEL ');
      Add('AND CTR_SEQCON = :SEQCON');

      ParamByName('CODCLI').AsString := dtsCtaReceber.FieldByName('CTR_CODCLI').AsString;
      ParamByName('CODEMP').AsString := dtsCtaReceber.FieldByName('CTR_CODEMP').AsString;
      ParamByName('SEQCON').AsString := dtsCtaReceber.FieldByName('CTR_SEQCON').AsString;
      ParamByName('NUMDUP').AsString := dtsCtaReceber.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := dtsCtaReceber.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('PARCEL').AsString := dtsCtaReceber.FieldByName('CTR_PARCEL').AsString;
      Open;

      If Not isEmpty Then
      Begin
        Result.ACodEmp := FieldByName('ADT_EMPLAN').AsString;
        Result.ASeqCon := FieldByName('ADT_SEQCON').AsString;
        Result.ACodCli := FieldByName('ADT_CODCLI').AsString;
      End;
    End;

  Finally
    pFreeAndNil(qryAux);
  End;
end;

end.
