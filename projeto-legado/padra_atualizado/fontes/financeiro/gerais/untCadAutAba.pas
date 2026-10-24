unit untCadAutAba;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBEditFocus, Menus, EditFocus, DB, Uni, Windows, AppEvnts, DBComboBoxFocus,
  untAutAba, frxClass, frxDBSet, BitBtnLockedIncrem, DBCtrls, Mask,
  frxExportCSVTestabilidade,untRelAutAba,untFastPrintEditor,UniClientDataSet,
  frxDMPExport;

type
  TfrmCadAutAba = class(TfrmPaiCad)
    Label1: TLabel;
    dbeSeqAbast: TDBEditFocus;
    Label2: TLabel;
    dbeCodFor: TDBEditFocus;
    Label3: TLabel;
    dbeDtaEmi: TDBEditFocus;
    Label7: TLabel;
    dbeVolQtdLitros: TDBEditFocus;
    edtNomFor: TEditFocus;
    pnlFundo: TPanel;
    Label28: TLabel;
    dbeCodMot: TDBEditFocus;
    edtNomMot: TEditFocus;
    Label4: TLabel;
    dbePlaVei: TDBEditFocus;
    edtNomVei: TEditFocus;
    dbcCombustivel: TDBComboBoxFocus;
    Label5: TLabel;
    Label6: TLabel;
    dbeValAbast: TDBEditFocus;
    dtsAutAba_: TDataSource;
    edtNomEmp: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    Label8: TLabel;
    dbeStatus: TDBEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    dbeKm_Vei: TDBEditFocus;
    lblDigita: TLabel;
    edtNomOpe: TEditFocus;
    dbeCodOpe: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure dbeKm_VeiKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objAutAba: TAutAba;
    RelAutAba : TRelAutAba;
    cdsRelatorio: TUniClientDataSet;
    editorFast: TFastPrintFileEditor;
    procedure pCarregaDadosAdicionais(DataSet: TDataSet);
    function fCriaClientDatasetRelAutAba: TUniClientDataSet;
    function fImprimeRelatorioLayout: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pInicializaIndices; override;
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untConstantes, untPai, untConsultas,
  untTypesSistema;

{$R *.dfm}

{ TfrmCadAutAba }

procedure TfrmCadAutAba.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadAutAba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
    FreeAndNil(objAutAba);
end;

procedure TfrmCadAutAba.FormCreate(Sender: TObject);
begin
  objAutAba     := TAutAba.Create(Self);
  inherited;
  strNomeTabela := 'AUTABA';
  strNomeCampo  := 'ABA_SEQABA';
  qryTabela     := objAutAba.qryTabela;
  qryTabela.AfterScroll := pCarregaDadosAdicionais;
  dtsAutAba_.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeSeqAbast;
  arrCamposChave[1] := dbeCodEmp;
end;

function TfrmCadAutAba.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = dbeDtaEmi) Then
        objAutAba.strDtaEmi := dbeDtaEmi.Text

      Else If (Sender = dbePlaVei) Then
      Begin

        If fVeiculoInativo(dbePlaVei.Text) Then
        Begin
          edtNomVei.Clear;
          fMensagem('','Este veículo está inativo.',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (objAutAba.strPlaVei <> dbePlaVei.Text) Then
            qryTabela.FieldByName('ABA_KM_VEI').AsString := fCampoTabela('VEI_KMATUA', 'CADVEI', ['VEI_PLAVEI'], [fTiraCaracEspeciais(dbePlaVei.Text)]);

          objAutAba.strPlaVei := dbePlaVei.Text;
          If Result Then
            dbePlaVei.Text := objAutAba.strPlaVei;
        End;

      End

      Else If Sender = dbeCodMot Then
        objAutAba.strCodMot := dbeCodMot.Text

      Else If Sender = dbeCodFor Then
        objAutAba.strCodFor := dbeCodFor.Text

      Else If Sender = dbeVolQtdLitros Then
        objAutAba.fltQtdLts := dbeVolQtdLitros.Field.AsFloat

      Else If Sender = dbeValAbast Then
        objAutAba.fltVlrAbs := dbeValAbast.Field.AsFloat

      Else If Sender = dbeKm_Vei Then
        objAutAba.strKm_Vei := dbeKm_Vei.Text

      Else If Sender = dbcCombustivel Then
        objAutAba.strCombus := dbcCombustivel.Text

      Else If Sender = dbeCodEmp Then
        objAutAba.strCodEmp := dbeCodEmp.Text

    Except
      On E: ExceptionAutCom Do
      Begin
        Result := False;
			  fMensagem('', E.Message,['&Ok']);
      End;

      On E: Exception Do
      Begin
			  pMensagensErro(E.Message,'[TfrmCadAutAba.fValidaCampos]');
        Result := False;
      End;
    End;
  End;

  pCarregaDadosAdicionais(dtsAutAba_.DataSet);

  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAutAba.pCarregaDadosAdicionais(DataSet: TDataSet);
begin
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
  edtNomVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);
  edtNomMot.Text := fRetNomeMotorista(dbeCodMot.Text);
  edtNomOpe.Text := fRetNomeOperador(dbeCodOpe.Text);
