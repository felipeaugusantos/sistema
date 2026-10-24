unit untMostraDebCtrChq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, StrUtils, DB, Mask, DBCtrls, DBEditFocus,
    Uni, Mapi, AppEvnts;

type
  TfrmMostraDebCtrChq = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtn;
    pnlDebCtr: TPanel;
    pnlDebChq: TPanel;
    lblDupOri: TLabel;
    edtDupOri: TEditFocus;
    dbgDuplicatas: TDBGridCitel;
    Label7: TLabel;
    edtChqTot: TEditFocus;
    dbgCheques: TDBGridCitel;
    pnlTitChq: TPanel;
    pnlTitCtr: TPanel;
    btnVisChq: TBitBtn;
    btnVisCtr: TBitBtn;
    edtJurRec: TEditFocus;
    lblJurRec: TLabel;
    edtCorDif: TEditFocus;
    lblCorDif: TLabel;
    edtTotVencido: TEditFocus;
    edtTotVencer: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeHist01: TDBEditFocus;
    dbeHist02: TDBEditFocus;
    btnEnviarEmail: TBitBtn;
    btnAgrupamentos: TBitBtn;
    btnProdutos: TBitBtn;
    qryTemporaria: TUniQuery;
    dtsTemporaria: TDataSource;
    qryTemporaria2: TUniQuery;
    dtsTemporaria2: TDataSource;
    qryTemporaria3: TUniQuery;
    dtsTemporaria3: TDataSource;
    qryProdutosMOVDET: TUniQuery;
    qryProdutosNOTDET: TUniQuery;
    qryProdutosDUPAGR: TUniQuery;
    btnObsDoc: TBitBtn;
    btnRelatorio: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pSomaTotVencimento;
    procedure pMostraDebCheque;
    procedure pMostraDebCadRec;
    procedure pCriaTemporaria;
    procedure pCriaTemporariaProdutos;
    procedure pDeletaTemporaria;
    procedure pDeletaTemporariaProdutos;
    procedure pCalculaValorCorrigido;
    procedure btnVisChqClick(Sender: TObject);
    procedure btnVisCtrClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnAgrupamentosClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDuplicatasTitleClick(Column: TColumn);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgChequesTitleClick(Column: TColumn);
    procedure dbgChequesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnObsDocClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);

  private
    { Private declarations }
    strSQLValores: String;
    strMensagemRel: String;
    strNomeArquivo: String;
    strFiltro: String;
    strSQLCheque: String;
    strSQlProdutos: String;
    bChkContaCorrente: Boolean;
    bChkProduto: Boolean;
    bChkCheque: Boolean;

    intOrdCadRec: Integer;
    intOrdChq: Integer;
    strFieldCadRec: String;

    procedure pGerarHtmlContaCorrente; //Comentada
    procedure pGeraEmail(blnAbrirEmVideo: Boolean);
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pCalculaTotalRelatorio;
    procedure pSelecionaProdutosContasReceber;

    function EnviarEMail(const De, Para, Assunto, Texto,
                         Arquivo: string; Confirma: Boolean): Integer;

  public
    { Public declarations }

    strCodCli : String;
    blnSelDocumentosDeb: Boolean; {se veio pelo Rusumo de Caixa}
  published
    property Constraints;
  end;

var
  frmMostraDebCtrChq: TfrmMostraDebCtrChq;

implementation

uses untModuloCons, untFuncoes, untfuncoesSimples, untObservacao,
  untModuloCadCli, untDigEmail, untDigEmailCtaCorrente, untModuloCadRec,
  untRelFatVendasClienteF9, untQckHTMLCliente, untRelCtrDebitosCliente;

{$R *.dfm}

procedure TfrmMostraDebCtrChq.FormShow(Sender: TObject);

begin
  inherited;

  {*******************************************}
  {* ESTA VARIÁVEL E PARA ORDEM DO GRID 1    *}
  {****************************************AC*}
  intOrdCadRec := 9;
  {*******************************************}
  {* ESTA VARIÁVEL E PARA ORDEM DO GRID 2    *}
  {****************************************AC*}
  intOrdChq    := 99;  
  pCriaTemporaria;
  pMostraDebCadRec;
  pMostraDebCheque;
  pSomaTotVencimento;

end;
                    
procedure TfrmMostraDebCtrChq.pMostraDebCheque;
  Var
    fltTotVen : Double;
    strSQL    : String;

