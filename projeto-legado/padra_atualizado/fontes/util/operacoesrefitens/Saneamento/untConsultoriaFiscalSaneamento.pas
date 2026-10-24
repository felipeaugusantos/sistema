unit untConsultoriaFiscalSaneamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Math,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untDllOpeProd,
  Data.DB, cxDBData,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Vcl.CheckLst, untMensagem, untFuncoesSimples, untFuncoesAuxiliares,
  untConsultas, untTypesSistema, untFuncoesConsulta, Uni,
  System.StrUtils, MaskEditFocus, Datasnap.DBClient,
  iMendes.Types,
  iMendes.Functions, iMendes.Constantes, iMendes.TProcessando, cxContainer,
  iMendes.Comunicador, cxProgressBar, untSalvaDadosInterface, iMendes.TProcessoAutcom,
  cxCurrencyEdit, cxCustomListBox, cxCheckListBox, cxLabel, Vcl.Samples.Spin,

  imendes.frameResultado, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);




  TfrmConsultoriaFiscalSaneamento = class(TfrmPai)
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    pnlFiltros: TPanel;
    btnLog: TBitBtnLocked;
    Timer1: TTimer;
    btnExpandir: TBitBtnLocked;
    btnRecolher: TBitBtnLocked;
    pnlCntFiltros: TPanel;
    Panel4: TPanel;
    grpProdutos: TGroupBox;
    Label8: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodNCM: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte2: TEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Panel1: TPanel;
    grpApresentacao: TGroupBox;
    btnLimparFiltros: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    grpICMS: TGroupBox;
    Label10: TLabel;
    edtDesAbfICM: TEditFocus;
    edtCodAbfIcm: TEditFocus;
    grpPISCOF: TGroupBox;
    Label45: TLabel;
    Label74: TLabel;
    edtDesAbfCof: TEditFocus;
    edtDesAbfPis: TEditFocus;
    edtAbfCof: TEditFocus;
    edtAbfPis: TEditFocus;
    grpIPI: TGroupBox;
    Label5: TLabel;
    edtAbfIpi: TEditFocus;
    edtDesAbfIpi: TEditFocus;
    grpEmpresa: TGroupBox;
    Label6: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    btnCarregarConsulta: TBitBtnLocked;
    Panel2: TPanel;
    pnlRodape: TPanel;
    Shape1: TShape;
    Label12: TLabel;
    Shape2: TShape;
    Label13: TLabel;
    Shape3: TShape;
    Label14: TLabel;
    btnGerarAbreviacao: TBitBtnLocked;
    pnlOpcoesRetorno: TPanel;
    spbExpandCollapse: TSpeedButton;
    Label15: TLabel;
    lblTotal: TLabel;
    grpFiltrosDiv: TGroupBox;
    chkDivICMS: TCheckBox;
    chkInfGerais: TCheckBox;
    chkSemIme: TCheckBox;
    dtsDados: TDataSource;
    pnlGridResultado: TPanel;
    clsFilterPerfil: TcxCheckListBox;
    cxpPagina: TcxSpinEdit;
    btnPerfis: TSpeedButton;
    chkRetparcial: TCheckBox;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    chkCodbarInv: TCheckBox;
    chkSemCst: TCheckBox;
    btnExportacoes: TBitBtnLocked;
    popMaisInfo: TPopupMenu;
    ItensComRetonoParcial1: TMenuItem;
    SemCST1: TMenuItem;
    CdigoBarrasinvalidos1: TMenuItem;
    ItensnoencontradosnaImendes1: TMenuItem;
    Label3: TLabel;
    edtLocItem: TEditFocus;
    N2: TMenuItem;
    ItenscomCdigodeBarrasInvlidosTodososProdutos1: TMenuItem;
    N3: TMenuItem;
    ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1: TMenuItem;
    procedure lblclbEmpEstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbfIcmExit(Sender: TObject);
    procedure edtCodAbfIcmKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodNCMKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfCofExit(Sender: TObject);
    procedure edtAbfPisExit(Sender: TObject);
    procedure edtAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtAbfIpiExit(Sender: TObject);
    procedure edtAbfIpiKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparFiltrosClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure btnRecolherClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodNCMExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure spbExpandCollapseClick(Sender: TObject);
    procedure cxSpinEdit1PropertiesChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure clsFilterPerfilEditValueChanged(Sender: TObject);
    procedure btnGerarAbreviacaoClick(Sender: TObject);
    procedure chkDivICMSClick(Sender: TObject);
    procedure btnCarregarConsultaClick(Sender: TObject);
    procedure clsFilterPerfilClick(Sender: TObject);
    procedure btnPerfisClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnExportacoesClick(Sender: TObject);
    procedure ItensComRetonoParcial1Click(Sender: TObject);
    procedure SemCST1Click(Sender: TObject);
    procedure CdigoBarrasinvalidos1Click(Sender: TObject);
    procedure ItensnoencontradosnaImendes1Click(Sender: TObject);
    procedure edtLocItemKeyPress(Sender: TObject; var Key: Char);
    procedure ItenscomCdigodeBarrasInvlidosTodososProdutos1Click(
      Sender: TObject);
    procedure CodigodeBarrasInvlidosComSaldodeEstoqueClick(Sender: TObject);
    procedure ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1Click(
      Sender: TObject);
  private
    blnCarregandoDados : Boolean;
    FPageIndex: Integer;
    arrProduto,
    arrNCM,
    arrFornec,
    arrLinGru,
    arrCodEmp,
    arrICMS,
    arrCofins,
    arrPis,
    arrIpi: TConsultasArray;

    blnUtiAbi,
    blnUtiAbr: Boolean;
    qryRelatorio: TUniQuery;
    objSalInt: TSalvaInterface;

    qryConAbf,
    qryConIPI,
    qryConFor,
    qryConGru,
    qryCadNcm: TUniQuery;
    ProcessaImendesRetorno: TProcessaImendesRetorno;
    RecParametrosApiSaneamento: TRecParametrosApiSaneamento;
    fraImendesResultado: TfraImendesResultado;
    procedure pLimpaCampos;
    procedure pConfirmarFiltros;
    function fMontaRecordFiltros: TRecFiltrosApiSaneamento;
    function fMontaRecordParametros: TRecParametrosApiSaneamento;
    function fPreencheZeroDireita(Texto: string; Quant: integer): String;
    function fVizualizaProcessoExterno(pgbStatus: TcxProgressBar; var lblCaption: TLabel; var lblTempoEstimado: TLabel): TepResultado;
    procedure pMonitoraProcesso;
    procedure pMonitoraProcessamentoPendente;
    function fSetEnumPerfisMarcados: TConjPerfis;
    function  ConjFiltroDivergencia: TConjFiltroDivergencia;
    procedure pMarcaDesmarcaTodosPerfis(blnMarca: Boolean);
    procedure pIniciaNovaConsulta;
    procedure pGeraRelatorio(FiltroDivergencia: TFiltroDivergencia);
    function fGeraRelatrorioCodBarInvalido(pgbProgresso: TcxProgressBar): Boolean;
    function fGeraRelatrorioSemImeCodBarValido(pgbProgresso: TcxProgressBar): Boolean;

    function fGeraRelatrorioSemCST(pgbProgresso: TcxProgressBar): Boolean;


    procedure pSetSQLRetParcial;
    procedure pSetSQLCodBarInvalido(blnConSaldo: Boolean);
    procedure pSetSemImendesCodigoDeBarrasValido(blnConSaldo: Boolean);
    procedure pSetSQLSemCST;
    function fGeraRelatrorioRetParcial(pgbProgresso: TcxProgressBar): Boolean;


  public
    objDllOpeProd : TparamOpeProd;

  protected
    strAutoincrem: string;

    epResultado : TepResultado;
    qryMonitoramento: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fTemItensSemCST: Boolean;
  end;

var
  frmConsultoriaFiscalSaneamento: TfrmConsultoriaFiscalSaneamento;



implementation

uses
  untModulo, untInputDialog, untTLog, untGravando;


{$R *.dfm}

function TfrmConsultoriaFiscalSaneamento.fVizualizaProcessoExterno(
  pgbStatus: TcxProgressBar; var lblCaption: TLabel; var lblTempoEstimado: TLabel): TepResultado;
  var qryConsultaExt: TUniQuery;
      blnTerminou: Boolean;
