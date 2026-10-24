{*****************************************}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadBzaBaseD;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBzaBasesD = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodBas: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    dbePesPeq: TDBEditFocus;
    Label6: TLabel;
    dbePreCus: TDBEditFocus;
    Label7: TLabel;
    dbeMargem: TDBEditFocus;
    Label3: TLabel;
    dbePreVen: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    Label5: TLabel;
    dbeEmbalagem: TDBEditFocus;
    dtsBzaCadBas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp    : TDBEdit;
    qryCon002    : TUniQuery;
    StrCodIteAnt : String;
    procedure pCarregaItem;
    procedure pHabilitaBtn;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetPrecoVenda(intOpcao: Integer): Double;
  public
    { Public declarations }
    procedure pAtualizarFatorTintometrico;
  end;

var
  frmCadBzaBasesD: TfrmCadBzaBasesD;

implementation

uses  untModuloTinta, untPesqAux,
      untPai,
      untFuncoesSimples, untFuncTinta,
      untTypesSistema, untConsultas, untValidarBaseItemAmarracao;

{$R *.dfm}

procedure TfrmCadBzaBasesD.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryBza_CadBas;
  strNomeTabela := 'BZA_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  dtsBzaCadBas.DataSet := frmModuloTinta.qryBza_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsBza_CadBas;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodBas;
  arrCamposChave[1] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadBzaBasesD.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da base deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        fBuscaPorCamposChave;
      End;

    End

    Else If (Sender  = dbeEmbalagem) Then
    Begin
      If (fEmptyStr(dbeEmbalagem.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem dever ser informada!', ['&OK']);
        Result := False;
      End
      Else If fStrToFloat(dbeEmbalagem.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', ' A embalagem deve ser configurada', ['&OK']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbePesPeq) Then
    Begin

      If (fEmptyStr(dbePesPeq.Text)) or (fStrToFloat(dbePesPeq.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O peso específico não está configurado corretamente!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadBzaBasesD.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
  pHabilitaBtn;
end;

procedure TfrmCadBzaBasesD.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESBAS');
  stlCampos.Add('BAS_EMBALA');
  stlCampos.Add('BAS_PESPEC');
  stlCampos.Add('ITE_CODITE');
  stlCampos.Add('ITE_DESITE');
  stlCampos.Add('ITE_REFERE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');


  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência');
end;

procedure TfrmCadBzaBasesD.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadBzaBasesD.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  strCodIteAnt := '';
  
  If qryTabela.State = dsInsert Then
  Begin
    qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('BAS_EMBALA').AsInteger := 1000;
    pSetFocus(dbeCodBas);
    edtDesIte.Clear;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadBzaBasesD.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key:= '/';
  If fPesqBaseTinta(Self, conBZA, nil, nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadBzaBasesD.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.text;
  inherited;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'BZA');
  
  pCarregaItem;
end;

procedure TfrmCadBzaBasesD.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBzaBasesD.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;
  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);

  pHabilitaBtn;
end;

procedure TfrmCadBzaBasesD.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadBzaBasesD.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;

  dbePesPeq.ReadOnly := (qryTabela.State in [dsEdit]);
end;

function TfrmCadBzaBasesD.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;


procedure TfrmCadBzaBasesD.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadBzaBasesD.pAtualizarFatorTintometrico;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN BZA_CADBAS ON BAS_CODITE = ITE_CODITE SET ITE_CNV_ML = (IFNULL(BAS_EMBALA, 1) * IFNULL(BAS_PESPEC, 1))';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadBzaBasesD.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;
  blnEdit := (dtsBzaCadBas.DataSet.State in [DsEdit]);

  Try
    fStartTransaction;

    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('BZA', dbeCodBas.text, dbeDescri.text, dbeCodIte.Text , StrCodIteAnt ,
         dtsBzaCadBas.DataSet.FieldByName('BAS_PESPEC').AsFloat , strToFloat(dbeEmbalagem.Text) ) Then
    begin
      inherited;
      pAtualizarFatorTintometrico;

      If ((Not fEmptyStr(strCoditeAnt)) And (blnEdit)) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'BZA');
      End;

      pHabilitaBtn;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

end.

