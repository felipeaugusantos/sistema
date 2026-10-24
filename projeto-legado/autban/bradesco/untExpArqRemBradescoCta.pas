unit untExpArqRemBradescoCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Uni, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBradescoCta = class(TfrmPai)
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

    procedure pAtribuiDadosBco(strCodBar: String; Var strCodBco: String; Var strCodAge: String; Var strCodCar: String; Var strConCor: String; Var strNosNum: String; Var strFatVen: String);

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemBradescoCta: TfrmExpArqRemBradescoCta;

implementation

uses untFuncoes, untfuncoesSimples, DB, untFuncoesBoleto, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemBradescoCta.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum('CONFIGCTA237-' + IntToStr(intCartei)), 08) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

procedure TfrmExpArqRemBradescoCta.btnGerarClick(Sender: TObject);
  Var
    strSQL         : String;
    strCodBco      : String;
    strNomBco      : String;
    strNomEmp      : String;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaVen      : String;
    strDtaEmi      : String;
    strCgcEmp      : String;
    strCodAgen     : String;
    strContCor     : String;
    strDigCnt      : String;
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
    strCtaCom      : String;
    strFatVen      : String;
    strKeyDup      : String;
    strDigit       : String;

    strCampoLivreCodBar: String;
    strDigitoCodBar    : String;
    strCodMoedaCodBar  : String;

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

  strCodBco  := '237';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'DIGCTAC', '');
  strIdeBco  := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'IDENTBC', '');
  strSeqArq  := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'PROXNUM', '');
  strCtaCom  := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'CONCOMP', '');
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
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strEndEmp := FieldByName('EMP_ENDERE').AsString;
      strNumEmp := FieldByName('EMP_ENDNUM').AsString;
      strComEmp := FieldByName('EMP_ENDCMP').AsString;
      strCidEmp := FieldByName('CID_NOMCID').AsString;
      strCepEmp := fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString);
      strEstEmp := FieldByName('CID_ESTADO').AsString;
      Close;
    End;

  {Finally
    FreeAndNil(qryConsultaGen);
  End;}

  If Length(strCgcEmp) > 11 Then
    intTipIns := 2
  Else
    intTipIns := 1;