begin
  Result := epSemProcesso;
  pgbStatus.Visible := False;
  blnTerminou := False;
  lblCaption.caption := 'Aguardando resposta';
  Application.ProcessMessages;
  Try
    qryConsultaExt := fCriaQuery;
    Try
      while not blnTerminou do
      Begin
        Application.ProcessMessages;
        If TfrmiMendesProcessando.blnMarcadoParaFechar then
        Begin
          Result := epAbotado;
          blnTerminou := True;
          continue;
        End;

        qryConsultaExt.SQL.Clear;
        qryConsultaExt.SQL.Add('SELECT STATUS, ACAO_ATUAL,TEMPO_ESTIMADO, PROCESSADOS, TOTAL_PARA_PROCESSAR, RESULTADO, MAQUINA_ESTADO FROM IMENDES_PARAM WHERE AUTOINCREM = "' + strAutoincrem + '"');
        qryConsultaExt.Open;

        lblCaption.caption :=  qryConsultaExt.FieldByName('ACAO_ATUAL').AsString;
        lblTempoEstimado.Caption := qryConsultaExt.FieldByName('TEMPO_ESTIMADO').AsString;


        If qryConsultaExt.FieldByName('TOTAL_PARA_PROCESSAR').AsInteger > 0 then
        Begin
          If IntegerToEstadoProcessamento(qryConsultaExt.FieldByName('MAQUINA_ESTADO').AsInteger) = epProcessando then
          Begin
            pgbStatus.Visible := True;
            pgbStatus.Properties.Max := qryConsultaExt.FieldByName('TOTAL_PARA_PROCESSAR').AsInteger;
            pgbStatus.Position       := qryConsultaExt.FieldByName('PROCESSADOS').AsInteger;
          End
          Else
            pgbStatus.Visible := False;
        End;

        If qryConsultaExt.FieldByName('STATUS').AsString =  cImendesConcluido Then
        Begin
          Case IntegerToEstadoProcessamento(qryConsultaExt.FieldByName('MAQUINA_ESTADO').AsInteger) of
            epFinalizadoSemItem: Begin
                                   Result := epConcluidoSemItensParaProcessar;
                                   pMensagemOk(qryConsultaExt.FieldByName('RESULTADO').AsString + #$A#$D + qryConsultaExt.FieldByName('ACAO_ATUAL').AsString);
                           End;
            epFalhaAutenticacao,
            epFinalizadoComErro: Begin
                                   Result := epConcluidComErro;
                                   pMensagemOk(qryConsultaExt.FieldByName('RESULTADO').AsString + #$A#$D + qryConsultaExt.FieldByName('ACAO_ATUAL').AsString);
                                 End;
            epFinalizadoPeloAutcom  : Result := epConcluido;
          End;
          blnTerminou := True;
          lblCaption.caption :=  qryConsultaExt.FieldByName('RESULTADO').AsString + #$A#$D + qryConsultaExt.FieldByName('ACAO_ATUAL').AsString;
        End;
        Application.ProcessMessages;
        Sleep(1000);
      End;

    Finally
      FreeAndNil(qryConsultaExt);
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TfrmConsultoriaFiscalSaneamento.fVizualizaProcessoExterno]');
      Result := epConcluidComErro;
    End;
  End;

  {}
end;

procedure TfrmConsultoriaFiscalSaneamento.ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1Click(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdSemImeCodbarValido);
end;

procedure TfrmConsultoriaFiscalSaneamento.ItenscomCdigodeBarrasInvlidosTodososProdutos1Click(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdCodbarrInvalido);

end;

procedure TfrmConsultoriaFiscalSaneamento.ItensComRetonoParcial1Click(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdRetornoParcialImendes);
end;

procedure TfrmConsultoriaFiscalSaneamento.ItensnoencontradosnaImendes1Click(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdSemImeCodbarValidoComSaldo);
end;

procedure TfrmConsultoriaFiscalSaneamento.btnExportacoesClick(Sender: TObject);
begin
  inherited;
 popMaisInfo.Popup(Self.Left + btnExportacoes.Left, Self.Top + pnlBotoes.Top);
end;

procedure TfrmConsultoriaFiscalSaneamento.btnCarregarConsultaClick(
  Sender: TObject);
begin
  inherited;
  pMonitoraProcessamentoPendente;

end;

procedure TfrmConsultoriaFiscalSaneamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fTemItensSemCST then
    Exit;
  If fVerificaCampos Then
    pConfirmarFiltros;
end;

procedure TfrmConsultoriaFiscalSaneamento.pConfirmarFiltros;
var
    qryGravaAgendamento: TUniQuery;
    strConexao: string;
    strDescricao: String;
    qryEmpresas: TUniQuery;
    strAutoincremLocal: String;
    strCodEmpLocal: String;
begin
  strAutoincremLocal := '';
  strAutoincrem := '';
  strDescricao := fInputDialog('Identificação da Consulta',
                               'Insira um texto para indentificar a consulta');
  if fEmptyStr(strDescricao) Then
  Begin
    pMensagemOk('Atenção, é preciso informar a Identificação da Consulta!');
    Exit;
  End;
  qryEmpresas := fCriaQuery;
  Try
    RecParametrosApiSaneamento := fMontaRecordParametros;
    qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP');
    qryEmpresas.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
    qryEmpresas.SQL.Add(iMendes.Functions.fStrLocate(RecParametrosApiSaneamento.Filtros.FilterCodEmpresa, RecParametrosApiSaneamento.Filtros.FilterArrEmpresa, 'EMP_CODEMP', 'CODEMP'));
    qryEmpresas.SQL.Add('  AND SIS_VALCFG = "1"');
    qryEmpresas.SQL.Add('  GROUP BY SIS_VALCFG');
    qryEmpresas.SQL.Add('UNION ALL');
    qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP');
    qryEmpresas.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
    qryEmpresas.SQL.Add(' WHERE TRUE');
    qryEmpresas.SQL.Add(iMendes.Functions.fStrLocate(RecParametrosApiSaneamento.Filtros.FilterCodEmpresa, RecParametrosApiSaneamento.Filtros.FilterArrEmpresa, 'EMP_CODEMP', 'CODEMP'));
    qryEmpresas.SQL.Add('  AND SIS_VALCFG = "2"');
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterCodEmpresa, RecParametrosApiSaneamento.Filtros.FilterArrEmpresa, strCodEmpLocal, 'CODEMP' , qryEmpresas);
    qryEmpresas.Open;

    qryGravaAgendamento := fCriaQuery;
    qryGravaAgendamento.SQL.Add('INSERT INTO IMENDES_PARAM(');
    qryGravaAgendamento.SQL.Add('IME_VISPRO,');
    qryGravaAgendamento.SQL.Add('PARAMETROS,');
    qryGravaAgendamento.SQL.Add('DATA,');
    qryGravaAgendamento.SQL.Add('STATUS,');
    qryGravaAgendamento.SQL.Add('PROCESSADOS,');
    qryGravaAgendamento.SQL.Add('TOTAL_PARA_PROCESSAR,');
    qryGravaAgendamento.SQL.Add('ACAO_ATUAL,');
    qryGravaAgendamento.SQL.Add('AUTOINCREM,');
    qryGravaAgendamento.SQL.Add('PAR_CODOPE,');
    qryGravaAgendamento.SQL.Add('CONEXAO,');
    qryGravaAgendamento.SQL.Add('DESCRICAO,');
    qryGravaAgendamento.SQL.Add('EMPRESA)');
    qryGravaAgendamento.SQL.Add('VALUES(');
    qryGravaAgendamento.SQL.Add('"1",');
    qryGravaAgendamento.SQL.Add(':PARAMETROS,');
    qryGravaAgendamento.SQL.Add(':DATA,');
    qryGravaAgendamento.SQL.Add(':STATUS,');
    qryGravaAgendamento.SQL.Add(':PROCESSADOS,');
    qryGravaAgendamento.SQL.Add(':TOTAL_PARA_PROCESSAR,');
    qryGravaAgendamento.SQL.Add(':ACAO_ATUAL,');
    qryGravaAgendamento.SQL.Add(':AUTOINCREM,');
    qryGravaAgendamento.SQL.Add(':PAR_CODOPE,');
    qryGravaAgendamento.SQL.Add(':CONEXAO,');
    qryGravaAgendamento.SQL.Add(':DESCRICAO,');
    qryGravaAgendamento.SQL.Add(':EMPRESA);');


    strConexao := 'ProviderName:=' + qryGravaAgendamento.Connection.ProviderName + #$A#$D +
                  'Username:=' + qryGravaAgendamento.Connection.Username + #$A#$D +
                  'Password:=' + fCriptografar(qryGravaAgendamento.Connection.Password) + #$A#$D +
                  'Server:=' + qryGravaAgendamento.Connection.Server + #$A#$D +
                  'Database:=' + qryGravaAgendamento.Connection.Database + #$A#$D +
                  'Port:=' + qryGravaAgendamento.Connection.Port.ToString();

    while not qryEmpresas.Eof Do
    Begin
      strCodEmpLocal := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      SetLength(RecParametrosApiSaneamento.Filtros.FilterArrEmpresa, 1);
      RecParametrosApiSaneamento.Filtros.FilterArrEmpresa[0].strCodigo := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
      RecParametrosApiSaneamento.Filtros.FilterArrEmpresa[0].strDescri := '';
      RecParametrosApiSaneamento.Filtros.FilterCodEmpresa := qryEmpresas.FieldByName('EMP_CODEMP').AsString;


      qryGravaAgendamento.ParamByName('PARAMETROS').ASString := RecParametrosApiSaneamento.fConvertToString;
      strAutoincremLocal := fRetAutoIncrem('IMENDES_PARAM', VS_strCodEmp);
      If strAutoincrem = '' Then
        strAutoincrem := strAutoincremLocal;

      qryGravaAgendamento.ParamByName('PARAMETROS').AsString := RecParametrosApiSaneamento.fConvertToString;
      qryGravaAgendamento.ParamByName('DESCRICAO').AsString := strDescricao;
      qryGravaAgendamento.ParamByName('CONEXAO').AsString := strConexao;
      qryGravaAgendamento.ParamByName('DATA').AsDateTime := fNow;
      qryGravaAgendamento.ParamByName('STATUS').AsString := 'P';
      qryGravaAgendamento.ParamByName('PROCESSADOS').AsInteger := 0;
      qryGravaAgendamento.ParamByName('TOTAL_PARA_PROCESSAR').AsInteger := 0;
      qryGravaAgendamento.ParamByName('ACAO_ATUAL').AsString := 'Aguardando processamento';
      qryGravaAgendamento.ParamByName('AUTOINCREM').AsString := strAutoincremLocal;
      qryGravaAgendamento.ParamByName('PAR_CODOPE').AsString := strLoginUsuarioLogado;
      qryGravaAgendamento.ParamByName('EMPRESA').AsString := qryEmpresas.FieldByName('EMP_CODEMP').AsString;


      qryGravaAgendamento.ExecSQL;
      objSalInt.fSalvaDados(strAutoincremLocal, Self.Name, '', True);
      qryEmpresas.Next;
    End;
  finally
    pMonitoraProcesso;
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.pGeraRelatorio(FiltroDivergencia: TFiltroDivergencia);
var
  qryConsulta : TUniQuery;
  frmGravando: TfrmGravando;
