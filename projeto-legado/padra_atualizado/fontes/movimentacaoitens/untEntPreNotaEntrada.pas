unit untEntPreNotaEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untFuncoesSimples,
  frxClass, frxDBSet, StrUtils,
  Math, BitBtnLockedIncrem, DBCtrls, DBEditFocus,
  MemDS, DBAccess, Datasnap.Provider, frxExportCSVTestabilidade,
  MaskUtils, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untZClient, cxMaskEdit, Datasnap.DBClient,  untFuncoesGenerica,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  untMsgLiberacao, DBMemoFocus;

type
  TfrmEntPreNotaEntrada = class(TfrmPaiOrdena)
    cdsConsultaITE_CODITE: TStringField;
    cdsConsultaITE_DESITE: TStringField;
    cdsConsultaITE_APLICA: TMemoField;
    cdsConsultaITE_CODBAR: TStringField;
    cdsConsultaITE_REFERE: TStringField;
    cdsConsultaITE_DESUNI: TStringField;
    cdsConsultaITE_QTDNFE: TFloatField;
    cdsCriticas: TUniClientDataSet;
    cdsCriticasCODITE: TStringField;
    cdsCriticasQTDPED: TFloatField;
    cdsCriticasQTDNFE: TFloatField;
    cdsCriticasDESITE: TStringField;
    cdsCriticasSIGUNI: TStringField;
    cdsConsultaITE_CODFAB: TStringField;
    cdsConsultaITE_LOCFIS: TStringField;
    cdsCriticasCODFAB: TStringField;
    cdsCriticasLOCFIS: TStringField;
    cdsCriticasSALDOS: TFloatField;
    cdsConsultaITE_SALDOS: TFloatField;
    cdsConsultaPCG_CODEMP: TStringField;
    cdsConsultaITE_QTDPED: TFloatField;
    cdsConsultaAUTOINCREM: TStringField;
    btnCriticas: TBitBtnLocked;
    cdsConsultaITE_UNIPED: TFloatField;
    cdsConsultaITE_UNINFE: TFloatField;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    cdsCriticasUNIPED: TFloatField;
    cdsCriticasUNINFE: TFloatField;
    btnConfirma: TBitBtnLocked;
    cdsCriticasINFADI: TStringField;
    pnlTotais: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    lblFrePed: TLabel;
    edtDifFre: TEditFocus;
    cdsConsultaITE_IPIPED: TFloatField;
    cdsConsultaITE_IPINFE: TFloatField;
    cdsConsultaITE_SUBPED: TFloatField;
    cdsConsultaITE_SUBNFE: TFloatField;
    cdsCriticasIPIPED: TFloatField;
    cdsCriticasIPINFE: TFloatField;
    cdsCriticasSUBPED: TFloatField;
    cdsCriticasSUBNFE: TFloatField;
    cdsCriticasFREPED: TFloatField;
    edtFreNfe: TEditFocus;
    edtFrePed: TEditFocus;
    Label6: TLabel;
    cdsCriticasNFEEAN: TStringField;
    cdsConsultaITE_NFEEAN: TStringField;
    cdsCriticasCODBAR: TStringField;
    pnlConPag: TPanel;
    pnlConGerEle: TPanel;
    cxgPedidosView: TcxGridDBTableView;
    cxgPedidosLevel1: TcxGridLevel;
    cxgPedidos: TcxGrid;
    cxgPedidosNUMPED: TcxGridDBColumn;
    cxgPedidosCONPAG: TcxGridDBColumn;
    cxgPedidosPRAMED: TcxGridDBColumn;
    cxgPedidosCODEMP: TcxGridDBColumn;
    lblConPagNot: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    Shape4: TShape;
    Label8: TLabel;
    Panel1: TPanel;
    lblNotEle: TLabel;
    btnNotEle: TBitBtnLocked;
    edtNotEle: TEditFocus;
    Panel2: TPanel;
    lblTipoDoc: TLabel;
    edtNumPed: TEditFocus;
    edtLisPed: TEditFocus;
    pnlCnvEmb: TPanel;
    rdgTipUni: TRadioGroup;
    lblLegendaCNVEMB: TLabel;
    chkOcultarItens: TCheckBox;
    Label7: TLabel;
    Label9: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    cxgPedidosTRAPED: TcxGridDBColumn;
    cdsCriticasTRAPED: TStringField;
    cdsCriticasTRAXML: TStringField;
    Splitter1: TSplitter;
    cdsCriticasAUTNFE: TStringField;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsConsultaAfterClose(DataSet: TDataSet);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumPedEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriticasClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNotEleClick(Sender: TObject);
    procedure btnNotEleEnter(Sender: TObject);
    procedure btnNotEleExit(Sender: TObject);
    procedure edtQtdIteKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgPedidosPRAMEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPedidosTRAPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPedidosTRAPEDGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
  private
    { Private declarations }
    fltOciVlr : Double;
    FPais: TPais;

    blnTravaJaAssociados: Boolean;

    strCnvEmb,
    strConPagNota: String;

    cdsPedidos: TZClient;

    strCodFor: String;

    stlPedidos: TStringList;
    stlEmpresas: TStringList;
    stlAutoinc: TStringList;


    recNotEle: TRecInfoNotaEletronica;

    intDecimaisQuantidade: Integer;
    strTipFreNFE : String;
    strCnpjTrans : String;

    arrTipoFretePed : Array of Array[0..1] of String;

    objLiberacao : TLiberacao;
    blnExiApl : Boolean;

    Function fSQLPedidos: String;
    function fTraduzFrete(strFreNFe : String) : String;
    Function fSomaItem(fltQtdIte, fltUnitario, fltIpiIte, fltSubIte: Double; strNfeEan : String): Boolean;
    Function fRegistraItem(strCodItem: String; fltQtdItem, fltUnitario, fltIpiItem, fltSubItem: Double; strNfeEan : String): Boolean;

    function fPermitePedidosJaAssociados(strNumPed: String; Var strNotas: String): Boolean;

    procedure pMostraCndPagNota(strCndPag: String);
    procedure pMostraConPagPedidos;

    procedure pIncluiCritica(strCodIte,
                             strDesIte,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdPed,
                             fltQtdNfe,
                             fltSaldos,
                             fltUniPed,
                             fltUniNfe,
                             fltIpiPed,
                             fltIpiNfe,
                             fltSubPed,
                             fltSubNfe,
                             fltFrePed,
                             fltFreNfe: Double;
                             strNfeEan,
                             strTraPed,
                             strTraXml,
                             strNFE: String);

    procedure pCancela(blnPerguntar: Boolean = True);
    Procedure pSetaRequeridos;

    function fPosssuiInconsistencias(prcFiltro: TFilterRecordEvent = Nil): Boolean;
    function fPosssuiInconsistenciasFrete : Boolean;
    function fCnpjTransportadoraDiferente(strNumped: string = ''): Boolean;

    function fIncluiItem(strCodIte: String; fltQtdIte: Double; fltUnitario, fltIpiIte, fltSubIte: Double; strNfeEan : String): Boolean;
    function fCalculaFretePedidos: Double;

    procedure pCarregaItensNotaEletronica;
    procedure pRemoverItensNaoEstaoNotaEletronica;
    procedure pInsereItensCdsCriticas;

    function fVerificaItensComPrecoDivergentesPedidos: Boolean;
    procedure pMostraMemo(stlIncon: TStrings);
    procedure pVerificaItensComProblemasCadastro;
    function fRetCdsInconsistenciaCadastrais : TUniClientDataSet;
    Function fPosssuiInconsistenciaCondPagto: Boolean;
    procedure OnFilterRecordDifTolerancia(DataSet: TDataSet;
      var Accept: Boolean);

    procedure OnFilterRecordDifToleranciaFrete(DataSet: TDataSet; var Accept: Boolean);

    procedure OnFilterRecordErros(DataSet: TDataSet; var Accept: Boolean);

    procedure pOnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean; blnComFrete: Boolean);


  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
  end;

var
  frmEntPreNotaEntrada: TfrmEntPreNotaEntrada;

implementation

uses  untPai, untTipoFreteAtc,untEntConferenciaFuncoes, untTypesSistema,
      untEntConfPedidos, untMemo, untFuncFat, untConsultas, untRelEntCriticasPreNota,
      untEntPreNotaEntradaMotivoLib, untConstantes, untTypesCRM,
      untFuncoesPedidoSimples,
      untAtualizaOcorrenciasCRM, untFuncoes;

{$R *.dfm}

Procedure TfrmEntPreNotaEntrada.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
  For intIndex := 0 To FieldDefs.Count - 1 Do
    FieldDefs[intIndex].Required := FALSE;
End;

function TfrmEntPreNotaEntrada.fPermitePedidosJaAssociados(strNumPed: String; Var strNotas: String): Boolean;
  Var
    strSQL: String;
    qryNotas: TUniQuery;
Begin
  strNotas := '';
  Result   := True;

  If blnTravaJaAssociados Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT GROUP_CONCAT(B08_NNF) AS NOTAS FROM GERELE G ';
    strSQL := strSQL + ' INNER JOIN PEDELE ON PEL_SEQELE = G.AUTOINCREM ';
    strSQL := strSQL + ' WHERE                                     ';
    strSQL := strSQL + '   GER_DOCENT IS NULL                      ';
    strSQL := strSQL + '   AND PEL_NUMDOC = :NUMPED           ';
    strSQL := strSQL + '   AND PEL_ESPDOC = "PD"                   ';
    strSQL := strSQL + '   AND PEL_CODEMP = :CODEMP           ';

    qryNotas := fCriaQuery;
    qryNotas.SQL.Text := strSQL;
    qryNotas.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNotas.ParamByName('NUMPED').AsString := strNumPed;
    qryNotas.Open;

    strNotas := qryNotas.FieldByName('NOTAS').AsString;

    Result   := fEmptyStr(strNotas);

    FreeAndNil(qryNotas);
  End;
End;

function TfrmEntPreNotaEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnLiberado,
    blnConferido,
    blnBaixado,
    blnOriundo,
    blnImportado,
    blnMaisDeUm: Boolean;
    strEmpDes,
    strEmpres,
    strNumPed,
    strPreNot,
    strNotas,
    strAutInc: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin
      cdsPedidos.Close;

      strNumPed := edtNumPed.Text;

      If Not fEmptyStr(strNumPed) Then
      Begin

        If Not fPedidoCompraCadastrado(edtNumPed.Text, VS_strCodEmp, 'PD',
                blnLiberado, blnConferido, blnBaixado, blnOriundo, blnImportado, blnMaisDeUm,
                strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Pedido não está cadastrado!', ['&O k']);
          Result := FALSE;
        End

        Else If fEhPedidoCompraMultiLoja(edtNumPed.Text, 'PD', VS_strCodEmp) Then
        Begin
          pMensagemOk('Esse pedido de compra é multi-loja e deve ser desmembrado para utilização!');
          Result := FALSE;
        End

        Else If (strCodFor <> recNotEle.strCodFor) And
                ((Not fPermitePedidosJaAssociados(edtNumPed.Text, strNotas)) Or
                 (Not fVeSeAtualizaPedidoCompra(edtNumPed.Text, VS_strCodEmp, recNotEle.strCodFor, strCodFor, False))) Then
        Begin
          If fEmptyStr(strNotas) Then
            fMensagem('ATENÇÃO!', 'O Fornecedor do Pedido e da NFe são diferentes!', ['&O k'])
          Else
            pMensagemOk('Esse pedido já está associado com a(s) nota(s) ' + strNotas + #13#10 +
                'e somente poderá ser utilizado após a entrada de mercadorias das notas listadas!');
          Result := FALSE;
        End

        Else If blnConferido Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Pedido já foi conferido!', ['&O k']);
          Result := FALSE;
        End

        Else If (Not blnLiberado) And fCfgSis('LIBPCM', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Pedido de Compra não está liberado!', ['&O k']);
          Result := FALSE;
        End

        Else
        Begin
          edtLisPed.Visible := False;
          edtLisPed.Clear;
        End;

      End

      Else If stlPedidos.Count = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhum pedido selecionado!', ['&O k']);
        Result := FALSE;
        stlAutoinc.Clear;
      End
      Else
        fPedidoCompraCadastrado(stlPedidos[0], VS_strCodEmp, 'PD', blnLiberado, blnConferido, blnBaixado,
          blnOriundo, blnImportado, blnMaisDeUm, strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc);

      If Result And (stlPedidos.Count = 0) Then
      Begin
        stlEmpresas.Clear;
        stlPedidos.Add(strNumPed);
        stlEmpresas.Add(strEmpres);
        stlAutoinc.Add(strAutInc);
      End;

      If Result And fEmptyStr(recNotEle.strAutInc) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione a Nota Fiscal Eletrônica!', ['&O k']);
        blnMudarFoco  := False;
        pSetfocus(btnNotEle);
        Result := FALSE;
        Exit;
      End;

      If Result And fAbreConsulta(TRUE) Then
      Begin
        edtDifFre.Text := FormatFloat('#,##0.00', (fStrToFloat(edtFrePed.Text) - fStrToFloat(edtFreNfe.Text)));

        If (edtFrePed.Text <> edtFreNfe.Text) Then
        Begin
          edtFrePed.Color      := clRed;
          edtFrePed.Font.Color := clWhite;
          edtFreNfe.Color      := clRed;
          edtFreNfe.Font.Color := clWhite;
          edtDifFre.Color      := clRed;
          edtDifFre.Font.Color := clWhite;
        End;

        pnlTail.Enabled := TRUE;
        edtNumPed.Enabled := False;
        btnNotEle.Enabled := False;
        rdgTipUni.Enabled := False;
        chkOcultarItens.Enabled := False;
        pSetFocus(dbgConsulta);

        pMostraConPagPedidos;

        Exit;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmEntPreNotaEntrada.fGetSql(blnLike: Boolean): String;
  Var
    strEMBPED: String;
Begin
  {*****************************}
  {* INCLUSÃO DE IPI E SUBST.  *}
  {**************************CI*}

  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                              ';
  Result := Result + '   GROUP_CONCAT(DISTINCT PCD_NUMPED) AS ITE_NUMPED,               ';
  Result := Result + '   IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) AS PCG_CODEMP,     ';
  Result := Result + '   PCD_CODITE AS AUTOINCREM,                                      ';
  Result := Result + '   PCD_CODITE AS ITE_CODITE,                                      ';
  Result := Result + '   0.0000 AS ITE_QTDNFE,                                          ';
  Result := Result + '   0.0000 AS ITE_UNINFE,                                          ';
  Result := Result + '   0.0000 AS ITE_IPINFE,                                          ';
  Result := Result + '   0.0000 AS ITE_SUBNFE,                                          ';
  Result := Result + '   "                         " AS ITE_NFEEAN,                     ';

  If fCfgSis('CNVEMB') <> 'N' Then
  Begin
    // ASSUME QUE A NFE ESTÁ SEMPRE EM UNIDADE DE COMPRA.
    // SE O PEDIDO ESTIVER EM UNIDADE DE VENDA ENTÃO É NECESSÁRIO CONVERTER PARA UNIDADE DE COMPRA
    strEMBPED := ' IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) ';

    Result := Result + '   SUM(ROUND(PCD_QTDITE - PCD_QTDBAI,' + fCfgSis('DEQTPC') + ') * ' + strEMBPED + ') AS ITE_QTDPED, ';

    Result := Result + '   ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '      , 4) / ' + strEMBPED + ' AS ITE_UNIPED,  ';

    Result := Result + '   ROUND((ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '      , 4) / ' + strEMBPED + ') * PCD_PERIPI / 100, 4) AS ITE_IPIPED, ';


    Result := Result + '   ROUND(SUM(PCD_TOTSUB) / SUM(PCD_QTDITE * ' + strEMBPED + '), 4) AS ITE_SUBPED, ';
  End Else
  Begin
    Result := Result + '   SUM(ROUND(PCD_QTDITE - PCD_QTDBAI,' + fCfgSis('DEQTPC') + ')) AS ITE_QTDPED, ';

    Result := Result + '   ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '                 , 4)  AS ITE_UNIPED,  ';

    Result := Result + '   ROUND(ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '                 , 4) * PCD_PERIPI / 100, 4) AS ITE_IPIPED,   ';

    Result := Result + '   ROUND(SUM(PCD_TOTSUB) / SUM(PCD_QTDITE), 4) AS ITE_SUBPED, ';
  End;

  Result := Result + '   IF(IFNULL(ITE_CODBAR,"") = "", "-", ITE_CODBAR) AS ITE_CODBAR, ';
  Result := Result + '   IF(IFNULL(ITE_CODFAB,"") = "", "-", ITE_CODFAB) AS ITE_CODFAB, ';
  Result := Result + '   IF(IFNULL(ITE_DESITE,"") = "", "-", ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '   ITE_APLICA AS ITE_APLICA,                                      ';
  Result := Result + '   IF(IFNULL(ITE_REFERE,"") = "", "-", ITE_REFERE) AS ITE_REFERE, ';
  Result := Result + '   UNI_SIGUNI AS ITE_DESUNI,                                      ';
  Result := Result + '   IF(IFNULL(ITE_LOCFIS,"") = "", "-", ITE_LOCFIS) AS ITE_LOCFIS, ';
  Result := Result + '   ITE_SALDOS                                      AS ITE_SALDOS  ';
  Result := Result + ' FROM          ';
  Result := Result + '   PCMDET D    ';
  Result := Result + '   INNER JOIN PCMGER   ON PCG_NUMPED = PCD_NUMPED AND ';
  Result := Result + '                          PCG_ESPDOC = PCD_ESPDOC AND ';
  Result := Result + '                          PCG_CODEMP = PCD_CODEMP AND ';
  Result := Result + '                          PCG_NUMCTN = PCD_NUMCTN     ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE ';

  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND ';
  Result := Result + '                          G.ITE_CODEMP = '+ QuotedStr(VS_strCodEmp) + ' ';

  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + ' WHERE      ';
  Result := Result + '   PCD_ESPDOC = "PD" AND ';
  Result := Result + '   PCD_NUMCTN = 0 AND ';
  Result := Result + '   PCD_BAIXAD = 0 AND ';
  Result := Result + '   ROUND(PCD_QTDITE - PCD_QTDBAI,' + fCfgSis('DEQTPC') + ') > 0 AND ';

  Result := Result + '   PCMGER.AUTOINCREM IN (' +  fCommaText(stlAutoinc, True) + ') ';

  Result := Result + ' GROUP BY      ';
  Result := Result + '   PCD_CODITE, ';

  If fCfgSis('CNVEMB') <> 'N' Then
  Begin

    Result := Result + '  ROUND(ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '      , 4) / ' + strEMBPED + ', 4) ';

  End Else
  Begin

    Result := Result + '   ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '                 , 4)  ';

  End;

End;

Function TfrmEntPreNotaEntrada.fRegistraItem(strCodItem: String; fltQtdItem, fltUnitario, fltIpiItem, fltSubItem: Double; strNfeEan : String): Boolean;
begin
  Result := FALSE;

  If fEmptyStr(strCodItem) Then
    Exit;

  If fltQtdItem <= 0 Then
    Exit;

  With cdsConsulta Do
  Begin
    If Locate('ITE_CODITE', strCodItem, []) Then
      Result := fSomaItem(fltQtdItem, fltUnitario, fltIpiItem, fltSubItem, strNfeEan)
    Else
      Result := fIncluiItem(strCodItem, fltQtdItem, fltUnitario, fltIpiItem, fltSubItem, strNfeEan);
  End;
end;