end;

procedure TfrmCadAutAba.pInicializaIndices;
begin
end;

procedure TfrmCadAutAba.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeSeqAbast, dbeDtaEmi, False);

  If blnUsaProCodigo Then
    dbeDtaEmi.SelectAll;
end;

procedure TfrmCadAutAba.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAutAba.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAutAba.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadAutAba.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    If fMensagem('AVISO', 'Deseja imprimir a autorização?', ['&Sim', '&Não']) = 1 Then
    Begin
      If Not fImprimeRelatorioLayout Then
          objAutAba.pImprimeAutorizacao(dbeSeqAbast.Text, dbeCodEmp.Text, Self.Name);
    End;
  End
  Else
    fRollBack;
end;

procedure TfrmCadAutAba.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeSeqAbast, dbeDtaEmi, False)
  Else
    pHabilitaCodigo(dbeSeqAbast, dbeSeqAbast, True);

  dbeDtaEmi.Field.Value := FormatDateTime('DD/MM/YYYY', VS_Date);

  dbeCodOpe.Field.Value := strLoginUsuarioLogado;
  edtNomOpe.Text        := strDescriUsuarioLogado;

  If blnUsaProCodigo Then
    dbeDtaEmi.SelectAll;

  dbeVolQtdLitros.Field.Value := 0.000;
  dbeValAbast.Field.Value := 0.00;
  dbeStatus.Field.Value := 'N';
  edtNomEmp.Clear;
  edtNomFor.Clear;
  edtNomMot.Clear;
  edtNomVei.Clear;
end;

procedure TfrmCadAutAba.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAbastecimento: TConsultasArray;
begin
  chrKey := '?';

  If fPesqAbastecimento(Self, dbeSeqAbast, qryTabela, chrKey, arrAbastecimento) Then
  Begin
    pSetFocus(btnAlterar);
  End;
 
end;

procedure TfrmCadAutAba.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpresa: TConsultasArray;

begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    fValidaCampos(dbeCodEmp, True);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAutAba.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornecedor : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornecedor) Then
  Begin
    fValidaCampos(dbeCodFor, True);
		Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAutAba.dbeCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMotorista : TConsultasArray;