begin
  qryConsulta := fCriaQuery;
  qryRelatorio := qryConsulta;
  Try
    case FiltroDivergencia of
      fdRetornoParcialImendes : pSetSQLRetParcial;
      fdCodbarrInvalido : pSetSQLCodBarInvalido(False);
      fdCodbarrInvalidoComSaldo : pSetSQLCodBarInvalido(true);
      fdSemCst : pSetSQLSemCST;
      fdSemImeCodbarValido : pSetSemImendesCodigoDeBarrasValido(False);
      fdSemImeCodbarValidoComSaldo : pSetSemImendesCodigoDeBarrasValido(true);
    End;

    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
    Begin
      pMensagemOk('Sem dados para exibir.');
      Exit;
    End;


    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Gerando Dados';
      case FiltroDivergencia of
        fdRetornoParcialImendes : frmGravando.fExecutarAcao := fGeraRelatrorioRetParcial;
        fdCodbarrInvalidoComSaldo,
        fdCodbarrInvalido : frmGravando.fExecutarAcao := fGeraRelatrorioCodBarInvalido;
        fdSemCst : frmGravando.fExecutarAcao := fGeraRelatrorioSemCST;
        fdSemImeCodbarValidoComSaldo,
        fdSemImeCodbarValido : frmGravando.fExecutarAcao := fGeraRelatrorioSemImeCodBarValido;
      End;

      frmGravando.ShowModal;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
  {}
end;



function TfrmConsultoriaFiscalSaneamento.fGeraRelatrorioSemCST(pgbProgresso: TcxProgressBar): Boolean;
var
  strLinha: String;
  lstRetorno: TStringList;
Begin
  pgbProgresso.Properties.Max := qryRelatorio.RecordCount;
  lstRetorno := TStringList.Create;
  Try

    strLinha := StringOfChar(' ', 200);
    Insert('Produto', strLinha, 1);
    Insert('Cód. Barras', strLinha, 70);
    lstRetorno.Add(TrimRight(strLinha));

    While not qryRelatorio.Eof do
    Begin
      strLinha := StringOfChar(' ', 200);
      Insert(Copy(qryRelatorio.FieldByName('ITE_CODITE').AsString + ' - ' + qryRelatorio.FieldByName('ITE_DESITE').AsString, 1, 68), strLinha, 1);
      Insert(qryRelatorio.FieldByName('ITE_CODBAR').AsString, strLinha, 70);
      lstRetorno.Add(TrimRight(strLinha));
      pgbProgresso.Position := qryRelatorio.RecNo;
      Application.ProcessMessages;
      qryRelatorio.Next;
    End;

    TfrmLog.pShowLog('Itens Sem CST Origem', lstRetorno);
    Result := True;

  Finally
    FreeAndNil(lstRetorno)
  End;

End;


function TfrmConsultoriaFiscalSaneamento.fGeraRelatrorioSemImeCodBarValido(pgbProgresso: TcxProgressBar): Boolean;
var
  strLinha: String;
  lstRetorno: TStringList;
Begin
  pgbProgresso.Properties.Max := qryRelatorio.RecordCount;
  lstRetorno := TStringList.Create;
  Try

    strLinha := StringOfChar(' ', 200);
    Insert('Produto', strLinha, 1);
    Insert('Cód. Barras', strLinha, 70);
    Insert('Saldo', strLinha, 86);
    lstRetorno.Add(TrimRight(strLinha));

    While not qryRelatorio.Eof do
    Begin
      strLinha := StringOfChar(' ', 100);
      Insert(Copy(qryRelatorio.FieldByName('ITE_CODITE').AsString + ' - ' + qryRelatorio.FieldByName('ITE_DESITE').AsString, 1, 68), strLinha, 1);
      Insert(qryRelatorio.FieldByName('ITE_CODBAR').AsString, strLinha, 70);
      Insert(fPadL(FormatFloat('#0.00', qryRelatorio.FieldByName('SALDO').AsFloat), 18, ' '), strLinha, 86) ;
      lstRetorno.Add(TrimRight(strLinha));
      pgbProgresso.Position := qryRelatorio.RecNo;
      Application.ProcessMessages;
      qryRelatorio.Next;
    End;

    TfrmLog.pShowLog('Itens com Cód. Barras Válido Não Encontrados na Imendes', lstRetorno);
    Result := True;

  Finally
    FreeAndNil(lstRetorno)
  End;
End;

function TfrmConsultoriaFiscalSaneamento.fGeraRelatrorioCodBarInvalido(pgbProgresso: TcxProgressBar): Boolean;
var
  strLinha: String;
  lstRetorno: TStringList;
Begin
  pgbProgresso.Properties.Max := qryRelatorio.RecordCount;
  lstRetorno := TStringList.Create;
  Try

    strLinha := StringOfChar(' ', 200);
    Insert('Produto', strLinha, 1);
    Insert('Cód. Barras', strLinha, 70);
    Insert('Saldo', strLinha, 86);
    lstRetorno.Add(TrimRight(strLinha));

    While not qryRelatorio.Eof do
    Begin
      strLinha := StringOfChar(' ', 100);
      Insert(Copy(qryRelatorio.FieldByName('ITE_CODITE').AsString + ' - ' + qryRelatorio.FieldByName('ITE_DESITE').AsString, 1, 68), strLinha, 1);
      Insert(qryRelatorio.FieldByName('ITE_CODBAR').AsString, strLinha, 70);
      Insert(fPadL(FormatFloat('#0.00', qryRelatorio.FieldByName('SALDO').AsFloat), 18, ' '), strLinha, 86) ;
      lstRetorno.Add(TrimRight(strLinha));
      pgbProgresso.Position := qryRelatorio.RecNo;
      Application.ProcessMessages;
      qryRelatorio.Next;
    End;

    TfrmLog.pShowLog('Itens com Código de Barras Inválido', lstRetorno);
    Result := True;

  Finally
    FreeAndNil(lstRetorno)
  End;
