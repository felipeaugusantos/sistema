unit untFluxoOrdemServico;

interface

uses
  untProcessoOrdemServico,
  Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  System.Generics.Collections,
  System.SysUtils,
  Vcl.Buttons,
  BitBtnLockedIncrem,
  Math,
  Data.DB,
  cxGrid,
  cxGraphics,
  cxEditRepositoryItems,
  cxGridCustomTableView,
  cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCustomView,
  untZClient,
  untTypesSistema,
  cxButtons,
  cxProgressBar,
  Uni;

type
  TFiltros = Record
    dtaCadIni: TDateTime;
    dtaCadFin: TDateTime;
    strNumOSe: String;
    strCodEmp: String;
    strProtoc: String;
    strNOSFab: String;
    strCodCli: String;
    strDocCli: String;
    strCodVen: String;
    strPedCmp: String;
    strCodMar: String;
    strStatus: String;
    strCodEqu: String;
    strNSerie: String;
    strNumPat: String;
    strObserv: String;
    blnCancel: Boolean;
    strGarant: String;
    strDocEnt: String;
    strEspEnt: String;
    strEmpEnt: String;
  End;

type
  TFluxoOrdemServico = class
  const
    LARGURA_SCROLLBAR = 18;
  private
    FVerificaStatus                     : Boolean;
    FTimerExecuta                       : TTimer;

    FEditRepositoryTextItem             : TcxEditRepositoryTextItem;
    FEditRepositoryImageComboBoxItem    : TcxEditRepositoryImageComboBoxItem;
    FEditRepositoryMemoItem             : TcxEditRepositoryMemoItem;

    FProcessos                          : TObjectList<TProcessoOrdemServico>;
    FCdsFluxo                           : TZClient;
    FCxgFluxo                           : TcxGrid;
    FCxgFluxoTBV                        : TcxGridDBBandedTableView;
    FblnFiltro                          : Boolean;
    FFiltros                            : TFiltros;

    FbtnDocsFiscaisEnt,
    FbtnDocsFiscaisSai,
    FbtnAnaliseTec,
    FbtnOrcamento,
    FbtnEnviarCliente,
    FbtnInterromperOrc,
    FbtnAprovar,
    FbtnReprovar,
    FbtnCancelarRep,
    FbtnRealizarMan,
    FbtnInterromperMan,
    FbtnManutencao,
    FbtnCancelarMan,
    FbtnApontamento,
    FbtnArmazenar,
    FbtnCancelarArm,
    FbtnRetirar,
    FbtnCancEntEquip,
    FbtnBaixarOSDes,
    FbtnComunicacoesInternas: TcxButton;

    function fSqlFluxo: String;
    function fParamsFiltroSql(APrefix: String = ''): String;
    function fIndexColumnToProcesso(intItemIndex: Integer): Integer;
    procedure pCarregaProcessos;
    procedure pValidaDireitosAcessoProcessos;
    procedure pCriaColunasCxgFluxo;
    procedure setCxgFluxo(const Value: TcxGrid);
    procedure cxgFluxoTBVCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxgFluxoTBVKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFluxoTBVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pExecutaTimer(Sender: TObject);
    procedure cdsFluxoAfterScroll(DataSet: TDataSet);

    procedure btnDocsFiscaisEntClick(Sender: TObject);
    procedure btnDocsFiscaisSaiClick(Sender: TObject);
    procedure btnAnaliseTecClick(Sender: TObject);
    procedure btnOrcamentoClick(Sender: TObject);
    procedure btnEnviarClienteClick(Sender: TObject);
    procedure btnInterromperOrcClick(Sender: TObject);
    procedure btnAprovarClick(Sender: TObject);
    procedure btnReprovarClick(Sender: TObject);
    procedure btnCancelarRepClick(Sender: TObject);
    procedure btnRealizarManClick(Sender: TObject);
    procedure btnInterromperManClick(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
    procedure btnCancelarManClick(Sender: TObject);
    procedure btnArmazenarClick(Sender: TObject);
    procedure btnCancelarArmClick(Sender: TObject);
    procedure btnRetirarClick(Sender: TObject);
    procedure btnCancEntEquipClick(Sender: TObject);
    procedure btnApontamentoClick(Sender: TObject);
    procedure btnBaixarOSDesClick(Sender: TObject);
    procedure btnComunicacoesInternasClick(Sender: TObject);

    procedure pHabilitaAnaliseTec;
    procedure pHabilitaOrcamento;
    procedure pHabilitaEnviarCliente;
    procedure pHabilitaAprovar;
    procedure pHabilitaReprovar;
    procedure pHabilitaRealizarMan;
    procedure pHabilitaManutencao;
    procedure pHabilitaArmazenar;
    procedure pHabilitaRetirar;

    procedure pChamadaDocsFiscais(aTipoDoc: TTipoDocsFiscaisFlxConEqu);
    procedure pVerificaStatusOSComRequisicao(AEmManutencao: Boolean = False);
    procedure pValidaFiltroCancelada(var aSQL: String);
    procedure pChamaManConsertoEquip(aProcesso: TTipoProcessosFlxConEqu; AstrNumOSe: String = ''; AstrCodEmp: String = '');

    procedure pCarregaFiltros;
    procedure pCarregaFiltroCodEmp;
    procedure pCarregaFiltroProtoc;
    procedure pCarregaFiltroNOSFab;
    procedure pCarregaFiltroCodCli;
    procedure pCarregaFiltroDocCli;
    procedure pCarregaFiltroPedCmp;
    procedure pCarregaFiltroCodVen;
    procedure pCarregaFiltroCodMar;
    procedure pCarregaFiltroCodEqu;
    procedure pCarregaFiltroNSerie;
    procedure pCarregaFiltroNumPat;
    procedure pCarregaFiltroDocEnt;

    function fFiltroObservacao(aObserv, APrefix: String): String;
    function fAtualizar(pgbProgresso: TcxProgressBar = nil): Boolean;
    function fFiltraOSCanceladas: String;
    function fVerificaPDComReqEmAbertoComPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String): Boolean;
    function fVerificaPDComReqEmAbertoSemPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String): Boolean;
    function fGetSQLCampoEditar: String;
    function fCarregaFiltroNumOSe: Boolean;

    function fVerificaFiltros(APrefix: String): String;
    function fVerificaFiltrosCodEmp(APrefix: String): String;
    function fVerificaFiltrosProtoc(APrefix: String): String;
    function fVerificaFiltrosNOSFab(APrefix: String): String;
    function fVerificaFiltrosCodCli(APrefix: String): String;
    function fVerificaFiltrosDocCli(APrefix: String): String;
    function fVerificaFiltrosPedCmp(APrefix: String): String;
    function fVerificaFiltrosCodVen(APrefix: String): String;
    function fVerificaFiltrosCodMar(APrefix: String): String;
    function fVerificaFiltrosCodEqu(APrefix: String): String;
    function fVerificaFiltrosNSerie(APrefix: String): String;
    function fVerificaFiltrosNumPat(APrefix: String): String;
    function fVerificaFiltrosDocEnt(APrefix: String): String;

    function fCarregaSemFiltro: String;
    function fGetSQLJaFatu(blnWhere: Boolean = False): String;

    function fValidaOrcEnviadoCliente: Boolean;
    procedure pInsereLogFlxOS(ANumOSe, ACodEmp, AFlxFasAnt, AFlxSitAnt, AFlxComAnt, AFlxFas, AFlxSit, AFlxCom: String);
  public
    property cxgFluxo                           : TcxGrid                            read FCxgFluxo                        write setCxgFluxo  ;

    procedure pSetButton(aButton: TcxButton);
    procedure pAtualizaDados(AVerificaStatus: Boolean = False);
    procedure pVerificaOSGarantiaAgPecas;
    procedure pNovaOrdemServico;
    procedure pCancelarOrdemServico;
    procedure pValidarPermissaoColunas;
    constructor Create(AEditRepositoryTextItem: TcxEditRepositoryTextItem;
                       AEditRepositoryImageComboBoxItem: TcxEditRepositoryImageComboBoxItem;
                       AEditRepositoryMemoItem: TcxEditRepositoryMemoItem;
                       AblnFiltro: Boolean;
                       AFiltros: TFiltros);

    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples, untFatManConsertoEquip, Dialogs, strUtils,
  untTSituacaoPedidoVenda, untGravando, untIFatReservaSaldo, untTFatReservaSaldo,
  untcxGridDBBandedColumnHelper, untConsertoEquipInformaOS, untInputDialog;

{ TFluxoOrdemServico }

procedure TFluxoOrdemServico.btnAnaliseTecClick(Sender: TObject);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (not FbtnAnaliseTec.Visible) then
    Exit;

  if (not FbtnAnaliseTec.Enabled) then
    Exit;

  if (FbtnAnaliseTec.PaintStyle <> bpsCaption) then
    Exit;

  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso               := True;
    frmFatManConsertoEquip.tpProcessoFlx                  := tprDefPrdSer;
    frmFatManConsertoEquip.blnFlxProcessoTec              := True;
    frmFatManConsertoEquip.blnRotinaTecnico               := True;
    frmFatManConsertoEquip.edtNumero.Text                 := FCdsFluxo.FieldByName('NUMERO_OS').AsString;
    frmFatManConsertoEquip.edtCodEmp.Text                 := FCdsFluxo.FieldByName('EMP').AsString;
    frmFatManConsertoEquip.tbsAcessorios.TabVisible       := False;
    frmFatManConsertoEquip.tbsDocsRelacionados.TabVisible := False;
    frmFatManConsertoEquip.tbsApontamentos.TabVisible     := False;
    frmFatManConsertoEquip.tbsHistEquipamento.TabVisible  := False;
    frmFatManConsertoEquip.btnRealizada.Visible           := False;
    frmFatManConsertoEquip.btnImprimir.Visible            := False;
    frmFatManConsertoEquip.btnTermoDev.Visible            := False;
    frmFatManConsertoEquip.btnAlteracao.Visible           := False;
    frmFatManConsertoEquip.btnDesEsp.Visible              := False;
    frmFatManConsertoEquip.btnReprovar.Visible            := False;
    frmFatManConsertoEquip.btnAprovada.Visible            := False;
    frmFatManConsertoEquip.btnCancelar.Visible            := False;
    frmFatManConsertoEquip.btnManutencao.Visible          := False;
    frmFatManConsertoEquip.btnHisSta.Visible              := False;
    frmFatManConsertoEquip.btnImpostos.Visible            := False;
    frmFatManConsertoEquip.btnImpEti.Visible              := False;
    frmFatManConsertoEquip.btnReativar.Visible            := False;
    frmFatManConsertoEquip.btnUltimasVendas.Visible       := False;
    frmFatManConsertoEquip.btnComunicacaoInterna.Visible  := True;
    frmFatManConsertoEquip.edtNumero.Enabled              := False;
    frmFatManConsertoEquip.btnApontHoras.Visible          := True;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados;
  end;
end;

procedure TFluxoOrdemServico.btnApontamentoClick(Sender: TObject);
begin
  if (not FbtnApontamento.Visible) and (not FbtnApontamento.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprApontamento);
end;

procedure TFluxoOrdemServico.btnAprovarClick(Sender: TObject);
begin
  if (not FbtnAprovar.Visible) then
    Exit;

  if (not FbtnAprovar.Enabled) then
    Exit;

  if (FbtnAprovar.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprAprovar);
end;

procedure TFluxoOrdemServico.btnCancelarRepClick(Sender: TObject);
begin
  if (not FbtnCancelarRep.Visible) then
    Exit;

  if (not FbtnCancelarRep.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprCancelarRep);
end;

procedure TFluxoOrdemServico.btnCancEntEquipClick(Sender: TObject);
var
  intOpAcao: Integer;
  strNumOSe,
  strCodEmp: String;
  frmConsertoEquipInformaOS: TfrmConsertoEquipInformaOS;
begin
  if (not FbtnCancEntEquip.Visible) then
    Exit;

  if (not FbtnCancEntEquip.Enabled) then
    Exit;

  if (FbtnCancEntEquip.PaintStyle <> bpsCaption) then
    Exit;

  intOpAcao := fGetMenu('Selecione uma opção', ['Cancelar Entrega da OS Selecionada', 'Informar OS'], 1);

  case intOpAcao of
    1: pChamaManConsertoEquip(tprCancEntregaEquip);
    2:
      begin
        pCriarFormularios(TfrmConsertoEquipInformaOS, frmConsertoEquipInformaOS);

        try
          frmConsertoEquipInformaOS.ShowModal();

          if (frmConsertoEquipInformaOS.blnConfirma) then
          begin
            strNumOSe := frmConsertoEquipInformaOS.strNumOSe;
            strCodEmp := frmConsertoEquipInformaOS.strCodEmp;

            pChamaManConsertoEquip(tprCancEntregaEquip, strNumOSe, strCodEmp);
          end;
        finally
          pFreeAndNil(frmConsertoEquipInformaOS);
        end;
      end;
  end;
end;

procedure TFluxoOrdemServico.btnComunicacoesInternasClick(Sender: TObject);
begin
  if (not FbtnComunicacoesInternas.Visible) then
    Exit;

  if (not FbtnComunicacoesInternas.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprComunicacoesInternas);
end;

procedure TFluxoOrdemServico.btnDocsFiscaisEntClick(Sender: TObject);
begin
  if (not FbtnDocsFiscaisEnt.Enabled) then
    Exit;

  pChamadaDocsFiscais(tpEntrada);
end;

procedure TFluxoOrdemServico.btnDocsFiscaisSaiClick(Sender: TObject);
begin
  if (not FbtnDocsFiscaisSai.Visible) then
    Exit;

  if (not FbtnDocsFiscaisSai.Enabled) then
    Exit;

  pChamadaDocsFiscais(tpSaida);
end;

procedure TFluxoOrdemServico.btnEnviarClienteClick(Sender: TObject);
begin
  if (not FbtnEnviarCliente.Visible) then
    Exit;

  if (not FbtnEnviarCliente.Enabled) then
    Exit;

  if (FbtnEnviarCliente.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprEnviarCliente);
end;

procedure TFluxoOrdemServico.btnArmazenarClick(Sender: TObject);
begin
  if (not FbtnArmazenar.Visible) then
    Exit;

  if (not FbtnArmazenar.Enabled) then
    Exit;

  if (FbtnArmazenar.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprArmazenar);
