unit untEntConferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, untTypesSistema, TypesRel,
  untFuncoesEtiquetas, Math, untEntConferenciaFuncoes,
  BitBtnLockedIncrem, untFuncoesRel, MemDS, DBAccess, Datasnap.Provider,
  frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.DBCtrls, DBMemoFocus, untZClient;

type
  TfrmEntConferencia = class(TfrmPaiOrdena)
    lblTipoDoc: TLabel;
    edtNumPed: TEditFocus;
    cdsConsultaITE_CODITE: TStringField;
    cdsConsultaITE_DESITE: TStringField;
    cdsConsultaITE_CODBAR: TStringField;
    cdsConsultaITE_REFERE: TStringField;
    cdsConsultaITE_DESUNI: TStringField;
    cdsConsultaITE_QTDCON: TFloatField;
    cdsCriticas: TUniClientDataSet;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxdbCriticas: TfrxDBDataset;
    cdsCriticasCODITE: TStringField;
    cdsCriticasQTDITE: TFloatField;
    cdsCriticasQTDCON: TFloatField;
    cdsCriticasDESITE: TStringField;
    cdsCriticasSIGUNI: TStringField;
    cdsConsultaITE_CODFAB: TStringField;
    cdsConsultaITE_LOCFIS: TStringField;
    cdsCriticasCODFAB: TStringField;
    cdsCriticasLOCFIS: TStringField;
    cdsCriticasSALDOS: TFloatField;
    cdsCriticasREFERE: TStringField;
    cdsConsultaITE_SALDOS: TFloatField;
    cdsConsultaPCG_CODEMP: TStringField;
    edtLisPed: TEditFocus;
    opdArqCol: TOpenDialog;
    mmoAjuda: TMemo;
    chkSintQtd: TCheckBox;
    cdsConsultaITE_EMBALA: TFloatField;
    pnlContagem: TPanel;
    rdbCodBar: TRadioButton;
    rdbCodFab: TRadioButton;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    Label3: TLabel;
    edtQtdIte: TEditFocus;
    lblQtdEti: TLabel;
    edtQtdEti: TEditFocus;
    cdsConsultaITE_QTDEMB: TFloatField;
    cdsConsultaITE_QTDUNI: TFloatField;
    cdsConsultaAUTOINCPCC: TStringField;
    cdsConsultaAUTOINCREM: TStringField;
    btnQuantidade: TBitBtnLocked;
    btnCriticas: TBitBtnLocked;
    btnQtdEti: TBitBtnLocked;
    btnCadSem: TBitBtnLocked;
    btnDigCodBarLocFis: TBitBtnLocked;
    btnImpColetor: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    Panel1: TPanel;
    spbEtiqueta: TSpeedButton;
    lblEtiqueta: TLabel;
    chkImprimeEtiqueta: TCheckBox;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblErrImg: TLabel;
    pnlFicIns: TPanel;
    Panel9: TPanel;
    dbeFicIns: TDBMemoFocus;
    Splitter1: TSplitter;
    cdsConsultaITE_FICINS: TMemoField;
    btnArquivosAnexos: TBitBtnLocked;
    btnEtiPro: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsConsultaAfterClose(DataSet: TDataSet);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumPedEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriticasClick(Sender: TObject);
    procedure btnQtdEtiClick(Sender: TObject);
    procedure btnCadSemClick(Sender: TObject);
    procedure rdbCodBarClick(Sender: TObject);
    procedure btnDigCodBarLocFisClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImpColetorClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure chkSintQtdClick(Sender: TObject);
    procedure chkImprimeEtiquetaClick(Sender: TObject);
    procedure spbEtiquetaClick(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure imgProDblClick(Sender: TObject);
    procedure btnArquivosAnexosClick(Sender: TObject);
    procedure btnEtiProClick(Sender: TObject);
  private
    { Private declarations }

    blnAbrindoConsulta,
    blnImgPro: Boolean;

    blnSintetizando: Boolean;
    objConEnt: TConfereEntrada;
    strDesEti: String;
    strCodCnd: String;
    strCndPag: String;
    strNumPar: String;
    tpeEtique: TTipoEtiqueta;
    blnPrePro: Boolean;
    intTabPre: Integer;
    stlAutoinc: TStringList;
    blnSelGarantia : Boolean;
    strETICEM: String;

    Function fRegistraItemConf: Boolean;
    Function fCancela: Boolean;
    Procedure pSetaRequeridos;
    procedure pAjustaColunas;
    procedure pIniciaOrdenacao;
    function fEscolheTipoEtiqueta: Boolean;
    procedure pImprimeEtiqueta(intQtdIte: Integer);
    function fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer): String;
    function fRetCamposIBPT: string;
    function fJoinIBPT: string;


  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;

    procedure pAcaoAbort; override;

  end;