End;

function TfrmConsultoriaFiscalSaneamento.fGeraRelatrorioRetParcial(pgbProgresso: TcxProgressBar): Boolean;
var lstRetorno: TStringList;
    lstMensagem: TStringList;
    strCodIte: String;
    strEstado: String;
    strLinha : String;
    i: integer;
begin
  pgbProgresso.Properties.Max := qryRelatorio.RecordCount;
  lstRetorno := TStringList.Create;
  lstMensagem := TStringList.Create;


  Try
    strCodIte := '';
    strLinha  := '';
    While not qryRelatorio.Eof do
    Begin
      lstMensagem.Text :=  qryRelatorio.FieldByName('ERROS').AsString;
      For i := 0 To lstMensagem.Count -1 do
      Begin

        strLinha := StringOfChar(' ', 200);
        If strCodIte <> qryRelatorio.FieldByName('IME_CODITE').AsString Then
        Begin
          strEstado := '';
          strCodIte := qryRelatorio.FieldByName('IME_CODITE').AsString;
          Insert(Copy(qryRelatorio.FieldByName('PRODUTO').AsString, 1, 99), strLinha, 1);
          lstRetorno.Add(TrimRight(strLinha));
        End;
        If strEstado <> qryRelatorio.FieldByName('ESTADO').AsString Then
        begin
          strLinha := StringOfChar(' ', 100);
          strEstado := qryRelatorio.FieldByName('ESTADO').AsString;
          Insert('Estado: ' + qryRelatorio.FieldByName('ESTADO').AsString,strLinha,  5);
          lstRetorno.Add(TrimRight(strLinha));
        End;
        strLinha := StringOfChar(' ', 165);
        Insert(lstMensagem[i], strLinha, 10);
        lstRetorno.Add(TrimRight(strLinha));
      End;
      strLinha := StringOfChar('-', 165);
      lstRetorno.Add(TrimRight(strLinha));

      pgbProgresso.Position := qryRelatorio.RecNo;
      Application.ProcessMessages;
      qryRelatorio.Next;
    End;

    TfrmLog.pShowLog('Itens com retorno parcial', lstRetorno);
    Result := True;

  Finally
    FreeAndNil(lstRetorno);
    FreeAndNil(lstMensagem);
  End;
End;

procedure  TfrmConsultoriaFiscalSaneamento.pSetSQLRetParcial;
begin
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add(  'SELECT');
  qryRelatorio.SQL.Add(  ' IME_CODITE,');
  qryRelatorio.SQL.Add(  ' CAST(CONCAT("Produto: ", IME_CODITE, "-", CADITE.ITE_DESITE," Ean: ", CADITE.ITE_CODBAR) AS CHAR(255)) AS PRODUTO,');
  qryRelatorio.SQL.Add(  ' ABF_ESTADO AS ESTADO,');
  qryRelatorio.SQL.Add(  ' CAST(CONCAT(IF(ABF_CODSIT_ENT_PEF IS NULL , CONCAT("Bloco PEF Incompleto: ", MPEF.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_ENT_PEJ IS NULL , CONCAT("Bloco PEJ Incompleto: ", MPEJ.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_ENT_PER IS NULL , CONCAT("Bloco PER Incompleto: ", MPER.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_ENT_PES IS NULL , CONCAT("Bloco PES Incompleto: ", MPES.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_ENT_PSI IS NULL , CONCAT("Bloco PSI Incompleto: ", MPSI.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_ENT_PII IS NULL , CONCAT("Bloco PII Incompleto: ", MPII.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_NCO IS NULL , CONCAT("Bloco NCO Incompleto: ", MNCO.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_CCO IS NULL , CONCAT("Bloco CCO Incompleto: ", MCCO.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_CNC IS NULL , CONCAT("Bloco CNC Incompleto: ", MCNC.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_SNA IS NULL , CONCAT("Bloco SNA Incompleto: ", MSNA.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_CTA IS NULL , CONCAT("Bloco CTA Incompleto: ", MCTA.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_PRU IS NULL , CONCAT("Bloco PRU Incompleto: ", MPRU.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_IND IS NULL , CONCAT("Bloco IND Incompleto: ", MIND.CARACT, CHAR(10)), ""),');
  qryRelatorio.SQL.Add(  '       IF(ABF_CODSIT_SAI_TRS IS NULL , CONCAT("Bloco TRS Incompleto: ", MTRS.CARACT, CHAR(10)), "")) AS CHAR(1000)) AS "ERROS"');
  qryRelatorio.SQL.Add(  '  FROM IMENDES_RESULTADO R');
  qryRelatorio.SQL.Add(  '  INNER JOIN CADITE ON ITE_CODITE = R.IME_CODITE');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  ' " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  ' INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPEF  ON MPEF.PRF_PERFIL = "PEF"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPEJ  ON MPEJ.PRF_PERFIL = "PEJ"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPER  ON MPER.PRF_PERFIL = "PER"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPES  ON MPES.PRF_PERFIL = "PES"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPSI  ON MPSI.PRF_PERFIL = "PSI"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPII  ON MPII.PRF_PERFIL = "PII"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MNCO  ON MNCO.PRF_PERFIL = "NCO"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MCCO  ON MCCO.PRF_PERFIL = "CCO"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MCNC  ON MCNC.PRF_PERFIL = "CNC"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MSNA  ON MSNA.PRF_PERFIL = "SNA"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MCTA  ON MCTA.PRF_PERFIL = "CTA"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MPRU  ON MPRU.PRF_PERFIL = "PRU"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MIND  ON MIND.PRF_PERFIL = "IND"');
  qryRelatorio.SQL.Add(  ' INNER JOIN (SELECT PRF_PERFIL, CONCAT("Perfil:", PRF_PERFIL, " Caract. Trib.(", IMENDES_CARACTRIB.ID,"): ", RPAD(IMENDES_CARACTRIB.DESCRICAO, 23, " "), ');
  qryRelatorio.SQL.Add(  '  " Finalidade(", IMENDES_FINALIDADE.ID,"):", RPAD(IMENDES_FINALIDADE.DESCRICAO, 26, " ")) AS CARACT FROM PRFSAN');
  qryRelatorio.SQL.Add(  '   INNER JOIN IMENDES_CARACTRIB ON PRF_CODIGO = IMENDES_CARACTRIB.ID INNER JOIN IMENDES_FINALIDADE ON PRF_FINALI = IMENDES_FINALIDADE.ID ) MTRS  ON MTRS.PRF_PERFIL = "TRS"');
  qryRelatorio.SQL.Add(  '');
  qryRelatorio.SQL.Add(  ' WHERE R.IME_RETPAR = 1');
  qryRelatorio.SQL.Add(  ' AND R.LOCAL = "iMendes"');
  qryRelatorio.SQL.Add(  ' AND(ABF_CODSIT_ENT_PEF IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_ENT_PEJ IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_ENT_PER IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_ENT_PES IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_ENT_PSI IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_ENT_PII IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_NCO IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_CCO IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_CNC IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_SNA IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_CTA IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_PRU IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_IND IS NULL OR');
  qryRelatorio.SQL.Add(  '    ABF_CODSIT_SAI_TRS IS NULL)');
  qryRelatorio.SQL.Add(  ' AND IME_SEQCON = "' + ProcessaImendesRetorno.strAutIncSelec+ '"');
  qryRelatorio.SQL.Add(  ' ORDER BY CADITE.ITE_DESITE, ESTADO');
End;

