unit untCadSitTributarias;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, Menus, AppEvnts, DB, BitBtnLockedIncrem, Mask, frxClass,
  frxExportCSVTestabilidade, MaskEditFocus, SysUtils, StrUtils;

type
  TfrmCadSitTributarias = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodTri: TDBEditFocus;
    dbeDesc01: TDBEditFocus;
    Label2: TLabel;
    dbeDesc02: TDBEditFocus;
    pnlFundo: TPanel;
    dtsCadTri: TDataSource;
    Label6: TLabel;
    dbeCFOPSP: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    Procedure pAfterOpen(dataSet: TDataSet);
    function fValidaCfops(strCfops: string): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema,
     MaskUtils;

{$R *.dfm}


procedure TfrmCadSitTributarias.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadSitTributarias.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CADTRI';
  strNomeCampo        := 'TRI_CODTRI';
  qryTabela           := fCriaQuery(Self);
  dtsCadTri.DataSet   := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTri;
end;

function TfrmCadSitTributarias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DA SITUAÇÃO TRIBUTA - *}
    {* RIA                                   *}
    {**************************************MV*}
    If (Sender = dbeCodTri) Then
    Begin
      If (fEmptyStr(dbeCodTri.Text)) And (dbeCodTri.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Situação Tributaria deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA SITUAÇÃO TRIBU- *}
    {* TARIA                                 *}
    {**************************************MV*}
    Else If (Sender = dbeDesc01) Then
    Begin
      If fEmptyStr(dbeDesc01.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Situação Tributaria deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCFOPSP) Then
    Begin
      Result := fValidaCfops(dbeCFOPSP.Text);
    End


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadSitTributarias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TRI_CODTRI');
  stlCampos.Add('TRI_DESC01+TRI_DESC02');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TRI_CODTRI');
  stlCamInd.Add('TRI_DESC01+TRI_DESC02');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descr. 1 / Descr. 2');

end;

procedure TfrmCadSitTributarias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadSitTributarias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadSitTributarias.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadSitTributarias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadSitTributarias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTri, dbeDesc01, False)
  Else
    pHabilitaCodigo(dbeCodTri, dbeCodTri, True);
end;

procedure TfrmCadSitTributarias.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrSitTrib: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE SIT. TRIBUTÁRIA *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqSitTributaria(Self, Nil, Nil, qryTabela, chrKey, arrSitTrib) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadSitTributarias.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTri, dbeDesc01, False);
end;

procedure TfrmCadSitTributarias.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

Procedure TfrmCadSitTributarias.pAfterOpen(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    FieldByName('TRI_CFOPSP').EditMask := '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999;0;_';
  End;
End;

function TfrmCadSitTributarias.fValidaCfops(strCfops: string): Boolean;
  Var
    stlCfops: TStringList;
    strCfop: String;
    strCfopNaoCad: String;
begin
  Result := True;
  strCfopNaoCad := '';

  stlCfops := TStringList.Create;
  stlCfops.Delimiter := '-';
  stlCfops.DelimitedText := FormatMaskText(qryTabela.FieldByName('TRI_CFOPSP').EditMask, strCfops);

  For strCfop In stlCfops Do
  Begin
    If (Not fEmptyStr(strCfop)) And (fEmptyStr(fCampoTabela('CFO_DESCR1', 'CADCFO', ['CFO_CODCFO'], [strCfop]))) Then
      strCfopNaoCad := strCfopNaoCad + strCfop + ',';
  End;

  FreeAndNil(stlCfops);

  If Not fEmptyStr(strCfopNaoCad) Then
  Begin
    strCfopNaoCad := LeftStr(strCfopNaoCad, Length(strCfopNaoCad)-1);
    fMensagem('', 'As seguintes CFOPs não estão cadastradas: ' + strCfopNaoCad, ['&Ok']);
    Result := False;
  End;
end;

end.

