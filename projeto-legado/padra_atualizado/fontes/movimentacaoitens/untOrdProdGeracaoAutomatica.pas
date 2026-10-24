unit untOrdProdGeracaoAutomatica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,
  DBAccess, Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  System.ImageList, Vcl.ImgList, cxProgressBar, untOrdPro;

type
  TRetornoSaldo = (rsOk, rsContinuarSemSaldo, rsContinuarComSaldo, rsCancelarProcesso);
  TfrmOrdProdGeracaoAutomatica = class(TfrmPaiOrdena)
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    lblSalRes: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblSalDis: TLabel;
    editSaldos: TEditFocus;
    edtSalRes: TEditFocus;
    edtSalReG: TEditFocus;
    edtSalEntFut: TEditFocus;
    edtSalDis: TEditFocus;
    btnPedSalRes: TBitBtnLocked;
    btnLotIte: TBitBtnLocked;
    pnlVAAUPR: TPanel;
    imglSitFin: TImageList;
    pnlFilSitFin: TPanel;
    Label11: TLabel;
    cmbSitFin: TcxImageComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnLotIteClick(Sender: TObject);
    procedure btnPedSalResClick(Sender: TObject);
    procedure cmbSitFinClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgConsultaTitleClick(Column: TColumn);
  private
    objOrdPro: TOrdPro;
    fltQtdApr : Double;
    rsDecisaoUsuario : TRetornoSaldo;
    function fDecisaoUsuario:TRetornoSaldo;
    function fChecaQuantProdutoDisponivel(strCodPro : String) : Boolean;
  protected
    blnEntFut : Boolean;

    blnVAAUPR: Boolean;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAtualizarSituacaoFinanceiraPedidos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pFiltrarPedidos;

    function fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
    function fField(strFieldName: String): TField;


    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; override;
    function fGetOrderBy: String; Override;

    procedure pAddListaQuery; Override;
    procedure pSetFilterDefault; override;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untFuncoesRel, untFuncoesRel2,
  untIFatReservaSaldo, untTFatReservaSaldo, untIFatEntregaFutura,
  untTFatEntregaFutura, untValidaSituacaoFinanceiraPedido, untGravando;

{***************************************************************************}
{*  BUSCA OS ITENS ESTRUTURAS CONTIDOS NOS PEDIDOS DE VENDA NAO FATURADOS  *}
{*  FDO_JAFATU = 0 E QUE NAO POSSUAM ORDEM DE PRODUCAO EMITIDA FDO_ORDPRO  *}
{************************************************************************JC*}
function TfrmOrdProdGeracaoAutomatica.fGetSql(blnLike: Boolean): String;
  Var
    strSql : String;
    strEmp_CD : String;
    function fGetSQLDetVlrCon: String;
    Begin
      Result := '';
      Result := Result + ' (FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP) - ';
      Result := Result + ' IFNULL( ( SELECT SUM(DET_VLRCON) ';
      Result := Result + '   FROM   MOVDET ';
      Result := Result + '   WHERE  DET_NUM_PD = FDO_NUMDOC  ';
      Result := Result + '   AND    DET_ESP_PD = FDO_ESPDOC  ';
      Result := Result + '   AND    DET_EMP_PD = FDO_CODEMP  ';
      Result := Result + '   AND    DET_CODITE = FDO_CODITE  ';
      Result := Result + '   AND    DET_IND_PD = FDO_SEQIND  ';
      Result := Result + '   AND    (SELECT COUNT(BRI_SEQDET) FROM BRIDET WHERE BRI_SEQDET = MOVDET.AUTOINCREM) = 0), 0) ';
    End;
