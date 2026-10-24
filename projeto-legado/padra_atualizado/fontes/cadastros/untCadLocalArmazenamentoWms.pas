unit untCadLocalArmazenamentoWms;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils, EditFocus;

type
  TfrmCadLocalArmazenamentoWms = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    pnlLocFis: TPanel;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    edtDesLoc: TEditFocus;
    pnlTop: TPanel;
    Label1: TLabel;
    dbeCodLar: TDBEditFocus;
    Label2: TLabel;
    dbeDesLar: TDBEditFocus;
    pnlPonImp: TPanel;
    Label3: TLabel;
    edtPonNFe: TEditFocus;
    edtDesPonNFe: TEditFocus;
    Label4: TLabel;
    edtPonEtd: TEditFocus;
    edtDesPonEtd: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtPonEtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtPonNFeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pCarregaLocalizacaoFisica;
    procedure pCarregaPontosImpressao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadLocalArmazenamentoWms: TfrmCadLocalArmazenamentoWms;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema,
  untFuncInsFactory, Shared.Functions.DataSet;

{$R *.dfm}

{ TfrmCadLocalArmazenamentoWms }

function TfrmCadLocalArmazenamentoWms.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {*************************************************}
    {* VALIDA CODIGO DO LOCAL DE ARMAZENAMENTO - WMS *}
    {**********************************************AC*}
    If (Sender = dbeCodLar) Then
    Begin
      If (fEmptyStr(dbeCodLar.Text)) And (dbeCodLar.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do local de armazenamento wms deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End
    {****************************************************}
    {* VALIDA DESCRICAO DA LOCAL DE ARMAZENAMENTO - WMS *}
    {*************************************************AC*}
    Else If (Sender = dbeDesLar) Then
    Begin
      If fEmptyStr(dbeDesLar.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição do local de armazenamento wms deve ser preenchida!', ['&Ok']);
      End;
    End

    Else If (Sender = edtLocFis) And pnlLocFis.Visible Then
    Begin
      edtDesLoc.Clear;

      If fEmptyStr(edtLocFis.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Localização Física deve ser preenchida!', ['&Ok']);
      End
      Else
      Begin
        edtDesLoc.Text := fRetNomLocFisica(edtLocFis.Text);

        If fEmptyStr(edtDesLoc.Text) Then
        Begin
          Result := False;
          qryTabela.FieldByName('LAR_LOCFIS').Clear;
          fMensagem('ATENÇÃO!', 'Localização Física não encontrada!', ['&Ok']);
        End
        Else
          qryTabela.FieldByName('LAR_LOCFIS').AsString :=
            fCampoTabela('AUTOINCREM', 'CADLOC', ['LOC_CODLOC','LOC_CODEMP'], [edtLocFis.Text, VS_strCodEmp], False);
      End;
    End

    else If (Sender = edtPonNFe) and pnlPonImp.Visible then
    begin
      edtDesPonNFe.Clear;

      if fEmptyStr(edtPonNFe.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O ponto de impressão da DANFE deve ser preenchido!', ['&Ok']);
      end
      else
      begin
        edtDesPonNFe.Text :=
          fCampoTabela('PON_NOMPON', 'PONIMP', ['PON_CODPON', 'PON_CODEMP'], [edtPonNFe.Text, VS_strCodEmp], False);

        if fEmptyStr(edtDesPonNFe.Text) then
        begin
          Result := False;
          qryTabela.FieldByName('LAR_PONNFE').Clear;
          fMensagem('ATENÇÃO!', 'Ponto de impressão não encontrado!', ['&Ok']);
        end
        else
          qryTabela.FieldByName('LAR_PONNFE').AsString :=
            fCampoTabela('AUTOINCREM', 'PONIMP', ['PON_CODPON', 'PON_CODEMP'], [edtPonNFe.Text, VS_strCodEmp], False);
      end;
    end

    else If (Sender = edtPonEtd) and pnlPonImp.Visible then
    begin
      edtDesPonEtd.Clear;

      if fEmptyStr(edtPonEtd.Text) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O ponto de impressão da etiqueta de despacho deve ser preenchido!', ['&Ok']);
      end
      else
      begin
        edtDesPonEtd.Text :=
          fCampoTabela('REL_DESPRO', 'CFGREL', ['UPPER(REL_NOMPRO)', 'REL_CODEMP'], [UpperCase(edtPonEtd.Text), VS_strCodEmp], False);

        if fEmptyStr(edtDesPonEtd.Text) then
        begin
          Result := False;
          qryTabela.FieldByName('LAR_PONETD').Clear;
          fMensagem('ATENÇÃO!', 'Ponto de impressão não encontrado!', ['&Ok']);
        end
        else
          qryTabela.FieldByName('LAR_PONETD').AsString :=
            fCampoTabela('AUTOINCREM', 'CFGREL', ['UPPER(REL_NOMPRO)', 'REL_CODEMP'], [UpperCase(edtPonEtd.Text), VS_strCodEmp], False);
      end;
    end;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadLocalArmazenamentoWms.pCarregaLocalizacaoFisica;
  Var
    objDados: IMyCampoTabela;
begin
  edtLocFis.Clear;
  edtDesLoc.Clear;

  If Not pnlLocFis.Visible Then
    Exit;

  If fEmptyStr(qryTabela.FieldByName('LAR_LOCFIS').AsString) Then
    Exit;

  objDados := fCampoTabela(['LOC_CODLOC','LOC_DESCRI'], 'CADLOC', ['AUTOINCREM'],
                           [qryTabela.FieldByName('LAR_LOCFIS').AsString], False);

  edtLocFis.Text := objDados.FieldByName('LOC_CODLOC').AsString;
  edtDesLoc.Text := objDados.FieldByName('LOC_DESCRI').AsString;
end;

procedure TfrmCadLocalArmazenamentoWms.pCarregaPontosImpressao;
var
  LDados: IMyCampoTabela;
begin
  edtPonNFe.Clear;
  edtDesPonNFe.Clear;
  edtPonEtd.Clear;
  edtDesPonEtd.Clear;

  if (not pnlPonImp.Visible) then
    Exit;

  if (not fEmptyStr(qryTabela.FieldByName('LAR_PONNFE').AsString)) then
  begin
    LDados := fCampoTabela(['PON_CODPON', 'PON_NOMPON'], 'PONIMP', ['AUTOINCREM'],
                             [qryTabela.FieldByName('LAR_PONNFE').AsString], False);

    edtPonNFe.Text := LDados.FieldByName('PON_CODPON').AsString;
    edtDesPonNFe.Text := LDados.FieldByName('PON_NOMPON').AsString;
  end;

  if (not fEmptyStr(qryTabela.FieldByName('LAR_PONETD').AsString)) then
  begin
    LDados := fCampoTabela(['REL_NOMPRO', 'REL_DESPRO'], 'CFGREL', ['AUTOINCREM'],
                             [qryTabela.FieldByName('LAR_PONETD').AsString], False);

    edtPonEtd.Text := LDados.FieldByName('REL_NOMPRO').AsString;
    edtDesPonEtd.Text := LDados.FieldByName('REL_DESPRO').AsString;
  end;
end;

procedure TfrmCadLocalArmazenamentoWms.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('LAR_CODLAR');
  stlCampos.Add('LAR_DESLAR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('LAR_DESLAR');
  stlCamInd.Add('LAR_CODLAR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadLocalArmazenamentoWms.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadLocalArmazenamentoWms.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADLAR';
  strNomeCampo      := 'LAR_CODLAR';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodLar;

  pnlLocFis.Visible := fCfgSis('CADLOC', varBoolean) And fCfgSis('SOLOLA', varBoolean);

  If Not pnlLocFis.Visible Then
    Self.Height := Self.Height - pnlLocFis.Height;

  pnlPonImp.Visible := fUsaRotinaWMS and fCfgSis('SOLOLA', varBoolean) and fCfgSis('FAGFIL', varBoolean);

  if (not pnlPonImp.Visible) then
    Self.Height := Self.Height - pnlPonImp.Height;
end;

procedure TfrmCadLocalArmazenamentoWms.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaLocalizacaoFisica;
  pCarregaPontosImpressao;
end;

procedure TfrmCadLocalArmazenamentoWms.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    pCarregaLocalizacaoFisica;
    pCarregaPontosImpressao;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLocalArmazenamentoWms.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadLocalArmazenamentoWms.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadLocalArmazenamentoWms.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadLocalArmazenamentoWms.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodLar, dbeDesLar, False)
  Else
    pHabilitaCodigo(dbeCodLar, dbeCodLar, True);
end;

procedure TfrmCadLocalArmazenamentoWms.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodLar, dbeDesLar, False);
end;

procedure TfrmCadLocalArmazenamentoWms.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadLocalArmazenamentoWms.btnPesquisaClick(Sender: TObject);
  Var
    arrLAR: TConsultasArray;
    chrKey: Char;
begin
  {*************************************************}
  {* NOVA CONSULTA DE LOCAL DE ARMAZENAMENTO - WMS *}
  {**********************************************AC*}
  chrKey := '/';
  If fPesqLocalArmazenamentoWms(Self, Nil, Nil, qryTabela, chrKey, arrLAR) Then
  Begin
    pCarregaLocalizacaoFisica;
    pCarregaPontosImpressao;
  End;
end;

procedure TfrmCadLocalArmazenamentoWms.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqLocFisica(Self, edtLocFis, edtDesLoc, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtLocFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLocalArmazenamentoWms.edtPonEtdKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqConfiguracaoRel(conSimples, Self, edtPonEtd, edtDesPonEtd, nil, Key, arrSel, 'REL_NOMPRO LIKE "%EtiDespacho%"') then
  begin
    If fValidaCampos(edtPonEtd, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadLocalArmazenamentoWms.edtPonNFeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqPontosImpressaoNFE(Self, edtPonNFe, edtDesPonNFe, nil, Key, arrSel) then
  begin
    If fValidaCampos(edtPonNFe, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

end.