Const
  MSG_ETIQUETA = 'Etiqueta não selecionada';

implementation

uses untRelEntConferencia, untPai, untFuncoesEtiqItens, untCadProFoto,
     untFuncoesSimples, untRelacSemelhanca, untEntConfPedidos, untCfgRel, untDllOpeProd,
     untDllOpeProdFuncoes, untEntImportaColetor, untFuncoesConsulta,
  untImagens, untGravaArquivoPasta, untEntEtiquetas;

{$R *.dfm}

Procedure TfrmEntConferencia.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
  For intIndex := 0 To FieldDefs.Count - 1 Do
    FieldDefs[intIndex].Required := FALSE;
End;

function TfrmEntConferencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin
      If edtNumPed.Enabled And (Not objConEnt.fValidaPedido(edtNumPed.Text, edtLisPed)) Then
        Result := FALSE;

      If Result And fAbreConsulta(TRUE) Then
      Begin
        pnlContagem.Enabled := TRUE;
        edtNumPed.Enabled := False;
        pSetFocus(edtCodIte);

        If (fCfgSis('REFENT', varBoolean)) and (fCfgSis('CONFME', varInteger) = 3) And not fEmptyStr(edtNumPed.Text) Then
          blnSelGarantia := fPedidoDeCompraOriundoDeGarantia(edtNumPed.Text, VS_strCodEmp);

        Exit;
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If Not objConEnt.fValidaQuantidade(edtQtdIte) Then
        Result := False

      Else If edtQtdIte.Focused Then
      Begin
        edtQtdEti.Text    := strETICEM;
        edtQtdIte.Enabled := False;
        If edtQtdEti.Visible Then
          pSetFocus(edtQtdEti)
        Else
          pSetFocus(edtCodIte);
        blnMudarFoco := False;
      End;

    End

    Else If (Sender = edtQtdEti) And (edtQtdEti.Visible) Then
    Begin

      If (StrToIntDef(edtQtdEti.Text, -1) < 0) Then
      Begin
        pMensagemSonora('A quantidade deve ser maior ou igual a zero!');
        Result := False;
      End
      Else
      Begin
        pSetFocus(edtCodIte);

        edtQtdIte.Enabled := False;
        edtQtdEti.Enabled := False;

        blnMudarFoco := False;
      End;
      
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEntConferencia.imgProDblClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsulta.IsEmpty) then
    TfrmImagens.pAbrirImagens(tiProduto, cdsConsulta.FieldByName('ITE_CODITE').AsString, True);
end;

Function TfrmEntConferencia.fGetSql(blnLike: Boolean): String;
Begin
  Result := objConEnt.fSqlConferencia(blnLike);
End;


function TfrmEntConferencia.fRetCamposIBPT: string;
  var
    i: integer;
Begin
  For i := 1 To 7 Do
  Begin
    If fCfgSis('IMPPAG', varInteger) = 1 Then
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
    End
    Else
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
    End;
  End;
End;

