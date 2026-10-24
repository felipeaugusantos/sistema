unit untCadFreteTranspRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Datasnap.DBClient, QColorLabel,
  System.StrUtils;

type
  TfrmCadFreteTranspRegiao = class(TfrmPaiCad)
    pnlGeral: TPanel;
    dtsTraReg: TDataSource;
    btnCadRapTra: TBitBtnLocked;
    btnCadRapReg: TBitBtnLocked;
    pnlTransp: TPanel;
    Label31: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    Label7: TLabel;
    dbeCodReg: TDBEditFocus;
    edtRegiao: TEditFocus;
    pnlTomador: TPanel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    dbeTomado: TDBEditFocus;
    pnlValores: TPanel;
    Label1: TLabel;
    dbeValIse: TDBEditFocus;
    gpbCalculoFrete: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeMinFre: TDBEditFocus;
    dbePerTot: TDBEditFocus;
    dbeValKil: TDBEditFocus;
    dbePd100K: TDBEditFocus;
    dbeMinGri: TDBEditFocus;
    dbePerGri: TDBEditFocus;
    dbeValTas: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadRapTraClick(Sender: TObject);
    procedure btnCadRapRegClick(Sender: TObject);
  private
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pLimparCamposCadastro;
    procedure pCarregaRegiao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadFreteTranspRegiao: TfrmCadFreteTranspRegiao;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema,
  untCadRapidoFreteTranspRegiao;

{$R *.dfm}

{ TfrmCadFreteTranspRegiao }

procedure TfrmCadFreteTranspRegiao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
  Begin
    dbeCodTra.ReadOnly := True;
    dbeCodReg.ReadOnly := True;
    pSetFocus(dbeValIse);
  End;
end;

procedure TfrmCadFreteTranspRegiao.btnCadRapRegClick(Sender: TObject);
begin
  inherited;
  If TfrmCadRapidoFreteTranspRegiao.fCadRapidoTraReg('R') Then
    fMensagem('ATENÇÃO!', 'Cadastro(s) de frete(s) alterado(s) com sucesso!', ['&Ok']);
end;

procedure TfrmCadFreteTranspRegiao.btnCadRapTraClick(Sender: TObject);
begin
  inherited;
  If TfrmCadRapidoFreteTranspRegiao.fCadRapidoTraReg('T') Then
    fMensagem('ATENÇÃO!', 'Cadastro(s) de frete(s) alterado(s) com sucesso!', ['&Ok']);
end;

procedure TfrmCadFreteTranspRegiao.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodTra.ReadOnly := False;
  dbeCodReg.ReadOnly := False;

  edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
  pCarregaRegiao;
end;

procedure TfrmCadFreteTranspRegiao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFreteTranspRegiao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimparCamposCadastro;
end;

procedure TfrmCadFreteTranspRegiao.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFreteTranspRegiao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  dbeCodTra.ReadOnly := False;
  dbeCodReg.ReadOnly := False;
end;

procedure TfrmCadFreteTranspRegiao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodTra);
  pLimparCamposCadastro;
end;

procedure TfrmCadFreteTranspRegiao.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fPesqFreteTransportadoraRegiao(Self, dbeCodTra, dbeCodReg, qryTabela, chrKey) Then
  Begin
    edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
    pCarregaRegiao;
  End;
end;

procedure TfrmCadFreteTranspRegiao.dbeCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrRegiao: TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, dbeCodReg, edtRegiao, Nil, Key, arrRegiao) Then
  Begin
    If fValidaCampos(dbeCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFreteTranspRegiao.dbeCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp: TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFreteTranspRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery(Self);
  strNomeTabela := 'TRAREG';
  dtsTraReg.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodTra;
  arrCamposChave[1] := dbeCodReg;

  strNomeCampo := 'AUTOINCREM';
  blnUsaProCodigo := False;
  qryTabela.AfterOpen := pAfterOpen;

  pnlTomador.Visible := fCfgSis('UTICTE', varBoolean);
end;

function TfrmCadFreteTranspRegiao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodTra) Then
  Begin
    If fEmptyStr(dbeCodTra.Text) Then
    Begin
      Result := False;
      edtNomTra.Clear;
    End
    Else
    Begin
      edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
      If fEmptyStr(edtNomTra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = dbeCodReg) Then
  Begin
    If fEmptyStr(dbeCodReg.Text) Then
    Begin
      Result := False;
      edtRegiao.Clear;
    End
    Else
    Begin
      pCarregaRegiao;
      If (fEmptyStr(edtRegiao.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;

        edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
        pCarregaRegiao;

      End;
    End;
  End
  Else If (Sender = dbeTomado) and (pnlTomador.Visible) Then
  Begin
    If fEmptyStr(dbeTomado.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Frete por Conta do deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (not AnsiMatchStr(dbeTomado.Text, ['E', 'D'])) Then
      Result := False;
  End
  Else If (Sender = dbeValIse) Or
          (Sender = dbeMinFre) Or
          (Sender = dbePerTot) Or
          (Sender = dbeValKil) Or
          (Sender = dbePd100K) Or
          (Sender = dbePerGri) Or
          (Sender = dbeMinGri) Or
          (Sender = dbeValTas) Then
  Begin
    If fEmptyStr((Sender As TCustomEdit).Text) Then
    Begin
      (Sender As TCustomEdit).Text := '0,00';
    End
    Else If fStrToFloat((Sender As TCustomEdit).Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Todos os valores devem ser maior ou igual a Zero.', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadFreteTranspRegiao.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('TRE_VALISE')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_MINFRE')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_PERTOT')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_VALKIL')).DisplayFormat := '#,##0.0000';
  TFloatField(DataSet.FieldByName('TRE_PD100K')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_PERGRI')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_MINGRI')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('TRE_VALTAS')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadFreteTranspRegiao.pCarregaRegiao;
begin
  edtRegiao.Text := fRetNomRegiao(dbeCodReg.Text);
end;

procedure TfrmCadFreteTranspRegiao.pInicializaIndices;
begin
  inherited;
  //
end;

procedure TfrmCadFreteTranspRegiao.pLimparCamposCadastro;
begin
  edtNomTra.Clear;
  edtRegiao.Clear;
end;

end.
