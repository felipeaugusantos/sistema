unit untCadSolBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  BitBtnLockedIncrem;

type
  TfrmCadSolBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeUnid: TDBEditFocus;
    dbeUnidadDescri: TEditFocus;
    dbeUnidUnid: TEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeCodIteDescri: TEditFocus;
    Label6: TLabel;
    dbePreCus: TDBEditFocus;
    Label7: TLabel;
    dbeMargem: TDBEditFocus;
    Label8: TLabel;
    dbePreVen: TDBEditFocus;
    pnlCabecalho: TPanel;
    btnRestPreco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure dbeUnidExit(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeUnidKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    qryCadSol: TUniQuery;
    dtsCadSol: TDataSource;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fValidaCodIte(strCodIte: String): Boolean;
    function fRetDescItem(strCodIte: String): String;
    function fValidaUnidade(strCodUni: String): Boolean;
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pMudarEstado(DataSet: TDataSet);
    { Public declarations }
  end;

var
  frmCadSolBases: TfrmCadSolBases;

implementation

uses untFuncoesSimples,  untPai, untFuncTinta,
   TypInfo, untConsultaCompRelacionamento;

{$R *.dfm}


procedure TfrmCadSolBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadSol;
  strNomeTabela := 'SOL_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeDescri;
  arrCamposChave[2] := dbeUnid;
end;

function TfrmCadSolBases.fRetDescItem(strCodIte: String): String;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = "' + strCodIte + '"', Self);
  qryGen.Open;
  Result := qryGen.FieldByName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

function TfrmCadSolBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin

      If fEmptyStr(dbeCodigo.Text) Then
      Begin
        fMensagem('', 'O código da base deve ser preenchido!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          strDesUni := dbeUnidadDescri.Text;
          strSigUni := dbeUnidUnid.Text;
          pLimparCampos;
          dbeUnidadDescri.Text := strDesUni;
          dbeUnidUnid.Text := strSigUni;
        End;
      End;

    End

    Else If (Sender = dbeCodIte) Then
    Begin

//      If fEmptyStr(dbeCodIte.Text) Then
//      Begin
//        fMensagem('', 'O Item base deve ser preenchido!', ['OK']);
//        Result := False;
//      End
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If Not fValidaCodIte(dbeCodIte.Text) Then
        Begin
          fMensagem('', 'Esse item não está cadastrado!', ['OK']);
          Result := False;
        End
        Else If Not fItemAtivo(dbeCodIte.Text) Then
        Begin
          fMensagem('', 'Esse item não está ativo!', ['OK']);
          Result := False;
        End
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'SOL_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
        End;
      End;


    End

    Else If (Sender = dbeUnid) Then
    Begin

      If fEmptyStr(dbeUnid.Text) Then
      Begin
        fMensagem('', 'A unidade deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If Not fValidaUnidade(dbeUnid.Text) Then
      Begin
        fMensagem('', 'Essa unidade não é válida!', ['OK']);
        Result := False;
      End;

    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If (Sender = dbePreCus)Then
      Begin
        If fEmptyStr(dbePreCus.Text) Then
        Begin
          fMensagem('', 'O preço de custo deve ser preenchido!', ['OK']);
          Result := False;
        End

        Else If (fStrToFloat(dbePreCus.Text) <= 0.0) Then
        Begin
          fMensagem('', 'O preço de custo deve ser maior que zero!', ['OK']);
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

      Else If (Sender = dbeMargem) Then
      Begin
        If fEmptyStr(dbeMargem.Text) Then
        Begin
          fMensagem('', 'A margem deve ser preenchida!', ['OK']);
          Result := False;
        End

        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('', 'A margem deve ser maior que zero!', ['OK']);
          Result := False;
        End

        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End
    End;

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadSolBases.fValidaCodIte(strCodIte: String): Boolean;
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

procedure TfrmCadSolBases.pCriaDataSets;
begin
  //
  qryCadSol := fCriarQuery('SELECT * FROM SOL_CADBAS WHERE FALSE', Self);
  qryCadSol.FieldByName('AUTOINCREM').Visible := False;
  dtsCadSol := fCriaDataSource(qryCadSol);

  qryCadSol.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadSol.FieldByName('BAS_CODUNI').DisplayLabel := 'Unidade';
  qryCadSol.FieldByName('BAS_CODITE').DisplayLabel := 'Cód. Item';
  qryCadSol.FieldByName('BAS_DESCRI').DisplayLabel := 'Descrição';
  qryCadSol.FieldByName('BAS_PRECUS').DisplayLabel := 'Pr. Custo';
  qryCadSol.FieldByName('BAS_PREVEN').DisplayLabel := 'Pr. Venda';
  qryCadSol.FieldByName('BAS_MARGEM').DisplayLabel := 'Margem';

  TFloatField(qryCadSol.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadSol.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadSol.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';

  qryCadSol.AfterCancel := pMudarEstado;
  qryCadSol.AfterDelete := pMudarEstado;
  qryCadSol.AfterEdit := pMudarEstado;
  qryCadSol.AfterInsert := pMudarEstado;
end;

procedure TfrmCadSolBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODUNI');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESCRI+BAS_CODBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadSolBases.pLigaDataSets;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
      (Components[intCont] as TDBEditFocus).DataSource := dtsCadSol;
  End;

  dbeCodigo.DataField := 'BAS_CODBAS';
  dbeCodIte.DataField := 'BAS_CODITE';
  dbeDescri.DataField := 'BAS_DESCRI';
  dbeMargem.DataField := 'BAS_MARGEM';
  dbeUnid.DataField   := 'BAS_CODUNI';
  dbePreCus.DataField  := 'BAS_PRECUS';
  dbePreVen.DataField  := 'BAS_PREVEN';

end;

procedure TfrmCadSolBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  dbeCodIteDescri.Text := fRetDescItem(dbeCodIte.Text);
end;

function TfrmCadSolBases.fValidaUnidade(strCodUni: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS CONT FROM CADUNI WHERE UNI_CODUNI = "' + strCodUni + '"', Self);
  qryGen.Open;

  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadSolBases.pRetDescUnidade(strCodUni: String; out strDescri,
  strUnid: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT UNI_SIGUNI, UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = "' + strCodUni + '"', Self);
  qryGen.Open;

  strDescri := qryGen.FieldByName('UNI_DESUNI').AsString;
  strUnid := qryGen.FieldByName('UNI_SIGUNI').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmCadSolBases.dbeUnidExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(dbeUnid.Text, strDescri, strUnid);
  dbeUnidadDescri.Text := strDescri;
  dbeUnidUnid.Text := strUnid;
end;

procedure TfrmCadSolBases.dbeCodIteKeyPress(Sender: TObject;
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

procedure TfrmCadSolBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadSolBases.dbeUnidKeyPress(Sender: TObject; var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadUni : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadUni := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	UNI_CODUNI AS "Código", ';
    strSQL := strSQL + ' 	UNI_DESUNI AS "Descrição", ';
    strSQL := strSQL + ' 	UNI_SIGUNI AS "Unidade", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	CADUNI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	UNI_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('UNI_CODUNI');
    stlIndice.Add('UNI_DESUNI');
    stlIndice.Add('UNI_SIGUNI');

    stlDescricao.Add('Código');
    stlDescricao.Add('Descrição');
    stlDescricao.Add('Unidade');

    stlIndCampos.Add('UNI_CODUNI');
    stlIndCampos.Add('UNI_DESUNI');
    stlIndCampos.Add('UNI_SIGUNI');

    utcRegistros.Limpar(Self.Name + 'CADUNI');
    If pConsultaComp(Self, qryCadUni, 'CADUNI', strSQL, stlIndice, stlDescricao) Then
    Begin
      dbeUnid.Text := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      dbeUnidadDescri.Text := qryCadUni.FieldByName('UNI_DESUNI').AsString;
      dbeUnidUnid.Text := qryCadUni.FieldByName('UNI_SIGUNI').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadUni);
  End;
end;

function TfrmCadSolBases.fRetPrecoVenda(intOpcao: Integer): Double;
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

procedure TfrmCadSolBases.btnRestPrecoClick(Sender: TObject);
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

procedure TfrmCadSolBases.pMudarEstado(DataSet: TDataSet);
begin
  btnRestPreco.Visible := (DataSet.State in [dsEdit, dsInsert]);
end;

procedure TfrmCadSolBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadSolBases.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + ' 	BAS_CODBAS "Base", ';
  strSQL := strSQL + ' 	BAS_CODUNI "Unidade", ';
  strSQL := strSQL + ' 	BAS_DESCRI "Descrição", ';
  strSQL := strSQL + ' 	ITE_CODITE "Código do Item", ';
  strSQL := strSQL + ' 	ITE_DESITE "Descrição do Item", ';
  strSQL := strSQL + ' 	ITE_REFERE "Referência do Item", ';
  strSQL := strSQL + ' 	B.AUTOINCREM "AUTOINCREM" ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' 	SOL_CADBAS B ';
  strSQL := strSQL + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' 	TRUE ';

  frmConsultaCompRelacionamento := TfrmConsultaCompRelacionamento.Create(Self);
  frmConsultaCompRelacionamento.strCampoRelacionamento := 'Código do Item';

  If pConsultaComp(Self, qryTabela, 'SOL_CADBAS', strSQL, stlCamInd, stlDesInd, '', False, frmConsultaCompRelacionamento) Then
  Begin
    dbeCodIteExit(Sender);
    dbeUnidExit(Sender);
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadSolBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  //
end;

end.