begin
  strEmp_CD := fCfgSis('EMP_CD');

  strSql := '';
  strSql := strSql + ' SELECT                                                ';
  strSql := strSql + '   FDO_NUMDOC,                                         ';
  strSql := strSql + '   FDO_ESPDOC,                                         ';
  strSql := strSql + '   FDO_DTAENT,                                         ';
  strSql := strSql + '   "OK" AS SITFIN,                                     ';
  If (fCfgSis('ENT_CD', varBoolean)) And (VS_strCodEmp = strEmp_CD) Then
    strSql := strSql + ' IF(FGO_ENT_CD = "S", IFNULL(FGO_EMP_CD, FGO_CODEMP), IF( IFNULL(FGO_EMP_TE,"") <> "", FGO_EMP_TE,  FGO_CODEMP)) AS EMPPRO, '
  Else
    strSql := strSql + '   IF( IFNULL(FGO_EMP_TE,"") <> "", FGO_EMP_TE,  FGO_CODEMP) AS EMPPRO, ';


  strSql := strSql + '   (SELECT ';
  strSql := strSql + '      SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ';
  strSql := strSql + '    FROM ';
  strSql := strSql + '      ADTCLI ';
  strSql := strSql + '    WHERE ';
  strSql := strSql + '      ADT_NUMDOC = FGO_NUMDOC AND ';
  strSql := strSql + '      ADT_ESPDOC = FGO_ESPDOC AND ';
  strSql := strSql + '      ADT_CODEMP = FGO_CODEMP AND ';
  strSql := strSql + '      ADT_CODCLI = FGO_CODCLI) AS VALADT, ';

  strSql := strSql + '   (SELECT ';
  strSql := strSql + '      SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) ';
  strSql := strSql + '    FROM ';
  strSql := strSql + '      CADREC ';
  strSql := strSql + '    WHERE ';
  strSql := strSql + '      CTR_NUMDUP = FGO_NUMDOC AND ';
  strSql := strSql + '      CTR_ESPDOC = FGO_ESPDOC AND ';
  strSql := strSql + '      CTR_CODEMP = FGO_CODEMP AND ';
  strSql := strSql + '      CTR_CODCLI = FGO_CODCLI AND ';
  strSql := strSql + '      CTR_DTAREC IS NOT NULL) AS VALREC, ';

  strSql := strSql + '   FATGOR.FGO_CONPAG AS CONPAG, ';
  strSql := strSql + '   FGO_NUMDOC AS NUMDOC,        ';
  strSql := strSql + '   FGO_ESPDOC AS ESPDOC,        ';
  strSql := strSql + '   FGO_CODEMP AS CODEMP,        ';

  strSql := strSql + '   FGO_CODCLI AS CODCLI,        ';
  strSql := strSql + '   FATGOR.FGO_CODFPG AS CODFPG, ';
  strSql := strSql + '   (SELECT ';
  strSql := strSql + '      GROUP_CONCAT(FPN_CODFPG) ';
  strSql := strSql + '    FROM ';
  strSql := strSql + '      FPGNEG ';
  strSql := strSql + '    WHERE ';
  strSql := strSql + '      FPGNEG.FPN_SEQFGO = FATGOR.AUTOINCREM) AS FPGNEG, ';
  strSql := strSql + '   FATGOR.AUTOINCREM AS AUTINC, ';
  strSql := strSql + '   FGO_TIPOPE AS TIPOPE,        ';
  If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) And (Not fCfgSis('LOCRET', VarBoolean)) Then
  Begin
    strSql := strSql + '  "N" AS ORIF11,';
  End
  Else
  Begin
    strSql := strSql + ' (SELECT ';
    strSql := strSql + '    IF(COUNT(*) > 0, "S", "N") ';
    strSql := strSql + '  FROM ';
    strSql := strSql + '    FATDOR AS PEDORI ';
    strSql := strSql + '  WHERE ';
    strSql := strSql + '    PEDORI.FDO_NUMFAT = FATGOR.FGO_NUMDOC AND ';
    strSql := strSql + '    PEDORI.FDO_TIPFAT = FATGOR.FGO_ESPDOC AND ';
    strSql := strSql + '    PEDORI.FDO_EMPFAT = FATGOR.FGO_CODEMP) AS ORIF11, ';
  End;

  strSql := strSql + '   SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP, ROUND(' + fGetSQLDetVlrCon + ', 2 ) ) ) AS VLRCON, ';
  strSql := strSql + '   EXTGOR.FGO_TOTBRI AS TOTBRI, ';
  strSql := strSql + '   EXTGOR.FGO_BOLADT AS BOLADT, ';
  strSql := strSql + '   EXTGOR.FGO_BOLVEN AS BOLVEN, ';
  strSql := strSql + ' (SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N", "N", "S") ';
  strSql := strSql + '    FROM FATDOR FD ';
  strSql := strSql + '    LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
  strSql := strSql + '   WHERE FD.FDO_SEQGER = FATGOR.AUTOINCREM) AS BENFUT, ';

  strSql := strSql + '   FDO_CODEMP,                                         ';
  strSql := strSql + '   FDO_CODCLI,                                         ';
  strSql := strSql + '   CLI_NOMCLI,                                         ';
  strSql := strSql + '   FDO_CODITE,                                         ';
  strSql := strSql + '   FDO_DESCRI,                                         ';
  strSql := strSql + '   SUM(FDO_QTDITE) AS FDO_QTDITE,                      ';
  strSql := strSql + '   UNI_SIGUNI,                                         ';
  strSql := strSql + '   FGO_LIBERA,                                         ';
  If fUsaQtdPendenteEntregaFutura Then
    strSql := strSql + ' ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('', True) + ' AS ITE_SALDOS, '
  Else
    strSql := strSql + '   ITE_SALDOS,                                       ';
  strSql := strSql + '   F.AUTOINCREM                                        ';
  strSql := strSql + ' FROM FATDOR F                                         ';
  strSql := strSql + '   INNER JOIN GERMAT ON FDO_CODITE = GMT_CODITE        ';
  strSql := strSql + '   INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSql := strSql + '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSql := strSql + '   LEFT JOIN EXTDOR ON FDO_SEQFDO = F.AUTOINCREM       ';
  strSql := strSql + '   LEFT  JOIN CADCLI ON (CLI_CODCLI = FDO_CODCLI)      ';
  strSql := strSql + '   LEFT  JOIN CADUNI ON (UNI_CODUNI = FDO_UNIDAD)      ';
  strSql := strSql + '   INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE        ';
  strSql := strSql + '                    AND ITE_CODEMP = :CODEMP           ';
  strSql := strSql + ' WHERE FDO_JAFATU = 0                                  ';
  strSql := strSql + '   AND FDO_ESPDOC = "PD"                               ';
  strSql := strSql + '   AND (                                               ';
  strSql := strSql + '         FDO_ORDPRO IS NULL AND                              ';
  strSql := strSql + '         ((SELECT COUNT(1) FROM MOVPRO WHERE PRO_CODEMP = FDO_CODEMP AND PRO_NUMDOC = FDO_NUMDOC AND PRO_ESPDOC = FDO_ESPDOC AND PRO_CODITE = FDO_CODITE) = 0)                              ';
  strSql := strSql + '       )                                               ';

  If (fCfgSis('BXSBIT', varString) = '3') Then
    strSql := strSql + '   AND FDO_BXSBIT = "S"                              ';
  {strSql := strSql + ' GROUP BY F.AUTOINCREM                                 ';}
  strSql := strSql + 'GROUP BY FDO_NUMDOC,FDO_ESPDOC,IF(IFNULL(FGO_EMP_TE, "") <> "", FGO_EMP_TE, FGO_CODEMP), FDO_DTAENT, FDO_CODCLI, FDO_CODITE ';

  strSql := strSql + ' ORDER BY FDO_DTAENT, FDO_CODEMP,                      ';
  strSql := strSql + '          FDO_NUMDOC, FDO_CODITE                       ';

  Result := strSql;

