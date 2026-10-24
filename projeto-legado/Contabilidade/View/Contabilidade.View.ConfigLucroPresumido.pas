unit Contabilidade.View.ConfigLucroPresumido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls,
  Contabilidade.Interfaces.ConfigLucroPresumido, Data.DB, Datasnap.DBClient,
  UniClientDataSet, System.Generics.Collections, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons,
  EditFocus, cxLabel, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxButtonEdit,
  Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus,
  Contabilidade.Interfaces.SharedLucroPresumido;

type
  TfrmConfigLucroPresumido = class(TfrmPaiContabilidade)
    pgcParametros: TPageControl;
    tbsCsll: TTabSheet;
    tbsIrpj: TTabSheet;
    tbsLancamentosContabeis: TTabSheet;
    pnlAbrirExercicio: TPanel;
    cxLabel1: TcxLabel;
    edtExercicio: TEditFocus;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    btnAbrir: TcxButton;
    GridTabDetalheCsll: TcxGridDBTableViewCitel;
    GridDetalheCsllLevel1: TcxGridLevel;
    GridDetalheCsll: TcxGridCitel;
    dsDetalheCsll: TDataSource;
    dsDetalheIrpj: TDataSource;
    GridTabDetalheCsllDESCOD: TcxGridDBColumn;
    GridTabDetalheCsllDESCRI: TcxGridDBColumn;
    GridTabDetalheCsllGRUPO_: TcxGridDBColumn;
    GridTabDetalheCsllPLANCO: TcxGridDBColumn;
    GridDetalheIrpj: TcxGridCitel;
    GridTabDetalheIrpj: TcxGridDBTableViewCitel;
    GridTabDetalheIrpjDESCOD: TcxGridDBColumn;
    GridTabDetalheIrpjGRUPO_: TcxGridDBColumn;
    GridTabDetalheIrpjDESCRI: TcxGridDBColumn;
    GridTabDetalheIrpjPLANCO: TcxGridDBColumn;
    GridDetalheIrpjLevel1: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    StyleRepository: TcxStyleRepository;
    EstiloComConta: TcxStyle;
    BtnCopiar: TBitBtnLocked;
    gbParametrosCsll: TGroupBox;
    gbParametrosIrpj: TGroupBox;
    Label12: TLabel;
    dbe_CODCON_csll: TDBEditFocus;
    edt_Descri_csll: TEditFocus;
    Label13: TLabel;
    dbe_HISPAD_csll: TDBEditFocus;
    dbe_HISTOR_csll: TDBMemoFocus;
    Label1: TLabel;
    dbe_CODCON_irpj: TDBEditFocus;
    edt_Descri_irpj: TEditFocus;
    Label2: TLabel;
    dbe_HISPAD_irpj: TDBEditFocus;
    dbe_HISTOR_irpj: TDBMemoFocus;
    dsGeralLanconCsll: TDataSource;
    dsGeralLanconIrpj: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExcluirClick(Sender: TObject);
    procedure GridTabDetalheCsllPLANCOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure GridTabDetalheIrpjPLANCOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure GridTabDetalheCsllStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure BtnCopiarClick(Sender: TObject);
    procedure dbe_CODCON_csllKeyPress(Sender: TObject; var Key: Char);
    procedure dbe_HISPAD_csllKeyPress(Sender: TObject; var Key: Char);
    procedure edtExercicioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FcdsGeralIrpj: TUniClientDataSet ;
    FcdsGeralLanconIrpj: TUniClientDataSet ;
    FcdsDetalheIrpj: TUniClientDataSet ;
    FcdsDetalhePlancoIrpj: TUniClientDataSet ;
    FcdsGeralCsll: TUniClientDataSet ;
    FcdsGeralLanconCsll: TUniClientDataSet ;
    FcdsDetalheCsll: TUniClientDataSet ;
    FcdsDetalhePlancoCsll: TUniClientDataSet ;
    FdictConfCorrespondenteCsllEmIrpj: TDictionary<String,String> ;
    procedure pCarregaConfCorrespondenteCsllEmIrpj ;
    function fCodigoCsllEmIrpjParaClonar(const AstrCodigoCsll: String): String ;
    function fCarrega(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCarrega ;
    function fPersiste(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoSalva ;
    function fDeleta(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoDelete ;
    function fClona(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoClona ;
    function fConverteDataSetToInterfaces(const AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet): IDadosConfigLucroPresumidoCfg ;
    procedure pCarregaEstruturaDatasets ;
    function fCarregaConfiguracoes(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): boolean ;
    procedure pLimpaClientDataSet ;
    procedure pHabilitarEdicao(const AblnHabilitado: Boolean) ;
    procedure pLimpaCampos ;
    procedure pIncluiGeral(const ADadosConfig: IDadosConfigLucroPresumidoCfg; var AcdsGeral: TUniClientDataSet) ;
    procedure pConfiguraPlanoContas(const ATipo: TTipoLucroPresumido; var AcdsDetalhePlanco, AcdsDetalhe, AcdsDetalhePlancoIrpj, AcdsDetalheIrpj: TUniClientDataSet) ;
    procedure pFiltraDetalhePlanco(var AcdsDetalhePlanco, AcdsDetalhe: TUniClientDataSet) ;
    function fSalvaDetalhePlanco(var AcdsDetalhePlanco, AcdsDetalhePlancoClone, AcdsDetalhe: TUniClientDataSet): Boolean ;
    function fValidaPlanoContabil(edtCodigo: TDBEditFocus; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False): Boolean ;
    procedure pCarregaPlanoContabil(strCodigo: String; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False);
    function fValidaHistoricoPadrao(edtCodigo: TDBEditFocus; memDscricao: TDBMemoFocus; const blnBuscaPorChave: boolean): Boolean;
    procedure pCarregaHistoricoPadrao(strCodigo: String; memDscricao: TDBMemoFocus);
    function fValidaHistorico(): Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  Contabilidade.Classes.ConfigLucroPresumidoFactory,
  Contabilidade.Classes.ConfigLucroPresumidoComum, untConsultas,
  untTypesSistema, untFuncoesSimples, Contabilidade.View.AdicionaPlanoContas,
  Contabilidade.Consultas, System.StrUtils, System.Types,
  Contabilidade.View.ConfigLucroPresumidoCopiarDe, Contabilidade.Funcoes,
  Contabilidade.Funcoes.LucroPresumido, Contabilidade.Funcoes.ImpostoRenda,
  Contabilidade.Interfaces;

{$R *.dfm}

{ TfrmConfigLucroPresumido }

procedure TfrmConfigLucroPresumido.btnAbrirClick(Sender: TObject);
var
  LstrMensagem: String ;
begin
  inherited;

  if fEmptyStr(edtExercicio.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  if fCarregaConfiguracoes(edtEmpSel.Text, strToInt(edtExercicio.Text), LstrMensagem) then
    pHabilitarEdicao(False)
  else
  begin
    pMensagemOk(LstrMensagem);
    pSetFocus(edtExercicio) ;
    exit ;
  end ;

end;

procedure TfrmConfigLucroPresumido.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarEdicao(True) ;
  pLimpaCampos ;
end;

procedure TfrmConfigLucroPresumido.BtnCopiarClick(Sender: TObject);
var
  LfrmConfigLucroPresumidoCopiarDe : TfrmConfigLucroPresumidoCopiarDe ;
  LstrMensagem: String ;
  LcdsDados: TUniClientDataSet ;
  LobjDadosIrpj: IDadosConfigLucroPresumidoCfg ;
  LobjDadosCsll: IDadosConfigLucroPresumidoCfg ;
  LblnClonouIrpj, LblnClonouCsll: Boolean ;
  LblnDeletouIrpj, LblnDeletouCsll: Boolean ;
begin
  inherited;
  pCriarFormularios(TfrmConfigLucroPresumidoCopiarDe, LfrmConfigLucroPresumidoCopiarDe);
  try
    LfrmConfigLucroPresumidoCopiarDe.Exercicio := StrToInt(edtExercicio.Text) ;
    LfrmConfigLucroPresumidoCopiarDe.CodEmp := edtEmpSel.Text ;
    if not LfrmConfigLucroPresumidoCopiarDe.fCarregarDados then
    begin
      fMensagem('ATENÇÃO!', 'Não há empresa para copiar configurações!', ['&Ok']);
      Exit ;
    end ;
    LfrmConfigLucroPresumidoCopiarDe.showModal;
    if LfrmConfigLucroPresumidoCopiarDe.blnConfirma then
    begin
      LcdsDados := LfrmConfigLucroPresumidoCopiarDe.cdsConfs ;

      LstrMensagem := 'Deseja realmente sobreescrever as informações' + #13#10 ;
      LstrMensagem := LstrMensagem + 'Exercício: '+ edtExercicio.Text +' Empresa: '+ edtEmpSel.Text + '-' + copy(edtNomEmpSel.Text, 1, 25) + #13#10 ;
      LstrMensagem := LstrMensagem + 'Com as informações da' + #13#10 ;
      LstrMensagem := LstrMensagem + 'Exercício: '+ LcdsDados.FieldByName('EXERCI').AsString +' Empresa: '+ LcdsDados.FieldByName('CODEMP').AsString + '-' + copy(LcdsDados.FieldByName('NOMEMP').AsString, 1, 25) + ' ?' + #13#10 ;

      if (fMensagem('Aviso', LstrMensagem, ['&Sim', '&Não'], 2) = 1) then
      begin
        LobjDadosIrpj := fCarrega(tlpIRPJ).fCarrega(LcdsDados.FieldByName('CODEMP').AsString, LcdsDados.FieldByName('EXERCI').AsInteger, LstrMensagem) ;
        if not Assigned(LobjDadosIrpj) then
        begin
          fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
          Exit ;
        end ;

        LobjDadosCsll := fCarrega(tlpCSLL).fCarrega(LcdsDados.FieldByName('CODEMP').AsString, LcdsDados.FieldByName('EXERCI').AsInteger, LstrMensagem) ;
        if not Assigned(LobjDadosCsll) then
        begin
          fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
          Exit ;
        end ;

        fStartTransaction() ;
        try

          LblnDeletouIrpj := fDeleta(tlpIRPJ).fDelete(FcdsGeralIrpj.FieldByName('CODIGO').AsString) ;
          LblnDeletouCsll := fDeleta(tlpCSLL).fDelete(FcdsGeralCsll.FieldByName('CODIGO').AsString) ;

          if not (LblnDeletouIrpj and LblnDeletouCsll) then
          begin
            fRollback();
            pMensagensErro('Problemas ao deletar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.BtnCopiarClick]');
            exit ;
          end ;

          LblnClonouIrpj := fClona(tlpIRPJ).fClona(edtEmpSel.Text, StrToInt(edtExercicio.Text), LobjDadosIrpj) ;
          LblnClonouCsll := fClona(tlpCSLL).fClona(edtEmpSel.Text, StrToInt(edtExercicio.Text), LobjDadosCsll) ;

          if not (LblnClonouIrpj and LblnClonouCsll) then
          begin
            fRollback();
            pMensagensErro('Problemas ao copiar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.BtnCopiarClick 1]');
            exit ;
          end ;

          pHabilitarEdicao(True) ;
          pLimpaCampos ;
          fCommit() ;

          fMensagem('ATENÇÃO!', 'Configurações copiadas com sucesso!', ['&Ok']);

        Except
          On E: Exception Do
          Begin
            fRollback();
            pMensagensErro(E.message + 'Problemas ao copiar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.BtnCopiarClick 2]');
          End;
        End;

      end ;
    end ;
  finally
    pFreeAndNil(LfrmConfigLucroPresumidoCopiarDe);
  end ;
end;

procedure TfrmConfigLucroPresumido.btnExcluirClick(Sender: TObject);
var
  LblnConfirmadoIrpj, LblnConfirmadoCsll: Boolean ;
begin
  inherited;
  if (fMensagem('Aviso', 'Deseja realmente apagar o registro?', ['&Sim', '&Não'], 2) = 1) then
  begin

    fStartTransaction() ;
    try

      LblnConfirmadoIrpj := fDeleta(tlpIRPJ).fDelete(FcdsGeralIrpj.FieldByName('CODIGO').AsString) ;

      LblnConfirmadoCsll := fDeleta(tlpCSLL).fDelete(FcdsGeralCsll.FieldByName('CODIGO').AsString) ;

      if not (LblnConfirmadoIrpj and LblnConfirmadoCsll) then
      begin
        fRollback();
        pMensagensErro('Problemas ao deletar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.btnExcluirClick 1]');
        exit ;
      end ;

      pHabilitarEdicao(True) ;
      pLimpaCampos ;
      fCommit() ;

    Except
      On E: Exception Do
      Begin
        fRollback();
        pMensagensErro(E.message + 'Problemas ao deletar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.btnExcluirClick 2]');
      End;
    End;

  end ;
end;

procedure TfrmConfigLucroPresumido.btnGravarClick(Sender: TObject);
var
  LObjDadosIrpj, LObjDadosCsll: IDadosConfigLucroPresumidoCfg ;
  LblnConfirmadoIrpj, LblnConfirmadoCsll: Boolean ;
begin
  inherited;

  if not fValidaHistorico then
    Exit ;

  fStartTransaction() ;
  try
    LObjDadosIrpj := fConverteDataSetToInterfaces(FcdsGeralIrpj, FcdsGeralLanconIrpj, FcdsDetalheIrpj, FcdsDetalhePlancoIrpj) ;
    LblnConfirmadoIrpj := fPersiste(tlpIRPJ).fSalva(LObjDadosIrpj) ;

    LObjDadosCsll := fConverteDataSetToInterfaces(FcdsGeralCsll, FcdsGeralLanconCsll, FcdsDetalheCsll, FcdsDetalhePlancoCsll) ;
    LblnConfirmadoCsll := fPersiste(tlpCSLL).fSalva(LObjDadosCsll) ;

    if not (LblnConfirmadoIrpj and LblnConfirmadoCsll) then
    begin
      fRollback();
      pMensagensErro('Problemas ao salvar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.btnGravarClick 1]');
      exit ;
    end ;

    pHabilitarEdicao(True) ;
    pLimpaCampos ;
    fCommit() ;

  Except
    On E: Exception Do
    Begin
      fRollback();
      pMensagensErro(E.message + 'Problemas ao salvar configurações Lucro Presumido. Tente novamente!', '[TfrmConfigLucroPresumido.btnGravarClick 2]');
    End;
  End;

end;

procedure TfrmConfigLucroPresumido.dbe_CODCON_csllKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPlanoContabil(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons) Then
    Begin
      FcdsGeralLanconCsll.Edit ;
      FcdsGeralLanconIrpj.Edit ;
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLucroPresumido.dbe_HISPAD_csllKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqHistoricoPadrao(Self, TDBEditFocus(Sender), Nil, Nil, Key, arrCons, True, edtEmpSel.Text) Then
    Begin
      FcdsGeralLanconCsll.Edit ;
      FcdsGeralLanconIrpj.Edit ;
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigLucroPresumido.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigLucroPresumido.edtExercicioKeyPress(Sender: TObject;
  var Key: Char);
  var arrSel: TConsultasArray;
begin
  inherited;
  If fPesqExercicioLucroPresumido(Self, edtExercicio, edtEmpSel, Nil, Key, arrSel, True) Then
  Begin
    If fValidaCampos(edtExercicio) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmConfigLucroPresumido.fCarrega(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCarrega;
begin
  Result := TFactoryConfigLucroPresumidoCarrega
              .New
              .fConfigura(ATipo) ;
end;

function TfrmConfigLucroPresumido.fCarregaConfiguracoes(
  const AstrCodEmp: String; const AintExercicio: Integer;
  var AstrMensagem: String): boolean;
var
  LObjDadosIrpj, LObjDadosCsll: IDadosConfigLucroPresumidoCfg ;
  LLstCadastroIrpj, LLstCadastroCsll: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;

begin
  Result := False ;

  FcdsGeralIrpj.DisableControls ;
  FcdsGeralLanconIrpj.DisableControls ;
  FcdsDetalheIrpj.DisableControls ;
  FcdsDetalhePlancoIrpj.DisableControls ;

  FcdsGeralCsll.DisableControls ;
  FcdsGeralLanconCsll.DisableControls ;
  FcdsDetalheCsll.DisableControls ;
  FcdsDetalhePlancoCsll.DisableControls ;
  try
    pLimpaClientDataSet ;

    LObjDadosIrpj := fCarrega(tlpIRPJ).fCarrega(AstrCodEmp, AintExercicio, AstrMensagem) ;
    if not Assigned(LObjDadosIrpj) then
      Exit ;

    pConverteInterfacesToDataSetConfig(LObjDadosIrpj, FcdsGeralIrpj, FcdsGeralLanconIrpj, FcdsDetalheIrpj, FcdsDetalhePlancoIrpj) ;
    pIncluiGeral(LObjDadosIrpj, FcdsGeralIrpj) ;
    LLstCadastroIrpj := fSelecionaCadastroTabelaApuracaoBC(tlpIRPJ).fSeleciona ;
    pAjustaDescricaoParametros(LLstCadastroIrpj, FcdsDetalheIrpj, FcdsDetalhePlancoIrpj) ;

    LObjDadosCsll := fCarrega(tlpCSLL).fCarrega(AstrCodEmp, AintExercicio, AstrMensagem) ;
    if not Assigned(LObjDadosIrpj) then
      Exit ;

    pConverteInterfacesToDataSetConfig(LObjDadosCsll, FcdsGeralCsll, FcdsGeralLanconCsll, FcdsDetalheCsll, FcdsDetalhePlancoCsll) ;
    pIncluiGeral(LObjDadosCsll, FcdsGeralCsll) ;
    LLstCadastroCsll := fSelecionaCadastroTabelaApuracaoBC(tlpCSLL).fSeleciona ;
    pAjustaDescricaoParametros(LLstCadastroCsll, FcdsDetalheCsll, FcdsDetalhePlancoCsll) ;

    edt_Descri_csll.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [dbe_CODCON_csll.Field.AsString], False) ;
    edt_Descri_irpj.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [dbe_CODCON_irpj.Field.AsString], False) ;

  finally
    FcdsGeralIrpj.EnableControls ;
    FcdsGeralLanconIrpj.EnableControls ;
    FcdsDetalheIrpj.EnableControls ;
    FcdsDetalhePlancoIrpj.EnableControls ;

    FcdsGeralCsll.EnableControls ;
    FcdsGeralLanconCsll.EnableControls ;
    FcdsDetalheCsll.EnableControls ;
    FcdsDetalhePlancoCsll.EnableControls ;
  end ;

  Result := True ;
end;

function TfrmConfigLucroPresumido.fClona(
  const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoClona;
begin
  Result := TFactoryConfigLucroPresumidoClona
              .New
              .fConfigura(ATipo) ;
end;

function TfrmConfigLucroPresumido.fDeleta(
  const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoDelete;
begin
  Result := TFactoryConfigLucroPresumidoDelete
              .New
              .fConfigura(ATipo) ;
end;

procedure TfrmConfigLucroPresumido.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if btnGravar.Enabled then
  begin
    pMensagemOk('Clique no botão "Gravar" ou "Cancelar" antes de fechar!');
    CanClose := False ;
  end ;
end;

procedure TfrmConfigLucroPresumido.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsGeralIrpj         := TUniClientDataSet.Create(Nil) ;
  FcdsGeralLanconIrpj   := TUniClientDataSet.Create(Nil) ;
  FcdsDetalheIrpj       := TUniClientDataSet.Create(Nil) ;
  FcdsDetalhePlancoIrpj := TUniClientDataSet.Create(Nil) ;
  FcdsGeralCsll         := TUniClientDataSet.Create(Nil) ;
  FcdsGeralLanconCsll   := TUniClientDataSet.Create(Nil) ;
  FcdsDetalheCsll       := TUniClientDataSet.Create(Nil) ;
  FcdsDetalhePlancoCsll := TUniClientDataSet.Create(Nil) ;
  pCarregaEstruturaDatasets ;
  dsDetalheCsll.DataSet := FcdsDetalheCsll ;
  dsDetalheIrpj.DataSet := FcdsDetalheIrpj ;
  dsGeralLanconCsll.DataSet := FcdsGeralLanconCsll ;
  dsGeralLanconIrpj.DataSet := FcdsGeralLanconIrpj ;
  pgcParametros.ActivePageIndex := 0 ;
  pHabilitarEdicao(True) ;
  FdictConfCorrespondenteCsllEmIrpj := TDictionary<String,String>.Create ;
  pCarregaConfCorrespondenteCsllEmIrpj ;
end;

procedure TfrmConfigLucroPresumido.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsGeralIrpj) ;
  FreeAndNil(FcdsGeralLanconIrpj) ;
  FreeAndNil(FcdsDetalheIrpj) ;
  FreeAndNil(FcdsDetalhePlancoIrpj) ;
  FreeAndNil(FcdsGeralCsll) ;
  FreeAndNil(FcdsGeralLanconCsll) ;
  FreeAndNil(FcdsDetalheCsll) ;
  FreeAndNil(FcdsDetalhePlancoCsll) ;
  FreeAndNil(FdictConfCorrespondenteCsllEmIrpj) ;
end;

function TfrmConfigLucroPresumido.fPersiste(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoSalva;
begin
  Result := TFactoryConfigLucroPresumidoSalva.New.fConfigura(ATipo) ;
end;

function TfrmConfigLucroPresumido.fSalvaDetalhePlanco(var AcdsDetalhePlanco,
  AcdsDetalhePlancoClone, AcdsDetalhe: TUniClientDataSet): Boolean;
begin
  ///limpa as contas anteriores, para lançar as novas do cdsClone
  AcdsDetalhePlanco.First ;
  while not AcdsDetalhePlanco.Eof do
    AcdsDetalhePlanco.Delete ;

  AcdsDetalhePlancoClone.First ;
  while not AcdsDetalhePlancoClone.Eof do
  begin
    AcdsDetalhePlanco.Append ;
    AcdsDetalhePlanco.FieldByName('SEQGER').AsString := AcdsDetalhe.FieldByName(TColunaDetalhePlanco.New.fRetornaColuna(AcdsDetalhe.FieldByName('CODIGO').AsString)).AsString ;
    AcdsDetalhePlanco.FieldByName('CODCON').AsString := AcdsDetalhePlancoClone.FieldByName('CODCON').AsString ;
    AcdsDetalhePlanco.FieldByName('DESCRI').AsString := AcdsDetalhePlancoClone.FieldByName('DESCRI').AsString ;
    AcdsDetalhePlanco.FieldByName('TPLACO').AsString := AcdsDetalhePlancoClone.FieldByName('TPLACO').AsString ;
    AcdsDetalhePlanco.Post ;
    AcdsDetalhePlancoClone.Next ;
  end ;

  AcdsDetalhe.Edit ;
  AcdsDetalhe.FieldByName('PLANCO').AsString := IfThen(AcdsDetalhePlanco.IsEmpty, '', 'S') ;
  AcdsDetalhe.Post ;

  Result := True ;
end;

function TfrmConfigLucroPresumido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin

    If (Sender = edtEmpSel) Then
    begin

      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End

    end
    Else If (Sender = dbe_CODCON_csll) Then
      Result := fValidaPlanoContabil(dbe_CODCON_csll, edt_Descri_csll, blnBuscaPorChave)
    Else If (Sender = dbe_CODCON_irpj) Then
      Result := fValidaPlanoContabil(dbe_CODCON_irpj, edt_Descri_irpj, blnBuscaPorChave)
    Else If (Sender = dbe_HISPAD_csll) Then
      Result := fValidaHistoricoPadrao(dbe_HISPAD_csll, dbe_HISTOR_csll, blnBuscaPorChave)
    Else If (Sender = dbe_HISPAD_irpj) Then
      Result := fValidaHistoricoPadrao(dbe_HISPAD_irpj, dbe_HISTOR_irpj, blnBuscaPorChave);

  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmConfigLucroPresumido.fValidaHistorico: Boolean;
begin
  Result := False ;
  if not fEmptyStr(dbe_CODCON_csll.Field.AsString) then
  begin
    if fEmptyStr(dbe_HISPAD_csll.Field.AsString) and fEmptyStr(dbe_HISTOR_csll.Field.AsString) then
    begin
      fMensagem('ATENÇÃO!', 'Histórico Padrão/Complemento não informado!', ['&Ok']);
      pSetFocus(dbe_HISPAD_csll);
      exit ;
    end ;
  end ;

  if not fEmptyStr(dbe_CODCON_irpj.Field.AsString) then
  begin
    if fEmptyStr(dbe_HISPAD_irpj.Field.AsString) and fEmptyStr(dbe_HISTOR_irpj.Field.AsString) then
    begin
      fMensagem('ATENÇÃO!', 'Histórico Padrão/Complemento não informado!', ['&Ok']);
      pSetFocus(dbe_HISPAD_irpj);
      exit ;
    end ;
  end ;
  Result := True ;
end;

function TfrmConfigLucroPresumido.fValidaHistoricoPadrao(
  edtCodigo: TDBEditFocus; memDscricao: TDBMemoFocus;
  const blnBuscaPorChave: boolean): Boolean;
begin
  Result := True;

  if not blnBuscaPorChave then
  begin
    exit ;
  end;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaHistoricoPadrao(edtCodigo.Text, memDscricao);

    If fEmptyStr(memDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Histórico Padrão não encontrado!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    memDscricao.Field.Clear;
end;

function TfrmConfigLucroPresumido.fValidaPlanoContabil(edtCodigo: TDBEditFocus;
  edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False): Boolean;
begin
  Result := True;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaPlanoContabil(edtCodigo.Text, edtDscricao, blnBuscaPorChave);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Conta Contábil não encontrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
    edtDscricao.Clear;
end;

procedure TfrmConfigLucroPresumido.pCarregaPlanoContabil(strCodigo: String; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False);
begin
  If Not fEmptyStr(strCodigo) Then
  begin
    if blnBuscaPorChave then
    begin
      edtDscricao.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [strCodigo], False);
    end
    else
    begin
      edtDscricao.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strCodigo], False);
    end;
  end
  Else
  begin
    edtDscricao.Clear;
  end;
end;

procedure TfrmConfigLucroPresumido.GridTabDetalheCsllPLANCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pConfiguraPlanoContas(tlpCSLL, FcdsDetalhePlancoCsll, FcdsDetalheCsll, FcdsDetalhePlancoIrpj, FcdsDetalheIrpj) ;
end;

procedure TfrmConfigLucroPresumido.GridTabDetalheCsllStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
  LgridTab: TcxGridDBTableViewCitel ;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      LgridTab := Sender as TcxGridDBTableViewCitel ;
      ARowInfo := LgridTab.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(LgridTab.DataController.Values[ARowInfo.RecordIndex,
                         LgridTab.GetColumnByFieldName('PLANCO').Index]) = 'S' Then
      Begin
        AStyle := EstiloComConta;
      End;
    end;
  end;
end;

procedure TfrmConfigLucroPresumido.GridTabDetalheIrpjPLANCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pConfiguraPlanoContas(tlpIRPJ, FcdsDetalhePlancoIrpj, FcdsDetalheIrpj, FcdsDetalhePlancoIrpj, FcdsDetalheIrpj) ;
end;

procedure TfrmConfigLucroPresumido.pCarregaConfCorrespondenteCsllEmIrpj;
begin
  FdictConfCorrespondenteCsllEmIrpj.Add('7;'+BASE_CALCULO_CSLL,'11;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('8;'+BASE_CALCULO_CSLL,'12;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('9;'+BASE_CALCULO_CSLL,'13;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('10;'+BASE_CALCULO_CSLL,'14;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('11;'+BASE_CALCULO_CSLL,'15;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('12;'+BASE_CALCULO_CSLL,'16;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('13;'+BASE_CALCULO_CSLL,'17;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('14;'+BASE_CALCULO_CSLL,'18;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('15;'+BASE_CALCULO_CSLL,'19;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('16;'+BASE_CALCULO_CSLL,'20;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('16.01;'+BASE_CALCULO_CSLL,'20.01;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('18;'+BASE_CALCULO_CSLL,'22;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('19;'+BASE_CALCULO_CSLL,'23;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('19.01;'+BASE_CALCULO_CSLL,'25.01;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('19.02;'+BASE_CALCULO_CSLL,'25.02;'+BASE_CALCULO_IRPJ);
  FdictConfCorrespondenteCsllEmIrpj.Add('20;'+BASE_CALCULO_CSLL,'24;'+BASE_CALCULO_IRPJ);
end;

procedure TfrmConfigLucroPresumido.pCarregaEstruturaDatasets;
begin
  //IRPJ
  pCarregaEstruturaConfig(FcdsGeralIrpj, FcdsGeralLanconIrpj, FcdsDetalheIrpj, FcdsDetalhePlancoIrpj) ;

  FcdsGeralIrpj.CreateDataSet ;

  FcdsGeralLanconIrpj.CreateDataSet ;

  FcdsDetalheIrpj.CreateDataSet ;

  FcdsDetalhePlancoIrpj.CreateDataSet ;
  FcdsDetalhePlancoIrpj.IndexFieldNames := 'SEQGER' ;

  ///CSLL
  pCarregaEstruturaConfig(FcdsGeralCsll, FcdsGeralLanconCsll, FcdsDetalheCsll, FcdsDetalhePlancoCsll) ;

  FcdsGeralCsll.CreateDataSet ;

  FcdsGeralLanconCsll.CreateDataSet ;

  FcdsDetalheCsll.CreateDataSet ;

  FcdsDetalhePlancoCsll.CreateDataSet ;
  FcdsDetalhePlancoCsll.IndexFieldNames := 'SEQGER' ;

end;

procedure TfrmConfigLucroPresumido.pCarregaHistoricoPadrao(strCodigo: String;
  memDscricao: TDBMemoFocus);
begin
  If Not fEmptyStr(strCodigo) Then
    memDscricao.Field.AsString := fRetDescHistoricoPadrao(strCodigo, edtEmpSel.Text)
  Else
    memDscricao.Field.Clear;
end;

function TfrmConfigLucroPresumido.fCodigoCsllEmIrpjParaClonar(
  const AstrCodigoCsll: String): String;
begin
  Result := '' ;
  if FdictConfCorrespondenteCsllEmIrpj.ContainsKey(AstrCodigoCsll) then
    Result := FdictConfCorrespondenteCsllEmIrpj.Items[AstrCodigoCsll] ;
end;

function TfrmConfigLucroPresumido.fConverteDataSetToInterfaces(const AcdsGeral,
  AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet): IDadosConfigLucroPresumidoCfg;
begin
  Result := TTipoConfigLucroPresumidoConverte
              .New
              .fConverte(AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco) ;
end;

procedure TfrmConfigLucroPresumido.pConfiguraPlanoContas(
  const ATipo: TTipoLucroPresumido; var AcdsDetalhePlanco, AcdsDetalhe, AcdsDetalhePlancoIrpj, AcdsDetalheIrpj: TUniClientDataSet);
var
  LfrmAdicionaPlanoContas: TfrmAdicionaPlanoContas ;
  LcdsClonado: TUniClientDataset ;
  LstrCodigoConfigIrpj: String ;
  LarrCodigoConfigIrpj: TStringDynArray ;
  LblnClonaIrpj: Boolean ;
  LstrColuna: String ;
begin
  inherited;

  pFiltraDetalhePlanco(AcdsDetalhePlanco, AcdsDetalhe) ;
  try

    pCriarFormularios(TfrmAdicionaPlanoContas, LfrmAdicionaPlanoContas);
    try

      LblnClonaIrpj := False ;
      LstrColuna := TColunaDetalhePlanco.New.fRetornaColuna(AcdsDetalhe.FieldByName('CODIGO').AsString) ;
      if ATipo = tlpCSLL then
      begin
        LstrCodigoConfigIrpj := fCodigoCsllEmIrpjParaClonar(AcdsDetalhe.FieldByName('DESCOD').AsString+';'+AcdsDetalhe.FieldByName('GRUPO_').AsString) ;
        if not fEmptyStr(LstrCodigoConfigIrpj) then
        begin
          LarrCodigoConfigIrpj := SplitString(LstrCodigoConfigIrpj, ';') ;
          if AcdsDetalheIrpj.Locate('DESCOD;GRUPO_', VarArrayOf([LarrCodigoConfigIrpj[0], LarrCodigoConfigIrpj[1]]), [loCaseInsensitive]) then
          begin
            LblnClonaIrpj := True ;
            LfrmAdicionaPlanoContas.CodigoFiltroIrpj := AcdsDetalheIrpj.FieldByName(LstrColuna).AsString ;
          end ;
        end ;
      end ;

      LfrmAdicionaPlanoContas.cdsDetalhePlanco := AcdsDetalhePlanco ;
      LfrmAdicionaPlanoContas.CodigoFiltro := AcdsDetalhe.FieldByName(TColunaDetalhePlanco.New.fRetornaColuna(AcdsDetalhe.FieldByName('CODIGO').AsString)).AsString ;
      LfrmAdicionaPlanoContas.Tipo := ATipo ;
      LfrmAdicionaPlanoContas.cdsDetalhe := AcdsDetalhe;
      LfrmAdicionaPlanoContas.cdsDetalheIrpj := AcdsDetalheIrpj ;
      LfrmAdicionaPlanoContas.cdsDetalhePlancoIrpj := AcdsDetalhePlancoIrpj ;

      LfrmAdicionaPlanoContas.showModal;
      if LfrmAdicionaPlanoContas.BlConfirma then
      begin
        LcdsClonado := LfrmAdicionaPlanoContas.cdsDetalhePlancoClonado ;
        fSalvaDetalhePlanco(AcdsDetalhePlanco, LcdsClonado, AcdsDetalhe) ;
        if LblnClonaIrpj then
          fSalvaDetalhePlanco(AcdsDetalhePlancoIrpj, LcdsClonado, AcdsDetalheIrpj) ;
      end ;
    finally
      pFreeAndNil(LfrmAdicionaPlanoContas);
    end ;

  finally
    AcdsDetalhePlanco.Filtered := False ;
  end ;

end;

procedure TfrmConfigLucroPresumido.pFiltraDetalhePlanco(
  var AcdsDetalhePlanco, AcdsDetalhe: TUniClientDataSet);
begin
  AcdsDetalhePlanco.Filtered := False ;
  AcdsDetalhePlanco.Filter := 'SEQGER = ' + fQuotedStr(AcdsDetalhe.FieldByName(TColunaDetalhePlanco.New.fRetornaColuna(AcdsDetalhe.FieldByName('CODIGO').AsString)).AsString) ;
  AcdsDetalhePlanco.Filtered := True ;
end;

procedure TfrmConfigLucroPresumido.pHabilitarEdicao(
  const AblnHabilitado: Boolean);
begin
  edtExercicio.Enabled := AblnHabilitado ;
  edtEmpSel.Enabled := AblnHabilitado ;
  edtNomEmpSel.Enabled := AblnHabilitado ;
  btnAbrir.Enabled := AblnHabilitado ;

  btnGravar.Enabled := not AblnHabilitado ;
  btnCancela.Enabled := not AblnHabilitado ;
  btnExcluir.Enabled := not AblnHabilitado ;
  BtnCopiar.Enabled := not AblnHabilitado ;

  pgcParametros.Enabled := not AblnHabilitado ;
end;

procedure TfrmConfigLucroPresumido.pIncluiGeral(
  const ADadosConfig: IDadosConfigLucroPresumidoCfg;
  var AcdsGeral: TUniClientDataSet);
begin
  if not Assigned(ADadosConfig) then
    exit ;

  if not Assigned(ADadosConfig.Geral) then
    exit ;

  if not fEmptyStr(ADadosConfig.Geral.Codigo) then
    exit ;

  AcdsGeral.Append ;
  AcdsGeral.FieldByName('CODEMP').AsString := edtEmpSel.Text ;
  AcdsGeral.FieldByName('EXERCI').AsInteger := StrToInt(edtExercicio.Text) ;
  AcdsGeral.Post ;

end;

procedure TfrmConfigLucroPresumido.pLimpaClientDataSet;
begin
  FcdsGeralIrpj.EmptyDataSet ;
  FcdsGeralLanconIrpj.EmptyDataSet ;
  FcdsDetalheIrpj.EmptyDataSet ;
  FcdsDetalhePlancoIrpj.EmptyDataSet ;

  FcdsGeralCsll.EmptyDataSet ;
  FcdsGeralLanconCsll.EmptyDataSet ;
  FcdsDetalheCsll.EmptyDataSet ;
  FcdsDetalhePlancoCsll.EmptyDataSet ;
end;

procedure TfrmConfigLucroPresumido.pLimpaCampos;
begin
  pLimpaClientDataSet ;
  edtExercicio.Clear ;
  edtEmpSel.Clear ;
  edtNomEmpSel.Clear ;

  pgcParametros.ActivePageIndex := 0 ;
  pSetFocus(edtExercicio);

end;

end.