function TfrmEntPreNotaEntrada.fRetCdsInconsistenciaCadastrais: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  Result.Data := cdsCriticas.Data;
  Result.Filter := 'INFADI <> ' + QuotedStr('') + ' AND CODITE <> ' + QuotedStr('00000');
  Result.Filtered := True;

  cdsCriticas.Filtered := False;
  cdsCriticas.Filter := ReplaceStr(cdsCriticas.Filter, 'OR (INFADI <> '''')', '' );
  cdsCriticas.Filtered := True;
end;

Function TfrmEntPreNotaEntrada.fSomaItem(fltQtdIte, fltUnitario, fltIpiIte, fltSubIte: Double; strNfeEan : String): Boolean;
Begin
  Result := FALSE;

  With cdsConsulta Do
  Begin
    Try
      {*****************************}
      {* INCLUSÃO DE IPI E SUBST.  *}
      {**************************CI*}

      Edit;
      FieldByName('ITE_QTDNFE').AsFloat := FieldByName('ITE_QTDNFE').AsFloat + fltQtdIte;
      FieldByName('ITE_IPINFE').AsFloat := RoundTo(fltIpiIte / fltQtdIte, -4);
      FieldByName('ITE_SUBNFE').AsFloat := RoundTo(fltSubIte / fltQtdIte, -4);
      FieldByName('ITE_UNINFE').AsFloat := fltUnitario;
      FieldByName('ITE_NFEEAN').AsString:= strNfeEan;
      Post;
      Result := TRUE;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fSomaItem]');
      End;
    End;
  End;
End;

function TfrmEntPreNotaEntrada.fTraduzFrete(strFreNFe: String): String;
begin
  if strFreNfe = '0' Then Result := '1';
  if strFreNfe = '1' Then Result := '2';
  if strFreNfe = '2' Then Result := '3';
  if strFreNfe = '9' Then Result := '9';
end;

procedure TfrmEntPreNotaEntrada.pCancela(blnPerguntar: Boolean = True);
Begin
  If (edtNumPed.Focused) Or (btnNotEle.Focused) Or cdsConsulta.IsEmpty Then
  begin

    If Not fEmptyStr(recNotEle.strAutInc) Then
      fLock_Unlock('NFE' + recNotEle.strAutInc, False, False, True);

    Close;
  end

  Else If (Not blnPerguntar) Or
          (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin
    If Not fEmptyStr(recNotEle.strAutInc) Then
      fLock_Unlock('NFE' + recNotEle.strAutInc, False, False, True);

    pLimpaPesquisa;
    edtNumPed.Enabled := True;
    btnNotEle.Enabled := True;
    rdgTipUni.Enabled := True;
    chkOcultarItens.Enabled := True;

    pSetFocus(btnNotEle);

    FillChar(recNotEle, SizeOf(recNotEle), #0);
    edtNotEle.Clear;
    rdgTipUni.ItemIndex := 0;
    edtNumPed.Clear;
    stlPedidos.Clear;
    edtLisPed.Clear;
    stlAutoInc.Clear;
    pMostraConPagPedidos;
  End;

End;

procedure TfrmEntPreNotaEntrada.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F9: btnCriticas.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_ESCAPE:  If pnlPesquisa.Visible Then
                 inherited                      
                Else
                  pCancela;

    Else inherited;
  End;

end;

procedure TfrmEntPreNotaEntrada.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  If fCfgSis('CNVEMB') <> 'S' Then
  Begin
    pnlCnvEmb.Visible        := False;
    pnlHeader.Height         := pnlHeader.Height - pnlCnvEmb.Height;
  End;

  pSetFocus(btnNotEle);
end;

procedure TfrmEntPreNotaEntrada.pMostraCndPagNota(strCndPag: String);
Begin
  lblConPagNot.Caption := 'Condição de Pagamento da Nota Eletrônica: ' +
    FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', strCndPag);
  If (strTipFreNfe = '2') Then
  lblConPagNot.Caption := lblConPagNot.Caption + ' Transportadora NF: ' + fFormataCpfCgc(strCnpjTrans, FPais);
End;

procedure TfrmEntPreNotaEntrada.btnNotEleClick(Sender: TObject);
  Var
    qryGerEle: TUniQuery;
    chrKey: Char;
    arrPreNota: TConsultasArray;
begin
  inherited;

  {*******************************************}
  {* NOVA CONSULTA DE NOTA FISCAL ELETRONICA *}
  {****************************************AC*}

  Try
    qryGerEle := fCriaQuery(Self);

    chrKey := '/';
    if fPesqGerelePreNotaEntrada(Self, edtNotEle, qryGerEle, recNotEle, chrKey, arrPreNota) then
    begin
      If Not fLock_Unlock('NFE' + recNotEle.strAutInc, True, False, True) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                      fGetHostLock('NFE' + recNotEle.strAutInc)  + '!', ['&Ok']);
        Exit;
      End;
      edtFreNfe.Text := FormatFloat('#,##0.00', qryGerEle.FieldByName('W08_VFRETE').AsFloat);
      strTipFreNFE   := fTraduzFrete(qryGerEle.FieldByName('X33_MODFRETE').AsString);
      strCnpjTrans  := qryGerEle.FieldByName('X34_CNPJ').AsString;
      strConPagNota  := fCampoTabela('GER_CONPAG', 'GERELE', ['AUTOINCREM'], [recNotEle.strAutInc]);
      SelectNext(ActiveControl, True, True);

    end else
    begin
      FillChar(recNotEle, SizeOf(recNotEle), #0);
      edtNotEle.Clear;
      rdgTipUni.ItemIndex := 0;
      strConPagNota := '';
      SelectNext(ActiveControl, True, True);
    end;

    pMostraCndPagNota(strConPagNota);

  Finally
    FreeAndNil(qryGerEle);
  End;

end;

procedure TfrmEntPreNotaEntrada.btnNotEleEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  FillChar(recNotEle, SizeOf(recNotEle), #0);
  edtNotEle.Clear;
  rdgTipUni.ItemIndex := 0;
end;

procedure TfrmEntPreNotaEntrada.btnNotEleExit(Sender: TObject);
begin
  inherited;
  If btnSair.Focused Then
    Exit;

  If fEmptyStr(recNotEle.strNumDoc) Then
  Begin
    fMensagem('','Selecione a NFe !', ['&Ok']);
    pSetFocus(btnNotEle);
  End
  Else
    pSetFocus(edtNumPed);
end;

procedure TfrmEntPreNotaEntrada.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmEntPreNotaEntrada.cdsConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;
  pnlTail.Enabled := FALSE;

  edtLisPed.Clear;
  stlPedidos.Clear;
  stlAutoinc.Clear;
  pMostraConPagPedidos;
end;

procedure TfrmEntPreNotaEntrada.cxgPedidosPRAMEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltPraNot: Double;
begin
  inherited;

  fltPraNot := fCalcMediaPagto(strConPagNota);

  If RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                      cxgPedidosPRAMED.Index])), -2) > RoundTo(fltPraNot, -2)  Then
  Begin
    ACanvas.Brush.Color := clRed;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End

  Else If RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                   cxgPedidosPRAMED.Index])), -2) < RoundTo(fltPraNot, -2)  Then
  Begin
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmEntPreNotaEntrada.cxgPedidosTRAPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var strCnpjTraPed: string;
begin
  inherited;
  //Quando o tipo frete for Destinatario (FOB) E CNPJ Transportadora diferente
  strCnpjTraPed := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                      cxgPedidosTRAPED.Index]));
  If (strTipFreNfe = '2') And (strCnpjTraPed <> strCnpjTrans) Then
  Begin
    If LeftStr(strCnpjTraPed, 8) <> LeftStr(strCnpjTrans, 8) Then
      ACanvas.Brush.Color := clRed
    Else
      ACanvas.Brush.Color := clyellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmEntPreNotaEntrada.cxgPedidosTRAPEDGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  Atext := fFormataCpfCgc(AText, FPais);
end;

procedure TfrmEntPreNotaEntrada.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    blnTemQtd,
    blnInconsistencia: Boolean;
begin
  inherited;

  blnTemQtd := (fFormataFloat(cdsConsultaITE_QTDNFE.AsFloat, intDecimaisQuantidade) > 0) And
               (fFormataFloat(cdsConsultaITE_QTDPED.AsFloat, intDecimaisQuantidade) > 0);

  If (Pos(Column.FieldName, 'ITE_QTDPED_ITE_QTDNFE_') > 0) Then
  Begin
    blnInconsistencia := Abs(fFormataFloat(cdsConsultaITE_QTDNFE.AsFloat, intDecimaisQuantidade) -
                          fFormataFloat(cdsConsultaITE_QTDPED.AsFloat, intDecimaisQuantidade)) > fltOciVlr;
    If blnInconsistencia Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clYellow;
      dbgConsulta.Canvas.Font.Color  := clBlack;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

  End;

  If (Pos(Column.FieldName, 'ITE_UNIPED_ITE_UNINFE_') > 0) Then
  Begin
    blnInconsistencia := (Abs(fFormataFloat(cdsConsultaITE_UNIPED.AsFloat, 4) -
                             fFormataFloat(cdsConsultaITE_UNINFE.AsFloat, 4)) > fltOciVlr);

    If blnInconsistencia Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clRed;
      dbgConsulta.Canvas.Font.Color  := clWhite;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

  End;

  {*****************************}
  {* INCLUSÃO DE IPI E SUBST.  *}
  {**************************CI*}

  If (Pos(Column.FieldName, 'ITE_IPIPED_ITE_IPINFE_') > 0) Then
  Begin
    blnInconsistencia := blnTemQtd And
                         (Abs(fFormataFloat(cdsConsultaITE_IPIPED.AsFloat, 4) -
                          fFormataFloat(cdsConsultaITE_IPINFE.AsFloat, 4)) > fltOciVlr);

    If blnInconsistencia Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clRed;
      dbgConsulta.Canvas.Font.Color  := clWhite;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

  End;

  If (Pos(Column.FieldName, 'ITE_SUBPED_ITE_SUBNFE_') > 0) Then
  Begin
    blnInconsistencia := blnTemQtd And
                         (Abs(fFormataFloat(cdsConsultaITE_SUBPED.AsFloat, 4) -
                          fFormataFloat(cdsConsultaITE_SUBNFE.AsFloat, 4)) > fltOciVlr);

    If blnInconsistencia Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clRed;
      dbgConsulta.Canvas.Font.Color  := clWhite;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

  End;

end;

procedure TfrmEntPreNotaEntrada.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    objConEnt: TConfereEntrada;
    stlRegSel: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlRegSel := TStringList.Create;
    objConEnt := TConfereEntrada.Create(stlPedidos, stlEmpresas);
    objConEnt.strCodFor := recNotEle.strCodFor;
    pCriarFormularios(TfrmEntConfPedidos, frmEntConfPedidos);

    Try
      frmEntConfPedidos.blnPreNota := True;
      frmEntConfPedidos.blnSalvaFornecedor := False;
      frmEntConfPedidos.strCodFor := recNotEle.strCodFor;
      frmEntConfPedidos.blnSelGarantia := (recNotEle.finalidadeXML = xmlGarantiaRetFornecedor);
      frmEntConfPedidos.objConEnt := objConEnt;
      frmEntConfPedidos.stlRegSel := stlRegSel;

      If frmEntConfPedidos.ShowModal = mrOK Then
      Begin
        stlAutoinc.Text  := frmEntConfPedidos.stlListSelecao.Text;
        objConEnt.pRetListaPedidos(stlPedidos, stlEmpresas, stlAutoinc, frmEntConfPedidos.cdsConsulta);
        edtNumPed.Clear;

        edtLisPed.Visible := True;
        edtLisPed.Text := stlPedidos.CommaText;

        fValidaCampos(edtNumPed);
      End;
    Finally
      FreeAndNil(stlRegSel);
      FreeAndNil(objConEnt);
      FreeAndNil(frmEntConfPedidos);
    End;

  End;

end;

procedure TfrmEntPreNotaEntrada.edtQtdIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmEntPreNotaEntrada.edtNumPedEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  edtNumPed.Clear;
end;

function TfrmEntPreNotaEntrada.fAbreConsulta(blnLike: Boolean): Boolean;
  Var
    intIndex : Integer;
Begin
  Result := False;

  If fVerificaItensComPrecoDivergentesPedidos Then
  Begin
    cdsConsultaITE_REFERE.Size := fTamRefere;
    Result := (inherited fAbreConsulta(blnLike));
	pSetaRequeridos;
    pCarregaItensNotaEletronica;
    pRemoverItensNaoEstaoNotaEletronica;
    edtFrePed.Text := FormatFloat('#,##0.00', fCalculaFretePedidos);

    If Result Then
    Begin
      TFloatField(cdsConsultaITE_QTDNFE).DisplayFormat := fMskDigitos(intDecimaisQuantidade);
      TFloatField(cdsConsultaITE_QTDPED).DisplayFormat := fMskDigitos(intDecimaisQuantidade);

      TFloatField(cdsConsultaITE_UNIPED).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsConsultaITE_UNINFE).DisplayFormat := fMskDigitos(4);

      {*****************************}
      {* INCLUSÃO DE IPI E SUBST.  *}
      {**************************CI*}

      TFloatField(cdsConsultaITE_IPIPED).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsConsultaITE_IPINFE).DisplayFormat := fMskDigitos(4);

      TFloatField(cdsConsultaITE_SUBPED).DisplayFormat := fMskDigitos(4);
      TFloatField(cdsConsultaITE_SUBNFE).DisplayFormat := fMskDigitos(4);

    End;
  End;

  //Preenche Lista com o Tipo de Frete dos Pedidos.
  SetLength(arrTipoFretePed,0);
  SetLength(arrTipoFretePed, stlPedidos.Count);
  For intIndex := 0 to stlPedidos.Count -1 Do
  Begin
    arrTipoFretePed[intIndex][0] := stlPedidos[intIndex];

    If stlAutoinc.Count > intIndex Then
      arrTipoFretePed[intIndex][1] := fCampoTabela('PCG_TIPFRE', 'PCMGER', ['AUTOINCREM'], [stlAutoinc[intIndex]] )
    Else
      arrTipoFretePed[intIndex][1] := '';
  End;

End;

function TfrmEntPreNotaEntrada.fCalculaFretePedidos: Double;
Var
   qryGen: TUniQuery;
Begin

  Result := 0;
  Try
    {******************************************}
    {* CALCULA FRETE DOS PEDIDOS SELECIONADOS *}
    {***************************************CI*}
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE    ');
      SQL.Add(' SUM(ROUND(PCG_VALFRE,' + fCfgSis('DEQTPC') + ')) AS ITE_FREPED ');
      SQL.Add(' FROM                  ');
      SQL.Add('   PCMGER              ');
      SQL.Add(' WHERE                 ');
      SQL.Add('   PCG_ESPDOC = "PD" AND ');
      SQL.Add('   PCG_NUMCTN = 0 AND ');
      SQL.Add('   (PCG_BAIXAD <> 1 OR PCG_BAIXAD IS NULL) AND ');
      SQL.Add('   PCMGER.AUTOINCREM IN (' +  fCommaText(stlAutoinc, True) + ') ');

      Open;
      Result := FieldByName('ITE_FREPED').AsFloat;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCalculaFretePedidos]');
    End;
  End;

  FreeAndNil(qryGen);

End;

function TfrmEntPreNotaEntrada.fCnpjTransportadoraDiferente(strNumped: string = ''): Boolean;

  function fValida: boolean;
  Begin
     Result := (LeftStr(cdspedidos.FieldByName('TRAPED').AsString, 8) <> LeftStr(strCnpjTrans, 8));
  End;

begin
  //Se a base do cnpj do pedido diferento da base de cnpj da nota gera critica
  // proucura divergencia
  cdsPedidos.First;
  Result := False;
  If strNumped <> '' Then
  Begin
    If cdsPedidos.Locate('NUMPED', strNumPed, []) Then
      Result := fValida;
  End
  Else
  Begin
    While not cdsPedidos.EoF do
    Begin
      Result := fValida;
      If Result Then
        Break;
      cdsPedidos.Next
    End;
  end;


End;

procedure TfrmEntPreNotaEntrada.pMostraMemo(stlIncon: TStrings);
begin
  try
    pCriarFormularios(TfrmMemo, frmMemo);
    frmMemo.cxMemo.Lines := stlIncon;
    frmMemo.cxMemo.Style.Font.Name := 'Courier New';
    frmMemo.cxMemo.Style.BorderColor := clBlack;
    frmMemo.cxMemo.Style.Color := $FFE4D5;
    frmMemo.cxMemo.Style.BorderColor := clBlue;
    frmMemo.cxMemo.Style.Font.Color := clNavy;
    frmMemo.cxMemo.Style.Font.Size := 12;
    frmMemo.Width := 800;
    frmMemo.Height := 600;
    frmMemo.ShowModal;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[]');
    end;
  end;
  pFreeAndNil(frmMemo);
end;

Function TfrmEntPreNotaEntrada.fSQLPedidos: String;

  Function fSQLPedido(strNumPed, strCodEmp: String): String;
  Begin
    Result := '';
    Result := Result + ' SELECT';
    Result := Result + '   PCG_NUMPED AS NUMPED, ';
    Result := Result + '   PCG_CODEMP AS CODEMP, ';
    Result := Result + '   PCG_CONPAG AS CONPAG, ';
    Result := Result + '   0.00       AS PRAMED, ';
    Result := Result + '   TRA_C_G_C_ AS TRAPED ';
    Result := Result + ' FROM PCMGER ';
    Result := Result + ' LEFT JOIN CADTRA T ON T.TRA_CODTRA = PCG_CODTRA ';
    Result := Result + ' WHERE       ';
    Result := Result + '   PCG_CODEMP = ' + QuotedStr(strCodEmp) + ' AND  ';
    Result := Result + '   PCG_NUMPED = ' + QuotedStr(strNumPed) + ' ';
  End;

  Var
    intContador: Integer;
Begin
  Result := '';
  For intContador := 0 To stlPedidos.Count - 1 Do
  Begin
    If intContador <> 0 Then
      Result := Result + '  UNION ALL ';

    Result := Result + fSQLPedido(stlPedidos[intContador], stlEmpresas[intContador]);
  End;
End;

procedure TfrmEntPreNotaEntrada.pMostraConPagPedidos;
Begin
  With cdsPedidos Do
  Begin
    qryQuery.SQL.Text := fSQLPedidos;

    If fEmptyStr(qryQuery.SQL.Text) Then
      Close
    Else
    Begin
      fAbreClient(True, 'TfrmEntPreNotaEntrada.pMostraConPagPedidos');

      pAlinhaCampoCentro('NUMPED');
      pAlinhaCampoCentro('CODEMP');

      While Not Eof Do
      Begin
        Edit;
        FieldByName('PRAMED').AsFloat := fCalcMediaPagto(FieldByName('CONPAG').AsString);
        Post;

        Next;
      End;
    End;

    If IsEmpty Then
      pnlConPag.ClientHeight := pnlConGerEle.Height + 50
    Else
      pnlConPag.ClientHeight := pnlConGerEle.Height + 70;
  End;
End;

procedure TfrmEntPreNotaEntrada.FormCreate(Sender: TObject);
begin
  inherited;

  blnTravaJaAssociados := Not fCfgSis('PERASS', varBoolean);

  pSetaNumPedCom(edtNumPed);
  FPais := fSetaPais;
  cdsCriticas.CreateDataSet;
  cdsCriticas.Open;

  stlPedidos := TStringList.Create;
  stlEmpresas  := TStringList.Create;
  stlAutoinc := TStringList.Create;

  intDecimaisQuantidade := fCfgSis('DEQTEM', varInteger);

  strCnvEmb := fCfgSis('CNVEMB');

  cdsPedidos := TZClient.Create(Self);

  cxgPedidosView.DataController.DataSource := cdsPedidos.dtsSource;

  objLiberacao := TLiberacao.create;

  strConPagNota := '';

  fltOciVlr := fCfgSis('OCIVLR', varDouble);
  If not fCfgSis('VALOCI', varBoolean) Then
    fltOciVlr := 0;

  blnExiApl := fCfgSis('EXIAPL', varBoolean);
  If blnExiApl Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := dtsConsulta;
  End;
end;

procedure TfrmEntPreNotaEntrada.pIncluiCritica(strCodIte,
                             strDesIte,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdPed,
                             fltQtdNfe,
                             fltSaldos,
                             fltUniPed,
                             fltUniNfe,
                             fltIpiPed,
                             fltIpiNfe,
                             fltSubPed,
                             fltSubNfe,
                             fltFrePed,
                             fltFreNfe: Double;
                             strNfeEan,
                             strTraPed,
                             strTraXml,
                             strNFE: String);

Begin

  {***********************************}
  {* INCLUSÃO DE IPI, SUBST. E FRETE *}
  {********************************CI*}

  With cdsCriticas Do
  Begin

    Insert;
    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := strDesIte;
    FieldByName('CODFAB').AsString := strCodFab;
    FieldByName('LOCFIS').AsString := strLocFis;
    FieldByName('DESUNI').AsString := strDesUni;
    FieldByName('QTDPED').AsFloat  := RoundTo(fltQtdPed,-4);
    FieldByName('QTDNFE').AsFloat  := RoundTo(fltQtdNfe,-4);
    FieldByName('UNIPED').AsFloat  := RoundTo(fltUniPed,-4);
    FieldByName('UNINFE').AsFloat  := RoundTo(fltUniNfe,-4);
    FieldByName('IPIPED').AsFloat  := RoundTo(fltIpiPed,-4);
    FieldByName('IPINFE').AsFloat  := RoundTo(fltIpiNfe,-4);
    FieldByName('SUBPED').AsFloat  := RoundTo(fltSubPed,-4);
    FieldByName('SUBNFE').AsFloat  := RoundTo(fltSubNfe,-4);
    FieldByName('FREPED').AsFloat  := RoundTo(fltFrePed,-4);
    FieldByName('FRENFE').AsFloat  := RoundTo(fltFreNfe,-4);
    FieldByName('SALDOS').AsFloat  := fltSaldos;
    FieldByName('NFEEAN').AsString := strNfeEan;
    FieldByName('AUTNFE').AsString := strNFE;

    if strCodIte = '00000' Then
    Begin
      FieldbyName('TRAPED').AsString := strTraPed;
      FieldbyName('TRAXML').AsString := strTraXml;

      FieldByName('QTDPED').Clear;
      FieldByName('QTDNFE').Clear;
      FieldByName('UNIPED').Clear;
      FieldByName('UNINFE').Clear;
      FieldByName('IPIPED').Clear;
      FieldByName('IPINFE').Clear;
      FieldByName('SUBPED').Clear;
      FieldByName('SUBNFE').Clear;
      FieldByName('FREPED').Clear;
      FieldByName('FRENFE').Clear;
      FieldByName('SALDOS').Clear;
    End;

    Post;
  End;
End;

procedure TfrmEntPreNotaEntrada.pInsereItensCdsCriticas;
  Var
    intIndex : Integer;
Begin
  if fPosssuiInconsistenciasFrete Then
  Begin

    For intIndex := 0 to Length(arrTipoFretePed) -1 Do
    Begin
      if arrTipoFretePed[intIndex][1] <> strTipFreNFE Then
      Begin
        pIncluiCritica('00000',
                       '  - PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TIPO DO FRETE: ' + UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1])) + ' TIPO DO FRETE NFE: ' +  UpperCase(fDescricaoFrete(strTipFreNFE)),
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       '',
                       '',
                       '',
                       recNotEle.strAutInc);
      End;

      //Quando o tipo frete for Destinatario (FOB) Criticar a transportadora
      If (strTipFreNfe = '2') and fCnpjTransportadoraDiferente(arrTipoFretePed[intIndex][0]) Then
      Begin
        pIncluiCritica('00000',
                       ' - PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TRANSPORTADORA DIVERGENTE: [PEDIDO = ' + cdsPedidos.FieldByName('TRAPED').AsString + '] [' + 'NOTA = ' + string(strCnpjTrans) + ']',
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       '',
                       cdsPedidos.FieldByName('TRAPED').AsString,
                       strCnpjTrans,
                       recNotEle.strAutInc);
      End;


    End;

  End;


  With cdsConsulta Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin
      {***********************************}
      {* INCLUSÃO DE IPI, SUBST. E FRETE *}
      {********************************CI*}

      pIncluiCritica(FieldByName('ITE_CODITE').AsString,
                     FieldByName('ITE_DESITE').AsString,
                     FieldByName('ITE_DESUNI').AsString,
                     FieldByName('ITE_CODFAB').AsString,
                     FieldByName('ITE_LOCFIS').AsString,
                     FieldByName('ITE_QTDPED').AsFloat,
                     FieldByName('ITE_QTDNFE').AsFloat,
                     FieldByName('ITE_SALDOS').AsFloat,
                     FieldByName('ITE_UNIPED').AsFloat,
                     FieldByName('ITE_UNINFE').AsFloat,
                     FieldByName('ITE_IPIPED').AsFloat,
                     FieldByName('ITE_IPINFE').AsFloat,
                     FieldByName('ITE_SUBPED').AsFloat,
                     FieldByName('ITE_SUBNFE').AsFloat,
                     fStrToFloat(edtFrePed.Text),
                     fStrToFloat(edtFreNfe.Text),
                     FieldByName('ITE_NFEEAN').AsString,
                     '',
                     '',
                     recNotEle.strAutInc);
      Next;
    End;

    EnableControls;
  End;
end;

procedure TfrmEntPreNotaEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   If Not fEmptyStr(recNotEle.strAutInc) Then
      fLock_Unlock('NFE' + recNotEle.strAutInc, False, False, True);

  inherited;

end;

procedure TfrmEntPreNotaEntrada.OnFilterRecordErros(DataSet: TDataSet;
  var Accept: Boolean);
Begin
  Accept := ( ( DataSet.FieldByName('QTDNFE').AsFloat - DataSet.FieldByName('QTDPED').AsFloat ) > fltOciVlr ) Or

            ( (RoundTo(DataSet.FieldByName('QTDNFE').AsFloat, -4) > 0) And
              (RoundTo(DataSet.FieldByName('QTDPED').AsFloat, -4) > 0) And

              (( ( DataSet.FieldByName('UNINFE').AsFloat - DataSet.FieldByName('UNIPED').AsFloat ) > fltOciVlr ) Or
               ( ( DataSet.FieldByName('IPINFE').AsFloat - DataSet.FieldByName('IPIPED').AsFloat ) > fltOciVlr ) Or
               ( ( DataSet.FieldByName('SUBNFE').AsFloat - DataSet.FieldByName('SUBPED').AsFloat ) > fltOciVlr )) )  Or

            ( ( DataSet.FieldByName('FRENFE').AsFloat - DataSet.FieldByName('FREPED').AsFloat ) > fltOciVlr ) Or
            ( not fEmptyStr(DataSet.FieldByName('INFADI').AsString));

End;

procedure TfrmEntPreNotaEntrada.btnConfirmaClick(Sender: TObject);
{  Const
    STR_FILTRO_ERROS = '(QTDPED < QTDNFE) OR (UNIPED < UNINFE) OR ' +
                       '(IPIPED < IPINFE) OR (SUBPED < SUBNFE) OR ' +
                       '(FREPED < FRENFE) OR (INFADI <> '''')';}
  Var
    qryUpdate: TUniQuery;
    intPedidos: Integer;
    intAgrupador : integer;
    objTabela    : TRegistroMsgLiberaTabela;
    strOpeLib    : String;
    blnPossuiInconsistencia: Boolean;

  procedure pAddArrMsgLib;
    var
      strCodIte: String;
      blnTemQtd,
      blnQtd, blnUni,
      blnIpi, blnSub : Boolean;
	    objLinha  : TLinhaMsgLibera;
  Begin
    With cdsCriticas do
    begin
      blnQtd := ((FieldByName('QTDNFE').AsFloat - FieldByName('QTDPED').AsFloat) > fltOciVlr);

      blnTemQtd := (RoundTo(FieldByName('QTDNFE').AsFloat, -4) > 0) And
                   (RoundTo(FieldByName('QTDPED').AsFloat, -4) > 0);

      blnUni := blnTemQtd And ((FieldByName('UNINFE').AsFloat - FieldByName('UNIPED').AsFloat) > fltOciVlr);

      blnIpi := blnTemQtd And ((FieldByName('IPINFE').AsFloat - FieldByName('IPIPED').AsFloat) > fltOciVlr);

      blnSub := blnTemQtd And ((FieldByName('SUBNFE').AsFloat - FieldByName('SUBPED').AsFloat) > fltOciVlr);

      strCodIte := FieldByName('CODITE').AsString;

      if strCodIte = '00000' then
        Exit;

      inc(IntAgrupador);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.'         , strCodIte                                                                         , 7  , alEsquerda);
      objLinha.pAddColuna('Descrição'    , FieldByName('DESITE').AsString                                                    , 93 , alEsquerda);
      objLinha.pAddColuna('Unidade'      , fRetSiglaUni( fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [strCodIte]) ) , 18 , alEsquerda, teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.Fabrica' , FieldByName('CODFAB').AsString , 122  , alEsquerda, teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna(''             , ''                                                                              , 66 , alEsquerda );
      objLinha.pAddColuna('Quant.Ped.'   , FormatFloat('#,##0.0000', FieldByName('QTDPED').AsFloat) + IIF(blnQtd, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Quant.NFE.'   , FormatFloat('#,##0.0000', FieldByName('QTDNFE').AsFloat) + IIF(blnIpi, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.Unit.Ped.' , FormatFloat('#,##0.00'  , FieldByName('UNIPED').AsFloat) + IIF(blnUni, '*', '') , 12 , alDireita  );
      objLinha.pAddColuna('Vr.Unit.NFE.' , FormatFloat('#,##0.00'  , FieldByName('UNINFE').AsFloat) + IIF(blnUni, '*', '') , 12 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna(''            , ''                                                                              , 66 , alEsquerda);
      objLinha.pAddColuna('Vr.IPI  Ped.', FormatFloat('#,##0.00  ', FieldByName('IPIPED').AsFloat) + IIF(blnIpi, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.IPI  NFE' , FormatFloat('#,##0.00'  , FieldByName('IPINFE').AsFloat) + IIF(blnIpi, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.ST  Ped.' , FormatFloat('#,##0.00'  , FieldByName('SUBPED').AsFloat) + IIF(blnSub, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.ST  NFE'  , FormatFloat('#,##0.00'  , FieldByName('SUBNFE').AsFloat) + IIF(blnSub, '*', '') , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);

    end;

  end;

  procedure pAddArrMsgLibCadastral(cdsCriCad : TUniClientDataSet);
    Var
      strCodIte : String;
      strDesIte : String;
      strNfeEan : String;
      strCodBar : String;
      strInfAdi : String;
      objLinha  : TLinhaMsgLibera;

  Begin
    With cdsCriCad Do
    Begin
      int(intAgrupador);
      strCodIte := FieldByName('CODITE').AsString;
      strDesIte := FieldByName('DESITE').AsString;
      strNfeEan := FieldByName('NFEEAN').AsString;
      strCodBar := FieldByName('CODBAR').AsString;
      strInfAdi := FieldByName('INFADI').AsString;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.'                  , strCodIte , 7  , alEsquerda);
      objLinha.pAddColuna('Descrição'             , strDesIte , 53 , alEsquerda);
      objLinha.pAddColuna('Código de Barras XML'  , strNfeEan , 28 , alEsquerda);
      objLinha.pAddColuna('Código de Barras Cad.' , strCodBar , 28 , alEsquerda);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Ocorrencias'           , strInfAdi , 122 , alEsquerda);
      objTabela.lstLinhas.Add(objLinha);

    End;
  End;

  Procedure pIncluiInconsistenciaConpag(blnconsis: Boolean);
  var
	  objLinha  : TLinhaMsgLibera;
  Begin
    If blnconsis Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DA CONDIÇÃO DE PAGAMENTO', alCentro, teAmbos, '', 125);
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTextoCaption('Condição de Pagamento da Nota', FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', strConPagNota), 29);
      objLiberacao.objMsgRemota.pAddTextoCaption('Prazo Médio da Nota'          , FormatFloat('#,##0.00', fCalcMediaPagto(strConPagNota))                                 , 29);
    End Else
    Begin
      objLiberacao.objMsgRemota.pAddTexto('Pedidos Pré-Nota:');
    End;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Pedido'                , 12 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Condição de Pagamento' , 63 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Prazo Médio'           , 43 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    If Not cdsPedidos.IsEmpty Then
    Begin
      cdsPedidos.First;
      While Not cdsPedidos.Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Pedido'                , cdsPedidos.FieldByName('NUMPED').AsString                                                                            , 12 , alEsquerda);
        objLinha.pAddColuna('Condição de Pagamento' , FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', cdsPedidos.FieldByName('CONPAG').AsString) , 63 , alEsquerda);
        objLinha.pAddColuna('Prazo Médio'           , FloatToStrF(cdsPedidos.FieldByName('PRAMED').AsFloat, ffNumber, 11, 2)                                               , 43 , alEsquerda);
        objTabela.lstLinhas.Add(objLinha);


        cdsPedidos.Next;
      End;
    End;

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
  End;


  function fPedeSenhaLiberacao: Boolean;
    Var
      strLinha     : String;
      strDiverge   : String;
      intIndex     : Integer;
      cdsCriCad    : TUniClientDataSet;
      blnTemQtd    : Boolean;
   	  objLinha     : TLinhaMsgLibera;
  begin
    cdsCriCad := fRetCdsInconsistenciaCadastrais;

    objLiberacao.Clear;
    strDiverge := '';

    objLiberacao.objMsgLibera.pAddTexto('Liberação de Pré-Nota com inconsistências');
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'       , recNotEle.strNumDoc                                                                      , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Chave de Acesso' , recNotEle.str_Chave                                                                      , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data emissão'    , DateToStr(recNotEle.dtaDtaDoc)                                                           , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagamento' , FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', strConPagNota) , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Prazo Médio'     , FormatFloat('#,##0.00', fCalcMediaPagto(strConPagNota))                                  , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'      , recNotEle.strCodFor + '-' + fRetNomFornecedor(recNotEle.strCodFor)                       , 16);

    pIncluiInconsistenciaConpag(fPosssuiInconsistenciaCondPagto);



    if fPosssuiInconsistenciasFrete Or (edtFrePed.Text <> edtFreNfe.Text) Then
    Begin
      objTabela := TRegistroMsgLiberaTabela.Create;

      For intIndex := 0 to Length(arrTipoFretePed) -1 Do
      Begin
        if arrTipoFretePed[intIndex][1] <> strTipFreNFE Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('PEDIDO'            , arrTipoFretePed[intIndex][0]                              , 22 , alEsquerda , teAmbos, True);
          objLinha.pAddColuna('TIPO DO FRETE'     , UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1]))  , 46 , alEsquerda , teAmbos, True);
          objLinha.pAddColuna('TIPO DO FRETE NFE' , UpperCase(fDescricaoFrete(strTipFreNFE))                  , 50 , alEsquerda , teAmbos, True);
          objTabela.lstLinhas.Add(objLinha);

          strLinha := fPadR('PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TIPO DO FRETE: ' + UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1])) + ' TIPO DO FRETE NFE: ' +  UpperCase(fDescricaoFrete(strTipFreNFE)), 106);
          strDiverge := strDiverge + strLinha + STRING_QUEBRA;
        End;
      End;


      If (edtFrePed.Text <> edtFreNfe.Text) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Vr. Frete Ped' , FormatFloat('#,##0.00', fStrToFloat(edtFrePed.Text) )                                , 39 , alEsquerda , teAmbos, True);
        objLinha.pAddColuna('Vr. Frete NFe' , FormatFloat('#,##0.00', fStrToFloat(edtFreNfe.Text) )                                , 39 , alEsquerda , teAmbos, True);
        objLinha.pAddColuna('Diferença'     , FormatFloat('#,##0.00', (fStrToFloat(edtFrePed.Text) - fStrToFloat(edtFreNfe.Text))) , 40 , alEsquerda , teAmbos, True);
        objTabela.lstLinhas.Add(objLinha);
      End;

      If (Not cdsCriticas.IsEmpty) Then
      Begin
        cdsCriticas.Filtered := False;
        cdsCriticas.Filter := 'NOT TRAPED = ' + QuotedStr('');
        cdsCriticas.Filtered := True;
        While Not (cdsCriticas.Eof) Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Item' , cdsCriticas.FieldByName('DESITE').AsString , 122 , alEsquerda , teAmbos);
          objTabela.lstLinhas.Add(objLinha);

          cdsCriticas.Next;
        End;

        cdsCriticas.Filtered := False;
        cdsCriticas.Filter := '';
      End;


      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);

    End;

    if (not cdsCriticas.IsEmpty) Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DE QUANTIDADES, VALORES E IMPOSTOS', alCentro, teAmbos, '', 125);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'         , 7  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'    , 57 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Quant.Ped.'   , 12 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Quant.NFE.'   , 12 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unit.Ped.' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unit.NFE.' , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , ''             , 66 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.IPI  Ped.' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.IPI  NFE'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.ST  Ped.'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.ST  NFE'   , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);


      With cdsCriticas do
      begin
        intAgrupador := -1;
        First;
        While not Eof do
        Begin
          pAddArrMsgLib;

          strDiverge := strDiverge + FieldByName('DESITE').AsString + STRING_QUEBRA;

          if FieldByName('QTDPED').AsFloat < FieldByName('QTDNFE').AsFloat then
            strDiverge := strDiverge + '  >> QUANTIDADE DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          blnTemQtd := (RoundTo(FieldByName('QTDNFE').AsFloat, -4) > 0) And
                       (RoundTo(FieldByName('QTDPED').AsFloat, -4) > 0);

          if blnTemQtd And (FieldByName('UNIPED').AsFloat < FieldByName('UNINFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR UNITÁRIO DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if blnTemQtd And (FieldByName('IPIPED').AsFloat < FieldByName('IPINFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR DE IPI DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if blnTemQtd And (FieldByName('SUBPED').AsFloat < FieldByName('SUBNFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR DA SUBSTITUIÇÃO DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if FieldByName('FREPED').AsFloat < FieldByName('FRENFE').AsFloat then
            strDiverge := strDiverge + '  >> VALOR DO FRETE DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          If Not fEmptyStr(FieldByName('INFADI').AsString) Then
            strDiverge := strDiverge + '  >> ' + FieldByName('INFADI').AsString + STRING_QUEBRA;

          Next;
        End
      end;

      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
    End;

    if (not cdsCriCad.IsEmpty) Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DE DADOS CADASTRAIS', alCentro, teAmbos, '', 125);


      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'                  , 7  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'             , 53 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Código de Barras XML'  , 28 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Código de Barras Cad.' , 28 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Ocorrencias'           , 122, alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      With cdsCriCad Do
      Begin
        First;

        intAgrupador := -1;

        While Not Eof Do
        Begin
          pAddArrMsgLibCadastral(cdsCriCad);
          Next;
        End;

      End;

      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
    End;

    objLiberacao.strDirAce := 'ENTLPN';
    objLiberacao.strSenLib := fCfgSis('SENLPN');
    objLiberacao.strMsgSen := 'Pré-Nota de Entrada';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;


    Result := objLiberacao.fLibera;

    strOpeLib := objLiberacao.strOperador;


    If Result Then
      Result := TfrmEntPreNotaEntradaMotivoLib.fRegistraMotivo(recNotEle.dtaDtaDoc,
                                                               recNotEle.strNumDoc,
                                                               'NF', //recNotEle.strEspDoc,
                                                               recNotEle.strSerDoc,
                                                               recNotEle.strCodFor,
                                                               VS_strCodEmp,
                                                               'F', //recNotEle.strTipoFc,
                                                               strOpeLib,
                                                               strDiverge);
                                                               
    FreeAndNil(cdsCriCad);
  End;

  procedure pGravaDadosInconsistencia;
    var
      qryInsertCritica: TUniQuery;
  begin
    If Not cdsCriticas.RecordCount > 0 Then
      Exit;

    qryInsertCritica := fCriaQuery;
    Try
      qryInsertCritica.SQL.Add('INSERT INTO PRECRI (');

      qryInsertCritica.SQL.Add('AUTOINCREM, CRI_CODITE, CRI_QTDPED, CRI_QTDNFE, CRI_UNIPED, CRI_UNINFE,');
      qryInsertCritica.SQL.Add('CRI_IPIPED, CRI_IPINFE, CRI_SUBPED, CRI_SUBNFE, CRI_FREPED, CRI_FRENFE,');
      qryInsertCritica.SQL.Add('CRI_INFADI, CRI_NFEEAN, CRI_CODBAR, CRI_TRAPED, CRI_TRAXML, CRI_OPELIB,');
      qryInsertCritica.SQL.Add('CRI_DTALIB, CRI_AUTNFE, CRI_DESITE, CRI_DESUNI, CRI_LOCFIS, CRI_CODFAB) VALUES ( ');
      qryInsertCritica.SQL.Add(':INCREM, :CODITE, :QTDPED, :QTDNFE, :UNIPED, :UNINFE,');
      qryInsertCritica.SQL.Add(':IPIPED, :IPINFE, :SUBPED, :SUBNFE, :FREPED, :FRENFE,');
      qryInsertCritica.SQL.Add(':INFADI, :NFEEAN, :CODBAR, :TRAPED, :TRAXML, :OPELIB,');
      qryInsertCritica.SQL.Add('CURDATE(), :AUTNFE, :DESITE, :DESUNI, :LOCFIS, :CODFAB)');

      cdsCriticas.First;

      While Not cdsCriticas.Eof Do
      Begin
        qryInsertCritica.ParamByName('INCREM').AsString  := fRetAutoIncrem('PRECRI', VS_strCodEmp);
        qryInsertCritica.ParamByName('OPELIB').AsString := strOpeLib;
        qryInsertCritica.ParamByName('AUTNFE').Value := recNotEle.strAutInc;
        qryInsertCritica.ParamByName('CODITE').Value := cdsCriticas.FieldByName('CODITE').Value;
        qryInsertCritica.ParamByName('QTDPED').Value := cdsCriticas.FieldByName('QTDPED').Value;
        qryInsertCritica.ParamByName('QTDNFE').Value := cdsCriticas.FieldByName('QTDNFE').Value;
        qryInsertCritica.ParamByName('UNIPED').Value := cdsCriticas.FieldByName('UNIPED').Value;
        qryInsertCritica.ParamByName('UNINFE').Value := cdsCriticas.FieldByName('UNINFE').Value;
        qryInsertCritica.ParamByName('IPIPED').Value := cdsCriticas.FieldByName('IPIPED').Value;
        qryInsertCritica.ParamByName('IPINFE').Value := cdsCriticas.FieldByName('IPINFE').Value;
        qryInsertCritica.ParamByName('SUBPED').Value := cdsCriticas.FieldByName('SUBPED').Value;
        qryInsertCritica.ParamByName('SUBNFE').Value := cdsCriticas.FieldByName('SUBNFE').Value;
        qryInsertCritica.ParamByName('FREPED').Value := cdsCriticas.FieldByName('FREPED').Value;
        qryInsertCritica.ParamByName('FRENFE').Value := cdsCriticas.FieldByName('FRENFE').Value;
        qryInsertCritica.ParamByName('INFADI').Value := cdsCriticas.FieldByName('INFADI').Value;
        qryInsertCritica.ParamByName('NFEEAN').Value := cdsCriticas.FieldByName('NFEEAN').Value;
        qryInsertCritica.ParamByName('CODBAR').Value := cdsCriticas.FieldByName('CODBAR').Value;
        qryInsertCritica.ParamByName('TRAPED').Value := cdsCriticas.FieldByName('TRAPED').Value;
        qryInsertCritica.ParamByName('TRAXML').Value := cdsCriticas.FieldByName('TRAXML').Value;
        qryInsertCritica.ParamByName('DESITE').Value := cdsCriticas.FieldByName('DESITE').Value;
        qryInsertCritica.ParamByName('DESUNI').Value := cdsCriticas.FieldByName('DESUNI').Value;
        qryInsertCritica.ParamByName('LOCFIS').Value := cdsCriticas.FieldByName('LOCFIS').Value;
        qryInsertCritica.ParamByName('CODFAB').Value := cdsCriticas.FieldByName('CODFAB').Value;
        qryInsertCritica.ExecSQL;
        cdsCriticas.Next;
      End;
    Finally
      FreeAndNil(qryInsertCritica);
    end;
  end;

begin
  inherited;

  Try

    If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Begin
      fMensagem('', 'Selecione a nota eletrônica e também o pedido de compra para continuar!', ['&OK']);
      Exit;
    End;

    blnPossuiInconsistencia := fPosssuiInconsistencias(OnFilterRecordErros);

    If (Not blnPossuiInconsistencia) Or fPedeSenhaLiberacao Then
    Begin

      If fEmptyStr(strOpeLib) Then
        strOpeLib := strLoginUsuarioLogado;

      fStartTransaction;

//      pAtualizaFornecedoresPedido(recNotEle.strCodFor);

      qryUpdate := fCriaQuery(Self);

      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;

        Add('UPDATE GERELE');
        Add('SET GER_DTALIB = :DTALIB,');
        Add('  GER_HORLIB = :HORLIB,');
        Add('  GER_OPELIB = :OPELIB, ');
        Add('  GER_UNICOM = :UNICOM  ');
        Add('WHERE AUTOINCREM = :AUTINC');

        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := Time;
        ParamByName('OPELIB').AsString := strOpeLib;
        ParamByName('AUTINC').AsString := recNotEle.strAutInc;

        If pnlCnvEmb.Visible And (rdgTipUni.ItemIndex = 0) Then
          ParamByName('UNICOM').AsString := 'S'
        Else
          ParamByName('UNICOM').AsString := 'N';

        ExecSQL;

        Close;
        Clear;

        Add('INSERT INTO PEDELE');
        Add('            (AUTOINCREM,');
        Add('             PEL_SEQELE,');
        Add('             PEL_NUMDOC,');
        Add('             PEL_ESPDOC,');
        Add('             PEL_CODEMP,');
        Add('             PEL_CODFOR)');
        Add('VALUES (:AUTINC,');
        Add('        :SEQELE,');
        Add('        :NUMDOC,');
        Add('        :ESPDOC,');
        Add('        :CODEMP,');
        Add('        :CODFOR)');

        For intPedidos := 0 to stlPedidos.Count - 1 Do
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('PEDELE', VS_strCodEmp);
          ParamByName('SEQELE').AsString := recNotEle.strAutInc;
          ParamByName('NUMDOC').AsString := stlPedidos[intPedidos];
          ParamByName('ESPDOC').AsString := 'PD';
          ParamByName('CODEMP').AsString := stlEmpresas[intPedidos];
          ParamByName('CODFOR').AsString := recNotEle.strCodFor;
          ExecSQL;

          If (VS_strHabilitarCRM) Then
          Begin
            TUpdateOccurrenceCRM.New()
              .NumDoc(stlPedidos[intPedidos])
              .EspDoc('PD')
              .CodEmp(stlEmpresas[intPedidos])
              .AcaFat(afcPedidoInclusaoPreNota)
              .pRun();
          End;
        End;

      End;

      If blnPossuiInconsistencia Then
        pGravaDadosInconsistencia;


      fCommit;

      FreeAndNil(qryUpdate);

      pMensagemOk('Liberação efetuada com sucesso!');
      fLock_Unlock('NFE' + recNotEle.strAutInc, False, False, True);
      pCancela(False);
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'');
    End;
  End;

end;

procedure TfrmEntPreNotaEntrada.btnCriticasClick(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  If (Not cdsCriticas.Active) Then
    Exit;

  If Not fPosssuiInconsistencias Then
  Begin
    fMensagem('', 'Não há inconsistências no Pedido!', ['&Ok']);
    Exit;
  end;

  Try
    cdsCriticas.IndexFieldNames := 'DESITE';

    cdsCriticas.Filtered := False;

    cdsCriticas.OnFilterRecord := OnFilterRecordDifToleranciaFrete;

    cdsCriticas.Filtered := True;

    pCriarFormularios(TfrmRelEntCriticasPreNota, frmRelEntCriticasPreNota);
    frmRelEntCriticasPreNota.strFilRel := Self.Name;
    frmRelEntCriticasPreNota.stlPedidos:= stlPedidos;
    frmRelEntCriticasPreNota.strNotEle := edtNotEle.Text;
    frmRelEntCriticasPreNota.strCodFor := strCodFor;
    frmRelEntCriticasPreNota.frxdbCriticas.DataSet := cdsCriticas;

    frmRelEntCriticasPreNota.cdsCriCad := fRetCdsInconsistenciaCadastrais;

    frmRelEntCriticasPreNota.ShowModal;
    FreeAndNil(frmRelEntCriticasPreNota);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[]');
    End;
  End;

end;

procedure TfrmEntPreNotaEntrada.FormDestroy(Sender: TObject);
begin


  FreeAndNil(stlEmpresas);
  FreeAndNil(stlAutoinc);
  cdsCriticas.EmptyDataSet;
  cdsCriticas.Close;

  stlPedidos.Clear;
  FreeAndNil(stlPedidos);
//  FreeAndNil(FPais);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);


  inherited;
end;

Function TfrmEntPreNotaEntrada.fPosssuiInconsistenciaCondPagto: Boolean;
  Var
    fltPraNot: Double;
Begin
  fltPraNot := fCalcMediaPagto(strConPagNota);
  Result := False;

  If Not cdsPedidos.IsEmpty Then
  Begin
    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      If RoundTo(cdsPedidos.FieldByName('PRAMED').AsFloat, -2) > RoundTo(fltPraNot, -2) Then
      Begin
        Result := True;
        Break;
      End;

      cdsPedidos.Next;
    End;
  End;
End;

procedure TfrmEntPreNotaEntrada.OnFilterRecordDifTolerancia(DataSet: TDataSet;
  var Accept: Boolean);
Begin
  pOnFilterRecordDifTolerancia(DataSet, Accept, False);
End;

procedure TfrmEntPreNotaEntrada.OnFilterRecordDifToleranciaFrete(DataSet: TDataSet;
  var Accept: Boolean);
Begin
  pOnFilterRecordDifTolerancia(DataSet, Accept, True);
End;

procedure TfrmEntPreNotaEntrada.pOnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean; blnComFrete: Boolean);
Begin
  Accept := ( Abs( DataSet.FieldByName('QTDPED').AsFloat - DataSet.FieldByName('QTDNFE').AsFloat ) > fltOciVlr ) Or

            ( (RoundTo(DataSet.FieldByName('QTDNFE').AsFloat, -4) > 0) And
              (RoundTo(DataSet.FieldByName('QTDPED').AsFloat, -4) > 0) And

              (( Abs( DataSet.FieldByName('UNIPED').AsFloat - DataSet.FieldByName('UNINFE').AsFloat ) > fltOciVlr ) Or
               ( Abs( DataSet.FieldByName('IPIPED').AsFloat - DataSet.FieldByName('IPINFE').AsFloat ) > fltOciVlr ) Or
               ( Abs( DataSet.FieldByName('SUBPED').AsFloat - DataSet.FieldByName('SUBNFE').AsFloat ) > fltOciVlr ))) Or


            ( Abs( DataSet.FieldByName('FREPED').AsFloat - DataSet.FieldByName('FRENFE').AsFloat ) > fltOciVlr ) Or
            ( not fEmptyStr(DataSet.FieldByName('INFADI').AsString));

  If blnComFrete Then
    Accept := Accept Or (DataSet.FieldByName('CODITE').AsString = '00000');
End;

procedure TfrmEntPreNotaEntrada.pRemoverItensNaoEstaoNotaEletronica;
  Var
    strFilter: String;
    blnFiltered: Boolean;
begin
  If Not chkOcultarItens.Checked Then
    Exit;

  strFilter   := cdsConsulta.Filter;
  blnFiltered := cdsConsulta.Filtered;

  cdsConsulta.Filter   := 'ITE_QTDPED > 0 AND ITE_QTDNFE = 0';
  cdsConsulta.Filtered := True;

  While Not cdsConsulta.IsEmpty Do
    cdsConsulta.Delete;

  cdsConsulta.Filter   := strFilter;
  cdsConsulta.Filtered := blnFiltered;
end;

Function TfrmEntPreNotaEntrada.fPosssuiInconsistencias(prcFiltro: TFilterRecordEvent): Boolean;
{
  Const
    STR_FILTRO_ERROS = '(QTDPED <> QTDNFE) OR (UNIPED <> UNINFE) OR ' +
                       '(IPIPED <> IPINFE) OR (SUBPED <> SUBNFE) OR ' +
                       '(FREPED <> FRENFE) OR (INFADI <> '''') ';
}
Begin
  cdsCriticas.Filtered := False;

  cdsCriticas.EmptyDataSet;
  pInsereItensCdsCriticas;

  pVerificaItensComProblemasCadastro;

{  If Not fEmptyStr(strFiltro) Then
    cdsCriticas.Filter := strFiltro
  Else
    cdsCriticas.Filter := STR_FILTRO_ERROS;}

  if Assigned(prcFiltro) Then
    cdsCriticas.OnFilterRecord := prcFiltro
  Else
    cdsCriticas.OnFilterRecord := OnFilterRecordDifTolerancia;

  cdsCriticas.Filtered := True;
  Result := (Not cdsCriticas.IsEmpty) or fPosssuiInconsistenciasFrete Or
            fPosssuiInconsistenciaCondPagto;
End;

function TfrmEntPreNotaEntrada.fPosssuiInconsistenciasFrete: Boolean;
  Var
    intIndex : Integer;
begin
  Result := False;
  For intIndex := 0 to Length(arrTipoFretePed) -1 Do
  Begin
    if arrTipoFretePed[intIndex][1] <> strTipFreNFE Then
    Begin
      Result := True;
      Break;
    End;
  End;

  If (Not Result) And (strTipFreNFE = '2') Then
   Result := fCnpjTransportadoraDiferente;

end;

Function TfrmEntPreNotaEntrada.fIncluiItem(strCodIte: String; fltQtdIte: Double; fltUnitario, fltIpiIte, fltSubIte: Double; strNfeEan : String): Boolean;
  Var
    strFicIns,
    strDesIte,
    strCodRef,
    strCodBar,
    strRefere,
    strCodUni,
    strCodFab,
    strLocFis: String;
    strLocSup: String;
    strAplica: String;
    fltEmbala: Double;
Begin
  Result := FALSE;

  pRetProdutoCodBar(strCodIte,
                    strDesIte,
                    strCodRef,
                    strCodBar,
                    strRefere,
                    strCodUni,
                    strCodFab,
                    strLocFis,
                    strLocSup,
                    strFicIns,
                    strAplica,
                    fltEmbala,
                    Length(strCodIte) > 5);

  If fEmptyStr(strDesIte) And (Length(strCodIte) > 5) Then
  Begin
    pRetProdutoSimilar(strCodIte,
                       strCodRef,
                       strDesIte,
                       strRefere,
                       strCodUni,
                       strCodFab,
                       strLocFis,
                       strLocSup,
                       strFicIns,
                       strAplica,
                       fltEmbala);

    If Not fEmptyStr(strDesIte) Then
      strCodBar := strCodIte;
  End;

  If fEmptyStr(strDesIte) Then
    pMensagemSonora('Item ' + strCodIte + ' não encontrado!')
  Else
  With cdsConsulta Do
  Begin
    cdsConsulta.Tag := 1;

    Try
      cdsConsulta.Insert;
      FieldByName('AUTOINCREM').AsString   := strCodRef;
      FieldByName('ITE_CODITE').AsString   := strCodRef;
      FieldByName('ITE_QTDNFE').AsFloat    := fltQtdIte;
      FieldByName('ITE_UNINFE').AsFloat    := fltUnitario;
      FieldByName('ITE_IPINFE').AsFloat    := RoundTo(fltIpiIte / fltQtdIte, -4);
      FieldByName('ITE_SUBNFE').AsFloat    := RoundTo(fltSubIte / fltQtdIte, -4);

      FieldByName('ITE_QTDPED').AsFloat    := 0;
      FieldByName('ITE_UNIPED').AsFloat    := 0;
      FieldByName('ITE_IPIPED').AsFloat    := 0;
      FieldByName('ITE_SUBPED').AsFloat    := 0;

      FieldByName('ITE_CODBAR').AsString   := IIF(fEmptyStr(strCodBar), '-', strCodBar);
      FieldByName('ITE_DESITE').AsString   := IIF(fEmptyStr(strDesIte), '-', strDesIte);
      FieldByName('ITE_APLICA').AsString   := IIF(fEmptyStr(strAplica), '-', strAplica);
      FieldByName('ITE_REFERE').AsString   := IIF(fEmptyStr(strRefere), '-', strRefere);
      FieldByName('ITE_DESUNI').AsString   := fRetSiglaUnidade(strCodUni);
      FieldByName('ITE_CODFAB').AsString   := IIF(fEmptyStr(strCodFab), '-', strCodFab);
      FieldByName('ITE_LOCFIS').AsString   := IIF(fEmptyStr(strLocFis), '-', strLocFis);

      If Fields.FindField('ITE_LOCSUP') <> Nil Then
        FieldByName('ITE_LOCSUP').AsString   := IIF(fEmptyStr(strLocSup), '-', strLocSup);

      FieldByName('ITE_NFEEAN').AsString   := strNfeEan;

      Post;
      Result := TRUE;
    Except
      On E: Exception Do
      Begin
        Result := FALSE;
        pMensagensErro(E.Message, '[fIncluiItem]');
      End;
    End;

    cdsConsulta.Tag := 0;

  End;

End;

procedure TfrmEntPreNotaEntrada.pCarregaItensNotaEletronica;
  Var
    strEmbala,
    strSQL: String;
    qryItens: TUniQuery;
    strQtdDec: string;
Begin
  If fEmptyStr(recNotEle.strAutInc) Then
    Exit;

  {*****************************}
  {* INCLUSÃO DE IPI E SUBST.  *}
  {**************************CI*}
  strQtdDec := fCfgSis('DEQTPC');
  strSQL := '';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + '   DET_CODITE  AS CODPRO,     ';
  strSQL := strSQL + '   O14_VIPI    AS IPINFE,     ';
  strSQL := strSQL + '   N23_VICMSST AS SUBNFE,    ';
  
  If (fCfgSis('CNVEMB') <> 'N') And (rdgTipUni.ItemIndex = 0) Then
  Begin
    If fCfgSis('TABPRF', varBoolean) Then
    begin

      strEmbala := '';
      strEmbala := strEmbala + ' IF(F.ITE_CODITE IS NULL, ';
      strEmbala := strEmbala + '      IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = DET_CODITE AND BAR_CODFOR = GER_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IF(IFNULL(I.ITE_EMBALA, 0) <> 0, I.ITE_EMBALA, 1)), ';
      strEmbala := strEmbala + '      IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) '

    End Else
      strEmbala := ' IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = DET_CODITE AND BAR_CODFOR = GER_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IF(IFNULL(I.ITE_EMBALA, 0) <> 0, I.ITE_EMBALA, 1)) ';

    strSQL := strSQL + '   ROUND((I11_VPROD - ' + fSQLDescontoXML + ') / I10_QCOM, 4) / ' + strEmbala + ' AS VALUNI,     ';
    strSQL := strSQL + '   ROUND(ROUND(I10_QCOM,' + strQtdDec + ') *  ' + strEmbala + ',' + strQtdDec + ') AS QTDPRO,     ';
  End Else
  Begin

    strSQL := strSQL + '   ROUND(I11_VPROD - ' + fSQLDescontoXML + ', 4) / I10_QCOM AS VALUNI,     ';
    strSQL := strSQL + '   I10_QCOM    AS QTDPRO,     ';

  End;

  strSQL := strSQL + '   I03_CEAN    AS NFEEAN      ';
  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   DETELE D                   ';

  strSQL := strSQL + ' INNER JOIN GERELE G ON G.AUTOINCREM = D.DET_SEQGER ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                        F.ITE_CODFOR =   GER_CODFOR AND ';
    strSQL := strSQL + '                        (SELECT COUNT(*) FROM TABPRE      ';
    strSQL := strSQL + '                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End;

  strSQL := strSQL + ' WHERE                        ';
  strSQL := strSQL + '   DET_SEQGER = ' + QuotedStr(recNotEle.strAutInc);

  qryItens := fCriaQuery(Self);

  With qryItens, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    Open;

    While Not Eof Do
    Begin
      fRegistraItem(FieldByName('CODPRO').AsString,
                    FieldByName('QTDPRO').AsFloat,
                    FieldByName('VALUNI').AsFloat,
                    FieldByName('IPINFE').AsFloat,
                    FieldByName('SUBNFE').AsFloat,
                    FieldByName('NFEEAN').AsString);
      Next;
    End;

  End;

  FreeAndNil(qryItens);

end;

function TfrmEntPreNotaEntrada.fVerificaItensComPrecoDivergentesPedidos: Boolean;
  var
    qryItens : TUniQuery;
    stlItens : TStringList;
    stlIncon : TStrings;
    intIndex : Integer;
    strUnitar: String;
Begin

  Result := True;

  stlIncon := TStringList.Create;

  stlItens := TStringList.Create;
  stlItens.Sorted := True;

  qryItens := fCriaQuery(Self);

  With qryItens, SQL Do
  Begin
    Close;
    Clear;
    Add(fGetSql(False));
    Open;

    First;

    While Not Eof Do
    Begin
      stlItens.Add(FieldByName('ITE_CODITE').AsString);
      Next;
    End;

    First;

    For intIndex := 0 To stlItens.Count - 1 Do
    Begin
      Filtered := False;
      Filter   := 'ITE_CODITE = ' + QuotedStr(stlItens[intIndex]);
      Filtered := True;

      If Recordcount > 1 Then
      Begin
        If stlIncon.Count = 0 Then
        Begin
          stlIncon.Add('-----------------------------------------------------------------------------');
          stlIncon.Add('|            PRODUTOS COM PREÇO UNITÁRIO DIFERENTE NOS PEDIDOS              |');
          stlIncon.Add('-----------------------------------------------------------------------------');
          stlIncon.Add('| CODIGO | DESCRICAO                   |      UNITAR.| PEDIDOS              |');
          stlIncon.Add('-----------------------------------------------------------------------------');
        End;

        First;

        While Not Eof Do
        Begin
          strUnitar := FormatFloat('#,##0.0000', FieldByName('ITE_UNIPED').AsFloat);

          stlIncon.Add('| ' + fPadR(FieldByName('ITE_CODITE').AsString, 07) +
                       '| ' + fPadR(FieldByName('ITE_DESITE').AsString, 28) +
                       '| ' + fPadL(strUnitar,                          12) +
                       '| ' + fPadR(FieldByName('ITE_NUMPED').AsString, 21) + '|');
          Next;
        End;

        stlIncon.Add('-----------------------------------------------------------------------------');

      End;

    End;

    If stlIncon.Count > 0 Then
    Begin
      stlIncon.Add('* PRESSIONE ESC PARA SAIR');

      Result := False;

      pMostraMemo(stlIncon);
    End;

  End;

  FreeAndNil(qryItens);
  FreeAndNil(stlItens);
  FreeAndNil(stlIncon);

End;

procedure TfrmEntPreNotaEntrada.pVerificaItensComProblemasCadastro;
  var
    qryItem  : TUniQuery;
    strInfAdi: String;
Begin
  qryItem := fCriaQuery(Self);

  With qryItem, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT');
    Add('  SQL_NO_CACHE');
    Add('  ITE_CODBAR,');
    Add('  ITE_UNICOM,');
    Add('  ITE_EMBALA,');
    Add('  ITE_BAREMB');
    Add('FROM');
    Add('  CADITE');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE');

  End;

  With cdsCriticas Do
  Begin
    First;

    While Not Eof Do
    Begin
      qryItem.Close;
      qryItem.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
      qryItem.Open;

      Edit;

      FieldByName('CODBAR').AsString := qryItem.FieldByName('ITE_CODBAR').AsString;

      strInfAdi := '';
      FieldByName('INFADI').AsString := '';

      If fEmptyStr(qryItem.FieldByName('ITE_CODBAR').AsString) Then
        FieldByName('INFADI').AsString :=
          FieldByName('INFADI').AsString + 'Código de Barras não cadastrado / '

      Else If (qryItem.FieldByName('ITE_CODBAR').AsString <> FieldByName('NFEEAN').AsString) And (Not fEmptyStr(FieldByName('NFEEAN').AsString)) Then
        FieldByName('INFADI').AsString :=
          FieldByName('INFADI').AsString + 'Código de Barras cadastrado Diferente do Contido no XML / ';

      If (strCnvEmb <> 'N') And (qryItem.FieldByName('ITE_EMBALA').AsFloat > 0) Then
      Begin
        If fEmptyStr(qryItem.FieldByName('ITE_BAREMB').AsString) Then
          FieldByName('INFADI').AsString :=
            FieldByName('INFADI').AsString + 'Código de Barras Emb. não cadastrado / ';

        If fEmptyStr(qryItem.FieldByName('ITE_UNICOM').AsString) Then
          FieldByName('INFADI').AsString :=
            FieldByName('INFADI').AsString + 'Unidade de compra não cadastrada / ';
      End;

      strInfAdi := Trim(FieldByName('INFADI').AsString);

      If (Not fEmptyStr(strInfAdi)) And (strInfAdi[Length(strInfAdi)] = '/') Then
      Begin
        FieldByName('INFADI').AsString := LeftStr(strInfAdi, Length(strInfAdi) - 1);
      End;

      Post;

      Next;
    End;

    First;

  End;

  FreeAndNil(qryItem);

End;

end.