begin

  fltTotVen := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CHQ_NUMCHQ, ';
  strSQL := strSQL + '  CHQ_CODEMP, ';
  strSQL := strSQL + '  CHQ_CODBCO, ';
  strSQL := strSQL + '  CHQ_DTADEP, ';
  strSQL := strSQL + '  CHQ_DTADEV, ';
  strSQL := strSQL + '  CHQ_DTAVEN, ';
  strSQL := strSQL + '  CHQ_VALCHQ, ';
  strSQL := strSQL + '  CHQ_NUMAGE  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CHQ_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CHQ_INCCTR = "N" ';

  If strTipFil = 'A' Then
  Begin
    strSQL := strSQL + '  AND CHQ_DTADEP IS NULL ';
  End
  Else If (strTipFil = 'B') Then
  Begin
    strSQL := strSQL + '  AND CHQ_DTADEP IS NOT NULL ';
  End;

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CADCHQ', 'CADCHQX');
  strSQL := strSQL + 'ORDER BY ';

  {***************************************************}
  {* DEPENDENDO DA ORDEM ESCOLHIDA NO GRID DE CHEQUE *}
  {* EU MUDO A ORDEM                                 *} 
  {************************************************AC*}
  If (intOrdChq >= 0) And (intOrdChq <= 7) Then
    strSQL := strSQL + IntToStr(intOrdChq)
  Else
    strSQL := strSQL + '  2, 1 ';

  {*******************************************}
  {* PEGO O SELECT DO CHEQUE PARA PODER      *}
  {* USA-LO NO RELATÓRIO                     *}
  {****************************************AC*}
  strSQLCheque := '';
  strSQLCheque := strSQL;

  With qryTemporaria3 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
    (FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';

    If Not IsEmpty Then
    Begin

      While Not Eof Do
      Begin
        fltTotVen := fltTotVen + FieldByName('CHQ_VALCHQ').AsFloat;
        Next;
      End;
      First;

      edtChqTot.Text := FormatFloat('#,##0.00', fltTotVen);

    End;
  End;

  dbgDuplicatas.SetFocus;

end;

procedure TfrmMostraDebCtrChq.pMostraDebCadRec;
  Var
    strSQL     : String;
    strNomCmp1 : String;
    strNomCmp2 : String;
    strNomCmp3 : String;

    fltDupOri : Double;
    fltJurRec : Double;
    fltCorDif : Double;

begin
  fltDupOri := 0.0;
  fltJurRec := 0.0;
  fltCorDif := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  NOMARQ, ';
  strSQL := strSQL + '  NUMDUP, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_NUMDUP AS "Nº Dupl.", ';
  strSQL := strSQL + '  SUBSTR(NOMPOR, 1, 25 ) AS "Portador", ';
  strSQL := strSQL + '  CTR_ESPDOC AS "Esp.", ';
  strSQL := strSQL + '  CTR_CODEMP AS "Emp.", ';
  strSQL := strSQL + '  CTR_CODVEN AS "Ven.", ';
  {**********************************************}
  {* MUDEI ESSES DOIS CAMPOS PARA O INICIO DO   *}
  {* SELECT, PARA PODER ORDENALOS DINAMICAMENTE *}
  {* SE O USUÁRIO NECESSITAR.                   *}
  {*******************************************AC*}
//  strSQL := strSQL + '  CTR_HIST01, ';
//  strSQL := strSQL + '  CTR_HIST02, ';

  If strTipFil = 'A' Then
  Begin
    strSQL := strSQL + '  CTR_DTACAD AS "Dt. Cad.", ';
    strSQL := strSQL + '  CTR_DTAVEN AS "Dt. Ven.", ';
    strSQL := strSQL + '  CTR_VALORI AS "V. Orig.", ';
    strSQL := strSQL + '  CTR_VALDUP AS "V. Dupl.", ';
    strSQL := strSQL + '  CTR_VALJUR AS "V. Juros", ';
    strSQL := strSQL + '  CTR_VALCAL AS "V. Corrig." ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

    strNomCmp1 := 'V. Dupl.';
    strNomCmp2 := 'V. Juros';
    strNomCmp3 := 'V. Corrig.';

    lblDupOri.Caption := strNomCmp1;
    lblJurRec.Caption := strNomCmp2;
    lblCorDif.Caption := strNomCmp3;

  End
  Else If strTipFil = 'B' Then
  Begin
    strSQL := strSQL + '  CTR_DTACAD AS "Dt. Cad.", ';//Alexandre C
    strSQL := strSQL + '  CTR_DTAVEN AS "Dt. Ven", ';
    strSQL := strSQL + '  CTR_DTAREC AS "Dt. Rec.", ';
    strSQL := strSQL + '  CTR_VALORI AS "V. Orig.", ';
    strSQL := strSQL + '  CTR_VALREC AS "V. Receb.", ';
    strSQL := strSQL + '  CTR_DIFERE AS "Diferença" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NOT NULL ';

    strNomCmp1 := 'V. Orig.';
    strNomCmp2 := 'V. Receb.';
    strNomCmp3 := 'Diferença';

    lblDupOri.Caption := strNomCmp1;
    lblJurRec.Caption := strNomCmp2;
    lblCorDif.Caption := strNomCmp3;

  End
  Else If strTipFil = 'T' Then
  Begin
    strSQL := strSQL + '  CTR_DTACAD AS "Dt. Cad.", ';//Alexandre C
    strSQL := strSQL + '  CTR_DTAVEN AS "Dt. Ven", ';
    strSQL := strSQL + '  CTR_DTAREC AS "Dt. Rec.", ';
    strSQL := strSQL + '  CTR_VALORI AS "V. Orig.", ';
    strSQL := strSQL + '  CTR_VALREC AS "V. Receb.", ';
    strSQL := strSQL + '  CTR_DIFERE AS "Diferença" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    strNomCmp1 := 'V. Orig.';
    strNomCmp2 := 'V. Receb.';
    strNomCmp3 := 'Diferença';

    lblDupOri.Caption := strNomCmp1;
    lblJurRec.Caption := strNomCmp2;
    lblCorDif.Caption := strNomCmp3;

  End;

  strSQL := strSQL + 'ORDER BY ';

  {*******************************************}
  {* MUDO A ORDEM DE ACORDO COM A ESCOLHA    *}
  {* DO USUÁRIO.                             *}
  {****************************************AC*}
  If ((intOrdCadRec >= 0) And (intOrdCadRec <= 13)) Then
    strSQL := strSQL + '"'+ strFieldCadRec +'"'
  Else
    strSQL := strSQL + '  3, 1, 2 ';

  With qryTemporaria2 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;

    Open;
    FieldByName('CTR_HIST01').Visible := False;
    FieldByName('CTR_HIST02').Visible := False;
    FieldByName('NOMARQ').Visible     := False;
    FieldByName('NUMDUP').Visible     := False;

    If Not IsEmpty Then
    Begin

      If strTipFil = 'A' Then
      Begin
        (FieldByName(strNomCmp1) As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName(strNomCmp2) As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName(strNomCmp3) As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('V. Orig.') As TFloatField).DisplayFormat := '#,##0.00';

        dbgDuplicatas.Columns[0].Width  := 70;
        dbgDuplicatas.Columns[1].Width  := 170;
        dbgDuplicatas.Columns[2].Width  := 30;
        dbgDuplicatas.Columns[3].Width  := 40;
        dbgDuplicatas.Columns[4].Width  := 40;
        dbgDuplicatas.Columns[5].Width  := 65;
        dbgDuplicatas.Columns[6].Width  := 55;
        dbgDuplicatas.Columns[7].Width  := 55;
        dbgDuplicatas.Columns[8].Width  := 50;
        dbgDuplicatas.Columns[9].Width  := 55;
        dbgDuplicatas.Columns[10].Width := 50;
      End
      Else If (strTipFil = 'B') Or
              (strTipFil = 'T') Then
      Begin
        (FieldByName(strNomCmp1) As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName(strNomCmp2) As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName(strNomCmp3) As TFloatField).DisplayFormat := '#,##0.00';

        dbgDuplicatas.Columns[0].Width  := 57;
        dbgDuplicatas.Columns[1].Width  := 165;
        dbgDuplicatas.Columns[2].Width  := 35;
        dbgDuplicatas.Columns[3].Width  := 35;
        dbgDuplicatas.Columns[4].Width  := 35;
        dbgDuplicatas.Columns[5].Width  := 63; //Alexandre C
        dbgDuplicatas.Columns[6].Width  := 63;
        dbgDuplicatas.Columns[7].Width  := 63;
        dbgDuplicatas.Columns[8].Width  := 55;
        dbgDuplicatas.Columns[9].Width  := 55;
        dbgDuplicatas.Columns[10].Width := 55;

        {*******************************************}
        {* COMENTEI PQ ADICIONEI A COLUNA 5 ACIMA  *}
        {****************************************AC*}
        {
        dbgDuplicatas.Columns[0].Width := 60;
        dbgDuplicatas.Columns[1].Width := 170;
        dbgDuplicatas.Columns[2].Width := 40;
        dbgDuplicatas.Columns[3].Width := 40;
        dbgDuplicatas.Columns[4].Width := 40;
        dbgDuplicatas.Columns[5].Width := 65; //Alexandre C  Antiga
        dbgDuplicatas.Columns[6].Width := 70;
        dbgDuplicatas.Columns[7].Width := 70;
        dbgDuplicatas.Columns[8].Width := 60;
        dbgDuplicatas.Columns[9].Width := 60;
        dbgDuplicatas.Columns[10].Width := 60;
        }

      End;

      While Not Eof Do
      Begin
        fltDupOri := fltDupOri + FieldByName(strNomCmp1).AsFloat;
        fltJurRec := fltJurRec + FieldByName(strNomCmp2).AsFloat;
        fltCorDif := fltCorDif + FieldByName(strNomCmp3).AsFloat;

        Next;
      End;
      First;

      edtDupOri.Text   := FormatFloat('#,##0.00', fltDupOri);
      edtJurRec.Text   := FormatFloat('#,##0.00', fltJurRec);
      edtCorDif.Text   := FormatFloat('#,##0.00', fltCorDif);

    End;
  End;

end;


procedure TfrmMostraDebCtrChq.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  {*****************************************}
  {* (*) LIMPA EVENTO                      *}
  {**************************************RL*}
  qryTemporaria2.AfterScroll := Nil;

  qryTemporaria.Close;
  qryTemporaria2.Close;
  qryTemporaria3.Close;

end;


procedure TfrmMostraDebCtrChq.btnFecharClick(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TfrmMostraDebCtrChq.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    btnEnviarEmail.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnAgrupamentos.Click;
  End
  Else If (Key = VK_F7) And (btnProdutos.Enabled) Then
  Begin
    btnProdutos.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnRelatorio.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnObsDoc.Click;
  End;
end;

procedure TfrmMostraDebCtrChq.pCriaTemporaria;
  Var
    strSQL: String;

begin

  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_ESPDOC AS CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP AS CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_CODVEN AS CTR_CODVEN, ';
  strSQL := strSQL + '  CTR_DTACAD AS CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN AS CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_VALDUP AS CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_VALORI AS CTR_VALORI, ';
  strSQL := strSQL + '  CTR_DTAREC AS CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_VALREC AS CTR_VALREC, ';
  strSQL := strSQL + '  CTR_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '  CTR_SEQBAI AS CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_HIST01 AS CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02 AS CTR_HIST02, ';
  strSQL := strSQL + '  CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS NOMPOR,';
  strSQL := strSQL + '  "CADREC"   AS NOMARQ ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC  ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + ' UNION ' + AnsiReplaceStr(strSQL, 'CADREC', 'CADRECX');

  strSQL := 'CREATE TABLE TMP_CADREC ' + strSQL;

  With qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    ExecSQL;
    Close;
  End;

  {*****************************************}
  {* CRIA CAMPO PARA VALOR DA DUPLICATA +  *}
  {* JUROS                                 *}
  {**************************************ED*}
  strSQL := '';
  strSQL := strSQL + 'ALTER TABLE ';
  strSQL := strSQL + '  TMP_CADREC ';
  strSQL := strSQL + 'ADD ';
  strSQL := strSQL + '  CTR_VALCAL NUMERIC(12,2) ';

  With qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  {*****************************************}
  {* CRIA CAMPO PARA VALOR DO JUROS        *}
  {**************************************ED*}
  strSQL := '';
  strSQL := strSQL + 'ALTER TABLE ';
  strSQL := strSQL + '  TMP_CADREC ';
  strSQL := strSQL + 'ADD ';
  strSQL := strSQL + '  CTR_VALJUR NUMERIC(12,2) ';

  With qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  {*****************************************}
  {* CRIA CAMPO PARA VALOR DA DIFERENÇA    *}
  {**************************************ED*}
  strSQL := '';
  strSQL := strSQL + 'ALTER TABLE ';
  strSQL := strSQL + '  TMP_CADREC ';
  strSQL := strSQL + 'ADD ';
  strSQL := strSQL + '  CTR_DIFERE NUMERIC(12,2) ';

  With qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  pCalculaValorCorrigido;

end;

procedure TfrmMostraDebCtrChq.pCriaTemporariaProdutos;
  Var
    strSQL: String;
begin

  pDeletaTemporariaProdutos;

  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   DET_NUMDOC AS DET_NUMDOC,  ';
  strSQL := strSQL + '   DET_ESPDOC AS DET_ESPDOC,  ';
  strSQL := strSQL + '   DET_CODEMP AS DET_CODEMP,  ';
  strSQL := strSQL + '   DET_CODITE AS DET_CODITE,  ';
  strSQL := strSQL + '   DET_DESCRI AS DET_DESCRI,  ';
  strSQL := strSQL + '   DET_UNIDAD AS DET_UNIDAD,  ';
  strSQL := strSQL + '   DET_QTDITE AS DET_QTDITE,  ';
  strSQL := strSQL + '   DET_UNITAR AS DET_UNITAR,  ';
  strSQL := strSQL + '   DET_UNIORI AS DET_UNIORI,  ';
  strSQL := strSQL + '   DET_TOTITE AS DET_TOTITE,  ';
  strSQL := strSQL + '   DET_DESCON AS DET_DESCON,  ';
  strSQL := strSQL + '   DET_TOTFRE AS DET_TOTFRE,  ';
  strSQL := strSQL + '   DET_DESESP AS DET_DESESP,  '; 
  strSQL := strSQL + '   DET_CODCLI AS DET_CODCLI,  ';
  strSQL := strSQL + '   DET_PROEMB AS DET_PROEMB,  ';
  strSQL := strSQL + '   DET_TIP_FC AS DET_TIP_FC,  ';
  strSQL := strSQL + '   DET_JAFATU AS DET_JAFATU   ';


  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   MOVDET                     ';
  strSQL := strSQL + ' WHERE DET_CODCLI = :CODCLI   ';
  strSQL := strSQL + ' UNION ' + AnsiReplaceStr(strSQL, 'MOVDET', 'MOVDETX');

  strSQL := 'CREATE TABLE TMP_MOVDET ' + strSQL;

  With qryProdutosMOVDET Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   DET_NUMDOC AS DET_NUMDOC,  ';
  strSQL := strSQL + '   DET_ESPDOC AS DET_ESPDOC,  ';
  strSQL := strSQL + '   DET_CODEMP AS DET_CODEMP,  ';
  strSQL := strSQL + '   DET_CODITE AS DET_CODITE,  ';
  strSQL := strSQL + '   DET_DESCRI AS DET_DESCRI,  ';
  strSQL := strSQL + '   DET_UNIDAD AS DET_UNIDAD,  ';
  strSQL := strSQL + '   DET_QTDITE AS DET_QTDITE,  ';
  strSQL := strSQL + '   DET_UNITAR AS DET_UNITAR,  ';
  strSQL := strSQL + '   DET_UNIORI AS DET_UNIORI,  ';
  strSQL := strSQL + '   DET_TOTITE AS DET_TOTITE,  ';
  strSQL := strSQL + '   DET_DESCON AS DET_DESCON,  ';
  strSQL := strSQL + '   DET_TOTFRE AS DET_TOTFRE,  ';
  strSQL := strSQL + '   DET_DESESP AS DET_DESESP,  ';  
  strSQL := strSQL + '   DET_CODCLI AS DET_CODCLI,  ';
  strSQL := strSQL + '   DET_PROEMB AS DET_PROEMB,  ';
  strSQL := strSQL + '   DET_TIP_FC AS DET_TIP_FC,  ';
  strSQL := strSQL + '   DET_JAFATU AS DET_JAFATU   ';
  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   NOTDET                     ';
  strSQL := strSQL + ' WHERE DET_CODCLI = :CODCLI   ';
  strSQL := strSQL + ' UNION ' + AnsiReplaceStr(strSQL, 'NOTDET', 'NOTDETX');

  strSQL := 'CREATE TABLE TMP_NOTDET ' + strSQL;

  With qryProdutosNOTDET Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT                      ';
  strSQL := strSQL + '   CONCAT(CTR_NUMAGR,CTR_PARCEL) AS CTR_NUMAGR, ';
  strSQL := strSQL + '   CTR_NUMDUP AS CTR_NUMDUP, ';
  strSQL := strSQL + '   CTR_ESPDOC AS CTR_ESPDOC, ';
  strSQL := strSQL + '   CTR_EMPAGR AS CTR_EMPAGR, ';
  strSQL := strSQL + '   CTR_CODVEN AS CTR_CODVEN, ';
  strSQL := strSQL + '   CTR_CODCLI AS CTR_CODCLI, ';  
  strSQL := strSQL + '   CTR_HIST01,               ';
  strSQL := strSQL + '   CTR_HIST02,               ';
  strSQL := strSQL + '   CTR_DTACAD AS CTR_DTACAD, ';
  strSQL := strSQL + '   CTR_DTAVEN AS CTR_DTAVEN, ';
  strSQL := strSQL + '   CTR_VALORI AS CTR_VALORI, ';
  strSQL := strSQL + '   CTR_VALDUP AS CTR_VALDUP  ';
  strSQL := strSQL + ' FROM                        ';
  strSQL := strSQL + '   DUPAGR                    ';
  strSQL := strSQL + ' WHERE CTR_CODCLI = :CODCLI  ';
  strSQL := strSQL + ' UNION ' + AnsiReplaceStr(strSQL, 'DUPAGR', 'DUPAGRX');

  strSQL := 'CREATE TABLE TMP_DUPAGR ' + strSQL;

  With qryProdutosDUPAGR Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    ExecSQL;
    Close;
  End;

end;

procedure TfrmMostraDebCtrChq.pDeletaTemporaria;
  Var
    strSQL: String;
begin
  If fTabelaExiste('TMP_CADREC') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_CADREC ';

    With qryTemporaria Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmMostraDebCtrChq.pDeletaTemporariaProdutos;
  Var
    strSQL: String;
begin

  If fTabelaExiste('TMP_MOVDET') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_MOVDET ';

    With qryProdutosMOVDET Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;

  If fTabelaExiste('TMP_NOTDET') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_NOTDET ';

    With qryProdutosNOTDET Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;

  If fTabelaExiste('TMP_DUPAGR') Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE TMP_DUPAGR ';

    With qryProdutosDUPAGR Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;

end;

procedure TfrmMostraDebCtrChq.pCalculaValorCorrigido;
  Var
    strSQL: String;
    fltJuros: Double;
    fltJurAtr: Double;
    qryGenRec: TUniQuery;
begin
  qryGenRec := fcriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_CADREC ';

  With qryTemporaria Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  TMP_CADREC ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTR_VALCAL = :VALCAL, ';
  strSQL := strSQL + '  CTR_VALJUR = :VALJUR, ';
  strSQL := strSQL + '  CTR_DIFERE = :DIFERE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

  fltJurAtr := VS_fltJurAtr;

  With qryTemporaria Do
  Begin

    First;

    While Not Eof Do
    Begin

      fltJuros := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                      FieldByName('CTR_VALDUP').AsFloat,
                                      fltJurAtr);

      qryGenRec.Close;
      qryGenRec.SQL.Clear;
      qryGenRec.SQL.Add(strSQL);
      qryGenRec.ParamByName('VALCAL').AsFloat   := fltJuros + FieldByName('CTR_VALDUP').AsFloat;
      qryGenRec.ParamByName('DIFERE').AsFloat   := FieldByName('CTR_VALORI').AsFloat - FieldByName('CTR_VALREC').AsFloat;
      qryGenRec.ParamByName('VALJUR').AsFloat   := fltJuros;
      qryGenRec.ParamByName('NUMDUP').AsString  := FieldByName('CTR_NUMDUP').AsString;
      qryGenRec.ParamByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
      qryGenRec.ParamByName('CODEMP').AsString  := FieldByName('CTR_CODEMP').AsString;
      qryGenRec.ParamByName('CODCLI').AsString  := strCodCli;
      qryGenRec.ExecSQL;
      qryGenRec.Close;

      Next;
    End;

  End;

  FreeAndNil(qryGenRec);
  
end;




procedure TfrmMostraDebCtrChq.btnVisChqClick(Sender: TObject);
begin
  inherited;

  btnVisChq.Enabled := False;
  btnVisCtr.Enabled := True;
  dbgCheques.SetFocus;

end;

procedure TfrmMostraDebCtrChq.btnVisCtrClick(Sender: TObject);
begin
  inherited;

  btnVisChq.Enabled := True;
  btnVisCtr.Enabled := False;
  dbgDuplicatas.SetFocus;

end;


{**************************************}
{* TOTAL DUPLICATA VENCIDA E À VENCER *}
{***********************************LB*}
procedure TfrmMostraDebCtrChq.pSomaTotVencimento;
  Var
    strSQL: String;
    qryGenRec : TUniQuery;

begin
  Try
    qryGenRec := fCriaQuery(Self);


    edtTotVencer.Text  := '0,00';
    edtTotVencido.Text := '0,00';

    If strTipFil = 'B' Then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(IF(CTR_DTAVEN <= :DTAATU, CTR_VALDUP,0)) AS DUPVEN, ';
    strSQL := strSQL + '  SUM(IF(CTR_DTAVEN > :DTAATU, CTR_VALDUP,0)) AS DUPAVE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('DTAATU').AsDateTime := VS_Date;
      Open;

      If Not IsEmpty Then
      Begin
        edtTotVencido.Text := FormatFloat('#,##0.00', FieldByName('DUPVEN').AsFloat);
        edtTotVencer.Text  := FormatFloat('#,##0.00', FieldByName('DUPAVE').AsFloat);
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

procedure TfrmMostraDebCtrChq.pGerarHtmlContaCorrente;
  Var
    //strArqHtml: String;
    strDestinatario: String;
    strEmailDestinatario: String;
    blnConfirma: Boolean;
//    strAssunto: String;
    strMensagem: String;
//    mail: TStringList;
begin

  If (qryTemporaria2.IsEmpty) And (qryTemporaria3.IsEmpty) Then
  Begin
    Exit;
  End;

  strDestinatario      := frmModuloCadCli.qryCadCli.FieldByName('CLI_NOMCLI').AsString;
  strEmailDestinatario := frmModuloCadCli.qryCadCli.FieldByName('CLI_EMAIL_').AsString;
  blnConfirma := False;
  Try
    Application.CreateForm(TfrmDigEmailCtaCorrente, frmDigEmailCtaCorrente);
    frmDigEmailCtaCorrente.edtEmail.Text   := strEmailDestinatario;
    frmDigEmailCtaCorrente.edtContato.Text := strDestinatario;
    blnConfirma := (frmDigEmailCtaCorrente.ShowModal = mrOk);
  Finally
    If (blnConfirma) Then
    Begin
      strDestinatario      := frmDigEmailCtaCorrente.edtContato.Text;
      strEmailDestinatario := frmDigEmailCtaCorrente.edtEmail.Text;
      strMensagem          := frmDigEmailCtaCorrente.memObservacoes.Text;
      bChkContaCorrente    := frmDigEmailCtaCorrente.chkContaCorrente.Checked;
      bChkProduto          := frmDigEmailCtaCorrente.chkProduto.Checked;
      bChkCheque           := frmDigEmailCtaCorrente.chkCheque.Checked;

      {*******************************************}
      {* PEGO ESTA INFORMAÇÃO PARA MOSTRAR NO    *}
      {* RELATÓRIO QUE SERÁ EXPORTADO POR EMAIL  *}
      {****************************************AC*}
      strMensagemRel       := strMensagem;
    End;
    FreeAndNil(frmDigEmailCtaCorrente);
  End;

  If (Not blnConfirma) Then
  Begin
    Exit;
  End;

  {*******************************************}
  {* GERO AS INFORMAÇÕES DAS DUPLICATAS E    *}
  {* EXPORTO O HTML.                         *}
  {****************************************AC*}
  pGeraEmail(FALSE);

  {*******************************************}
  {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O     *}
  {* ARQUIVO.                                *}
  {****************************************AC*}
  If (Not fEmptyStr(strNomeArquivo)) Then
  Begin
    EnviarEMail('', strEmailDestinatario, fRetNomeEmpresa + ' : Conta Corrente ', 'Segue em anexo Conta Corrente.'+strFiltro, strNomeArquivo, True);
    SetForegroundWindow(Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);

(*
{*******************************************}
{* COMENTEI AQUI.AQUI GERAVA ANTIGO HTML   *}
{****************************************AC*}

  strArqHtml := frmModuloCadCli.fGeraHtmlContaCorrente(strCodCli, strTipFil,
                                                       fStrToFloat(edtTotVencido.Text),
                                                       fStrToFloat(edtDupOri.Text),
                                                       fStrToFloat(edtJurRec.Text),
                                                       fStrToFloat(edtCorDif.Text),
                                                       fStrToFloat(edtTotVencer.Text),
                                                       strMensagem,
                                                       qryTemporaria2);



  If (Not fEmptyStr(strArqHtml)) Then
  Begin
    strAssunto := fRetNomeEmpresa +  ': Conta Corrente ';

    mail := TStringList.Create;
    try
      {****************************}
      {* ENDERECO DO DESTINATÁRIO *}
      {*************************ER*}
      mail.values['to'] := strEmailDestinatario;
      mail.values['subject'] := strAssunto;

      {******************************************}
      {* PARA QUE O CORPO DA MENSAGEM SEJA HTML *}
      {* O BODY DEVE FICAR EM BRANCO E ANEXAR O *}
      {* ARQUIVO HTML DESEJADO, AUTOMATICAMENTE *}
      {* ELE APARECERÁ NO CORPO DA MENSAGEM     *}
      {**************************************ER**}
      mail.values['body'] := '';
      mail.values['attachment0'] := strArqHtml;
  //    mail.values['attachment1']:='C:\Test2.txt';
      EnviaEMail(Application.Handle, mail);
    finally
      mail.Free;
    end;

{    fEnviaHtmlEmail(strArqHtml, strEmailDestinatario, strDestinatario, strAssunto,
      fRetEmailEmpresa(VS_strCodEmp), fRetNomeEmpresa);}
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Não foi possível gerar o arquivo Html!', ['&Ok']);
  End;

  Try
    Sleep(3500);
    DeleteFile(strArqHtml);
    DeleteFile(strArqHtml + '.eml');
  Except
  End;

*)
end;

procedure TfrmMostraDebCtrChq.btnEnviarEmailClick(Sender: TObject);
begin
  inherited;
  pGerarHtmlContaCorrente;
end;

procedure TfrmMostraDebCtrChq.btnAgrupamentosClick(Sender: TObject);
  Var
    strNomArq: String;
begin
  inherited;
  strNomArq := IIF(dbgDuplicatas.DataSource.DataSet.FieldByName('NOMARQ').AsString = 'CADREC', 'DUPAGR', 'DUPAGRX');
  If (dbgDuplicatas.DataSource.DataSet.FieldByName('Esp.').AsString = 'AG') Then
  Begin
    frmModuloCadRec.pMostraDuplicatasAgrupadas(strNomArq,
                                               LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('Nº Dupl.').AsString, 6),
                                               LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('Emp.').AsString, 3),
                                               blnSelDocumentosDeb);
                                               
  End;