function TfrmEntConferencia.fJoinIBPT: string;
Begin
  Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = CADEMP.EMP_CODCID ';
  If fCfgSis('IMPPAG', varInteger) = 1 Then
  Begin
    If fCfgSis('TIPABF') = 2 Then
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = G.ITE_CODABF '
    Else
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = I.ITE_CODABF ';
  End
  Else
  begin
    Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = I.ITE_CLAIPI), ';
    
    Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) , ';
    Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2)))) ';
  End;
End;


function TfrmEntConferencia.fGetSqlItemEtiqueta(strCodIte: String;
  intQtdIte: Integer): String;
  Var
    strSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT                    ';
  Result := Result + '     EMP_CODEMP AS CODEMP, ';
  Result := Result + '     EMP_NOMEMP AS NOMEMP, ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + '   I.ITE_ATICOM AS ATICOM, ';
  Result := Result + '   I.ITE_CODITE AS CODITE, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS NUMDOC, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS ESPDOC, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS SERIE_, ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM,   ';
  Result := Result + '     EMP_C_G_C_ AS EMPCGC,   ';
  Result := Result + '   G.ITE_LOCFIS AS LOCFIS,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '   I.ITE_CODFOR AS CODFOR,   ';
  Result := Result + '     MAR_CODMAR AS CODMAR,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';
  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + ' IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + ' IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS ITE_PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS ITE_PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS ITE_PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS ITE_PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS ITE_PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS ITE_PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS ITE_PREVE7, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS PREVE7, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '   0.0000 AS VALITE,         ';
  Result := Result + '   0.0000 AS VALVIS,         ';
  Result := Result + '   I.ITE_DTAALT,         ';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '   CAST("" AS CHAR(1)) AS DESEMB ,';
  Result := Result + '   0.0000 AS TOTPRA,        ';
  Result := Result + '   0.0000 AS PREVIS,        ';
  Result := Result + '   0.0000 AS VALPAR,        ';
  Result := Result + '   0.0000 AS QTDPAR,        ';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " " , MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   G.ITE_AMZETI AS AMZETI,  ';
  Result := Result + '   I.ITE_ITEATI AS ITEATI,  ';
  Result := Result + '   G.ITE_SALDOS AS SALDOS,  ';

  Result := Result + '   CADEMP.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '   CADEMP.EMP_FONDA2 AS FONDA2,  ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS,       ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1,       ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2,       ';

  Result := Result + ' CAST("" AS CHAR(1)) AS LOTECR, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS EMBALA, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS EMBPRE, ';
  Result := Result + ' FOR_CODFOR AS CODFOR, ';
  Result := Result + ' FOR_NOMFOR AS NOMFOR, ';
  Result := Result + ' G.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS DESEMB, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS OBSIMP, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS CODAMZ, ';
  Result := Result + ' ITE_VALIDA AS VALIDA,';
  Result := Result + ' ITE_ITESAC AS ITESAC, ';
  Result := Result + ' ITE_COMPOS AS COMPOS, ';
  Result := Result + ' ITE_PAISOR AS PAISOR, ';
  Result := Result + ' ITE_ESTMIN AS ESTMIN, ';
  Result := Result + ' ITE_ESTMAX AS ESTMAX, ';
  Result := Result + ' ITE_MLTVEN AS MLTVEN, ';
  Result := Result +  fRetCamposIBPT;
  Result := Result + '   I.AUTOINCREM,              ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR       ';

  Result := Result + ' FROM                        ';
  Result := Result + '   CADITE I  ';
  Result := Result + '   INNER JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';

  Result := Result + '   INNER JOIN CADEMP ON EMP_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = I.ITE_CODFOR  ';

  Result := Result + '   INNER JOIN ITEGER G ON          ';
  Result := Result + '     I.ITE_CODITE = G.ITE_CODITE AND ';
  Result := Result + '     G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + '   INNER JOIN CADMAR ON       ';
  Result := Result + '     MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + '   LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '   WHERE  ';
  Result := Result + '   PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result +    fJoinIBPT;
  Result := Result + ' WHERE                      ';
  Result := Result + '   I.ITE_CODITE = ' + QuotedStr(strCodIte);

  strSQL := Result;

end;

