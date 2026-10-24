unit untExpRemessaBancoBrasilPGG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Uni, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository, 
  untFrameDirectoryEditFocus,untFuncAutban;

type
  TfrmExpRemessaBancoBrasilPGG = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    qryConsultaGen : TUniQuery;
     function fGetCodigoUF(UF : String): String;
     function CaseOfString(s: string; a: array of string): Integer;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpRemessaBancoBrasilPGG: TfrmExpRemessaBancoBrasilPGG;

implementation

uses untFuncoes, untfuncoesSimples, DB, untFuncoesBoleto, untLogCtp;

{$R *.dfm}

function TfrmExpRemessaBancoBrasilPGG.CaseOfString(s: string; a: array of string): Integer;
begin
  Result := 0;

  while (Result < Length(a)) and (a[Result] <> s) do
    Inc(Result);

  if (a[Result] <> s) then
    Result := -1;
end;

function TfrmExpRemessaBancoBrasilPGG.fGetCodigoUF(UF : String): String;
  Var
    LEstados : array[0..26] of string;
begin

// Preenchendo o vetor.
  LEstados[0] := 'AC';
  LEstados[1] := 'AL';
  LEstados[2] := 'AP';
  LEstados[3] := 'AM';
  LEstados[4] := 'BA';
  LEstados[5] := 'CE';
  LEstados[6] := 'DF';
  LEstados[7] := 'ES';
  LEstados[8] := 'GO';
  LEstados[9] := 'MA';
  LEstados[10] := 'MT';
  LEstados[11] := 'MS';
  LEstados[12] := 'MG';
  LEstados[13] := 'PA';
  LEstados[14] := 'PB';
  LEstados[15] := 'PR';
  LEstados[16] := 'PE';
  LEstados[17] := 'PI';
  LEstados[18] := 'RN';
  LEstados[19] := 'RS';
  LEstados[20] := 'RJ';
  LEstados[21] := 'RO';
  LEstados[22] := 'RR';
  LEstados[23] := 'SC';
  LEstados[24] := 'SP';
  LEstados[25] := 'SE';
  LEstados[26] := 'TO';


  Case CaseOfString(UF, LEstados) Of
    0 : Result := '01-9';
    1 : Result := '02-7';
    2 : Result := '03-5';
    3 : Result := '04-3';
    4 : Result := '05-1';
    5 : Result := '06-0';
    6 : Result := '07-8';
    7 : Result := '08-6';
    8 : Result := '10-8';
    9 : Result := '12-4';
    10 : Result := '13-2';
    11 : Result := '28-0';
    12 : Result := '14-0';
    13 : Result := '15-9';
    14 : Result := '16-7';
    15 : Result := '17-5';
    16 : Result := '18-3';
    17 : Result := '19-1';
    18 : Result := '20-5';
    19 : Result := '21-3';
    20 : Result := '22-1';
    21 : Result := '23-0';
    22 : Result := '24-8';
    23 : Result := '25-6';
    24 : Result := '26-4';
    25 : Result := '27-2';
    26 : Result := '29-9';
  End;

end;

procedure TfrmExpRemessaBancoBrasilPGG.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoConfig(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'PROXNUM', ''), 08) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

procedure TfrmExpRemessaBancoBrasilPGG.btnGerarClick(Sender: TObject);
  Var
    strSQL         : String;
    strCodBco      : String;
    strNomBco      : String;
    strNomEmp      : String;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaVen      : String;
    strDtaEmi      : String;

    strDigAge      : String;
    strCodCar      : String;
    strNosNum      : String;
    strEndEmp      : String;
    strNumEmp      : String;
    strComEmp      : String;
    strCidEmp      : String;
    strCepEmp      : String;
    strEstEmp      : String;
    strDtaPag      : String;
    strSeqArq      : String;
    strIdeBco      : String;
    strNumMCI      : String;
    strFatVen      : String;
    strKeyDup      : String;

    strHeader      : String;
    strTransacao   : String;
    strTrailler    : String;

    intTipIns      : Integer;
    intSeqReg      : Integer;
    fltValPagTot   : Double;
    txtTexto       : TextFile;

    qryRemessa     : TUniQuery;

    strFilePath : String;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;
    strCodTrib : String;
    strNumeroBanco : String;
    strCompet : String;