end;

procedure TFluxoOrdemServico.btnBaixarOSDesClick(Sender: TObject);
begin
  if (not FbtnBaixarOSDes.Visible) then
    Exit;

  if (not FbtnBaixarOSDes.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprBaixarOSDes);
end;

procedure TFluxoOrdemServico.btnCancelarArmClick(Sender: TObject);
begin
  if (not FbtnCancelarArm.Visible) then
    Exit;

  if (not FbtnCancelarArm.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprCancelarArm);
end;

procedure TFluxoOrdemServico.btnCancelarManClick(Sender: TObject);
begin
  if (not FbtnManutencao.Visible) then
    Exit;

  if (not FbtnManutencao.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprCancelarMan);
end;

procedure TFluxoOrdemServico.btnInterromperManClick(Sender: TObject);
begin
  if (not FbtnInterromperMan.Visible) then
    Exit;

  if (not FbtnInterromperMan.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprInterromperMan);
end;

procedure TFluxoOrdemServico.btnInterromperOrcClick(Sender: TObject);
begin
  if (not FbtnInterromperOrc.Visible) then
    Exit;

  if (not FbtnInterromperOrc.Enabled) then
    Exit;

  pChamaManConsertoEquip(tprInterromperOrc);
end;

procedure TFluxoOrdemServico.btnManutencaoClick(Sender: TObject);
begin
  if (not FbtnManutencao.Visible) then
    Exit;

  if (not FbtnManutencao.Enabled) then
    Exit;

  if (FbtnManutencao.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprManutencao);
end;

procedure TFluxoOrdemServico.btnOrcamentoClick(Sender: TObject);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (not FbtnOrcamento.Visible) then
    Exit;

  if (not FbtnOrcamento.Enabled) then
    Exit;

  if (FbtnOrcamento.PaintStyle <> bpsCaption) then
    Exit;

  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso              := True;
    frmFatManConsertoEquip.tpProcessoFlx                 := tprOrcamento;
    frmFatManConsertoEquip.edtNumero.Text                := FCdsFluxo.FieldByName('NUMERO_OS').AsString;
    frmFatManConsertoEquip.edtCodEmp.Text                := FCdsFluxo.FieldByName('EMP').AsString;
    frmFatManConsertoEquip.tbsAcessorios.TabVisible      := False;
    frmFatManConsertoEquip.btnRealizada.Visible          := False;
    frmFatManConsertoEquip.btnImprimir.Visible           := False;
    frmFatManConsertoEquip.btnTermoDev.Visible           := False;
    frmFatManConsertoEquip.btnAlteracao.Visible          := False;
    frmFatManConsertoEquip.btnReprovar.Visible           := False;
    frmFatManConsertoEquip.btnAprovada.Visible           := False;
    frmFatManConsertoEquip.btnCancelar.Visible           := False;
    frmFatManConsertoEquip.btnManutencao.Visible         := False;
    frmFatManConsertoEquip.btnHisSta.Visible             := False;
    frmFatManConsertoEquip.btnSalRes.Visible             := False;
    frmFatManConsertoEquip.btnImpEti.Visible             := False;
    frmFatManConsertoEquip.btnReativar.Visible           := False;
    frmFatManConsertoEquip.btnComunicacaoInterna.Visible := True;
    frmFatManConsertoEquip.btnApontHoras.Visible         := True;
    frmFatManConsertoEquip.edtNumero.Enabled             := False;
    frmFatManConsertoEquip.btnAddObsTec.Visible          := False;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados;
  end;
end;

procedure TFluxoOrdemServico.btnRealizarManClick(Sender: TObject);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (not FbtnRealizarMan.Visible) then
    Exit;

  if (not FbtnRealizarMan.Enabled) then
    Exit;

  if (FbtnRealizarMan.PaintStyle <> bpsCaption) then
    Exit;

  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso     := True;
    frmFatManConsertoEquip.tpProcessoFlx        := tprRealizarMan;
    frmFatManConsertoEquip.blnRotinaTecnico     := True;
    frmFatManConsertoEquip.edtNumero.Text       := FCdsFluxo.FieldByName('NUMERO_OS').AsString;
    frmFatManConsertoEquip.edtCodEmp.Text       := FCdsFluxo.FieldByName('EMP').AsString;
    frmFatManConsertoEquip.btnAddObsTec.Visible := False;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados;
  end;
end;

procedure TFluxoOrdemServico.btnReprovarClick(Sender: TObject);
begin
  if (not FbtnReprovar.Visible) then
    Exit;

  if (not FbtnReprovar.Enabled) then
    Exit;

  if (FbtnReprovar.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprReprovar);
end;

procedure TFluxoOrdemServico.btnRetirarClick(Sender: TObject);
begin
  if (not FbtnRetirar.Visible) then
    Exit;

  if (not FbtnRetirar.Enabled) then
    Exit;

  if (FbtnRetirar.PaintStyle <> bpsCaption) then
    Exit;

  pChamaManConsertoEquip(tprRetirar);
end;

procedure TFluxoOrdemServico.cdsFluxoAfterScroll(DataSet: TDataSet);
begin
  FbtnDocsFiscaisEnt.Enabled := (fVerificaAcessoSistema('FXDOCF', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('DOCS_FISCAIS_RELACIONADOS_ENT').AsString <> 'REALIZADO') and (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'C');
  FbtnDocsFiscaisSai.Enabled := (fVerificaAcessoSistema('FXDOCF', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('DOCS_FISCAIS_RELACIONADOS_SAI').AsString <> 'REALIZADO') and (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'C');
  FbtnInterromperOrc.Enabled := (fVerificaAcessoSistema('FLXINO', strLoginUsuarioLogado)) and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AC') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'RC') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AE') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'PF'));
  FbtnCancelarRep.Enabled    := (fVerificaAcessoSistema('FLXCRE', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'ON') and (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AA');
  FbtnInterromperMan.Enabled := (fVerificaAcessoSistema('FLXINM', strLoginUsuarioLogado)) and ((FcdsFluxo.FieldByName('FLXSIT').AsString = 'EM') or (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AP') or (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AS'));
  FbtnApontamento.Enabled    := (fVerificaAcessoSistema('FLXAPO', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('APONTAMENTO').AsString <> 'REALIZADO') and (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'C');
  FbtnCancelarArm.Enabled    := (fVerificaAcessoSistema('FXCAAR', strLoginUsuarioLogado)) and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AR') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AF'));
  FbtnBaixarOSDes.Enabled    := (fVerificaAcessoSistema('FLXBOS', strLoginUsuarioLogado)) and ((FcdsFluxo.FieldByName('FLXSIT').AsString = 'OI') or (FcdsFluxo.FieldByName('FLXSIT').AsString = 'TA')
    or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'OI') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'MI'));
  FbtnCancelarMan.Enabled    := (fVerificaAcessoSistema('FXCAMA', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'MF');

  pHabilitaAnaliseTec;
  pHabilitaOrcamento;
  pHabilitaEnviarCliente;
  pHabilitaAprovar;
  pHabilitaReprovar;
  pHabilitaRealizarMan;
  pHabilitaManutencao;
  pHabilitaArmazenar;
  pHabilitaRetirar;
end;

constructor TFluxoOrdemServico.Create(AEditRepositoryTextItem: TcxEditRepositoryTextItem;
                       AEditRepositoryImageComboBoxItem: TcxEditRepositoryImageComboBoxItem;
                       AEditRepositoryMemoItem: TcxEditRepositoryMemoItem;
                       AblnFiltro: Boolean;
                       AFiltros: TFiltros);
begin
  FCxgFluxo    := nil;
  FCxgFluxoTBV := nil;

  FEditRepositoryTextItem               := AEditRepositoryTextItem;
  FEditRepositoryImageComboBoxItem      := AEditRepositoryImageComboBoxItem;
  FEditRepositoryMemoItem               := AEditRepositoryMemoItem;
  FblnFiltro                            := AblnFiltro;
  FFiltros                              := AFiltros;

  FProcessos := TObjectList<TProcessoOrdemServico>.Create;
  FCdsFluxo := TZClient.Create(nil, fSqlFluxo);

  if (not FblnFiltro) then
  begin
    if (not fCfgSis('MAOSEM', varBoolean)) then
      FCdsFluxo.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  end
  else
    pCarregaFiltros;

  FCdsFluxo.AfterScroll := cdsFluxoAfterScroll;

  FTimerExecuta := TTimer.Create(nil);
  FTimerExecuta.Enabled  := False;
  FTimerExecuta.Interval := 5;
  FTimerExecuta.OnTimer := pExecutaTimer;

  pCarregaProcessos;
end;

procedure TFluxoOrdemServico.cxgFluxoTBVCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (not ACellViewInfo.GridRecord.IsData) then
    Exit;

  if(ACellViewInfo.GridRecord.Index >= 0) then
    FTimerExecuta.Enabled := True;
end;

procedure TFluxoOrdemServico.cxgFluxoTBVKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    FTimerExecuta.Enabled := True;
end;

procedure TFluxoOrdemServico.cxgFluxoTBVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  LGridSite : TcxGridSite;
  LGridView : TcxGridDBBandedTableView;
  LHitTest  : TcxCustomGridHitTest;
  intCount  : integer;
begin
  if (Sender is TcxGridSite) then
  begin
    LGridSite := Sender as TcxGridSite;
    LGridView := LGridSite.GridView as TcxGridDBBandedTableView;

    if (LGridView.IsControlLocked) then
      Exit;

    if (LGridView.IsUpdateLocked) then
      Exit;

    if (LGridView.IsLoading) then
      Exit;

    if (LGridView.IsDesigning) then
      Exit;

    LHitTest  := LGridView.GetHitTest(X, Y);

    if (LHitTest is TcxGridRecordCellHitTest) then
    begin
      intCount := fIndexColumnToProcesso((LHitTest as TcxGridRecordCellHitTest).Item.Index);

      if (intCount < 0) then
        Exit;

      if (intCount > FProcessos.Count) then
        Exit;

      FProcessos[intCount].objComum.pMouseMove(LGridSite, X, Y);
    end;
  end;
end;

destructor TFluxoOrdemServico.Destroy;
begin
  pFreeAndNil(FProcessos);
  pFreeAndNil(FCdsFluxo);
  pFreeAndNil(FTimerExecuta);
  inherited;
end;

function TFluxoOrdemServico.fAtualizar(pgbProgresso: TcxProgressBar = nil): Boolean;
var
  strAutoincrem : String;
begin
  Result := True;

  FCdsFluxo.DisableControls;
  FCdsFluxo.AfterScroll := nil;

  try
    if FVerificaStatus then
    begin
      pInformacao('Aguarde, Verificando Ordens de Serviço - Ag. Peças...', pgbProgresso);
      pVerificaStatusOSComRequisicao;

      pInformacao('Aguarde, Verificando Ordens de Serviço - Em Manutenção...', pgbProgresso);
      pVerificaStatusOSComRequisicao(True);
    end;

    if FCdsFluxo.Active then
      if (not FCdsFluxo.isEmpty) then
        strAutoincrem := FCdsFluxo.FieldByName('AUTOINCREM').AsString;

    pInformacao('Aguarde, Carregando Ordens de Serviço...', pgbProgresso);

    FcdsFluxo.Close;
    FcdsFluxo.qryQuery.Close;
    FcdsFluxo.fAbreClient(True, 'TfrmFatManConsertoFluxoProcesso.pAtualizaDados()',  False, True);

    if not FCdsFluxo.Locate('AUTOINCREM', strAutoincrem, []) then
      FCdsFluxo.First;

    FCdsFluxo.IndexFieldNames := 'ORDPROTOC;';

    if (fCfgSis('EFXTPG', varBoolean)) then
      FCdsFluxo.IndexFieldNames := FCdsFluxo.IndexFieldNames + 'ORDGARANT;';

    FCdsFluxo.IndexFieldNames := FCdsFluxo.IndexFieldNames + 'EMP;NUMERO_OS';
    pSetFocus(FCxgFluxo);
  finally
    FCdsFluxo.EnableControls;
    cdsFluxoAfterScroll(nil);
    FCdsFluxo.AfterScroll := cdsFluxoAfterScroll;
  end;
end;

function TFluxoOrdemServico.fCarregaFiltroNumOSe: Boolean;
begin
  Result := False;

  if fEmptyStr(FFiltros.strNumOSe) then
    Exit;

  FCdsFluxo.qryQuery.ParamByName('NUMOSE').AsString := FFiltros.strNumOSe;

  if (not fEmptyStr(FFiltros.strCodEmp)) then
    FCdsFluxo.qryQuery.ParamByName('CODEMP').AsString := FFiltros.strCodEmp
  else
    FCdsFluxo.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Result := True;
end;

function TFluxoOrdemServico.fCarregaSemFiltro: String;
begin
  Result := ' WHERE ((EQUGER.EQU_FLXCOM <> "ER") ';

  if fCfgSis('FXEXER', varBoolean) then
  begin
    Result := Result + ' OR ((EQUGER.EQU_FLXSIT = "AF") ';
    Result := Result + ' AND ((' + fGetSQLJaFatu(True) + ') = 0)) ';
  end;

  Result := Result + ') ';
end;

function TFluxoOrdemServico.fValidaOrcEnviadoCliente: Boolean;
begin
  Result := True;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'O') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AC') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'ON') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'RC') then
    Exit;

  Result := False;
end;

function TFluxoOrdemServico.fFiltraOSCanceladas: String;
var
  LstrFXTPVM,
  LstrFXTPAM,
  LstrFXTPVD,
  LstrFXFIVM,
  LstrFXFIAM,
  LstrFXFIVD: String;
