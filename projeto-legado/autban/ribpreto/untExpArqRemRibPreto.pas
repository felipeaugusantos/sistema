unit untExpArqRemRibPreto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Menus, Buttons, ExtCtrls, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem,
  JvExMask, JvToolEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemRibPreto = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;

  end;

var
  frmExpArqRemRibPreto: TfrmExpArqRemRibPreto;

implementation

uses untFuncoes, untfuncoesSimples,  DB;

{$R *.dfm}

procedure TfrmExpArqRemRibPreto.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'ARQ01.TXT';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemRibPreto.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
//    strCodAgen  : String;
    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strNosNum1  : String;
    strNosNum2  : String;
    strInstru1  : String;
    strInstru2  : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    strCodAgenCob  :String;
    strDigAgenCob  :String;
    strDiaPro      : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;

    strNumDup   : String;
    strMensa1   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;

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

  strCodBco     := '741';
  strNomBco     := 'BANCO RIB PRETO';
  strNomEmp     := fRetNomeEmpresa(VS_strCodEmp);
  strContBco    := Trim(fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'CODEMPR', ''));
  strDtaRem     := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strCodAgenCob := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgenCob := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'DIGAGEN', '');
  strInstru1    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fArqIniAutban(0, 'CONFIG409', 'RELOCAL', '') = 'N' );


  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try

    qryRemessa := fCriaQuery(Self);


    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B, ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    //strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL,'CADCBI','CADCBIX');

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;



    //*************************************************//
    // SE O CODIGO DA MENSAGEM FOR 94 ENTAO DEVE IMP.  //
    // A MENSAGEM DE MULTA, PRESENTE NA OBSERV. 1      //
    //**********************************************ED*//
    strMensa1 := qryRemessa.FieldByName('CLI_NOMCLI').AsString;
    Try

      If StrToInt( strInstru1 ) = 94 Then
        strMensa1 := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'OBSERV1', '');

    Except

    End;



    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************LB*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001..001
                   fPadR   ('1'                , 001)      + //002..002
                   fPadR   ('REMESSA'          , 007)      + //003..009
                   fPadR   ('01'               , 002)      + //010..011
                   fPadR   ('COBRANCA'         , 015)      + //012..026
                   fPadR   (strContBco         , 020)      + //027..046
                   fPadR   (strNomEmp          , 030)      + //047..076
                   fPadR   (strCodBco          , 003)      + //077..079
                   fPadR   (strNomBco          , 015)      + //080..094
                   fPadR   (strDtaRem          , 006)      + //095..100
                   fPadR   (''                 , 294)      + //101..394
                   fStrZero(IntToStr(intCodSeq), 006);       //395

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
      Writeln(txtTexto,strHeader);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************LB*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);


          strCodCar := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'CODCART', '');
          strDiaPro := fArqIniAutban(0, 'CONFIG741-' + IntToStr(intCartei), 'DIAPROT', '');

          strNosNum1 := fStrZero('0',08);
          strNosNum2 := '';
          {***************************************************}
          {* SE O COD. CARTEIRA = 6 DEVERA PREENCHER O NOSSO *}
          {* NUMERO, CASO CONTRARIO PREENCHE COM ZEROS       *}
          {************************************************LB*}
          If (strCodCar = '6') Then
          Begin
            strNosNum1 := fStrZero(FieldByName('CBI_NOSNUM').AsString, 8);
          End;

          strNosNum2 := fStrZero(FieldByName('CBI_NOSNUM').AsString, 13);


          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          strSeqTit := fStrZero(fAtuCodSeq('CONFIG033', 'PROXNUM'), 7);

          strKeyDup := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_ESPDOC').AsString +
                       FieldByName('CBI_CODEMP').AsString +
                       FieldByName('CBI_CODCLI').AsString;

          If FieldByName('CBI_ESPDOC').AsString = 'MI' Then
            strNumDup := FieldByName('CBI_NUMDUP').AsString + FieldByName('CBI_PARCEL').AsString + '/4'

          Else If FieldByName('CBI_ESPDOC').AsString = 'FF' Then
            strNumDup := FieldByName('CBI_NUMDUP').AsString + FieldByName('CBI_PARCEL').AsString + '/3'

          Else If FieldByName('CBI_ESPDOC').AsString = 'AG' Then
            strNumDup := FieldByName('CBI_NUMDUP').AsString + FieldByName('CBI_PARCEL').AsString + '/2'
            
          Else
            strNumDup := FieldByName('CBI_NUMDUP').AsString + FieldByName('CBI_PARCEL').AsString + '/1';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          strTransacao := fPadR      ('1'                                  ,01)       + //001..001
                          fPadR      ('02'                                 ,02)       + //002..003
                          fPadL      (strCgcEmp                            ,14, '0')  + //004..017
                          fPadR      (strContBco                           ,20)       + //018..037
                          fPadR      (strKeyDup                            ,25)       + //038..062
                          fStrZero   (strNosNum1                           ,08)       + //063..070
                          fStrZero   (strNosNum2                           ,13)       + //071..083
                          fPadR      (''                                   ,03)       + //084..086
                          fPadR      (''                                   ,21)       + //087..107
                          fPadR      ('4'                                  ,01)       + //108..108
                          fPadR      ('01'                                 ,02)       + //109..110
                          fPadR      (strNumDup                            ,10)       + //111..120
                          fPadR      (strDtaVen                            ,06)       + //121..126
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    ,13)       + //127..139
                          fPadR      ('237'                                ,03)       + //140..142
                          fStrZero   ('0'                                  ,04)       + //143..146
                          fPadR      ('0'                                  ,01)       + //147..147
                          fPadR      ('01'                                 ,02)       + //148..149
                          fPadR      ('N'                                  ,01)       + //150..150
                          fPadR      (strDtaEmi                            ,06)       + //151..156
                          fPadR      (strInstru1                           ,02)       + //157..158
                          fPadR      (strInstru2                           ,02)       + //159..160
                          fValNumForm(fltValAtr                            ,13)       + //161..173
                          fStrZero   ('0'                                  ,06)       + //174..179
                          fValNumForm(0                                    ,13)       + //180..192
                          fValNumForm(0                                    ,13)       + //193..205
                          fValNumForm(0                                    ,13)       + //206..218
                          fStrZero   (strCpfCgc                            ,02)       + //219..220
                          fPadL      (strCgcCli                            ,14, '0')  + //221..234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   ,30)       + //235..264
                          fPadR      (''                                   ,10)       + //265..274
                          fPadR      (FieldByName('ENDERE').AsString       ,40)       + //275..314
                          fPadR      (FieldByName('BAIRRO').AsString       ,12)       + //315..326
                          fPadR      (FieldByName('C_E_P_').AsString       ,08, '0')  + //327..334
                          fPadR      (FieldByName('CIDADE').AsString       ,15)       + //335..349
                          fPadR      (FieldByName('ESTADO').AsString       ,02)       + //350..351
                          fPadR      (strMensa1                            ,40)       + //352..381
                          fStrZero   (strDiaPro                            ,02)       + //392..393
                          fPadR      ('0'                                  ,01)       + //394..394
                          fStrZero   (IntToStr(intCodSeq)                  ,06);        //395..400


          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          Writeln(txtTexto,strTransacao);

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********LB*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001..001
                     fPadR   (' '                , 393) + //002..394
                     fStrZero(IntToStr(intCodSeq), 006);  //395..400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************LB*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        ExecSQL;
        Close;

        strSQL := AnsiReplaceStr(strSQL, 'CADCBI', 'CADCBIX');

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        ExecSQL;
        Close;
      End;


    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

  Finally
    FreeAndNil(qryRemessa);
  End;

end;

procedure TfrmExpArqRemRibPreto.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);
end;

procedure TfrmExpArqRemRibPreto.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndicePor: TStringList;
    stlDesIndPor: TStringList;
    strSQL: String;
begin
  inherited;
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  POR_CODPOR AS "Código", ';
    strSQL := strSQL + '  POR_NOMPOR AS "Nome", ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  CADPOR  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE  ';

  If fEntraCons(Key) Then
  Begin

    Try

      stlIndicePor := TStringList.Create;
      stlDesIndPor := TStringList.Create;

      Key := #0;
      stlIndicePor.Add('POR_NOMPOR');
      stlIndicePor.Add('POR_CODPOR');
      stlDesIndPor.Add('Nome');
      stlDesIndPor.Add('Código');


      If pConsultaComp(Self, qryCadPor,'CADPOR',strSQL, stlIndicePor, stlDesIndPor) Then
      Begin
        edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
        Self.SelectNext((Sender As TWinControl), True, True);
      End;

    Finally
      FreeAndNil(stlIndicePor);
      FreeAndNil(stlDesIndPor);
    End;

  End;

end;

function TfrmExpArqRemRibPreto.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADEMP');
    Open;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;


procedure TfrmExpArqRemRibPreto.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
