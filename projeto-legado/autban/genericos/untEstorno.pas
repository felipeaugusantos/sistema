unit untEstorno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, DB,
  Menus, AppEvnts, Mask, MaskEditFocus, Uni, BitBtnLockedIncrem, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxScreenTip, cxClasses,
  dxCustomHint, cxHint;


type
  TfrmEstorno = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    edtCodBco: TEditFocus;
    edtDesBco: TEdit;
    pnlDtaCad: TPanel;
    Label2: TLabel;
    mskDtaIni1: TMaskEditFocus;
    Label3: TLabel;
    btnGerar: TBitBtnLocked;
    mskDtaEnvIni1: TMaskEditFocus;
    Label1: TLabel;
    Label4: TLabel;
    mskDtaEnvFin1: TMaskEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCodEmp: TEditFocus;
    edtNroRem: TEditFocus;
    mskDtaFin1: TMaskEditFocus;
    grbDup: TGroupBox;
    grbRem: TGroupBox;
    edtDesEmp: TEdit;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaEnvIni: TcxDateEdit;
    mskDtaEnvFin: TcxDateEdit;
    RdgPeriodo: TRadioGroup;
    HintControler: TcxHintStyleController;
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryDuplic: TUniQuery;
    FblnEnvPro: Boolean;

    FContasAPagarAPI: Boolean;

    Procedure pEstornoContasPagar;
    Procedure pEstornoContasReceber;

  public
    blnCancEnvBanco: Boolean;
    blnApenasCadRec: Boolean;
    blnApenasCadPag: Boolean;
    blnApareceDtaPg: Boolean;
    blnEstEnvSPC:    Boolean;
    strTipGer: String;
    strTipoBanco: String;

    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;
    property ContasAPagarAPI: Boolean read FContasAPagarAPI write FContasAPagarAPI;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;

var
  frmEstorno: TfrmEstorno;

implementation

uses untGerDupSel,  untfuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmEstorno.btnGerarClick(Sender: TObject);

begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If strTipGer = 'P' Then
    pEstornoContasPagar
  Else
    pEstornoContasReceber;

end;

procedure TfrmEstorno.FormShow(Sender: TObject);
begin
  inherited;
   If ((blnApenasCadRec) or (blnEstEnvSPC)) Then
   begin
     if(edtCodBco.text = 'SPC')then
     begin
       PnlTopo.Caption :='Cancelamento de Duplicatas enviadas para SPC';
     end
     Else if(edtCodBco.text = 'SER')then
     begin
       PnlTopo.Caption :='Cancelamento de Duplicatas enviadas para o Serasa';
     end
       Else if(edtCodBco.text = 'IEP')then
     begin
       PnlTopo.Caption :='Cancelamento de Duplicatas enviadas para Protesto';
     end
      Else if(edtCodBco.text = 'BOA')then
     begin
       PnlTopo.Caption :='Cancelamento de Duplicatas enviadas para o Boa Vista';
     end
     Else
     PnlTopo.Caption := 'Cancelamento de Duplicatas enviadas p/ banco - ' + edtCodBco.Text;
   end;

  if edtCodBco.Text = 'SPC' then
  begin
    if not (blnEstEnvSPC)then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).Visible := False;
    end
    Else
    Begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Data do envio para o SPC';
    End;
  end;

   If edtCodBco.Text = 'IEP' Then
  begin
    If Not(blnApenasCadRec)Then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).Visible := False;
    end
    Else
    Begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Data de envio para Protesto';
    End;
  end;

  If edtCodBco.Text = 'BOA' Then
  begin
    If Not(blnApenasCadRec)Then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).Visible := False;
    end
    Else
    Begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Data de inclusão de duplicatas em aberto/pagas no Boa Vista';
    End;
  end;

  If strTipGer = 'P' Then
  Begin
    grbRem.Visible := False;
    Self.Height := Self.Height - 69;
    pnlDtaCad.Height := 130;
    grbDup.Top:= 45;
    pSetFocus(mskDtaIni);

    rdgPeriodo.Visible := False;
    edtDesEmp.Width    := 303;
    label2.Caption     := 'Data de Cadastro:';
    label2.Left        := 7;
    mskDtaIni.Left     := 98;
    label3.Left        :=192;
    mskDtaFin.Left     :=201;

    If (blnApenasCadPag) then
    begin
      PnlTopo.Caption := 'Cancelamento de Duplicatas enviadas p/ banco - ' + edtCodBco.Text;
    end;
  End
  Else If Not blnApenasCadRec Then
  Begin
    grbRem.Visible := False;
    frmEstorno.Height := frmEstorno.Height - 68;
    pnlDtaCad.Height := 129;
    grbDup.Top:= 44;
    pSetFocus(mskDtaIni);
    If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) And Not(blnApenasCadRec) then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Data de seleção para o Serasa';
    end
    Else If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) And Not(blnApenasCadRec) then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Data de envio para o Serasa';
    end;
  End
  Else If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) Or (edtCodBco.Text = 'BOA') Then
  Begin
    grbRem.Visible := False;
    frmEstorno.Height := frmEstorno.Height - 69;
    pnlDtaCad.Height := 130;
    grbDup.Top:= 45;
    pSetFocus(mskDtaIni);
    If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) then
    begin
      TRadioButton(rdgPeriodo.Controls[2]).ShowHint := True;
      TRadioButton(rdgPeriodo.Controls[2]).Hint := 'Enviados para o Serasa';
    end;
  End