begin
  LstrFXTPVM := fCfgSis('FXTPVM', varString);
  LstrFXTPAM := fCfgSis('FXTPAM', varString);
  LstrFXTPVD := fCfgSis('FXTPVD', varString);
  LstrFXFIVM := fCfgSis('FXFIVM', varString);
  LstrFXFIAM := fCfgSis('FXFIAM', varString);
  LstrFXFIVD := fCfgSis('FXFIVD', varString);

  Result := '';

  Result := Result + ' SELECT ';
  Result := Result + '    IF(EQU_PRTATD = "N", 1, 0) AS ORDPROTOC, ';
  Result := Result + '    IF((EQU_GARANT IN ("F", "L")) AND (DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + '), 0, 1) ORDGARANT, ';
  Result := Result + '    DEL_EQUGER.AUTOINCREM, ';
  Result := Result + '    IF(EQU_PRTATD = "N", IF(EQU_GARANT = "R", "R", ""), EQU_PRTATD) AS ' + TProcessoNumOS.DATA_FIELD_NAME_STATUSOS + ', ';
  Result := Result + '    IF((EQU_GARANT IN ("F", "L")) AND (DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + '), 1, 0) AS TMPRES, ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_IMP + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_ETI + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_TRESP + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_TDEV + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_ORDEXE + ', ';
  Result := Result + '    EQU_NUMOSE AS '                            + TProcessoNumOS.DATA_FIELD_NAME_NUMEROOS + ', ';
  Result := Result + '    EQU_PROTOC AS '                            + TProcessoDadosOS.DATA_FIELD_NAME_PROTOCOLO + ', ';
  Result := Result + '    "CONSULTAR" AS '                           + TProcessoDadosOS.DATA_FIELD_NAME_CONSULTA + ', ';
  Result := Result + '    @JAFATU := 0, ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_EDITAR + ', ';
  Result := Result + '    DEL_EQUGER.EQU_CODEMP AS '                 + TProcessoDadosOS.DATA_FIELD_NAME_EMP + ', ';
  Result := Result + '    EQU_DTAENT AS '                            + TProcessoDadosOS.DATA_FIELD_NAME_DTINC + ', ';
  Result := Result + '    CONCAT(CLI_CODCLI, " - ", CLI_NOMCLI, ';
  Result := Result + '           IF(IFNULL(EQU_CODFAZ, "") <> "", CONCAT(" - FAZENDA: ", ';
  Result := Result + '             (SELECT FAZ_NOMFAZ FROM CADFAZ WHERE FAZ_CODFAZ = EQU_CODFAZ)), "")) AS ' + TProcessoDadosOS.DATA_FIELD_NAME_CLIENTE + ', ';
  Result := Result + '    CLI_C_G_C_ AS '                            + TProcessoDadosOS.DATA_FIELD_NAME_CPFCNPJ + ', ';
  Result := Result + '    CADEQU.EQU_DESCRI AS '                     + TProcessoDadosOS.DATA_FIELD_NAME_EQUIPAMENTO + ', ';
  Result := Result + '    MAR_DESMAR AS '                            + TProcessoDadosOS.DATA_FIELD_NAME_MARCA + ', ';
  Result := Result + '    EQU_NFREME AS '                            + TProcessoDadosOS.DATA_FIELD_NAME_NFREME + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_HISTSTATUS + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_HISTETAPAS + ', ';
  Result := Result + '    "" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_HISTFAT + ', ';

  Result := Result + '    EQU_NOSFAB                                AS ' + TProcessoGarantia.DATA_FIELD_NAME_NOSFAB + ', ';

  if (fCfgSis('EFXTPG', varBoolean)) then
  begin
    Result := Result + '    IF(EQU_GARANT IN ("F", "L"), ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + ', "3", ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPVD + ', "2", "1")), "") AS ' + TProcessoGarantia.DATA_FIELD_NAME_STAGAR + ', ';
    Result := Result + '    "" AS ' + TProcessoGarantia.DATA_FIELD_NAME_TMPGAR + ', ';
  end;

  if (fCfgSis('EFXTPF', varBoolean)) then
  begin
    Result := Result + '    IF((EQU_STATUS <> "R") AND (EQU_STATUS <> "N"), IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXFIAM + ', "3", ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXFIVD + ', "2", "1")), "") AS ' + TProcessoFinalizacaoOS.DATA_FIELD_NAME_STAFIN + ', ';
    Result := Result + '    "" AS ' + TProcessoFinalizacaoOS.DATA_FIELD_NAME_TMPFIN + ', ';
  end;

  if (fCfgSis('TXAUTI', varBoolean)) then
    Result := Result + '    "0.00" AS ' + TProcessoTaxaArmazenamento.DATA_FIELD_NAME_TX_ARM + ', ';

  Result := Result + '    "" AS ' + TProcessoDocsFiscais.DATA_FIELD_NAME_ENT + ', ';
  Result := Result + '    "" AS ' + TProcessoDocsFiscais.DATA_FIELD_NAME_SAI + ', ';
  Result := Result + '    "" AS ' + TProcessoDefPrdSer.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoOrcamento.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoAprovar.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoReprovar.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoManutencao.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoApontamento.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoFinalizar.DATA_FIELD_NAME + ', ';
  Result := Result + '    "" AS ' + TProcessoRetirar.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF(EQU_DTFIMA IS NULL, 0, 1) AS FINMAN, ';
  Result := Result + '    "C" FLXFAS, ';
  Result := Result + '    "CA" FLXSIT, ';
  Result := Result + '    "CA" FLXCOM, EQU_FLXFAS, EQU_FLXSIT, EQU_FLXCOM, ';
  Result := Result + '    "OS CANCELADA" ' + TProcessoDadosOS.DATA_FIELD_NAME_STATUS + ', ';
  Result := Result + '    "CANCELADA" ' + TProcessoDadosOS.DATA_FIELD_NAME_SITUACAO + ', ';
  Result := Result + '    "CANCELADA" ' + TProcessoDadosOS.DATA_FIELD_NAME_COMPLEMENTO + ', ';
  Result := Result + '    "" AS ' + TProcessoDadosOS.DATA_FIELD_NAME_MOTREPR + ', ';
  Result := Result + '    EQU_SITDTR AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DTENTR_EQUIP + ', ';
  Result := Result + '    (SELECT CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) FROM CADOPE WHERE OPE_CODOPE = EQU_DIGRET) AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DIG_ENTREG + ', ';
  Result := Result + '    EQU_DTFIMA AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DTFIN_MAN + ', ';
  Result := Result + '    ' + fFormataCondPagSQL('EQU_CONPAG', TProcessoDadosOS.DATA_FIELD_NAME_CON_PAGTO) + ', ';
  Result := Result + '    IF(IFNULL(EQU_CODFPG, "") <> "", CONCAT(EQU_CODFPG, "-", FPG_DESCRI), "") AS ' + TProcessoDadosOS.DATA_FIELD_NAME_FOR_PAGTO + ', ';
  Result := Result + '    DEL_EQUGER.EQU_DESCRI AS ' + TProcessoDadosOS.DATA_FIELD_NAME_OBSERVACOES;
  Result := Result + ' FROM DEL_EQUGER ';
  Result := Result + ' INNER JOIN CADCLI ON DEL_EQUGER.EQU_CODCLI = CADCLI.CLI_CODCLI ';
  Result := Result + ' INNER JOIN CADEQU ON DEL_EQUGER.EQU_CODEQU = CADEQU.EQU_CODIGO ';
  Result := Result + ' LEFT JOIN CADMAR ON CADEQU.EQU_CODMAR = CADMAR.MAR_CODMAR ';
  Result := Result + ' LEFT JOIN CADFPG ON EQU_CODFPG = FPG_CODIGO ';

  Result := Result + fParamsFiltroSql('DEL_');
end;

function TFluxoOrdemServico.fFiltroObservacao(aObserv, APrefix: String): String;
var
  arrPalavrasObserv: TArray<String>;
  strPalavra,
  strTxtObs: String;
begin
  Result := '';

  if (not fEmptyStr(aObserv)) then
  begin
    arrPalavrasObserv := String(aObserv).Split([' ']);

    strTxtObs := '%';

    for strPalavra in arrPalavrasObserv do
      if not strPalavra.Trim.IsEmpty then
        strTxtObs := strTxtObs + strPalavra + '%';

    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_DESCRI LIKE "' + strTxtObs + '") ';
  end;
end;

function TFluxoOrdemServico.fGetSQLCampoEditar: String;
begin
  if (not fCfgSis('FLXEDT', varBoolean)) then
    Result := '    IF(EQU_STATUS IN ("E", "F"), "EDITAR", "") AS '  + TProcessoDadosOS.DATA_FIELD_NAME_EDITAR + ', '
  else
    Result := '    IF((EQU_STATUS IN ("E", "F")) OR (EQU_FLXFAS IN ("M", "R") AND EQU_FLXSIT NOT IN ("FA", "ON", "NF", "OB") AND @JAFATU = 0), "EDITAR", "") AS '  + TProcessoDadosOS.DATA_FIELD_NAME_EDITAR + ', ';
end;

function TFluxoOrdemServico.fGetSQLJaFatu(blnWhere: Boolean = False): String;
begin
  Result := '';

  Result := Result + ' COALESCE((((SELECT DISTINCT FGO_JAFATU FROM FATGOR F WHERE (FGO_NUMDOC = EQU_NUMPED) AND (FGO_ESPDOC = EQU_TIPPED) AND (FGO_CODEMP = EQUGER.EQU_EMPPED)) = 1) ';
  Result := Result + '    OR ((SELECT COUNT(DISTINCT FDO_JAFATU) FROM FATDOR F WHERE (FDO_NUMDOC = EQU_NUMPED) AND (FDO_ESPDOC = EQU_TIPPED) AND (FDO_CODEMP = EQUGER.EQU_EMPPED)) = 2) ';

  if (not blnWhere) then
  begin
    Result := Result + '    OR ((SELECT COUNT(FGO_JAFATU) FROM FATGOR F INNER JOIN EQUGOR ON F.AUTOINCREM = FGO_SEQFGO WHERE (EQUGOR.FGO_SEQEQU = EQUGER.AUTOINCREM) AND (FGO_JAFATU = 1)) > 0) ';
    Result := Result + '    OR ((SELECT COUNT(FDO_JAFATU) FROM FATDOR F INNER JOIN FATGOR FG ON F.FDO_SEQGER = FG.AUTOINCREM INNER JOIN EQUGOR ON FG.AUTOINCREM = FGO_SEQFGO ';
    Result := Result + '    WHERE (EQUGOR.FGO_SEQEQU = EQUGER.AUTOINCREM) AND (FDO_JAFATU = 1)) > 0)) ';
  end
  else
  begin
    Result := Result + '    OR (IFNULL((SELECT 1 FROM FATGOR F INNER JOIN EQUGOR ON F.AUTOINCREM = FGO_SEQFGO WHERE (EQUGOR.FGO_SEQEQU = EQUGER.AUTOINCREM) ';
    Result := Result + '    GROUP BY FGO_SEQEQU HAVING COUNT(FGO_SEQFGO) = COUNT(DISTINCT FGO_JAFATU)), 0) <> 0)) ';
  end;

  Result := Result + '    , 0) ';
end;

function TFluxoOrdemServico.fIndexColumnToProcesso(intItemIndex: Integer): Integer;
begin
  Result := FCxgFluxoTBV.Columns[intItemIndex].Position.BandIndex;
end;

function TFluxoOrdemServico.fParamsFiltroSql(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strNumOSe)) then
  begin
    Result := Result + ' WHERE (' + APrefix + 'EQUGER.EQU_NUMOSE = :NUMOSE)';
    Result := Result + '   AND (' + APrefix + 'EQUGER.EQU_CODEMP = :CODEMP) ';
  end
  else
    Result := fVerificaFiltros(APrefix);
end;

function TFluxoOrdemServico.fSqlFluxo: String;
var
  LstrFXTPVM,
  LstrFXTPAM,
  LstrFXTPVD,
  LstrFXFIVM,
  LstrFXFIAM,
  LstrFXFIVD: String;