Function TfrmEntConferencia.fCancela: Boolean;
Begin
  Result := True;

  If (edtNumPed.Focused) Or cdsConsulta.IsEmpty Then
    Close

  Else If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
  Begin
    edtNumPed.Enabled := True;
    pSetFocus(edtNumPed);
    edtNumPed.Clear;
    objConEnt.stlPedidos.Clear;
    objConEnt.stlEmpresas.Clear;
    edtLisPed.Clear;
  End

  Else Result := False;

End;

procedure TfrmEntConferencia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
                 fRegistraItemConf
               Else
                 inherited;
    VK_F6: btnQuantidade.Click;
    VK_F7: If btnQtdEti.Visible Then btnQtdEti.Click;
    VK_F8: btnImpColetor.Click;
    VK_F9: btnCriticas.Click;
    VK_F11: btnCadSem.Click;
    VK_F12: btnDigCodBarLocFis.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_ESCAPE:  If pnlPesquisa.Visible Then
                Begin
                 inherited
                End Else
                Begin
                  If Not fCancela Then
                    Key := 0;
                End;

    VK_DELETE: If dbgConsulta.Focused Then
                 btnExcluir.Click;

    VK_F1: If spbEtiqueta.Enabled Then
             spbEtiqueta.Click;

    Else inherited;
  End;

end;

procedure TfrmEntConferencia.pImprimeEtiqueta(intQtdIte: Integer);
  Var
    qryIteEti: TUniQuery;
    strNomFil: String;
    prmDllEtq: TParamDllEtiquetas;
    cdsIteEti: TZClient;
    DataSetEti: TDataSet;
    i, x: integer;

begin
  inherited;
  Try
    Try
      qryIteEti := fCriarQuery(fGetSqlItemEtiqueta(cdsConsulta.FieldByName('ITE_CODITE').AsString, intQtdIte));
      qryIteEti.Open;
      cdsIteEti := TZClient.Create(nil, fGetSqlItemEtiqueta(cdsConsulta.FieldByName('ITE_CODITE').AsString, intQtdIte));
      cdsIteEti.fAbreClient(False, 'TConferePreNota.pImprimeEtiqueta');
      for i := 2 To intQtdIte do
      begin
        cdsIteEti.Insert;
        For x := 0 to qryIteEti.Fields.Count -1 do
          cdsIteEti.Fields[x].Value := qryIteEti.Fields[x].Value;
        cdsIteEti.Post;
      end;
      DataSetEti := cdsIteEti;


      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      prmDllEtq := TParamDllEtiquetas.Create;

      prmDllEtq.tpeTipEtq := tpeEtique;
      prmDllEtq.intTabPre := intTabPre;
      prmDllEtq.dtsImpres := DataSetEti;
      prmDllEtq.strNomFil := strNomFil;
      prmDllEtq.strNomFrm := Self.Name;
      prmDllEtq.intNumCop := 1;
      prmDllEtq.blnImpEti := True;

      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');

      FreeAndNil(prmDllEtq);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEntConferPreNota.pImprimeEtiqueta]');
      End;

    End;
  Finally
    If Assigned(qryIteEti) then
      FreeAndNil(qryIteEti);
    If Assigned(cdsIteEti) then
      FreeAndNil(cdsIteEti);

  End;


end;

procedure TfrmEntConferencia.pIniciaOrdenacao;
Begin
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;
End;

procedure TfrmEntConferencia.FormShow(Sender: TObject);
begin
  inherited;

  blnAbrindoConsulta  := False;

  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  strETICEM := fCfgSis('ETICEM');

  pIniciaOrdenacao;

  If fCfgSis('IMETEM', varBoolean) Then
  Begin
    objConEnt.pCarregaEtiqueta(Self.Name);
    edtQtdEti.Text   := strETICEM;
  End
  Else
  Begin
    lblQtdEti.Visible := False;
    edtQtdEti.Visible := False;
    btnQtdEti.Visible := False;
  End;
  rdbCodFab.Visible := fCfgSis('UTICFB', varBoolean);
  stlAutoinc := TStringList.Create;

  cdsConsultaITE_REFERE.Size := fTamRefere;
  pAjustaColunas;
  pSetFocus(edtNumPed);  
