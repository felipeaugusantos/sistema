unit Contabilidade.View.TipoDePlanoDeContaContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade;

type
  TfrmTipoDePlanoDeContaContabil = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsTipPla: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    FblnModoVinculoEmpresaLogada: Boolean;
    procedure pAplicarModoVinculoEmpresaLogada;
    procedure pVinculaEmpresaLogadaAoTipoPlano;
  public
    property ModoVinculoEmpresaLogada: Boolean read FblnModoVinculoEmpresaLogada write FblnModoVinculoEmpresaLogada;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmTipoDePlanoDeContaContabil: TfrmTipoDePlanoDeContaContabil;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas,
  Contabilidade.Funcoes, Uni, Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

procedure TfrmTipoDePlanoDeContaContabil.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmTipoDePlanoDeContaContabil.btnCancelaClick(Sender: TObject);
begin
  inherited;

  if FblnModoVinculoEmpresaLogada then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

procedure TfrmTipoDePlanoDeContaContabil.btnGravarClick(Sender: TObject);
begin
  inherited;

  if FblnModoVinculoEmpresaLogada and blnGravou then
  begin
    pVinculaEmpresaLogadaAoTipoPlano;
    ModalResult := mrOk;
    Close;
  end;
end;

procedure TfrmTipoDePlanoDeContaContabil.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmTipoDePlanoDeContaContabil.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTip: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoDePlanoDeContaContabil(Self, Nil, Nil, qryTabela, chrKey, arrTip) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmTipoDePlanoDeContaContabil.FormCreate(Sender: TObject);
begin
  inherited;
  FblnModoVinculoEmpresaLogada := False;
  strNomeTabela     := 'TPLACO';
  strNomeCampo      := 'ACO_CODIGO';

  qryTabela         := fCriaQueryContabilidade('TPLACO', Self.Name, Self);
  qryTabela.SQL.Text := 'SELECT * FROM TPLACO';
  dtsTipPla.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmTipoDePlanoDeContaContabil.FormShow(Sender: TObject);
begin
  inherited;

  if FblnModoVinculoEmpresaLogada then
    pAplicarModoVinculoEmpresaLogada;
end;

procedure TfrmTipoDePlanoDeContaContabil.pAplicarModoVinculoEmpresaLogada;
begin
  if not (qryTabela.State in [dsInsert, dsEdit]) then
    btnIncluir.Click;
end;

procedure TfrmTipoDePlanoDeContaContabil.pVinculaEmpresaLogadaAoTipoPlano;
var
  LqryAux: TUniQuery;
  LstrTplaco: string;
begin
  LstrTplaco := Trim(qryTabela.FieldByName('ACO_CODIGO').AsString);
  if fEmptyStr(LstrTplaco) then
    Exit;

  LqryAux := fCriaQuery(Self);
  try
    LqryAux.SQL.Text := 'UPDATE CADEMP SET EMP_TPLACO = :TPLACO WHERE EMP_CODEMP = :CODEMP';
    LqryAux.ParamByName('TPLACO').AsString := LstrTplaco;
    LqryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryAux.ExecSQL;
  finally
    FreeAndNil(LqryAux);
  end;
end;

function TfrmTipoDePlanoDeContaContabil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do tipo deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End
  Else If (Sender = dbeDescri) Then
  Begin
    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do tipo deve ser preenchida!', ['&OK']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmTipoDePlanoDeContaContabil.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ACO_CODIGO');
  stlCampos.Add('ACO_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ACO_DESCRI');
  stlCamInd.Add('ACO_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

end.