begin
  LstrFXTPVM := fCfgSis('FXTPVM', varString);
  LstrFXTPAM := fCfgSis('FXTPAM', varString);
  LstrFXTPVD := fCfgSis('FXTPVD', varString);
  LstrFXFIVM := fCfgSis('FXFIVM', varString);
  LstrFXFIAM := fCfgSis('FXFIAM', varString);
  LstrFXFIVD := fCfgSis('FXFIVD', varString);

  Result := '';

  Result := Result + ' SELECT ';
  Result := Result + '    IF(EQUGER.EQU_PRTATD = "N", 1, 0) AS ORDPROTOC, ';
  Result := Result + '    IF((EQU_GARANT IN ("F", "L")) AND (DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + '), 0, 1) ORDGARANT, ';
  Result := Result + '    EQUGER.AUTOINCREM, ';
  Result := Result + '    IF(EQUGER.EQU_PRTATD = "N", IF(EQUGER.EQU_GARANT = "R", "R", ""), EQUGER.EQU_PRTATD) AS ' + TProcessoNumOS.DATA_FIELD_NAME_STATUSOS + ', ';
  Result := Result + '    IF((EQU_GARANT IN ("F", "L")) AND (DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + '), 1, 0) AS TMPRES, ';
  Result := Result + '    "IMP" AS '                                      + TProcessoDadosOS.DATA_FIELD_NAME_IMP + ', ';
  Result := Result + '    "ETI" AS '                                      + TProcessoDadosOS.DATA_FIELD_NAME_ETI + ', ';
  Result := Result + '    "TRESP" AS '                                    + TProcessoDadosOS.DATA_FIELD_NAME_TRESP + ', ';
  Result := Result + '    "TDEV" AS '                                     + TProcessoDadosOS.DATA_FIELD_NAME_TDEV + ', ';
  Result := Result + '    "ORDEXE" AS '                                   + TProcessoDadosOS.DATA_FIELD_NAME_ORDEXE + ', ';
  Result := Result + '    EQUGER.EQU_NUMOSE AS '                          + TProcessoNumOS.DATA_FIELD_NAME_NUMEROOS + ', ';
  Result := Result + '    EQUGER.EQU_PROTOC AS '                          + TProcessoDadosOS.DATA_FIELD_NAME_PROTOCOLO + ', ';
  Result := Result + '    "CONSULTAR" AS '                                + TProcessoDadosOS.DATA_FIELD_NAME_CONSULTA + ', ';

  Result := Result + '    @JAFATU := ' + fGetSQLJaFatu + ' AS JAFATU, ';
  Result := Result + fGetSQLCampoEditar;

  Result := Result + '    EQUGER.EQU_CODEMP AS '                          + TProcessoDadosOS.DATA_FIELD_NAME_EMP + ', ';
  Result := Result + '    EQUGER.EQU_DTAENT AS '                          + TProcessoDadosOS.DATA_FIELD_NAME_DTINC + ', ';
  Result := Result + '    CONCAT(CLI_CODCLI, " - ", CLI_NOMCLI, ';
  Result := Result + '           IF(IFNULL(EQU_CODFAZ, "") <> "", CONCAT(" - FAZENDA: ", ';
  Result := Result + '             (SELECT FAZ_NOMFAZ FROM CADFAZ WHERE FAZ_CODFAZ = EQU_CODFAZ)), "")) AS ' + TProcessoDadosOS.DATA_FIELD_NAME_CLIENTE + ', ';
  Result := Result + '    CLI_C_G_C_ AS '                                 + TProcessoDadosOS.DATA_FIELD_NAME_CPFCNPJ + ', ';
  Result := Result + '    CADEQU.EQU_DESCRI AS '                          + TProcessoDadosOS.DATA_FIELD_NAME_EQUIPAMENTO + ', ';
  Result := Result + '    MAR_DESMAR AS '                                 + TProcessoDadosOS.DATA_FIELD_NAME_MARCA + ', ';
  Result := Result + '    EQU_NFREME AS '                                 + TProcessoDadosOS.DATA_FIELD_NAME_NFREME + ', ';
  Result := Result + '    "CONSULTAR"                                AS ' + TProcessoDadosOS.DATA_FIELD_NAME_HISTSTATUS + ', ';
  Result := Result + '    "CONSULTAR"                                AS ' + TProcessoDadosOS.DATA_FIELD_NAME_HISTETAPAS + ', ';
  Result := Result + '    "CONSULTAR"                                AS ' + TProcessoDadosOS.DATA_FIELD_NAME_HISTFAT + ', ';

  Result := Result + '    EQUGER.EQU_NOSFAB                                AS ' + TProcessoGarantia.DATA_FIELD_NAME_NOSFAB + ', ';

  if (fCfgSis('EFXTPG', varBoolean)) then
  begin
    Result := Result + '    IF(EQU_GARANT IN ("F", "L"), ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPAM + ', "3", ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXTPVD + ', "2", "1")), "") AS ' + TProcessoGarantia.DATA_FIELD_NAME_STAGAR + ', ';
    Result := Result + '    IF(EQU_GARANT IN ("F", "L"), (' + LstrFXTPVM + ' - DATEDIFF(CURDATE(), EQU_DTAENT)), "") AS ' + TProcessoGarantia.DATA_FIELD_NAME_TMPGAR + ', ';
  end;

  if (fCfgSis('EFXTPF', varBoolean)) then
  begin
    Result := Result + '    IF((EQU_STATUS <> "R") AND (EQU_STATUS <> "N"), IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXFIAM + ', "3", ';
    Result := Result + '    IF(DATEDIFF(CURDATE(), EQU_DTAENT) > ' + LstrFXFIVD + ', "2", "1")), "") AS ' + TProcessoFinalizacaoOS.DATA_FIELD_NAME_STAFIN + ', ';
    Result := Result + '    IF((EQU_STATUS <> "R") AND (EQU_STATUS <> "N"), (' + LstrFXFIVM + ' - DATEDIFF(CURDATE(), EQU_DTAENT)), "") AS ' + TProcessoFinalizacaoOS.DATA_FIELD_NAME_TMPFIN + ', ';
  end;

  if (fCfgSis('TXAUTI', varBoolean)) then
    Result := Result + '    (SELECT FORMAT(IFNULL(SUM(CTR_VALDUP), 0.00), 2, "pt_BR") FROM CADREC WHERE EQUGER.AUTOINCREM = CTR_SEQEQU) AS ' + TProcessoTaxaArmazenamento.DATA_FIELD_NAME_TX_ARM + ', ';

  Result := Result + '    IF((EQU_FLXCOM = "ER") OR (EQU_STATUS = "N"), "REALIZADO", ';
  Result := Result + '    IF((SELECT COUNT(1) FROM MEQMER WHERE MEQMER.MER_AUTEQU = EQUGER.AUTOINCREM AND MEQMER.MER_TIPOPE = "E") > 0, "REALIZADO", "REALIZAR")) AS ' + TProcessoDocsFiscais.DATA_FIELD_NAME_ENT + ', ';
  Result := Result + '    IF((EQU_FLXCOM = "ER" AND EQU_FLXSIT <> "AF"), "REALIZADO", ';
  Result := Result + '    IF((SELECT COUNT(1) FROM MEQMER WHERE MEQMER.MER_AUTEQU = EQUGER.AUTOINCREM AND MEQMER.MER_TIPOPE = "S") > 0, "REALIZADO", "REALIZAR")) AS ' + TProcessoDocsFiscais.DATA_FIELD_NAME_SAI + ', ';
  Result := Result + '    IF((EQU_STATUS = "R") OR (EQU_STATUS = "N"), "REALIZADO", "INCLUIR / REMOVER") AS ' + TProcessoDefPrdSer.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF(EQU_STATUS = "E", "REALIZAR", "REALIZADO") AS ' + TProcessoOrcamento.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF((EQU_STATUS = "E") OR (EQU_STATUS = "F"), "APROVAR", IF(EQU_STATUS = "N", "", "REALIZADO")) AS ' + TProcessoAprovar.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF((EQU_STATUS = "E") OR (EQU_STATUS = "F"), "REPROVAR", IF(EQU_STATUS = "N", "REALIZADO", "")) AS ' + TProcessoReprovar.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF((EQU_STATUS = "R") OR (EQU_STATUS = "N") OR ((EQU_STATUS = "M") AND (EQU_SUBSTA = "C")), "REALIZADO", "REALIZAR") AS ' + TProcessoManutencao.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF((EQU_STATUS = "R") OR (EQU_STATUS = "N"), "", "INCLUIR") AS '                                  + TProcessoApontamento.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF((EQU_STATUS = "R") OR (EQU_STATUS = "N"), "REALIZADO", "REALIZAR") AS ' + TProcessoFinalizar.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF(((EQU_STATUS = "R") OR (EQU_STATUS = "N")) AND (EQU_SUBSTA = "C"), "REALIZADO", "REALIZAR") AS ' + TProcessoRetirar.DATA_FIELD_NAME + ', ';
  Result := Result + '    IF(EQU_DTFIMA IS NULL, 0, 1) AS FINMAN, ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN (EQU_FLXFAS = "M") AND (EQU_FLXSIT = "AR") AND (EQU_STATUS = "R") AND (@JAFATU) THEN "F" ';
  Result := Result + '    ELSE EQU_FLXFAS END FLXFAS, ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN (EQU_FLXSIT = "MF") AND (((EQU_STATUS = "M") AND (EQU_SUBSTA = "C")) OR (EQU_STATUS = "R" AND EQU_SUBSTA = "")) THEN "MF" ';
  Result := Result + '        WHEN (EQU_STATUS = "R") AND (@JAFATU) THEN "FA" ';
  Result := Result + '    ELSE EQU_FLXSIT END FLXSIT, ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN (EQU_FLXFAS = "M") AND (EQU_FLXSIT = "AR") AND (NOT @JAFATU) THEN "AF" ';
  Result := Result + '        WHEN (EQU_FLXCOM = "AR") OR ((EQU_FLXFAS = "M") AND (EQU_FLXSIT = "AR") AND (@JAFATU)) THEN "AR" ';
  Result := Result + '    ELSE EQU_FLXCOM END FLXCOM, EQU_FLXFAS, EQU_FLXSIT, EQU_FLXCOM, ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN EQU_FLXFAS = "A" THEN "OS ABERTA" ';
  Result := Result + '        WHEN EQU_FLXFAS = "T" THEN "ANÁLISE TÉCNICA" ';
  Result := Result + '        WHEN EQU_FLXFAS = "O" THEN "ORÇAMENTO" ';
  Result := Result + '        WHEN EQU_FLXFAS = "R" THEN "OS FINALIZADA" ';
  Result := Result + '        WHEN EQU_FLXFAS = "F" THEN "FATURAMENTO" ';
  Result := Result + '        WHEN EQU_FLXFAS = "M" THEN "MANUTENÇÃO" ';
  Result := Result + '    END ' + TProcessoDadosOS.DATA_FIELD_NAME_STATUS + ', ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN EQU_FLXSIT = "OI" THEN "OS INCLUÍDA" ';
  Result := Result + '        WHEN EQU_FLXSIT = "TC" THEN "ANÁLISE TÉCNICA CONCLUÍDA" ';
  Result := Result + '        WHEN EQU_FLXSIT = "TA" THEN "ANÁLISE TÉCNICA EM ANDAMENTO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "OR" THEN "ORÇAMENTO REALIZADO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "OA" THEN "ORÇAMENTO APROVADO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "ON" THEN "ORÇAMENTO REPROVADO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "EM" THEN "EM MANUTENÇÃO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "AP" THEN "AG. PEÇAS" ';
  Result := Result + '        WHEN EQU_FLXSIT = "AS" THEN "AG. SEPARAÇÃO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "MF" THEN "MANUTENÇÃO FINALIZADA" ';
  Result := Result + '        WHEN EQU_FLXSIT = "AR" THEN "ARMAZENADA" ';
  Result := Result + '        WHEN EQU_FLXSIT = "FA" THEN "FATURADO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "AF" THEN "AG. FATURAMENTO" ';
  Result := Result + '        WHEN EQU_FLXSIT = "NF" THEN "OS NÃO FATURADA" ';
  Result := Result + '        WHEN EQU_FLXSIT = "OB" THEN "OS BAIXADA - DESISTÊNCIA" ';
  Result := Result + '    END ' + TProcessoDadosOS.DATA_FIELD_NAME_SITUACAO + ', ';
  Result := Result + '    CASE ';
  Result := Result + '        WHEN EQU_FLXCOM = "AT" THEN "AG. ANÁLISE TÉCNICA" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AO" THEN "AG. ORÇAMENTO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AE" THEN "AG. ENVIO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "PF" THEN "AG. ENVIO - PEÇAS FALTANTES" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AC" THEN "ENVIADO - AG. CLIENTE" ';
  Result := Result + '        WHEN EQU_FLXCOM = "OI" THEN "ORÇAMENTO INTERROMPIDO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AA" THEN "AG. ARMAZENAMENTO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "RC" THEN "REPROVAÇÃO CANCELADA" ';
  Result := Result + '        WHEN EQU_FLXCOM = "ER" THEN "EQUIPAMENTO RETIRADO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AM" THEN "AG. MANUTENÇÃO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "MI" THEN "MANUTENÇÃO INTERROMPIDA" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AF" THEN "AG. FATURAMENTO" ';
  Result := Result + '        WHEN EQU_FLXCOM = "AR" THEN "AG. RETIRADA DO EQUIPAMENTO" ';
  Result := Result + '    END ' + TProcessoDadosOS.DATA_FIELD_NAME_COMPLEMENTO + ', ';
  Result := Result + '    (SELECT IFNULL(MRE_DESCRI, "") FROM CADMRE WHERE EQU_CODMRE = MRE_CODIGO) AS ' + TProcessoDadosOS.DATA_FIELD_NAME_MOTREPR + ', ';
  Result := Result + '    EQU_SITDTR AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DTENTR_EQUIP + ', ';
  Result := Result + '    (SELECT CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) FROM CADOPE WHERE OPE_CODOPE = EQU_DIGRET) AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DIG_ENTREG + ', ';
  Result := Result + '    EQU_DTFIMA AS ' + TProcessoDadosOS.DATA_FIELD_NAME_DTFIN_MAN + ', ';
  Result := Result + '    ' + fFormataCondPagSQL('EQU_CONPAG', TProcessoDadosOS.DATA_FIELD_NAME_CON_PAGTO) + ', ';
  Result := Result + '    IF(IFNULL(EQU_CODFPG, "") <> "", CONCAT(EQU_CODFPG, "-", FPG_DESCRI), "") AS ' + TProcessoDadosOS.DATA_FIELD_NAME_FOR_PAGTO + ', ';
  Result := Result + '    EQUGER.EQU_DESCRI AS ' + TProcessoDadosOS.DATA_FIELD_NAME_OBSERVACOES;
  Result := Result + ' FROM EQUGER ';
  Result := Result + ' INNER JOIN CADCLI ON EQUGER.EQU_CODCLI = CADCLI.CLI_CODCLI ';
  Result := Result + ' INNER JOIN CADEQU ON EQUGER.EQU_CODEQU = CADEQU.EQU_CODIGO ';
  Result := Result + ' LEFT JOIN CADMAR ON CADEQU.EQU_CODMAR = CADMAR.MAR_CODMAR ';
  Result := Result + ' LEFT JOIN CADFPG ON EQU_CODFPG = FPG_CODIGO ';

  if (not FblnFiltro) then
  begin
    Result := Result + fCarregaSemFiltro;

    if (not fCfgSis('MAOSEM', varBoolean)) then
      Result := Result + '     AND EQUGER.EQU_CODEMP = :CODEMP ';
  end
  else
  begin
    if (not fEmptyStr(FFiltros.strStatus)) or (not fEmptyStr(FFiltros.strNumOSe)) then
    begin
      Result := Result + fParamsFiltroSql;
    end
    else
      Result := '';

    pValidaFiltroCancelada(Result);
  end;

  Result := Result + ' ORDER BY 1, ';

  if (fCfgSis('EFXTPG', varBoolean)) then
    Result := Result + '     2, ';

  Result := Result + '     9, 12 ';
end;

function TFluxoOrdemServico.fVerificaFiltros(APrefix: String): String;
begin
  Result := Result + ' WHERE (' + APrefix + 'EQUGER.EQU_DTAENT >= :DTAINI AND ' + APrefix + 'EQUGER.EQU_DTAENT <= :DTAFIN)';

  Result := Result + fVerificaFiltrosCodEmp(APrefix);
  Result := Result + fVerificaFiltrosProtoc(APrefix);
  Result := Result + fVerificaFiltrosNOSFab(APrefix);
  Result := Result + fVerificaFiltrosCodCli(APrefix);
  Result := Result + fVerificaFiltrosDocCli(APrefix);
  Result := Result + fVerificaFiltrosPedCmp(APrefix);
  Result := Result + fVerificaFiltrosCodVen(APrefix);
  Result := Result + fVerificaFiltrosCodMar(APrefix);
  Result := Result + fVerificaFiltrosCodEqu(APrefix);
  Result := Result + fVerificaFiltrosNSerie(APrefix);
  Result := Result + fVerificaFiltrosNumPat(APrefix);
  Result := Result + fVerificaFiltrosDocEnt(APrefix);

  Result := Result + fFiltroObservacao(FFiltros.strObserv, APrefix);
  Result := Result + ' AND (' + FFiltros.strGarant + ') ';

  if fEmptyStr(APrefix) then
    Result := Result + ' AND (' + FFiltros.strStatus + ') ';