end;

procedure TfrmEntConferencia.pAjustaColunas;
Begin
  If chkSintQtd.Checked Then
  Begin
    dbgConsulta.Columns[1].Width   := dbgConsulta.Columns[1].Width +
                                      dbgConsulta.Columns[4].Width +
                                      dbgConsulta.Columns[5].Width;
    dbgConsulta.Columns[4].Visible := False;
    dbgConsulta.Columns[5].Visible := False;
  End Else
  Begin
    dbgConsulta.Columns[4].Visible := True;
    dbgConsulta.Columns[5].Visible := True;
    dbgConsulta.Columns[1].Width   := dbgConsulta.Columns[1].Width -
                                      dbgConsulta.Columns[4].Width -
                                      dbgConsulta.Columns[5].Width;
  End;
End;

procedure TfrmEntConferencia.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  edtQtdEti.Enabled := True;
  pSetFocus(edtQtdIte);

end;

procedure TfrmEntConferencia.btnEtiProClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    pMensagemOk('Nenhum item conferido!');
    Exit;
  End;

  TfrmEntEtiquetas.pImpEtiConfPedido(objConEnt.stlPedidos);
end;

procedure TfrmEntConferencia.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If (Not btnExcluir.Enabled) Then
    Exit;

  objConEnt.pExcluiItem;

  pSetFocus(edtCodIte);
end;

procedure TfrmEntConferencia.btnImpColetorClick(Sender: TObject);
begin
  inherited;
  TEntImportaColetor.fImportaColetor(cdsConsulta, edtCodIte, edtQtdIte, fRegistraItemConf);
end;

procedure TfrmEntConferencia.btnSairClick(Sender: TObject);
begin
  fCancela;
end;

procedure TfrmEntConferencia.cdsConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;

  If Not blnSintetizando Then
  Begin
    pnlContagem.Enabled := FALSE;
    objConEnt.pLiberaLista;
    edtLisPed.Clear;
    objConEnt.stlPedidos.Clear;
    objConEnt.stlEmpresas.Clear;
    objConEnt.strCodFor := '';
  End;

  With cdsConsulta Do
  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, '');
end;

procedure TfrmEntConferencia.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(DataSet.IsEmpty, '', DataSet.FieldByName('ITE_CODITE').AsString));

end;

procedure TfrmEntConferencia.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If DataSet.Active Then
    objConEnt.intRecNo := DataSet.RecNo;


  If blnAbrindoConsulta Then
    Exit;

  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(DataSet.IsEmpty, '', DataSet.FieldByName('ITE_CODITE').AsString));
  If cdsConsulta.FieldByName('ITE_CODITE').AsString <> '' Then
     btnArquivosAnexos.Visible := DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + cdsConsulta.FieldByName('ITE_CODITE').AsString);

end;

procedure TfrmEntConferencia.chkImprimeEtiquetaClick(Sender: TObject);
begin
  inherited;
  If chkImprimeEtiqueta.Checked And (lblEtiqueta.Caption = MSG_ETIQUETA) Then
  Begin
    chkImprimeEtiqueta.Checked := fEscolheTipoEtiqueta;
  End;

  If chkImprimeEtiqueta.Checked And (StrToIntDef(edtQtdEti.Text, 0) = 0) Then
    edtQtdEti.Text := '1';

end;

procedure TfrmEntConferencia.chkSintQtdClick(Sender: TObject);
begin
  inherited;

  objConEnt.blnSintetico := chkSintQtd.Checked;
  pAjustaColunas;

  If Not edtNumPed.Enabled Then
  Begin
    Try
      blnSintetizando := True;
      pIniciaOrdenacao;
      fValidaCampos(edtNumPed, True);
    Finally
      blnSintetizando := False;
    End;
  End;
  
end;

