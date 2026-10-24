unit untExpArqSerPEFIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  frxClass, frxExportCSVTestabilidade, frxDBSet, Data.DB, Datasnap.DBClient, UniClientDataSet, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqSerPEFIN = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    frxRelValidacaoLinhaDigitavel: TfrxReport;
    frxdsValLinDig: TfrxDBDataset;
    cdsErrosLinDig: TUniClientDataSet;
    cdsErrosLinDigCLIENTE: TStringField;
    cdsErrosLinDigDUPLICATA: TStringField;
    cdsErrosLinDigESPDOC: TStringField;
    cdsErrosLinDigCODEMP: TStringField;
    cdsErrosLinDigERRO: TStringField;
    cdsErrosLinDigSOLUCAO: TStringField;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function fDefineIndicadorPeriodo(dtaInicio, dtaFim: TDateTime): String;
    procedure pImprimeRelInconsistenciaLinhaDigitavel;
    procedure pAdicionaErroLinDig(strCliente, strNumDup,
  strEspDoc, strCodEmp, strErro: String);
    function fMontaNumDup: String;
  public
    { Public declarations }
    cdsArqSer: TUniClientDataSet;
    function fGeraArquivoSerasa(Path, Arquivo: String):Boolean;
    function fEspacos(quantidade: Integer): String;
    function fVerificaTipoCli(dataCadastro: TDate): Integer;
    function fCorrigeValorDuplicata(valor: double; opcao: Integer): String;
  end;

var
  frmExpArqSerPEFIN: TfrmExpArqSerPEFIN;

implementation

uses untFuncoesSimples, untFuncAutban,
  untGeraArqSerasaPEFIN,  StrUtils;

{$R *.dfm}

function TfrmExpArqSerPEFIN.fGeraArquivoSerasa(Path, Arquivo: String): Boolean;
  Var
    qryGen  : TUniQuery;
    mArquivo: TStringList;

    intCont1  : Integer;
    intNumReg : Integer;
    intSeqArq : Integer;
    intCartei : Integer;

    fltDiaAtr : Double;
    fltTotTax : Double;

    strSQL             : String;
    strHeader          : String;
    strDetalhe         : String;
    strBolReg2         : String;
    strBolReg3         : String;
    strTrailler        : String;
    strKEYDUP          : String;
    strSeqArq          : String;
    strIndicadorPeriodo: String;
    strLinDig          : String;
    strCodAgen         : String;
    strDigAgen         : String;
    strContCor         : String;
    strDConCor         : String;
    strCodConv         : String;
    strVarCar          : String;
    strCodCar          : String;
    strDiaPro          : String;
    strMandMsg         : String;
    strCobran          : String;
    strProAcei         : String;
    strVlrTit          : String;
    strInst01          : String;
    strInst02          : String;
    strObs001          : String;
    strObs002          : String;
    strObs003          : String;
    strObs004          : String;
    strObs005          : String;
    dataInicio         : TDate;
    dataFim            : TDate;
