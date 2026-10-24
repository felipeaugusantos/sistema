unit untCfgPisCofinsSuframa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, uni, untFuncoesSimples, untConstantes, EditFocus, untConfiguracoesSUFIPC;

type

  TfrmCfgPisCofinsSuframa = class(TfrmPai)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnConfirma: TBitBtnLocked;
    edtPISCST: TEditFocus;
    edtCOFCST: TEditFocus;
    edtPisBase: TEditFocus;
    edtPisAliquota: TEditFocus;
    edtCofBase: TEditFocus;
    edtCofAliquota: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);

  private
    function fValidaCstPreechida: Boolean;
    procedure pZeraZSeVazio;
    function fValidaBasePreenchida: Boolean;
    function fValidaAliquotaPreenchida: Boolean;

    { Private declarations }
  public
    class procedure AbreConfiguracaoParaEdicao(var RecCfgPisCofinsSuframa: TRecCfgPisCofinsSuframa);
    { Public declarations }
  end;


  TCfgPisCofinsSuframa = class
  private
    procedure pSavaConfiguracao;
  public
    RecCfgPisCofinsSuframa: TRecCfgPisCofinsSuframa;
    class procedure pAbreConfiguracao(strCodEmp: String);

  End;


implementation

{$R *.dfm}

{ TCfgPisCofinsSuframa }

class procedure TCfgPisCofinsSuframa.pAbreConfiguracao(strCodEmp: String);
var CfgPisCofinsSuframa: TCfgPisCofinsSuframa;
begin
  CfgPisCofinsSuframa := TCfgPisCofinsSuframa.Create;
  Try
    CfgPisCofinsSuframa.RecCfgPisCofinsSuframa.pGetValue(strCodEmp);
    TfrmCfgPisCofinsSuframa.AbreConfiguracaoParaEdicao(CfgPisCofinsSuframa.RecCfgPisCofinsSuframa);
    If CfgPisCofinsSuframa.RecCfgPisCofinsSuframa.blnGravar Then
      CfgPisCofinsSuframa.pSavaConfiguracao;

  Finally
    FreeAndNil(CfgPisCofinsSuframa);
  End;

end;


procedure TCfgPisCofinsSuframa.pSavaConfiguracao;
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('REPLACE INTO CFGSIS_SUFIPC(');
    qryComand.SQL.Add('  IPC_PISCST,');
    qryComand.SQL.Add('  IPC_PISBAS,');
    qryComand.SQL.Add('  IPC_PISAQL,');
    qryComand.SQL.Add('  IPC_COFCST,');
    qryComand.SQL.Add('  IPC_COFBAS,');
    qryComand.SQL.Add('  IPC_COFALQ,');
    qryComand.SQL.Add('  IPC_CODEMP)');
    qryComand.SQL.Add('VALUES');
    qryComand.SQL.Add('  (:PISCST,');
    qryComand.SQL.Add('   :PISBAS,');
    qryComand.SQL.Add('   :PISAQL,');
    qryComand.SQL.Add('   :COFCST,');
    qryComand.SQL.Add('   :COFBAS,');
    qryComand.SQL.Add('   :COFALQ,');
    qryComand.SQL.Add('   :CODEMP)');
    qryComand.ParamByName('PISCST').AsString := RecCfgPisCofinsSuframa.PIS_CST;
    qryComand.ParamByName('PISBAS').AsFloat  := RecCfgPisCofinsSuframa.PIS_BASE;
    qryComand.ParamByName('PISAQL').AsFloat  := RecCfgPisCofinsSuframa.PIS_ALIQUOTA;
    qryComand.ParamByName('COFCST').AsString := RecCfgPisCofinsSuframa.COFINS_CST;
    qryComand.ParamByName('COFBAS').AsFloat  := RecCfgPisCofinsSuframa.COFINS_BASE;
    qryComand.ParamByName('COFALQ').AsFloat  := RecCfgPisCofinsSuframa.COFINS_ALIQUOTA;
    qryComand.ParamByName('CODEMP').AsString := RecCfgPisCofinsSuframa.CODEMP;
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
end;

