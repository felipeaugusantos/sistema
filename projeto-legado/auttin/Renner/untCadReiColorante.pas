{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{**************************************MV*}
unit untCadReiColorante;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, Uni, BitBtnLockedIncrem, DB,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadReiColorantes = class(TfrmPaiCad)
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
    Label5: TLabel;
    dbeQtdLit: TDBEditFocus;
    btnRestPreco: TSpeedButton;
    DbeColDescri: TDBEditFocus;
    lblDescricao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadIte: TUniQuery;
    qryCadCol: TUniQuery;
    dtsCadCol: TDataSource;

    strCoditeAnt : String;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pAtualizarFatorTintometrico;
    { Public declarations }
  end;

var
  frmCadReiColorantes: TfrmCadReiColorantes;

implementation

uses untPai, untPesqAux,
     untFuncoesSimples, untFuncTinta,
     TypInfo, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadReiColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadCol;
  strNomeTabela := 'REI_CADCOL';
  strNomeCampo := 'COL_CODCOL';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCol;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadReiColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadReiColorantes.fValidaCampos(Sender: TWinControl;
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



    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin

      {*****************************************}
      {* VALIDA O ITEM COLORANTE               *}
      {**************************************MV*}
      If (Sender = dbeCodIte) Then
      Begin

        If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'REI_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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
    End;


//    Else If (Sender = dbeQtdLit) Then
//    Begin
//
//      If (fEmptyStr(dbeQtdLit.Text)) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'A quantidade de onças deve ser preenchido!', ['&O k']);
//        Result := False;
//      End
//      Else If (fStrToFloat(dbeQtdLit.Text) <= 0) Then
//      Begin
//        fMensagem('ATENÇÃO!', 'A quantidade de onças deve ser maior que Zero!', ['&O k']);
//        Result := False;
//      End;
//
//    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadReiColorantes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_PRECUS');
  stlCampos.Add('COL_MARGEM');
  stlCampos.Add('COL_PREVEN');
  stlCampos.Add('COL_QTDLIT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadReiColorantes.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadCol;
    End;
  End;
end;

procedure TfrmCadReiColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  strCoditeAnt    := '';

  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodCol);
  edtDesIte.Clear;
  btnRestPreco.Visible := True;
end;

procedure TfrmCadReiColorantes.btnAlterarClick(Sender: TObject);
begin
  strCoditeAnt := dbeCodIte.Text;
  inherited;
  dbeCodCol.Enabled := False;
  If (dbeCodIte.Enabled) Then
    pSetFocus(dbeCodIte );

  btnRestPreco.Visible := True;
end;

procedure TfrmCadReiColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadReiColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;


procedure TfrmCadReiColorantes.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadCol := fCriarQuery('SELECT * FROM REI_CADCOL', Self);

  qryCadCol.FieldByName('COL_CODCOL').DisplayLabel := 'Código';
  qryCadCol.FieldbyName('COL_DESCRI').DisplayLabel := 'Descrição';
  qryCadCol.FieldbyName('COL_PRECUS').DisplayLabel := 'Preço Custo';
  qryCadCol.FieldbyName('COL_MARGEM').DisplayLabel := 'Margem';
  qryCadCol.FieldbyName('COL_PREVEN').DisplayLabel := 'Preço Venda';
  qryCadCol.FieldByName('AUTOINCREM').Visible := False;

  dtsCadCol := fCriaDataSource(qryCadCol);
end;

procedure TfrmCadReiColorantes.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conRei, Nil, Nil, qryTabela, Key, arrSel, True, '', 'COL_CODITE', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadReiColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodite.text;
  inherited;

  If fEmptyStr(dbeCodite.text) Then
    pEnviarLogRep(strCodIteAnt, 'REI');

  pCarregaItem;
  btnRestPreco.Visible := False;
end;

procedure TfrmCadReiColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadReiColorantes.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadReiColorantes.btnGravarClick(Sender: TObject);
begin
  fStartTransaction;
  inherited;
  Try
    btnRestPreco.Visible := False;

    If blnGravou Then
    Begin
      pAtualizarFatorTintometrico;

      If Not fEmptyStr(strCodIteAnt) Then
      Begin
        if (strCodIteAnt <> dbeCodIte.Text) Then
        begin
          pEnviarLogRep(strCodIteAnt, 'REI');
        End;
      End;

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
end;

procedure TfrmCadReiColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnRestPreco.Visible := False;
end;

procedure TfrmCadReiColorantes.pAtualizarFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN REI_CADCOL ON ITE_CODITE = COL_CODITE SET ITE_CNV_ML = 841.8710';;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.

