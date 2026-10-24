unit Contabilidade.View.TransferenciaSaldosPlanoContasAnterior;

interface

uses
  Windows, Controls, Forms, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes,
  frxClass, frxExportCSVTestabilidade, Contabilidade.View.TfrmPaiCadContabilidade, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxRadioGroup, cxDBEdit, cxGroupBox, ComboBoxFocus, QColorLabel, Vcl.Dialogs,
  cxProgressBar, MemDS, DBAccess, Uni, Contabilidade.Classes.TImportacaoDadosContabeis, untExcel;

type
  TfrmTransferenciaSaldosPlanoContasAnterior = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    dtsPlaNco: TDataSource;
    dbeContaAnterior: TDBEditFocus;
    dbeContaNovo: TDBEditFocus;
    edtDescricaoContaNovo: TEditFocus;
    lblContaRef: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    dbeValorSaldoInicial: TDBEditFocus;
    lblSigRes: TLabel;
    dbeIndicadorSituacao: TDBEditFocus;
    lblAguardandoSN: TColorLabel;
    Label11: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    dbeCompetencia: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    btnExportar: TBitBtnLocked;
    btnImportar: TBitBtnLocked;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PopImportar: TPopupMenu;
    Importar1: TMenuItem;
    GerarModelo1: TMenuItem;
    PopExclusao: TPopupMenu;
    RegistroAtual1: TMenuItem;
    odosRegistros1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeContaNovoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure Importar1Click(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure GerarModelo1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RegistroAtual1Click(Sender: TObject);
    procedure odosRegistros1Click(Sender: TObject);
  private
    { Private declarations }
    FstrCompetenciaAnterior: String ;
    FstrCodEmpAnterior: String ;
    FstrPathArquivo: String ;
    FobjExcel   : TExcel;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaDescricaoCampos;
    function fValidaCompetencia: boolean;
    procedure pCarregaPlanoContabilNovo(const blnBuscaPorChave: Boolean=False);
    function fImportarArquivo(ApgbProgresso: TcxProgressBar): Boolean ;
    function fExportarArquivo(ApgbProgresso: TcxProgressBar): Boolean ;
    function fGerarArquivo(ApgbProgresso: TcxProgressBar; AstrPath: String): Boolean ;
    function fCarregarArquivo(ApgbProgresso: TcxProgressBar; AstrPath: String): Boolean ;
    procedure pSetaTextoProgresso(ApgbProgresso: TcxProgressBar;
      const AstrTexto: String);
    function fCreateImportacaoDadosContabeis(ApgbProgresso: TcxProgressBar = Nil): IImportacaoDadosContabeis ;
    procedure pExcluirTodosRegistros(const AstrCodEmp, AstrCompet: String) ;
    function fValidaDadosInformados: Boolean ;
    function fRetornaDadosParaExclusao(var AstrCodEmp, AstrCompet: String): Boolean ;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Contabilidade.Interfaces, untTypesSistema, Contabilidade.Funcoes,
     untFuncoesSimples, Contabilidade.Consultas, StrUtils, untConsultas,
     Variants, SysUtils, Contabilidade.Classes.TImportacaoDadosContabeisFactory,
     Contabilidade.Classes.TControleContabilidade,
     Contabilidade.Classes.TImportacaoDadosContabeisTspCoa,
     Contabilidade.View.TransferenciaSaldosPlanoContasAnteriorExcluir;

{$R *.dfm}

procedure TfrmTransferenciaSaldosPlanoContasAnterior.FormCreate(Sender: TObject);
begin
  inherited;
  FstrCompetenciaAnterior := '' ;
  FstrCodEmpAnterior := '' ;
  FstrPathArquivo := '' ;
  strNomeTabela     := 'TSPCOA';
  strNomeCampo      := 'COA_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM TSPCOA', Self);
  dtsPlaNco.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
  FobjExcel := TExcel.fCriarExcel(Self);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FobjExcel) ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pCarregaDescricaoCampos;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnExcluirClick(
  Sender: TObject);