begin
  inherited;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '001';
  strNomBco  := 'BANCO DO BRASIL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strIdeBco  := fGetBancoConfig(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'IDENTBC', '');
  strNumMci  := fGetBancoConfig(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'NUMMCI', '');
  strSeqArq  := fGetBancoConfig(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'PROXNUM', '');
  strDtaRem  := FormatDateTime('yyyy',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('dd',VS_Date);
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());

  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************JU*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Ok']);
    Exit;
  End;

  Try

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strEndEmp := qryConsultaGen.FieldByName('EMP_ENDERE').AsString;
    strNumEmp := qryConsultaGen.FieldByName('EMP_ENDNUM').AsString;
    strComEmp := qryConsultaGen.FieldByName('EMP_ENDCMP').AsString;
    strCidEmp := qryConsultaGen.FieldByName('CID_NOMCID').AsString;
    strCepEmp := fTiraCaracEspeciais(qryConsultaGen.FieldByName('EMP_C_E_P_').AsString);
    strEstEmp := qryConsultaGen.FieldByName('CID_ESTADO').AsString;
    qryConsultaGen.Close;


    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  B.*,                     ';
    strSQL := strSQL + '  F.FOR_NOMFOR,            ';
    strSQL := strSQL + '  F.FOR_ENDERE AS ENDERE,  ';
    strSQL := strSQL + '  F.FOR_BAIRRO AS BAIRRO,  ';
    strSQL := strSQL + '  F.FOR_C_E_P_ AS C_E_P_,  ';
    strSQL := strSQL + '  F.FOR_ENDCOM AS COMPLEMENTO, ';
    strSQL := strSQL + '  F.FOR_ENDNUM AS NUMERO,  ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS CGCCPF,  ';
    strSQL := strSQL + '  F.FOR_C_G_C_ AS CODCGC,  ';
    strSQL := strSQL + '  D.BCF_CAMCEN AS CAMCEN,  ';
    strSQL := strSQL + '  D.BCF_CODBCO AS CODBCO,  ';
    strSQL := strSQL + '  D.BCF_NUMAGE AS CODAGE,  ';
    strSQL := strSQL + '  D.BCF_DIGAGE AS DIGAGE,  ';
    strSQL := strSQL + '  D.BCF_NUMCTA AS NUMCTA,  ';
    strSQL := strSQL + '  D.BCF_DIGCTA AS DIGCTA,  ';
    strSQL := strSQL + '  D.BCF_DIGVER AS DIGVER,  ';
    strSQL := strSQL + '  D.BCF_COMPDES AS COMPDES, ';
    strSQL := strSQL + '  C.CID_NOMCID AS CIDADE,  ';
    strSQL := strSQL + '  C.CID_ESTADO AS ESTADO,  ';
    strSQL := strSQL + '  B.PGI_FORPGT AS FORMAPAGTO, ';
    strSQL := strSQL + '  IF(B.PGI_FORPGT = "DEP",PGI_CODBCO,LEFT(PGI_CODBAR, 3)) AS CODBAN ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADPGI B                 ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
    strSQL := strSQL + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  PGI_BCOPGG = PGI_CODBCO AND ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO     ';

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add(strSQL);
    qryRemessa.ParamByName('CODBCO').AsString := strCodBco;
    qryRemessa.Open;

    If Not qryRemessa.IsEmpty Then
    Begin
      fStartTransaction;

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      intSeqReg := 1;

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************JU*}
      strHeader := '';
      strHeader := fPadR   ('A'                , 001)      + //Tipo de registro 001 001 X(001) "A"
                   fPadR   ('REC300'           , 006)      + //Nome do arquivo 002 007 X(006) "REC300"
                   fPadL   ('99'               , 002)      + //Tipo de arquivo 008 009 9(002) GNRE - " 99 "
                   fPadL   ('01'               , 002)      + //Tipo de Serviço 010 011 9(002) Pagamento - " 01 "
                   fPadL   (strDtaRem          , 008)      + //Data da remessa 012 019 9(008) Data da remessa ( AAAAMMDD )
                   fPadL   (strSeqArq          , 006, '0') + //Sequencial da remessa 020 025 9(006) Nº. sequencial diário .Não pode seR repetido
                   fPadL   (strIdeBco          , 006, '0') + //Número do convênio 026 031 9(006) Fornecido pelo BB
                   fPadL   (strNumMci          , 009, '0') + //Número do MCI 032 040 9(009) Fornecido pelo BB
                   fPadR   (strNomEmp          , 030)      + //Nome do convenente 041 070 X(030) Nome da empresa ( Razão Social )
                   fPadL   ('0'                , 009, '0') + //Sequencial do IED 071 079 9(009) Preencher com zeros
                   fPadL   ('0'                , 009, '0') + //Remessa do BB Office 080 088 9(009) Preencher com zeros
                   fPadL   ('0'                , 009, '0') + //Sequencial de retorno do IED 089 097 9(009) Preencher com zeros
                   fPadR   (' '                , 173, ' ') + //Filler 098 270 X(173) Brancos
                   fPadL   (strSeqArq          , 006, '0') + //Sequencial da remessa 271 276 9(006) Nº. sequencial diário .Não pode ser repetido
                   fPadR   (' '                , 006, ' ') + //Filler 277 282 X(006) Brancos
                   fPadR   (' '                , 005, ' ') + //Tipo de movimento 283 287 X(005) Brancos
                   fPadR   (' '                , 008, ' ') + //Versão do aplicativo 288 295 X(008) Brancos
                   fPadL   (IntToStr(intSeqReg), 005, '0');  //Sequencial 296 300 9(005) Nº. Sequencial em lote iniciado em 1.

      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {****************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

      fltValPagTot := 0;

      {***********************}
      {* REGISTRO DE DETALHE *}
      {********************JU*}

      strTransacao := '';

      While Not qryRemessa.Eof Do
      Begin
        Inc(intSeqReg);

        Application.ProcessMessages;

        fltValPagTot := fltValPagTot + qryRemessa.FieldByName('PGI_VALPAG').AsFloat;

        strDtaVen := FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('dd',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);

        strDtaEmi := FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                     FormatDateTime('dd',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime);

        strDtaPag := FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('dd',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);


        strKeyDup  := qryRemessa.FieldByName('PGI_AUTOIN').AsString;
        strCodTrib := qryRemessa.FieldByName('PGI_CODREC').asString;


        strNumeroBanco := qryRemessa.FieldByName('PGI_NUMDUP').AsString +
                          qryRemessa.FieldByName('PGI_PARCEL').AsString +
                          qryRemessa.FieldByName('PGI_CODEMP').AsString +
                          fPadR(qryRemessa.FieldByName('PGI_SERIE_').AsString, 3, '_');

        strCompet := Copy(qryRemessa.FieldByName('PGI_COMPET').asString,1,2)+
                     Copy(qryRemessa.FieldByName('PGI_COMPET').asString,4,4);


        intTipIns := IIF((Length(qryRemessa.FieldByName('CODCGC').AsString) > 11),2,1);

        strTransacao := fPadR      ('G'                                      , 01)      + //Tipo de registro 001 001 X(001) "G"
                        fPadL      (LeftStr(fGetCodigoUF(qryRemessa.FieldByName('ESTADO').AsString),2), 02)  + //Código da UF ( * ) 002 003 9(002) Código da Unidade Federativa
                        fPadR      (RightStr(fGetCodigoUF(qryRemessa.FieldByName('ESTADO').AsString),1), 01) + //DV da UF 004 004 X(001) Dígito verificador da UF
                        fPadR      (strKeyDup                                , 25)      + //Identificador da guia 005 029 X(025) Atribuído pelo cliente
                        fPadL      (strCodTrib                               , 06)      + //Código da receita 030 034 9(005) Código da receita Estadual
                        fPadL      (IntToStr(intTipIns)                      , 01)      + //Indicador de CPF / CGC 036 036 9(001) 1 = CPF ou 2 = CGC
                        fPadL      (qryRemessa.FieldByName('CODCGC').AsString, 14,'0')  + //Número do CPF / CGC 037 050 9(014) Número do CPF ou CGC
                        fPadR      (strNumeroBanco                           , 15)      + //Número do documento 051 065 X(015) Atribuído pelo cliente
                        fPadL      (strCompet                                , 06)      + //Período de referência 066 071 9(006) Período - mês e ano ( MMAAAA )
                        fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat, 11)   + //Valor principal 072 082 9(009) V9(02) Valor principal da guia
                        fValNumForm(0                                        , 11)      + //Valor de atualização monetária 083 093 9(009) V9(02) Valor de atualização monetária da guia
                        fValNumForm(0                                        , 11)      + //Valor do juros 094 104 9(009) V9(02) Valor do juros
                        fValNumForm(0                                        , 11)      + //Valor da multa 105 115 9(009) V9(02) Valor da multa
                        fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat, 11)   + //Valor Total 116 126 9(009) V9(02) Valor total da guia
                        fPadR      (strDtaVen                                , 08)      + //Data do vencimento 127 134 X(008) Data do vencimento ( AAAAMMDD )
                        fPadR      (strDtaPag                                , 08)      + //Data do pagamento 135 142 X(008) Data do pagamento ( AAAAMMDD )
                        fPadR      ('01'                                     , 02)      + //Tipo de recibo 143 144 X(002) GNRE - " 01 "
                        fPadR      (qryRemessa.FieldByName('FOR_NOMFOR').AsString, 35)  + //Nome do contribuinte 145 179 X(035) Nome do contribuinte
                        fPadR      (qryRemessa.FieldByName('CODCGC').AsString , 20)     + //Inscrição estadual 180 199 X(020) Número da inscrição estadual
                        fPadR      (qryRemessa.FieldByName('PGI_CODBAR').AsString, 44)  + //Código de barras 200 243 X(044) Número do código de barras
                        fPadR      (' '                                      , 25, ' ') + //Autorização de débito 244 268 X(025) Número da autorização de débito
                        fPadR      (strDtaPag                                , 08)      + //Data de débito 269 276 X(008) Data de débito ( AAAAMMDD )
                        fValNumForm(qryRemessa.FieldByName('PGI_VALPAG').AsFloat, 11)   + //Valor do débito 277 287 9(009) V9(02) Valor do débito
                        fPadR      (' '                                      , 08 ,' ') + //Filler 288 295 X(008) Brancos
                        fPadL      (IntToStr(intSeqReg)                      , 05, '0');  //Seqüencial 296 300 9(005) Seqüencial de registro incluindo Header .

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************AF*}
        Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

        {****************}
        {* GRAVA LOGCTP *}
        {*************JS*}
        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(qryRemessa.FieldByName('PGI_NUMDUP').AsString,
                                       qryRemessa.FieldByName('PGI_PARCEL').AsString,
                                       qryRemessa.FieldByName('PGI_SEQBAI').AsInteger,
                                       qryRemessa.FieldByName('PGI_CODEMP').AsString,
                                       qryRemessa.FieldByName('PGI_CODFOR').AsString,
                                       qryRemessa.FieldByName('PGI_SERIE_').AsString);

        If Assigned(objPag) Then
        begin
          strGetCodFor := objPag.objCodFor.FOR_CODFOR;
          untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - PGG - ' + strCodBco, Self.Name);
        end;

        If Assigned(objRep) Then
          FreeAndNil(objRep);

        qryRemessa.Next;
      End;

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      Inc(intSeqReg);

      strTrailler := '';
      strTrailler := fPadR      ('Z'                     , 001) + //Tipo de registro 001 001 X(001) " Z "
                     fPadL      (IntToStr(intSeqReg), 006, '0') + //Quantidade de registros 002 007 9(006) Inclui o registro Header e Trailer Filler 008 295 x(288) Brancos
                     fPadR      (' '                     , 288) + //Filler 008 295 x(288) Brancos
                     fPadL      (IntToStr(intSeqReg), 005, '0');  //Sequencial 296 300 9 (005) Sequencial de registro

      {****************************************}
      {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
      {*************************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strTrailler));

      CloseFile(txtTexto);

      strSeqArq := fAtuCodSeq('CONFIGPGG001-' + IntToStr(intCartei), 'PROXNUM');

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_BCOPGG = PGI_CODBCO AND PGI_CODBCO = :CODBCO ';

      qryRemessa.Close;
      qryRemessa.SQL.Clear;
      qryRemessa.SQL.Add(strSQL);
      qryRemessa.ParamByName('CODBCO').AsString := '001';
      qryRemessa.ExecSQL;
      qryRemessa.Close;

      pBackupCnfBco;

      If fCommit then
		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);


    End
    Else
    Begin
      fRollback;
      fMensagem('ATENÇÃO','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);

	  Except
		On E: Exception Do
		Begin

		  fRollBack;

		  While FileExists(strFilePath) do
		  Begin
			  DeleteFile(strFilePath);
		  End;

		  FreeAndNil(qryRemessa);
		  FreeAndNil(qryConsultaGen);
		  pMensagensErro(E.Message,  '[untExpRemessaBancoBrasilPGG.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;
  End;

end;

end.
