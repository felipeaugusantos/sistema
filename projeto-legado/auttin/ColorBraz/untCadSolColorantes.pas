unit untCadSolColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  BitBtnLockedIncrem;

type
  TfrmCadSolColorantes = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    dbePreCus: TDBEditFocus;
    Label4: TLabel;
    dbeMargem: TDBEditFocus;
    Label5: TLabel;
    dbePreVen: TDBEditFocus;
    dbeCodIteDescri: TEditFocus;
    btnRestPreco: TSpeedButton;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCol: TUniQuery;
    qryCadIte: TUniQuery;
    dtsCadCol : TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fValidaCodIte(strCodIte: String): Boolean;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pMudarEstado(DataSet: TDataSet);
    { Public declarations }
    procedure pAtualizaFatorTintometrico;
  end;

var
  frmCadSolColorantes: TfrmCadSolColorantes;

implementation

uses untFuncoesSimples, untFuncTinta, untPai,
     untPesqAux, untConsultaCompRelacionamento;

{$R *.dfm}

{ TfrmCadSolColorantes }

function TfrmCadSolColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) Then
      Begin
        fMensagem('', 'O código deve ser preenchido', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodIte) Then
    Begin

      If (fEmptyStr(dbeCodIte.Text)) Then
      Begin
        fMensagem('', 'O item do colorante deve ser preenchido!', ['OK']);
        Result := False;
      End

      Else If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'SOL_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
      End

      Else If (Not fValidaCodIte(dbeCodIte.Text)) Then
      Begin
        fMensagem('', 'O item não é válido!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbePreCus) Then
    Begin

      If (fEmptyStr(dbePreCus.Text)) Then
      Begin
        fMensagem('', 'O preço de custo deve ser preenchido', ['OK']);
        Result := False;
      End

      Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
      Begin
        fMensagem('', 'O preço de custo deve ser maior que zero', ['OK']);
        Result := False;
      End

      Else
      Begin
        dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End;

    End

    Else If (Sender = dbeMargem) Then
    Begin
      If fEmptyStr(dbeMargem.Text) Then
      Begin
        fMensagem('', 'A margem deve ser preenchida!', ['OK']);
        Result := False;
      End

      Else If (fStrToFloat(dbeMargem.Text) <= 0) Then
      Begin
        fMensagem('', 'A margem deve ser maior que zero!', ['OK']);
        Result := False;
      End

      Else
      Begin
        dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End;
    End

    Else If (Sender = dbePreVen) Then
    Begin
      If fEmptyStr(dbePreVen.Text) Then
      Begin
        fMensagem('', 'O preço de venda deve ser preenchido!', ['OK']);
        Result := False;
      End

      Else If (fStrToFloat(dbePreVen.Text) <= 0.0) Then
      Begin
        fMensagem('', 'O preço de venda deve ser maior que zero!', ['OK']);
        Result := False;
      End

      Else
      Begin
        dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End;
    End


  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadSolColorantes.pCriaDataSets;
begin
  qryCadCol := fCriarQuery('SELECT * FROM SOL_CADCOL WHERE FALSE', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Colorante';
  qryCadCol.FieldByName('COL_CODITE').DisplayLabel := 'Cód. Item';
  qryCadCol.fieldbyName('AUTOINCREM').Visible := False;

  dtsCadCol := fCriaDataSource(qryCadCol);

  qryCadCol.AfterCancel := pMudarEstado;
  qryCadCol.AfterDelete := pMudarEstado;
  qryCadCol.AfterEdit := pMudarEstado;
  qryCadCol.AfterInsert := pMudarEstado;
end;

procedure TfrmCadSolColorantes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_CODITE');
  stlCampos.Add('ITE_DESITE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('COL_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadSolColorantes.pLigaDataSets;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
      (Components[intCont] as TDBEditFocus).DataSource := dtsCadCol;
  End;

  dbeCodigo.DataField := 'COL_CODCOL';
  dbeCodIte.DataField := 'COL_CODITE';
  dbeMargem.DataField := 'COL_MARGEM';
  dbePreCus.DataField := 'COL_PRECUS';
  dbePreVen.DataField := 'COL_PREVEN';

end;

procedure TfrmCadSolColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'SOL_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadSolColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadSolColorantes.fValidaCodIte(strCodIte: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;

  FreeAndNil(qryGen);
end;

procedure TfrmCadSolColorantes.pMudarEstado(DataSet: TDataSet);
begin
  btnRestPreco.Visible := (DataSet.State in [dsEdit, dsInsert]);
end;

procedure TfrmCadSolColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  If (dbeCodigo.Enabled) Then
    pSetFocus(dbeCodigo);
end;

procedure TfrmCadSolColorantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If (dbeCodigo.Enabled) Then
    pSetFocus(dbeCodigo);
end;

procedure TfrmCadSolColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  dbeCodIteDescri.Text := fRetNomProduto(dbeCodIte.Text);
end;

procedure TfrmCadSolColorantes.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadIte : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadIte := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	ITE_CODITE AS "Código", ';
    strSQL := strSQL + ' 	ITE_DESITE AS "Descrição", ';
    strSQL := strSQL + ' 	UNI_SIGUNI AS "Unidade", ';
    strSQL := strSQL + ' 	CADITE.AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	CADITE ';
    strSQL := strSQL + ' 	LEFT JOIN CADUNI ';
    strSQL := strSQL + ' 	ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('ITE_DESITE');
    stlIndice.Add('ITE_CODITE');

    stlDescricao.Add('Descrição');
    stlDescricao.Add('Código');

    stlIndCampos.Add('ITE_DESITE');
    stlIndCampos.Add('ITE_CODITE');

    utcRegistros.Limpar(Self.Name + 'CADITE');
    If pConsultaComp(Self, qryCadIte, 'CADITE', strSQL, stlIndice, stlDescricao) Then
    Begin
      dbeCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      dbeCodIteDescri.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
      btnRestPrecoClick(Sender);
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadIte);
  End;
end;

procedure TfrmCadSolColorantes.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' 	COL_CODCOL "Código do Colorante", ';
  strSQL := strSQL + ' 	COL_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência do Item", ';
  strSQL := strSQL + ' 	C.AUTOINCREM "AUTOINCREM" ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' 	SOL_CADCOL C ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'SOL_CADCOL', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadSolColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadSolColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  dbeCodIteDescri.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
  pHabilitaBtn;
end;

procedure TfrmCadSolColorantes.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadSolColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtn;
  pAtualizaFatorTintometrico;
end;

procedure TfrmCadSolColorantes.pAtualizaFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN SOL_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = 1000;';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

END.


