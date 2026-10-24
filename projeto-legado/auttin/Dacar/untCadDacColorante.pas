{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{**************************************MV*}
unit untCadDacColorante;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDacColorantes = class(TfrmPaiCad)
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
    btnRestPreco: TSpeedButton;
    Label5: TLabel;
    dbeEmbala: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure dbePreCusExit(Sender: TObject);
    procedure dbeMargemExit(Sender: TObject);
    procedure dbeEmbalaChange(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCadIte: TUniQuery;
    qryDac_CadCol : TUniQuery;
    dstDac_CadCol : TDataSource;

    strCodIteAnt : String;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
    procedure pLigaDbe;
    procedure pAddMascara;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pAtualizarFatorTintometrico;
  end;

var
  frmCadDacColorantes: TfrmCadDacColorantes;

implementation

uses untPai, untPesqAux,
     untFuncTinta, untFuncoesSimples,
     untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadDacColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  qryDac_CadCol := fCriaQuery(Self);
  qryDac_CadCol.SQL.Text := 'SELECT * FROM DAC_CADCOL';
  dstDac_CadCol := fCriaDataSource(qryDac_CadCol);

  qryDac_CadCol.Open;

  pAddMascara;

  qryDac_CadCol.Close;

  pLigaDbe;

  qryTabela     := qryDac_CadCol;
  strNomeTabela := 'DAC_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'COL_CODEMP';
  dbeCodEmp.DataSource := dstDac_CadCol;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCol;
  arrCamposChave[1] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadDacColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadDacColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
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

    Else If (Sender = dbePreCus) Then
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

    Else If (Sender = dbeEmbala) Then
    Begin
      If (fStrToFloat(dbeEmbala.Text) <= 0) And (blnBuscaPorChave) Then
      Begin
        fMensagem('ATENÇÃO!', 'A embalagem não está configurada corretamente', ['&O k']);
        Result := False;
      End
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
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'DAC_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (Not fItemAtivo(dbeCodIte.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item está inativo!', ['&O k']);
            Result := False;
          End
          Else If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
            If (qryTabela.State = dsInsert) Then
            Begin
              dbePreCus.Field.AsFloat := fltPrecus;
              dbeMargem.Field.AsFloat := fltMargem;
              dbePreVen.Field.AsFloat := fltPreVen;
            End;
          End;
        End;
      End;


    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadDacColorantes.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('COL_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadDacColorantes.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodCol);
  edtDesIte.Clear;

  pHabilitaBtn;
  pAddMascara;
end;

procedure TfrmCadDacColorantes.btnAlterarClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;
  dbeCodCol.Enabled := False;
  pSetFocus(dbeCodIte);

  pAddMascara;

  pHabilitaBtn;
end;

procedure TfrmCadDacColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDacColorantes.dbeEmbalaChange(Sender: TObject);
begin
  inherited;
  pAddMascara;
end;

procedure TfrmCadDacColorantes.dbeMargemExit(Sender: TObject);
begin
  inherited;
  dbeMargem.Text := FormatFloat('#0.00', fStrToFloat(dbeMargem.Text));
end;

procedure TfrmCadDacColorantes.dbePreCusExit(Sender: TObject);
begin
  inherited;
  dbePreCus.Text := FormatFloat('#0.00', fStrToFloat(dbePreCus.Text));
end;

procedure TfrmCadDacColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;

  pHabilitaBtn;
end;


procedure TfrmCadDacColorantes.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conDac, Nil, Nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDacColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'DAC');

  pCarregaItem;
end;

procedure TfrmCadDacColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadDacColorantes.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;
end;

procedure TfrmCadDacColorantes.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodIteAnt) Then
  Begin
    if (strCodIteAnt <> dbeCodIte.Text) Then
    begin
      pEnviarLogRep(strCodIteAnt, 'DAC');
    End;
  End;

  pHabilitaBtn;
  pAtualizarFatorTintometrico;
end;

procedure TfrmCadDacColorantes.pLigaDbe;
begin
  dbeCodCol.DataSource := dstDac_CadCol;
  dbePreCus.DataSource := dstDac_CadCol;
  dbeMargem.DataSource := dstDac_CadCol;
  dbePreVen.DataSource := dstDac_CadCol;
  dbeCodIte.DataSource := dstDac_CadCol;
  dbeEmbala.DataSource := dstDac_CadCol;
end;

procedure TfrmCadDacColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadDacColorantes.pAddMascara;
begin
  TFloatField(dstDac_CadCol.DataSet.FieldByName('COL_PRECUS')).DisplayFormat := '0.0000';
  TFloatField(dstDac_CadCol.DataSet.FieldByName('COL_PREVEN')).DisplayFormat := '0.0000';
  TFloatField(dstDac_CadCol.DataSet.FieldByName('COL_MARGEM')).DisplayFormat := '0.0000';
  TFloatField(dstDac_CadCol.DataSet.FieldByName('DAC_EMBALA')).DisplayFormat := '0.0000';
end;

procedure TfrmCadDacColorantes.pAtualizarFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN DAC_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = DAC_EMBALA';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.

