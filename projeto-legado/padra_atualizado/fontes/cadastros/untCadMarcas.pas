unit untCadMarcas;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, QColorLabel, SysUtils;

type
  TfrmCadMarcas = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodMar: TDBEditFocus;
    Label2: TLabel;
    dbeDesMar: TDBEditFocus;
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    lblFator: TLabel;
    dbeFatCus: TDBEditFocus;
    Label37: TLabel;
    dbeStatus: TDBEditFocus;
    ColorLabel1: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeStatusEnter(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterOpen(DataSet: TDataSet);
    function  fTemItemAtivo(strCodMar: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMarcas }

function TfrmCadMarcas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CODIGO DA MARCA                *}
    {**************************************WI*}
    If (Sender = dbeCodMar) Then
    Begin
      If (fEmptyStr(dbeCodMar.Text)) And (dbeCodMar.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Marca deve ser preenchido!', ['&Ok']);
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
    {*****************************************}
    {* VALIDA DESCRICAO DA MARCA             *}
    {**************************************WI*}
    Else If (Sender = dbeDesMar) Then
    Begin
      If fEmptyStr(dbeDesMar.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Marca deve ser preenchida!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeStatus) Then
    Begin
      If Pos(dbeStatus.Text,'SN') <= 0 Then
      Begin
        fMensagem('', 'O campo Ativa da Marca deve ser S ou N!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeFatCus) Then
    Begin
      If (Sender.Visible) Then
      Begin
        If Not fEmptyStr(dbeFatCus.Text) Then
        Begin
          If fStrToFloat(dbeFatCus.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO', 'O fator para elevação do custo deve ser maior ou igual a zero!', ['OK']);
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Defina uma fator para elevação do custo!', ['OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If Result And (Not fEmptyStr(dbeCodMar.Text)) And (dbeStatus.Text = 'N') And (fTemItemAtivo(dbeCodMar.Text)) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa marca possui itens ativos vinculados, para inativa-la faça a transferência dessa marca ou inative os produtos!', ['OK']);
    Result := False;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadMarcas.fTemItemAtivo(strCodMar: String): Boolean;
Var
    strSql: String;
    qryCad: TUniQuery;
begin
  qryCad := fCriaQuery(Nil);
  strSQL := '';
  strSQL := strSQL + ' SELECT   ITE_CODITE      ';
  strSQL := strSQL + ' FROM CADITE              ';
  strSQL := strSQL + '  WHERE                   ';
  strSQL := strSQL + '     ITE_CODMAR = :CODIGO ';
  strSQL := strSQL + ' AND ITE_ITEATI = "S"     ';
  strSQL := strSQL + ' LIMIT 1                  ';

  qryCad.SQL.Add(strSql);
  qryCad.ParamByName('CODIGO').AsString := strCodMar;
  qryCad.Open;

  Result := (Not qryCad.IsEmpty);

  qryCad.Close;

  FreeAndNil(qryCad);
end;

procedure TfrmCadMarcas.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('MAR_FATCUS')).DisplayFormat := '#,##0.000000';
end;

procedure TfrmCadMarcas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MAR_CODMAR');
  stlCampos.Add('MAR_DESMAR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MAR_DESMAR');
  stlCamInd.Add('MAR_CODMAR');

  stlDesInd.Add('Marca');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Código');

end;

procedure TfrmCadMarcas.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadMarcas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADMAR';
  strNomeCampo      := 'MAR_CODMAR';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodMar;

  qryTabela.AfterOpen := pAfterOpen;

  lblFator.Visible  := fCfgSis('ELCUCO', varBoolean);
  dbeFatCus.Visible := lblFator.Visible;
end;

procedure TfrmCadMarcas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMarcas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMarcas.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadMarcas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMarcas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMar, dbeDesMar, False)
  Else
    pHabilitaCodigo(dbeCodMar, dbeCodMar, True);
  dbeStatus.Field.AsString := 'S';
end;

procedure TfrmCadMarcas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMar, dbeDesMar, False);
end;

procedure TfrmCadMarcas.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadMarcas.btnPesquisaClick(Sender: TObject);
  Var
    arrMarca : TConsultasArray;
    chrKey   : Char;
begin
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  chrKey := '/';
  If fPesqMarcas(Self, Nil, Nil, qryTabela, chrKey, arrMarca, True, False) Then
  Begin
  
  End;
end;

procedure TfrmCadMarcas.dbeStatusEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeStatus.Text) Then
    dbeStatus.Text := 'S';
end;

end.