//  Try

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT B.*, F.FOR_NOMFOR, F.FOR_ENDERE AS ENDERE, F.FOR_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '       F.FOR_C_E_P_ AS C_E_P_, F.FOR_C_G_C_ AS C_G_C_ , C.CID_NOMCID AS CIDADE, ';
    strSQL := strSQL + '       C.CID_ESTADO AS ESTADO ';
    strSQL := strSQL + 'FROM CADPGI B ';
    strSQL := strSQL + 'LEFT JOIN CADFOR F ON F.FOR_CODFOR = B.PGI_CODFOR ';
    strSQL := strSQL + 'LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + 'WHERE PGI_CODBCO = :CODBCO ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      intSeqReg := 1;

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************JU*}
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 - 001
                   fPadR   (strIdeBco          , 008)      + //002 - 009
                   fPadR   (IntToStr(intTipIns), 001)      + //010 - 010
                   fPadL   (strCgcEmp          , 015, '0') + //011 - 025
                   fPadR   (strNomEmp          , 040)      + //026 - 065
                   fPadR   ('20'               , 002)      + //066 - 067
                   fPadR   ('1'                , 001)      + //068 - 068
                   fPadL   (strSeqArq          , 005, '0') + //069 - 073
                   fPadL   ('0'                , 005, '0') + //074 - 078
                   fPadR   (strDtaRem          , 008)      + //079 - 086
                   fPadR   (strHorRem          , 006)      + //087 - 092
                   fPadR   (' '                , 013)      + //093 - 105
                   fPadR   ('0'                , 001)      + //106 - 106
                   fPadR   (' '                , 371)      + //107 - 477
                   fPadL   (strSeqArq          , 009, '0') + //478 - 486
                   fPadR   (' '                , 008)      + //487 - 494
                   fPadL   (IntToStr(intSeqReg), 006, '0');  //495 - 500

      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {****************************AF*}
      Writeln(txtTexto,strHeader);

      {
      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' LEFT(PGI_CODBAR, 3) = ' + QuotedStr('237');
      qryRemessa.Filtered := True;
       }

      fltValPagTot := 0;

      If Not qryRemessa.IsEmpty Then
      Begin

        {***********************}
        {* REGISTRO DE DETALHE *}
        {********************JU*}
        With qryRemessa Do
        Begin

          strTransacao := '';

          While Not Eof Do
          Begin
            Inc(intSeqReg);

            Application.ProcessMessages;

            fltValPagTot := fltValPagTot + FieldByName('PGI_VALPAG').AsFloat;

            strDtaVen := FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime);

            strDtaEmi := FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime);

            strDtaPag := FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime);

            pAtribuiDadosBco(FieldByName('PGI_CODBAR').AsString, strCodBco, strCodAgen, strCodCar, strContCor, strNosNum, strFatVen);

            strDigit  := '';
            strDigCnt := fCalcDigitoModulo11(strContCor, strDigit);
            strDigit  := '';
            strDigAge := fCalcDigitoModulo11(strCodAgen, strDigit);

            strKeyDup := FieldByName('PGI_AUTOIN').AsString;

            strCampoLivreCodBar := Copy(FieldByName('PGI_CODBAR').AsString, 20, 25);
            strDigitoCodBar     := Copy(FieldByName('PGI_CODBAR').AsString,  5, 1);
            strCodMoedaCodBar   := Copy(FieldByName('PGI_CODBAR').AsString,  4, 1);


            If Length(FieldByName('C_G_C_').AsString) > 11 Then
              intTipIns := 2
            Else
              intTipIns := 1;

            strTransacao := fPadR      ('1'                                      , 01)      + //001 - 001
                            fPadR      (IntToStr(intTipIns)                      , 01)      + //002 - 002
                            fPadL      (FieldByName('C_G_C_').AsString      , 15, '0')      + //003 - 017
                            fPadR      (FieldByName('FOR_NOMFOR').AsString       , 30)      + //018 - 047
                            fPadR      (FieldByName('ENDERE').AsString           , 40)      + //048 - 087
                            fPadR      (FieldByName('C_E_P_').AsString           , 08)      + //088 - 095
                            fPadR      (strCodBco                                , 03)      + //096 - 098
                            fPadL      (strCodAgen                          , 05, '0')      + //099 - 103
                            fPadL      (strDigAge                           , 01, '0')      + //104 - 104
                            fPadL      (strContCor                          , 13, '0')      + //105 - 117
                            fPadR      (strDigCnt                           , 02, ' ')      + //118 - 119
                            fPadL      (FieldByName('PGI_NUMDUP').AsString +
                                        FieldByName('PGI_PARCEL').AsString +
                                        FieldByName('PGI_CODFOR').AsString       , 16)      + //120 - 135
                            fPadL      (strCodCar                           , 03, '0')      + //136 - 138
                            fPadL      (strNosNum                           , 12, '0')      + //139 - 150
                            fStrZero   ('0'                                      , 15)      + //151 - 165
                            fPadL      (strDtaVen                                , 08)      + //166 - 173
                            fPadL      ('0'                                 , 08, '0')      + //174 - 181
                            fPadL      ('0'                                 , 08, '0')      + //182 - 189
                            fPadL      ('0'                                      , 01)      + //190 - 190
                            fPadL      (strFatVen                                , 04)      + //191 - 194
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 10)      + //194 - 204
                            fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //205 - 219
                            fPadL      ('0'                                 , 15, '0')      + //220 - 234
                            fPadL      ('0'                                 , 15, '0')      + //235 - 249
                            fPadR      ('04'                                     , 02)      + //250 - 251
                            fPadR      (' '                                      , 10)      + //252 - 261
                            fPadR      (' '                                      , 02)      + //262 - 263
                            fPadR      ('31'                                     , 02)      + //264 - 265