Begin
  mArquivo := nil;
  Result   := False;

  If (fEmptyStr(Path) or fEmptyStr(Arquivo)) then
  Begin
    fMensagem(Application.Title, 'Informar o arquivo de destino!', ['&O K']);
  End
  Else
  Begin
    Try
      intCartei := frmGeraArqSerasaPEFIN.intCartei;

      strCodAgen := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CODAGEN', '');
      strDigAgen := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIGAGEN', '');
      strContCor := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'NUMCTAC', '');
      strDConCor := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIGCTAC', '');
      strCodConv := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CODCONV', '');
      strVarCar  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'VARCART', '');
      strCodCar  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'NUMCART', '');
      strDiaPro  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAPROT', '');
      strMandMsg := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'MANDMSG', '');
      strCobran  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'TIPCOBR', '');
      strProAcei := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'PROACEI', '');
      strInst01  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU1', '');
      strInst02  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU2', '');
      strObs001  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'OBSERV1', '');
      strObs002  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'OBSERV2', '');
      strObs003  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'OBSERV3', '');
      strObs004  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'OBSERV4', '');
      strObs005  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'OBSERV5', '');

      With cdsArqSer Do
      Begin
        Filtered := False;
        Filter := 'CTR_MARCAD = ''M''';
        Filtered := True;
      End;

      intNumReg   := 1;
      dataInicio  := StrToDate(frmGeraArqSerasaPEFIN.mskDtaIni.Text);
      dataFim     := StrToDate(frmGeraArqSerasaPEFIN.mskDtaFin.Text);

      strIndicadorPeriodo := fDefineIndicadorPeriodo(dataInicio, dataFim);

      If fEmptyStr(fGetBancoConfig(0,'PEFIN','SEQARQ','')) Then
        intSeqArq := 1
      Else
        intSeqArq := StrToInt(fGetBancoConfig(0,'PEFIN','SEQARQ',''));

      strSeqArq := fStrZero(intSeqArq, 6);

      Inc(intSeqArq);
      fGetBancoConfig(1, 'PEFIN', 'SEQARQ', IntToStr(intSeqArq));

      mArquivo := TStringList.Create;

      {*******************************************}
      {* HEADER                                  *}
      {****************************************PH*}

      strHeader := '';
      strHeader := '0'                                                                                                              + // 001 a 001
                   fStrZero(LeftStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fCadEmp('C_G_C_'),'.',''),'/',''),'-',''), 08), 09)+ // 002 a 010
                   FormatDateTime('yyyymmdd', fNow())                                                                               + // 011 a 018
                   fStrZero(Copy(fCadEmp('FONE01'), 01, 02), 04)                                                                    + // 019 a 022
                   RightStr(fCadEmp('FONE01'), 08)                                                                                  + // 023 a 030
                   '0000'                                                                                                           + // 031 a 034
                   fPadR(fCadEmp('CONTAT'), 70)                                                                                     + // 035 a 104
                   fPadR('SERASA-CONVEM04', 15)                                                                                     + // 105 a 119
                   fStrZero(strSeqArq, 06)                                                                                          + // 120 a 125
                   'E'                                                                                                              + // 126 a 126
                   fEspacos(467)                                                                                                    + // 127 a 593
                   fStrZero(intNumReg, 7)                                                                                           ; // 594 a 600

      mArquivo.Add(strHeader);

      {*******************************************}
      {* Detalhe                                 *}
      {****************************************PH*}
      cdsArqSer.First;

      For intCont1 := 1 to cdsArqSer.RecordCount Do
      Begin
        Inc(intNumReg);

        strDetalhe := '';
        strBolReg2 := '';
        strBolReg3 := '';

        strKEYDUP := LeftStr(cdsArqSer.FieldByName('CTR_AUTINC').AsString, 14) + RightStr(cdsArqSer.FieldByName('CTR_AUTINC').AsString, 02);

        fltDiaAtr := VS_Date - cdsArqSer.FieldByName('CTR_DTAVEN').AsDateTime;
        fltTotTax := (cdsArqSer.FieldByName('CTR_VALDUP').AsFloat * fCfgSis('TAXDIA', varDouble) / 100) * fltDiaAtr;

        strDetalhe := strDetalhe + '1'                                                                                                  + // 001 a 001
                                   'I'                                                                                                  + // 002 a 002
                                   RightStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fCadEmp('C_G_C_'),'.',''),'/',''),'-',''), 06) + // 003 a 008
                                   FormatDateTime('yyyymmdd', cdsArqSer.FieldByName('CTR_DTAVEN').AsDateTime)                           + // 009 a 016
                                   FormatDateTime('yyyymmdd', cdsArqSer.FieldByName('CTR_DTAVEN').AsDateTime)                           + // 017 a 024
                                   fPadR('VM', 03)                                                                                      + // 025 a 027
                                   fEspacos(04)                                                                                         + // 028 a 031
                                   IIF(cdsArqSer.FieldByName('CLI_CGCCPF').AsString = '1', 'J', 'F')                                    + // 032 a 032
                                   cdsArqSer.FieldByName('CLI_CGCCPF').AsString                                                         + // 033 a 033
                                   fPadL(fTiraCaracEspeciaisPonto(cdsArqSer.FieldByName('CLI_C_G_C_').AsString), 15, '0')               + // 034 a 048
                                   fEspacos(02)                                                                                         + // 049 a 050
                                   fEspacos(19)                                                                                         + // 051 a 068
                                   fEspacos(36)                                                                                         + // 069 a 105
                                   fPadR(cdsArqSer.FieldByName('CLI_NOMCLI').AsString, 70)                                              + // 106 a 175
                                   '00000000'                                                                                           + // 176 a 183
                                   fEspacos(140)                                                                                        + // 184 a 323
                                   fPadR(Copy(cdsArqSer.FieldByName('CLI_ENDERE').AsString, 01, 45), 45)                                + // 324 a 368
                                   fPadR(cdsArqSer.FieldByName('CLI_BAIRRO').AsString, 20)                                              + // 369 a 388
                                   fPadR(cdsArqSer.FieldByName('CID_NOMCID').AsString, 25)                                              + // 389 a 413
                                   fPadR(cdsArqSer.FieldByName('CID_ESTADO').AsString, 02)                                              + // 414 a 415
                                   fPadL(cdsArqSer.FieldByName('CLI_C_E_P_').AsString, 08)                                              + // 416 a 423
                                   fPadL(AnsiReplaceStr(
                                         AnsiReplaceStr(FormatFloat('#,##0.00', cdsArqSer.FieldByName('CTR_VALDUP').AsFloat), ',', ''),
                                         '.', ''), 15, '0')                                                                             + // 424 a 438
                                   strKEYDUP                                                                                            + // 439 a 454
                                   fEspacos(09)                                                                                         + // 455 a 463
                                   IIF(Length(cdsArqSer.FieldByName('CLI_ENDERE').AsString) > 45,
                                       fPadR(Copy(cdsArqSer.FieldByName('CLI_ENDERE').AsString, 46, 25), 25),
                                       fEspacos(25))                                                                                    + // 464 a 488
                                   fPadL(LeftStr(cdsArqSer.FieldByName('CLI_FONE01').AsString, 02), 04, '0')                            + // 489 a 492
                                   fPadL(Trim(Copy(cdsArqSer.FieldByName('CLI_FONE01').AsString, 03, 09)), 09, '0')                     + // 493 a 501
                                   FormatDateTime('yyyymmdd', cdsArqSer.FieldByName('CTR_DTACAD').AsDateTime)                           + // 502 a 509
                                   fPadL(AnsiReplaceStr(
                                         AnsiReplaceStr(FormatFloat('#,##0.00', cdsArqSer.FieldByName('CTR_VALDUP').AsFloat +
                                                                                cdsArqSer.FieldByName('CTR_VALJUR').AsFloat +
                                                                                cdsArqSer.FieldByName('CTR_VALCOB').AsFloat -
                                                                                cdsArqSer.FieldByName('CTR_VALDES').AsFloat +
                                                                                fltTotTax), ',', ''),
                                         '.', ''), 15, '0')                                                                             + // 510 a 524
                                   fEspacos(06)                                                                                         + // 525 a 530
                                   'B'                                                                                                  + // 531 a 531
                                   fEspacos(62)                                                                                         + // 532 a 593
                                   fStrZero(intNumReg, 07)                                                                              ; // 594 a 600

        strLinDig := fRetLinDig('001',
                                strCodAgen,
                                strCodCar,
                                strCodConv,
                                strContCor,
                                cdsArqSer.FieldByName('CTR_NOSNUM').AsString,
                                FormatFloat('#,##0.00', cdsArqSer.FieldByName('CTR_VALDUP').AsFloat +
                                                                           cdsArqSer.FieldByName('CTR_VALJUR').AsFloat +
                                                                           cdsArqSer.FieldByName('CTR_VALCOB').AsFloat -
                                                                           cdsArqSer.FieldByName('CTR_VALDES').AsFloat +
                                                                           fltTotTax),
                                cdsArqSer.FieldByName('CTR_DTAVEN').AsDateTime, False);

        if Pos('ERRO', strLinDig.ToUpper()) > 0 then
        begin
          pAdicionaErroLinDig(cdsArqSer.FieldByName('CTR_CODCLI').AsString+'-'+cdsArqSer.FieldByName('CLI_NOMCLI').AsString,
                              cdsArqSer.FieldByName('CTR_NUMDUP').AsString+cdsArqSer.FieldByName('CTR_PARCEL').AsString,
                              cdsArqSer.FieldByName('CTR_ESPDOC').AsString,
                              cdsArqSer.FieldByName('CTR_CODEMP').AsString,
                              strLinDig);

          Inc(intNumReg, -1);

          cdsArqSer.Next;

          Continue;
        end;

        mArquivo.Add(strDetalhe);
        Inc(intNumReg);

        strVlrTit := FormatFloat('#,##0.00', cdsArqSer.FieldByName('CTR_VALDUP').AsFloat +
                                 cdsArqSer.FieldByName('CTR_VALJUR').AsFloat +
                                 cdsArqSer.FieldByName('CTR_VALCOB').AsFloat -
                                 cdsArqSer.FieldByName('CTR_VALDES').AsFloat +
                                 fltTotTax);

        strVlrTit := fPadL(FloatToStr(fFormataFloat(fStrToFloat(strVlrTit), 02) * 100), 14, '0');

        If Not fEmptyStr(strLinDig) Then
        Begin
          strBolReg2 := '2'                                                          + // 001 a 001
                        '001'                                                        + // 002 a 004
                        '9'                                                          + // 005 a 005
                        fPadR('BANCO DO BRASIL', 15)                                 + // 006 a 020
                        strLinDig                                                    + // 021 a 067
                        fPadR('PAGAVEL EM QUALQUER BANCO ATE O VENCIMENTO', 70)      + // 068 a 137
                        fEspacos(70)                                                 + // 138 a 207
                        fEspacos(65)                                                 + // 208 a 272
                        fPadR(strCodAgen + strDigAgen + strContCor + strDConCor, 25) + // 273 a 297
                        FormatDateTime('yyyymmdd', cdsArqSer.FieldByName('CTR_DTACAD').AsDateTime) + // 298 a 305
                        fPadR(fMontaNumDup(), 25)                                    + // 306 a 330
                        fPadR(cdsArqSer.FieldByName('CTR_ESPDOC').AsString, 05)      + // 331 a 335
                        fPadR(strProAcei, 03)                                        + // 336 a 338
                        fEspacos(20)                                                 + // 339 a 358
                        '00000000'                                                   + // 359 a 366
                        fPadR(cdsArqSer.FieldByName('CTR_NOSNUM').AsString, 25)      + // 367 a 391
                        fPadR(IntToStr(intCartei), 5)                                + // 392 a 396
                        fPadR('R$', 3)                                               + // 397 a 399
                        fEspacos(19)                                                 + // 400 a 418
                        fPadL(FloatToStr
                             (fFormataFloat
                             (cdsArqSer.FieldByName('CTR_VALDUP').AsFloat,
                              02) * 100), 15, '0')                                   + // 419 a 433
                        fPadL(FloatToStr
                             (fFormataFloat
                             (cdsArqSer.FieldByName('CTR_VALDES').AsFloat,
                              02) * 100), 15, '0')                                   + // 434 a 448
                        fPadL('0', 15, '0')                                          + // 449 a 463
                        fPadL(FloatToStr(fFormataFloat(fltTotTax,02) * 100), 15, '0')+ // 464 a 478
                        fPadL('0', 15, '0')                                          + // 479 a 493
                        fStrZero(strVlrTit, 15)                                      + // 494 a 508
                        fEspacos(1)                                                  + // 509 a 509
                        fPadL('0', 16, '0')                                          + // 510 a 525
                        fEspacos(68)                                                 + // 526 a 593
                        fStrZero(intNumReg, 07)                                      ; // 594 a 600

          mArquivo.Add(strBolReg2);
          Inc(intNumReg);

          strBolReg3 := '3'                      + // 001 a 001
                        fPadR(strInst01, 70)     + // 002 a 071
                        fPadR(strInst02, 70)     + // 072 a 141
                        fPadR(strObs001, 70)     + // 142 a 211
                        fPadR(strObs002, 70)     + // 212 a 281
                        fPadR(strObs003, 70)     + // 282 a 351
                        fPadR(strObs004, 70)     + // 352 a 421
                        fPadR(strObs005, 70)     + // 422 a 491
                        fEspacos(70)             + // 492 a 561
                        fEspacos(32)             + // 562 a 593
                        fStrZero(intNumReg, 07)  ; // 594 a 600

          mArquivo.Add(strBolReg3);

        End;

        cdsArqSer.Next;
      End;

      Inc(intNumReg);
      {********************************}
      {* TRAILLER                     *}
      {*****************************PH*}
      strTrailler := '9'                                                                                 + // 001 a 001
                     fEspacos(592)                                                                       + // 002 a 593
                     fStrZero(intNumReg, 07)                                                             ; // 594 a 600

      mArquivo.Add(strTrailler);

      cdsArqSer.First;

      strSQL  := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '    CADREC ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   CTR_DTAPFI = :DTAPFI ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
      strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '   CTR_CODEMP = :CODEMP ';

      qryGen := fCriaQuery;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);

      For intCont1 := 1 to cdsArqSer.RecordCount Do
      Begin
        if not cdsErrosLinDig.Locate('CLIENTE;DUPLICATA;CODEMP',VarArrayOf([cdsArqSer.FieldByName('CTR_CODCLI').AsString+'-'+cdsArqSer.FieldByName('CLI_NOMCLI').AsString,cdsArqSer.FieldByName('CTR_NUMDUP').AsString+cdsArqSer.FieldByName('CTR_PARCEL').AsString,cdsArqSer.FieldByName('CTR_CODEMP').AsString]),[loCaseInsensitive, loPartialKey]) then
        begin
          qryGen.ParamByName('DTAPFI').AsDate   := VS_Date;
          qryGen.ParamByName('NUMDUP').AsString := cdsArqSer.FieldByName('CTR_NUMDUP').AsString;
          qryGen.ParamByName('PARCEL').AsString := cdsArqSer.FieldByName('CTR_PARCEL').AsString;
          qryGen.ParamByName('SEQBAI').AsInteger:= cdsArqSer.FieldByName('CTR_SEQBAI').AsInteger;
          qryGen.ParamByName('ESPDOC').AsString := cdsArqSer.FieldByName('CTR_ESPDOC').AsString;
          qryGen.ParamByName('CODCLI').AsString := cdsArqSer.FieldByName('CTR_CODCLI').AsString;
          qryGen.ParamByName('CODEMP').AsString := cdsArqSer.FieldByName('CTR_CODEMP').AsString;
          qryGen.ExecSQL;
        end;
        cdsArqSer.Next;
      End;

      mArquivo.SaveToFile(Path + '\' + Arquivo);
      Result := FileExists(Path + '\' + Arquivo);

      If (cdsArqSer.RecordCount = cdsErrosLinDig.RecordCount) And Result Then
      Begin
        DeleteFile(Path + '\' + Arquivo);
      End;

    finally
      mArquivo.Free;
      FreeAndNil(qryGen);
    end;
  end;
end;

function TfrmExpArqSerPEFIN.fMontaNumDup: String;
begin
  Result := cdsArqSer.FieldByName('CTR_NUMDUP').AsString +
            cdsArqSer.FieldByName('CTR_PARCEL').AsString +
            cdsArqSer.FieldByName('CTR_ESPDOC').AsString;
end;

function TfrmExpArqSerPEFIN.fDefineIndicadorPeriodo(dtaInicio, dtaFim: TDateTime): String;
  Var
    fltQtdDias: Double;
begin

  fltQtdDias := dtaFim - dtaInicio;

  If (fltQtdDias <= 1) Then
    Result := 'D'
  Else If (fltQtdDias <= 7) Then
    Result := 'S'
  Else If (fltQtdDias <= 15) Then
    Result := 'Q'
  Else
    Result := 'M';

end;

procedure TfrmExpArqSerPEFIN.btnGerarClick(Sender: TObject);
begin
  inherited;
  cdsErrosLinDig.EmptyDataSet;
  if fGeraArquivoSerasa(fraPathRemessa.edtDirectory.text, edtNomArquivo.Text) then
  Begin
    if not cdsErrosLinDig.IsEmpty then
      pImprimeRelInconsistenciaLinhaDigitavel;
      If (cdsArqSer.RecordCount <> cdsErrosLinDig.RecordCount) Then
      Begin
        fMensagem('', 'Arquivo foi gerado com sucesso!', ['&OK']);
      End
      Else
        fMensagem('', 'Não foi possivel gerar o arquivo!', ['&OK']);
    Close;
  End
  else
    fMensagem('', 'Não foi possivel gerar o arquivo!', ['&OK'])
end;

function TfrmExpArqSerPEFIN.fEspacos(quantidade: Integer): String;
begin
  Result := Format('%' + IntToStr(quantidade) + 's', [''])
end;


  {*******************************************}
  {*Verifica tipo do cliente                 *}
  {*                                         *}
  {*1-> Antigo                               *}
  {*2-> Menos de um Ano                      *}
  {*3-> Inativo//não verificar por aqui      *}
  {****************************************PH*}
function TfrmExpArqSerPEFIN.fVerificaTipoCli(dataCadastro: TDate): Integer;
var
  diferenca: Integer;
begin
  diferenca := trunc(VS_Date) - trunc(dataCadastro);
  if diferenca > 365 then
    Result := 1
  else
    Result := 2;
end;


procedure TfrmExpArqSerPEFIN.pAdicionaErroLinDig(strCliente, strNumDup,
  strEspDoc, strCodEmp, strErro: String);
Var
  arrErro: TArray<string>;
begin
  SetLength(arrErro, 0);
  With cdsErrosLinDig Do
  begin
    Append;
    cdsErrosLinDigCLIENTE.AsString   := strCliente;
    cdsErrosLinDigDUPLICATA.AsString := strNumDup;
    cdsErrosLinDigESPDOC.AsString    := strEspDoc;
    cdsErrosLinDigCODEMP.AsString    := strCodEmp;
    arrErro := strErro.Split(['/']);

    if Length(arrErro) > 0 then
    Begin
      cdsErrosLinDigERRO.AsString    := arrErro[1];
      cdsErrosLinDigSOLUCAO.AsString := arrErro[2];
    End;

    Post;
  end;
end;

procedure TfrmExpArqSerPEFIN.pImprimeRelInconsistenciaLinhaDigitavel;
begin
  With frxRelValidacaoLinhaDigitavel Do
  Begin
    Script.Variables['NOMEMP']  := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
    Script.Variables['NOMREL']  := 'DUPLICATAS NÃO ENVIADAS NO ARQUIVO REMESSA POR INCONSISTÊNCIA SERASA PEFIN';
    script.Variables['PERIODO'] := 'GERAÇÃO DE ' + frmGeraArqSerasaPEFIN.mskDtaIni.Text + ' A ' + frmGeraArqSerasaPEFIN.mskDtaFin.Text;
    pPreviewReport(Self.Name, 'Duplicatas não enviadas no arquivo remessa por inconsistência SERASA PEFIN', frxRelValidacaoLinhaDigitavel);
  End;
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

function TfrmExpArqSerPEFIN.fCorrigeValorDuplicata(valor: double;
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

procedure TfrmExpArqSerPEFIN.FormCreate(Sender: TObject);
begin
  inherited;
  edtNomArquivo.Text := 'RELATO' + FormatDateTime('yyyymmdd', VS_Date) + '.TXT';
  cdsArqSer := TUniClientDataSet.Create(Self);
end;

procedure TfrmExpArqSerPEFIN.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsArqSer);
end;

end.
