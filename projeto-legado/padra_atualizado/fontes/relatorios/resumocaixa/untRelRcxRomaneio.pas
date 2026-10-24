unit untRelRcxRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelRcxRomaneio = class(TfrmPaiRelatorio)
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtRomaneio: TEditFocus;
    Label1: TLabel;
    lblDesDtaIni: TLabel;
    Label2: TLabel;
    procedure edtRomaneioKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  function fVerificaRomaneio(strNumRom: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelRcxRomaneio: TfrmRelRcxRomaneio;

implementation

uses untfuncoesSimples, untPai, untModuloSPR, untQckRcxRomaneio, untTypesSistema,
     untConsultas, Data.DB;

{$R *.dfm}

procedure TfrmRelRcxRomaneio.edtRomaneioKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel   : TConsultasArray;
    chrKey   : Char;

begin
  inherited;

  qryConGen := fCriaQuery;

  chrKey := '/';

  If fPesqRomaneio(Self, edtRomaneio, qryConGen, chrKey, arrSel, 'CADRCXX') Then
  Begin
    edtRomaneio.Text := qryConGen.FieldByName('GER_NUMROM').AsString;
    If (fValidaCampos(edtRomaneio, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
  
  FreeAndNil(qryConGen);
end;

procedure TfrmRelRcxRomaneio.FormCreate(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

function TfrmRelRcxRomaneio.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    {*********************}
    {* VALIDA ROMANEIO   *}
    {******************RL*}
    Else If (Sender = edtRomaneio) Then
    Begin

      If (Not fEmptyStr(edtRomaneio.Text)) Then
      Begin

        If (Not fVerificaRomaneio(edtRomaneio.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não existem recebimento deste romaneio '+ edtRomaneio.Text + ' para o resumo de caixa!', ['&Ok']);
          Result := False;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelRcxRomaneio.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;
  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(RCX_NUMDOC,RCX_PARCEL) AS NUMDOC, ';
    strSQL := strSQL + '  RCX_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  RCX_DINREC AS DINHEI, ';
    strSQL := strSQL + '  RCX_CHQAVI AS CHQAVI, ';
    strSQL := strSQL + '  RCX_CHQPRE AS CHQPRE, ';
    strSQL := strSQL + '  RCX_CARREC AS CARREC, ';
    strSQL := strSQL + '  RCX_VALFIN AS VALFIN, ';
    strSQL := strSQL + '  RCX_VALDOC AS VALDOC, ';
    strSQL := strSQL + '  IFNULL(RCX_DINREC, 0)   + ';
    strSQL := strSQL + '    IFNULL(RCX_CHQAVI, 0) + ';
    strSQL := strSQL + '    IFNULL(RCX_CHQPRE, 0) + ';
    strSQL := strSQL + '    IFNULL(RCX_CARREC, 0) + ';
    strSQL := strSQL + '    IFNULL(RCX_VALFIN, 0) AS TOTALREG, ';
    strSQL := strSQL + '  RCX_NUMROM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX, CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
    strSQL := strSQL + '  AND RCX_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  AND RCX_ESPDOC <> "FC" ';
    strSQL := strSQL + '  AND RCX_JURDES = "" ';

    If Not fEmptyStr(edtRomaneio.Text) Then
      strSQL := strSQL + ' AND RCX_NUMROM = :GER_NUMROM '
    Else
      strSQL := strSQL + ' AND (RCX_NUMROM IS NOT NULL AND RCX_NUMROM <> "") ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '  RCX_NUMROM, ESPDOC, NUMDOC ';

    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtRomaneio.Text) Then
        ParamByName('GER_NUMROM').AsString := Trim(edtRomaneio.Text);

      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckRcxRomaneio,frmQckRcxRomaneio);

        frmQckRcxRomaneio.dtaDtaIni := StrToDate(mskDtaIni.Text);
        If (fEmptyStr(edtRomaneio.Text)) Then
          frmQckRcxRomaneio.rllRomaneio.Caption := 'ROMANEIO: TODOS'
        Else
          frmQckRcxRomaneio.rllRomaneio.Caption := 'ROMANEIO: ' + edtRomaneio.Text;

        frmQckRcxRomaneio.strOrdem  := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        frmQckRcxRomaneio.rllNomeRelatorio.Caption := 'RELATÓRIO DE ROMANEIO';

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frmQckRcxRomaneio.qckPagina, frmQckRcxRomaneio.rpsSetup)
        Else
          pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckRcxRomaneio.qckPagina);

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmRelRcxRomaneio.btnImprimirClick]');
        End;
      End;
      pFreeAndNil(frmQckRcxRomaneio);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  pSetFocus(mskDtaIni);
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelRcxRomaneio.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

function TfrmRelRcxRomaneio.fVerificaRomaneio(
  strNumRom: String): Boolean;
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;

begin
  Try

    qryGenRcx := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_NUMROM = ' + QuotedStr(Trim(edtRomaneio.Text)) + ' AND ';
    strSQL := strSQL + '  RCX_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    With qryGenRcx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenRcx);
  End;

end;


end.