//                            fPadR      (IIF(strCodBco = '237', '30', '31')       , 02)      + //264 - 265
                            fPadR      ('0'                                 , 08, '0')      + //266 - 273
                            fPadR      (' '                                      , 03)      + //274 - 276
                            fPadR      ('01'                                     , 02)      + //277 - 278
                            fPadR      (' '                                      , 10)      + //279 - 288
                            fPadR      ('0'                                      , 01)      + //289 - 289
                            fPadR      ('0'                                 , 02, '0')      + //290 - 291
                            fPadR      (' '                                      , 04)      + //292 - 295
                            fPadR      (' '                                      , 15)      + //296 - 310
                            fPadR      (' '                                      , 15)      + //311 - 325
                            fPadR      (' '                                      , 06)      + //326 - 331
                            fPadR      (' '                                      , 40)      + //332 - 371
                            fPadR      (' '                                      , 02)      + //372 - 373
                            fPadR      (strCampoLivreCodBar                      , 25)      + //374 - 398
                            fPadR      (strDigitoCodBar                          , 01)      + //399 - 399
                            fPadR      (strCodMoedaCodBar                        , 01)      + //400 - 400
                            fPadR      (' '                                      , 13)      + //401 - 413
                            fPadR      (' '                                      , 02)      + //414 - 415
                            fPadR      (strKeyDup                                , 35)      + //416 - 450
                            fPadR      (' '                                      , 22)      + //451 - 472
                            fPadR      ('0'                                 , 05, '0')      + //473 - 477
                            fPadR      (' '                                      , 01)      + //478 - 478
                            fPadR      ('0'                                      , 01)      + //479 - 479
                            fPadR      (IIF(Not fEmptyStr(strCtaCom),strCtaCom,'0')
                                                                            , 07, '0')      + //480 - 486
                            fPadR      (' '                                      , 08)      + //487 - 494
                            fPadL      (IntToStr(intSeqReg)                 , 06, '0');       //495 - 500

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto,strTransacao);

            {****************}
            {* GRAVA LOGCTP *}
            {*************JS*}
            objRep := TCadPagRepository.Create;
            objPag := objRep.fRetDuplicata(FieldByName('PGI_NUMDUP').AsString,
                                           FieldByName('PGI_PARCEL').AsString,
                                           FieldByName('PGI_SEQBAI').AsInteger,
                                           FieldByName('PGI_CODEMP').AsString,
                                           FieldByName('PGI_CODFOR').AsString,
                                           FieldByName('PGI_SERIE_').AsString);

            If Assigned(objPag) Then
            begin
              strGetCodFor := objPag.objCodFor.FOR_CODFOR;
              untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, Self.Name);
            end;

            If Assigned(objRep) Then
              FreeAndNil(objRep);

            Next;
          End;

        End;

      End;

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      Inc(intSeqReg);

      strTrailler := '';
      strTrailler := fPadR      ('9'                     , 001) + //001 - 001
                     fPadL      (IntToStr(intSeqReg), 006, '0') + //002 - 007
                     fValNumForm(fltValPagTot            , 017) + //008 - 024
                     fPadR      (' '                     , 470) + //025 - 495
                     fPadL      (IntToStr(intSeqReg), 006, '0');  //496 - 500

      {****************************************}
      {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
      {*************************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
}
      strSeqArq := fAtuCodSeq('CONFIGCTA237-' + IntToStr(intCartei), 'PROXNUM');

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := '237';
        ExecSQL;
        Close;
      End;

      pBackupCnfBco;

      If fCommit then
		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);


    End
    Else
    Begin
      fRollback;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

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
		  pMensagensErro(E.Message,  '[untExpArqRemBradescoCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;
  End;

end;

procedure TfrmExpArqRemBradescoCta.pAtribuiDadosBco(strCodBar: String; var strCodBco, strCodAge, strCodCar, strConCor, strNosNum, strFatVen: String);
begin

  strCodBco := LeftStr(strCodBar, 3);
  strFatVen := Copy(strCodBar, 6, 4);

  If (strCodBco = '237') Then
  Begin
    strCodAge := Copy(strCodBar, 20, 04);
    strCodCar := Copy(strCodBar, 24, 02);
    strNosNum := Copy(strCodBar, 26, 11);
    strConCor := Copy(strCodBar, 37, 07);
  End
  Else
  Begin
    strCodAge := '';
    strCodCar := '';
    strNosNum := '';
    strConCor := '';
  End;

end;

end.
