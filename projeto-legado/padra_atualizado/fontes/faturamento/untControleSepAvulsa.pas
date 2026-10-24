unit untControleSepAvulsa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, UniClientDataSet, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, DB, strUtils, untZClient, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.ImgList, cxImageComboBox, EditFocus, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCurrencyEdit, Estoque.Lote.TCdsLoteQuantidade,
  Expedicao.TSeparacaoAvulsa, untFatGorFactory;

type
  TopcAcao = (opcNenhum, opcSaida, opcDevolucao, opcBaixa, opcEnviarSeparador);

  TfrmControleSepAvulsa = class(TfrmPai)
    pnlButtons: TPanel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    cxgDadosColumnCODCSP: TcxGridDBColumn;
    cxgDadosColumnCODITE: TcxGridDBColumn;
    cxgDadosColumnDESITE: TcxGridDBColumn;
    cxgDadosColumnSIGUNI: TcxGridDBColumn;
    cxgDadosColumnLOCFIS: TcxGridDBColumn;
    cxgDadosColumnOPEIMP: TcxGridDBColumn;
    cxgDadosColumnNOMIMP: TcxGridDBColumn;
    cxgDadosColumnDTAIMP: TcxGridDBColumn;
    cxgDadosColumnHRAIMP: TcxGridDBColumn;
    cxgDadosColumnOPESAI: TcxGridDBColumn;
    cxgDadosColumnNOMSAI: TcxGridDBColumn;
    cxgDadosColumnDTASAI: TcxGridDBColumn;
    cxgDadosColumnHRASAI: TcxGridDBColumn;
    btnSaida: TBitBtnLocked;
    btnDevolucao: TBitBtnLocked;
    btnUpdate: TBitBtnLocked;
    btnRelatorio: TBitBtnLocked;
    btnBaixar: TBitBtnLocked;
    ImageList1: TImageList;
    cxgDadosColumnLEGENDA: TcxGridDBColumn;
    btnEnviaSeparador: TBitBtnLocked;
    pnlItem: TPanel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    lblStatus: TLabel;
    lblCodBar: TLabel;
    edtCodIte: TEditFocus;
    cxgDadosColumnQTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnSaidaClick(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnDevolucaoClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnEnviaSeparadorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    tpAcao : TopcAcao;
    cdsDados : TZClient;
    objSeparacaoAvulsa : TSeparacaoAvulsa;
    function fSQL : String;
    function fBuscaItem: Boolean;
    procedure pProcessaRegistro;
    procedure pApagaPedidoDeReserva;
    function fGravarEnvioSeparador(strSeparador : String; cdsLotes : TCdsLoteQuantidade) : boolean;

    procedure cdsDadosAfterScroll(DataSet: TDataSet);
  public
    class function pRegistraImpressao(strCodOpe, strCodIte, strNumLot : String; fltQuantidade : Double) : Boolean;
    class procedure pImprimeSeparacaoItem(strCodIte, strDesIte, strLocFis,
    strSigUni, strCodFab, strCodCli, strCodVen, strCodDig  : String; fltPreVen : Double; strRefere : String = ''; strMsgLv1 : String = '';
    fltQtdSep: Double = 1; pblnImpContinua: Boolean = False);
  protected
    Function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untModuloFatImp, untCfgRel, untTypesSistema,
  untFuncoesRel, untFuncoesRel2, untObservacao, untCadLote, untConsultas,
  untEditorFastImpressao, untDigOperador, Expedicao.View.frmSeparacaoAvulsaEnviarSeparador, untDigQuantidade;

{ TfrmControleSepAvulsa }

procedure TfrmControleSepAvulsa.btnBaixarClick(Sender: TObject);
begin
  inherited;
  If cdsDados.IsEmpty Then
  Begin
    fMensagem('','Nenhum registro disponível!', ['&Ok']);
    Exit;
  End;

  if (fCfgSis('UTCSEA', varString) <> 'C') and cdsDados.FieldByName('CSP_OPESAI').IsNull Then
  Begin
    fMensagem('', 'A saída do produto não foi efetuada, não é possível efetuar a baixa!', ['&Ok']);
    Exit;
  End;

  tpAcao := opcBaixa;

  pProcessaRegistro;
  btnUpdate.Click;
  cdsDados.First;

  pSetFocus(cxgDados);

end;

procedure TfrmControleSepAvulsa.btnDevolucaoClick(Sender: TObject);
begin
  if not btnDevolucao.visible then
    exit();

  If cdsDados.IsEmpty Then
  Begin
    fMensagem('','Nenhum registro disponível!', ['&Ok']);
    Exit;
  End;

  if cdsDados.FieldByName('CSP_OPESAI').IsNull Then
  Begin
    fMensagem('', 'A saída do produto não foi efetuada, não é possível efetuar a devolução!', ['&Ok']);
    Exit;
  End;

  fMensagem('', 'Digite o código de barras para confirmar a devolução do produto!', ['&Ok']);
  lblCodBar.Visible := True;
  edtCodIte.Visible := True;
  tpAcao := opcDevolucao;
  pSetFocus(edtCodIte);

end;

procedure TfrmControleSepAvulsa.btnEnviaSeparadorClick(Sender: TObject);
begin
  if not btnEnviaSeparador.visible then
    exit();

  If cdsDados.IsEmpty Then
  Begin
    fMensagem('','Nenhum registro disponível!', ['&Ok']);
    Exit;
  End;

  if cdsDados.FieldByName('CSP_OPESAI').IsNull Then
  Begin
    tpAcao := opcEnviarSeparador;
     pProcessaRegistro;
     btnUpdate.Click;
     cdsDados.First;

     pSetFocus(cxgDados);

  End
  Else
    fMensagem('', 'Separação já enviada, operação não permitida!', ['&Ok']);
end;

procedure TfrmControleSepAvulsa.btnRelatorioClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(236, 8035, [8036],
                        [],
                        [],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmControleSepAvulsa.btnSaidaClick(Sender: TObject);
begin
  if not btnSaida.visible then
    exit();

  If cdsDados.IsEmpty Then
  Begin
    fMensagem('','Nenhum registro disponível!', ['&Ok']);
    Exit;
  End;

  if cdsDados.FieldByName('CSP_OPESAI').IsNull Then
  Begin
    fMensagem('', 'Digite o código de barras para confirmar a saída do produto!', ['&Ok']);
    lblCodBar.Visible := True;
    edtCodIte.Visible := True;
    tpAcao := opcSaida;
    pSetFocus(edtCodIte);
  End
  Else
    fMensagem('', 'Saída já realizada, operação não permitida!', ['&Ok']);

end;

procedure TfrmControleSepAvulsa.btnUpdateClick(Sender: TObject);
begin
  inherited;
  cdsDados.fAbreClient(True, 'TfrmControleSepAvulsa.btnUpdateClick');
end;

procedure TfrmControleSepAvulsa.cxgDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    pEscapePressed

  Else
  If Key = VK_Return Then
  Begin
    If cdsDados.IsEmpty Then
    Begin
      fMensagem('','Nenhum registro disponível!', ['&Ok']);
      Exit;
    End;

    if cdsDados.FieldByName('CSP_OPESAI').IsNull Then
      btnSaida.Click
    Else
    Begin
      Case fGetMenu('Escolha:', ['Devolução de produto', 'Baixa', 'Cancelar'], 1) Of
        1: btnDevolucao.Click;
        2: btnBaixar.Click;
      End;
    End;

  End;
end;

procedure TfrmControleSepAvulsa.edtCodIteExit(Sender: TObject);
begin
  inherited;
  lblCodBar.Visible := False;
  edtCodIte.Visible := False;
  edtCodIte.Clear;
  pSetFocus(cxgDados);
end;

procedure TfrmControleSepAvulsa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If edtCodIte.Visible Then
  Begin
    If fMensagem('','Deseja cancelar?', ['&Sim', '&Não'],2) = 1 Then
      edtCodIteExit(nil);
    Action := caNone;
  End;

end;

procedure TfrmControleSepAvulsa.FormCreate(Sender: TObject);
begin
  inherited;
  objSeparacaoAvulsa := TSeparacaoAvulsa.Create(fCfgSis('UTCSEA', varString));
  cdsDados := TZClient.Create(Self, fSQL);
  cdsDados.AfterScroll := cdsDadosAfterScroll;
  cdsDados.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  cxgDadosTableView.DataController.DataSource := cdsDados.dtsSource;
  cdsDados.fAbreClient(True, 'TfrmControleSepAvulsa.FormCreate');
  tpAcao := opcNenhum;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodIte.MaxLength := 43;

end;

procedure TfrmControleSepAvulsa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objSeparacaoAvulsa);
  inherited;
end;

procedure TfrmControleSepAvulsa.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F1  : btnSaida.Click;
    VK_F2  : btnDevolucao.Click;
    VK_F3  : btnBaixar.Click;
    VK_F4  : btnEnviaSeparador.Click;
    VK_F5  : btnUpdate.Click;
    VK_F10 : btnRelatorio.Click;
  End;
end;

procedure TfrmControleSepAvulsa.FormShow(Sender: TObject);
begin
  inherited;

  if objSeparacaoAvulsa.fUtilizaColetor then
  begin
    btnSaida.visible := False;
    btnDevolucao.visible := False;
  end
  else
  begin
    btnEnviaSeparador.Visible := False;
    cxgDadosColumnQTDITE.Visible := False;
  end;

  lblStatus.Caption := objSeparacaoAvulsa.fRetornaLegendaSeparacao;

end;

function TfrmControleSepAvulsa.fSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT CONSEP.AUTOINCREM,                                 ';
  Result := Result + '        CSP_CODCSP,                                        ';
  Result := Result + '        CSP_CODEMP,                                        ';
  Result := Result + '        CSP_CODITE,                                        ';
  Result := Result + '        CSP_QTDITE,                                        ';
  Result := Result + '        CSP_NUMLOT,                                        ';
  Result := Result + '        ITE_DESITE,                                        ';
  Result := Result + '        UNI_SIGUNI,                                        ';
  Result := Result + '        CSP_LOCFIS,                                        ';
  Result := Result + '        CSP_OPEIMP,                                        ';
  Result := Result + '      I.OPE_NOMOPE AS NOMIMP,                              ';
  Result := Result + '        CSP_DTAIMP,                                        ';
  Result := Result + '        CSP_HRAIMP,                                        ';
  Result := Result + '        CSP_OPESAI,                                        ';
  Result := Result + '      S.OPE_NOMOPE AS NOMSAI,                              ';
  Result := Result + '        CSP_DTASAI,                                        ';
  Result := Result + '        CSP_HRASAI,                                        ';
  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM  ';
  Result := Result + '   ITEBAR WHERE C.ITE_CODITE = BAR_CODITE) AS BAREMB,      ';
  Result := Result + '      C.ITE_CODBAR AS CODBAR,                              ';
  Result := Result + '      IF(CSP_OPESAI IS NULL, 0, 1) AS LEGENDA,             ';
  Result := Result + '      C.ITE_CODMAR,                                        ';
  Result := Result + '      C.ITE_REFERE,                                        ';
  Result := Result + '      C.ITE_CODUNI,                                        ';
  Result := Result + '      C.ITE_CODFOR,                                        ';
  Result := Result + '      C.ITE_MSGLV1                                         ';
  Result := Result + ' FROM CONSEP                                               ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = CSP_CODITE          ';
  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = CSP_CODITE          ';
  Result := Result + '                    AND G.ITE_CODEMP = CSP_CODEMP          ';
  Result := Result + ' INNER JOIN CADOPE I ON I.OPE_CODOPE = CSP_OPEIMP          ';
  Result := Result + ' LEFT  JOIN CADOPE S ON S.OPE_CODOPE = CSP_OPESAI          ';
  Result := Result + ' LEFT  JOIN CADUNI U ON U.UNI_CODUNI = ITE_CODUNI          ';
  Result := Result + ' WHERE CSP_OPEBAI IS NULL                                  ';
  Result := Result + '   AND CSP_OPEDEV IS NULL                                  ';
  Result := Result + '   AND CSP_CODEMP = :CODEMP                                ';
  Result := Result + '   AND (   ((SELECT                                        ';
  Result := Result + '               COUNT(*)                                    ';
  Result := Result + '             FROM                                          ';
  Result := Result + '               DETCSP                                      ';
  Result := Result + '             WHERE DET_SEQCSP = CONSEP.AUTOINCREM          ';
  Result := Result + '               AND DETCSP.DET_DTASEP IS NULL) > 0)         ';
  Result := Result + '        OR ((SELECT                                        ';
  Result := Result + '               COUNT(*)                                    ';
  Result := Result + '             FROM                                          ';
  Result := Result + '               DETCSP WHERE                                ';
  Result := Result + '               DET_SEQCSP = CONSEP.AUTOINCREM ) = 0)       ';
  Result := Result + '       )                                                   ';
  Result := Result + ' ORDER BY LEGENDA, ITE_DESITE, CSP_CODCSP                  ';

end;

function TfrmControleSepAvulsa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strAutInc : String;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    if (Sender = edtCodIte) And (edtCodIte.Visible) Then
    Begin
      Result := fBuscaItem;
      If Result Then
      Begin
        strAutInc := cdsDados.FieldByName('AUTOINCREM').AsString;
        blnMudarFoco := False;
        pProcessaRegistro;
        btnUpdate.Click;
        If not cdsDados.Locate('AUTOINCREM', strAutInc, []) Then
          cdsDados.First;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;
function TfrmControleSepAvulsa.fGravarEnvioSeparador(strSeparador : String; cdsLotes : TCdsLoteQuantidade) : boolean;
var
  strAutoincremFATGOR,
  strAutoincremFATDOR,
  strNumeroDocumento,
  strCodigoCliente : String;
  qryAuxiliar : TUniQuery;

  recServicos: TDadosServicos;
  arrDuplic : TarrDuplicata;
begin
  qryAuxiliar := fCriaQuery(nil);
  try
    strCodigoCliente := fCadEmp('CLIFIL');
    strNumeroDocumento := fRetSequencialPedido;
    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    FillChar(recServicos, SizeOf(recServicos), #0);

    qryAuxiliar.SQL.Text := objSeparacaoAvulsa.fRetornaSQLInsertDetalhe;

    qryAuxiliar.ParamByName('DET_CODEMP').AsString := VS_strCodEmp;
    qryAuxiliar.ParamByName('DET_SEQCSP').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
    qryAuxiliar.ParamByName('DET_CODITE').AsString := cdsDados.FieldByName('CSP_CODITE').AsString;
    qryAuxiliar.ParamByName('DET_OPESEP').AsString := strSeparador;

    Result := TFatGorFactory.fGetFatGor.fGravaFatGor(strAutoincremFATGOR,              // strIncrem
                           VS_strCodEmp,          // strCodEmp
                           strNumeroDocumento,             // strNumeroDocumento
                           'PD',                  // strEspDoc
                           strCodigoCliente,             // strCodigoCliente
                           strLoginUsuarioLogado, // strCodVen
                           '',                    // strCodTra
                           '',                    // strSerie:
                           VS_Date,               // dtaDtaEnt
                           fTime(),               // dtaHorEnt
                           '01000',               // strConPag
                           '',                    // strEstado
                           '',                    // strNomCom
                           '',                    // strEndCon
                           '',                    // strBaiCon
                           '',                    // strCepCon
                           '',                    // strCidCon
                           '',                    // strEstCon
                           '',                    // strCodAti
                           '',                    // strTelCon
                           0,                     //  dtaNasCon
                           '',                    // strCgcCpf
                           '',                    // strCgcCon
                           '',                    // strIesCon
                           '',                    // strCli_Rg
                           0.0,                   // fltBasSim
                           0.0,                   // fltBasIpi
                           0.0,                   // fltAlqIpi
                           0.0,                   // fltTotIpi
                           0.0,                   // fltBasIcm
                           0.0,                   // fltAlqIcm
                           0.0,                   // fltTotIcm
                           0.0,                   // fltTotRet
                           0.0,                   // fltAlqRet
                           0.0,                   // fltBasRet
                           0.0,                   // fltDesEsp
                           0.0,                   // fltVlrCon
                           0.0,                   // fltTotPro
                           0.0,                   // fltTotCus
                           0.0,                   // fltTotMed
                           '',                    // strTipFre
                           0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                           0.0,                   // fltTotFre
                           0.0,                   // fltTotFre
                           0.0,                   // fltPesBru
                           0.0,                   // fltPesLiq
                           0,                     // fltVolume
                           arrDuplic,             // arrDuplic
                           '',                    // strEspeci
                           '',                    // strMarca,
                           objSeparacaoAvulsa.fRetornaMensagemPedidoReserva,             // strMen001
                           '',             // strMen002
                           False,                 // blnJaFatu
                           '',                    // strTipFat
                          // '',
                           '',                    // strNumFat
                           '',                    // strEmpFat
                           0,                     // dtaDtaFat
                           '',                    // strVenFat
                           '',                    // strCndFat
                           0.0,                   // fltValFat
                           0.0,                   // fltPorDes
                           strLoginUsuarioLogado, // strCodDig
                           '',                    // strCodCnd
                           '',                    // strCodFpg
                           recServicos, '',       // strConEnt
                           VS_Date,               // dtaPreVis
                           0.0,                   // fltVPgAnt
                           VS_Date,               // dtaUltAlt
                           '',                    // strNTrava
                           'A',                   // strTipPed
                           '',                    // strCliCtt
                           False,                 // blnLibera
                           'S',                   // strEntFat
                           0.0,                   // fltDesCon
                           '1',                   // strTabPre
                           '',                    // strEntFut
                           0.0,                   // fltMargem
                           '',                    // strNumPok
                           '',                    // strEmp_CD
                           False,                 // blnEnt_CD
                           'N',                   // strOprFlj
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '',                    // strMenExp
                           '', '', False,         // blnPedLib
                           0.0,
                           'N',
                           '',
                           0,
                           'P',                   // strTipFin
                           0,                     // fltDesFin
                           '',                    // strAutEnt
                           '',
                           '',
                           False,
                           '',
                           Nil,
                           '',
                           '',
                           0,
                           0,
                           0,
                           '',
                           nil,
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           '',
                           0,
                           '',
                           '',
                           '',
                           'N');


    cdsLotes.First;
    while Result and (not cdsLotes.Eof) do
    begin
      strAutoincremFATDOR := '';
      Result := Result and TFatGorFactory.fGetFatGor.fGravaFatDor(strAutoincremFATDOR,
                                        strAutoincremFATGOR,                                    // strSeqGer
                                        VS_strCodEmp,                                 // strCodEmp
                                        strCodigoCliente,                                    // strCodigoCliente
                                        strLoginUsuarioLogado,                        // strCodVen
                                        cdsDados.FieldByName('CSP_CODITE').AsString,  // strCodIte
                                        cdsDados.FieldByName('ITE_CODMAR').AsString, // strCodMar
                                        '',                                           // strCodDiv
                                        strNumeroDocumento,                                    // strNumeroDocumento
                                        'PD',                                         // strEspDoc
                                        '',                                           // strSerie:
                                        VS_Date, fTime(),                             // dtaHorEnt
                                        '01000',                                      // strConPag
                                        '',                                           //strEstado
                                        cdsDados.FieldByName('ITE_DESITE').AsString, // strDescri
                                        cdsDados.FieldByName('ITE_REFERE').AsString, // strRefere
                                        cdsDados.FieldByName('ITE_CODUNI').AsString, // strUnidad
                                        cdsDados.FieldByName('ITE_CODFOR').AsString, // strForIte
                                        cdsLotes.FieldByName('QUANTIDADE').AsFloat,  // fltQtdIte
                                        0.0,                                          // fltUnitar
                                        0.0,                                          // fltUniOri
                                        0.0,                                          // fltUniVis
                                        0.0,                                          // fltTotIte
                                        0.0,                                          // fltVlrCon
                                        0.0,                                          // fltTotCus
                                        0.0,                                          // fltTotMed
                                        0.0,                                          // fltDesCon
                                        0.0,                                          // fltTotFre
                                        0.0,                                          // fltDesEsp
                                        0.0,                                          // fltDesAce
                                        '',                                           // strCodRep
                                        '',                                           // strCodVe2
                                        0.0,                                          // fltPerCom
                                        0.0,                                          // fltTotCom
                                        0.0,                                          // fltTotCo2
                                        '',                                           // strClaFis
                                        '',                                           // strCodFis
                                        0.0,                                          // fltValIpi
                                        0.0,                                          // fltAlqIpi
                                        0.0,                                          // fltBasIpi
                                        0.0,                                          // fltValIcm
                                        0.0,                                          // fltAlqIcm
                                        0.0,                                          // fltBasIcm
                                        0.0,                                          // fltValRet
                                        0.0,                                          // fltAlqRet
                                        0.0,                                          // fltBasRet
                                        0.0,                                          // fltTotPes
                                        0.0,                                          // fltPerBas
                                        0.0,                                          // fltPerRed
                                        False,                                        // blnJaFatu
                                        '',                                           // strTipFat
                                       //'',
                                        '',                                           // strNumFat
                                        '',                                           // strEmpFat
                                        0,                                            // dtaDtaFat
                                        '',                                           // strVenFat
                                        '',                                           // strCndFat
                                        0.0,                                          // fltValFat
                                        'NOR',                                        // strIdePro
                                        'N',                                          // strIncPis
                                        strLoginUsuarioLogado,                        // strCodDig
                                        '',                                           // strConPag
                                        '',                                           // strProEmb
                                        '',                                           // strCodFpg
                                        '',                                           // strIteCha
                                        '',                                           // strIteTin
                                        '',                                           // strDesCor
                                        '',                                           // strTipEmb
                                        0.0,                                          // fltQtdEmb
                                        0.0,                                          // fltPreEmb
                                        '',                                           // strTipPre
                                        0.0,                                          // fltPrvTin
                                        0.0,                                          // fltPrcTin
                                        0.0,                                          // fltFatTin
                                        '',                                           // strIteEmb
                                        '',                                           // strGruEmb
                                        0,                                            // intLazQua
                                        'N',                                          // strPromoc
                                        '',                                           // strSeqTin
                                        0.0,                                          // fltQtdPul
                                        0,                                            // intSeqInd
                                        0.0,                                          // fltQtdBai
                                        0.0,                                          // fltUniDig
                                        '',                                           // strComple
                                        0.0,                                          // fltVolPro
                                        '',                                           // strCodAca
                                        '',                                           // strEmpAca
                                        False,                                        // blnProAca
                                        '',                                           // strTabPre
                                        '',                                           // strLinha:
                                        '',                                           // strCatali
                                        '',                                           // strCodDil
                                        0.0,                                          // fltPorDil
                                        '',                                           // strDilCon
                                        0.0,                                          // fltPorCat: Double;
                                        '',                                           // strEntRet,
                                        '',                                           // strLocRet,
                                        '',                                           // strEntFut,
                                        '',                                           // strMotFut: String;
                                        0,                                            // dtaDtEntr: TDateTime;
                                        0,                                            // fltTotCu2: Double;
                                        0,                                            // fltComRep,
                                        0,                                            // fltPerRep: Double;
                                        '',                                           // strKey_EP,
                                        cdsLotes.FieldByName('NUMERO_LOTE').AsString, // strNumLot: String;
                                        '',                                           // strEmpPrd: String;
                                        False,                                        // blnBxSbIt: Boolean;
                                        '',                                           // strEmpIte: String;
                                        '',                                           // strDocDev,
                                        '',                                           // strEspDev,
                                        '',                                           // strEmpDev: String;
                                        '',                                           // strEmpFor: String;
                                        '',                                           // strOrdPro: String;
                                        0,                                            // fltFreSug: Double;
                                        0,                                            // fltQtdExp: Double;
                                        '',                                           // strBarEmb: String;
                                        '',                                           // strNumCmp: String;
                                        0,                                            // intNItCmp: Integer;
                                        '',                                           // strCodMec: String;
                                        '',                                           // strSeqRcd: String;
                                        0,                                            // intSeqInc: Integer;
                                        0,                                            // intOrdIte: Integer;
                                        0);                                           // fltPesLiq: Double;


      if Result then
      begin
        qryAuxiliar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DETCSP', VS_strCodEmp);
        qryAuxiliar.ParamByName('DET_SEQFDO').AsString := strAutoincremFATDOR;
        qryAuxiliar.ParamByName('DET_QTDITE').AsFloat  := cdsLotes.FieldByNAme('QUANTIDADE').AsFloat;
        qryAuxiliar.ParamByName('DET_NUMLOT').AsString := cdsLotes.FieldByNAme('NUMERO_LOTE').AsString;
        qryAuxiliar.ExecSQL;
      end;

      cdsLotes.Next;
    end;

  finally
    FreeAndNil(qryAuxiliar);
  end;

end;

procedure TfrmControleSepAvulsa.cdsDadosAfterScroll(DataSet: TDataSet);
begin
  if Assigned(objSeparacaoAvulsa) then
    objSeparacaoAvulsa.strCodigo := DataSet.FieldByName('CSP_CODCSP').AsString;
end;

procedure TfrmControleSepAvulsa.pApagaPedidoDeReserva;
var
  qryAuxiliar : TUniQuery;
  strAutoincremFATGOR : String;
begin
  qryAuxiliar := fCriaQuery(nil);
  try
    qryAuxiliar.Close;
    qryAuxiliar.SQL.Text := objSeparacaoAvulsa.fRetornaSQLPedidoReserva;

    qryAuxiliar.ParamByName('AUTOINCREM').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
    qryAuxiliar.Open;

    If not qryAuxiliar.isEmpty Then
    Begin
      {Reprocessar Saldos}
      TFatGorFactory.fGetFatGor.pNotificaRobo(qryAuxiliar.FieldByName('FDO_NUMDOC').AsString, qryAuxiliar.FieldByName('FDO_ESPDOC').AsString, qryAuxiliar.FieldByName('FDO_CODEMP').AsString);

       strAutoincremFATGOR := qryAuxiliar.FieldByName('FDO_SEQGER').AsString;

       qryAuxiliar.Close;
       qryAuxiliar.SQL.Clear;
       qryAuxiliar.SQL.Add('DELETE FROM FATGOR WHERE AUTOINCREM = :AUTOINCREM');
       qryAuxiliar.ParamByName('AUTOINCREM').AsString := strAutoincremFATGOR;
       qryAuxiliar.ExecSQL;
    End;
  finally
    FreeAndNil(qryAuxiliar);
  end;
end;

class procedure TfrmControleSepAvulsa.pImprimeSeparacaoItem(strCodIte,
  strDesIte, strLocFis, strSigUni, strCodFab, strCodCli, strCodVen, strCodDig : String;
    fltPreVen: Double; strRefere : String = ''; strMsgLv1 : String = ''; fltQtdSep: Double = 1; pblnImpContinua: Boolean = False);
  Var
    qryCfgRel: TUniQuery;
    cdsItens : TUniClientDataSet;

    strSenha  : String;
    strCodOpe : String;
    strNumLot : String;
    qryCadLot : TUniQuery;
    edtCodIteC: TEditFocus;
    chrKey    : Char;
    arrSel    : TConsultasArray;
    objCadLot : TCadLot;

    objImpressao: TEditorFastImpressao;
    objSeparacaoAvulsa : TSeparacaoAvulsa;
    strEsp: string;
    strPDF: string;
    strTpLayout: string;
    intQtdImp: Integer;
    strNomeFila: string;
    strTipImp: string;

    fltQuantidade : double;

    Procedure pCriaCdItens;
    Begin
      cdsItens := TUniClientDataSet.Create(Application);
      With cdsItens Do
      Begin

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'CODITE';
          DataType := ftString;
          Size := fTamCodIte;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'DESITE';
          DataType := ftString;
          Size := 70;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'LOCFIS';
          DataType := ftString;
          Size := 60;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'UNIDAD';
          DataType := ftString;
          Size := 05;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'VALUNI';
          DataType := ftFloat;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'CODFAB';
          DataType := ftString;
          Size := 40;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'REFERE';
          DataType := ftString;
          Size := 16;
        End;

        With FieldDefs.AddFieldDef Do
        Begin
          Name := 'MSGLV1';
          DataType := ftString;
          Size := 50;
        End;

        CreateDataSet;

        Open;

        Insert;

        FieldByName('CODITE').AsString := strCodIte;
        FieldByName('DESITE').AsString := strDesIte;
        FieldByName('LOCFIS').AsString := strLocFis;
        FieldByName('UNIDAD').AsString := strSigUni;
        FieldByName('CODFAB').AsString := strCodFab;
        FieldByName('VALUNI').AsFloat  := fltPreVen;
        FieldByName('REFERE').AsString := strRefere;
        FieldByName('MSGLV1').AsString := strMsgLv1;

        Post;

      End;
    End;

    Function fGetSalto: String;
      Var
        strSalto : String;
        intQtdSal,
        intContador: Integer;
    Begin
      strSalto := '';
      intQtdSal := fCfgSis('QTDSAL', varInteger);
      For intContador := 1 To intQtdSal Do
        strSalto := strSalto + '       ' + #13#10;
      Result := strSalto;
    End;

    Procedure pIncluiDadosCabec;
    Begin
      With frmModuloFatImp, frxDocSepItem, Script Do
      Begin
        Variables['NOMFAN'] := fRetFantasiaEmpresa;
        Variables['CODCLI'] := strCodCli;
        Variables['NOMCLI'] := fRetNomCliente(strCodCli);
        Variables['VENDED'] := strCodVen + '-' + fRetNomVendRep(strCodVen);
        Variables['DIGITA'] := strCodDig + '-' + fRetNomVendRep(strCodDig) ;
        Variables['DTAENT'] := VS_Date;
        Variables['HORENT'] := fTime();
        Variables['SALTO']  := fGetSalto;
        Variables['OPELOG'] := strLoginUsuarioLogado + '-' + fRetNomVendRep(strLoginUsuarioLogado) ;
      End;

    End;

    function fImprimirLayoutEditor: Boolean;
      procedure pImprimir(tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string);
      Begin
        objImpressao := TEditorFastImpressao.Create(Nil);

        try
          With objImpressao Do
          Begin
            recDocume.strNumDoc := '';
            recDocume.strCodIte := strCodIte;
            recDocume.strCodCli := strCodCli;
            recDocume.strCodEmp := VS_strCodEmp;
            recDocume.strEspDoc := strEspecie;
            tpeTipoEtiqueta     := tpeSepItem;
            recDocume.intQtdImp := intQtdImp;
            recDocume.blnReimpr := False;
            recDocume.blnDocCan := False;
            recDocume.blnQtdOri := False;
            recDocume.blnConfir := False;
            recDocume.blnDocSep := False;
            recDocume.blnImpExpedicao := False;
            recDocume.blnFilEmp := False;
            recDocume.blnImpFil := False;
            recDocume.blnSepFut := False;
            recDocume.blnEnt_CD := False;
            recDocume.blnSimples               := False;
            recDocume.blnSempreEntr            := False;
            recDocume.blnRequisicao            := False;
            recDocume.blnLocFisEmpEmi          := False;
            recDocume.blnAgruparItensSeparacao := False;
            recDocume.blnVisPdf := False;
            recDocume.strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
            recDocume.fltQtdSep := fltQtdSep;
            If fEmptyStr(recDocume.strNomImp) Then
              recDocume.strSaida := 'P'
            Else
              recDocume.strSaida := 'I';

            Result := (fImprimeDocumento(tpArquivo, '', '')) And (objImpressao.recDocume.blnTemLay);

            if tpArquivo = tpaPDF Then
              StrPDFRet := strArqPDF;
          End;

        Finally
          FreeAndNil(objImpressao);
        End;
      End;
  begin
    Result := False;

    strTpLayout := 'Separação de Item';
    strEsp := 'IT';

    pImprimir(tpaNormal, strEsp, strPDF);
  end;

Begin
  objSeparacaoAvulsa := TSeparacaoAvulsa.Create(fCfgSis('UTCSEA', varString));
  try
    Try
      If objSeparacaoAvulsa.fUtilizaColetor and (Not fPergunta('Confirma a impressão da separação?')) Then
        Exit;

      If fCfgSis('UTCSEA', varString) <> 'N' Then
      Begin
        If ffrmSenha(strSenha, 'Digite sua senha para realizar a separação avulsa') Then
        Begin
          strCodOpe := fRetCodVendedor(strSenha);
          If fEmptyStr( fRetNomeOperador(strCodOpe) ) Then
          Begin
            fMensagem('', 'Senha inválida, operação não permitida!', ['&Ok']);
            Exit;
          End;

        End
        Else
          Exit;

        Try
          objCadLot := TCadLot.Create(nil);
          qryCadLot := fCriaQuery;
          edtCodIteC := TEditFocus.Create(Nil);
          edtCodIteC.Text := strCodIte;
          chrKey    := '/';

          strNumLot := '';
          strLocFis := '';
          fltQuantidade := 0;
          if objSeparacaoAvulsa.fUtilizaColetor then
          begin
              if not fDigQuantidade('Separação Avulsa', 'Quantidade a Separar', fltQuantidade, 0, -1, fCfgSis('DECUNI', varInteger)) then
                exit();
          end
          else
          begin

            If Not objCadLot.fItemSemNenhumLoteEmpresa(strCodIte) Then
            Begin
              If (fCfgSis('CTLEST') = '2') Then //Configurado que usa Armazem
                strNumLot := objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(strCodIte);

              If (Not fEmptyStr(strNumLot)) And (objCadLot.fSaldoLote(strCodIte, VS_strCodEmp, strNumLot) > 0) Then
              Begin
                strLocFis := objCadLot.fLocalizacaoFisicaLote(strCodIte, VS_strCodEmp, strNumLot);
              End
              Else If fPesqLoteItens(Nil, Nil, edtCodIteC, fCfgSis('DECUNI',varInteger), qryCadLot, chrKey, arrSel ) Then
              Begin
                strNumLot := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
                strLocFis := qryCadLot.FieldByName('LOT_LOCFIS').AsString;
              End
              Else
              Begin
                fMensagem('', 'Localização inválida, operação não permitida!', ['&Ok']);
                Exit;
              End;
            End;
          end;

        Finally
          FreeAndNil(objCadLot);
          FreeAndNil(qryCadLot);
          FreeAndNil(edtCodIteC);
        End;

        If not TfrmControleSepAvulsa.pRegistraImpressao(strCodOpe, strCodIte, strNumLot, fltQuantidade) Then
          Exit;
      End;

      If objSeparacaoAvulsa.fUtilizaColetor Then Begin
        pMensagemOk('Solicitação enviada!');
        Exit;
      End;

      qryCfgRel := fCriaQuery;
      Try
        pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP', VS_strCodEmp);

        If (fImprimirLayoutEditor()) Then
        Begin
          if Not pblnImpContinua then
            pMensagemOk('Separação impressa!');
          Exit;
        End;

        pCriarFormularios(TfrmModuloFatImp,frmModuloFatImp);

        fPreImpressao(qryCfgRel, strNomeFila,strTipImp,False);
      Finally
        FreeAndNil(qryCfgRel);
      End;


      if strTipImp = 'J' then
      begin
        frmModuloFatImp.frxDocSepItem := frmModuloFatImp.frxDocSep40Item_J;
      end
      else
      begin
        frmModuloFatImp.frxDocSepItem := frmModuloFatImp.frxDocSep40Item;
      end;

      With frmModuloFatImp, frxDocSepItem Do
      Begin
        pCriaCdItens;
        pIncluiDadosCabec;

        frxDBSepItem.DataSet := cdsItens;

        PrintOptions.Printer := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');

        If PrepareReport Then
        Begin
          PrintOptions.ShowDialog := fEmptyStr(strNomeFila);

          If fEmptyStr(strNomeFila) Then
            pPreviewReport('frmFatVendas_SEP', 'Impressão de separação avulsa', frxDocSepItem)
          Else
            pPrintReport('frmFatVendas_SEP', 'Impressão de separação avulsa', strNomeFila, frxDocSepItem);
        End;

        cdsItens.EmptyDataSet;
        FreeAndNil(cdsItens);
      End;

      FreeAndNil(frmModuloFatImp);

      pMensagemOk('Separação impressa!');

    Except
      On E: Exception Do
       pMensagensErro(E.Message, '[pImprimeSeparacaoItem]');
    End;
  finally
    FreeAndNil(objSeparacaoAvulsa);
  end;
End;

class function TfrmControleSepAvulsa.pRegistraImpressao(strCodOpe, strCodIte, strNumLot : String; fltQuantidade : Double): Boolean;
  Var
    qryInsert : TUniQuery;
    qryCadIte : TUniQuery;
    strCodBar : String;
    strLocFis : String;
begin
  qryCadIte := fCriaQuery(Application);
  Try
    With qryCadIte, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT I.ITE_CODITE,                                  ');
      Add('        I.ITE_CODBAR,                                  ');
      Add('        IFNULL(LOT_LOCFIS, G.ITE_LOCFIS) AS ITE_LOCFIS ');
      Add(' FROM ITEGER G                                         ');
      Add(' INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE    ');
      Add(' LEFT  JOIN CADLOT L ON L.LOT_CODITE = G.ITE_CODITE    ');
      Add('                    AND L.LOT_CODEMP = G.ITE_CODEMP    ');
      Add('                    AND L.LOT_NUMLOT = :NUMLOT         ');
      Add(' WHERE G.ITE_CODITE = :CODITE                          ');
      Add('   AND G.ITE_CODEMP = :CODEMP                          ');

      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('NUMLOT').AsString   := strNumLot;

      Open;

      strCodBar := FieldByName('ITE_CODBAR').AsString;
      strLocFis := FieldByName('ITE_LOCFIS').AsString;

    End;
  Finally
    FreeAndNil(qryCadIte);
  End;

  qryInsert := fCriaQuery(Application);
  Try
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;

      Add(' INSERT INTO CONSEP ( AUTOINCREM,                   ');
      Add('                      CSP_CODCSP,                   ');
      Add('                      CSP_CODEMP,                   ');
      Add('                      CSP_CODITE,                   ');
      Add('                      CSP_NUMLOT,                   ');
      Add('                      CSP_CODBAR,                   ');
      Add('                      CSP_LOCFIS,                   ');
      Add('                      CSP_OPEIMP,                   ');
      Add('                      CSP_DTAIMP,                   ');
      Add('                      CSP_QTDITE,                   ');
      Add('                      CSP_HRAIMP)                   ');
      Add('       VALUES       (  :AUTINC,                     ');
      Add('                       :CODCSP,                     ');
      Add('                       :CODEMP,                     ');
      Add('                       :CODITE,                     ');
      Add('                       :NUMLOT,                     ');
      Add('                       :CODBAR,                     ');
      Add('                       :LOCFIS,                     ');
      Add('                       :OPEIMP,                     ');
      Add('                       :DTAIMP,                     ');
      Add('                       :QTDITE,                     ');
      Add('                       :HRAIMP)                     ');

      ParamByName('AUTINC').AsString   := fRetAutoIncrem('CONSEP', VS_strCodEmp);
      ParamByName('CODCSP').AsString   := fAtualizaProCod('CONSEP', 'CSP_CODCSP');
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('QTDITE').AsFloat    := fltQuantidade;

      if not fEmptyStr(strNumLot) then
        ParamByName('NUMLOT').AsString   := strNumLot;

      if not fEmptyStr(strCodBar) then
        ParamByName('CODBAR').AsString   := strCodBar;

      if not fEmptyStr(strLocFis) then
        ParamByName('LOCFIS').AsString   := strLocFis;

      ParamByName('OPEIMP').AsString   := strCodOpe;
      ParamByName('DTAIMP').AsDateTime := VS_Date;
      ParamByName('HRAIMP').AsDateTime := fNow;

      Try
        ExecSQL;
        Result := True;
      Except
        On E : Exception Do
        Begin
          Result := False;
          pMensagensErro(e.Message, '');
        End;
      End;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;


Function TfrmControleSepAvulsa.fBuscaItem : Boolean;
  Var
    strCamBus : String;
    blnBarExp : Boolean;

  procedure pInverteBusca;
  begin
    If (strCamBus='BAREMB') Then
      strCamBus:='CODBAT'
    Else
      strCamBus:='BAREMB';
  end;

  Function fEncontraItem : Boolean;
  Begin
    If strCamBus = 'BAREMB' Then
      Result := (edtCodIte.Text = cdsDados.FieldByName('CODBAR').AsString) Or
                (Pos('-' + edtCodIte.Text + '-', cdsDados.FieldByName('BAREMB').AsString) > 0)
    Else
      Result := cdsDados.FieldByName('CSP_CODITE').AsString = edtCodIte.Text
  End;

begin

  If (Length(edtCodIte.Text) > fTamCodIte) Then
    strCamBus := 'BAREMB'
  Else
  Begin
    strCamBus := 'CODITE';
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

    If (blnBarExp) Then
    Begin
      edtCodIte.Clear;
      pMensagemSonora('Para expedir este produto é necessário informar o código de barras.');
      Result := False;
      Exit;
    End;
  End;

  If (strCamBus = 'CODITE') Then
  Begin
    Result := fEncontraItem;
  End
  Else
  Begin
    Result := fEncontraItem;

    If (Not Result) Then
    Begin
      pInverteBusca;
      Result := fEncontraItem;
    End;

  End;

  If (Not Result) Then
  Begin
    fMensagem('', 'Produto (' + edtCodIte.Text + ') não encontrado!', ['&Ok']);
  End;
End;

procedure TfrmControleSepAvulsa.pProcessaRegistro;
  Var
    strSenha : String;
    strCodOpe: String;
    strSeparador: String;
    qryAux: TUniQuery;
    strJustif: String;
    frmSeparacaoAvulsaEnviarSeparador: TfrmSeparacaoAvulsaEnviarSeparador;
    cdsLotes : TCdsLoteQuantidade;
Begin
  If ffrmSenha(strSenha, 'Digite sua senha para realizar a separação avulsa') Then
  Begin
    strCodOpe := fRetCodVendedor(strSenha);
    If fEmptyStr( fRetNomeOperador(strCodOpe) ) Then
    Begin
      fMensagem('', 'Senha inválida, operação não permitida!', ['&Ok']);
      Exit;
    End;

  End
  Else
    Exit;

  strJustif := '';
  If (tpAcao = opcBaixa) And (fMensagem('', 'Deseja digitar uma justificativa?', ['&Sim', '&Não']) = 1) Then
  Begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.lblMensagem.Caption := 'Justificativa';
    frmObservacao.memObs.MaxLength := 80;
    frmObservacao.blnUtilizarConfirmacao := True;
    frmObservacao.ShowModal;
    If  frmObservacao.blnConfirmou Then
      strJustif := frmObservacao.memObs.Texto
    Else
    Begin
      fMensagem('','Justificativa obrigatória!' + #13 + 'Operação não realizada!', ['&Ok']);
      FreeAndNil(frmObservacao);
      Exit;
    End;
    FreeAndNil(frmObservacao);
  End;

  qryAux := fCriaQuery;
  cdsLotes := TCdsLoteQuantidade.Create(nil);
  Try
    if (tpAcao = opcEnviarSeparador) then
    begin
      pCriarFormularios(TfrmSeparacaoAvulsaEnviarSeparador, frmSeparacaoAvulsaEnviarSeparador);
      try
        frmSeparacaoAvulsaEnviarSeparador.strCodigoProduto := cdsDados.FieldByName('CSP_CODITE').AsString;
        frmSeparacaoAvulsaEnviarSeparador.fltQuantidadeSolicitada := cdsDados.FieldByName('CSP_QTDITE').AsFloat;

        if frmSeparacaoAvulsaEnviarSeparador.ShowModal = mrOk then
        begin
          strSeparador := frmSeparacaoAvulsaEnviarSeparador.edtCodigoSeparador.Text;
          cdsLotes.Data := frmSeparacaoAvulsaEnviarSeparador.cdsLotes.Data;
        end
        else
          exit();
      finally
        pFreeAndNil(frmSeparacaoAvulsaEnviarSeparador);
      end;

    end;

    fStartTransaction;
    try
      if tpAcao = opcBaixa then
        pApagaPedidoDeReserva;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' UPDATE CONSEP SET                       ');

      If tpAcao in [opcSaida, opcEnviarSeparador] Then
      Begin
        qryAux.SQL.Add('                   CSP_OPESAI = :CODOPE, ');
        qryAux.SQL.Add('                   CSP_DTASAI = :CSPDTA, ');
        qryAux.SQL.Add('                   CSP_HRASAI = :CSPHRA  ');
      End
      Else
      If tpAcao = opcDevolucao Then
      Begin
        qryAux.SQL.Add('                   CSP_OPEDEV = :CODOPE, ');
        qryAux.SQL.Add('                   CSP_DTADEV = :CSPDTA, ');
        qryAux.SQL.Add('                   CSP_HRADEV = :CSPHRA  ');
      End
      Else
      If tpAcao = opcBaixa Then
      Begin
        qryAux.SQL.Add('                   CSP_OPEBAI = :CODOPE, ');
        qryAux.SQL.Add('                   CSP_DTABAI = :CSPDTA, ');
        qryAux.SQL.Add('                   CSP_HRABAI = :CSPHRA  ');

        If Not fEmptyStr(strJustif) Then
          qryAux.SQL.Add('                ,CSP_JUSBAI = :JUSBAI ');
      End;

      qryAux.SQL.Add(' WHERE AUTOINCREM = :AUTINC              ');

      qryAux.ParamByName('CODOPE').AsString   := strCodOpe;
      qryAux.ParamByName('CSPDTA').AsDateTime := VS_Date;
      qryAux.ParamByName('CSPHRA').AsDateTime := fNow;
      qryAux.ParamByName('AUTINC').AsString   := cdsDados.FieldByName('AUTOINCREM').AsString;

      If Not fEmptyStr(strJustif) Then
        qryAux.ParamByName('JUSBAI').AsString := strJustif;

      qryAux.ExecSql;

      If tpAcao = opcEnviarSeparador Then
      begin
        if not fGravarEnvioSeparador(strSeparador, cdsLotes) then
          Raise Exception.Create('Erro ao enviar ao separador');
      end;

      fCommit();

      pSetFocus(cxgDados);
    Except
      On E: Exception do
      begin
        fRollBack();
        Raise E;
      end;
    end;

  Finally
    FreeAndNil(cdsLotes);
    FreeAndNil(qryAux);
  End;

End;




end.