begin
  inherited;
  If fPesqMotorista(Self, dbeCodMot, edtNomMot, Nil, Key, arrMotorista) Then
  Begin
    fValidaCampos(dbeCodMot, True);
		Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAutAba.dbeKm_VeiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['0'..'9', #8]) Then
    Key := #0;
end;

procedure TfrmCadAutAba.dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVeiculo: TConsultasArray;
begin
  inherited;
  If fPesqVeiculos(Self, dbePlaVei, edtNomVei, Nil, Key, arrVeiculo, True, True,  ' VEI_STATUS = "A" ') Then
  Begin
    fValidaCampos(dbePlaVei, True);
		Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadAutAba.fCriaClientDatasetRelAutAba: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_DTAEMI';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_SEQABA';
    DataType := ftString;
    Size     := 6;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODFOR';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_PLAVEI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_COMBUS';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODMOT';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_QTDLTS';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_VLRABA';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_KM_VEI';
    DataType := ftString;
    Size     := 7;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESVEI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMFOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMMOT';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMEMP';
    DataType := ftString;
    Size     := 100;
  end;

  Result.CreateDataSet;

end;

function TfrmCadAutAba.fImprimeRelatorioLayout: Boolean;
Var
  blnEmpty : Boolean;
  qryAux: TUniQuery;
  strSql: String;
  LNomFil : String;
  LTipImp : String;
begin
  Result := False;
  cdsRelatorio  := fCriaClientDatasetRelAutAba;
  editorFast := TFastPrintFileEditor.Create(Self);
  qryAux := fCriaQuery;
  Try
    strSql := '';
    strSql := strSql + 'SELECT *  ';
    strSql := strSql + 'FROM AUTABA  ';
    strSql := strSql + 'WHERE ABA_SEQABA = :SEQABA AND ';
    strSql := strSql + 'ABA_CODEMP = :CODEMP ';

    With qryAux Do
    Begin
      Close;
      Params.Clear;
      SQL.Clear;
      SQL.Add(strSql);
      ParamByName('SEQABA').AsString := dbeSeqAbast.Text;
      ParamByName('CODEMP').AsString := dbeCodEmp.Text;
      Open;
      If Not isEmpty Then
      Begin
        cdsRelatorio.Append;
        cdsRelatorio.FieldByName('ABA_CODEMP').AsString   := FieldByName('ABA_CODEMP').AsString;
        cdsRelatorio.FieldByName('ABA_DTAEMI').AsDateTime := FieldByName('ABA_DTAEMI').AsDateTime;
        cdsRelatorio.FieldByName('ABA_SEQABA').AsString   := FieldByName('ABA_SEQABA').AsString;
        cdsRelatorio.FieldByName('ABA_CODFOR').AsString   := FieldByName('ABA_CODFOR').AsString;
        cdsRelatorio.FieldByName('ABA_PLAVEI').AsString   := FieldByName('ABA_PLAVEI').AsString;
        cdsRelatorio.FieldByName('ABA_COMBUS').AsString   := FieldByName('ABA_COMBUS').AsString;
        cdsRelatorio.FieldByName('ABA_CODMOT').AsString   := FieldByName('ABA_CODMOT').AsString;
        cdsRelatorio.FieldByName('ABA_KM_VEI').AsString   := FieldByName('ABA_KM_VEI').AsString;

        cdsRelatorio.FieldByName('DESVEI').AsString   := fRetornaDescricaoVeic(FieldByName('ABA_PLAVEI').AsString);
        cdsRelatorio.FieldByName('NOMFOR').AsString   := fRetNomFornecedor(FieldByName('ABA_CODFOR').AsString);
        cdsRelatorio.FieldByName('NOMMOT').AsString   := fRetNomeMotorista(FieldByName('ABA_CODMOT').AsString);
        cdsRelatorio.FieldByName('NOMEMP').AsString   := fRetNomeEmpresaSelec(FieldByName('ABA_CODEMP').AsString);

        cdsRelatorio.FieldByName('ABA_QTDLTS').AsFloat:= FieldByName('ABA_QTDLTS').AsFloat;
        cdsRelatorio.FieldByName('ABA_VLRABA').AsFloat:= FieldByName('ABA_VLRABA').AsFloat;
        cdsRelatorio.Post;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
  RelAutAba  := TRelAutAba.CreateInstance(cdsRelatorio);
  editorFast.pSetFastPrintFile(RelAutAba);
  blnEmpty := RelAutAba.IsEmpty;
  If Not blnEmpty Then
  Begin
    { Sem layout personalizado a impressao segue pelo layout padrao (pImprimeAutorizacao), que ja
      pede a impressora. Perguntar a fila antes de saber se o layout existe abria a selecao duas vezes. }
    If editorFast.fLoadReport Then
    Begin
      pCarregaConfImpr(qryCfgRel, Self.Name);
      LNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      LTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

      If fEmptyStr(LNomFil) Then
        fPreImpressao(qryCfgRel, LNomFil, LTipImp, False);

      editorFast.pSelectFil(Self.Name, LNomFil, fRetNomeRede);
      editorFast.pPrint;
      Result := True;
    End;
  End;

  FreeAndNil(editorFast);
  FreeAndNil(cdsRelatorio);
end;
end.