end;

procedure TfrmMostraDebCtrChq.btnProdutosClick(Sender: TObject);
begin
  inherited;

  Try
    frmRelFatVendasClienteF9 := TfrmRelFatVendasClienteF9.Create(Self);

    With frmRelFatVendasClienteF9 Do
    Begin

      frmRelFatVendasClienteF9.pMostrarProdutos(
       LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('Nº Dupl.').AsString, 6),
       dbgDuplicatas.DataSource.DataSet.FieldByName('Esp.').AsString,
       LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('Emp.').AsString, 3));

      ShowModal;
    End;

  Finally
    FreeAndNil(frmRelFatVendasClienteF9);
  End;

end;

procedure TfrmMostraDebCtrChq.pAtualizaDados(DataSet: TDataSet);
begin

  {*******************************************}
  {* HABILITA / DESABILITA BOTÃO QUE CHAMA   *}
  {* TELA DE DUPLICATAS AGRUPADAS            *}
  {****************************************RL*}
  If dbgDuplicatas.DataSource.DataSet.FieldByName('Esp.').AsString = 'AG' Then
  Begin
    btnAgrupamentos.Enabled := True;
    btnProdutos.Enabled     := False;
  End
  Else
  Begin
    btnAgrupamentos.Enabled := False;
    btnProdutos.Enabled     := True;
  End;