end;

function TfrmOrdProdGeracaoAutomatica.fAtualizarSituacaoFinanceiraPedidos(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strPenFin: String;
begin
  pgbProgresso.Properties.Max := cdsConsulta.RecordCount;
  Result := True;
  With cdsConsulta Do
  Begin
    Filtered := False;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fSituacaoFinanceiraPedidoOk(strPenFin) Then
        fField('SITFIN').AsString := 'OK'
      Else
        fField('SITFIN').AsString := '';

      Post;
      Next;
      pgbProgresso.Position := cdsConsulta.RecNo;
      Application.ProcessMessages;
    End;
    pFiltrarPedidos;
    First;
  End;
end;


procedure TfrmOrdProdGeracaoAutomatica.pFiltrarPedidos;
begin
  If Not blnVAAUPR Then
    Exit;
  cdsConsulta.Filtered := False;
  If pnlFilSitFin.Visible Then
  Begin
    Case cmbSitFin.ItemIndex Of
      1: cdsConsulta.Filter :=  'SITFIN <> ' + QuotedStr('OK');
      2: cdsConsulta.Filter :=  'SITFIN =  ' + QuotedStr('OK');
    Else
     cdsConsulta.Filter :=  'AUTINC <>  ' + fQuotedStr('');
    End;
  End;
  cdsConsulta.Filtered := True;
  Application.ProcessMessages;
End;


procedure TfrmOrdProdGeracaoAutomatica.pSetFilterDefault;
begin
  inherited;
  pFiltrarPedidos;
end;

function TfrmOrdProdGeracaoAutomatica.fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
  Var
   blnJaUsouCreditoDeAdiantamento: Boolean;
   fltValRec: Double;
   strConPag: String;
begin
  {************************************************************************}
  {* TELA DE FORMULAÇÃO DE TINTA DE MÁQUINA POSSUI A MESMA REGRA ABAIXO,  *}
  {* SE ALTERAR, VERIFICAR A NECESSIDADE DE ALTERAR LÁ TAMBÉM!            *}
  {*********************************************************************RN*}

  blnJaUsouCreditoDeAdiantamento:= False;

  fltValRec := fFormataFloat(fField('VALADT').AsFloat + fField('VALREC').AsFloat, 2);
  strConPag := fField('CONPAG').AsString;

  If ((strConPag = '01000') And (fltValRec > 0) And (fltValRec < fField('VLRCON').AsFloat))
     Or
     ((fltValRec <= 0) And (strConPag <> '01000') And (fConPagComEntrada(strConPag))) Then
  Begin
    blnJaUsouCreditoDeAdiantamento := fJaUsouCreditoDeAdiantamento(fField('NUMDOC').AsString,
                                                                   fField('ESPDOC').AsString,
                                                                   fField('CODEMP').AsString);
  End;

  Result := fValidaSituacaoFinanceiraPedido(fField('CODCLI').AsString,
                                            fField('ESPDOC').AsString,
                                            fField('CODFPG').AsString,
                                            strConPag,
                                            fField('FPGNEG').AsString,
                                            fField('AUTINC').AsString,
                                            fField('TIPOPE').AsString,
                                            fField('ORIF11').AsString = 'S',
                                            fField('VLRCON').AsFloat - fField('TOTBRI').AsFloat,
                                            fltValRec,
                                            fField('BOLADT').AsFloat,
                                            fField('BOLVEN').AsString = 'S',
                                            fField('BENFUT').AsString = 'S',
                                            strPenFin,
                                            blnJaUsouCreditoDeAdiantamento);
end;


function TfrmOrdProdGeracaoAutomatica.fField(strFieldName: String): TField;
begin
  Result := cdsConsulta.FindField(strFieldName);
end;

function TfrmOrdProdGeracaoAutomatica.fAbreConsulta(blnLike: Boolean): Boolean;
 var frmGravando : TfrmGravando;
begin
  Result := inherited fAbreConsulta(blnLike);
  If blnVAAUPR Then
  Begin

    frmGravando := TfrmGravando.Create(Self);
    Try
      frmGravando.lblGravando.Caption := 'Atualizando Situação Financeira...';
      frmGravando.fExecutarAcao := fAtualizarSituacaoFinanceiraPedidos;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando)
    End;
  End;
