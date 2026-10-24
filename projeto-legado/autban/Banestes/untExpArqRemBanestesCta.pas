{******************************************************}
{* ATENÇÃO, ESSE BANCO NÃO ESTÁ PREPARADO PARA CARNET *}
{***************************************************AF*}
unit untExpArqRemBanestesCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBanestesCta = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;

    { Private declarations }
  public
    { Public declarations }
    strNomForm,
    strConfig : String;
    
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBanestesCta: TfrmExpArqRemBanestesCta;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemBanestesCta.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, strConfig, 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum(strConfig), 08) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemBanestesCta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemBanestesCta.btnGerarClick(Sender: TObject);
  Var
    strSQL         : String;
    strCodBco      : String;
    strNomBco      : String;
    strNomEmp      : String;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaVen      : String;
    strDtaEmi      : String;
    strDtaPag      : String;
    strSeqArq      : String;
    strIdeBco      : String;
    strKeyDup      : String;

    strHeader      : String;
    strTransacao   : String;
    strTrailler    : String;
    strTipIns      : String;
    strAvisaFor    : String;

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

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco   := '021';
  strNomBco   := 'BANESTES S.A';
  strNomEmp   := fRetNomeEmpresa(VS_strCodEmp);
  strIdeBco   := fGetBancoConfig(0, strConfig, 'IDENTBC', '');
  strSeqArq   := fGetBancoConfig(0, strConfig, 'PROXNUM', '');
  strAvisaFor := fGetBancoConfig(0, strConfig, 'AVISAFOR', '');
  strDtaRem   := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem   := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());

  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT B.*, F.FOR_NOMFOR, F.FOR_ENDERE AS ENDERE, F.FOR_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '       F.FOR_C_E_P_ AS C_E_P_, F.FOR_C_G_C_ AS C_G_C_ , C.CID_NOMCID AS CIDADE, ';
    strSQL := strSQL + '       C.CID_ESTADO AS ESTADO, E.EMP_C_G_C_ ';
    strSQL := strSQL + 'FROM CADPGI B ';
    strSQL := strSQL + 'JOIN CADFOR F ON F.FOR_CODFOR = B.PGI_CODFOR      ';
    strSQL := strSQL + 'JOIN CADEMP E ON E.EMP_CODEMP = B.PGI_CODEMP      ';
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
      {***************************JS*}
      strHeader := '';
      strHeader := fPadR   ('0'                                    , 001)      + //001 - 001
                   fPadR   ('1'                                    , 001)      + //002 - 002
                   fPadR   ('REMESSA'                              , 007)      + //003 - 009
                   fPadR   ('11'                                   , 002)      + //010 - 011
                   fPadR   ('PAGAMENTOS'                           , 015, ' ') + //012 - 026
                   fPadL   (strIdeBco                              , 011, '0') + //027 - 037
                   fPadR   (' '                                    , 009)      + //038 - 046
                   fPadR   (strNomEmp                              , 030, ' ') + //047 - 076
                   fPadR   (strCodBco                              , 003)      + //077 - 079
                   fPadR   (strNomBco                              , 012, ' ') + //080 - 091
                   fPadR   (' '                                    , 003, ' ') + //092 - 094
                   fPadR   (strDtaRem                              , 008)      + //095 - 102
                   fPadR   (strHorRem                              , 006)      + //103 - 108
                   fPadR   (' '                                    , 280)      + //109 - 388
                   fPadL   (strSeqArq                              , 006, '0') + //389 - 394
                   fPadL   (IntToStr(intSeqReg)                    , 006, '0');  //395 - 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      fltValPagTot := 0;

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************JS*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          Inc(intSeqReg);

          Application.ProcessMessages;

          fltValPagTot := fltValPagTot + FieldByName('PGI_VALPAG').AsFloat;

          strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

          strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                       FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

          strKeyDup := FieldByName('PGI_AUTOIN').AsString;

          If Length(FieldByName('EMP_C_G_C_').AsString) > 11 Then
            strTipIns := '02'
          Else
            strTipIns := '01';

          strTransacao := fPadR      ('1'                                      , 01)      + //001 - 001
                          fPadR      (strTipIns                                , 02)      + //002 - 003
                          fPadR      (FieldByName('EMP_C_G_C_').AsString  , 14, '0')      + //004 - 017
                          fPadL      (strIdeBco                           , 11, '0')      + //018 - 028
                          fPadR      (' '                                      , 05)      + //029 - 033
                          fPadR      (strKeyDup                                , 25)      + //034 - 058
                          fPadR      (FieldByName('C_G_C_').AsString      , 14, '0')      + //059 - 072
                          fPadR      ('DM '                                    , 03)      + //073 - 075
                          fPadR      ('0'                                 , 09, '0')      + //076 - 084
                          fPadR      ('01'                                     , 02)      + //085 - 086
                          fPadR      (' '                                      , 10)      + //087 - 096
                          fPadL      (strDtaVen                                , 08)      + //097 - 104
                          fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 13)      + //105 - 117
                          fPadR      ('COB'                                    , 03)      + //118 - 120
                          fPadR      ('0'                                 , 03, '0')      + //121 - 123
                          fPadR      ('0'                                 , 05, '0')      + //124 - 128
                          fPadR      (' '                                      , 01)      + //129 - 129
                          fPadR      ('0'                                 , 12, '0')      + //130 - 141
                          fPadR      (' '                                      , 35)      + //142 - 176
                          fPadR      ('0'                                 , 13, '0')      + //177 - 189
                          fPadR      (FieldByName('FOR_NOMFOR').AsString       , 40)      + //190 - 229
                          fPadR      (strAvisaFor                              , 01)      + //230 - 230
                          fPadR      (FieldByName('ENDERE').AsString           , 40)      + //231 - 270
                          fPadR      (FieldByName('BAIRRO').AsString           , 12)      + //271 - 282
                          fPadR      (FieldByName('CIDADE').AsString           , 15)      + //283 - 297
                          fPadR      (FieldByName('C_E_P_').AsString           , 08)      + //298 - 305
                          fPadR      (FieldByName('ESTADO').AsString           , 02)      + //306 - 307
                          fPadR      ('1'                                      , 01)      + //308 - 308
                          fPadR      (FieldByName('PGI_CODBAR').AsString       , 49)      + //309 - 357
                          fPadR      ('0'                                 , 13, '0')      + //358 - 370
                          fPadL      (strDtaVen                                , 08)      + //371 - 378
                          fPadR      (' '                                      , 04)      + //379 - 382
                          fPadR      (' '                                      , 04)      + //383 - 386
                          fPadR      (' '                                      , 03)      + //387 - 389
                          fPadR      ('0'                                 , 05, '0')      + //390 - 394
                          fPadL      (IntToStr(intSeqReg)                 , 06, '0');       //395 - 400


          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JS*}
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

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      Inc(intSeqReg);

      strTrailler := '';
      strTrailler := fPadR      ('9'                     , 001) + //001 - 001
                     fPadR      (' '                     , 380) + //002 - 381
                     fValNumForm(fltValPagTot            , 013) + //382 - 394
                     fPadL      (IntToStr(intSeqReg), 006, '0');  //395 - 400

      {****************************************}
      {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
      {*************************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      strSeqArq := fAtuCodSeq(strConfig, 'PROXNUM');

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;
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
      pMensagensErro(E.Message,  '[untExpArqRemBanestesCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

    End;
  End;
end;

procedure TfrmExpArqRemBanestesCta.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBanestesCta.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmExpArqRemBanestesCta.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBanestesCta.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