Var
  Lpnt : TPoint;
begin
  Lpnt.X := 0;
  Lpnt.Y := 0;
  Lpnt   := btnExcluir.ClientToScreen( Lpnt );
  Lpnt.Y := Lpnt.Y + btnExcluir.Height + 1;
  PopExclusao.Popup(Lpnt.X, Lpnt.Y);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnExportarClick(
  Sender: TObject);
begin
  inherited;

  FstrPathArquivo := '' ;
  if not SaveDialog.Execute(self.Handle) then
  begin
    fMensagem('ATENÇÃO!', 'Exportação cancelada!', ['&OK']);
    Exit ;
  end ;
  FstrPathArquivo := SaveDialog.FileName ;

  fChamaTelaGravando(fExportarArquivo) ;

  fMensagem('Mensagem!', 'Exportação Concluida!', ['&OK']);

end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnGravarClick(
  Sender: TObject);
begin

  if not fValidaDadosInformados then
    Exit ;

  inherited;
  FstrCompetenciaAnterior := dbeCompetencia.Field.AsString ;
  FstrCodEmpAnterior := dbeCodEmp.Field.AsString ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnImportarClick(
  Sender: TObject);
Var
  Lpnt : TPoint;
begin
  inherited;
  Lpnt.X := 0 ;
  Lpnt.Y := 0 ;
  Lpnt   := btnImportar.ClientToScreen( Lpnt );
  Lpnt.Y := Lpnt.Y + btnImportar.Height;
  popImportar.Popup(Lpnt.X, Lpnt.Y);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnIncluirClick(Sender: TObject);
begin
  inherited;
  //pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
  dbeCompetencia.Field.AsString := FstrCompetenciaAnterior;
  dbeCodEmp.Field.AsString := FstrCodEmpAnterior;
  pCarregaDescricaoCampos;
  pSetFocus(dbeCompetencia);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrPlan: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTransferenciaSaldosPlanoContasAnterior(Self, qryTabela, chrKey, arrPlan) Then
  begin
    pCarregaDescricaoCampos;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.dbeCodEmpKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.dbeContaNovoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    LstrTplaco: String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('COA_PLANOV')).EditMask := '';
    LstrTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(dbeCodEmp.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self,
                                                  dbeContaNovo,
                                                  Nil,
                                                  Nil,
                                                  Key,
                                                  arrSel,
                                                  True,
                                                  LstrTplaco,
                                                  True,
                                                  False,
                                                  '',
                                                  False,
                                                  '',
                                                  '',
                                                  '',
                                                  'S') Then
    Begin
      If fValidaCampos(dbeContaNovo, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('COA_PLANOV')).EditMask := fMskCon;
  End;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fRetornaDadosParaExclusao(
  var AstrCodEmp, AstrCompet: String): Boolean;
var
  LfrmDadosExcluir: TfrmTransferenciaSaldosPlanoContasAnteriorExcluir ;