end;

function TFluxoOrdemServico.fVerificaFiltrosCodCli(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strCodCli)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_CODCLI = :CODCLI) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosCodEmp(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strCodEmp)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_CODEMP = :CODEMP) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosCodEqu(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strCodEqu)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_CODEQU = :CODEQU) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosCodMar(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strCodMar)) then
    Result := Result + ' AND (CADMAR.MAR_CODMAR = :CODMAR) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosCodVen(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strCodVen)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_CODVEN = :CODVEN) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosDocCli(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strDocCli)) then
    Result := Result + ' AND (CLI_C_G_C_ = :DOCCLI) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosDocEnt(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strDocEnt)) then
  begin
    Result := Result + ' AND EXISTS (SELECT 1 FROM ' + APrefix + 'MEQMER ';
    Result := Result + '             WHERE ' + APrefix + 'EQUGER.AUTOINCREM = ' + APrefix + 'MEQMER.MER_AUTEQU ';
    Result := Result + '               AND ' + APrefix + 'MEQMER.MER_TIPOPE = "E" ';
    Result := Result + '               AND ' + APrefix + 'MEQMER.MER_NUMDOC = :DOCENT ';
    Result := Result + '               AND ' + APrefix + 'MEQMER.MER_ESPDOC = :ESPENT ';
    Result := Result + '               AND ' + APrefix + 'MEQMER.MER_EMPGER = :EMPENT) ';
  end;
end;

function TFluxoOrdemServico.fVerificaFiltrosNOSFab(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strNOSFab)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_NOSFAB = :NOSFAB) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosNSerie(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strNSerie)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_NSERIE = :NSERIE) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosNumPat(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strNumPat)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_NUMPAT = :NUMPAT) ';
end;

function TFluxoOrdemServico.fVerificaFiltrosPedCmp(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strPedCmp)) then
  begin
    Result := Result + ' AND (EXISTS (SELECT E.AUTOINCREM ';
    Result := Result + '             FROM ' + APrefix + 'EQUGER E ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'FATGOR F ON (E.EQU_NUMPED = FGO_NUMDOC AND E.EQU_TIPPED = FGO_ESPDOC AND E.EQU_EMPPED = FGO_CODEMP) ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'MOVRCD M ON (FGO_NUMDOC = RCD_DOCPDV AND FGO_ESPDOC = RCD_ESPPDV AND FGO_CODEMP = RCD_EMPPDV) ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'PCMDET P ON P.AUTOINCREM = RCD_SEQPCD ';
    Result := Result + '             WHERE E.AUTOINCREM = ' + APrefix + 'EQUGER.AUTOINCREM ';
    Result := Result + '               AND P.PCD_NUMPED = :PEDCMP ';
    Result := Result + '             UNION ';
    Result := Result + '             SELECT E.AUTOINCREM ';
    Result := Result + '             FROM ' + APrefix + 'EQUGER E ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'EQUGOR EG ON E.AUTOINCREM = FGO_SEQEQU ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'FATGOR F ON (FGO_SEQFGO = F.AUTOINCREM) ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'MOVRCD M ON (FGO_NUMDOC = RCD_DOCPDV AND FGO_ESPDOC = RCD_ESPPDV AND FGO_CODEMP = RCD_EMPPDV) ';
    Result := Result + '             LEFT JOIN ' + APrefix + 'PCMDET P ON P.AUTOINCREM = RCD_SEQPCD ';
    Result := Result + '             WHERE E.AUTOINCREM = ' + APrefix + 'EQUGER.AUTOINCREM ';
    Result := Result + '               AND P.PCD_NUMPED = :PEDCMP)) ';
  end;
end;

function TFluxoOrdemServico.fVerificaFiltrosProtoc(APrefix: String): String;
begin
  Result := '';

  if (not fEmptyStr(FFiltros.strProtoc)) then
    Result := Result + ' AND (' + APrefix + 'EQUGER.EQU_PROTOC = :PROTOC) ';
end;

function TFluxoOrdemServico.fVerificaPDComReqEmAbertoComPedidoDeCompra(
  strNumDoc, strEspDoc, strCodEmp: String): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE                              ';
    strSQL := strSQL + '     CONCAT(F.FDO_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI,';
    strSQL := strSQL + '     CONCAT(F.FDO_CODVEN, "-", O.OPE_NOMOPE) AS NOMVEN,';
    strSQL := strSQL + '     CONCAT(F.FDO_NUMDOC, "-", F.FDO_ESPDOC, "-", F.FDO_CODEMP) AS PEDVEN,';
    strSQL := strSQL + '     F.FDO_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '     CONCAT(F.FDO_CODITE, "-", F.FDO_DESCRI) AS DESITE,';
    strSQL := strSQL + '     U.UNI_SIGUNI AS UNIDAD,                        ';
    strSQL := strSQL + '     F.FDO_QTDITE AS QTDITE,                        ';
    strSQL := strSQL + '     CONCAT(M.RCD_CODIGO, "-", M.RCD_CODEMP) AS NUMREQ,';
    strSQL := strSQL + '     M.RCD_CODIGO, M.RCD_CODEMP,                    ';
    strSQL := strSQL + '     M.RCD_QTDITE AS QTDREQ,                        ';
    strSQL := strSQL + '     (SELECT IFNULL(SUM(BAI_QTDREQ), 0) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS QTDBAI,';
    strSQL := strSQL + '      CONCAT(P.PCD_NUMPED, "-", P.PCD_ESPDOC, "-", P.PCD_CODEMP) AS NUMCOM,';
    strSQL := strSQL + '     P.PCD_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '     (SELECT GROUP_CONCAT(CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP))';
    strSQL := strSQL + '      FROM BAIREQ                                 ';
    strSQL := strSQL + '      INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET';
    strSQL := strSQL + '      WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS,   ';
    strSQL := strSQL + '     C.CLI_C_G_C_ ';
    strSQL := strSQL + ' FROM FATDOR F ';

    if fCfgSis('SLTFRC', varBoolean) then
    begin
      strSQL := strSQL + ' JOIN FDOABS A ON F.AUTOINCREM = A.ABS_SEQFDO ';
      strSQL := strSQL + ' JOIN PREPRQ Q ON A.ABS_SEQPRQ = Q.AUTOINCREM ';
    end;

    strSQL := strSQL + ' JOIN CADCLI C ON C.CLI_CODCLI = F.FDO_CODCLI ';
    strSQL := strSQL + ' JOIN MOVRCD M ON F.FDO_NUMDOC = M.RCD_DOCPDV ';
    strSQL := strSQL + '                AND F.FDO_ESPDOC = M.RCD_ESPPDV ';
    strSQL := strSQL + '                AND F.FDO_CODEMP = M.RCD_EMPPDV ';
    strSQL := strSQL + '                AND F.FDO_CODITE = M.RCD_CODITE ';
    strSQL := strSQL + ' LEFT JOIN CADUNI U ON F.FDO_UNIDAD = U.UNI_CODUNI';
    strSQL := strSQL + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = F.FDO_CODVEN';
    strSQL := strSQL + ' INNER JOIN PCMDET P ON P.AUTOINCREM = RCD_SEQPCD';
    strSQL := strSQL + ' WHERE F.FDO_NUMDOC = :NUMDOC                    ';
    strSQL := strSQL + '     AND F.FDO_ESPDOC = :ESPDOC                    ';
    strSQL := strSQL + '     AND F.FDO_CODEMP = :CODEMP                    ';
    strSQL := strSQL + '     AND IFNULL(PCD_BAIXAD, 0) = 0                 ';
    strSQL := strSQL + '     AND RCD_REQNEG <> "S"                         ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    Result := (not qryAux.IsEmpty);
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFluxoOrdemServico.fVerificaPDComReqEmAbertoSemPedidoDeCompra(
  strNumDoc, strEspDoc, strCodEmp: String): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE                              ';
    strSQL := strSQL + '     CONCAT(F.FDO_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI,';
    strSQL := strSQL + '     CONCAT(F.FDO_CODVEN, "-", O.OPE_NOMOPE) AS NOMVEN,';
    strSQL := strSQL + '     CONCAT(F.FDO_NUMDOC, "-", F.FDO_ESPDOC, "-", F.FDO_CODEMP) AS PEDVEN,';
    strSQL := strSQL + '     F.FDO_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '     CONCAT(F.FDO_CODITE, "-", F.FDO_DESCRI) AS DESITE,';
    strSQL := strSQL + '     U.UNI_SIGUNI AS UNIDAD,                        ';
    strSQL := strSQL + '     F.FDO_QTDITE AS QTDITE,                        ';
    strSQL := strSQL + '     M.RCD_CODIGO AS NUMREQ,                        ';
    strSQL := strSQL + '     M.RCD_CODIGO, M.RCD_CODEMP,                    ';
    strSQL := strSQL + '     M.RCD_QTDITE AS QTDREQ,                        ';
    strSQL := strSQL + '     (SELECT IFNULL(SUM(BAI_QTDREQ), 0) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS QTDBAI,';
    strSQL := strSQL + '      CONCAT(P.PCD_NUMPED, "-", P.PCD_ESPDOC, "-", P.PCD_CODEMP) AS NUMCOM,';
    strSQL := strSQL + '     P.PCD_DTAENT AS DTAENT,                        ';
    strSQL := strSQL + '     (SELECT GROUP_CONCAT(CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP))';
    strSQL := strSQL + '      FROM BAIREQ                                 ';
    strSQL := strSQL + '      INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET';
    strSQL := strSQL + '      WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS    ';
    strSQL := strSQL + ' FROM FATDOR F  ';

    if fCfgSis('SLTFRC', varBoolean) then
    begin
      strSQL := strSQL + ' JOIN FDOABS A ON F.AUTOINCREM = A.ABS_SEQFDO ';
      strSQL := strSQL + ' JOIN PREPRQ Q ON A.ABS_SEQPRQ = Q.AUTOINCREM ';
    end;

    strSQL := strSQL + ' JOIN CADCLI C ON C.CLI_CODCLI = F.FDO_CODCLI   ';
    strSQL := strSQL + ' JOIN MOVRCD M ON F.FDO_NUMDOC = M.RCD_DOCPDV ';
    strSQL := strSQL + '       AND F.FDO_ESPDOC = M.RCD_ESPPDV ';
    strSQL := strSQL + '       AND F.FDO_CODEMP = M.RCD_EMPPDV ';
    strSQL := strSQL + '       AND F.FDO_CODITE = M.RCD_CODITE ';
    strSQL := strSQL + ' LEFT JOIN CADUNI U ON F.FDO_UNIDAD = U.UNI_CODUNI';
    strSQL := strSQL + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = F.FDO_CODVEN';
    strSQL := strSQL + ' LEFT JOIN PCMDET P ON P.AUTOINCREM = RCD_SEQPCD';
    strSQL := strSQL + ' WHERE F.FDO_NUMDOC = :NUMDOC                    ';
    strSQL := strSQL + ' AND F.FDO_ESPDOC = :ESPDOC                    ';
    strSQL := strSQL + ' AND F.FDO_CODEMP = :CODEMP                    ';
    strSQL := strSQL + ' AND IFNULL(PCD_BAIXAD, 0) = 0                 ';
    strSQL := strSQL + ' AND RCD_REQNEG <> "S" AND P.PCD_NUMPED IS NULL ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open();

    Result := (not qryAux.IsEmpty);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TFluxoOrdemServico.pAtualizaDados(AVerificaStatus: Boolean = False);
begin
  FVerificaStatus := AVerificaStatus;
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Aguarde, Carregando Ordens de Serviço...';
    frmGravando.fExecutarAcao := fAtualizar;
    frmGravando.ShowModal;
  finally
    FVerificaStatus := False;
    FreeAndNil(frmGravando);
  end;
end;

procedure TFluxoOrdemServico.pCancelarOrdemServico;
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (FCdsFluxo.FieldByName('STATUS').AsString = 'REPROVADA') then
  begin
    pMensagemOK('O.S. reprovada não pode ser cancelada!');
    Exit;
  end;

  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso   := True;
    frmFatManConsertoEquip.strFlxNovaCancelar := 'C';
    frmFatManConsertoEquip.edtNumero.Text     := FCdsFluxo.FieldByName('NUMERO_OS').AsString;
    frmFatManConsertoEquip.edtCodEmp.Text     := FCdsFluxo.FieldByName('EMP').AsString;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados();
  end;
end;

procedure TFluxoOrdemServico.pCarregaFiltroCodCli;
begin
  if (not fEmptyStr(FFiltros.strCodCli)) then
    FCdsFluxo.qryQuery.ParamByName('CODCLI').AsString := FFiltros.strCodCli;
end;

procedure TFluxoOrdemServico.pCarregaFiltroCodEmp;
begin
  if (not fEmptyStr(FFiltros.strCodEmp)) then
    FCdsFluxo.qryQuery.ParamByName('CODEMP').AsString := FFiltros.strCodEmp;
end;

procedure TFluxoOrdemServico.pCarregaFiltroDocCli;
begin
  if (not fEmptyStr(FFiltros.strDocCli)) then
    FCdsFluxo.qryQuery.ParamByName('DOCCLI').AsString := FFiltros.strDocCli;
end;

procedure TFluxoOrdemServico.pCarregaFiltroDocEnt;
begin
  if (not fEmptyStr(FFiltros.strDocEnt)) then
  begin
    FCdsFluxo.qryQuery.ParamByName('DOCENT').AsString := FFiltros.strDocEnt;
    FCdsFluxo.qryQuery.ParamByName('ESPENT').AsString := FFiltros.strEspEnt;
    FCdsFluxo.qryQuery.ParamByName('EMPENT').AsString := FFiltros.strEmpEnt;
  end;
end;