procedure TfrmConsultoriaFiscalSaneamento.pSetSQLCodBarInvalido(blnConSaldo: Boolean);
begin
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add('SELECT IME_CODITE AS ITE_CODITE, ITE_DESITE, IME_CODBAR AS ITE_CODBAR, SUM(G.ITE_SALDOS) AS SALDO');
  qryRelatorio.SQL.Add('FROM IMENDES_ITENS');
  qryRelatorio.SQL.Add('INNER JOIN CADITE C ON ITE_CODITE = IME_CODITE');
  qryRelatorio.SQL.Add('INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE');
  qryRelatorio.SQL.Add('WHERE IME_SEQCON = "' + ProcessaImendesRetorno.strAutIncSelec+ '"');
  qryRelatorio.SQL.Add('AND IME_SEMEAN = 1');
  qryRelatorio.SQL.Add('GROUP BY IME_CODITE');
  If blnConSaldo then
    qryRelatorio.SQL.Add('HAVING SALDO <> 0');
  qryRelatorio.SQL.Add('ORDER BY ITE_DESITE');
End;


procedure TfrmConsultoriaFiscalSaneamento.pSetSemImendesCodigoDeBarrasValido(blnConSaldo: Boolean);
begin
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add('SELECT IME_CODITE AS ITE_CODITE, ITE_DESITE, IME_CODBAR AS ITE_CODBAR, SUM(G.ITE_SALDOS) AS SALDO');
  qryRelatorio.SQL.Add('FROM IMENDES_ITENS');
  qryRelatorio.SQL.Add('INNER JOIN CADITE C ON ITE_CODITE = IME_CODITE');
  qryRelatorio.SQL.Add('INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE');
  qryRelatorio.SQL.Add('WHERE IME_SEQCON = "' + ProcessaImendesRetorno.strAutIncSelec+ '"');
  qryRelatorio.SQL.Add('AND IME_SEMIME = 1');
  qryRelatorio.SQL.Add('AND IME_SEMEAN = 0');
  qryRelatorio.SQL.Add('GROUP BY IME_CODITE');
  If blnConSaldo then
    qryRelatorio.SQL.Add('HAVING SALDO <> 0');
  qryRelatorio.SQL.Add('ORDER BY ITE_DESITE');
End;

procedure TfrmConsultoriaFiscalSaneamento.pSetSQLSemCST;
begin
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add('SELECT IME_CODITE AS ITE_CODITE, ITE_DESITE, IME_CODBAR AS ITE_CODBAR');
  qryRelatorio.SQL.Add('FROM IMENDES_ITENS');
  qryRelatorio.SQL.Add('INNER JOIN CADITE ON ITE_CODITE = IME_CODITE');
  qryRelatorio.SQL.Add('WHERE IME_SEQCON = "' + ProcessaImendesRetorno.strAutIncSelec+ '"');
  qryRelatorio.SQL.Add('AND IME_SEMEAN = 3');
  qryRelatorio.SQL.Add('ORDER BY ITE_DESITE');
End;

function TfrmConsultoriaFiscalSaneamento.fSetEnumPerfisMarcados: TConjPerfis;
Begin
  Result := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];
End;

function TfrmConsultoriaFiscalSaneamento.fTemItensSemCST: Boolean;
var qryConsulta : TUniQuery;
    blnTipAbfGeral: Boolean;
    blnTipAbpcGeral: Boolean;
      strAbfPis,
      strAbfIpi,
      strCodFor,
      strCodGru,
      strCodIte,
      strCodNCM,
      strCodAbf,
      strCodEmp,
      strAbfCof: String;
      strConteudo : TStringList;
begin
  qryConsulta := fCriaQuery;
  RecParametrosApiSaneamento := fMontaRecordParametros;
  blnTipAbfGeral  := iMendesfCfgSis('TIPABF', varString, RecParametrosApiSaneamento.Filtros.FilterCodEmpresa) = '1';
  blnTipAbpcGeral := iMendesfCfgSis('TPABPC', varString, RecParametrosApiSaneamento.Filtros.FilterCodEmpresa) = '1';

  Try
    qryConsulta.SQL.Add('SELECT C.ITE_CODITE, C.ITE_DESITE FROM CADITE C ');
    qryConsulta.SQL.Add(' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND I.ITE_CODEMP = "' +VS_StrCodEmp+ '"');
    qryConsulta.SQL.Add(' WHERE IFNULL(ITE_CSTORI, "") = ""') ;

    qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterCodEmpresa , RecParametrosApiSaneamento.Filtros.FilterArrEmpresa  , 'I.ITE_CODEMP', 'CODEMP'));
    qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterCodFornecedor , RecParametrosApiSaneamento.Filtros.FilterArrFornecedor  , 'C.ITE_CODFOR', 'CODFOR'));
    qryConsulta.SQL.Add(fStrLocateLinGru(RecParametrosApiSaneamento.Filtros.FilterCodLinhaGrupo, RecParametrosApiSaneamento.Filtros.FilterArrLinhaGrupo, 'C.ITE_CODGRU', 'CODGRU'));
    qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterCodItem , RecParametrosApiSaneamento.Filtros.FilterArrItem  , 'C.ITE_CODITE', 'CODITE'));

    If blnTipAbfGeral Then
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvICMS , RecParametrosApiSaneamento.Filtros.FilterArrAbvICMS , 'C.ITE_CODABF', 'CODABF'))
    Else
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvICMS , RecParametrosApiSaneamento.Filtros.FilterArrAbvICMS , 'I.ITE_CODABF', 'CODABF'));

    If blnTipAbfGeral Then
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvPIS , RecParametrosApiSaneamento.Filtros.FilterArrAbvPIS, 'C.ITE_ABFPIS', 'ABFPIS'))
    Else
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvPIS , RecParametrosApiSaneamento.Filtros.FilterArrAbvPIS, 'I.ITE_ABFPIS', 'ABFPIS'));

    If blnTipAbpcGeral Then
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvCOFINS , RecParametrosApiSaneamento.Filtros.FilterArrAbvCOFINS, 'C.ITE_ABFCOF', 'ABFCOF'))
    Else
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvCOFINS , RecParametrosApiSaneamento.Filtros.FilterArrAbvCOFINS, 'I.ITE_ABFCOF', 'ABFCOF'));

    If blnTipAbpcGeral Then
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvIPI , RecParametrosApiSaneamento.Filtros.FilterArrAbvIPI, 'C.ITE_ABFIPI', 'ABFIPI'))
    Else
      qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterAbvIPI , RecParametrosApiSaneamento.Filtros.FilterArrAbvIPI, 'I.ITE_ABFIPI', 'ABFIPI'));

    qryConsulta.SQL.Add(fStrLocate(RecParametrosApiSaneamento.Filtros.FilterNCM , RecParametrosApiSaneamento.Filtros.FilterArrNCM, 'C.ITE_CLAIPI', 'CLAIPI'));

    qryConsulta.SQL.Add(' AND C.ITE_ITEATI = "S" ');

    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterCodItem        , RecParametrosApiSaneamento.Filtros.FilterArrItem       , strCodIte, 'CODITE' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterCodFornecedor  , RecParametrosApiSaneamento.Filtros.FilterArrFornecedor , strCodFor, 'CODFOR' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterCodLinhaGrupo  , RecParametrosApiSaneamento.Filtros.FilterArrLinhaGrupo , strCodGru, 'CODGRU' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterAbvPis         , RecParametrosApiSaneamento.Filtros.FilterArrAbvPis     , strAbfPis, 'ABFPIS' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterAbvCofins      , RecParametrosApiSaneamento.Filtros.FilterArrAbvCofins  , strAbfCof, 'ABFCOF' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterAbvIpi         , RecParametrosApiSaneamento.Filtros.FilterArrAbvIpi     , strAbfIpi, 'ABFIPI' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterCodEmpresa     , RecParametrosApiSaneamento.Filtros.FilterArrEmpresa    , strCodEmp, 'CODEMP' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterNCM            , RecParametrosApiSaneamento.Filtros.FilterArrNCM        , strCodNcm, 'CLAIPI' , qryConsulta);
    pSetaParam(RecParametrosApiSaneamento.Filtros.FilterAbvICMS        , RecParametrosApiSaneamento.Filtros.FilterArrAbvICMS    , strCodAbf, 'CODABF' , qryConsulta);

    qryConsulta.Open;

    If qryConsulta.IsEmpty then
      Exit(False);

    Result := True;
    strConteudo := TStringlist.Create;
    Try
      strConteudo.Add('Itens sem CST Origem Informado:');
      while not qryConsulta.Eof Do
      Begin
        strConteudo.Add(qryConsulta.FieldByName('ITE_CODITE').AsString + ' - ' +  qryConsulta.FieldByName('ITE_DESITE').AsString);
        qryConsulta.Next;
      End;
      TfrmLog.pShowLog('Itens sem CST Origem Informado', strConteudo);
    Finally
      FreeAndNil(strConteudo);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TfrmConsultoriaFiscalSaneamento.fMontaRecordFiltros: TRecFiltrosApiSaneamento;
