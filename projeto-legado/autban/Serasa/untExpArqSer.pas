unit untExpArqSer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, UniDataSetProvider, UniClientDataSet,
  ComboBoxFocus, untTBoaVista, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqSer = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    rdgTipArq: TRadioGroup;
    cmbPeriodo: TComboBoxFocus;
    lblPeriodo: TLabel;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objConfBoa : TConfBoaVista;
    objBoaVista: TBoaVista;
    function fDefineIndicadorPeriodo: String;
  public
    { Public declarations }
    strCodBco: String;

    function fGeraArquivoSerasa(Path, Arquivo: String):Boolean;
    function fVerificaTipoCli(dataCadastro: TDate): Integer;
    function fCorrigeValorDuplicata(valor: double; opcao: Integer): String;
  end;

var
  frmExpArqSer: TfrmExpArqSer;

implementation

uses untFuncoesSimples,
  untGeraArqSerasa, DB,  StrUtils, untConstantes, untFuncoes;

{$R *.dfm}

function TfrmExpArqSer.fGeraArquivoSerasa(Path, Arquivo: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    qryAux: TUniQuery;
    cdsDup: TUniClientDataSet;
    pvdDup: TUniDataSetProvider;
    mArquivo: TStringList;

    intCont1: Integer;

    strHeader: String;
    strDetalhe: String;
    strDups: String;
    strTrailler: String;

    intQTDCLI: Integer;
    intQTDDUP: Integer;

    intTipocli: Integer;

    strNumDup: String;
    strCGCDUP: String;
    strDTACAD: String;
    strVALDUP: String;
    strDTAVEN: String;
    strDTAREC: String;
    strKEYDUP: String;

    dataInicio, dataFim: TDate;

    strIndicadorPeriodo: String;
Begin
  Result := False;
  If fEmptyStr(Path) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve informar o diretório para gerar o arquivo para exportação!', ['&O K ']);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  If fEmptyStr(Arquivo) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve informar o nome do arquivo para exportação!', ['&O K']);
    pSetFocus(edtNomArquivo);
    Exit;
  End;

  mArquivo  := nil;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CBI_DTAINI, ';
    strSQL := strSQL + '   CBI_DTAFIN, ';
    strSQL := strSQL + '   CBI_CODCLI, ';
    strSQL := strSQL + '   CLI_STATUS, ';
    strSQL := strSQL + '   CLI_DTACAD, ';
    strSQL := strSQL + '   REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_ ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + '   LEFT JOIN CADCBI ON CLI_CODCLI = CBI_CODCLI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CBI_CODBCO = "SER" ';
    strSQL := strSQL + ' GROUP BY CBI_CODCLI  ';
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   CBI_DTAINI, CBI_DTAFIN ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      FreeAndNil(qryGen);
      Exit;
    End;

    qryGen.First;
    dataInicio  := qryGen.FieldByName('CBI_DTAINI').AsDateTime;
    qryGen.Last;
    dataFim     := qryGen.FieldByName('CBI_DTAFIN').AsDateTime;

    strIndicadorPeriodo := fDefineIndicadorPeriodo;

    {*******************************************}
    {* HEADER                                  *}
    {****************************************PH*}

    strHeader := '';
    strHeader := '00'                                                                                              + // 001 a 002
                 fPadR('RELATO COMP NEGOCIOS'                                           , 20)                      + // 003 a 022
                 fPadR(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fCadEmp('C_G_C_'),'.',''),'/',''),'-',''), 14) + // 023 a 036
                 FormatDateTime('yyyymmdd', dataInicio)                                                            + // 037 a 044
                 FormatDateTime('yyyymmdd', dataFim)                                                               + // 045 a 052
                 strIndicadorPeriodo                                                                               + // 053 a 053
                 fPadR(' ', 15)                                                                                    + // 054 a 068
                 fPadR(' ', 03)                                                                                    + // 069 a 071
                 fPadR(' ', 29)                                                                                    + // 072 a 100
                 'V.'                                                                                              + // 101 a 102
                 '01'                                                                                              + // 103 a 104
                 fPadR(' ', 26)                                                                                    ; // 105 a 130

    {*******************************************}
    {* Detalhe                                 *}
    {****************************************PH*}
    strDetalhe := '';

    qryGen.First;

    For intCont1 := 1 to qryGen.RecordCount Do
    Begin

      If qryGen.FieldByName('CLI_STATUS').AsString = 'I' Then
        intTipocli := 3
      Else
        intTipocli := fVerificaTipoCli(qryGen.FieldByName('CLI_DTACAD').AsDateTime);

      strDetalhe := strDetalhe + '01'                                                                                                                      + // 001 a 002
                                 fPadR(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(qryGen.FieldByName('CLI_C_G_C_').AsString,'.',''),'/',''),'-',''), 14) + // 003 a 016
                                 '01'                                                                                                                      + // 017 a 018
                                 FormatDateTime('yyyymmdd', qryGen.FieldByName('CLI_DTACAD').AsDateTime)                                                   + // 019 a 026
                                 IntToStr(intTipocli)                                                                                                      + // 027 a 027
                                 fPadR(' ', 38)                                                                                                            + // 028 a 065
                                 fPadR(' ', 34)                                                                                                            + // 066 a 099
                                 fPadR(' ', 01)                                                                                                            + // 100 a 100
                                 fPadR(' ', 30)                                                                                                            + // 101 a 130
                                 #13                                                                                                                       ;

      qryGen.Next;
    End;
    intQTDCLI := qryGen.RecordCount;

    FreeAndNil(qryGen);

    {*******************************************}
    {*DUPLICADAS / TITULOS                     *}
    {****************************************PH*}

    strSQL := '';
    strSQL := strSQL + ' SELECT B.*,  ';
    strSQL := strSQL + '        C.CLI_C_G_C_, ';
    strSQL := strSQL + '        R.CTR_SEQBAI, ';
    strSQL := strSQL + '        R.CTR_DTAREC  ';
    strSQL := strSQL + ' FROM CADCBI B ';
    strSQL := strSQL + '   JOIN CADREC R ON B.CBI_NUMDUP = R.CTR_NUMDUP AND ';
    strSQL := strSQL + '                         B.CBI_PARCEL = R.CTR_PARCEL AND ';
    strSQL := strSQL + '                         B.CBI_ESPDOC = R.CTR_ESPDOC AND ';
    strSQL := strSQL + '                         B.CBI_CODEMP = R.CTR_CODEMP AND ';
    strSQL := strSQL + '                         B.CBI_CODCLI = R.CTR_CODCLI AND ';
    strSQL := strSQL + '                         R.CTR_SEQBAI = 0                ';
    strSQL := strSQL + '   JOIN CADCLI C ON B.CBI_CODCLI = C.CLI_CODCLI     ';
    strSQL := strSQL + ' WHERE B.CBI_CODBCO = "SER" ';

    {************************}
    {* ICLUSÕES E EXCLUSÕES *}
    {*********************JU*}
    If rdgTipArq.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'R.CTR_DTAREC', '(R.DTADEL) AS CTR_DTAREC'),'CADREC', 'DEL_CADREC');
    End
    {*************}
    {* ICLUSÕES  *}
    {**********JU*}
    Else If rdgTipArq.ItemIndex = 1 Then
    Begin
      strSQL := strSQL + ' AND B.CBI_STSSER = "I" ';
    End
    {*************}
    {* EXCLUSÕES *}
    {**********JU*}
    Else If rdgTipArq.ItemIndex = 2 Then
    Begin
      strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'R.CTR_DTAREC', '(R.DTADEL) AS CTR_DTAREC'),'CADREC', 'DEL_CADREC');
      strSQL := strSQL + ' AND B.CBI_STSSER = "E" ';
    End;

    strSQL := strSQL + ' ORDER BY CBI_CODCLI, CBI_NUMDUP ';

    qryAux := fCriaQuery;

    cdsDup := TUniClientDataSet.Create(Self);
    pvdDup := TUniDataSetProvider.Create(Self);
    pvdDup.DataSet := qryAux;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.Open;
    pSetaClient(qryAux);

    cdsDup.Close;
    cdsDup.SetProvider(pvdDup);
    cdsDup.Open;
    cdsDup.First;
    FreeAndNil(qryAux);

    intQTDDUP := cdsDup.RecordCount;

    strDups := '';

    While Not cdsDup.Eof do
    begin
        strNumDup := RightStr(cdsDup.FieldByName('CBI_NUMDUP').AsString, 10);
        strCGCDUP := fPadR(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(cdsDup.FieldByName('CLI_C_G_C_').AsString,'.',''),'/',''),'-',''), 14);
        strDTACAD :=  FormatDateTime('yyyymmdd', cdsDup.FieldByName('CBI_DTACAD').AsDateTime);
        strVALDUP := fCorrigeValorDuplicata(cdsDup.fieldByName('CBI_VALDUP').AsFloat, IIF(cdsDup.FieldByName('CBI_STSSER').AsString = 'I', 1, 2));
        strDTAVEN := FormatDateTime('yyyymmdd', cdsDup.FieldByName('CBI_DTAVEN').AsDateTime);

        If cdsDup.FieldByName('CBI_DTADEV').AsDateTime > 0 Then
          strDTAREC := FormatDateTime('yyyymmdd', cdsDup.FieldByName('CBI_DTADEV').AsDateTime)
        Else
        If cdsDup.FieldByName('CTR_DTAREC').AsDateTime > 0 Then
          strDTAREC := FormatDateTime('yyyymmdd', cdsDup.FieldByName('CTR_DTAREC').AsDateTime)
        Else
          strDTAREC := fPadR(' ', 8);

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(cdsDup.FieldByName('CBI_ESPDOC').AsString) then
            Exit;

        strKEYDUP := fPadR('#D' + fPadR(cdsDup.FieldByName('CBI_NUMDUP').AsString, 12) +
                                  fPadR(cdsDup.fieldByName('CBI_PARCEL').AsString, 03) +
                                  fPadR(cdsDup.FieldByName('CBI_ESPDOC').AsString, 02) +
                                  fPadR(cdsDup.FieldByName('CBI_CODEMP').AsString, 03) +
                                  fPadR(cdsDup.FieldByName('CBI_CODCLI').AsString, 08), 34);

        strDups := strDups + '01'                                                                       + // 001 a 002
                             strCGCDUP                                                                  + // 003 a 016
                             '05'                                                                       + // 017 a 018
                             strNumDup                                                                  + // 019 a 028
                             strDTACAD                                                                  + // 029 a 036
                             strVALDUP                                                                  + // 037 a 049
                             strDTAVEN                                                                  + // 050 a 057
                             strDTAREC                                                                  + // 058 a 065
                             strKEYDUP                                                                  + // 066 a 099
                             fPadR(' ', 01)                                                             + // 100 a 101
                             fPadR(' ', 24)                                                             + // 102 a 125
                             fPadR(' ', 02)                                                             + // 126 a 127
                             fPadR(' ', 01)                                                             + // 128 a 128
                             fPadR(' ', 03)                                                             + // 129 a 131
                             #13                                                                        ;
        cdsDup.Next;
    end;

    {********************************}
    {* TRAILLER                     *}
    {*****************************PH*}
    strTrailler := '99'                                                                                 + // 001 a 002
                   Format('%.11d', [intQTDCLI])                                                         + // 003 a 013
                   fPadR(' ', 44)                                                                       + // 014 a 057
                   Format('%.11d', [intQTDDUP])                                                         + // 058 a 068
                   fPadR(' ', 11)                                                                       + // 069 a 079
                   fPadR(' ', 11)                                                                       + // 080 a 090
                   fPadR(' ', 09)                                                                       + // 091 a 100
                   fPadR(' ', 31)                                                                       ; // 101 a 130

    fStartTransaction;

    Try
      cdsDup.First;
      While Not cdsDup.Eof Do
      Begin
        qryGen := fCriaQuery;

        strSQL  := '';
        If cdsDup.FieldByName('CBI_STSSER').AsString = 'I' Then
        Begin
          strSQL := strSQL + ' UPDATE ';
          strSQL := strSQL + '   CADREC ';
          strSQL := strSQL + ' SET ';
          strSQL := strSQL + '   CTR_DTASER = IF(CTR_DTAREC IS NULL,    :DTASER,CTR_DTASER), ';
          strSQL := strSQL + '   CTR_DTASE2 = IF(CTR_DTAREC IS NOT NULL,:DTASER,CTR_DTASE2)  ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
          strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
          strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
          strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
          strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
          strSQL := strSQL + '   CTR_CODEMP = :CODEMP ';

          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(strSQL);
          qryGen.ParamByName('DTASER').AsDate   := VS_Date;
          qryGen.ParamByName('NUMDUP').AsString := cdsDup.FieldByName('CBI_NUMDUP').AsString;
          qryGen.ParamByName('PARCEL').AsString := cdsDup.FieldByName('CBI_PARCEL').AsString;
          qryGen.ParamByName('SEQBAI').AsInteger:= cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
          qryGen.ParamByName('ESPDOC').AsString := cdsDup.FieldByName('CBI_ESPDOC').AsString;
          qryGen.ParamByName('CODCLI').AsString := cdsDup.FieldByName('CBI_CODCLI').AsString;
          qryGen.ParamByName('CODEMP').AsString := cdsDup.FieldByName('CBI_CODEMP').AsString;
          qryGen.ExecSQL;
        End
        Else
        Begin
          strSQL := strSQL + ' UPDATE                     ';
          strSQL := strSQL + '   DEL_CADREC               ';
          strSQL := strSQL + ' SET                        ';
          strSQL := strSQL + '   CTR_SEREXC = :DTASER     ';
          strSQL := strSQL + 'WHERE                       ';
          strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
          strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
          strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
          strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
          strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
          strSQL := strSQL + '   CTR_CODEMP = :CODEMP     ';

          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(strSQL);
          qryGen.ParamByName('DTASER').AsDate    := VS_Date;
          qryGen.ParamByName('NUMDUP').AsString  := cdsDup.FieldByName('CBI_NUMDUP').AsString;
          qryGen.ParamByName('PARCEL').AsString  := cdsDup.FieldByName('CBI_PARCEL').AsString;
          qryGen.ParamByName('SEQBAI').AsInteger := cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
          qryGen.ParamByName('ESPDOC').AsString  := cdsDup.FieldByName('CBI_ESPDOC').AsString;
          qryGen.ParamByName('CODCLI').AsString  := cdsDup.FieldByName('CBI_CODCLI').AsString;
          qryGen.ParamByName('CODEMP').AsString  := cdsDup.FieldByName('CBI_CODEMP').AsString;
          qryGen.ExecSQL;

          // Atualiza a CADREC no caso das devoluções que foram enviadas como exclusão
          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add(AnsiReplaceStr(strSQL, 'DEL_CADREC', 'CADREC'));
          qryGen.ParamByName('DTASER').AsDate    := VS_Date;
          qryGen.ParamByName('NUMDUP').AsString  := cdsDup.FieldByName('CBI_NUMDUP').AsString;
          qryGen.ParamByName('PARCEL').AsString  := cdsDup.FieldByName('CBI_PARCEL').AsString;
          qryGen.ParamByName('SEQBAI').AsInteger := cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
          qryGen.ParamByName('ESPDOC').AsString  := cdsDup.FieldByName('CBI_ESPDOC').AsString;
          qryGen.ParamByName('CODCLI').AsString  := cdsDup.FieldByName('CBI_CODCLI').AsString;
          qryGen.ParamByName('CODEMP').AsString  := cdsDup.FieldByName('CBI_CODEMP').AsString;
          qryGen.ExecSQL;
        End;

        cdsDup.Next;
        FreeAndNil(qryGen);
      End;

      mArquivo := TStringList.Create;
      mArquivo.Text := strHeader + #13 + strDetalhe + strDups + strTrailler;
      mArquivo.SaveToFile(Path + '\' + Arquivo, TEncoding.ANSI);
      Result := FileExists(Path + '\' + Arquivo);

      qryAux := fCriaQuery;
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM CADCBI WHERE CBI_CODBCO = "SER" ';
      If rdgTipArq.ItemIndex = 1 Then
        strSQL := strSQL + ' AND CBI_STSSER = "I"'
      Else If rdgTipArq.ItemIndex = 2 Then
        strSQL := strSQL + ' AND CBI_STSSER = "E"';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
      End;

      fCommit;

      FreeAndNil(qryAux);
  Except
    ON E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;

  finally
    mArquivo.Free;
    FreeAndNil(cdsDup);
    FreeAndNil(pvdDup);
  end;

end;

function TfrmExpArqSer.fDefineIndicadorPeriodo: String;
begin
  If (cmbPeriodo.ItemIndex = 0) Then
    Result := 'D'
  Else If (cmbPeriodo.ItemIndex = 1) Then
    Result := 'S'
  Else If (cmbPeriodo.ItemIndex = 2) Then
    Result := 'Q'
  Else
    Result := 'M';

end;

procedure TfrmExpArqSer.btnGerarClick(Sender: TObject);
  var
    blnExporta: Boolean;
begin
  inherited;

  If cmbPeriodo.ItemIndex = -1 Then
  Begin
    fMensagem('', 'Informe a periodicidade!', ['&OK']);
    pSetFocus(cmbPeriodo);
    Exit;
  End;

  If (strCodBco = 'BOA') Then
  Begin
    blnExporta := objBoaVista.fExportaRemessa(fraPathRemessa.edtDirectory.text + '\' + edtNomArquivo.Text, '', fDefineIndicadorPeriodo,
                                             IIF(rdgTipArq.ItemIndex = 0, '', IIF(rdgTipArq.ItemIndex = 1, 'I', 'E')));
    If blnExporta Then
    Begin
      objConfBoa.strPathRemessa   := fraPathRemessa.edtDirectory.text;
      objConfBoa.strPeriodicidade := fDefineIndicadorPeriodo;
      objBoaVista.pSalvaConfiguracao(objConfBoa);
      FreeAndNil(objBoaVista);
    End;
  End
  Else
  Begin
    blnExporta := fGeraArquivoSerasa(fraPathRemessa.edtDirectory.text, edtNomArquivo.Text);

    if blnExporta then
    Begin
       fMensagem('', 'Arquivo foi gerado com sucesso!', ['&OK']);
       Close;
    End
    else
      fMensagem('', 'Não foi possivel gerar o arquivo!', ['&OK']);
  End;
end;

  {*******************************************}
  {*Verifica tipo do cliente                 *}
  {*                                         *}
  {*1-> Antigo                               *}
  {*2-> Menos de um Ano                      *}
  {*3-> Inativo//não verificar por aqui      *}
  {****************************************PH*}
function TfrmExpArqSer.fVerificaTipoCli(dataCadastro: TDate): Integer;
var
  diferenca: Integer;
begin
  diferenca := trunc(VS_Date) - trunc(dataCadastro);
  if diferenca > 365 then
    Result := 1
  else
    Result := 2;
end;

{*******************************************}
{*retorna uma string                       *}
{*'9999999999999' caso opcao = 2           *}
{*                                         *}
{*e uma string com 13 algarismos do valor  *}
{*sem ponto completado com 0               *}
{*                                         *}
{*ex: 56.69                                *}
{*                                         *}
{*0000000005669                            *}
{****************************************PH*}

function TfrmExpArqSer.fCorrigeValorDuplicata(valor: double;
  opcao: Integer): String;
var
  intValor: Integer;
begin
  intValor := trunc(valor * 100);
  if opcao = 2 then
    Result := '9999999999999'
  else
    Result := Format('%.13d', [Abs(intValor)]);
end;

procedure TfrmExpArqSer.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(fraPathRemessa);
end;

procedure TfrmExpArqSer.FormCreate(Sender: TObject);
begin
  inherited;
  edtNomArquivo.Text := 'RELATO' + FormatDateTime('yyyymmdd', VS_Date) + '.TXT';
  strCodBco          := 'SER';
end;

procedure TfrmExpArqSer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Then
                 self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExpArqSer.FormShow(Sender: TObject);
begin
  inherited;
  If strCodBco = 'BOA' Then
  Begin
    objBoaVista := TBoaVista.Create;
    objConfBoa  := objBoaVista.fRetConfiguracao;

    fraPathRemessa.edtDirectory.text  := objConfBoa.strPathRemessa;
    If objConfBoa.strPeriodicidade = 'D' Then
      cmbPeriodo.ItemIndex := 0
    Else If objConfBoa.strPeriodicidade = 'S' Then
      cmbPeriodo.ItemIndex := 1
    Else If objConfBoa.strPeriodicidade = 'Q' Then
      cmbPeriodo.ItemIndex := 2
    Else
      cmbPeriodo.ItemIndex := 3;

    edtNomArquivo.Text := 'COMPORTAMENTAL PJ.TXT';
  End;
end;

end.
