unit untRelFiscTermoAbert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel, DB,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, WinSpool, AppEvnts,
  BitBtnLockedIncrem, untFuncoesGenerica, frxExportCSVTestabilidade,
  strUtils, frxRich;

type
  TfrmRelFiscTermoAbert = class(TfrmPaiRelatorio)
    gpbOpcao: TGroupBox;
    rdbEntrada: TRadioButton;
    rdbSaida: TRadioButton;
    rdbInventario: TRadioButton;
    rdbNota: TRadioButton;
    gpbNota: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    gpbEntSaiInv: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskDtaEnv: TMaskEditFocus;
    mskDtaUltNot: TMaskEditFocus;
    edtFolIni: TEditFocus;
    edtFolFin: TEditFocus;
    edtNroLivro: TEditFocus;
    edtNotaIni: TEditFocus;
    edtNotaFin: TEditFocus;
    frxPaginaM: TfrxReport;
    frxPaginaJ: TfrxReport;
    procedure rdbEntradaClick(Sender: TObject);
    procedure rdbSaidaClick(Sender: TObject);
    procedure rdbInventarioClick(Sender: TObject);
    procedure rdbNotaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FPais: TPais;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFiscTermoAbert: TfrmRelFiscTermoAbert;

implementation



{$R *.dfm}

uses untFuncoesSimples, untIFuncoes, untValorPorExtenso;

