unit untExpArqSPC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, untFuncoes,
  BitBtnLockedIncrem, untFuncoesSimples, Uni, UniClientDataSet, UniDataSetProvider, DB,
  System.StrUtils, untLogCtr, untFrameDirectoryEditFocus;

type
  TfrmExpArqSPC = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    rdgTipArq: TRadioGroup;
    btnGerar: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    strCodEntidade: String;
    strCodAssociado: String;
    strCPF: String;
    strPath: String;

    function fRetornaCodEvento(strCodOco, strCodBco: String): String;
    function BuscaVencimentoDaInclusao(AChaveDuplicata, ACodigoCliente: String): TDateTime;
  public
    { Public declarations }
    function fGeraArquivoSPC(Path, Arquivo: String):Boolean;
  end;

var
  frmExpArqSPC: TfrmExpArqSPC;

implementation

uses untConstantes;

{$R *.dfm}

procedure TfrmExpArqSPC.btnGerarClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(fraPathRemessa.edtDirectory.text) then
  begin
    fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Path para Arquivos de Remessa na aba Configurar, ou selecionar um diretório válido!', ['&O K ']);
    pSetFocus(fraPathRemessa);
    Exit;
  end
  else
  begin

    fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

    If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
    Begin
      fMensagem('Path:', 'Diretório inválido para gerar arquivo.', ['&O K'], 1, True);
      pSetFocus(fraPathRemessa);
      Exit;
    End;

    if fGeraArquivoSPC(fraPathRemessa.edtDirectory.text, edtNomArquivo.Text) then
    Begin
      fMensagem('', 'Arquivo foi gerado com sucesso!', ['&OK']);
      Close;
    End
    else
      fMensagem('', 'Não foi possivel gerar o arquivo!', ['&OK']);
  end;
end;

function TfrmExpArqSPC.BuscaVencimentoDaInclusao(AChaveDuplicata, ACodigoCliente: String): TDateTime;
var
  qryLogCtr: TUniQuery;
begin
  qryLogCtr := fCriaQuery;

  qryLogCtr.Close;
  qryLogCtr.SQL.Clear;
  qryLogCtr.SQL.Add('SELECT DISTINCT ');
  qryLogCtr.SQL.Add('     CTR_DTAVEN ');
  qryLogCtr.SQL.Add('FROM LOGCTR ');
  qryLogCtr.SQL.Add('WHERE CTR_DTALOG = (SELECT MAX(CTR_DTALOG) ');
  qryLogCtr.SQL.Add('                    FROM LOGCTR ');
  qryLogCtr.SQL.Add('                    WHERE CTR_NUMDUP = :NUMDUP AND ');
  qryLogCtr.SQL.Add('                          CTR_PARCEL = :PARCEL AND ');
  qryLogCtr.SQL.Add('                          CTR_ESPDOC = :ESPDOC AND ');
  qryLogCtr.SQL.Add('                          CTR_CODEMP = :CODEMP AND ');
  qryLogCtr.SQL.Add('                          CTR_CODCLI = :CODCLI AND ');
  qryLogCtr.SQL.Add('                          CTR_DESCRI LIKE "%INCLUSÃO SPC BRASIL%") AND ');
  qryLogCtr.SQL.Add('      CTR_HORLOG = (SELECT MAX(CTR_HORLOG) ');
  qryLogCtr.SQL.Add('                    FROM LOGCTR ');
  qryLogCtr.SQL.Add('                    WHERE CTR_NUMDUP = :NUMDUP AND ');
  qryLogCtr.SQL.Add('                          CTR_PARCEL = :PARCEL AND ');
  qryLogCtr.SQL.Add('                          CTR_ESPDOC = :ESPDOC AND ');
  qryLogCtr.SQL.Add('                          CTR_CODEMP = :CODEMP AND ');
  qryLogCtr.SQL.Add('                          CTR_CODCLI = :CODCLI AND ');
  qryLogCtr.SQL.Add('                          CTR_DESCRI LIKE "%INCLUSÃO SPC BRASIL%") AND ');
  qryLogCtr.SQL.Add('      CTR_NUMDUP = :NUMDUP AND ');
  qryLogCtr.SQL.Add('      CTR_PARCEL = :PARCEL AND ');
  qryLogCtr.SQL.Add('      CTR_ESPDOC = :ESPDOC AND ');
  qryLogCtr.SQL.Add('      CTR_CODEMP = :CODEMP AND ');
  qryLogCtr.SQL.Add('      CTR_CODCLI = :CODCLI     ');

  qryLogCtr.ParamByName('NUMDUP').AsString := fStrZero(Copy(AChaveDuplicata, 001, 12), 12);
  qryLogCtr.ParamByName('PARCEL').AsString := Trim(Copy(AChaveDuplicata, 013, 03));
  qryLogCtr.ParamByName('ESPDOC').AsString := Copy(AChaveDuplicata, 016, 02);
  qryLogCtr.ParamByName('CODEMP').AsString := fStrZero(Copy(AChaveDuplicata,018,03),3);
  qryLogCtr.ParamByName('CODCLI').AsString := ACodigoCliente;
  qryLogCtr.Open;

  Result := qryLogCtr.FieldByName('CTR_DTAVEN').AsDateTime;
  FreeAndNil(qryLogCtr);