procedure TFluxoOrdemServico.pCarregaFiltroCodEqu;
begin
  if (not fEmptyStr(FFiltros.strCodEqu)) then
    FCdsFluxo.qryQuery.ParamByName('CODEQU').AsString := FFiltros.strCodEqu;
end;

procedure TFluxoOrdemServico.pCarregaFiltroCodMar;
begin
  if (not fEmptyStr(FFiltros.strCodMar)) then
    FCdsFluxo.qryQuery.ParamByName('CODMAR').AsString := FFiltros.strCodMar;
end;

procedure TFluxoOrdemServico.pCarregaFiltroCodVen;
begin
  if (not fEmptyStr(FFiltros.strCodVen)) then
    FCdsFluxo.qryQuery.ParamByName('CODVEN').AsString := FFiltros.strCodVen;
end;

procedure TFluxoOrdemServico.pCarregaFiltroNOSFab;
begin
  if (not fEmptyStr(FFiltros.strNOSFab)) then
    FCdsFluxo.qryQuery.ParamByName('NOSFAB').AsString := FFiltros.strNOSFab;
end;

procedure TFluxoOrdemServico.pCarregaFiltroNSerie;
begin
  if (not fEmptyStr(FFiltros.strNSerie)) then
    FCdsFluxo.qryQuery.ParamByName('NSERIE').AsString := FFiltros.strNSerie;
end;

procedure TFluxoOrdemServico.pCarregaFiltroNumPat;
begin
  if (not fEmptyStr(FFiltros.strNumPat)) then
    FCdsFluxo.qryQuery.ParamByName('NUMPAT').AsString := FFiltros.strNumPat;
end;

procedure TFluxoOrdemServico.pCarregaFiltroPedCmp;
begin
  if (not fEmptyStr(FFiltros.strPedCmp)) then
    FCdsFluxo.qryQuery.ParamByName('PEDCMP').AsString := FFiltros.strPedCmp;
end;

procedure TFluxoOrdemServico.pCarregaFiltroProtoc;
begin
  if (not fEmptyStr(FFiltros.strProtoc)) then
    FCdsFluxo.qryQuery.ParamByName('PROTOC').AsString := FFiltros.strProtoc;
end;

procedure TFluxoOrdemServico.pCarregaFiltros;
begin
  if fCarregaFiltroNumOSe then
    Exit;

  FCdsFluxo.qryQuery.ParamByName('DTAINI').AsDateTime := FFiltros.dtaCadIni;
  FCdsFluxo.qryQuery.ParamByName('DTAFIN').AsDateTime := FFiltros.dtaCadFin;

  pCarregaFiltroCodEmp;
  pCarregaFiltroProtoc;
  pCarregaFiltroNOSFab;
  pCarregaFiltroCodCli;
  pCarregaFiltroDocCli;
  pCarregaFiltroPedCmp;
  pCarregaFiltroCodVen;
  pCarregaFiltroCodMar;
  pCarregaFiltroCodEqu;
  pCarregaFiltroNSerie;
  pCarregaFiltroNumPat;
  pCarregaFiltroDocEnt;
end;

procedure TFluxoOrdemServico.pCarregaProcessos;
var
  intCont: integer;
begin
  pValidaDireitosAcessoProcessos;

  for intCont := 0 to Pred(FProcessos.Count) do
  begin
    FProcessos[intCont].objComum.OnAposRealizar := pAtualizaDados;
    FProcessos[intCont].cxEditRepositoryImageComboBoxItem      := FEditRepositoryImageComboBoxItem;
    FProcessos[intCont].cxEditRepositoryTextItem               := FEditRepositoryTextItem;
    FProcessos[intCont].cxEditRepositoryMemoItem               := FEditRepositoryMemoItem;

    if intCont > 0 then
      FProcessos[intCont].objComum.objProcessoComumAnterior    := FProcessos[intCont -1].objComum;

    if intCont > 1 then
      FProcessos[intCont].objComum.objProcessoComumAntAnterior  := FProcessos[intCont -2].objComum;

    if intCont > 2 then
      FProcessos[intCont].objComum.objProcessoComumAntAnterior2  := FProcessos[intCont -3].objComum;

    if intCont < Pred(FProcessos.Count) then
      FProcessos[intCont].objComum.objProcessoComumSeguinte    := FProcessos[intCont +1].objComum;
  end;
end;

procedure TFluxoOrdemServico.pChamadaDocsFiscais(aTipoDoc: TTipoDocsFiscaisFlxConEqu);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.tpDocsFiscaisFlx              := aTipoDoc;
    frmFatManConsertoEquip.blnFluxoProcesso              := True;
    frmFatManConsertoEquip.tpProcessoFlx                 := tprDocsFiscais;
    frmFatManConsertoEquip.edtNumero.Text                := FCdsFluxo.FieldByName('NUMERO_OS').AsString;
    frmFatManConsertoEquip.edtCodEmp.Text                := FCdsFluxo.FieldByName('EMP').AsString;
    frmFatManConsertoEquip.tbsAcessorios.TabVisible      := False;
    frmFatManConsertoEquip.tbsDefeitos.TabVisible        := False;
    frmFatManConsertoEquip.tbsProdutos.TabVisible        := False;
    frmFatManConsertoEquip.tbsServicos.TabVisible        := False;
    frmFatManConsertoEquip.tbsApontamentos.TabVisible    := False;
    frmFatManConsertoEquip.tbsHistEquipamento.TabVisible := False;
    frmFatManConsertoEquip.btnRealizada.Visible          := False;
    frmFatManConsertoEquip.btnImprimir.Visible           := False;
    frmFatManConsertoEquip.btnTermoDev.Visible           := False;
    frmFatManConsertoEquip.btnAlteracao.Visible          := False;
    frmFatManConsertoEquip.btnEndEnt.Visible             := False;
    frmFatManConsertoEquip.btnDesEsp.Visible             := False;
    frmFatManConsertoEquip.btnReprovar.Visible           := False;
    frmFatManConsertoEquip.btnAprovada.Visible           := False;
    frmFatManConsertoEquip.btnCancelar.Visible           := False;
    frmFatManConsertoEquip.btnObservacao.Visible         := False;
    frmFatManConsertoEquip.btnManutencao.Visible         := False;
    frmFatManConsertoEquip.btnHisSta.Visible             := False;
    frmFatManConsertoEquip.btnSalRes.Visible             := False;
    frmFatManConsertoEquip.btnImpostos.Visible           := False;
    frmFatManConsertoEquip.btnAddObsTec.Visible          := False;
    frmFatManConsertoEquip.btnImpEti.Visible             := False;
    frmFatManConsertoEquip.btnReativar.Visible           := False;
    frmFatManConsertoEquip.btnUltimasVendas.Visible      := False;
    frmFatManConsertoEquip.btnComunicacaoInterna.Visible := True;
    frmFatManConsertoEquip.btnApontHoras.Visible         := True;
    frmFatManConsertoEquip.edtNumero.Enabled             := False;
    frmFatManConsertoEquip.btnAlteraItens.Visible        := False;
    frmFatManConsertoEquip.btnBrindeTotalServ.Visible    := False;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados;
  end;
end;

procedure TFluxoOrdemServico.pChamaManConsertoEquip(aProcesso: TTipoProcessosFlxConEqu; AstrNumOSe: String = ''; AstrCodEmp: String = '');
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (not FbtnApontamento.Visible) and (not FbtnApontamento.Enabled) then
    Exit;

  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso := True;
    frmFatManConsertoEquip.tpProcessoFlx    := aProcesso;
    frmFatManConsertoEquip.edtNumero.Text   := IIF((fEmptyStr(AstrNumOSe)), FCdsFluxo.FieldByName('NUMERO_OS').AsString, AstrNumOSe);
    frmFatManConsertoEquip.edtCodEmp.Text   := IIF((fEmptyStr(AstrCodEmp)), FCdsFluxo.FieldByName('EMP').AsString, AstrCodEmp);
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados;
  end;
end;

procedure TFluxoOrdemServico.pCriaColunasCxgFluxo;
var
  intCount: integer;
  cxBand  : TcxGridBand;
begin
  if not Assigned(FCxgFluxoTBV) then
    exit;

  for intCount := 0 to Pred(FProcessos.Count) do
  begin
    cxBand := FCxgFluxoTBV.Bands.Add;
    cxBand.Caption := FProcessos[intCount].objComum.strTitulo;
    FProcessos[intCount].pConfiguraColumn(FCxgFluxoTBV, cxBand.Index);
  end;
end;

procedure TFluxoOrdemServico.pExecutaTimer(Sender: TObject);
var
  intProcesso: Integer;
  strColuna,
  strValor   : String;
begin
  FTimerExecuta.Enabled := False;

  if (FProcessos.Count = 0) then
    Exit;

  if not FCdsFluxo.isEmpty then
  begin
    try
      intProcesso := fIndexColumnToProcesso(FCxgFluxoTBV.Controller.FocusedColumn.Index);

      If FProcessos[intProcesso].objComum.fColunaSoDisplay(FCxgFluxoTBV.Controller.FocusedColumn.Index) Then
        Exit;

      FProcessos[intProcesso].objComum.
        pExecuta(FCdsFluxo.FieldByName(TcxGridDBBandedColumn(FCxgFluxoTBV.Controller.FocusedColumn).DataBinding.FieldName).AsString,
                 FCdsFluxo.FieldByName('NUMERO_OS').AsString, FCdsFluxo.FieldByName('EMP').AsString,
                 TcxGridDBBandedColumn(FCxgFluxoTBV.Controller.FocusedColumn).DataBinding.FieldName);

      strColuna := TcxGridDBBandedColumn(FCxgFluxoTBV.Controller.FocusedColumn).DataBinding.FieldName;
      strValor  := FCdsFluxo.FieldByName(TcxGridDBBandedColumn(FCxgFluxoTBV.Controller.FocusedColumn).DataBinding.FieldName).AsString;

      if (strColuna = 'CONSULTA_OS') or ((strColuna = 'EDITAR_OS') and (not fEmptyStr(strValor))) then
        pAtualizaDados;
    Except
      On E: ExceptionMessage do
        pMensagemOK(E.Message);
    end;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaAnaliseTec;
begin
  FbtnAnaliseTec.Caption    := '[F2] Realizar Análise Técnica';
  FbtnAnaliseTec.PaintStyle := bpsCaption;
  FbtnAnaliseTec.Enabled    := (fVerificaAcessoSistema('FLXDPS', strLoginUsuarioLogado))
    and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AT') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'OI')
    or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'MI'));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AT') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'OI') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'MI') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'A') then
  begin
    FbtnAnaliseTec.Enabled     := True;
    FbtnAnaliseTec.Caption := 'Análise Técnica Realizada';
    FbtnAnaliseTec.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaAprovar;
begin
  FbtnAprovar.Caption    := '[F7] Aprovar';
  FbtnAprovar.PaintStyle := bpsCaption;
  FbtnAprovar.Enabled    := (fVerificaAcessoSistema('FLXAPR', strLoginUsuarioLogado))
    and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AC') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'RC'));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'A') and
    (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'T') and
    (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'O') and
    (FcdsFluxo.FieldByName('FLXSIT').AsString <> 'OR') and
    (FcdsFluxo.FieldByName('FLXSIT').AsString <> 'ON') then
  begin
    FbtnAprovar.Enabled    := True;
    FbtnAprovar.Caption    := 'Aprovado';
    FbtnAprovar.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaArmazenar;