var i: integer;
begin
  Result.FilterDescricaoDoItem := edtDesIte.Text;

  SetLength(Result.FilterArrItem, Length(arrProduto));
  For i := 0 To High(arrProduto) do
  begin
    Result.FilterArrItem[i].strCodigo := arrProduto[i].strCodigo;
    Result.FilterArrItem[i].strDescri := arrProduto[i].strDescri;
  End;
  Result.FilterCodItem := edtCodIte.Text;
  Result.FilterCodFornecedor := edtCodFor.Text;
  SetLength(Result.FilterArrFornecedor, Length(arrFornec));
  For i := 0 To High(arrFornec) do
  begin
    Result.FilterArrFornecedor[i].strCodigo := arrFornec[i].strCodigo;
    Result.FilterArrFornecedor[i].strDescri := arrFornec[i].strDescri;
  End;

  SetLength(Result.FilterArrLinhaGrupo, Length(arrLinGru));
  For i := 0 To High(arrLinGru) do
  begin
    Result.FilterArrLinhaGrupo[i].strCodigo := arrLinGru[i].strCodigo;
    Result.FilterArrLinhaGrupo[i].strDescri := arrLinGru[i].strDescri;
  End;


  Result.FilterCodLinhaGrupo := mskLinGru.Text;
  Result.FilterNCM := edtCodNCM.Text;
  SetLength(Result.FilterArrNCM, Length(arrNCM));
  For i := 0 To High(arrNCM) do
  begin
    Result.FilterArrNCM[i].strCodigo := arrNCM[i].strCodigo;
    Result.FilterArrNCM[i].strDescri := arrNCM[i].strDescri;
  End;

  Result.FilterAbvPis := edtAbfPis.Text;
  SetLength(Result.FilterArrAbvPis, Length(arrPis));
  For i := 0 To High(arrPis) do
  begin
    Result.FilterArrAbvPis[i].strCodigo := arrPis[i].strCodigo;
    Result.FilterArrAbvPis[i].strDescri := arrPis[i].strDescri;
  End;

  Result.FilterAbvCofins := edtAbfCof.Text;
  SetLength(Result.FilterArrAbvCofins, Length(arrCofins));
  For i := 0 To High(arrCofins) do
  begin
    Result.FilterArrAbvCofins[i].strCodigo := arrCofins[i].strCodigo;
    Result.FilterArrAbvCofins[i].strDescri := arrCofins[i].strDescri;
  End;
  Result.FilterAbvIpi := edtAbfIpi.Text;
  SetLength(Result.FilterArrAbvIpi, Length(arrIpi));
  For i := 0 To High(arrIpi) do
  begin
    Result.FilterArrAbvIpi[i].strCodigo := arrIpi[i].strCodigo;
    Result.FilterArrAbvIpi[i].strDescri := arrIpi[i].strDescri;
  End;

  Result.FilterCodEmpresa := edtCodEmp.Text;
  SetLength(Result.FilterArrEmpresa, Length(arrCodEmp));
  For i := 0 To High(arrCodEmp) do
  begin
    Result.FilterArrEmpresa[i].strCodigo := arrCodEmp[i].strCodigo;
    Result.FilterArrEmpresa[i].strDescri := arrCodEmp[i].strDescri;
  End;
  Result.FilterAbvICMS := edtCodAbfIcm.Text;
  SetLength(Result.FilterArrAbvICMS, Length(arrICMS));
  For i := 0 To High(arrICMS) do
  begin
    Result.FilterArrAbvICMS[i].strCodigo := arrICMS[i].strCodigo;
    Result.FilterArrAbvICMS[i].strDescri := arrICMS[i].strDescri;
  End;

  Result.FilterPerfis := fSetEnumPerfisMarcados;
end;

function TfrmConsultoriaFiscalSaneamento.fMontaRecordParametros: TRecParametrosApiSaneamento;
begin
  Result.Filtros := fMontaRecordFiltros;
end;

procedure TfrmConsultoriaFiscalSaneamento.btnExpandirClick(Sender: TObject);
begin
  inherited;
  fraImendesResultado.ExpandAll;
end;

procedure TfrmConsultoriaFiscalSaneamento.btnGerarAbreviacaoClick(
  Sender: TObject);