end;

function TfrmExpArqSPC.fGeraArquivoSPC(Path, Arquivo: String): Boolean;
Var
  mArquivo: TStringList;

  intCodSeq: Integer;
  intTotalReg: Integer;
  intSeqRem: Integer;

  strSQL     : String;
  strHeader  : String;
  strDetalhe : String;
  strTrailler: String;
  strCodEve: String;
  strStatus: String;
  strSeqRem: String;
  strKeyDup: String;
  strCgcEmp: String;
  strCPFEmp: String;

  qryGen: TUniQuery;
  qryEmp: TUniQuery;
  qryAux: TUniQuery;
  cdsDup: TUniClientDataSet;
  pvdDup: TUniDataSetProvider;
  ADataVencimento: TDateTime;
begin
  Result    := False;
  strCodEve := '';
  ADataVencimento := 0;

  If fEmptyStr(Path) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve informar o diretório para gerar o arquivo de exportação!', ['&O K ']);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  If fEmptyStr(Arquivo) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você deve informar o nome do arquivo para exportação!', ['&O K']);
    pSetFocus(edtNomArquivo);
    Exit;
  End;

  strSeqRem := fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', '');
  intSeqRem := StrToInt(strSeqRem);

  mArquivo  := nil;

  Try
    qryGen := fCriaQuery;
    qryEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT CADCBI.*, CLI_NOMCLI, CLI_CGCCPF, CLI_C_G_C_, CLI_NASCIM, CLI_NOMMAE, ';
    strSQL := strSQL + '        CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM, CLI_BAIRRO, CLI_C_E_P_, CID_NOMCID, ';
    strSQL := strSQL + '        CID_ESTADO, CLI_EMAIL_, CLI_STATUS, CLI_DTACAD, EMP_C_E_P_, R.AUTOINCREM, ';
    strSQL := strSQL + '        REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_, CTR_SEQBAI, CTR_STSSPC, CTR_DTAREC ';
    strSQL := strSQL + ' FROM CADCLI ';
    strSQL := strSQL + '   LEFT JOIN CADCBI ON CLI_CODCLI = CBI_CODCLI ';
    strSQL := strSQL + '   LEFT JOIN CADREC R ON CBI_NUMDUP = CTR_NUMDUP AND ';
    strSQL := strSQL + '                         CBI_PARCEL = CTR_PARCEL AND ';
    strSQL := strSQL + '                         CBI_ESPDOC = CTR_ESPDOC AND ';
    strSQL := strSQL + '                         CBI_CODEMP = CTR_CODEMP AND ';
    strSQL := strSQL + '                         CBI_CODCLI = CTR_CODCLI AND ';
    strSQL := strSQL + '                         CTR_SEQBAI = 0              ';
    strSQL := strSQL + '   LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ';
    strSQL := strSQL + '   LEFT JOIN CADEMP ON CBI_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + ' WHERE CBI_CODBCO = "SPC" ';

    if rdgTipArq.ItemIndex = 1 then
    Begin
      strSQL := strSQL + ' AND CBI_STSSER = "I" ';
    end
    else
    if rdgTipArq.ItemIndex = 2 then
    begin
      strSQL := strSQL + ' AND CBI_STSSER = "E" ';
    end;

    strSQL := strSQL + ' ORDER BY CBI_DTAINI, CBI_DTAFIN ';

    cdsDup := TUniClientDataSet.Create(Self);
    pvdDup := TUniDataSetProvider.Create(Self);
    pvdDup.DataSet := qryGen;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;
    qryGen.First;
    pSetaClient(qryGen);

    cdsDup.Close;
    cdsDup.SetProvider(pvdDup);
    cdsDup.Open;
    cdsDup.First;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strCPFEmp := FieldByName('EMP_C_E_P_').AsString;
      Close;
    End;

    if Not qryGen.IsEmpty then
    begin
      {*******************************************}
      {* HEADER                                  *}
      {****************************************MO*}
      intCodSeq   := 1;
      intTotalReg := 1;

      strHeader := '';
      strHeader := '00'                                + // 001 a 002 - Tipo de Registro
                   fPadR('REMESSA', 07)                + // 003 a 009 - Operação
                   FormatDateTime('ddmmyyyy', VS_Date) + // 010 a 017 - Data Movimento
                   fPadR(strSeqRem, 08, '0')           + // 018 a 025 - Remessa
                   fPadR(strCodEntidade, 05, '0')      + // 026 a 030 - Entidade
                   fPadR(strCodAssociado, 08, '0')     + // 031 a 038 - Associado
                   FormatDateTime('yyyymmdd', VS_Date) + // 039 a 046 - Data Movimento Arquivo
                   fPadR(' ', 321)                     + // 047 a 367 - brancos
                   fPadL('SPC' , 05, ' ')              + // 368 a 372 - Unidade de Negocio
                   fPadR('12', 02)                     + // 373 a 374 - Número da Versão
                   fPadR(' ', 10)                      + // 375 a 384 - Código de Retorno
                   fStrZero(IntToStr(intCodSeq), 006);   // 385 a 390 - Sequencial do Registro

      {*******************************************}
      {* Detalhe                                 *}
      {****************************************MO*}
      strDetalhe := '';
      inc(intCodSeq);

      qryGen.First;

      strCPFEmp := AnsiReplaceStr(strCPFEmp,'-','');
      strCPFEmp := AnsiReplaceStr( strCPFEmp,'.','');
      strCPFEmp := AnsiReplaceStr( strCPFEmp,'/','');

      while not qryGen.Eof do
      Begin
        if ((not qryGen.FieldByName('CTR_DTAREC').IsNull) and (qryGen.FieldByName('CBI_STSSER').AsString = 'I')) then
        begin
          fMensagem('ATENÇÃO!', 'Existem duplicatas baixadas marcadas para inclusão no SPC! A geração do arquivo será cancelada!', ['&O K ']);
          FreeAndNil(qryGen);
          FreeAndNil(cdsDup);
          FreeAndNil(pvdDup);
          Exit;
        end;

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryGen.FieldByName('CBI_ESPDOC').AsString) then
          Exit;

        strKeyDup := fPadR(qryGen.FieldByName('CBI_NUMDUP').AsString, 12) +
                     fPadR(qryGen.FieldByName('CBI_PARCEL').AsString, 03) +
                     fPadR(qryGen.FieldByName('CBI_ESPDOC').AsString, 02) +
                     fPadR(qryGen.FieldByName('CBI_CODEMP').AsString, 03) ;

        strCPF := AnsiReplaceStr(qryGen.FieldByName('CLI_C_G_C_').AsString,'-','');
        strCPF := AnsiReplaceStr( strCPF,'.','');
        strCPF := AnsiReplaceStr( strCPF,'/','');

        strDetalhe := strDetalhe + '01'                                                                               + // 001 a 002 - Tipo de Registro
                                   fPadR(strCPFEmp, 08, '0')                                                          + // 003 a 010 - Praça de Concessão
                                   fPadR(Trim(qryGen.FieldByName('CLI_NOMCLI').AsString), 45)                         + // 011 a 055 - Nome/Razão
                                   fPadR(IntToStr(qryGen.FieldByName('CLI_CGCCPF').AsInteger), 01)                    + // 056 a 056 - Tipo documento
                                   fPadL(strCPF, 15, '0')                                                             + // 057 a 071 - CPF/CNPJ
                                   fPadR(' ', 20)                                                                     + // 072 a 091 - RG
                                   fPadR(FormatDateTime('ddmmyyyy', qryGen.FieldByName('CLI_NASCIM').AsDateTime), 08) + // 092 a 099 - Data de Nascimento
                                   fPadR(Trim(qryGen.FieldByName('CLI_NOMMAE').AsString), 45)                         + // 100 a 144 - Filiação
                                   fPadR(Trim(qryGen.FieldByName('CLI_ENDERE').AsString), 50)                         + // 145 a 194 - Endereço
                                   fPadL(Trim(qryGen.FieldByName('CLI_ENDNUM').AsString), 05, '0')                    + // 195 a 199 - Número
                                   fPadR(Trim(qryGen.FieldByName('CLI_ENDCOM').AsString), 30)                         + // 200 a 229 - Complemento
                                   fPadR(Trim(qryGen.FieldByName('CLI_BAIRRO').AsString), 25)                         + // 230 a 254 - Bairro
                                   fPadR(Trim(qryGen.FieldByName('CLI_C_E_P_').AsString), 08, '0')                    + // 255 a 262 - CEP
                                   fPadR(Trim(qryGen.FieldByName('CID_NOMCID').AsString), 30)                         + // 263 a 292 - Cidade
                                   fPadR(Trim(qryGen.FieldByName('CID_ESTADO').AsString), 02)                         + // 293 a 294 - UF
                                   fPadR(' ', 02)                                                                     + // 295 a 296 - Fone-DDD
                                   fPadR(' ', 18)                                                                     + // 297 a 314 - brancos
                                   fPadR(' ', 10)                                                                     + // 315 a 324 - Fone-Numero
                                   fPadR(Trim(qryGen.FieldByName('CLI_EMAIL_').AsString), 50)                         + // 325 a 374 - Email
                                   fPadR(' ', 10)                                                                     + // 375 a 384 - Código de Retorno
                                   fStrZero(IntToStr(intCodSeq), 06)                                                  + // 385 a 390 - Sequencial do Registro
                                   #13                                                                                ;

        inc(intCodSeq);

        strStatus := qryGen.FieldByName('CBI_STSSER').AsString;

        //EXCLUSÃO: BUSCA A DATA DE VENCIMENTO DA INCLUSÃO AO SPC
        if strStatus = 'E' then
          ADataVencimento := BuscaVencimentoDaInclusao(strKeyDup, qryGen.FieldByName('CBI_CODCLI').AsString);

        strDetalhe := strDetalhe + '02'                                                                                  + // 001 a 002 - Tipo de Registro
                                   fPadR(IntToStr(qryGen.FieldByName('CLI_CGCCPF').AsInteger), 01)                       + // 003 a 003 - Tipo documento
                                   fPadL(strCPF, 15, '0')                                                                + // 004 a 018 - CPF/CNPJ
                                   fPadR(strStatus, 01)                                                                  + // 019 a 019 - Código de Operação
                                   fPadR('C', 01)                                                                        + // 020 a 020 - Comprador/Fiador/Avalista
                                   fPadR(FormatDateTime('ddmmyyyy',
                                         IIF(strStatus = 'I', qryGen.FieldByName('CBI_DTAVEN').AsDateTime, ADataVencimento)), 08) + // 021 a 028 - Data de Vencimento
                                   fPadR(FormatDateTime('ddmmyyyy', qryGen.FieldByName('CBI_DTACAD').AsDateTime), 08)    + // 029 a 036 - Data de Registro(compra)
                                   fValNumForm(qryGen.FieldByName('CBI_VALDUP').AsFloat       , 13)                      + // 037 a 049 - Valor do Debito
                                   fPadR(strKeyDup, 30, ' ')                                                             + // 050 a 079 - Contrato
                                   fPadR(strCodAssociado, 08)                                                            + // 080 a 087 - Associado
                                   fPadR('45', 02)                                                                       + // 088 a 089 - Natureza da Inclusão** FIXO SEGUNDO ANÁLISE DO REQUISITO 69392
                                   fPadL(IIF(strStatus = 'I', ' ', qryGen.FieldByName('CBI_MOTSPC').AsString) , 03, ' ') + // 090 a 092 - Motivo da Exclusão
                                   fPadR(qryGen.FieldByName('CLI_C_G_C_').AsString, 15)                                  + // 093 a 107 - CPF/CNPJ
                                   fPadR(IntToStr(qryGen.FieldByName('CLI_CGCCPF').AsInteger), 01)                       + // 108 a 108 - Tipo documento
                                   fPadR('S', 001)                                                                       + // 109 a 109 - Notificar via e-mail
                                   fPadR(' ', 265)                                                                       + // 110 a 374 - Brancos
                                   fPadR(' ', 010)                                                                       + // 375 a 384 - Código de Retorno
                                   fStrZero(IntToStr(intCodSeq), 06)                                                     + // 385 a 390 - Sequencial do Registro
                                   #13                                                                                   ;
        inc(intCodSeq);
        qryGen.Next;
      End;

      intTotalReg := intTotalReg + intCodSeq;

      {********************************}
      {* TRAILLER                     *}
      {*****************************MO*}
      strTrailler := '99'                                 + // 001 a	002 -	Tipo de Registro
                     fStrZero(IntToStr(intTotalReg-1), 06)+ // 003 a 008 -	Total de Registros
                     fPadR(' ', 366)                      + // 009	a 374 -	brancos
                     fPadR(' ', 10)                       + // 375 a	384 -	Código de Retorno
                     fStrZero(IntToStr(intCodSeq), 06)    + // 385 a	390 -	Sequencial do Registro
                     #13                               ;

      fStartTransaction;
      
      Try
        cdsDup.First;
        While Not cdsDup.Eof Do
        Begin
          qryAux := fCriaQuery;

          strSQL  := '';

          If cdsDup.FieldByName('CBI_STSSER').AsString = 'I' Then
          Begin
            //OCORRÊNCIA REFERENTE A INCLUSÃO DE TITULO ESTAMOS MANDANDO 45 FIXO
            //DECIDIDO ISSO NO REQUISITO DE CRIÇÃO DO SPC
            strCodEve := fRetornaCodEvento('45', 'SPC');

            strSQL := strSQL + ' UPDATE CADREC ';
            strSQL := strSQL + ' SET ';
            strSQL := strSQL + '   CTR_DTASPC = :DATA, ';
            strSQL := strSQL + '   CTR_STSSPC = "I",   ';
            strSQL := strSQL + '   CTR_DTCSPC = NULL  ';

            If not fEmptyStr(strCodEve) then
              strSQL := strSQL + '   , CTR_CODEVE = :CODEVE ';

            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
            strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
            strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
            strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
            strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
            strSQL := strSQL + '   CTR_CODEMP = :CODEMP ';

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add(strSQL);
            qryAux.ParamByName('DATA').AsDate     := VS_Date;
            qryAux.ParamByName('NUMDUP').AsString := cdsDup.FieldByName('CBI_NUMDUP').AsString;
            qryAux.ParamByName('PARCEL').AsString := cdsDup.FieldByName('CBI_PARCEL').AsString;
            qryAux.ParamByName('SEQBAI').AsInteger:= cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
            qryAux.ParamByName('ESPDOC').AsString := cdsDup.FieldByName('CBI_ESPDOC').AsString;
            qryAux.ParamByName('CODCLI').AsString := cdsDup.FieldByName('CBI_CODCLI').AsString;
            qryAux.ParamByName('CODEMP').AsString := cdsDup.FieldByName('CBI_CODEMP').AsString;

            If not fEmptyStr(strCodEve) then
              qryAux.ParamByName('CODEVE').AsString := strCodEve;

            qryAux.ExecSQL;

            strSQL := AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC');

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add(strSQL);
            qryAux.ParamByName('DATA').AsDate     := VS_Date;
            qryAux.ParamByName('NUMDUP').AsString := cdsDup.FieldByName('CBI_NUMDUP').AsString;
            qryAux.ParamByName('PARCEL').AsString := cdsDup.FieldByName('CBI_PARCEL').AsString;
            qryAux.ParamByName('SEQBAI').AsInteger:= cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
            qryAux.ParamByName('ESPDOC').AsString := cdsDup.FieldByName('CBI_ESPDOC').AsString;
            qryAux.ParamByName('CODCLI').AsString := cdsDup.FieldByName('CBI_CODCLI').AsString;
            qryAux.ParamByName('CODEMP').AsString := cdsDup.FieldByName('CBI_CODEMP').AsString;

            If not fEmptyStr(strCodEve) then
              qryAux.ParamByName('CODEVE').AsString := strCodEve;

            qryAux.ExecSQL;

            //Gravação do LogCtr
            If not fEmptyStr(cdsDup.FieldByName('AUTOINCREM').AsString) then
              untLogCtr.GravaLogCtr(cdsDup.FieldByName('AUTOINCREM').AsString, 'REMESSA DE INCLUSÃO SPC BRASIL', Self.Name);

          End
          Else
          Begin
            strCodEve := fRetornaCodEvento(RightStr(cdsDup.FieldByName('CBI_MOTSPC').AsString, 2), 'SPC');

            strSQL := strSQL + ' UPDATE ';
            strSQL := strSQL + '   CADREC ';
            strSQL := strSQL + ' SET ';
            strSQL := strSQL + '   CTR_DTASPC = :DATA, ';
            strSQL := strSQL + '   CTR_DTCSPC = NULL, ';
            strSQL := strSQL + '   CTR_STSSPC = "E" ';

            If not fEmptyStr(strCodEve) then
              strSQL := strSQL + '   , CTR_CODEVE = :CODEVE '
            ELSE
              strSQL := strSQL + '   , CTR_CODEVE = NULL ';

            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
            strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
            strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
            strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
            strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
            strSQL := strSQL + '   CTR_CODEMP = :CODEMP ';

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add(strSQL);
            qryAux.ParamByName('DATA').AsDate      := VS_Date;
            qryAux.ParamByName('NUMDUP').AsString  := cdsDup.FieldByName('CBI_NUMDUP').AsString;
            qryAux.ParamByName('PARCEL').AsString  := cdsDup.FieldByName('CBI_PARCEL').AsString;
            qryAux.ParamByName('SEQBAI').AsInteger := cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
            qryAux.ParamByName('ESPDOC').AsString  := cdsDup.FieldByName('CBI_ESPDOC').AsString;
            qryAux.ParamByName('CODCLI').AsString  := cdsDup.FieldByName('CBI_CODCLI').AsString;
            qryAux.ParamByName('CODEMP').AsString  := cdsDup.FieldByName('CBI_CODEMP').AsString;

            If not fEmptyStr(strCodEve) then
              qryAux.ParamByName('CODEVE').AsString := strCodEve;

            qryAux.ExecSQL;

            strSQL := AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC');

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add(strSQL);
            qryAux.ParamByName('DATA').AsDate     := VS_Date;
            qryAux.ParamByName('NUMDUP').AsString := cdsDup.FieldByName('CBI_NUMDUP').AsString;
            qryAux.ParamByName('PARCEL').AsString := cdsDup.FieldByName('CBI_PARCEL').AsString;
            qryAux.ParamByName('SEQBAI').AsInteger:= cdsDup.FieldByName('CTR_SEQBAI').AsInteger;
            qryAux.ParamByName('ESPDOC').AsString := cdsDup.FieldByName('CBI_ESPDOC').AsString;
            qryAux.ParamByName('CODCLI').AsString := cdsDup.FieldByName('CBI_CODCLI').AsString;
            qryAux.ParamByName('CODEMP').AsString := cdsDup.FieldByName('CBI_CODEMP').AsString;

            If not fEmptyStr(strCodEve) then
              qryAux.ParamByName('CODEVE').AsString := strCodEve;

            qryAux.ExecSQL;

            //Gravação do LogCtr
            If not fEmptyStr(cdsDup.FieldByName('AUTOINCREM').AsString) then
              untLogCtr.GravaLogCtr(cdsDup.FieldByName('AUTOINCREM').AsString, 'REMESSA DE EXCLUSÃO SPC BRASIL', Self.Name);

          End;
          cdsDup.Next;
          FreeAndNil(qryGen);
        End;

        mArquivo := TStringList.Create;
        mArquivo.Text := strHeader + #13 + strDetalhe + strTrailler;
        mArquivo.SaveToFile(Path + '\' + Arquivo);
        Result := FileExists(Path + '\' + Arquivo);

        strSQL := '';
        strSQL := strSQL + ' DELETE FROM CADCBI WHERE CBI_CODBCO = "SPC" ';

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

        FreeAndNil(qryAux);

        //Atualiza código de remessa no cnfbco
        Inc(intSeqRem);
        strSeqRem := IntToStr(intSeqRem);

        if Length(strSeqRem) < 8 then
          strSeqRem := fStrZero(strSeqRem, 8);

        fGetBancoConfig(1, 'CONFIGSPC', 'PROXNUM', strSeqRem);

        pBackupCnfBco;

        fCommit;
      Except
        ON E: Exception Do
        Begin
          fRollBack;
          Raise Exception.Create(E.Message);
        End;
      End;
    end
    else
      Result := False;

  finally
    mArquivo.Free;
    FreeAndNil(cdsDup);
    FreeAndNil(pvdDup);
  end;
end;

procedure TfrmExpArqSPC.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(fraPathRemessa);
end;

procedure TfrmExpArqSPC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Then
                 self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExpArqSPC.FormShow(Sender: TObject);
begin
  inherited;

  strCodEntidade  := fGetBancoConfig(0, 'CONFIGSPC', 'CODENTI', '');
  strCodAssociado := fGetBancoConfig(0, 'CONFIGSPC', 'CODASSO', '');
  strPath         := fGetBancoConfig(0, 'CONFIGSPC', 'PATHREM', '');

  if Length(strCodEntidade) < 5 then
    strCodEntidade := fStrZero(strCodEntidade,05);

  if Length(strCodAssociado) < 8 then
    strCodAssociado := fStrZero(strCodAssociado,08);

  fraPathRemessa.edtDirectory.text := strPath;
  edtNomArquivo.Text  := strCodAssociado + '_' + strCodEntidade + '_' + FormatDateTime('yyyymmdd', VS_Date) + '_' + FormatDateTime('HHMM', fTime()) + '.TXT';
end;

function TfrmExpArqSPC.fRetornaCodEvento(strCodOco, strCodBco: String): String;
VAR
  qryCons: TUniquery;
begin
  qryCons := fCriaQuery;

  With qryCons Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT RET_CODEVE FROM OCORET WHERE RET_CODOCO = :CODOCO AND RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP ');
    ParamByName('CODOCO').AsString := strCodOco;
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    Result := FieldByName('RET_CODEVE').AsString;
  End;

  FreeAndNil(qryCons);
end;

end.