procedure TfrmEntConferencia.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsConsulta.Active Then
    Exit;

  If cdsConsulta.RecNo = objConEnt.intRecNo Then
  Begin
    dbgConsulta.Canvas.Brush.Color := clBlue;
    dbgConsulta.Canvas.Font.Color  := clWhite;
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEntConferencia.pAcaoAbort;
Begin
  pSetFocus(edtCodIte);
End;

procedure TfrmEntConferencia.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlRegSel: TStringList;
    frmEntConfPedidos: TfrmEntConfPedidos;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlRegSel := TStringList.Create;
    pCriarFormularios(TfrmEntConfPedidos, frmEntConfPedidos);
    Try
      frmEntConfPedidos.objConEnt := objConEnt;
      frmEntConfPedidos.blnConferenciaPorPedido := ( Pos(fCfgSis('CONFME', varString), '3_2_') > 0) And fCfgSis('REFENT', varBoolean);
      frmEntConfPedidos.stlRegSel := stlRegSel;

      If frmEntConfPedidos.ShowModal = mrOK Then
      Begin
        blnSelGarantia := frmEntConfPedidos.blnSelGarantia;
        stlAutoinc.Text  := frmEntConfPedidos.stlListSelecao.Text;
        objConEnt.pRetListaPedidos(objConEnt.stlPedidos, objConEnt.stlEmpresas, stlAutoinc, frmEntConfPedidos.cdsConsulta);
        edtNumPed.Clear;

        edtLisPed.Visible := True;
        edtLisPed.Text := objConEnt.stlPedidos.CommaText;

        fValidaCampos(edtNumPed);
      End;
    Finally
      FreeAndNil(stlRegSel);
      FreeAndNil(frmEntConfPedidos);
    End;

  End;

end;

procedure TfrmEntConferencia.edtNumPedEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;
  edtNumPed.Clear;

end;

function TfrmEntConferencia.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  blnAbrindoConsulta := True;

  Try

    Result := inherited fAbreConsulta(blnLike) And objConEnt.fRetTotalItens;
    pSetaRequeridos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEntConferencia.fAbreConsulta]');
    End;
  End;

  blnAbrindoConsulta := False;

  With cdsConsulta Do
  TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, IfThen(IsEmpty, '', FieldByName('ITE_CODITE').AsString));
End;

procedure TfrmEntConferencia.FormCreate(Sender: TObject);
begin
  inherited;

  blnImgPro := fCfgSis('IMGPRO') = 'S';

  pnlImgPro.Visible  := blnImgPro;

  blnSintetizando := False;

  cdsCriticas.CreateDataSet;
  cdsCriticas.Open;

  objConEnt := TConfereEntrada.Create(cdsConsulta,
                                      cdsCriticas,
                                      edtNumPed,
                                      dbgConsulta,
                                      cdsConsultaAfterScroll);

  edtQtdIte.EditFormat := fMskDigitos(objConEnt.intDeqTpc);

  edtNumPed.MaxLength := fTamDocCadRec();
  edtNumPed.TamCampo  := edtNumPed.MaxLength;
  blnSelGarantia := False;

  If fCfgSis('ITEBAR', varBoolean) Then
  Begin
    rdbCodBar.Enabled := False;
    rdbCodBar.Checked := True;
    rdbCodFab.Enabled := False;
  End;
end;

procedure TfrmEntConferencia.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.Active Then
  Begin
    fMensagem('', 'É necessário selecionar um pedido!', ['&Ok']);
    Exit;
  end;
    
  objConEnt.pConfirma(blnSelGarantia);
end;

procedure TfrmEntConferencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(stlAutoinc);

  cdsCriticas.EmptyDataSet;
  cdsCriticas.Close;
end;

procedure TfrmEntConferencia.btnCriticasClick(Sender: TObject);
var
  frmRelEntConferencia: TfrmRelEntConferencia;