begin
  Result := False ;
  pCriarFormularios(TfrmTransferenciaSaldosPlanoContasAnteriorExcluir, LfrmDadosExcluir);
  Try
    Try
      LfrmDadosExcluir.showModal;
      Result := LfrmDadosExcluir.Confirma ;

      if Result then
      begin
        AstrCodEmp := LfrmDadosExcluir.CodEmp ;
        AstrCompet := LfrmDadosExcluir.Compet ;
      end ;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmTransferenciaSaldosPlanoContasAnterior.fRetornaDadosParaExclusao]');
      End;
    End;
  finally
    pFreeAndNil(LfrmDadosExcluir);
  end ;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeContaNovo) Then
  Begin
    pCarregaPlanoContabilNovo(blnBuscaPorChave);
    If fEmptyStr(dbeContaNovo.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A conta analitica do plano de contas novo não pode ser vazia.', ['&OK']);
      Result := False;
    End
    Else If (Not fEmptyStr(dbeContaNovo.Text)) And (fEmptyStr(edtDescricaoContaNovo.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
      Result := False;
    End
    Else If (qryTabela.State In [dsInsert, dsEdit]) Then
    begin
      If fEmptyStr(edtDescricaoContaNovo.Text) Then
        dbeContaNovo.Field.Value := Null
      Else
        dbeContaNovo.Field.AsString := fSemMascaraPlaNco(dbeContaNovo.Text);
    end;
  End
  Else If (Sender = dbeCodEmp) Then
  Begin
    If fEmptyStr(dbeCodEmp.Text) Then
    Begin
      fMensagem('','O Código da empresa deve ser preenchido!',['&OK']);
      edtNomEmp.Clear;
      Result := False;
    End
    Else
    Begin
      edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text]);
      If (fEmptyStr(edtNomEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A empresa não está cadastrada!',['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = dbeIndicadorSituacao) Then
  Begin
    If (Not MatchStr(dbeIndicadorSituacao.Text, ['C', 'D'])) Then
    Begin
      fMensagem('ATENÇÃO!','O campo indicador deve ser preenchido com "C" ou "D"!',['&OK']);
      Result := False;
    End;
  End
  Else If (Sender = dbeCompetencia) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dbeCompetencia.Text)) Then
    Begin
      pMensagemOk('A competência não pode ser vazia.');
      Result := False;
    End
    Else If Not fValidaCompetencia Then
    Begin
      pMensagemOk('O mês da competência deve estar entre 01 e 12.');
      Result := False;
    End;
  End
  Else If (Sender = dbeContaAnterior) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dbeContaAnterior.Text)) Then
    Begin
      pMensagemOk('A conta analitica do plano de contas anterior não pode ser vazia.');
      Result := False;
    End;
  End
  Else If (Sender = dbeValorSaldoInicial) Then
  Begin
    If fStrToFloat(dbeValorSaldoInicial.Text) < 0.00 Then
    Begin
      pMensagemOk('O valor do saldo inicial do periodo deve ser negativo!');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fValidaCompetencia: boolean;
Var
  strMes: String;
  strCompetencia: String;
begin
  Result := True;
  strCompetencia := ReplaceStr(dbeCompetencia.Text, '/', '');

  strMes := LeftStr(strCompetencia, 2);

  if Length(strCompetencia) <> 6 Then
    Exit(False);

  If (StrToIntDef(strMes,0) <= 0) Then
    Exit(False);

  If (StrToIntDef(strMes,0) > 12) Then
    Exit(False);
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fValidaDadosInformados: Boolean;
var
  LstrMensagem: String ;
begin
  Result := False ;

  if Not fVerificaCampos then
    Exit ;


  TValidaProcessoTspCoa.pValidaPlanoContasNaPlaini(dbeCodEmp.Field.AsString,
                                                   dbeCompetencia.Field.AsString,
                                                   dbeContaNovo.Field.AsString,
                                                   LstrMensagem) ;
  if not fEmptyStr(LstrMensagem) then
  begin
    fMensagem('ATENÇÃO', LstrMensagem, ['&OK']);
    exit ;
  end ;

  Result := True ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.GerarModelo1Click(
  Sender: TObject);
var
  objExcel : TExcel;
  intCnt : integer ;
  LListaInfoColunas : TListInfoColunaDadosContabeis;
begin
  inherited;

  objExcel := TExcel.fCriarExcel(Self);
  try
    If Not objExcel.CriarArquivo Then
    begin
      Exit;
    End;

    objExcel.ProximaLinha;
    LListaInfoColunas := fCreateImportacaoDadosContabeis.fColunas ;
    for intCnt := 0 to LListaInfoColunas.Count-1 do
    begin
      objExcel.Escrever(objExcel.LinhaAtual, intCnt+1, LListaInfoColunas.Items[intCnt].Descricao);
    end;

    objExcel.AutoAjuste;
    objExcel.SalvarArquivo;
    objExcel.FecharArquivo;
  finally
    FreeAndNil(objExcel);
  end;

  fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.Importar1Click(
  Sender: TObject);