begin
  FbtnArmazenar.Caption    := '[F11] Realizar Armazenamento';
  FbtnArmazenar.PaintStyle := bpsCaption;
  FbtnArmazenar.Enabled    := (fVerificaAcessoSistema('FLXFIN', strLoginUsuarioLogado))
    and (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AA');

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AR') or
    (((FcdsFluxo.FieldByName('FLXSIT').AsString = 'ON') or
    (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') or
    (FcdsFluxo.FieldByName('FLXSIT').AsString = 'FA')) and (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AR')) then
  begin
    FbtnArmazenar.Enabled    := True;
    FbtnArmazenar.Caption    := 'Armazenado';
    FbtnArmazenar.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaEnviarCliente;
begin
  FbtnEnviarCliente.Caption    := '[F4] Enviar para o Cliente';
  FbtnEnviarCliente.PaintStyle := bpsCaption;
  FbtnEnviarCliente.Enabled    := (fVerificaAcessoSistema('FLXENV', strLoginUsuarioLogado))
    and (FcdsFluxo.FieldByName('FLXFAS').AsString = 'O') and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AE') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'PF'));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'A') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'T') then
    Exit;

  if (not fValidaOrcEnviadoCliente) then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  FbtnEnviarCliente.Enabled    := True;
  FbtnEnviarCliente.Caption    := 'Enviado para o Cliente';
  FbtnEnviarCliente.PaintStyle := bpsDefault;
end;

procedure TFluxoOrdemServico.pHabilitaManutencao;
begin
  FbtnManutencao.Caption    := '[F10] Finalizar Manutenção';
  FbtnManutencao.PaintStyle := bpsCaption;
  FbtnManutencao.Enabled    := (fVerificaAcessoSistema('FLXMAN', strLoginUsuarioLogado))
    and (FcdsFluxo.FieldByName('FLXFAS').AsString = 'M') and ((FcdsFluxo.FieldByName('FLXSIT').AsString = 'EM')
    or ((fVerificaAcessoSistema('FXRMAP', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AP'))
    or ((fVerificaAcessoSistema('FXRMAS', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AS')));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'MF') or
    ((FcdsFluxo.FieldByName('FLXFAS').AsString = 'M') and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AR')) or
    (FcdsFluxo.FieldByName('FLXSIT').AsString = 'FA') then
  begin
    FbtnManutencao.Enabled    := True;
    FbtnManutencao.Caption    := 'Manutenção Finalizada';
    FbtnManutencao.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaOrcamento;
begin
  FbtnOrcamento.Caption    := '[F3] Realizar Orçamento';
  FbtnOrcamento.PaintStyle := bpsCaption;
  FbtnOrcamento.Enabled    := (fVerificaAcessoSistema('FLXORC', strLoginUsuarioLogado))
    and (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AO');

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'A') and (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'T') then
  begin
    FbtnOrcamento.Enabled    := True;
    FbtnOrcamento.Caption    := 'Orçamento Realizado';
    FbtnOrcamento.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaRealizarMan;
begin
  FbtnRealizarMan.Caption    := '[F9] Realizar Manutenção';
  FbtnRealizarMan.PaintStyle := bpsCaption;
  FbtnRealizarMan.Enabled    := (fVerificaAcessoSistema('FLXRMA', strLoginUsuarioLogado))
    and (fCfgSis('FLXTEC', varBoolean)) and (FcdsFluxo.FieldByName('FLXFAS').AsString = 'M') and ((FcdsFluxo.FieldByName('FLXSIT').AsString = 'EM')
    or ((fVerificaAcessoSistema('FXRMAP', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AP'))
    or ((fVerificaAcessoSistema('FXRMAS', strLoginUsuarioLogado)) and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AS')));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXSIT').AsString = 'OB') then
    Exit;

  if (fCfgSis('FLXTEC', varBoolean)) and ((FcdsFluxo.FieldByName('FLXSIT').AsString = 'MF') or
    (FcdsFluxo.FieldByName('FINMAN').AsInteger = 1) or
    ((FcdsFluxo.FieldByName('FLXFAS').AsString = 'M') and (FcdsFluxo.FieldByName('FLXSIT').AsString = 'AR')) or
    (FcdsFluxo.FieldByName('FLXSIT').AsString = 'FA')) then
  begin
    FbtnRealizarMan.Enabled    := True;
    FbtnRealizarMan.Caption    := 'Manutenção Realizada';
    FbtnRealizarMan.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaReprovar;
begin
  FbtnReprovar.Caption    := '[F8] Reprovar';
  FbtnReprovar.PaintStyle := bpsCaption;
  FbtnReprovar.Enabled    := (fVerificaAcessoSistema('FLXREP', strLoginUsuarioLogado))
    and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AC') or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'RC'));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'RC') then
    Exit;

  if ((FcdsFluxo.FieldByName('FLXFAS').AsString = 'R') and (FcdsFluxo.FieldByName('FLXSIT').AsString <> 'ON')) then
    Exit;

  if (not ((FcdsFluxo.FieldByName('FLXFAS').AsString = 'O') and (FcdsFluxo.FieldByName('FLXSIT').AsString <> 'ON'))) and
    ((FcdsFluxo.FieldByName('FLXFAS').AsString <> 'A') and
    (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'T') and
    (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'M') and
    (FcdsFluxo.FieldByName('FLXFAS').AsString <> 'F') and
    (FcdsFluxo.FieldByName('FLXSIT').AsString <> 'FA')) then
  begin
    FbtnReprovar.Enabled    := True;
    FbtnReprovar.Caption    := 'Reprovado';
    FbtnReprovar.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pHabilitaRetirar;
begin
  FbtnRetirar.Caption    := '[F12] Realizar Entrega do Equipamento';
  FbtnRetirar.PaintStyle := bpsCaption;
  FbtnRetirar.Enabled    := (fVerificaAcessoSistema('FLXRET', strLoginUsuarioLogado)) and ((FcdsFluxo.FieldByName('FLXCOM').AsString = 'AR')
    or (FcdsFluxo.FieldByName('FLXCOM').AsString = 'AF'));

  if (FcdsFluxo.FieldByName('FLXFAS').AsString = 'C') then
    Exit;

  if (FcdsFluxo.FieldByName('FLXCOM').AsString = 'ER') then
  begin
    FbtnRetirar.Enabled    := True;
    FbtnRetirar.Caption    := 'Equipamento Retirado';
    FbtnRetirar.PaintStyle := bpsDefault;
  end;
end;

procedure TFluxoOrdemServico.pInsereLogFlxOS(ANumOSe, ACodEmp, AFlxFasAnt,
  AFlxSitAnt, AFlxComAnt, AFlxFas, AFlxSit, AFlxCom: String);
const
  LSQL = 'INSERT INTO LOGFLX (AUTOINCREM, LOG_DTALOG, LOG_HORLOG, LOG_NUMOSE, LOG_CODEMP, LOG_CODOPE, LOG_CODDIG, LOG_FASANT, ' +
         '     LOG_SITANT, LOG_COMANT, LOG_FASATU, LOG_SITATU, LOG_COMATU, LOG_EMPLOG, LOG_FLXLOG) ' +
         ' VALUES (:AUTINC, :DTALOG, :HORLOG, :NUMOSE, :CODEMP, :CODOPE, :CODDIG, :FASANT, :SITANT, :COMANT, :FASATU, ' +
         '     :SITATU, :COMATU, :EMPLOG, :FLXLOG) ';
var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery();

  try
    LQuery.SQL.Add(LSQL);
    LQuery.ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGFLX', ACodEmp);
    LQuery.ParamByName('DTALOG').AsDate     := VS_Date;
    LQuery.ParamByName('HORLOG').AsDateTime := fTime();
    LQuery.ParamByName('NUMOSE').AsString   := ANumOSe;
    LQuery.ParamByName('CODEMP').AsString   := ACodEmp;
    LQuery.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    LQuery.ParamByName('CODDIG').AsString   := strLoginUsuarioLogado;
    LQuery.ParamByName('FASANT').AsString   := AFlxFasAnt;
    LQuery.ParamByName('SITANT').AsString   := AFlxSitAnt;
    LQuery.ParamByName('COMANT').AsString   := AFlxComAnt;
    LQuery.ParamByName('FASATU').AsString   := AFlxFas;
    LQuery.ParamByName('SITATU').AsString   := AFlxSit;
    LQuery.ParamByName('COMATU').AsString   := AFlxCom;
    LQuery.ParamByName('EMPLOG').AsString   := VS_strCodEmp;
    LQuery.ParamByName('FLXLOG').AsString   := 'S';
    LQuery.ExecSQL();
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TFluxoOrdemServico.pNovaOrdemServico;
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso               := True;
    frmFatManConsertoEquip.strFlxNovaCancelar             := 'N';
    frmFatManConsertoEquip.edtCodEmp.Text                 := VS_strCodEmp;
    frmFatManConsertoEquip.tbsDefeitos.TabVisible         := False;
    frmFatManConsertoEquip.tbsProdutos.TabVisible         := False;
    frmFatManConsertoEquip.tbsServicos.TabVisible         := False;
    frmFatManConsertoEquip.tbsDocsRelacionados.TabVisible := False;
    frmFatManConsertoEquip.btnRealizada.Visible           := False;
    frmFatManConsertoEquip.btnImprimir.Visible            := False;
    frmFatManConsertoEquip.btnTermoDev.Visible            := False;
    frmFatManConsertoEquip.btnAlteracao.Visible           := False;
    frmFatManConsertoEquip.btnDesEsp.Visible              := False;
    frmFatManConsertoEquip.btnReprovar.Visible            := False;
    frmFatManConsertoEquip.btnAprovada.Visible            := False;
    frmFatManConsertoEquip.btnCancelar.Visible            := False;
    frmFatManConsertoEquip.btnObservacao.Visible          := False;
    frmFatManConsertoEquip.btnManutencao.Visible          := False;
    frmFatManConsertoEquip.btnHisSta.Visible              := False;
    frmFatManConsertoEquip.btnSalRes.Visible              := False;
    frmFatManConsertoEquip.btnImpostos.Visible            := False;
    frmFatManConsertoEquip.btnAddObsTec.Visible           := False;
    frmFatManConsertoEquip.btnImpEti.Visible              := False;
    frmFatManConsertoEquip.btnReativar.Visible            := False;
    frmFatManConsertoEquip.btnUltimasVendas.Visible       := False;
    frmFatManConsertoEquip.btnComunicacaoInterna.Visible  := False;
    frmFatManConsertoEquip.edtNumero.Enabled              := False;
    frmFatManConsertoEquip.btnApontHoras.Visible          := False;
    frmFatManConsertoEquip.btnAlteraItens.Visible         := False;
    frmFatManConsertoEquip.btnBrindeTotalServ.Visible     := False;
    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
    pAtualizaDados();
  end;
end;

procedure TFluxoOrdemServico.pValidaDireitosAcessoProcessos;
begin
  FProcessos.Add(TProcessoNumOS.Create());
  FProcessos.Add(TProcessoDadosOS.Create());

  if (fCfgSis('EFXTPG', varBoolean)) or (fVerificaAcessoSistema('FXOSFA', strLoginUsuarioLogado)) then
    FProcessos.Add(TProcessoGarantia.Create());

  if (fCfgSis('EFXTPF', varBoolean)) then
    FProcessos.Add(TProcessoFinalizacaoOS.Create());

  if (fCfgSis('TXAUTI', varBoolean)) then
    FProcessos.Add(TProcessoTaxaArmazenamento.Create());
end;

procedure TFluxoOrdemServico.pValidaFiltroCancelada(var aSQL: String);
begin
  if (FFiltros.blnCancel) or (not fEmptyStr(FFiltros.strNumOSe)) then
  begin
    if (not fEmptyStr(aSQL)) then
      aSQL := aSQL + ' UNION ALL ';

    aSQL := aSQL + fFiltraOSCanceladas;
  end;
end;

procedure TFluxoOrdemServico.pValidarPermissaoColunas;
begin
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_CONSULTA).Visible     := fVerificaAcessoSistema('FLXCNS', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_EDITAR).Visible       := fVerificaAcessoSistema('FLXEDT', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_CLIENTE).Visible      := fVerificaAcessoSistema('FLXCLI', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_MOTREPR).Visible      := fVerificaAcessoSistema('FLXMRE', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_NFREME).Visible       := fVerificaAcessoSistema('FLXREM', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_DTENTR_EQUIP).Visible := fVerificaAcessoSistema('FLXDTR', strLoginUsuarioLogado);

  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_IMP).Visible          := fVerificaAcessoSistema('FLXIMP', strLoginUsuarioLogado);
  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_ETI).Visible          := fVerificaAcessoSistema('FLXETI', strLoginUsuarioLogado);

  if (fCfgSis('TERCEQ', varBoolean)) then
    TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_TRESP).Visible      := fVerificaAcessoSistema('FXTRES', strLoginUsuarioLogado);

  TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_TDEV).Visible         := fVerificaAcessoSistema('FXTDEV', strLoginUsuarioLogado);

  if fCfgSis('OSIMOE', varBoolean) then
    TcxGridDBBandedColumnHelper.fFindBandedColumnByNameView(FCxgFluxoTBV, TProcessoDadosOS.DATA_FIELD_NAME_ORDEXE).Visible     := fVerificaAcessoSistema('FXORDE', strLoginUsuarioLogado);
end;

procedure TFluxoOrdemServico.pVerificaOSGarantiaAgPecas;
var
  strSQL   : String;
  blnSaldo ,
  blnAtuFlx,
  blnTemReq: Boolean;
  fltSaldos,
  fltSalRes: Double;
  qryOSGar ,
  qryItens ,
  qryAux   ,
  qryReq   : TUniQuery;
begin
  blnAtuFlx := False;

  qryOSGar := fCriaQuery;
  qryItens := fCriaQuery;
  qryAux   := fCriaQuery;
  qryReq   := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT AUTOINCREM, EQU_NUMOSE NUMOSE, EQU_CODEMP CODEMP, EQU_NUMPED NUMPED, EQU_EMPPED EMPPED, ';
    strSQL := strSQL + '   EQU_FLXFAS FLXFAS, EQU_FLXSIT FLXSIT, EQU_FLXCOM FLXCOM ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' WHERE EQU_GARANT = "F" ';
    strSQL := strSQL + '   AND EQU_FLXSIT = "AP" ';
    strSQL := strSQL + '   AND NOT EXISTS (SELECT FDO_NUMDOC ';
    strSQL := strSQL + '                   FROM FATDOR F ';
    strSQL := strSQL + '                   INNER JOIN EXTDOR ED ON F.AUTOINCREM = ED.FDO_SEQFDO ';
    strSQL := strSQL + '                   WHERE FDO_RESERV = "N" ';
    strSQL := strSQL + '                     AND F.FDO_NUMDOC = EQU_NUMPED ';
    strSQL := strSQL + '                     AND F.FDO_ESPDOC = EQU_TIPPED ';
    strSQL := strSQL + '                     AND F.FDO_CODEMP = EQU_EMPPED) ';
    strSQL := strSQL + '   AND NOT EXISTS (SELECT FDO_NUMDOC ';
    strSQL := strSQL + '                   FROM FATDOR F ';
    strSQL := strSQL + '                   INNER JOIN EXTDOR ED ON F.AUTOINCREM = ED.FDO_SEQFDO ';
    strSQL := strSQL + '                   INNER JOIN EQUGOR G ON F.FDO_SEQGER = G.FGO_SEQFGO ';
    strSQL := strSQL + '                   WHERE FDO_RESERV = "N" ';
    strSQL := strSQL + '                   AND G.FGO_SEQEQU = EQUGER.AUTOINCREM) ';

    qryOSGar.SQL.Text := strSQL;
    qryOSGar.Open;

    strSQL := '';
    strSQL := strSQL + ' SELECT EQU_CODITE CODITE, EQU_QTDITE QTDITE, FDO_CODEMP CODEMP, FDO_NUMLOT NUMLOT ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' INNER JOIN FATDOR ON EQU_NUMPED = FDO_NUMDOC AND ';
    strSQL := strSQL + '                      EQU_TIPPED = FDO_ESPDOC AND EQU_EMPPED = FDO_CODEMP ';
    strSQL := strSQL + ' INNER JOIN EQUDET ON EQUGER.AUTOINCREM = EQUDET.EQU_SEQGER ';
    strSQL := strSQL + ' WHERE EQUGER.AUTOINCREM = :AUTINC ';
    qryItens.SQL.Text := strSQL;

    strSQL := '';
    strSQL := strSQL + ' SELECT (SUM(RCD_QTDITE) - SUM(PCD_QTDBAI)) QTDREQ ';
    strSQL := strSQL + ' FROM MOVRCD ';
    strSQL := strSQL + ' LEFT JOIN PCMDET ON RCD_SEQPCD = PCMDET.AUTOINCREM  AND PCMDET.PCD_BAIXAD > 0 ';
    strSQL := strSQL + ' WHERE RCD_CODITE = :CODITE ';
    strSQL := strSQL + '     AND RCD_CODEMP = :CODEMP ';
    qryReq.SQL.Text := strSQL;

    while not qryOSGar.Eof do
    begin
      blnSaldo := True;

      qryItens.Close;
      qryItens.ParamByName('AUTINC').AsString := qryOSGar.FieldByName('AUTOINCREM').AsString;
      qryItens.Open;

      while not qryItens.Eof do
      begin
        fltSaldos := fCampoTabela('IFNULL(LOT_SALDOS, 0)', 'CADLOT', ['LOT_STATUS', 'LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
          ['S', qryItens.FieldByName('CODITE').AsString, VS_strCodEmp, qryItens.FieldByName('NUMLOT').AsString]);

        fltSalRes := TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(qryItens.FieldByName('CODEMP').AsString)
                         .CodigoItem(qryItens.FieldByName('CODITE').AsString)
                         .CodEmpresa(VS_strCodEmp)
                         .NumeroDocumento(qryOSGar.FieldByName('NUMPED').AsString)
                         .TipoFiltroDocumento(tfdIgnorarDocumento)
                         .NumeroLote(qryItens.FieldByName('NUMLOT').AsString)
                     ).fGetQuantidade();

        blnTemReq := (fVerificaPDComReqEmAbertoComPedidoDeCompra(qryOSGar.FieldByName('NUMPED').AsString, 'PD',
                        qryOSGar.FieldByName('EMPPED').AsString) or
                      fVerificaPDComReqEmAbertoSemPedidoDeCompra(qryOSGar.FieldByName('NUMPED').AsString, 'PD',
                        qryOSGar.FieldByName('EMPPED').AsString));

        if (not blnTemReq) then
        begin
          qryReq.Close;
          qryReq.ParamByName('CODITE').AsString := qryItens.FieldByName('CODITE').AsString;
          qryReq.ParamByName('CODEMP').AsString := qryItens.FieldByName('CODEMP').AsString;
          qryReq.Open;

          fltSalRes := fltSalRes - qryReq.FieldByName('QTDREQ').AsFloat;
        end
        else
          blnSaldo := False;

        if (fFormataFloat(fltSaldos - fltSalRes, 2) < fFormataFloat(qryItens.FieldByName('QTDITE').AsFloat, 2)) then
          blnSaldo := False;

        qryItens.Next;
      end;

      if blnSaldo then
      begin
        blnAtuFlx := True;

        strSQL := '';
        strSQL := strSQL + ' UPDATE EQUGER ';
        strSQL := strSQL + ' SET EQU_FLXSIT = "EM" ';
        strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

        try
          fStartTransaction;

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Text := strSQL;
          qryAux.ParamByName('AUTINC').AsString := qryOSGar.FieldByName('AUTOINCREM').AsString;
          qryAux.ExecSQL;

          pInsereLogFlxOS(qryOSGar.FieldByName('NUMOSE').AsString, qryOSGar.FieldByName('CODEMP').AsString,
            qryOSGar.FieldByName('FLXFAS').AsString, qryOSGar.FieldByName('FLXSIT').AsString, qryOSGar.FieldByName('FLXCOM').AsString,
            qryOSGar.FieldByName('FLXFAS').AsString, 'EM', qryOSGar.FieldByName('FLXCOM').AsString);

          fCommit;
        except on E: Exception do
          fRollback;
        end;
      end;

      qryOSGar.Next;
    end;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(qryItens);
    FreeAndNil(qryOSGar);
    FreeAndNil(qryReq);
  end;

  if blnAtuFlx then
    pAtualizaDados();
end;

procedure TFluxoOrdemServico.pVerificaStatusOSComRequisicao(AEmManutencao: Boolean = False);
var
  LSQL,
  LAux, LStatus: String;
  LQry, LUpd: TUniQuery;

  function fNovaSituacao: String;
  begin
    Result := IIF(AEmManutencao, 'AP', 'EM');

    if (not fCfgSis('FLXSEP', varBoolean)) then
      Exit;

    if AEmManutencao then
      Exit;

    Result := 'EM';

    if (LQry.FieldByName('BAISEP').AsInteger = 1) then
      Exit;

    Result := 'AS';
  end;
begin
  if (not fCfgSis('FXVSTA', varBoolean)) then
    Exit;

  LAux := 'STATUS_PEDIDO_OS';

  if (not fCfgSis('MAOSEM', varBoolean)) then
    LAux := LAux + '_' + VS_strCodEmp;

  if not fLock_Unlock(LAux, True, False) then
    Exit;

  LSQL := '';
  LSQL := LSQL + ' SELECT DISTINCT E.AUTOINCREM AUTINC, EQU_NUMOSE NUMOSE, EQU_CODEMP CODEMP, EQU_FLXSIT FLXSIT, ';
  LSQL := LSQL + '   (SELECT COUNT(1) FROM EXTGOR EG      ';
  LSQL := LSQL + '    WHERE F.FDO_SEQGER = EG.FGO_SEQFGO  ';
  LSQL := LSQL + '      AND EG.FGO_OPBXSE IS NULL         ';
  LSQL := LSQL + '      AND EG.FGO_DTBXSE IS NULL         ';
  LSQL := LSQL + '      AND EG.FGO_HRBXSE IS NULL) BAISEP ';
  LSQL := LSQL + ' FROM EQUGER E ';
  LSQL := LSQL + ' INNER JOIN FATDOR F ON EQU_NUMPED = FDO_NUMDOC ';
  LSQL := LSQL + '                    AND EQU_TIPPED = FDO_ESPDOC ';
  LSQL := LSQL + '                    AND EQU_EMPPED = FDO_CODEMP ';
  LSQL := LSQL + ' INNER JOIN MOVRCD R ON FDO_NUMDOC = RCD_DOCPDV ';
  LSQL := LSQL + '                    AND FDO_ESPDOC = RCD_ESPPDV ';
  LSQL := LSQL + '                    AND FDO_CODEMP = RCD_EMPPDV ';
  LSQL := LSQL + '                    AND FDO_CODITE = RCD_CODITE ';
  LSQL := LSQL + ' INNER JOIN EXTGOR AS EG ON EG.FGO_SEQFGO = F.FDO_SEQGER ';
  LSQL := LSQL + ' LEFT  JOIN FGOSTA AS ST ON ST.STA_CODIGO = EG.FGO_STATUS ';
  LSQL := LSQL + ' WHERE EQU_FLXFAS = "M" ';
  LSQL := LSQL + '   AND EQU_FLXSIT IN (' + IIF(AEmManutencao, '"EM", "AS"', '"AP"') + ') ';
  LSQL := LSQL + '   AND EQU_FLXCOM = "AM" ';

  if AEmManutencao then
  begin
    LSQL := LSQL + '   AND (IFNULL(RCD_SEQPCD, "") = "" ';
    LSQL := LSQL + '        OR EXISTS (SELECT P.AUTOINCREM ';
    LSQL := LSQL + '                   FROM PCMDET P ';
    LSQL := LSQL + '   	               WHERE RCD_SEQPCD = P.AUTOINCREM ';
    LSQL := LSQL + '   	                 AND PCD_BAIXAD = 0)) ';
  end
  else
  begin
    LSQL := LSQL + '   AND NOT EXISTS ( ';
    LSQL := LSQL + '     SELECT RD.RCD_CODIGO ';
    LSQL := LSQL + '     FROM MOVRCD RD ';
    LSQL := LSQL + '     LEFT JOIN PCMDET P ON RD.RCD_SEQPCD = P.AUTOINCREM ';
    LSQL := LSQL + '     WHERE FDO_NUMDOC = RD.RCD_DOCPDV ';
    LSQL := LSQL + '       AND FDO_ESPDOC = RD.RCD_ESPPDV ';
    LSQL := LSQL + '       AND FDO_CODEMP = RD.RCD_EMPPDV ';
    LSQL := LSQL + '       AND (RD.RCD_SEQPCD IS NULL OR PCD_BAIXAD = 0)) ';
  end;

  if not fCfgSis('MAOSEM', varBoolean) then
    LSQL := LSQL + '     AND EQU_CODEMP = ' + QuotedStr(VS_strCodEmp);

  LQry := fCriaQuery;
  LUpd := fCriaQuery;

  try
    LUpd.SQL.Add('UPDATE EQUGER ');
    LUpd.SQL.Add('SET EQU_FLXSIT = :FLXSIT ');
    LUpd.SQL.Add('WHERE AUTOINCREM = :AUTINC ');

    LQry.SQL.Text := LSQL;
    LQry.Open;

    while not LQry.Eof do
    begin
      LStatus := fNovaSituacao;

      LUpd.Close;
      LUpd.ParamByName('FLXSIT').AsString := IIF(AEmManutencao, 'AP', 'EM');
      LUpd.ParamByName('AUTINC').AsString := LQry.FieldByName('AUTINC').AsString;
      LUpd.ExecSQL;

      pInsereLogFlxOS(LQry.FieldByName('NUMOSE').AsString, LQry.FieldByName('CODEMP').AsString,
                        'M', LQry.FieldByName('FLXSIT').AsString, 'AM',
                        'M', LStatus, 'AM');

      LQry.Next;
    end;
  finally
    fLock_Unlock(LAux, False, False);
    FreeAndNil(LQry);
    FreeAndNil(LUpd);
  end;
end;

procedure TFluxoOrdemServico.pSetButton(aButton: TcxButton);
begin
  case AnsiIndexStr(UpperCase(aButton.Name), ['BTNDOCSFISCAISENT', 'BTNDOCSFISCAISSAI', 'BTNANALISETEC', 'BTNORCAMENTO',
    'BTNENVIARCLIENTE', 'BTNINTERROMPERORC', 'BTNAPROVAR', 'BTNREPROVAR', 'BTNCANCELARREP', 'BTNREALIZARMAN',
    'BTNINTERROMPERMAN', 'BTNMANUTENCAO', 'BTNCANCELARMAN', 'BTNAPONTAMENTO', 'BTNARMAZENAR', 'BTNCANCELARARM',
    'BTNRETIRAR', 'BTNCANCENTEQUIP', 'BTNBAIXAROSDES', 'BTNCOMUNICACOESINTERNAS']) of
    0:
      begin
        FbtnDocsFiscaisEnt := aButton;
        FbtnDocsFiscaisEnt.OnClick := btnDocsFiscaisEntClick;
      end;
    1:
      begin
        FbtnDocsFiscaisSai := aButton;
        FbtnDocsFiscaisSai.OnClick := btnDocsFiscaisSaiClick;
      end;
    2:
      begin
        FbtnAnaliseTec := aButton;
        FbtnAnaliseTec.OnClick := btnAnaliseTecClick;
      end;
    3:
      begin
        FbtnOrcamento := aButton;
        FbtnOrcamento.OnClick := btnOrcamentoClick;
      end;
    4:
      begin
        FbtnEnviarCliente := aButton;
        FbtnEnviarCliente.OnClick := btnEnviarClienteClick;
      end;
    5:
      begin
        FbtnInterromperOrc := aButton;
        FbtnInterromperOrc.OnClick := btnInterromperOrcClick;
      end;
    6:
      begin
        FbtnAprovar := aButton;
        FbtnAprovar.OnClick := btnAprovarClick;
      end;
    7:
      begin
        FbtnReprovar := aButton;
        FbtnReprovar.OnClick := btnReprovarClick;
      end;
    8:
      begin
        FbtnCancelarRep := aButton;
        FbtnCancelarRep.OnClick := btnCancelarRepClick;
      end;
    9:
      begin
        FbtnRealizarMan := aButton;
        FbtnRealizarMan.OnClick := btnRealizarManClick;
      end;
    10:
      begin
        FbtnInterromperMan := aButton;
        FbtnInterromperMan.OnClick := btnInterromperManClick;
      end;
    11:
      begin
        FbtnManutencao := aButton;
        FbtnManutencao.OnClick := btnManutencaoClick;
      end;
    12:
      begin
        FbtnCancelarMan := aButton;
        FbtnCancelarMan.OnClick := btnCancelarManClick;
      end;
    13:
      begin
        FbtnApontamento := aButton;
        FbtnApontamento.OnClick := btnApontamentoClick;
      end;
    14:
      begin
        FbtnArmazenar := aButton;
        FbtnArmazenar.OnClick := btnArmazenarClick;
      end;
    15:
      begin
        FbtnCancelarArm := aButton;
        FbtnCancelarArm.OnClick := btnCancelarArmClick;
      end;
    16:
      begin
        FbtnRetirar := aButton;
        FbtnRetirar.OnClick := btnRetirarClick;
      end;
    17:
      begin
        FbtnCancEntEquip         := aButton;
        FbtnCancEntEquip.OnClick := btnCancEntEquipClick;
        FbtnCancEntEquip.Enabled := (fVerificaAcessoSistema('FXCAEN', strLoginUsuarioLogado));
      end;
    18:
      begin
        FbtnBaixarOSDes := aButton;
        FbtnBaixarOSDes.OnClick := btnBaixarOSDesClick;
      end;
    19:
      begin
        FbtnComunicacoesInternas := aButton;
        FbtnComunicacoesInternas.OnClick := btnComunicacoesInternasClick;
      end;
  end;
end;

procedure TFluxoOrdemServico.setCxgFluxo(const Value: TcxGrid);
begin
  FCxgFluxo    := Value;
  FCxgFluxoTBV := (FCxgFluxo.ActiveView as TcxGridDBBandedTableView);

  FCxgFluxoTBV.OptionsData.Appending        := False;
  FCxgFluxoTBV.OptionsData.CancelOnExit     := False;
  FCxgFluxoTBV.OptionsData.Deleting         := False;
  FCxgFluxoTBV.OptionsData.Editing          := False;
  FCxgFluxoTBV.OptionsData.Inserting        := False;
  FCxgFluxoTBV.OptionsView.HeaderAutoHeight := True;
  FCxgFluxoTBV.OptionsView.CellAutoHeight   := True;
  FCxgFluxoTBV.OptionsView.GroupByBox       := False;
  FCxgFluxoTBV.DataController.DataSource    := FCdsFluxo.dtsSource;

  FCxgFluxoTBV.OnCellClick                  := cxgFluxoTBVCellClick;
  FCxgFluxoTBV.OnKeyPress                   := cxgFluxoTBVKeyPress;
  FCxgFluxoTBV.OnMouseMove                  := cxgFluxoTBVMouseMove;

  pCriaColunasCxgFluxo;
end;

end.