begin
  inherited;

  If objConEnt.fPedidoCompleto(TRUE) Then

    fMensagem('', 'Não há inconsistências no Pedido!', ['&Ok'])

  Else
  Begin
    If (Not cdsConsulta.Active) Then
      Exit;                                          

    If (Not cdsCriticas.Active) Then
      Exit;
      
    pCriarFormularios(TfrmRelEntConferencia, frmRelEntConferencia);

    frmRelEntConferencia.cdsCriticas := cdsCriticas;
    frmRelEntConferencia.strNumPed   := 'PEDIDO(S): '  + objConEnt.stlPedidos.CommaText;
    frmRelEntConferencia.strFornec   := objConEnt.strCodFor + ' - ' + fRetNomFornecedor(objConEnt.strCodFor);
    frmRelEntConferencia.blnEhConferenciaDePedido := True;
    frmRelEntConferencia.ShowModal;

    FreeAndNil(frmRelEntConferencia);

  End;

end;

procedure TfrmEntConferencia.btnQtdEtiClick(Sender: TObject);
begin
  inherited;

  If (Not btnQtdEti.Enabled) Then
    Exit;

  chkImprimeEtiqueta.Checked := True;
  edtQtdEti.Enabled := True;
  pSetFocus(edtQtdEti);

end;



procedure TfrmEntConferencia.btnArquivosAnexosClick(Sender: TObject);
begin
  If Not btnArquivosAnexos.Visible Then
    Exit;

  pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + cdsConsulta.FieldByName('ITE_CODITE').AsString;
    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos em Anexo )';
    frmGravaArquivoPasta.btnImportar.Enabled := False;
    frmGravaArquivoPasta.blnConsulta := True;

    frmGravaArquivoPasta.ShowModal;
  Finally
    FreeAndNil(frmGravaArquivoPasta);
  End;

end;

procedure TfrmEntConferencia.btnCadSemClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmRelacSemelhanca, frmRelacSemelhanca);
end;

procedure TfrmEntConferencia.rdbCodBarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  edtCodIte.MaxLength := IIF(rdbCodBar.CheCked, 15, 25);

end;

procedure TfrmEntConferencia.spbEtiquetaClick(Sender: TObject);
begin
  inherited;
  fEscolheTipoEtiqueta;
end;

procedure TfrmEntConferencia.btnDigCodBarLocFisClick(Sender: TObject);
begin
  inherited;

  If fVerificaAcessoSistema('CODBAR') Then
    pOpeProd(DigCodBarLocFis)
  Else
    pMensagemOk('Liberar direito em Direitos de Acesso (Entrada de Mercadorias\ Permitir alterar o código de barras do cadastro de produtos)');
end;

procedure TfrmEntConferencia.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objConEnt);
end;

Function TfrmEntConferencia.fRegistraItemConf: Boolean;
  Var
    blnCodBarNaoEcontrado: Boolean;
Begin
  Result := FALSE;

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If Not fValidaCampos(edtQtdIte) Then
    Exit;

  If Not fValidaCampos(edtQtdEti) Then
    Exit;

  Result := objConEnt.fRegistraItem(rdbCodBar.Checked, rdbCodFab.Checked,
              edtCodIte, edtQtdIte, Nil, True, blnCodBarNaoEcontrado);

  If Result Then
  Begin
    If chkImprimeEtiqueta.Checked Then
      pImprimeEtiqueta(StrToIntDef(edtQtdEti.Text,0));

    objConEnt.pAtualizaDataConf;
    edtQtdEti.Text := strETICEM;
  End;

  If blnCodBarNaoEcontrado And  fPergunta('Deseja cadastrar um novo código de barras?') Then
    btnDigCodBarLocFis.Click;

End;

function TfrmEntConferencia.fEscolheTipoEtiqueta: Boolean;
  Var
    blnExiPrePro : Boolean;
begin
  Result := untFuncoesEtiqItens.fEscolheTipoEtiqueta (tpeEtique, False, blnPrePro, intTabPre, strCodCnd, strCndPag, strNumPar, strDesEti, blnExiPrePro);
  If Result Then
    lblEtiqueta.Caption := strDesEti;
end;

end.