end;

procedure TfrmEstorno.pEstornoContasPagar;
  Var
    strSQL : String;

    LTotalDuplicatas: Double;
begin

  fDropTable('TMP_ATBPAG');

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_ATBPAG ';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP,CTP_PARCEL) AS CTP_NUMDUP, ';
  strSQL := strSQL + '  CTP_PARCEL, ';
  strSQL := strSQL + '  CTP_SEQBAI, ';
  strSQL := strSQL + '  CTP_SERIE_, ';
  strSQL := strSQL + '  CTP_DTAVEN, ';
  strSQL := strSQL + '  CTP_DTACAD, ';
  strSQL := strSQL + '  CTP_VALDUP, ';
  strSQL := strSQL + '  CTP_VALDUP + IFNULL(CTP_OUTENT, 0) - IFNULL(CTP_DESSUJ, 0) AS VALORTOTAL, ';
  strSQL := strSQL + '  CTP_CODEMP, ';
  strSQL := strSQL + '  CTP_CODFOR, ';
  strSQL := strSQL + '  CE.EMP_EMPATI AS EMPATI, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  CTP_OUTENT, ';
  strSQL := strSQL + '  IFNULL(CTP_DESSUJ, 0) AS CTP_VALDES, ';
  strSQL := strSQL + '  CONCAT(FOR_ENDERE," ", IFNULL(FOR_ENDNUM,"")) AS FOR_ENDCOB, ';
  strSQL := strSQL + '  FOR_BAIRRO AS FOR_BAICOB, ';
  strSQL := strSQL + '  D1.CID_NOMCID AS FOR_NOMCID, ';
  strSQL := strSQL + '  D1.CID_ESTADO AS FOR_ESTADO, ';
  strSQL := strSQL + '  FOR_C_E_P_ AS FOR_CEPCOB, ';
  strSQL := strSQL + '  CTP_HIST01, ';
  strSQL := strSQL + '  CTP_HIST02, ';
  strSQL := strSQL + '  CTP_CODVEL, ';
  strSQL := strSQL + '  PGI_PROTES AS CTP_PROTES, ';
  strSQL := strSQL + '  CTP_CODCTA, ';
  strSQL := strSQL + '  CTP_CODBAR, ';
  strSQL := strSQL + '  CTP_LINDIG, ';
  strSQL := strSQL + '  CTP_DTALIB, ';

  strSQL := strSQL + '  CTP_TIPDOC, ';
  strSQL := strSQL + '  CTP_Q_GUIA, ';
  strSQL := strSQL + '  CTP_CODREC, ';
  strSQL := strSQL + '  CTP_COMPET, ';
  strSQL := strSQL + '  CTP_BCOFOR, ';
  strSQL := strSQL + '  CTP_FORPIX, ';
  strSQL := strSQL + '  CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ';
  strSQL := strSQL + '         "AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ';
  strSQL := strSQL + '         "CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA), 14, " ")) AS CONTAFOR, ';

  strSQL := strSQL + '  IF(PGI_OUTENT IS NULL, IFNULL(CTP_OUTENT, 0), IFNULL(PGI_OUTENT, 0)) AS OUTENT, ';
  strSQL := strSQL + '  IF(CTP_DEPOSI = "N", "Boleto", "Depósito") AS DEPOSI, ';
  strSQL := strSQL + '  CADPAG.AUTOINCREM AS AUTOINCREM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + '  INNER JOIN CADPAG ON CTP_CODFOR = FOR_CODFOR AND CTP_DTAPAG IS NULL ';
  strSQL := strSQL + '  LEFT JOIN CADCID D1 ON D1.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '  LEFT JOIN BCOFOR B ON B.AUTOINCREM = CTP_BCOFOR ';
  strSQL := strSQL + '  LEFT JOIN FORPIX X ON X.AUTOINCREM = CTP_FORPIX ';
  strSQL := strSQL + '  LEFT JOIN CADEMP CE ON CE.EMP_CODEMP = CADPAG.CTP_CODEMP ';

  If blnApenasCadPag Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADPGI ON (       ';
    strSQL := strSQL + '  CTP_NUMDUP = PGI_NUMDUP     ';
    strSQL := strSQL + '  AND CTP_PARCEL = PGI_PARCEL ';
    strSQL := strSQL + '  AND CTP_CODEMP = PGI_CODEMP ';
    strSQL := strSQL + '  AND CTP_CODFOR = PGI_CODFOR ';
    strSQL := strSQL + '  AND IFNULL(CTP_SERIE_, "") = IFNULL(PGI_SERIE_, "") ';
    strSQL := strSQL + '  AND CTP_SEQBAI = PGI_SEQBAI   ) ';
  End
  Else
  Begin
    strSQL := strSQL + '  INNER JOIN CADPGI ON (      ';
    strSQL := strSQL + '  CTP_NUMDUP = PGI_NUMDUP     ';
    strSQL := strSQL + '  AND CTP_PARCEL = PGI_PARCEL ';
    strSQL := strSQL + '  AND CTP_CODEMP = PGI_CODEMP ';
    strSQL := strSQL + '  AND CTP_CODFOR = PGI_CODFOR ';
    strSQL := strSQL + '  AND IFNULL(CTP_SERIE_, "") = IFNULL(PGI_SERIE_, "") ';
    strSQL := strSQL + '  AND CTP_SEQBAI = PGI_SEQBAI   ) ';
  End;

  strSQL := strSQL + 'WHERE TRUE ';

  If blnApenasCadPag Then
  Begin
    strSQL := strSQL + '  AND CTP_DTAENV IS NOT NULL ';
    strSQL := strSQL + '  AND CTP_BCOENV = :CODBCO ';
    strSQL := strSQL + '  AND PGI_NUMDUP IS NULL ';
  End
  Else
  Begin
    strSQL := strSQL + '  AND CTP_DTAENV IS NOT NULL ';
    strSQL := strSQL + '  AND PGI_CODBCO = :CODBCO   ';
  End;

  If fCfgSis('DACPOR',  varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + ' AND (IFNULL(CTP_PORBAI, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + ' AND CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(edtCodEmp.Text)) Then
    strSQL := strSQL + ' AND CTP_CODEMP = :CODEMP ' ;

  if MatchStr(LeftStr(edtCodBco.Text,3), ['001']) then
  begin
    if FContasAPagarAPI then
    begin
      if blnApenasCadPag then
        strSQL := strSQL + ' AND CTP_CARTEI = "API" '
      else
        strSQL := strSQL + ' AND PGI_CARTEI = "API" ';
    end
    else
    begin
      if blnApenasCadPag then
        strSQL := strSQL + ' AND CTP_CARTEI = "CNAB" '
      else
        strSQL := strSQL + ' AND PGI_CARTEI = "CNAB" ' ;
    end;
  end;

  With qryDuplic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if edtCodBco.Text = 'IEP' Then
      ParamByName('CODBCO').AsString := ''
    else
      ParamByName('CODBCO').AsString := edtCodBco.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(edtCodEmp.Text)) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBPAG ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTP_MARCAD VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ATBPAG');
    Open;

    (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    If Not IsEmpty Then
    Begin
      LTotalDuplicatas := 0;

      First;
      While Not Eof Do
      Begin
        LTotalDuplicatas := LTotalDuplicatas + FieldByName('VALORTOTAL').AsFloat;
        Next;
      End;

      Try
        pCriarFormularios(TfrmGerDupSel, frmGerDupSel);

        frmGerDupSel.qryDuplic := qryDuplic;

        If Not blnApenasCadPag Then
        Begin
          frmGerDupSel.pnlTopo.Caption := 'Cancelamento de Duplicatas p/ Remessa- ' + edtDesBco.Text;
          frmGerDupSel.strLog          := 'CANC. DE DUPLICATAS PARA REMESSA';
        End
        Else
        Begin
          frmGerDupSel.pnlTopo.Caption := 'Cancelamento de Duplicatas enviada p/ banco- ' + edtDesBco.Text;
          frmGerDupSel.strLog          := 'CANC. DE DUPLICATAS ENVIADAS';
        End;

        frmGerDupSel.blnEstorno          := True;
        frmGerDupSel.btnProtesta.Visible := False;
        frmGerDupSel.strTipoBanco        := strTipoBanco;
        frmGerDupSel.ContasAPagarAPI     := FContasAPagarAPI;

        if edtCodBco.Text = 'IEP' THEN
          frmGerDupSel.strCodBco           := ''
        ELSE
          frmGerDupSel.strCodBco           := edtCodBco.Text;

        //REDIMENSIONANDO A TELA PARA APRESENTAR OS DADOS DE FORMA DE PAGAMENTO E CÓDIGO DO TED
        If (edtCodBco.Text = '237') And (strTipoBanco = '240p') Then
          frmGerDupSel.Width             := 1000;

        frmGerDupSel.strTipGer           := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
        frmGerDupSel.lblMensagem.Caption := '';
        frmGerDupSel.edtTotalDup.Text    := FloatToStrF(LTotalDuplicatas,ffNumber,15,2);
        frmGerDupSel.ShowModal;
      Finally
        FreeAndNil(frmGerDupSel);
      End;

    End
    Else
      fMensagem('','Não há dados para cancelar duplicata!',['&O K']);

  End;

end;

procedure TfrmEstorno.pEstornoContasReceber;
  Var
    strSQL,
    strSQLP,
    strAgreg : String;

    TotalDuplicatas: Double;
begin

  fDropTable('TMP_ATBREC');

  strAgreg := '';
  strSQL   := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CADREC.AUTOINCREM, ';
  strSQL := strSQL + '  CE.EMP_EMPATI AS EMPATI, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_DTAENV, ';
  strSQL := strSQL + '  CTR_STSSPC, ';
  strSQL := strSQL + '  CURRENT_TIMESTAMP AS HRAFIL, ';


  if Pos(edtCodBco.Text,'756_237_341_033_001_089_748_') > 0 then
    strSQL := strSQL + '  IF(CTR_VALDUP > 0, CTR_VALDUP, CTR_VALREC) AS CTR_VALDUP, '
  else
  if (edtCodBco.Text <> 'SPC') AND (edtCodBco.Text <> 'IEP') then
  begin
    if (edtCodBco.Text = 'SER') Or (edtCodBco.Text = 'BOA') then
      strSQL := strSQL + '  CTR_VALORI AS CTR_VALDUP, '
    else
      strSQL := strSQL + '  CTR_VALDUP, ';
  end
  else
    strSQL := strSQL + '  IF(CTR_VALDUP > 0, CTR_VALDUP, CTR_VALORI) AS CTR_VALDUP, ';

  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_CODVEL, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_FANSOB, ';
  strSQL := strSQL + '  CLI_ENDCOB, ';
  strSQL := strSQL + '  CLI_BAICOB, ';
  strSQL := strSQL + '  (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = CLI_CODCID) AS CLI_NOMCID, ';
  strSQL := strSQL + '  CLI_CEPCOB, ';
  strSQL := strSQL + '  (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = CLI_CODCID) AS CLI_ESTADO, ';
  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_CARTEI, ';
  strSQL := strSQL + '  "" AS DEPOSI, ';

  if (not blnEstEnvSPC) And (edtCodBco.Text <> 'SER') And (edtCodBco.Text <> 'BOA') Then
  Begin
    strSQL := strSQL + '  CBI_PROTES AS CTR_PROTES, '
  End
  Else
  Begin
    strSQL := strSQL + '  CTR_PROTES, ';
  End;

  strAgreg := strAgreg + '( SELECT     ';
  strAgreg := strAgreg + '    COUNT(*) ';
  strAgreg := strAgreg + '  FROM       ';
  strAgreg := strAgreg + '    CADREC R ';
  strAgreg := strAgreg + '  WHERE      ';
  strAgreg := strAgreg + '    R.CTR_CODCLI = CLI_CODCLI ';
  strAgreg := strAgreg + '    AND R.CTR_VALDUP < 0      ';
  strAgreg := strAgreg + '    AND R.CTR_DTAREC IS NULL )';

  strAgreg := ' ( ' + strAgreg + '  ) AS CTR_CREDIT ';

  strSQL := strSQL + strAgreg;
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI,';
  strSQL := strSQL + '  CADREC';
  strSQL := strSQL + ' LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR   ';
  strSQL := strSQL + ' LEFT JOIN CADEMP CE ON EMP_CODEMP = CADREC.CTR_CODEMP   ';



  If blnApenasCadRec Then
  Begin
    strSQL := strSQL + ' LEFT JOIN REMDET T ON DET_DUPLIC = CADREC.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN REMGER R ON R.AUTOINCREM = T.DET_SEQGER';
    strSQL := strSQL + '  LEFT JOIN CADCBI ON ( ';
    strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI ) ';
  End
  Else
  Begin
    if (NOT blnEstEnvSPC) Then
      strSQL := strSQL + '  ,CADCBI ';
  End;

  strSQL := strSQL + 'WHERE ';

  if (edtCodBco.Text <> 'SPC') And (edtCodBco.Text <> 'SER') And (edtCodBco.Text <> 'BOA') AND (edtCodBco.Text <> 'IEP')  then
  begin

    If edtCodBco.Text = '748' Then
    Begin
       strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND ((CBI_CODOCO="01" OR CBI_CODOCO IS NULL) OR (CBI_CODOCO="06" OR CBI_CODOCO="04" OR CBI_CODOCO="05" OR CBI_CODOCO="09" ';
       strSQL := strSQL + '   OR CBI_CODOCO="18" OR CBI_CODOCO="19" OR CBI_CODOCO="31"))) OR  ';
       strSQL := strSQL + '   (CTR_DTAREC IS NOT NULL AND (CBI_CODOCO<>"01" AND CBI_CODOCO IS NOT NULL AND CTR_SEQBAI=0)) ';
       If blnApenasCadRec Then
         strSQL := strSQL + '   OR (CTR_DTAREC IS NOT NULL AND DET_DTAREC IS NOT NULL) ';
       strSQL := strSQL + '   ) ';
    End
    Else
    Begin
       strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND ((CBI_CODOCO IN ("01","71") OR CBI_CODOCO IS NULL) OR (CBI_CODOCO="06" OR CBI_CODOCO="20" OR CBI_CODOCO="19"))) OR  ';
       strSQL := strSQL + '   (CTR_DTAREC IS NOT NULL AND (CBI_CODOCO<>"01" AND CBI_CODOCO IS NOT NULL AND CTR_SEQBAI=0)) ';
       If blnApenasCadRec Then
         strSQL := strSQL + '   OR (CTR_DTAREC IS NOT NULL AND DET_DTAREC IS NOT NULL) ';
       strSQL := strSQL + '   ) ';
    End;

  end;

  If blnApenasCadRec Then
  Begin
    If (edtCodBco.Text = 'SER') Then
    Begin
      strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI AND';
      strSQL := strSQL + '   ((CTR_DTASER IS NOT NULL AND CTR_DTASE2 IS NULL AND CTR_DTAREC IS NULL AND "TABELA" = "") ';
      strSQL := strSQL + '   OR  (CTR_DTASE2 IS NOT NULL AND CTR_DTASER IS NOT NULL AND "TABELA" = "") ';
      strSQL := strSQL + '   OR  (CTR_DTASER IS NOT NULL AND CTR_SEREXC IS NOT NULL AND "TABELA" = "DEL")) ';
      strSQL := strSQL + '  AND CTR_SEQBAI = 0 ';
    End
    Else If (edtCodBco.Text = 'BOA') Then
    Begin
      strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI AND';
      strSQL := strSQL + '   ((CTR_DTABOA IS NOT NULL OR CTR_DTABO2 IS NOT NULL AND "TABELA" = "") ';
      strSQL := strSQL + '   OR  (CTR_DTABO2 IS NOT NULL AND CTR_DTABOA IS NOT NULL AND "TABELA" = "") ';
      strSQL := strSQL + '   OR  (CTR_DTABOA IS NOT NULL AND CTR_BOAEXC IS NOT NULL AND "TABELA" = "DEL")) ';
      strSQL := strSQL + '  AND CTR_SEQBAI = 0 ';
    End
    Else If FblnEnvPro Then
    begin
      strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI AND ';
      strSQL := strSQL + '  COALESCE(CTR_DTAPRO, "") <> "" ';
    end
    else
    begin
      strSQL := strSQL + ' AND CTR_CODCLI = CLI_CODCLI';
      strSQL := strSQL + '  AND CTR_DTAENV IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_BCOENV = :CODBCO ';
    end;
  End
  Else
  Begin
    if blnEstEnvSPC Then
    begin
      strSQL := strSQL + ' CTR_DTASPC IS NOT NULL AND CTR_DTCSPC IS NULL   ';
    end
    Else If (edtCodBco.Text = 'SER') or (edtCodBco.Text = 'SPC') Or (edtCodBco.Text = 'BOA') or (FblnEnvPro) Then
    Begin
      strSQL := strSQL + '  CTR_CODCLI = CLI_CODCLI  ';

      If FblnEnvPro then
        strSQL := strSQL + '  AND (COALESCE(CBI_CODBCO, "") = "") AND (COALESCE(CTR_DTAPRO, "") = "")'
      else
        strSQL := strSQL + '  AND CBI_CODBCO = :CODBCO   ';

      strSQL := strSQL + '  AND CTR_NUMDUP = CBI_NUMDUP ';
      strSQL := strSQL + '  AND CTR_PARCEL = CBI_PARCEL ';
      strSQL := strSQL + '  AND CTR_ESPDOC = CBI_ESPDOC ';
      strSQL := strSQL + '  AND CTR_CODEMP = CBI_CODEMP ';
      strSQL := strSQL + '  AND CTR_CODCLI = CBI_CODCLI ';
    End
    Else
    Begin
      strSQL := strSQL + '  AND CTR_CODCLI = CLI_CODCLI  ';
      strSQL := strSQL + '  AND CBI_CODBCO = :CODBCO   ';
      strSQL := strSQL + '  AND CTR_NUMDUP = CBI_NUMDUP ';
      strSQL := strSQL + '  AND CTR_PARCEL = CBI_PARCEL ';
      strSQL := strSQL + '  AND CTR_ESPDOC = CBI_ESPDOC ';
      strSQL := strSQL + '  AND CTR_CODEMP = CBI_CODEMP ';
      strSQL := strSQL + '  AND CTR_CODCLI = CBI_CODCLI ';
    End;
  End;

  If fCfgSis('DACPOR',  varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + ' AND (IFNULL(CTR_PORBAI, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If edtCodBco.Text = '001' Then
  Begin
    If edtDesBco.Text  = 'Brasil' Then
      strSQL := strSQL +   'AND CTR_CARTEI LIKE "%CONF%001-%" '
    Else If edtDesBco.Text  = 'Brasil7d' Then
      strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONF%D7%" ';
  End
  Else If edtDesBco.Text  = 'Caixa Federal 400p' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONF%4P400%" '
  Else If edtDesBco.Text = 'Caixa Federal' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONF%104-%" '

  Else If edtDesBco.Text  = 'Santander[240p]' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONF%3B240p%" '
  Else If edtDesBco.Text = 'Santander' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONF%033B-%" '

  Else If edtDesBco.Text  = 'Bancoob' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CON%756-%" '
  Else If edtDesBco.Text  = 'Bancoob(240p)' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CON%756%240p-%" '
  Else If edtDesBco.Text = 'Bradesco(240p_Vendor)' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "CONF%237%VEN%-%" '
  Else If edtDesBco.Text = 'Bradesco' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "CON%237-%" '
  Else If edtDesBco.Text = 'Unicred' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CON%090-%" '
  Else If edtDesBco.Text = 'Unicred (400p)' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CONFIG090_400p%" '
  Else If edtDesBco.Text = 'Sicredi' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CON%748-%" '
  Else If edtDesBco.Text = 'Sicredi [240p]' Then
    strSQL := strSQL +  ' AND CTR_CARTEI LIKE "%CON%748_%" ';

  If Not fEmptyStr(edtNroRem.Text) Then
    strSQL := strSQL + '  AND R.GER_NROREM = :NROREM ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  begin

      If(RdgPeriodo.ItemIndex = 0) Then
      begin
        strSQL := strSQL + ' AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
      end

      Else If(RdgPeriodo.ItemIndex = 1) Then
      begin
        strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
      end

      Else If(RdgPeriodo.ItemIndex = 2) Then
      begin
        If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) And Not(blnApenasCadRec) then
        Begin
          strSQL := strSQL + ' AND CBI_DTASER BETWEEN :DTAINI AND :DTAFIN ';
        End
        Else If ((edtDesBco.Text = 'Serasa') And (edtCodBco.Text = 'SER')) And (blnApenasCadRec) then
        Begin
          strSQL := strSQL + ' AND (CTR_DTASER BETWEEN :DTAINI AND :DTAFIN OR CTR_DTASE2 BETWEEN :DTAINI AND :DTAFIN OR CTR_SEREXC BETWEEN :DTAINI AND :DTAFIN) ';
        End
        Else If (blnEstEnvSPC) And (edtCodBco.Text = 'SPC') then
        begin
          strSQL := strSQL + ' AND CTR_DTASPC BETWEEN :DTAINI AND :DTAFIN ';
        end
        Else If (blnApenasCadRec) And (edtCodBco.Text = 'IEP') then
        begin
          strSQL := strSQL + ' AND CTR_DTAPRO BETWEEN :DTAINI AND :DTAFIN ';
        end
         Else If (blnApenasCadRec) And (edtCodBco.Text = 'BOA') then
        begin
          strSQL := strSQL + ' AND (CTR_DTABOA BETWEEN :DTAINI AND :DTAFIN OR CTR_DTABO2 BETWEEN :DTAINI AND :DTAFIN) ';
        end
        Else
          strSQL := strSQL + ' AND CTR_DTAENV BETWEEN :DTAINI AND :DTAFIN ';
      end;
  end;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaEnvIni.Text)) Then
    strSQL :=  strSQL + ' AND R.GER_DTACAD BETWEEN :ENVINI AND :ENVFIN ';

  If blnCancEnvBanco Then
  Begin
    strSQL := strSQL + '  AND CBI_NUMDUP IS NULL ';
    strSQL := strSQL + '  AND CBI_PARCEL IS NULL ';
    strSQL := strSQL + '  AND CBI_ESPDOC IS NULL ';
    strSQL := strSQL + '  AND CBI_CODEMP IS NULL ';
    strSQL := strSQL + '  AND CBI_CODCLI IS NULL ';
  End;

  strSQLP := strSQL;

  if (edtCodBco.Text = 'SPC') then
  begin
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC');
    strSQL := ' SELECT * FROM ( ' + strSQL + ') AS TABELA GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI ';
  end;

  If (edtCodBco.Text = 'SER') Or (edtCodBco.Text = 'BOA') Then
  Begin
    strSQLP := AnsiReplaceStr(strSQLP,'CADREC','DEL_CADREC');
    strSQLP := AnsiReplaceStr(strSQLP,'TABELA','DEL');
    strSQL  := AnsiReplaceStr(strSQL,'TABELA','');
    strSQL  := strSQL + ' UNION ALL ' + strSQLP;
  End;

  if (FblnEnvPro) or (edtCodBco.Text = '341') then
    strSQL := strSQL + ' GROUP BY AUTOINCREM ';

  strSQL :=  'CREATE TEMPORARY TABLE TMP_ATBREC ' + strSQL ;

  With (qryDuplic) Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If ((blnApenasCadRec) And (edtCodBco.Text <> 'SER') And (edtCodBco.Text <> 'BOA') And (edtCodBco.Text <> 'IEP')) Or
       ((Not blnApenasCadRec) And (Not blnEstEnvSPC) And (Not FblnEnvPro)) Then
    Begin
      ParamByName('CODBCO').AsString := edtCodBco.Text;
    End;

    If Not fEmptyStr(edtNroRem.Text) Then
      ParamByName('NROREM').AsString := edtNroRem.Text;


    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not fEmptyStr (fTiraCaracEspeciais(mskDtaEnvIni.Text)) Then
    Begin
      ParamByName('ENVINI').AsDateTime := StrToDateTime(mskDtaEnvIni.Text);
      ParamByName('ENVFIN').AsDateTime := StrToDateTime(mskDtaEnvFin.Text);
    End;

    ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_MARCAD VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_CODCAR INT ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ATBREC');

    Open;

    (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    If Not IsEmpty Then
    Begin
      TotalDuplicatas := 0;

      First;
      While Not Eof Do
      Begin
        TotalDuplicatas := TotalDuplicatas + FieldByName('CTR_VALDUP').AsFloat;
        Next;
      End;

      Try
        pCriarFormularios(TfrmGerDupSel,frmGerDupSel);

        frmGerDupSel.qryDuplic := qryDuplic;

        if edtCodBco.Text = 'SPC' then
        begin
          frmGerDupSel.pnlTopo.Caption := 'Cancelamento de Duplicatas p/ Remessa - SPC ' + edtDesBco.Text;
          frmGerDupSel.strLog          := 'CANC. DE DUPLICATAS PARA REMESSA';
        end
        else
        begin
          If Not blnApenasCadRec Then
          begin
            frmGerDupSel.pnlTopo.Caption := 'Cancelamento de Duplicatas p/ Remessa - ' + edtDesBco.Text;
            frmGerDupSel.Caption         := 'Cancelamento de Duplicatas p/ Remessa - ' + edtDesBco.Text;
            frmGerDupSel.strLog          := 'CANC. DE DUPLICATAS PARA REMESSA';
            frmGerDupSel.blnApenasCadRec := False;
          end
          else
          begin
            frmGerDupSel.pnlTopo.Caption := 'Cancelamento de Duplicatas enviada p/ banco - ' + edtDesBco.Text;
            frmGerDupSel.Caption         := 'Cancelamento de Duplicatas enviada p/ banco - ' + edtDesBco.Text;
            frmGerDupSel.strLog          := 'CANC. DE DUPLICATAS ENVIADAS ';
            frmGerDupSel.blnApenasCadRec := True;
          end;
        end;

        IF edtCodBco.Text = 'IEP' then
          frmGerDupSel.strCodBco           := ''
        ELSE
          frmGerDupSel.strCodBco           := edtCodBco.Text;

        frmGerDupSel.blnEstorno          := True;
        frmGerDupSel.btnProtesta.Visible := False;

        if (edtCodBco.Text <> 'SPC') And (edtCodBco.Text <> 'SER') And (edtCodBco.Text <> 'BOA') And (edtCodBco.Text <> 'IEP') then
        begin
          frmGerDupSel.Label6.Visible := False;
          frmGerDupSel.Shape1.Visible := False;
          frmGerDupSel.Label8.Visible := False;
          frmGerDupSel.gpbLegenda.Width := 133;
        end;

        frmGerDupSel.blnEnvPro           := FblnEnvPro;
        frmGerDupSel.lblMensagem.Caption := '';
        frmGerDupSel.blnEstEnvSPC        := blnEstEnvSPC;
        frmGerDupSel.strTipGer           := 'R';
        frmGerDupSel.edtTotalDup.Text    := FloatToStrF(TotalDuplicatas,ffNumber,15,2);
        frmGerDupSel.ShowModal;
      Finally
        FreeAndNil(frmGerDupSel);
      End;

    End
    Else
      fMensagem('','Não há dados para cancelar duplicata!',['&O K']);

  End;

end;

procedure TfrmEstorno.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmp.Text) Then
    edtDesEmp.Text := 'TODOS'
  Else
    edtDesEmp.Text := fRetNomeEmpresa(fStrZero(edtCodEmp.Text,3));

  If fEmptyStr(edtDesEmp.Text) And (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    fMensagem('','Código da empresa não encontrado.',['&O K']);
    pSetFocus(edtCodEmp);
  End;
end;

procedure TfrmEstorno.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RG*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, Nil, Nil, Key, arrEmp) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmEstorno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fDropTable('TMP_ATBPAG');
  fDropTable('TMP_ATBREC');
end;

procedure TfrmEstorno.FormCreate(Sender: TObject);
begin
  inherited;
  qryDuplic := fCriaQuery(Self);
  FblnEnvPro := False;

  FContasAPagarAPI := False;
end;

function TfrmEstorno.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));
      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End;

    {*******************************}
    {******** DTA VENCIMEN. ********}
    {*******************************}

    If (Sender = mskDtaEnvIni) Then
    Begin
      mskDtaEnvFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaEnvIni.Text));
      If Not mskDtaEnvFin.Enabled Then
        mskDtaEnvFin.Clear;
    End

    Else If (Sender = mskDtaEnvFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaEnvIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaEnvFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Envio final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaEnvIni.Text,mskDtaEnvFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Envio final deve ser maior ou igual a Data de Envio Inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