class procedure TfrmCfgPisCofinsSuframa.AbreConfiguracaoParaEdicao(var RecCfgPisCofinsSuframa: TRecCfgPisCofinsSuframa);
var frmCfgPisCofinsSuframa: TfrmCfgPisCofinsSuframa;
begin
  RecCfgPisCofinsSuframa.blnGravar := False;
  pCriarFormularios(TfrmCfgPisCofinsSuframa, frmCfgPisCofinsSuframa);
  Try
    frmCfgPisCofinsSuframa.edtPISCST.Text :=  RecCfgPisCofinsSuframa.PIS_CST;
    frmCfgPisCofinsSuframa.edtCOFCST.Text :=  RecCfgPisCofinsSuframa.COFINS_CST;
    frmCfgPisCofinsSuframa.edtPisBase.Text := FormatFloat('#0.00', RecCfgPisCofinsSuframa.PIS_BASE);
    frmCfgPisCofinsSuframa.edtCofBase.Text := FormatFloat('#0.00', RecCfgPisCofinsSuframa.COFINS_BASE);
    frmCfgPisCofinsSuframa.edtPisAliquota.Text := FormatFloat('#0.00', RecCfgPisCofinsSuframa.PIS_ALIQUOTA);
    frmCfgPisCofinsSuframa.edtCofAliquota.Text := FormatFloat('#0.00', RecCfgPisCofinsSuframa.COFINS_ALIQUOTA);
    If frmCfgPisCofinsSuframa.ShowModal = mrOk Then
    begin
      RecCfgPisCofinsSuframa.PIS_CST := frmCfgPisCofinsSuframa.edtPISCST.Text;
      RecCfgPisCofinsSuframa.COFINS_CST := frmCfgPisCofinsSuframa.edtCOFCST.Text;
      RecCfgPisCofinsSuframa.PIS_BASE := StrToFloat(frmCfgPisCofinsSuframa.edtPisBase.Text);
      RecCfgPisCofinsSuframa.COFINS_BASE := StrToFloat(frmCfgPisCofinsSuframa.edtCofBase.Text);
      RecCfgPisCofinsSuframa.PIS_ALIQUOTA := StrToFloat(frmCfgPisCofinsSuframa.edtPisAliquota.Text);
      RecCfgPisCofinsSuframa.COFINS_ALIQUOTA := StrToFloat(frmCfgPisCofinsSuframa.edtCofAliquota.Text);
      RecCfgPisCofinsSuframa.blnGravar := True;
    End;
  Finally
    FreeAndNil(frmCfgPisCofinsSuframa);
  End;

end;

function TfrmCfgPisCofinsSuframa.fValidaCstPreechida: Boolean;
var strErro: String;
Begin
  strErro := '';
  If fEmptyStr(edtPISCST.Text) Then
  Begin
    strErro := 'A CST do PIS deve ser preenchida.';
    pSetFocus(edtPISCST);

  End;
  If fEmptyStr(edtCOFCST.Text) Then
  Begin
    strErro := 'A CST do COFINS deve ser preenchida.';
    pSetFocus(edtCOFCST);
  End;
  Result := fEmptyStr(strErro);
  If not Result Then
    pMensagemOk(strErro);

End;

procedure TfrmCfgPisCofinsSuframa.pZeraZSeVazio;
begin
  If fEmptyStr(edtPisBase.Text) Then
    edtPisBase.Text := '0';
  If fEmptyStr(edtPisAliquota.Text) Then
    edtPisAliquota.Text := '0';
  If fEmptyStr(edtCofBase.Text) Then
    edtCofBase.Text := '0';
  If fEmptyStr(edtCofAliquota.Text) Then
    edtCofAliquota.Text := '0';
end;

function TfrmCfgPisCofinsSuframa.fValidaBasePreenchida: Boolean;
var strErro: String;
Begin
  strErro := '';
  If StrToFloat(edtPisBase.Text) < 0 Then
  Begin
    strErro := 'A Base do PIS deve ser maior ou igual a zero.';
    pSetFocus(edtPisBase);

  End;
  If StrToFloat(edtCofBase.Text)< 0 Then
  Begin
    strErro := 'A base do COFINS deve ser maior ou igual a zero.';
    pSetFocus(edtCofBase);
  End;
  Result := fEmptyStr(strErro);
  If not Result Then
    pMensagemOk(strErro);

End;

function TfrmCfgPisCofinsSuframa.fValidaAliquotaPreenchida: Boolean;
var strErro: String;
Begin
  strErro := '';
  If StrToFloat(edtPisAliquota.Text) < 0 Then
  Begin
    strErro := 'A Alíquota do PIS deve ser maior ou igual a zero.';
    pSetFocus(edtPisAliquota);

  End;
  If StrToFloat(edtCofAliquota.Text)< 0 Then
  Begin
    strErro := 'A Alíquota do COFINS deve ser maior ou igual a zero.';
    pSetFocus(edtCofAliquota);
  End;
  Result := fEmptyStr(strErro);
  If not Result Then
    pMensagemOk(strErro);

End;

procedure TfrmCfgPisCofinsSuframa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pZeraZSeVazio;
  If Not fValidaCstPreechida Then
    Exit;
  If Not fValidaBasePreenchida Then
    Exit;
  If not fValidaAliquotaPreenchida Then
    Exit;
  ModalResult := mrOk;
end;

end.