end;

procedure TfrmMostraDebCtrChq.FormCreate(Sender: TObject);
begin
  inherited;

  {******************************************}
  {* QUANDO UTILIZAR ESSE RECURSO, NÃO      *}
  {* ESQUECER DE "LIMPAR" O EVENTO, OU SEJA *}
  {* ATRIBUIR NIL AO EVENTO. VER (*) NO E-  *}
  {* VENTO "OnClose"                        *}
  {* AO FAZE-LO, FAVOR COLOCAR ESSE COMEN-  *}
  {* TARIO                                  *}
  {***************************************RL*}
  qryTemporaria2.AfterScroll := pAtualizaDados;
  
  blnSelDocumentosDeb := FALSE;
end;

{*******************************************}
{* PROCEDURE QUE GERA INFORMAÇÕES PARA O   *}
{* RELATÓRIO E EXPORTA O PDF               *}
{****************************************AC*}
procedure TfrmMostraDebCtrChq.pGeraEmail(blnAbrirEmVideo: Boolean);
  Var
    strSQL: String;
    strCheque: String;
    strImagem: String;
    strExecutavel: String;
    strDirImagem: String;
begin

  {*******************************************}
  {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
  {* PARA USA-LO MAIS ABAIXO                 *}
  {****************************************AC*}
  strExecutavel := ExtractFilePath(Application.ExeName);

  {*******************************************}
  {* CRIO TEMPORARIAPRODUTOS PARA PEGAR OS   *}
  {* PRODUTOS INCLUSIVE AGRUPAMENTO          *}
  {****************************************AC*}
  pCriaTemporariaProdutos;

  {*******************************************}
  {* SELECIONO OS PRODUTOS                   *}
  {****************************************AC*}
  pSelecionaProdutosContasReceber;

  If strTipFil = 'A' Then
    strFiltro := 'Título(s) em Aberto(s).'
  Else If strTipFil = 'B' Then
    strFiltro := 'Título(s) Baixado(s).'
  Else If strTipFil = 'T' Then
    strFiltro := 'Título(s) Aberto(s) e Baixado(s).';

  Try

    Application.CreateForm(TfrmQckHTMLCliente,frmQckHTMLCliente);

    With frmQckHTMLCliente Do
    Begin


      qryRelatorio.Close;
      qryRelatorio.SQL.Clear;
      qryRelatorio.SQL.Add(strSQlProdutos);
      If bChkContaCorrente Then
      Begin
        qryRelatorio.ParamByName('CODCLI').AsString := strCodCli;
      End
      Else
      Begin
        qryRelatorio.ParamByName('CODCLI').AsString := '';
      End;
      qryRelatorio.Open;

      //CLIENTE
      strSQL := '';
      strSQL := strSQL + ' SELECT CLI_NOMCLI AS NOME,     ';
      strSQL := strSQL + '        CLI_FANSOB AS FANTASIA, ';
      strSQL := strSQL + '        CLI_ENDERE AS ENDERECO, ';
      strSQL := strSQL + '        CONCAT(CLI_BAIRRO," - ",CONCAT(CID.CID_NOMCID," - ",CID.CID_ESTADO)," - ",CLI_C_E_P_) AS BAIRRO, ';
      strSQL := strSQL + '        CLI_FONE01 AS TELEFONE1, ';
      strSQL := strSQL + '        CLI_FONE02 AS TELEFONE2, ';
      strSQL := strSQL + '        CLI_CGCCPF, ';
      strSQL := strSQL + '        IF (CLI_CGCCPF = 1, CONCAT(SUBSTRING(CLI_C_G_C_,1,2),".", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,3,3),".", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,6,3),"/", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,9,4),"-", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,13,2)),   ';
      strSQL := strSQL + '                            CONCAT(SUBSTRING(CLI_C_G_C_,1,3),".", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,4,3),".", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,7,3),"/", ';
      strSQL := strSQL + '                                   SUBSTRING(CLI_C_G_C_,10,2))) AS CLI_C_G_C_ , ';
      strSQL := strSQL + '        CLI_F_A_X_, ';
      strSQL := strSQL + '        CLI_I_E_S_, ';
      strSQL := strSQL + '        CLI_CONTAT AS CONTATO ';
      strSQL := strSQL + '   FROM CADCLI CLI ';
      strSQL := strSQL + '   JOIN CADCID CID ON CID.CID_CODCID = CLI.CLI_CODCID ';
      strSQL := strSQL + '  WHERE CLI_CODCLI = :CODCLI ';

      qryCliente.Close;
      qryCliente.SQL.Clear;
      qryCliente.SQL.Add(strSQL);
      qryCliente.ParamByName('CODCLI').AsString := strCodCli;
      qryCliente.Open;

      //EMPRESA
      strSQL := '';
      strSQL := strSQL + ' SELECT CONCAT(EMP_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
      strSQL := strSQL + '        CONCAT(EMP_ENDERE,", ",IFNULL(EMP_ENDNUM,""),"  ",IFNULL(EMP_ENDCMP,"")) AS ENDERECO, ';
      strSQL := strSQL + '        CONCAT(EMP_FONE01," / ",IFNULL(EMP_FONE02,"")) AS TELEFONE, ';
      strSQL := strSQL + '        CONCAT(EMP_BAIRRO," - ",CONCAT(CID.CID_NOMCID," - ",IFNULL(CID.CID_ESTADO,""))) AS BAIRRO, ';
      strSQL := strSQL + '        CONCAT(CID.CID_CODCID ,"-", IFNULL(CID.CID_NOMCID,"")) AS CIDADE, ';
      strSQL := strSQL + '        EMP_C_E_P_ AS CEP, ';
      strSQL := strSQL + '        EMP_F_A_X_, ';
      strSQL := strSQL + '        EMP_CONTAT, ';
      strSQL := strSQL + '        EMP_EMAIL_, ';
      strSQL := strSQL + '        ' + fCurrentDate + ' AS DATA ';
      strSQL := strSQL + '   FROM CADEMP EMP ';
      strSQL := strSQL + '   JOIN CADCID CID ON CID.CID_CODCID = EMP.EMP_CODCID ';
      strSQL := strSQL + '  WHERE EMP_CODEMP = :CODEMP ';

      qryEmpresa.Close;
      qryEmpresa.SQL.Clear;
      qryEmpresa.SQL.Add(strSQL);
      qryEmpresa.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryEmpresa.Open;

      {*******************************************}
      {* TOTAIS RELATORIO                        *}
      {****************************************AC*}
      pCalculaTotalRelatorio;

      qryTotal.Close;
      qryTotal.SQL.Clear;
      qryTotal.SQL.Add(strSQLValores);
      qryTotal.ParamByName('CODCLI').AsString   := strCodCli;
      qryTotal.ParamByName('DTAATU').AsDateTime := VS_Date;
      qryTotal.Open;

      {*******************************************}
      {* SE O CHECKBOX REFERENTE AO CHEQUE NÃO   *}
      {* NÃO ESTIVER CHECADO, ENTÃO EU ZERO A    *}
      {* VARIÁVEL REFENTE AO SQL DO CHEQUE       *}
      {****************************************AC*}
      strCheque := '';
      If (bChkCheque) Then
      Begin
        qryCheque.Close;
        qryCheque.SQL.Clear;
        qryCheque.SQL.Add(strSQLCheque);
        qryCheque.ParamByName('CODCLI').AsString := strCodCli;
        qryCheque.Open;
        If qryCheque.IsEmpty Then
          strCheque := 'N'
        Else
          strCheque := 'S';
      End
      Else
        strCheque := 'N';

      {*********************************************************}
      {* SE NÃO EXISTIR O ARQUIVO ELE NÃO CARREGA NO RELATÓRIO *}
      {******************************************************AC*}

      strImagem := '';

      If FileExists(VS_strPatLog) Then
      Begin
        strImagem    := 'S';
        strDirImagem := VS_strPatLog;
      End
      Else
      Begin
        strImagem    := 'N';
        strDirImagem := '';
      End;

      qryInformacoes.Close;
      qryInformacoes.CreateDataSet;
      qryInformacoes.Append;
      qryInformacoesADICIONAIS.AsString := strMensagemRel;
      qryInformacoesCHEQUE.AsString     := strCheque;
      qryInformacoesIMAGEM.AsString     := strImagem;
      qryInformacoesDIRETORIO.AsString  := strDirImagem;
      qryInformacoes.Post;

    End;

    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {****************************************AC*}
    If Not blnAbrirEmVideo Then
    Begin
      If Not DirectoryExists(strExecutavel+'ContaCorrente') Then
        CreateDir(strExecutavel+'ContaCorrente');
    End;    

    {*******************************************}
    {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
    {****************************************AC*}
    strNomeArquivo := 'Arquivo'+strCodCli+'.pdf';

    {*******************************************}
    {* INFORMAÇÕES DO RELATÓRIO :              *}
    {* DESABILITA ALGUNS CONTROLES E EXPORTA   *}
    {* O PDF.                                  *}
    {****************************************AC*}
    With frmQckHTMLCliente Do
    Begin
      frxPagina.PrepareReport(True);

      If blnAbrirEmVideo Then
      Begin
        frxPagina.ShowReport;
      End Else
      Begin
        frxExportaPDF.FileName    := strNomeArquivo;
        frxExportaPDF.DefaultPath := strExecutavel+'ContaCorrente';
        frxExportaPDF.ShowDialog  := False;
        frxPagina.Export(frxExportaPDF);
      End;

    End;

    {*******************************************}
    {* REUTILIZO A VARIÁVEL PARA PODER PASSAR  *}
    {* O CAMINHO PARA SER GERADO O ANEXO NO    *}
    {* EMAIL                                   *}
    {****************************************AC*}
    strNomeArquivo := strExecutavel+'ContaCorrente\'+strNomeArquivo;

  Finally
    FreeAndNil(frmQckHTMLCliente.frxPagina);
  End;

  frmQckHTMLCliente.qryRelatorio.Close;
  frmQckHTMLCliente.qryCliente.Close;
  frmQckHTMLCliente.qryEmpresa.Close;
  frmQckHTMLCliente.qryTotal.Close;
  frmQckHTMLCliente.qryInformacoes.Close;

  {********************************************}
  {* DELETO TEMPORARIA PARA PEGAR OS PRODUTOS *}
  {*****************************************AC*}
  pDeletaTemporariaProdutos;

end;

{********************************************}
{* FUNÇÃO QUE ABRE O OUTLOOK E ANEXO O HTML *}
{*****************************************AC*}
function TfrmMostraDebCtrChq.EnviarEMail(const De, Para, Assunto, Texto,
  Arquivo: string; Confirma: Boolean): Integer;
var
  Msg: TMapiMessage;
  lpSender, lpRecepient: TMapiRecipDesc;
  FileAttach: TMapiFileDesc;
  SM: TFNMapiSendMail;
  MAPIModule: HModule;
  Flags: Cardinal;
begin
  // cria propriedades da mensagem
  FillChar(Msg, SizeOf(Msg), 0);
  with Msg do
    begin
      if (Assunto <> '') then
        lpszSubject := PChar(Assunto);
       if (Texto <> '') then
        lpszNoteText := PChar(Texto);

      // remetente
      if (De <> '') then
        begin
          lpSender.ulRecipClass := MAPI_ORIG;
          lpSender.lpszName     := PChar(De);
          lpSender.lpszAddress  := PChar(De);
          lpSender.ulReserved   := 0;
          lpSender.ulEIDSize    := 0;
          lpSender.lpEntryID    := nil;
          lpOriginator          := @lpSender;
        end;

      // destinatário
      if (Para <> '') then
        begin
          lpRecepient.ulRecipClass := MAPI_TO;
          lpRecepient.lpszName     := PChar(Para);
          lpRecepient.lpszAddress  := PChar(Para);
          lpRecepient.ulReserved   := 0;
          lpRecepient.ulEIDSize    := 0;
          lpRecepient.lpEntryID    := nil;
          nRecipCount              := 1;
          lpRecips                 := @lpRecepient;
        end
      else
        lpRecips := nil;

      // arquivo anexo
      if (Arquivo = '') then
        begin
          nFileCount := 0;
          lpFiles    := nil;
        end
      else
        begin
          FillChar(FileAttach, SizeOf(FileAttach), 0);
          FileAttach.nPosition    := Cardinal($FFFFFFFF);
          FileAttach.lpszPathName := PChar(Arquivo);
          nFileCount              := 1;
          lpFiles                 := @FileAttach;

          {*******************************************}
          {* ANEXA A IMAGEM TAMBÉM SE NECESSARIO     *}
          {* SÓ É PRECISO CRIAR UMA NOVA VARIÁVEL    *}
          {* FileAttach E ACRESCENTAR MAIS UM        *)
          {* PARÂMETRO Arquivo NA FUNÇÃO             *)
          {****************************************AC*}
          //FillChar(FileAttach2, SizeOf(FileAttach2), 0);
          //FileAttach2.nPosition    := Cardinal($FFFFFFFFF);
          //FileAttach2.lpszPathName := PChar(Arquivo2);
          //nFileCount               := 2;
          //lpFiles                  := @FileAttach2;
        end;
    end;
  // carrega dll e o método para envio do email
  MAPIModule := LoadLibrary(PChar(MAPIDLL));
  if MAPIModule = 0 then
    Result := -1
  else
    try
      if Confirma then
        Flags := MAPI_DIALOG or MAPI_LOGON_UI
      else
        Flags := 0;
      @SM := GetProcAddress(MAPIModule, 'MAPISendMail');
      if @SM <> nil then
        Result := SM(0, Application.Handle, Msg, Flags, 0)
      else
        Result := 1;
    finally
      FreeLibrary(MAPIModule);
    end;
end;

procedure TfrmMostraDebCtrChq.pCalculaTotalRelatorio;
  Var
    strSQL: String;
begin
  strSQLValores := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SUM(CTR_VALORI) AS TOTALORIGINAL,                       ';
  strSQL := strSQL + '   SUM(CTR_VALDUP) AS TOTALDUPLICATA,                      ';
  strSQL := strSQL + '   SUM(CTR_VALJUR) AS TOTALJUROS,                          ';
  strSQL := strSQL + '   SUM(CTR_VALCAL) AS TOTALCORRIGIDO,                      ';
  strSQL := strSQL + '   SUM(CTR_VALREC) AS TOTALRECEBIDO,                       ';
  strSQL := strSQL + '   SUM(CTR_DIFERE) AS TOTALDIFERENCA,                      ';
  strSQL := strSQL + '   SUM(IF(CTR_DTAVEN <= :DTAATU, CTR_VALDUP,0)) AS DUPVEN, ';
  strSQL := strSQL + '   SUM(IF(CTR_DTAVEN > :DTAATU, CTR_VALDUP,0)) AS DUPAVE   ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   TMP_CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';

  If strTipFil = 'B' Then
    strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';

  If strTipFil = 'A' Then
    strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';

  {*******************************************}
  {* GUARDO ESSE SELECT PARA USA-LO CASO O   *}
  {* USUARIO USE ENVIAR EMAIL QUANDO         *}
  {* strTipFil <> 'B'                        *}
  {****************************************AC*}

  strSQLValores := strSQL;    //
end;

procedure TfrmMostraDebCtrChq.pSelecionaProdutosContasReceber;
  Var
    strSQL: String;
begin

  {**********************************************}
  {* SE ESCOLHER CONTA CORRENTE ENTRO AQUI      *}
  {* SENÃO ELE SÓ MOSTRA O CHEQUE, SE O USUÁRIO *}
  {* TIVER ESCOLHIDO ESSA OPÇÃO                 *}
  {*******************************************AC*}
//  If (bChkContaCorrente) Then
//  Begin
    //Duplicatas
  //MOVDET E MOVDETX
    strSQL := '';
    strSQL := strSQL + '  SELECT                                           ';
    strSQL := strSQL + '    CTR_NUMDUP AS DUPLICATA,                       ';
    strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR,            ';
    strSQL := strSQL + '    CTR_ESPDOC AS ESPECIE,                         ';
    strSQL := strSQL + '    CTR_CODEMP AS EMPRESA,                         ';
    strSQL := strSQL + '    CTR_CODVEN AS VENDEDOR,                        ';
    strSQL := strSQL + '    CTR_HIST01,                                    ';
    strSQL := strSQL + '    CTR_HIST02,                                    ';
    strSQL := strSQL + '    CTR_DTACAD AS DATACADASTRO,                    ';
    strSQL := strSQL + '    CTR_DTAVEN AS DATAVENCIMENTO,                  ';
    strSQL := strSQL + '    CTR_VALORI AS VALORORIGINAL,                   ';
    strSQL := strSQL + '    CTR_VALDUP AS VALORDUPLICATA,                  ';
    strSQL := strSQL + '    CTR_VALJUR AS VALORJUROS,                      ';
    strSQL := strSQL + '    CTR_VALCAL AS VALORCORRIGIDO,                  ';
    strSQL := strSQL + '    CTR_DTAREC AS DATARECEBIMENTO,                 ';
    strSQL := strSQL + '    CTR_VALREC AS VALORRECEBIDO,                   ';
//    strSQL := strSQL + '    CTR_DIFERE AS DIFERENCA,                       ';
    strSQL := strSQL + '    IF (LENGTH(CTR_NUMDUP) = 6,CTR_VALORI - CTR_VALREC,CTR_DIFERE) AS DIFERENCA, ';

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
    //Item
      strSQL := strSQL + '    DET_CODITE AS CODITEM,                         ';
      strSQL := strSQL + '    DET_DESCRI AS DESCRICAOITEM,                   ';
      strSQL := strSQL + '    UNI_DESUNI AS UNIDADE,                         ';
      strSQL := strSQL + '    DET_QTDITE AS QTDEITEM,                        ';
      strSQL := strSQL + '    DET_UNITAR AS UNITARIOITEM,                    ';
      strSQL := strSQL + '    DET_UNIORI AS UNIORIITEM,                      ';
      strSQL := strSQL + '    DET_TOTITE AS TOTALITEM,                       ';
      strSQL := strSQL + '    DET_DESESP AS TOTALDESESP,                     ';
      strSQL := strSQL + '    DET_DESCON AS DESCONTOITEM,                    ';
      strSQL := strSQL + '    DET_TOTFRE AS TOTALFRETE,                      ';

      strSQL := strSQL + '    "99999" AS ORDEM,                              ';
      strSQL := strSQL + '    CTR_ESPDOC AS ORDEM2,                          ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,      ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2,  ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '    "2" AS STATUS3                               '
      Else
        strSQL := strSQL + '    "1" AS STATUS3                               ';

      {*******************************************}
      {* JOIN PARA PEGAR O(S) PRODUTO(S) DA(S)   *}
      {* DUPLICATA(S).                           *}
      {****************************************AC*}
      strSQL := strSQL + '  FROM                                             ';
      strSQL := strSQL + '    TMP_CADREC                                     ';
      strSQL := strSQL + '  JOIN TMP_MOVDET ON DET_NUMDOC = SUBSTRING(CTR_NUMDUP,1,12) ';
      strSQL := strSQL + '                 AND DET_ESPDOC = CTR_ESPDOC       ';
      strSQL := strSQL + '                 AND DET_CODEMP = CTR_CODEMP       ';
      strSQL := strSQL + '  JOIN CADUNI ON UNI_CODUNI     = DET_UNIDAD       ';
    End
    Else
    Begin
      {************************************************}
      {* SE O CHECKBOX DE PRODUTO NAO ESTIVER CHECADO *}
      {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS  *}
      {*********************************************AC*}

      strSQL := strSQL + '    NULL AS CODITEM,                         ';
      strSQL := strSQL + '    NULL AS DESCRICAOITEM,                   ';
      strSQL := strSQL + '    NULL AS UNIDADE,                         ';
      strSQL := strSQL + '    0.00 AS QTDEITEM,                        ';
      strSQL := strSQL + '    0.00 AS UNITARIOITEM,                    ';
      strSQL := strSQL + '    0.00 AS UNIORIITEM,                      ';
      strSQL := strSQL + '    0.00 AS TOTALITEM,                       ';
      strSQL := strSQL + '    0.00 AS TOTALDESESP,                     ';      
      strSQL := strSQL + '    0.00 AS DESCONTOITEM,                    ';
      strSQL := strSQL + '    0.00 AS TOTALFRETE,                      ';

      strSQL := strSQL + '    SUBSTRING(CTR_NUMDUP,1,12) AS ORDEM,           ';
      strSQL := strSQL + '    CTR_ESPDOC AS ORDEM2,                          ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,      ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2,  ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '    "2" AS STATUS3                               '
      Else
        strSQL := strSQL + '    "1" AS STATUS3                               ';

      strSQL := strSQL + '  FROM                                             ';
      strSQL := strSQL + '    TMP_CADREC                                     ';
    End;

    If strTipFil = 'A' Then
    Begin
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
      strSQL := strSQL + '    CTR_DTAREC IS NULL        ';
    End
    Else If strTipFil = 'B' Then
    Begin
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
      strSQL := strSQL + '    CTR_DTAREC IS NOT NULL    ';
    End
    Else If strTipFil = 'T' Then
    Begin
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '    CTR_CODCLI = :CODCLI      ';
    End;

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
      strSQL := strSQL + '    AND DET_PROEMB <> "S"           ';
      strSQL := strSQL + '    AND DET_TIP_FC = "C"            ';
      strSQL := strSQL + '    AND DET_JAFATU = 0              ';
    End;

    If (bChkProduto) Then
      strSQL := strSQL + '  UNION                                            ';

    If (bChkProduto) Then
    Begin

      //NOTDET E NOTDETX
      //strSQL := '';
      strSQL := strSQL + '  SELECT                                           ';
      strSQL := strSQL + '    CTR_NUMDUP AS DUPLICATA,                       ';
      strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR,            ';
      strSQL := strSQL + '    CTR_ESPDOC AS ESPECIE,                         ';
      strSQL := strSQL + '    CTR_CODEMP AS EMPRESA,                         ';
      strSQL := strSQL + '    CTR_CODVEN AS VENDEDOR,                        ';
      strSQL := strSQL + '    CTR_HIST01,                                    ';
      strSQL := strSQL + '    CTR_HIST02,                                    ';
      strSQL := strSQL + '    CTR_DTACAD AS DATACADASTRO,                    ';
      strSQL := strSQL + '    CTR_DTAVEN AS DATAVENCIMENTO,                  ';
      strSQL := strSQL + '    CTR_VALORI AS VALORORIGINAL,                   ';
      strSQL := strSQL + '    CTR_VALDUP AS VALORDUPLICATA,                  ';
      strSQL := strSQL + '    CTR_VALJUR AS VALORJUROS,                      ';
      strSQL := strSQL + '    CTR_VALCAL AS VALORCORRIGIDO,                  ';
      strSQL := strSQL + '    CTR_DTAREC AS DATARECEBIMENTO,                 ';
      strSQL := strSQL + '    CTR_VALREC AS VALORRECEBIDO,                   ';
//      strSQL := strSQL + '    CTR_DIFERE AS DIFERENCA,                       ';
      strSQL := strSQL + '    IF (LENGTH(CTR_NUMDUP) = 6,CTR_VALORI - CTR_VALREC,CTR_DIFERE) AS DIFERENCA, ';

      {***********************************************}
      {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
      {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
      {********************************************AC*}

      //Item
      strSQL := strSQL + '    DET_CODITE AS CODITEM,                         ';
      strSQL := strSQL + '    DET_DESCRI AS DESCRICAOITEM,                   ';
      strSQL := strSQL + '    UNI_DESUNI AS UNIDADE,                         ';
      strSQL := strSQL + '    DET_QTDITE AS QTDEITEM,                        ';
      strSQL := strSQL + '    DET_UNITAR AS UNITARIOITEM,                    ';
      strSQL := strSQL + '    DET_UNIORI AS UNIORIITEM,                      ';
      strSQL := strSQL + '    DET_TOTITE AS TOTALITEM,                       ';
      strSQL := strSQL + '    DET_DESESP AS TOTALDESESP,                     ';      
      strSQL := strSQL + '    DET_DESCON AS DESCONTOITEM,                    ';
      strSQL := strSQL + '    DET_TOTFRE AS TOTALFRETE,                      ';

      strSQL := strSQL + '    "99999" AS ORDEM,                              ';
      strSQL := strSQL + '    CTR_ESPDOC AS ORDEM2,                          ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,      ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2,  ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '    "2" AS STATUS3                               '
      Else
        strSQL := strSQL + '    "1" AS STATUS3                               ';

      strSQL := strSQL + '  FROM                                             ';
      strSQL := strSQL + '    TMP_CADREC                                     ';
      strSQL := strSQL + '  JOIN TMP_NOTDET ON DET_NUMDOC = SUBSTRING(CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                 AND DET_ESPDOC = CTR_ESPDOC       ';
      strSQL := strSQL + '                 AND DET_CODEMP = CTR_CODEMP       ';
      strSQL := strSQL + '  JOIN CADUNI ON UNI_CODUNI     = DET_UNIDAD       ';

      If strTipFil = 'A' Then
      Begin
        strSQL := strSQL + '  WHERE                       ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    CTR_DTAREC IS NULL        ';
      End
      Else If strTipFil = 'B' Then
      Begin
        strSQL := strSQL + '  WHERE                       ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    CTR_DTAREC IS NOT NULL    ';
      End
      Else If strTipFil = 'T' Then
      Begin
        strSQL := strSQL + '  WHERE                       ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI      ';
      End;

      {***********************************************}
      {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
      {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
      {********************************************AC*}

      strSQL := strSQL + '    AND DET_PROEMB <> "S"           ';
      strSQL := strSQL + '    AND DET_TIP_FC = "C"            ';
      strSQL := strSQL + '    AND DET_JAFATU = 0              ';

    End;

    If (bChkProduto) Then
      strSQL := strSQL + '  UNION                                            ';
    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
      //MOSTRA A DUPLICATA SEM O ITEM
      strSQL := strSQL + '  SELECT                                           ';
      strSQL := strSQL + '    CTR_NUMDUP AS DUPLICATA,                       ';
      strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR,            ';
      strSQL := strSQL + '    CTR_ESPDOC AS ESPECIE,                         ';
      strSQL := strSQL + '    CTR_CODEMP AS EMPRESA,                         ';
      strSQL := strSQL + '    CTR_CODVEN AS VENDEDOR,                        ';
      strSQL := strSQL + '    CTR_HIST01,                                    ';
      strSQL := strSQL + '    CTR_HIST02,                                    ';
      strSQL := strSQL + '    CTR_DTACAD AS DATACADASTRO,                    ';
      strSQL := strSQL + '    CTR_DTAVEN AS DATAVENCIMENTO,                  ';
      strSQL := strSQL + '    CTR_VALORI AS VALORORIGINAL,                   ';
      strSQL := strSQL + '    CTR_VALDUP AS VALORDUPLICATA,                  ';
      strSQL := strSQL + '    CTR_VALJUR AS VALORJUROS,                      ';
      strSQL := strSQL + '    CTR_VALCAL AS VALORCORRIGIDO,                  ';
      strSQL := strSQL + '    CTR_DTAREC AS DATARECEBIMENTO,                 ';
      strSQL := strSQL + '    CTR_VALREC AS VALORRECEBIDO,                   ';
//      strSQL := strSQL + '    CTR_DIFERE AS DIFERENCA,                       ';
      strSQL := strSQL + '    IF (LENGTH(CTR_NUMDUP) = 6,CTR_VALORI - CTR_VALREC,CTR_DIFERE) AS DIFERENCA, ';

      //Item
      strSQL := strSQL + '    NULL AS CODITEM,                         ';
      strSQL := strSQL + '    NULL AS DESCRICAOITEM,                   ';
      strSQL := strSQL + '    NULL AS UNIDADE,                         ';
      strSQL := strSQL + '    NULL AS QTDEITEM,                        ';
      strSQL := strSQL + '    NULL AS UNITARIOITEM,                    ';
      strSQL := strSQL + '    NULL AS UNIORIITEM,                      ';
      strSQL := strSQL + '    NULL AS TOTALITEM,                       ';
      strSQL := strSQL + '    NULL AS TOTALDESESP,                     ';      
      strSQL := strSQL + '    NULL AS DESCONTOITEM,                    ';
      strSQL := strSQL + '    NULL AS TOTALFRETE,                      ';

      strSQL := strSQL + '    IF(CTR_ESPDOC = "AG",SUBSTRING(CTR_NUMDUP,1,6),"99999") AS ORDEM,  ';
      strSQL := strSQL + '    CTR_ESPDOC AS ORDEM2,                          ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,      ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2,  ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '    "2" AS STATUS3                               '
      Else
        strSQL := strSQL + '    "1" AS STATUS3                               ';

      strSQL := strSQL + '   FROM TMP_CADREC                                  ';
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '   (SUBSTRING(CTR_NUMDUP,1,6)) NOT IN (SELECT DET_NUMDOC FROM TMP_MOVDET) ';
      strSQL := strSQL + '   AND (SUBSTRING(CTR_NUMDUP,1,6)) NOT IN (SELECT DET_NUMDOC FROM TMP_NOTDET) ';

      If strTipFil = 'A' Then
      Begin
        strSQL := strSQL + '  AND                         ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    CTR_DTAREC IS NULL        ';
      End
      Else If strTipFil = 'B' Then
      Begin
        strSQL := strSQL + '  AND                         ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    CTR_DTAREC IS NOT NULL    ';
      End
      Else If strTipFil = 'T' Then
      Begin
        strSQL := strSQL + '  AND                         ';
        strSQL := strSQL + '    CTR_CODCLI = :CODCLI      ';
      End;
    End;

    If (bChkProduto) Then
      strSQL := strSQL + '  UNION                         ';

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
      //MOSTRA DUPLICATA DO AGRUPAMENTO QUE NÃO TEM ITEM
      strSQL := strSQL + '  SELECT                                ';
      strSQL := strSQL + '    AGR.CTR_NUMDUP AS DUPLICATA,        ';
      strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR, ';
      strSQL := strSQL + '    AGR.CTR_ESPDOC AS ESPECIE,          ';
      strSQL := strSQL + '    AGR.CTR_EMPAGR AS EMPRESA,          ';
      strSQL := strSQL + '    AGR.CTR_CODVEN AS VENDEDOR,         ';
      strSQL := strSQL + '    AGR.CTR_HIST01,                     ';
      strSQL := strSQL + '    AGR.CTR_HIST02,                     ';
      strSQL := strSQL + '    AGR.CTR_DTACAD AS DATACADASTRO,     ';
      strSQL := strSQL + '    AGR.CTR_DTAVEN AS DATAVENCIMENTO,   ';
      strSQL := strSQL + '    AGR.CTR_VALORI AS VALORORIGINAL,    ';
      strSQL := strSQL + '    AGR.CTR_VALDUP AS VALORDUPLICATA,   ';
      strSQL := strSQL + '    REC.CTR_VALJUR AS VALORJUROS,       ';
      strSQL := strSQL + '    REC.CTR_VALCAL AS VALORCORRIGIDO,   ';
      strSQL := strSQL + '    REC.CTR_DTAREC AS DATARECEBIMENTO,  ';
      strSQL := strSQL + '    REC.CTR_VALREC AS VALORRECEBIDO,    ';
//      strSQL := strSQL + '    REC.CTR_DIFERE AS DIFERENCA,        ';
      strSQL := strSQL + '    IF (LENGTH(AGR.CTR_NUMDUP) = 6,AGR.CTR_VALORI - REC.CTR_VALREC,REC.CTR_DIFERE) AS DIFERENCA, ';

      strSQL := strSQL + '    NULL AS CODITEM,                    ';
      strSQL := strSQL + '    NULL AS DESCRICAOITEM,              ';
      strSQL := strSQL + '    NULL AS UNIDADE,                    ';
      strSQL := strSQL + '    NULL AS QTDEITEM,                   ';
      strSQL := strSQL + '    NULL AS UNITARIOITEM,               ';
      strSQL := strSQL + '    NULL AS UNIORIITEM,                 ';
      strSQL := strSQL + '    NULL AS TOTALITEM,                  ';
      strSQL := strSQL + '    NULL AS TOTALDESESP,                ';      
      strSQL := strSQL + '    NULL AS DESCONTOITEM,               ';
      strSQL := strSQL + '    NULL AS TOTALFRETE,                 ';

      strSQL := strSQL + '    SUBSTRING(AGR.CTR_NUMAGR,1,6) AS ORDEM,  ';
      strSQL := strSQL + '    "AH" AS ORDEM2,                          ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,     ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2, ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '    "2" AS STATUS3                              '
      Else
        strSQL := strSQL + '    "1" AS STATUS3                              ';

      strSQL := strSQL + '  FROM TMP_CADREC REC                             ';
      strSQL := strSQL + '  JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = SUBSTRING(REC.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                 AND AGR.CTR_CODCLI = REC.CTR_CODCLI                ';
      strSQL := strSQL + '                 AND AGR.CTR_EMPAGR = REC.CTR_CODEMP                ';
      strSQL := strSQL + '                 AND (AGR.CTR_NUMDUP NOT IN (SELECT DET_NUMDOC      ';
      strSQL := strSQL + '                                               FROM TMP_MOVDET      ';
      strSQL := strSQL + '                                              WHERE DET_ESPDOC = AGR.CTR_ESPDOC   ';
      strSQL := strSQL + '                                                AND DET_CODEMP = AGR.CTR_EMPAGR   ';
      strSQL := strSQL + '                                                AND DET_CODCLI = AGR.CTR_CODCLI)) ';
      strSQL := strSQL + '                 AND (AGR.CTR_NUMDUP NOT IN (SELECT DET_NUMDOC                    ';
      strSQL := strSQL + '                                               FROM TMP_NOTDET                    ';
      strSQL := strSQL + '                                              WHERE DET_ESPDOC = AGR.CTR_ESPDOC   ';
      strSQL := strSQL + '                                                AND DET_CODEMP = AGR.CTR_EMPAGR   ';
      strSQL := strSQL + '                                                AND DET_CODCLI = AGR.CTR_CODCLI)) ';

      If strTipFil = 'A' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    REC.CTR_DTAREC IS NULL        ';
      End
      Else If strTipFil = 'B' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    REC.CTR_DTAREC IS NOT NULL    ';
      End
      Else If strTipFil = 'T' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI      ';
      End;

      strSQL := strSQL + '      AND REC.CTR_ESPDOC = "AG"     ';
    End;

    strSQL := strSQL + '  UNION                             ';

    //MOSTRA ITENS AGRUPAMENTO DUPAGR,DUPAGRX COM MOVDET,MOVDET
    strSQL := strSQL + '  SELECT                                 ';
    strSQL := strSQL + '    AGR.CTR_NUMDUP AS DUPLICATA,         ';
    strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR,  ';
    strSQL := strSQL + '    AGR.CTR_ESPDOC AS ESPECIE,           ';
    strSQL := strSQL + '    AGR.CTR_EMPAGR AS EMPRESA,           ';
    strSQL := strSQL + '    AGR.CTR_CODVEN AS VENDEDOR,          ';
    strSQL := strSQL + '    AGR.CTR_HIST01,                      ';
    strSQL := strSQL + '    AGR.CTR_HIST02,                      ';
    strSQL := strSQL + '    AGR.CTR_DTACAD AS DATACADASTRO,      ';
    strSQL := strSQL + '    AGR.CTR_DTAVEN AS DATAVENCIMENTO,    ';
    strSQL := strSQL + '    AGR.CTR_VALORI AS VALORORIGINAL,     ';
    strSQL := strSQL + '    AGR.CTR_VALDUP AS VALORDUPLICATA,    ';
    strSQL := strSQL + '    REC.CTR_VALJUR AS VALORJUROS,        ';
    strSQL := strSQL + '    REC.CTR_VALCAL AS VALORCORRIGIDO,    ';
    strSQL := strSQL + '    REC.CTR_DTAREC AS DATARECEBIMENTO,   ';
    strSQL := strSQL + '    REC.CTR_VALREC AS VALORRECEBIDO,     ';
//    strSQL := strSQL + '    REC.CTR_DIFERE AS DIFERENCA,         ';
    strSQL := strSQL + '    IF (LENGTH(AGR.CTR_NUMDUP) = 6,AGR.CTR_VALORI - REC.CTR_VALREC,REC.CTR_DIFERE) AS DIFERENCA, ';

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
      //Item
      strSQL := strSQL + '    DET_CODITE AS CODITEM,               ';
      strSQL := strSQL + '    DET_DESCRI AS DESCRICAOITEM,         ';
      strSQL := strSQL + '    UNI_DESUNI AS UNIDADE,               ';
      strSQL := strSQL + '    DET_QTDITE AS QTDEITEM,              ';
      strSQL := strSQL + '    DET_UNITAR AS UNITARIOITEM,          ';
      strSQL := strSQL + '    DET_UNIORI AS UNIORIITEM,            ';
      strSQL := strSQL + '    DET_TOTITE AS TOTALITEM,             ';
      strSQL := strSQL + '    DET_DESESP AS TOTALDESESP,           ';      
      strSQL := strSQL + '    DET_DESCON AS DESCONTOITEM,          ';
      strSQL := strSQL + '    DET_TOTFRE AS TOTALFRETE,            ';

      strSQL := strSQL + '    SUBSTRING(AGR.CTR_NUMAGR,1,6) AS ORDEM,       ';
      strSQL := strSQL + '    "AH" AS ORDEM2,                               ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,     ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2, ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '  "2" AS STATUS3                              '
      Else
        strSQL := strSQL + '  "1" AS STATUS3                              ';

      strSQL := strSQL + '  FROM   ';
      strSQL := strSQL + '    TMP_CADREC REC  ';

      strSQL := strSQL + '  JOIN TMP_DUPAGR AGR ON SUBSTRING(AGR.CTR_NUMAGR,1,6) = SUBSTRING(REC.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                     AND AGR.CTR_CODCLI = REC.CTR_CODCLI ';
      strSQL := strSQL + '                     AND AGR.CTR_EMPAGR = REC.CTR_CODEMP ';

      strSQL := strSQL + '  JOIN TMP_MOVDET ON DET_NUMDOC = SUBSTRING(AGR.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                 AND DET_ESPDOC = AGR.CTR_ESPDOC ';
      strSQL := strSQL + '                 AND DET_CODEMP = AGR.CTR_EMPAGR ';

      strSQL := strSQL + '  JOIN CADUNI ON UNI_CODUNI     = DET_UNIDAD     ';
    End
    Else
    Begin
      strSQL := strSQL + '    NULL AS CODITEM,               ';
      strSQL := strSQL + '    NULL AS DESCRICAOITEM,         ';
      strSQL := strSQL + '    NULL AS UNIDADE,               ';
      strSQL := strSQL + '    0.00 AS QTDEITEM,              ';
      strSQL := strSQL + '    0.00 AS UNITARIOITEM,          ';
      strSQL := strSQL + '    0.00 AS UNIORIITEM,            ';
      strSQL := strSQL + '    0.00 AS TOTALITEM,             ';
      strSQL := strSQL + '    0.00 AS TOTALDESESP,           ';      
      strSQL := strSQL + '    0.00 AS DESCONTOITEM,          ';
      strSQL := strSQL + '    0.00 AS TOTALFRETE,            ';

      strSQL := strSQL + '    SUBSTRING(AGR.CTR_NUMAGR,1,6) AS ORDEM,       ';
      strSQL := strSQL + '    "AH" AS ORDEM2,                               ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,     ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2, ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '  "2" AS STATUS3                              '
      Else
        strSQL := strSQL + '  "1" AS STATUS3                              ';

      strSQL := strSQL + '  FROM   ';
      strSQL := strSQL + '    TMP_CADREC REC  ';

      strSQL := strSQL + '  JOIN TMP_DUPAGR AGR ON SUBSTRING(AGR.CTR_NUMAGR,1,6) = SUBSTRING(REC.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                     AND AGR.CTR_CODCLI = REC.CTR_CODCLI ';
      strSQL := strSQL + '                     AND AGR.CTR_EMPAGR = REC.CTR_CODEMP ';
    End;

    If strTipFil = 'A' Then
    Begin
      strSQL := strSQL + '  WHERE                           ';
      strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
      strSQL := strSQL + '    REC.CTR_DTAREC IS NULL        ';
    End
    Else If strTipFil = 'B' Then
    Begin
      strSQL := strSQL + '  WHERE                           ';
      strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
      strSQL := strSQL + '    REC.CTR_DTAREC IS NOT NULL    ';
    End
    Else If strTipFil = 'T' Then
    Begin
      strSQL := strSQL + '  WHERE                           ';
      strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI      ';
    End;

    strSQL := strSQL + '    AND REC.CTR_ESPDOC = "AG"       ';

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin
      strSQL := strSQL + '    AND DET_PROEMB <> "S"           ';
      strSQL := strSQL + '    AND DET_TIP_FC = "C"            ';
      strSQL := strSQL + '    AND DET_JAFATU = 0              ';
    End;

    If (bChkProduto) Then
      strSQL := strSQL + '  UNION                         ';

    {***********************************************}
    {* SE O CHECKBOX DE PRODUTO ESTIVER CHECADO    *}
    {* ENTÃO EU MOSTRO OS PRODUTOS E AS DUPLICATAS *}
    {********************************************AC*}
    If (bChkProduto) Then
    Begin

      //MOSTRA ITENS AGRUPAMENTO DUPAGR,DUPAGRX COM MOVDET,MOVDET
      strSQL := strSQL + '  SELECT                                 ';
      strSQL := strSQL + '    AGR.CTR_NUMDUP AS DUPLICATA,         ';
      strSQL := strSQL + '    SUBSTR(NOMPOR, 1, 25 ) AS PORTADOR,  ';
      strSQL := strSQL + '    AGR.CTR_ESPDOC AS ESPECIE,           ';
      strSQL := strSQL + '    AGR.CTR_EMPAGR AS EMPRESA,           ';
      strSQL := strSQL + '    AGR.CTR_CODVEN AS VENDEDOR,          ';
      strSQL := strSQL + '    AGR.CTR_HIST01,                      ';
      strSQL := strSQL + '    AGR.CTR_HIST02,                      ';
      strSQL := strSQL + '    AGR.CTR_DTACAD AS DATACADASTRO,      ';
      strSQL := strSQL + '    AGR.CTR_DTAVEN AS DATAVENCIMENTO,    ';
      strSQL := strSQL + '    AGR.CTR_VALORI AS VALORORIGINAL,     ';
      strSQL := strSQL + '    AGR.CTR_VALDUP AS VALORDUPLICATA,    ';
      strSQL := strSQL + '    REC.CTR_VALJUR AS VALORJUROS,        ';
      strSQL := strSQL + '    REC.CTR_VALCAL AS VALORCORRIGIDO,    ';
      strSQL := strSQL + '    REC.CTR_DTAREC AS DATARECEBIMENTO,   ';
      strSQL := strSQL + '    REC.CTR_VALREC AS VALORRECEBIDO,     ';
//      strSQL := strSQL + '    REC.CTR_DIFERE AS DIFERENCA,         ';
      strSQL := strSQL + '    IF (LENGTH(AGR.CTR_NUMDUP) = 6,AGR.CTR_VALORI - REC.CTR_VALREC,REC.CTR_DIFERE) AS DIFERENCA, ';

      //Item
      strSQL := strSQL + '    DET_CODITE AS CODITEM,               ';
      strSQL := strSQL + '    DET_DESCRI AS DESCRICAOITEM,         ';
      strSQL := strSQL + '    UNI_DESUNI AS UNIDADE,               ';
      strSQL := strSQL + '    DET_QTDITE AS QTDEITEM,              ';
      strSQL := strSQL + '    DET_UNITAR AS UNITARIOITEM,          ';
      strSQL := strSQL + '    DET_UNIORI AS UNIORIITEM,            ';
      strSQL := strSQL + '    DET_TOTITE AS TOTALITEM,             ';
      strSQL := strSQL + '    DET_DESESP AS TOTALDESESP,           ';
      strSQL := strSQL + '    DET_DESCON AS DESCONTOITEM,          ';
      strSQL := strSQL + '    DET_TOTFRE AS TOTALFRETE,            ';

      strSQL := strSQL + '    SUBSTRING(AGR.CTR_NUMAGR,1,6) AS ORDEM,       ';
      strSQL := strSQL + '    "AH" AS ORDEM2,                               ';

      strSQL := strSQL + '    IF (CTR_DTAREC IS NULL,"A",0) AS STATUS1,     ';
      strSQL := strSQL + '    IF (CTR_DTAREC IS NOT NULL,"B",0) AS STATUS2, ';

      If strTipFil = 'T' Then
        strSQL := strSQL + '  "2" AS STATUS3                              '
      Else
        strSQL := strSQL + '  "1" AS STATUS3                              ';

      strSQL := strSQL + '  FROM   ';
      strSQL := strSQL + '    TMP_CADREC REC  ';

      strSQL := strSQL + '  JOIN TMP_DUPAGR AGR ON SUBSTRING(AGR.CTR_NUMAGR,1,6) = SUBSTRING(REC.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                     AND AGR.CTR_CODCLI = REC.CTR_CODCLI ';
      strSQL := strSQL + '                     AND AGR.CTR_EMPAGR = REC.CTR_CODEMP ';

      strSQL := strSQL + '  JOIN TMP_NOTDET ON DET_NUMDOC = SUBSTRING(AGR.CTR_NUMDUP,1,6) ';
      strSQL := strSQL + '                 AND DET_ESPDOC = AGR.CTR_ESPDOC ';
      strSQL := strSQL + '                 AND DET_CODEMP = AGR.CTR_EMPAGR ';

      strSQL := strSQL + '  JOIN CADUNI ON UNI_CODUNI     = DET_UNIDAD     ';

      If strTipFil = 'A' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    REC.CTR_DTAREC IS NULL        ';
      End
      Else If strTipFil = 'B' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI AND  ';
        strSQL := strSQL + '    REC.CTR_DTAREC IS NOT NULL    ';
      End
      Else If strTipFil = 'T' Then
      Begin
        strSQL := strSQL + '  WHERE                           ';
        strSQL := strSQL + '    REC.CTR_CODCLI = :CODCLI      ';
      End;

      strSQL := strSQL + '    AND REC.CTR_ESPDOC = "AG"       ';

      strSQL := strSQL + '    AND DET_PROEMB <> "S"           ';
      strSQL := strSQL + '    AND DET_TIP_FC = "C"            ';
      strSQL := strSQL + '    AND DET_JAFATU = 0              ';

    End;

    strSQL := strSQL + '  ORDER BY                          ';
    strSQL := strSQL + '    ORDEM,ORDEM2,1                  ';

    strSQlProdutos := '';
    strSQlProdutos := strSQL;
  //End;
end;

procedure TfrmMostraDebCtrChq.dbgDuplicatasTitleClick(Column: TColumn);
begin
  inherited;

  If Not qryTemporaria2.IsEmpty Then
  Begin
    {*************************************************}
    {* ESTOU SOMANDO + 3 PQ NO SELECT DOS REGISTROS  *}
    {* OS TRES PRIMEIROS CAMPOS NÃO ME "INTERESSAM". *}
    {* ELE TRAZ TRES CAMPOS A MAIS, QUE NÃO SÃO      *}
    {* MOSTRADOS NO GRID, MAS SÃO MOSTRADOS LOGO     *}
    {* ABAIXO (NOMARQ, CTR_HIST01, CTR_HIST02)       *}
    {**********************************************AC*}
    intOrdCadRec := 0;
    intOrdCadRec := dbgDuplicatas.Columns.Items[Column.Index].Index + 3;

    {*******************************************}
    {* MOSTRA QUAL O NOME DO CAMPO INDEXADO    *}
    {****************************************AC*}
    strFieldCadRec := '';
    strFieldCadRec := qryTemporaria2.FieldList.Strings[intOrdCadRec+1];

    {**************************************************}
    {* REFAZ A CONSULTA SE O USUÁRIO QUISER ORDENA-LO *}
    {***********************************************AC*}
    pMostraDebCadRec;
  End
  Else
    intOrdCadRec := 99;

  dbgDuplicatas.SetFocus;
      
end;

procedure TfrmMostraDebCtrChq.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If intOrdCadRec <> 99 Then
  Begin
    If Column.Index = intOrdCadRec - 3 then
    Begin
      dbgDuplicatas.Canvas.Brush.Color := clInfoBk;
      dbgDuplicatas.Canvas.Font.Color  := clWindowText;
      dbgDuplicatas.Canvas.FillRect(Rect);
      dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;
end;

procedure TfrmMostraDebCtrChq.dbgChequesTitleClick(Column: TColumn);
begin
  inherited;

  If Not qryTemporaria3.IsEmpty Then
  Begin
    intOrdChq := 0;
    intOrdChq := dbgCheques.Columns.Items[Column.Index].Index + 1;

    {**************************************************}
    {* REFAZ A CONSULTA SE O USUÁRIO QUISER ORDENA-LO *}
    {***********************************************AC*}
    pMostraDebCheque;
  End
  Else
    intOrdChq := 99;

  dbgCheques.SetFocus;
      
end;

procedure TfrmMostraDebCtrChq.dbgChequesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If intOrdChq <> 99 Then
  Begin
    If Column.Index = intOrdChq -1 then
    Begin
      dbgCheques.Canvas.Brush.Color := clInfoBk;
      dbgCheques.Canvas.Font.Color  := clWindowText;
      dbgCheques.Canvas.FillRect(Rect);
      dbgCheques.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;
end;

procedure TfrmMostraDebCtrChq.btnObsDocClick(Sender: TObject);
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  inherited;

  qryGenGer := fCriaQuery(Self);

  {*****************************}
  {* CARREGA OBS DO MOVGER/X *}
  {**************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_MEN001, ';
  strSQL := strSQL + '  GER_MEN002, ';
  strSQL := strSQL + '  GER_MEN003, ';
  strSQL := strSQL + '  GER_MEN004, ';
  strSQL := strSQL + '  GER_MEN005 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP ';
  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL,'MOVGER','MOVGERX');

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;                                  
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := qryTemporaria2.FieldByName('NUMDUP').AsString;
    ParamByName('ESPDOC').AsString := qryTemporaria2.FieldByName('Esp.').AsString;
    ParamByName('CODEMP').AsString := qryTemporaria2.FieldByName('Emp.').AsString;
    Open;

    If Not IsEmpty Then
    Begin

      Try
        frmObservacao := TfrmObservacao.Create(Application);
        frmObservacao.lblMensagem.Caption := 'Observação da Duplicata: ' + qryTemporaria2.FieldByName('Nº Dupl.').AsString;
        frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN001').asString);
        frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN002').asString);
        frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN003').asString);
        frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN004').asString);
        frmObservacao.memObs.Lines.Add(FieldByName('GER_MEN005').asString);
        frmObservacao.ShowModal;

      Finally
        FreeAndNil(frmObservacao);
      End;
    End
    Else
      fMensagem('ATENÇÃO!', 'Este documento não possui observação!', ['&Ok']);

  End;

  FreeAndNil(qryGenGer);

end;

procedure TfrmMostraDebCtrChq.btnRelatorioClick(Sender: TObject);
begin
  inherited;

  frmRelCtrDebitosCliente := TfrmRelCtrDebitosCliente.Create(Application);

  If frmRelCtrDebitosCliente.ShowModal = mrOk Then
  Begin
    bChkContaCorrente    := frmRelCtrDebitosCliente.chkContaCorrente.Checked;
    bChkProduto          := frmRelCtrDebitosCliente.chkProduto.Checked;
    bChkCheque           := frmRelCtrDebitosCliente.chkCheque.Checked;

    pGeraEmail(TRUE);
  End;

  FreeAndNil(frmRelCtrDebitosCliente);
end;

end.