begin
  inherited;
  FstrPathArquivo := '' ;
  if not OpenDialog.Execute(self.Handle) then
  begin
    fMensagem('ATENÇÃO!', 'Importação cancelada!', ['&OK']);
    Exit ;
  end ;
  FstrPathArquivo := OpenDialog.FileName ;
  if FobjExcel.AbrirArquivo(FstrPathArquivo) then
  begin
    fChamaTelaGravando(fImportarArquivo) ;
  end ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.odosRegistros1Click(
  Sender: TObject);
var
  LstrCodEmp: String ;
  LstrCompet: String ;
begin
  inherited;

  if not fRetornaDadosParaExclusao(LstrCodEmp, LstrCompet) then
    Exit ;

  if fMensagem('ATENÇÃO!', 'Deseja realmente excluir TODOS os registros da empresa/competência?', ['&Sim', '&Não'], 1) = 2 then
    Exit;

  pExcluirTodosRegistros(LstrCodEmp, LstrCompet) ;

  qryTabela.Close ;
  qryTabela.Open ;

  pCarregaDescricaoCampos;

  fMensagem('Mensagem!', 'Dados excluídos com sucesso!', ['&OK']);

end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('COA_PLANOV').EditMask := fMskCon;
  DataSet.FieldByName('COA_COMPET').EditMask := '99/9999;0;_';
  TFloatField(DataSet.FieldByName('COA_VALLAN')).DisplayFormat := fMskDigitos(2);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pCarregaDescricaoCampos;
var
  strTplAco: string ;
begin
  edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text], False);
  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text], False);
  edtDescricaoContaNovo.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [dbeContaNovo.Text, strTplAco], False);
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pCarregaPlanoContabilNovo(
  const blnBuscaPorChave: Boolean);
var
  strTplAco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDescricaoContaNovo.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_PATRIM'], [dbeContaNovo.Text, 'S']);
  end
  else
  begin
    strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text], False);
    edtDescricaoContaNovo.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO', 'NCO_PATRIM'], [dbeContaNovo.Text, strTplAco, 'S']);
  end;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fCarregarArquivo(
  ApgbProgresso: TcxProgressBar; AstrPath: String): Boolean;
var
  LobjImportacaoDados : IImportacaoDadosContabeis;
begin
  LobjImportacaoDados := fCreateImportacaoDadosContabeis(ApgbProgresso) ;
  result := LobjImportacaoDados.fCarregaDadosPlanilha(TMostraMensagemErroValidacao.pMostra) ;
  if result then
  begin
    result := LobjImportacaoDados.fPersisteDados ;
  end;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fCreateImportacaoDadosContabeis(
  ApgbProgresso: TcxProgressBar): IImportacaoDadosContabeis;
begin
  Result := TImportacaoDadosContabeisFactory.New.fImportacao(tidcTransfSaldosPlanco,
                                                             ApgbProgresso,
                                                             FobjExcel,
                                                             True,
                                                             '',
                                                             '',
                                                             '',
                                                             nil) ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pExcluirTodosRegistros(const AstrCodEmp, AstrCompet: String);
var
  LqryDados: TUniQuery ;