end;

function TfrmOrdProdGeracaoAutomatica.fSetParametros: Boolean;
begin
  Result := Inherited fSetParametros;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;


{$R *.dfm}

procedure TfrmOrdProdGeracaoAutomatica.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  fAbreConsulta(True);

  edtSalEntFut.Visible := blnEntFut;
  label7.Visible       := blnEntFut;

end;

procedure TfrmOrdProdGeracaoAutomatica.pAddListaQuery;
begin
  If fCfgSis('LIBPED', varBoolean) Then
  Begin
    If cdsConsulta.FieldByName('FGO_LIBERA').AsInteger <= 0 Then
    Begin
      pMensagemOK('Pedido não liberado, não é possível marcar este registro.' + #13 + 'Efetue a liberação do pedido em "Liberação de Pedidos".');
      Exit;
    End;
  End;

  inherited;
end;

{*********************************************}
{* MARCA TODOS OS REGISTROS PARA CONFIRMACAO *}
{******************************************JC*}
procedure TfrmOrdProdGeracaoAutomatica.btnMarcaClick(Sender: TObject);
begin
  inherited;
  stlListSelecao.Clear;

  With cdsConsulta Do
  Begin

    First;
    DisableControls;

    While Not Eof Do
    Begin
      pAddListaQuery;
      Next;
    End;

    EnableControls;

  End;
end;

procedure TfrmOrdProdGeracaoAutomatica.btnPedSalResClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(208, 7626, [],
                        ['CODITE','ESPDOC','CODEMP'],
                        [cdsConsulta.FieldByName('FDO_CODITE').AsString,
                        'PD',
                        VS_strCodEmp],
                        Sender,
                        nil,
                        True);

  End;

end;

procedure TfrmOrdProdGeracaoAutomatica.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pFiltrarPedidos;
end;

procedure TfrmOrdProdGeracaoAutomatica.cdsConsultaAfterScroll(DataSet: TDataSet);
var
  fltSalExt: Double;
begin
  inherited;
  edtSalRes.Clear;
  edtSalReG.Clear;
  edtSalDis.Clear;
  editSaldos.Clear;
  edtSalEntFut.Clear;

  If cdsConsulta.IsEmpty Then
    Exit;

  If blnEntFut Then
    edtSalEntFut.Text := FormatFloat('#,##0.000', TEntregaFutura.New(
                                                    TParamEF.New()
                                                      .CodIte(cdsConsulta.FieldByName('FDO_CODITE').AsString)
                                                      .CodEmp(VS_strCodEmp)
                                                      .ConverteML(True)
                                                      .TipoTE(tteTodas)
                                                    ).Total());

  editSaldos.Text := FormatFloat('#,##0.000', cdsConsulta.FieldByName('ITE_SALDOS').AsFloat);
  edtSalRes.Text  := FormatFloat('#,##0.000', TSaldoReservado.New(
                                                TReservaParametros.New()
                                                  .EmpresaItem(VS_strCodEmp)
                                                  .CodigoItem(cdsConsulta.FieldByName('FDO_CODITE').AsString)
                                                  .CodEmpresa(VS_strCodEmp)
                                                  .TipoReserva(trsPedidoVenda)
                                                  .ConverterML(True)
                                                ).fGetQuantidade());

  edtSalReG.Text  := FormatFloat('#,##0.000', TSaldoReservado.New(
                                                TReservaParametros.New()
                                                  .EmpresaItem(VS_strCodEmp)
                                                  .CodigoItem(cdsConsulta.FieldByName('FDO_CODITE').AsString)
                                                  .CodEmpresa(VS_strCodEmp)
                                                  .TipoReserva(trsGarantia)
                                                  .ConverterML(True)
                                                ).fGetQuantidade());

  fltSalExt := TSaldoReservado.New(
                TReservaParametros.New()
                  .EmpresaItem(VS_strCodEmp)
                  .CodigoItem(cdsConsulta.FieldByName('FDO_CODITE').AsString)
                  .CodEmpresa(VS_strCodEmp)
                  .TipoReserva(trsExterno)
                  .ConverterML(True)
                ).fGetQuantidade();

  If (fltSalExt < 0) Then
    fltSalExt := 0;

  If (fCfgSis('MOVFUL', varString) = '2') Then
    fltSalExt := 0;

  edtSalDis.Text  := FormatFloat('#,##0.000', cdsConsulta.FieldByName('ITE_SALDOS').AsFloat - fStrToFloat(edtSalRes.Text) - fStrToFloat(edtSalReG.Text) - fltSalExt );
end;

procedure TfrmOrdProdGeracaoAutomatica.cmbSitFinClick(Sender: TObject);
begin
  inherited;
  pFiltrarPedidos;
end;

procedure TfrmOrdProdGeracaoAutomatica.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  bitmap : TBitmap;
  fixRect : TRect;
  bmpWidth : integer;

  imgIndex : integer;
begin
  inherited;
  If blnVAAUPR Then
  Begin
    fixRect := Rect;

    // customizing the 'LastName' field
    if Column.Field.FieldName = 'SITFIN' then
    begin
      //adding some logic to grab the required image
      if cdsConsulta.FieldByName('SITFIN').ASString = 'OK' then
        imgIndex := 2
      else
        imgIndex := 1;
      bitmap := TBitmap.Create;
      try
        //grab the image from the ImageList
        //(using the "Salary" field's value)
        imglSitFin.GetBitmap(imgIndex,bitmap);
        //Fix the bitmap dimensions
        bmpWidth := (Rect.Bottom - Rect.Top);
        fixRect.Right := Rect.Left + bmpWidth;
        //draw the bitmap
        dbgConsulta.Canvas.StretchDraw(fixRect,bitmap);
      finally
        bitmap.Free;
      end;

      // reset the output rectangle,
      // add space for the graphics
      fixRect := Rect;
      fixRect.Left := fixRect.Left + bmpWidth;
      //draw default text (fixed position)
      dbgConsulta.DefaultDrawColumnCell(
         fixRect,
         DataCol,
         Column,
         State);
    end;
  End;
end;

procedure TfrmOrdProdGeracaoAutomatica.dbgConsultaTitleClick(Column: TColumn);
begin
  inherited;
  pFiltrarPedidos;
end;

{********************************}
{* DESMARCA TODOS OS REGISTROS  *}
{*****************************JC*}
procedure TfrmOrdProdGeracaoAutomatica.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  stlListSelecao.Clear;
  dbgConsulta.Repaint;
  cdsConsulta.First;
end;

function TfrmOrdProdGeracaoAutomatica.fDecisaoUsuario :TRetornoSaldo;
var
  strMensagem : String;

Begin
   If rsDecisaoUsuario <> rsContinuarComSaldo Then
   Begin
      If fCfgSis('SLD_OI') = 'T' then
      Begin
        strMensagem := 'Existe(m) produto(s) sem saldo disponível para contemplar a ordem '+ #13 +
                       'de serviço. Para esses itens não serão geradas as ordens de produção.';

        if fMensagem('', strMensagem + #13 +  'Deseja continuar?', ['&Sim', '&Não']) = 1 Then
        Begin
           result := rsContinuarComSaldo;
           exit;
        End
        Else
        Begin
          result := rsCancelarProcesso;
          exit;
        End;

      End
      Else
      Begin
        strMensagem := 'Existe(m) produto(s) sem saldo disponível para contemplar a ordem de serviço.';

        if fMensagem('', strMensagem + #13 +  'Deseja continuar?', ['&Sim', '&Não']) = 1 Then
        Begin
          result := rsContinuarSemSaldo;
          exit;
        End
        Else
        Begin
          result := rsCancelarProcesso;
          exit;
        End;

      End;

   End
   Else
   Begin
     result := rsContinuarComSaldo;
     Exit
   End;


End;

function TfrmOrdProdGeracaoAutomatica.fChecaQuantProdutoDisponivel(strCodPro : String) : Boolean;

  function fValidaSaldo(strCodIte : String; fltQtdIte: Double; fltSalDis : Real) : Boolean;
  Begin
    if (objOrdPro.fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque and fItemEstrutura(strCodIte)) then
    begin
      Result := True;
      Exit;
    end;

    Result := (fltQtdIte * fltQtdApr ) <= fltSalDis;

  end;

Begin
  Try

    objOrdPro.pCriaTemporaria(False, strCodPro);

    With objOrdPro.cdsIteEst Do
    Begin
      DisableControls;
      First;

      result := True;

      While Not Eof Do
      Begin

        if not(objOrdPro.fGerarOrdemDeProducaoParaSubProdutosSemSaldoNoEstoque and fItemEstrutura(FieldByName('ITESUB').AsString)) then
        begin
          if not fValidaSaldo(FieldByName('ITESUB').AsString, FieldByName('QTDITE').AsFloat, FieldByName('SALDOS').AsFloat) Then
          Begin
            result := False;
            Exit;
          End;

        end;

        Next;

      End;

    End;
  Finally
    objOrdPro.cdsIteEst.EnableControls;
  End;

End;


procedure TfrmOrdProdGeracaoAutomatica.btnGravarClick(Sender: TObject);
  Var
    arrOrdPro : Array Of TOrdPro;
    intRegis,
    intIndex,
    intUltimaLinha,
    intQtdeInserido : Integer;
    strAuto : String;

    {**********************************************************}
    {* MARCA O NUMERO DA ORDEM DE PRODUCAO NA TABELA FATDOR   *}
    {* FDO_ORDPRO LOCALIZANDO PELO INCREMENTO E EMPRESA DOC.  *}
    {*******************************************************JC*}
    procedure pMarcaNumOrdPro(strIncrem, strCodEmp, strOrdPro: String);
      Var
        qryUpd : TUniQuery;
    begin

      qryUpd := fCriaQuery(Nil);

      With qryUpd Do
      Begin
        Close;
        SQL.Clear;

        SQL.Add('UPDATE ');
        SQL.Add('	FATDOR ');
        SQL.Add('SET ');
        SQL.Add('	FDO_ORDPRO = :ORDPRO ');
        SQL.Add('WHERE ');
        SQL.Add('	AUTOINCREM = :INCREM AND ');
        SQL.Add('	FDO_CODEMP = :CODEMP ');

        ParamByName('ORDPRO').AsString := strOrdPro;
        ParamByName('INCREM').AsString := strIncrem;
        ParamByName('CODEMP').AsString := strCodEmp;

        ExecSQL;

      End;

      FreeAndNil(qryUpd);

    end;
begin
  inherited;

  objOrdPro := TOrdPro.Create(Self, False);

  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  If fMensagem('', 'Confirma Geração de Ordem de Produção ?', ['S I M', 'N Ã O']) = 2 Then
    Exit;


  Try

    Self.Enabled := False;

    With cdsConsulta Do
    Begin

      SetLength(arrOrdPro, stlListSelecao.Count);
      For intRegis := 0 To stlListSelecao.Count - 1 Do
        arrOrdPro[IntRegis] := Nil;

      First;
      intRegis := 0;
      intQtdeInserido := 0;
      DisableControls;

      rsDecisaoUsuario := rsOk;

      {**********************************************************}
      {* PROCESSA TODOS OS REGISTROS VERIFICANDO SE O MESMO FOI *}
      {* SELECIONADO, CASO SIM EXECUTA INCLUSAO DA ORD.PRODUCAO *}
      {*******************************************************JC*}
      While Not Eof Do
      Begin
        strAuto  := '''' + Fieldbyname('AUTOINCREM').AsString + '''';
        intIndex := stlListSelecao.IndexOf(strAuto);

        If intIndex > -1 Then
        Begin

          IntRegis := intRegis + 1;
          Application.ProcessMessages;

          arrOrdPro[Pred(IntRegis)] := TOrdPro.Create(Nil, False);

          With arrOrdPro[Pred(IntRegis)] Do
          Begin
            fltQtdApr := FieldByName('FDO_QTDITE').AsFloat;
            strCodIte := FieldByName('FDO_CODITE').AsString;
            strNumDoc := FieldByName('FDO_NUMDOC').AsString;
            strEspDoc := FieldByName('FDO_ESPDOC').AsString;
            strCodEmp := FieldByName('EMPPRO').AsString;

            strNumPed := FieldByName('NUMDOC').AsString;
            strEspPed := FieldByName('ESPDOC').AsString;
            strEmpPed := FieldByName('CODEMP').AsString;

            strCodCli := FieldByName('FDO_CODCLI').AsString;

            strQtdApr := FieldByName('FDO_QTDITE').AsString;
            strQtdPro := '0.0';
            strConfer := fRetNomVendRep(strLoginUsuarioLogado);
            strDtaPro := DateToStr(VS_Date);
            strDtaCad := DateToStr(VS_Date);
            strSeqInd := FieldByName('AUTOINCREM').AsString;

            If fCfgSis('SLD_OI') <> 'N' Then
            Begin
              If rsDecisaoUsuario <> rsContinuarSemSaldo then
              Begin
                blnTemSal := True;

                if Not fChecaQuantProdutoDisponivel(FieldByName('FDO_CODITE').AsString) Then
                Begin
                  blnTemSal := False;
                  rsDecisaoUsuario := fDecisaoUsuario;
                  if rsDecisaoUsuario = rsCancelarProcesso Then
                     Break;
                End;
              End;

            End;

          End;

        End;

        pnlInfo.Caption := 'Registros: ' + IntToStr(RecNo) + '/' + IntToStr(RecordCount);
        Application.ProcessMessages;

        Next;

      End;

      Self.Enabled := True;
      pnlInfo.Caption := '';

      If intRegis = 0 Then
        fMensagem('',' Nenhum Registro foi selecionado !', ['O K'])
      Else
      Begin
        fAbreConsulta(False);
        intUltimaLinha := 0;

        If rsDecisaoUsuario <> rsCancelarProcesso Then
        Begin
          For intRegis := Low(arrOrdPro) To High(arrOrdPro) Do
          Begin
            If Assigned(arrOrdPro[intRegis]) Then
            Begin
              If fCfgSis('SLD_OI') <> 'N' Then
              Begin
                If rsDecisaoUsuario = rsContinuarComSaldo then
                Begin
                  If arrOrdPro[IntRegis].blnTemSal Then
                  Begin
                    arrOrdPro[IntRegis].blnTransacao := True;
                    If arrOrdPro[IntRegis].fInsereOrdemProducao Then
                    Begin
                      pMarcaNumOrdPro(arrOrdPro[IntRegis].strSeqInd, arrOrdPro[IntRegis].strCodEmp, arrOrdPro[intRegis].strCodPro);
                      intQtdeInserido := intQtdeInserido + 1;
                    End;
                  End
                  Else
                    Next;
                End
                Else
                Begin
                  arrOrdPro[IntRegis].blnTransacao := True;
                  If arrOrdPro[IntRegis].fInsereOrdemProducao Then
                  Begin
                    pMarcaNumOrdPro(arrOrdPro[IntRegis].strSeqInd, arrOrdPro[IntRegis].strCodEmp, arrOrdPro[intRegis].strCodPro);
                    intQtdeInserido := intQtdeInserido + 1;
                  End;
                End;

              End
              Else
              begin
                arrOrdPro[IntRegis].blnTransacao := True;
                If arrOrdPro[IntRegis].fInsereOrdemProducao Then
                Begin
                  pMarcaNumOrdPro(arrOrdPro[IntRegis].strSeqInd, arrOrdPro[IntRegis].strCodEmp, arrOrdPro[intRegis].strCodPro);
                  intQtdeInserido := intQtdeInserido + 1;
                End
                Else
                Begin
                  fRollBack;
                  Break;
                End;

              End;

            End;

          End;

        End;

      End;

      EnableControls;

    End;

    If (intQtdeInserido > 0) Then
    Begin
      If fMensagem('','Geração concluída com sucesso!. Imprime as ordens de Produção?', ['&Sim', '&Não']) = 1 Then
         For intRegis := Low(arrOrdPro) To High(arrOrdPro) Do
           If Assigned(arrOrdPro[intRegis]) Then
             arrOrdPro[intRegis].pImprimeOrdPro(arrOrdPro[intRegis].strCodPro, intUltimaLinha, False, arrOrdPro[intRegis].strCodEmp);
    End;


  Finally
    For intRegis := Low(arrOrdPro) To High(arrOrdPro) Do
      If Assigned(arrOrdPro[intRegis]) Then
        FreeAndNil(arrOrdPro[intRegis]);

    blnSempreRelerBanco := True;
    cdsConsulta.DisableControls;
    fAbreConsulta(True);
    stlListSelecao.Clear;
    dbgConsulta.Repaint;
    cdsConsulta.First;
    cdsConsulta.EnableControls;
    blnSempreRelerBanco := False;

  End;

end;

procedure TfrmOrdProdGeracaoAutomatica.btnLotIteClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(207, 7616, [7719,7720,7721,7722],
                      ['CODITE'],
                      [cdsConsulta.FieldByName('FDO_CODITE').AsString],
                      Sender,
                      ['CODITE'],
                      False);
  End;

end;

function TfrmOrdProdGeracaoAutomatica.fGetOrderBy: String;
begin
  Result := '';
end;

procedure TfrmOrdProdGeracaoAutomatica.FormCreate(Sender: TObject);
begin
  inherited;
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnVAAUPR := fCfgSis('VAAUPR', varBoolean);
  pnlVAAUPR.Visible := blnVAAUPR;
  dbgConsulta.Columns[9].Visible := blnVAAUPR;
end;

procedure TfrmOrdProdGeracaoAutomatica.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6 : btnLotIte.Click;
    VK_F8 : btnDesmarca.Click;
    VK_F10: btnGravar.Click;
    VK_F7 : If Shift = [] Then
              btnMarca.Click
            Else
            If Shift = [ssAlt] Then
              btnPedSalRes.Click;
    VK_F3,
    VK_F5:  pFiltrarPedidos;

  End;
  
end;

end.
