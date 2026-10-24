{*****************************************}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadZynBases;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, AppEvnts, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadZynBases = class(TfrmPaiCad)
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
    dtsZyn_CadBas: TDataSource;
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
    qryCon002: TUniQuery;
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
  frmCadZynBases: TfrmCadZynBases;

implementation

uses  untPesqAux,
      untConsultaFatItem,  untPai,
      untFuncoesSimples, untFuncTinta,
      untConsultaCompRelacionamento;

{$R *.dfm}

procedure TfrmCadZynBases.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := fCriaQuery(Self);
  dtsZyn_CadBas.DataSet := qryTabela;
  qryTabela.SQL.Add('SELECT * FROM ZYN_CADBAS');

  strNomeTabela := 'ZYN_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBas;

  qryCon002 := fCriaQuery(Self);
end;

function TfrmCadZynBases.fValidaCampos(Sender: TWinControl;
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
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'ZYN_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If (Sender = dbePreCus) Then
      Begin
        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End

      Else If (Sender = dbePreVen) Then
      Begin
        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;
      End

      Else If (Sender = dbeMargem) Then
      Begin
        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End
    End



  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadZynBases.pCarregaItem;
begin
  pPesquisaCadIte(Nil, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
  pHabilitaBtn;
end;

procedure TfrmCadZynBases.pInicializaIndices;
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

procedure TfrmCadZynBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    strSQL: String;
begin

  If (fEntraCons(Key)) Then
  Begin

    stlCamIndIte := TStringList.Create;
    stlDesIndIte := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE AS "Codigo", ';
    strSQL := strSQL + '  I.ITE_DESITE AS "Descrição", ';
    strSQL := strSQL + '  I.ITE_REFERE AS "Referência", ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "Unidade", ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS "Preço de Venda", ';
    strSQL := strSQL + '  I.ITE_CODMAR As "Cód. Marca", ';
    strSQL := strSQL + '  M.MAR_DESMAR As "Marca", ';
    strSQL := strSQL + '  I.AUTOINCREM AS "AUTOINCREM", ';
    strSQL := strSQL + '  IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO") AS ITE_ITEATI, ';
    strSQL := strSQL + '  I.ITE_CODSIM, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  DATEDIFF(CURRENT_DATE, ITE_DTAUVE) ULTVEN ';
    //strSQL := strSQL + '  G.ITE_SALRES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamIndIte.Add('I.ITE_DESITE');
    stlCamIndIte.Add('I.ITE_CODITE');
    stlCamIndIte.Add('I.ITE_REFERE');
    stlCamIndIte.Add('I.ITE_CODBAR');

    stlDesIndIte.Add('Descrição');
    stlDesIndIte.Add('Codigo');
    stlDesIndIte.Add('Referência');

    Application.CreateForm(TfrmConsultaFatItem, frmConsultaFatItem);

    If pConsultaEspecifica(Self, frmConsultaFatItem, qryCon002, 'CADITE',
        strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin

      dbeCodIte.Text := qryCon002.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      btnRestPrecoClick(Sender);
      SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(frmConsultaFatItem);

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;
end;

procedure TfrmCadZynBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  If qryTabela.State = dsInsert Then
  Begin
    qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('BAS_EMBALA').AsInteger := 1000;
    pSetFocus(dbeCodBas);
    edtDesIte.Clear;
  End;

  pHabilitaBtn;
end;

procedure TfrmCadZynBases.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' 	BAS_CODBAS "Base", ';
  strSQL := strSQL + ' 	BAS_DESBAS "Descrição", ';
  strSQL := strSQL + ' 	BAS_EMBALA "Embalagem", ';
  strSQL := strSQL + ' 	BAS_PESPEC "Peso Específico", ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência", ';
  strSQL := strSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + ' 	ZYN_CADBAS B ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'ZYN_CADBAS', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadZynBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadZynBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadZynBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodBas.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
  dbePesPeq.ReadOnly := True;

  pHabilitaBtn;
end;

procedure TfrmCadZynBases.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadZynBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;

  dbePesPeq.ReadOnly := (qryTabela.State in [dsEdit]);
end;

function TfrmCadZynBases.fRetPrecoVenda(intOpcao: Integer): Double;
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


procedure TfrmCadZynBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadZynBases.pAtualizarFatorTintometrico;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN ZYN_CADBAS ON BAS_CODITE = ITE_CODITE SET ITE_CNV_ML = (BAS_EMBALA * BAS_PESPEC)';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadZynBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pAtualizarFatorTintometrico;
end;

end.