begin
  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Add('SELECT * FROM TSPCOA WHERE COA_CODEMP = :CODEMP AND COA_COMPET = :COMPET') ;
    LqryDados.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryDados.ParamByName('COMPET').AsString := AstrCompet ;
    LqryDados.Open ;
    LqryDados.First ;
    fStartTransaction();
    try
      while not LqryDados.Eof do
      begin
        fVerificaIntegridade(Self.Name, 'TSPCOA', LqryDados) ;
        LqryDados.delete ;
      end ;
      fCommit();
    Except
      On E: Exception Do
      begin
        fRollBack();
        pMensagensErro(E.Message, 'TfrmTransferenciaSaldosPlanoContasAnterior.pExcluirTodosRegistros');
      end ;
    End;
  finally
    FreeAndNil(LqryDados) ;
  end ;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fExportarArquivo(
  ApgbProgresso: TcxProgressBar): Boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Iniciando Exportação...') ;
  Result := fGerarArquivo(ApgbProgresso, FstrPathArquivo) ;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fGerarArquivo(
  ApgbProgresso: TcxProgressBar; AstrPath: String): Boolean;
var
  LqryConsulta: TUniQuery ;
  LlstArquivo: TStringList ;
  LstrLinha: String ;
  LintCnt: Integer ;
begin

  if FileExists(AstrPath) then
    DeleteFile(AstrPath) ;

  pSetaTextoProgresso(ApgbProgresso, 'Gerando Exportação...') ;

  LqryConsulta := fCriaQuery() ;
  LlstArquivo  := TStringList.Create ;
  try
    LlstArquivo.Clear ;
    // cabeçalho
    LstrLinha := '"Competência";"Empresa";"Plano Contas Anterior";"Devedor/Credor";"Saldo Inicial";"Plano Contas Novo";"Descrição Plano Contas Novo"' ;
    LlstArquivo.Add(LstrLinha) ;

    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT TSPCOA.COA_COMPET, TSPCOA.COA_CODEMP, TSPCOA.COA_PLAANT, TSPCOA.COA_INDSIT, TSPCOA.COA_VALLAN, TSPCOA.COA_PLANOV, PLANCO.NCO_DESCRI ') ;
    LqryConsulta.SQL.Add(' FROM TSPCOA ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN CADEMP ON CADEMP.EMP_CODEMP = TSPCOA.COA_CODEMP ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN PLANCO ON TSPCOA.COA_PLANOV = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = CADEMP.EMP_TPLACO ') ;
    LqryConsulta.SQL.Add(' ORDER BY TSPCOA.COA_COMPET ') ;
    LqryConsulta.Open ;

    ApgbProgresso.Properties.Max := LqryConsulta.RecordCount ;

    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      ApgbProgresso.Position := LqryConsulta.RecNo;
      Application.ProcessMessages;

      LstrLinha := '' ;
      for LintCnt := 0 to LqryConsulta.FieldCount-1 do
      begin
        LstrLinha := LstrLinha + '"' + LqryConsulta.Fields.Fields[LintCnt].AsString + '";' ;
      end ;
      LlstArquivo.Add(LstrLinha) ;

      LqryConsulta.Next ;
    end ;

    LlstArquivo.SaveToFile(AstrPath);

  finally
    FreeAndNil(LqryConsulta) ;
    FreeAndNil(LlstArquivo) ;
  end ;

  Result := True ;
end;

function TfrmTransferenciaSaldosPlanoContasAnterior.fImportarArquivo(
  ApgbProgresso: TcxProgressBar): Boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Iniciando Importação...') ;
  Result := fCarregarArquivo(ApgbProgresso, FstrPathArquivo) ;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COA_CODEMP');
  stlCampos.Add('COA_COMPET');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COA_COMPET');
  stlCamInd.Add('COA_CODEMP');

  stlDesInd.Add('Data');
  stlDesInd.Add('Empresa');
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; const AstrTexto: String);
begin
  If Assigned(ApgbProgresso) And (GetParentForm(ApgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(ApgbProgresso).FindComponent('lblGravando')).Caption := AstrTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnterior.RegistroAtual1Click(
  Sender: TObject);
begin
  TfrmPaiCadContabilidade(Self).btnExcluirClick(Sender);
  pCarregaDescricaoCampos;
end;

end.


