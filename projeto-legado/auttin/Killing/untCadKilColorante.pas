{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{**************************************MV*}
unit untCadKilColorante;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, Uni, BitBtnLockedIncrem;

type
  TfrmCadKilColorantes = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodCol: TDBEditFocus;
    Label2: TLabel;
    dbePreCus: TDBEditFocus;
    Label3: TLabel;
    dbeMargem: TDBEditFocus;
    Label4: TLabel;
    dbePreVen: TDBEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCadIte: TUniQuery;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pAtualizaFatorTintometrico;
    { Public declarations }
  end;

var
  frmCadKilColorantes: TfrmCadKilColorantes;

implementation

uses untModuloTinta, untPai, untPesqAux,
  untConsultaFatItem, untFuncoesSimples, untFuncTinta,
  untConsultaCompRelacionamento;

{$R *.dfm}

procedure TfrmCadKilColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryKil_CadCol;
  strNomeTabela := 'KIL_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'COL_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsKil_CadCol;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCol;
  arrCamposChave[1] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadKilColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,000';

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

function TfrmCadKilColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodCol) Then
    Begin

      If (fEmptyStr(dbeCodCol.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          pLimparCampos;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O ITEM COLORANTE               *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

//      If (fEmptyStr(dbeCodIte.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'O Item Colorante deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
//      Else
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'KIL_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
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
    End;





  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadKilColorantes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_PRECUS');
  stlCampos.Add('COL_MARGEM');
  stlCampos.Add('COL_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadKilColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodCol);
  edtDesIte.Clear;
end;

procedure TfrmCadKilColorantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodCol.Enabled := False;
  pSetFocus(dbePreCus);
end;

procedure TfrmCadKilColorantes.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
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

    If pConsultaEspecifica(Self, frmConsultaFatItem, qryCadIte, 'CADITE',
        strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin

      dbeCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(frmConsultaFatItem);

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;
end;

procedure TfrmCadKilColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;


procedure TfrmCadKilColorantes.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' 	COL_CODCOL "Código do Colorante", ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência do Item",	 ';
  strSQL := strSQL + ' 	C.AUTOINCREM "AUTOINCREM"  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' 	KIL_CADCOL C ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE  ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'KIL_CADCOL', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;


end;

procedure TfrmCadKilColorantes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadKilColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadKilColorantes.pAtualizaFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN KIL_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = 1000';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadKilColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pAtualizaFatorTintometrico;
end;

end.

