{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadKilBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, AppEvnts, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadKilBase = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodFml: TDBEditFocus;
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    Label3: TLabel;
    dbeCodUni: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbePreCus: TDBEditFocus;
    Label6: TLabel;
    dbeMargem: TDBEditFocus;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    edtSigUni: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;
    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadKilBase: TfrmCadKilBase;

implementation

uses untModuloTinta, untPesqAux,
  untConsultaFatItem, untConstantes, untPai,
  untFuncoesSimples, untFuncTinta,
  untConsultaCompRelacionamento, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadKilBase.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryKil_CadBas;
  strNomeTabela := 'KIL_CADBAS';
  strNomeCampo  := 'BAS_CODFML';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsKil_CadBas;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeCodFml;
  arrCamposChave[1] := dbeCodBas;
  arrCamposChave[2] := dbeCodUni;
  arrCamposChave[3] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

{*****************************************}
{* CALCULA O PREÇO DE VENDA              *}
{**************************************MV*}
function TfrmCadKilBase.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadKilBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeCodFml) Then
    Begin

      If (fEmptyStr(dbeCodFml.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    Else If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A UNIDADE                      *}
    {**************************************MV*}
    Else If (Sender = dbeCodUni) Then
    Begin

      If (fEmptyStr(dbeCodUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaUnidade;
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(edtSigUni.Text, UNIDADES_BASE) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If (Not fBuscaPorCamposChave) Then
          Begin
            strDesUni := edtDesUni.Text;
            strSigUni := edtSigUni.Text;
            pLimparCampos;
            edtDesUni.Text := strDesUni;
            edtSigUni.Text := strSigUni;
          End
          Else
          Begin
            pCarregaItem;
          End;
        End;
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

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

//      If (fEmptyStr(dbeCodIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'O Item Base deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
//      Else
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        pCarregaItem;
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'KIL_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End
        Else If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      {*****************************************}
      {* VALIDA O PREÇO DE CUSTO               *}
      {**************************************MV*}
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

      {*****************************************}
      {* VALIDA A MARGEM                       *}
      {**************************************MV*}
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

      {*****************************************}
      {* VALIDA O PREÇO DE VENDA               *}
      {**************************************MV*}
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
    End




  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadKilBase.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadKilBase.pCarregaUnidade;
begin
  If Not fEmptyStr(dbeCodUni.Text) Then
  Begin
    edtDesUni.Text := fRetNomUnidade(dbeCodUni.Text);
    edtSigUni.Text := fRetSiglaUnidade(dbeCodUni.Text);
  End
  Else
  Begin
    edtDesUni.Clear;
    edtSigUni.Clear;
  End;
end;

procedure TfrmCadKilBase.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODFML');
  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODUNI');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_PRECUS');
  stlCampos.Add('BAS_MARGEM');
  stlCampos.Add('BAS_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_CODBAS+BAS_CODFML');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base/Código');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadKilBase.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fedtCodPesquisaSimples(dbeCodUni,
                            nil,
                            Key,
                            Self,
                            ['UNI_DESUNI','UNI_CODUNI','UNI_SIGUNI'],
                            ['Descrição','Código','Sigla'],
                            ['UNI_CODUNI','UNI_DESUNI','UNI_SIGUNI'],
                            ['Código','Descrição','Sigla'],
                            'UNI_CODUNI',
                            'UNI_CODUNI',
                            'CADUNI') then
  Begin
    if fValidaCampos(dbeCodUni, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadKilBase.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
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
      SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(frmConsultaFatItem);

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;

end;

procedure TfrmCadKilBase.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodFml);

  edtDesUni.Clear;
  edtSigUni.Clear;
  edtDesIte.Clear;
end;

procedure TfrmCadKilBase.btnPesquisaClick(Sender: TObject);
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + ' 	BAS_CODFML "Código", ';
  strSQL := strSQL + ' 	BAS_CODBAS "Base", ';
  strSQL := strSQL + ' 	BAS_DESCRI "Descrição",	 ';
  strSQL := strSQL + ' 	BAS_CODUNI "Unidade",	 ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência do Item",  ';
  strSQL := strSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + ' 	KIL_CADBAS B ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE  ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'KIL_CADBAS', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaUnidade;
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadKilBase.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadKilBase.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadKilBase.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodFml.Enabled := False;
  dbeCodBas.Enabled := False;
  dbeCodUni.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadKilBase.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

end.