function TfrmRelFiscTermoAbert.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {************************************}
    {* VALIDA A DATA INICIAL            *}
    {*********************************LU*}
    If (Sender = mskDtaIni) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('AVISO','O Campo Data Inicial deve ser preenchido!',['&O K']);
        Result := False;
      End;

      If Result Then
        TMaskEditFocus(Sender).Text := FormatDateTime('dd/mm/yyyy', strToDate(TMaskEditFocus(Sender).Text));
    End
    Else
    {************************************}
    {* VALIDA A DATA FINAL              *}
    {*********************************LU*}
    If (Sender = mskDtaFin) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('AVISO','O Campo Data Final deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      {**************************************************}
      {* VERIFICA SE A DATA FINAL E MENOR QUE A INICIAL *}
      {***********************************************LU*}
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('AVISO','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;

      If Result Then
        TMaskEditFocus(Sender).Text := FormatDateTime('dd/mm/yyyy', strToDate(TMaskEditFocus(Sender).Text));
    End

    {************************************}
    {* VALIDA A NOTA INICIAL            *}
    {*********************************LU*}
    Else
    If (Sender = edtNotaIni) And (rdbNota.Checked) Then
    Begin
      If fEmptyStr(edtNotaIni.Text) Then
      Begin
        fMensagem('AVISO','O Campo Nota Inicial deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else
    {************************************}
    {* VALIDA A NOTA FINAL              *}
    {*********************************LU*}
    If (Sender = edtNotaFin) And (rdbNota.Checked) Then
    Begin
      If fEmptyStr(edtNotaFin.Text) Then
      Begin
        fMensagem('AVISO','O Campo Nota Final deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      {**************************************************}
      {* VERIFICA SE A NOTA FINAL É MENOR QUE A INICIAL *}
      {***********************************************LU*}
      If StrToInt(edtNotaIni.Text) > StrToInt(edtNotaFin.Text) Then
      Begin
        fMensagem('AVISO','O Número da Nota Inicial deve ser menor que o Número da Nota Final!',['&O K']);
        Result := False;
      End;

    End

    {************************************}
    {* VALIDA A FOLHA INICIAL           *}
    {*********************************LU*}
    Else
    If (Sender = edtFolIni) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(edtFolIni.Text) Then
      Begin
        fMensagem('AVISO','O Campo Folha Inicial deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else
    {************************************}
    {* VALIDA A NOTA FINAL              *}
    {*********************************LU*}
    If (Sender = edtFolFin) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(edtFolFin.Text) Then
      Begin
        fMensagem('AVISO','O Campo Folha Final deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      {***************************************************}
      {* VERIFICA SE A FOLHA FINAL É MENOR QUE A INICIAL *}
      {************************************************LU*}
      If StrToInt(edtFolIni.Text) > StrToInt(edtFolFin.Text) Then
      Begin
        fMensagem('AVISO','O Número da Folha Inicial deve ser menor que o Número da Folha Final!',['&O K']);
        Result := False;
      End;
    End

    {************************************}
    {* VALIDA A DATA DE ENVIO           *}
    {*********************************LU*}
    Else
    If (Sender = mskDtaEnv) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnv.Text)) Then
      Begin
        fMensagem('AVISO','O Campo Data de Envio deve ser preenchido!',['&O K']);
        Result := False;
      End;
      If Result Then
        TMaskEditFocus(Sender).Text := FormatDateTime('dd/mm/yyyy', strToDate(TMaskEditFocus(Sender).Text));
    End

    {************************************}
    {* VALIDA A DATA DA ULTIMA NOTA     *}
    {*********************************LU*}
    Else
    If (Sender = mskDtaUltNot) And (rdbNota.Checked) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaUltNot.Text)) Then
      Begin
        fMensagem('AVISO','O Campo Data da Última Nota deve ser preenchido!',['&O K']);
        Result := False;
      End;
      If Result Then
        TMaskEditFocus(Sender).Text := FormatDateTime('dd/mm/yyyy', strToDate(TMaskEditFocus(Sender).Text));
    End

    {************************************}
    {* VALIDA O NUMERO DO LIVRO         *}
    {*********************************LU*}
    Else
    If (Sender = edtNroLivro) And (Not rdbNota.Checked) Then
    Begin
      If fEmptyStr(edtNroLivro.Text) Then
      Begin
        fMensagem('AVISO','O Campo Número do Livro deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;

  End;

end;

procedure TfrmRelFiscTermoAbert.rdbEntradaClick(Sender: TObject);
begin
  inherited;
  If rdbEntrada.Checked Then
  Begin
    gpbEntSaiInv.Visible := True;
    gpbNota.Visible := False;
  End;
end;

procedure TfrmRelFiscTermoAbert.rdbSaidaClick(Sender: TObject);
begin
  inherited;
  If rdbSaida.Checked Then
  Begin
    gpbEntSaiInv.Visible := True;
    gpbNota.Visible := False;
  End;
end;

procedure TfrmRelFiscTermoAbert.rdbInventarioClick(Sender: TObject);
begin
  inherited;
  If rdbInventario.Checked Then
  Begin
    gpbEntSaiInv.Visible := True;
    gpbNota.Visible := False;
  End;
end;

procedure TfrmRelFiscTermoAbert.rdbNotaClick(Sender: TObject);
begin
  inherited;
  If rdbNota.Checked Then
  Begin
    gpbEntSaiInv.Visible := False;
    gpbNota.Visible := True;
  End;
end;

procedure TfrmRelFiscTermoAbert.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(rdbEntrada);
end;

procedure TfrmRelFiscTermoAbert.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
end;

procedure TfrmRelFiscTermoAbert.FormShow(Sender: TObject);
begin
  inherited;

  rdbEntradaClick(Sender);

end;

procedure TfrmRelFiscTermoAbert.btnImprimirClick(Sender: TObject);
Var
  qryGeral : TUniQuery;
  strModelo: String;
  strTitulo: String;
  strSQL   : String;
  strData  : String;
  intQtdFol: Integer;
  strNumFol: String;
  frxPagina: TfrxReport;
begin
  inherited;
   pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
    strSQL := strSQL + '   CID_NOMCID AS NOMCID, ';
    strSQL := strSQL + '   CID_ESTADO AS ESTADO, ';
    strSQL := strSQL + '   EMP_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS ENDERE, ';
    strSQL := strSQL + '   EMP_C_G_C_ AS CGC, ';
    strSQL := strSQL + '   EMP_I_E_S_ AS IES, ';
    strSQL := strSQL + '   EMP_JUCESP AS JUCESP, ';
    strSQL := strSQL + '   EMP_DTADSP AS DTADSP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   LEFT JOIN CADCID ON (EMP_CODCID = CID_CODCID) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';

    qryGeral := fCriaQuery(Self);
    qryGeral.Sql.Add(strSQL);
    qryGeral.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGeral.Open;

    qryGeral.Edit;
    qryGeral.FieldByName('CGC').AsString  := fFormataCpfCgc(qryGeral.FieldByName('CGC').AsString, FPais);
    qryGeral.Post;

    frxRelatorio.DataSet := qryGeral;

    If strTipImp = 'M' Then
      frxPagina := frxPaginaM
    Else
      frxPagina := frxPaginaJ;

    strModelo := '';  
    If (rdbNota.Checked) Then
    Begin
      intQtdFol := StrToIntDef(edtNotaFin.Text,0) - StrToIntDef(edtNotaIni.Text,0) + 1;
      strData   := mskDtaUltNot.Text;
      strTitulo := 'REGISTRO DE NOTAS FISCAIS';
    End
    Else
    Begin
      intQtdFol := StrToIntDef(edtFolFin.Text,0) - StrToIntDef(edtFolIni.Text,0) + 1;

      If rdbEntrada.Checked Then
      Begin
        strModelo := 'P 1-A';
        strTitulo := 'REGISTRO DE APURAÇÃO DE ICMS - ENTRADAS';
      End;

      If rdbSaida.Checked Then
      Begin
        strModelo := 'P 2-A';
        strTitulo := 'REGISTRO DE APURAÇÃO DE ICMS - SAÍDAS';
      End;

      If rdbInventario.Checked Then
      Begin
        strModelo := 'P 7';
        strTitulo := 'REGISTRO DE INVENTÁRIO FÍSICO';
      End;

      strModelo := '(MODELO ' + strModelo + ')';  

      strData   := mskDtaEnv.Text;
    End;
    strNumFol := Trim(AnsiReplaceStr(AnsiReplaceStr(fRetExtensoNumero(inttoStr(intQtdFol)), 'REAL', ''), 'REAIS', ''));
    
    frxPagina.Script.Variables['MODELO'] := strModelo;
    frxPagina.Script.Variables['TITULO'] := strTitulo;
    frxPagina.Script.Variables['LIVRO']  := edtNroLivro.Text;
    frxPagina.Script.Variables['INTPAG'] := fStrZero(IntToStr(intQtdFol),3);
    frxPagina.Script.Variables['STRPAG'] := strNumFol;
    frxPagina.Script.Variables['PAGINI'] := fStrZero(edtFolIni.Text, 3);
    frxPagina.Script.Variables['PAGFIN'] := fStrZero(edtFolFin.Text, 3);
    frxPagina.Script.Variables['DTAINI'] := mskDtaIni.Text;
    frxPagina.Script.Variables['DTAFIN'] := mskDtaFin.Text;
    frxPagina.Script.Variables['DTAASS'] := qryGeral.fieldbyname('NOMCID').asString + ', ' + UpperCase(FormatDateTime('DD "de" MMMM "de" YYYY' , StrToDate(strData)));

    frxPagina.Script.Variables['BLNNOTFIS'] := rdbNota.Checked;
    frxPagina.Script.Variables['SERIE_']    := fCfgSis('SERFSC');
    frxPagina.Script.Variables['NOTINI']    := edtNotaIni.Text;
    frxPagina.Script.Variables['NOTFIN']    := edtNotaFin.Text;

    If edtDestino.Text = 'V' Then
    Begin
      pPreviewReport(Self.Name, Self.Caption, frxPagina);
    End
    Else
    Begin
      If frxPagina.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxPagina);
    End;

  End;

  FreeAndNil(qryGeral);

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

end.