begin
  inherited;
  If ProcessaImendesRetorno.fGerarAbreviacoes Then
  begin
    pLimpaCampos;
    btnGerarAbreviacao.Enabled := False;
    chkDivICMS.Enabled := False;
    chkInfGerais.Enabled := False;
    chkSemIme.Enabled := False;
    btnExpandir.Enabled := False;
    btnRecolher.Enabled := False;
    btnExportacoes.Enabled := False;
    pnlCntFiltros.Enabled := True;
    pnlOpcoesRetorno.Visible := False;
    Try
      pnlFiltros.Visible := True;
      spbExpandCollapse.Caption := 'Recolher Filtros';
    Finally
      pSetFocus(edtCodIte);
    End;
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.btnLimparFiltrosClick(
  Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmConsultoriaFiscalSaneamento.btnPerfisClick(Sender: TObject);
begin
  inherited;
  If pnlOpcoesRetorno.Height = 176 Then
  Begin
    clsFilterPerfil.Visible := False;
    pnlOpcoesRetorno.Height := 50;
    btnPerfis.Caption := 'Expandir Perfis';
  End
  Else
  Begin
    clsFilterPerfil.Visible := True;
    pnlOpcoesRetorno.Height := 176;
    btnPerfis.Caption := 'Recolher Perfis';
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.btnRecolherClick(Sender: TObject);
begin
  inherited;
  fraImendesResultado.CollapseAll;
end;

procedure TfrmConsultoriaFiscalSaneamento.CdigoBarrasinvalidos1Click(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdCodbarrInvalidoComSaldo);
end;

procedure TfrmConsultoriaFiscalSaneamento.CodigodeBarrasInvlidosComSaldodeEstoqueClick(
  Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdCodbarrInvalidoComSaldo);
end;

function TfrmConsultoriaFiscalSaneamento.ConjFiltroDivergencia: TConjFiltroDivergencia;
begin
  Result := [];
  If chkDivICMS.Checked Then
    Result := Result + [fdICMS];
//  If chkDivIPI.Checked Then
//    Result := Result + [fdIPI];
//  If chkDivPIS.Checked Then
//    Result := Result + [fdPISCOfins];
  If chkInfGerais.Checked Then
    Result := Result + [fdInfGerais];
  If chkRetparcial.Checked Then
    Result := Result + [fdRetornoParcialImendes];
  If chkSemIme.Checked Then
    Result := Result + [fdSemImendes];
  If chkSemCst.Checked Then
    Result := Result + [fdSemCst];
  If chkCodbarInv.Checked Then
    Result := Result + [fdCodbarrInvalido];


End;

procedure TfrmConsultoriaFiscalSaneamento.chkDivICMSClick(Sender: TObject);
begin
  inherited;
  If blnCarregandoDados Then
    Exit;
  fraImendesResultado.pIniciaAlteracao;
  ProcessaImendesRetorno.pAbrirParametros(True, ProcessaImendesRetorno.strAutIncSelec, dtsDados,ConjFiltroDivergencia);
  If dtsDados.DataSet.RecordCount > 0 Then
    btnGerarAbreviacao.Enabled := ProcessaImendesRetorno.fTemDifIcms;
  cxpPagina.Value := ProcessaImendesRetorno.FPageAtual;
  cxpPagina.Properties.MaxValue := ProcessaImendesRetorno.intQtdRegistros;
  lblTotal.Caption := '/'+ ProcessaImendesRetorno.intQtdRegistros.ToString;
  fraImendesResultado.pFinalizaAlteracao;
end;

procedure TfrmConsultoriaFiscalSaneamento.clsFilterPerfilClick(Sender: TObject);
begin
  inherited;
  If clsFilterPerfil.ItemIndex > -1 Then
    TBandPerfil(clsFilterPerfil.Items.Objects[clsFilterPerfil.ItemIndex]).pChangeVisible(clsFilterPerfil.Items[clsFilterPerfil.ItemIndex].Checked);
end;

procedure TfrmConsultoriaFiscalSaneamento.clsFilterPerfilEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If clsFilterPerfil.ItemIndex > -1 Then
    TBandPerfil(clsFilterPerfil.Items.Objects[clsFilterPerfil.ItemIndex]).pChangeVisible(clsFilterPerfil.Items[clsFilterPerfil.ItemIndex].Checked);

end;


procedure TfrmConsultoriaFiscalSaneamento.spbExpandCollapseClick(Sender: TObject);
begin
  inherited;
  pnlFiltros.Visible := Not pnlFiltros.Visible;
  If pnlFiltros.Visible Then
    spbExpandCollapse.Caption := 'Recolher Filtros'
  Else
    spbExpandCollapse.Caption := 'Expandir Filtros'
end;


procedure TfrmConsultoriaFiscalSaneamento.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodosPerfis(True);
end;

procedure TfrmConsultoriaFiscalSaneamento.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodosPerfis(False);

end;

procedure TfrmConsultoriaFiscalSaneamento.cxSpinEdit1PropertiesChange(
  Sender: TObject);
begin
  inherited;
  If cxpPagina.Text <> ProcessaImendesRetorno.FPageAtual.ToString Then
  Begin
    fraImendesResultado.pIniciaAlteracao;
    ProcessaImendesRetorno.pAbrirParametros(False, ProcessaImendesRetorno.strAutIncSelec,  dtsDados, [], strToInt(cxpPagina.Text));
    fraImendesResultado.pFinalizaAlteracao;
    ProcessaImendesRetorno.FPageAtual :=  StrToIntDef(cxpPagina.Text, 1);
  End;

end;

function TfrmConsultoriaFiscalSaneamento.fPreencheZeroDireita(Texto: string; Quant: integer): String;
begin
   Result := Texto;
   Quant := Quant - Length(Result);
   if Quant > 0 then
      Result := Result + StringOfChar('0', Quant);
end;

procedure TfrmConsultoriaFiscalSaneamento.pLimpaCampos;
begin
  edtDesIte.Clear;
  edtDesIte2.Clear;
  edtCodNCM.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtAbfCof.Clear;
  edtDesAbfCof.Clear;
  edtAbfPis.Clear;
  edtDesAbfPis.Clear;
  edtAbfIPI.Clear;
  edtDesAbfIPI.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodAbfIcm.Clear;
  edtDesAbfIcm.Clear;
  edtCodIte.Clear;
  mskLinGru.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfCofExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfCof, edtDesAbfCof, arrCofins, fRetDesAbfCof, Nil, 'da abreviação de COFINS');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfCofKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   If fPesqCofSai(Self, edtAbfCof, edtDesAbfCof, Nil, Key, arrCofins, False) Then
    If fValidaCampos(edtAbfCof, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfIpiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfIpi, edtDesAbfIpi, arrIPI, fRetDesAbfIpi, Nil, 'da abreviação de IPI');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfIpiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqIPISai(Self, nil, qryConIPI, Key, arrIPI) Then
  Begin
    edtAbfIpi.Text := qryConIPI.FieldByName('APC_CODAPC').AsString;
    edtDesAbfIpi.Text := qryConIPI.FieldByName('APC_DESCRI').AsString;
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfPisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfPis, edtDesAbfPis, arrPis, fRetDesAbfPis, Nil, 'da abreviação de PIS');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtAbfPisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPisSai(Self, edtAbfPis, edtDesAbfPis, Nil, Key, arrPis, False) Then
    If fValidaCampos(edtAbfPis, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConsultoriaFiscalSaneamento.edtClaIPIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqClaIPI(Self, edtAbfIpi, nil, Key, arrIPI,False) Then
    if fValidaCampos(edtAbfIpi, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodAbfIcmExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAbfIcm, edtDesAbfICM, arrICMS, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodAbfIcmKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
    If fPesqAbrevFiscal(Self, edtCodAbfIcm, edtDesAbfIcm, qryConAbf, Key, arrICMS, False) Then
  Begin
    If fValidaCampos(edtCodAbfIcm, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    fValidaCampos(edtCodEmp, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte2, arrProduto, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, nil, nil, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
    If fValidaCampos(edtCodIte) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodNCMExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodNCM.Text) Then
    edtCodNCM.Text := fPreencheZeroDireita(edtCodNCM.Text, 8);
end;

procedure TfrmConsultoriaFiscalSaneamento.edtCodNCMKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqClaIPI(Self, edtCodNCM, nil, Key, arrNCM, False) Then
  Begin
    if fValidaCampos(edtCodNCM, True) then
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.edtLocItemKeyPress(Sender: TObject;
  var Key: Char);
  var APagina : integer;
begin
  inherited;
  If Key = #13 then
  Begin
    APagina := ProcessaImendesRetorno.fLocalizaPaginaDoItem(edtLocItem.Text);
    If APagina > -1 Then
    Begin
      If  APagina <> cxpPagina.Value Then
        cxpPagina.Value := APagina;
      If dtsDados.DataSet.Locate('IME_CODITE', edtLocItem.Text, []) Then
        fraImendesResultado.pSetFocusGrid;
      edtLocItem.text := '';
    End
    Else
      pMensagemOk('Produto não encontrado com esses filtros!');
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.FormActivate(Sender: TObject);
var strRetorno: String;
begin
  inherited;
  If fTamCodAbfIcm < 7 then
  Begin
    pMensagemOk('Falta rodar os scripts que altera o tamanho do "Código da Abreviação de ICMS"!');
    Close;
  End;

  If Not TAPISaneamento.fValidaConexao(strRetorno,VS_StrCodEmp, True, frmModulo.GetCurrentConnection) Then
    pMensagemOk(strRetorno);

end;

procedure TfrmConsultoriaFiscalSaneamento.pIniciaNovaConsulta;
begin
  pLimpaCampos;
  btnGerarAbreviacao.Enabled := False;
  //      chkDivPIS.Enabled := False;
  chkDivICMS.Enabled := False;
  //      chkDivIPI.Enabled := False;
  chkInfGerais.Enabled := False;
  chkSemIme.Enabled := False;
  btnExpandir.Enabled := False;
  btnRecolher.Enabled := False;
  btnExportacoes.Enabled := False;

  pnlCntFiltros.Enabled := True;
  pnlOpcoesRetorno.Visible := False;


  Try
    If Assigned(dtsDados.DataSet) Then
      dtsDados.DataSet.Close;
    pnlFiltros.Visible := True;
    spbExpandCollapse.Caption := 'Recolher Filtros';
  Finally
    pSetFocus(edtCodIte);
  End;
End;

procedure TfrmConsultoriaFiscalSaneamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Assigned(dtsDados.DataSet) then
  Begin
    If btnGerarAbreviacao.Enabled Then
    If fPergunta('Deseja iniciar uma nova consulta?') Then
    Begin
      CanClose := False;

      pIniciaNovaConsulta;

    End;
  End
  Else If (epResultado <> epAbotado) Then
  Begin
     CanClose := True;
  End;


  While (epResultado = epAbotado) do
  Begin
    If Not fPergunta('Fechar a tela? O processo poderá ser visualizado posteriormente.') Then
    Begin
      CanClose := False;
      pMonitoraProcesso;
    End
    else
    begin
      epResultado := epSemProcesso;
      CanClose := False;
      pIniciaNovaConsulta;
    End;
  End;




end;

procedure TfrmConsultoriaFiscalSaneamento.FormCreate
(Sender: TObject);
begin
  inherited;
  FPageIndex := 1;
  ProcessaImendesRetorno := TProcessaImendesRetorno.Create;
  qryMonitoramento := fCriaQuery(Self);
  qryCadNcm := fCriaQuery(Self);
  qryConIPI := fCriaQuery(Self);
  blnUtiAbi := fCfgSis('UTIABI', varBoolean);
  blnUtiAbr := fCfgSis('UTIABR', varBoolean);
  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.TamCampo:= fTamCodIte;
  objSalInt := TSalvaInterface.Create(Self);

  objSalInt.fCarregaDados('', Self, Self.Name, '', True, False, False);

  fraImendesResultado := TfraImendesResultado.fCriaFrameResultado(Self, pnlGridResultado, ProcessaImendesRetorno, dtsDados);
  fraImendesResultado.btnSair := btnSair;
  edtLocItem.TamCampo := fTamCodIte;

  grpPISCOF.Visible := fCfgSis('FILPCI') = 'S';
  grpIPI.Visible := grpPISCOF.Visible;

  CdigoBarrasinvalidos1.Visible := (Pos(strLoginUsuarioLogado, '_999_998_997_') > 0);
  ItensnoencontradosnaImendes1.Visible := CdigoBarrasinvalidos1.Visible;

  If Not CdigoBarrasinvalidos1.Visible Then
  begin
    ItenscomCdigodeBarrasInvlidosTodososProdutos1.Caption :=  'Itens com Código de Barras Inválidos';
    ItenscomCdBarrasVlidoNoEncontradosnaImendesTodososProdutos1.Caption := 'Itens com Cód. Barras Válido Não Encontrados na Imendes';
  end;
end;

procedure TfrmConsultoriaFiscalSaneamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ProcessaImendesRetorno);
  FreeAndNil(qryMonitoramento);
  FreeAndNil(qryConIPI);
  FreeAndNil(qryCadNcm);
  FreeAndNil(objSalInt);
  fraImendesResultado.pDestroy;
  FreeAndNil(fraImendesResultado);
  inherited;


end;

procedure TfrmConsultoriaFiscalSaneamento.FormResize(Sender: TObject);
begin
  inherited;
  clsFilterPerfil.Visible := False;
  clsFilterPerfil.Columns := 2;
  clsFilterPerfil.Visible := True;
  If pnlOpcoesRetorno.Height = 42 Then
    clsFilterPerfil.Visible := False;
end;

procedure TfrmConsultoriaFiscalSaneamento.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  btnExpandir.Enabled := False;
  btnRecolher.Enabled := False;
  btnExportacoes.Enabled := False;

  edtCodEmp.Text := VS_strCodEmp;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

function TfrmConsultoriaFiscalSaneamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        pMensagemOk('É necessário selecionar ao menos uma empresa!');
        Result := False;
      End;
    End
    Else
    If (Sender = edtCodIte) Then
    begin
      If edtCodIte.Text <> '' Then
      Begin
        If fCampoTabela('ITE_USAIME', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'N' Then
        begin
          pMensagemOk('Produto sem permissão para consulta na rotina Imendes.');
          edtCodIte.Text := '';
          edtDesIte2.Text := '';
          Result := False;
        End
        Else
        begin
          pEdtCodSelectExit(edtCodIte, edtDesIte2, arrProduto, nil, fRetNomProduto, 'do Produto');
          Result := edtDesIte2.Text <> '';
        End;
      End
      Else
      Begin
        Result := True;
      End;
      If Not Result Then
        pMensagemOk('Código do Produto Inválido!');
    End;
  End;

  If Not Result Then
    pSetFocus(Sender)
end;

procedure TfrmConsultoriaFiscalSaneamento.lblclbEmpEstClick(Sender: TObject);
begin
  inherited;
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmConsultoriaFiscalSaneamento.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmConsultoriaFiscalSaneamento.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.pMarcaDesmarcaTodosPerfis(blnMarca: Boolean);
var i: integer;
begin
  For i := 0 To clsFilterPerfil.Items.Count -1 do
  Begin
    clsFilterPerfil.Items[i].Checked := blnMarca;
    TBandPerfil(clsFilterPerfil.Items.Objects[i]).pChangeVisible(clsFilterPerfil.Items[i].Checked);
  end;
  {}
end;

procedure TfrmConsultoriaFiscalSaneamento.pMonitoraProcessamentoPendente;
var strBkpAutIncSelec: string;
begin
  Try
    strBkpAutIncSelec := ProcessaImendesRetorno.strAutIncSelec;
    ProcessaImendesRetorno.pVisualizaProcessosOperador(strLoginUsuarioLogado);
    If ProcessaImendesRetorno.strAutIncSelec <> '' Then
    Begin
      blnCarregandoDados:= True;

      objSalInt.fCarregaDados(ProcessaImendesRetorno.strAutIncSelec, Self, Self.Name, '', True, False, False);
//      chkDivPIS.Checked := False;
      chkDivICMS.Checked := False;
//      chkDivIPI.Checked := False;
      chkInfGerais.Checked := False;
      chkSemIme.Checked := False;
      chkRetparcial.Checked := False;
      blnCarregandoDados:= False;

      RecParametrosApiSaneamento := fMontaRecordParametros;
      fraImendesResultado.pIniciaAlteracao;
      ProcessaImendesRetorno.pAbrirParametros(True, ProcessaImendesRetorno.strAutIncSelec, dtsDados);
      fraImendesResultado.pFinalizaAlteracao;
      If Assigned(dtsDados.DataSet) Then
        If dtsDados.DataSet.RecordCount > 0 Then
           btnGerarAbreviacao.Enabled := ProcessaImendesRetorno.fTemDifIcms;


      If Not pnlOpcoesRetorno.Visible Then
      Begin
        pnlOpcoesRetorno.Visible := True;
        clsFilterPerfil.Columns := 2;

        fraImendesResultado.GridDinamico.pAjustaArrBandPerfil(RecParametrosApiSaneamento.Filtros.FilterPerfis +[cjpIndef], clsFilterPerfil);
//        chkDivPIS.Enabled := True;
        chkDivICMS.Enabled := True;
//        chkDivIPI.Enabled := True;
        chkInfGerais.Enabled := True;
        chkSemIme.Enabled := True;
        spbExpandCollapse.Enabled := True;
        btnRecolher.Enabled := True;
        btnExportacoes.Enabled := True;
        btnExpandir.Enabled := True;
        btnGerarAbreviacao.Enabled := ProcessaImendesRetorno.fTemDifIcms;

        pnlCntFiltros.Enabled := False;
        spbExpandCollapse.Click;
      End;

      cxpPagina.Value := ProcessaImendesRetorno.FPageAtual;
      cxpPagina.Properties.MaxValue := ProcessaImendesRetorno.intQtdRegistros;
      lblTotal.Caption := '/'+ ProcessaImendesRetorno.intQtdRegistros.ToString;

    End
    Else
      ProcessaImendesRetorno.strAutIncSelec := strBkpAutIncSelec;
  Finally
  End;
end;

procedure TfrmConsultoriaFiscalSaneamento.pMonitoraProcesso;
begin
  epResultado := TfrmiMendesProcessando.fExecutaProcesso(fVizualizaProcessoExterno, qryMonitoramento);
  case epResultado Of
    epAbotado: Close;
    epConcluido : Begin
                    fraImendesResultado.pIniciaAlteracao;
                    ProcessaImendesRetorno.pAbrirParametros(True, strAutoincrem, dtsDados);
                    fraImendesResultado.pFinalizaAlteracao;
                    ProcessaImendesRetorno.strAutIncSelec := strAutoincrem;
 
                    pnlOpcoesRetorno.Visible := True;
                    clsFilterPerfil.Columns := 2;
                    fraImendesResultado.GridDinamico.pAjustaArrBandPerfil(RecParametrosApiSaneamento.Filtros.FilterPerfis + [cjpIndef], clsFilterPerfil);
//                    chkDivPIS.Enabled := True;
                    chkDivICMS.Enabled := True;
//                    chkDivIPI.Enabled := True;
                    chkInfGerais.Enabled := True;
                    chkSemIme.Enabled := True;
                    cxpPagina.Properties.MaxValue := ProcessaImendesRetorno.intQtdRegistros;
                    lblTotal.Caption := '/'+ ProcessaImendesRetorno.intQtdRegistros.ToString;
                    spbExpandCollapse.Enabled := True;
                    btnRecolher.Enabled := True;
                    btnExportacoes.Enabled := True;
                    btnExpandir.Enabled := True;

                    pnlCntFiltros.Enabled := False;
                    If dtsDados.DataSet.RecordCount > 0 Then
                      btnGerarAbreviacao.Enabled := ProcessaImendesRetorno.fTemDifIcms;
                  end;


  End;

end;


procedure TfrmConsultoriaFiscalSaneamento.SemCST1Click(Sender: TObject);
begin
  inherited;
  pGeraRelatorio(fdSemCst);

end;

end.


