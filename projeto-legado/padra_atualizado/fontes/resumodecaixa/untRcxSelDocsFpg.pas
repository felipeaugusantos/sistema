unit untRcxSelDocsFpg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  AppEvnts, Uni, UniClientDataSet, UniDataSetProvider, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untRcxTResumoDeCaixa,
  untTLock;

type
  TfrmRcxSelDocsFpg = class(TfrmPai)
    dbgDocumentos: TDBGridCitel;
    lblCliente: TLabel;
    dbeCliente: TDBEditFocus;
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnFecharForm: Boolean;
    qryDocsFpg : TUniQuery;
    cdsData    : TUniClientDataSet;
    dtsData    : TDataSource;
    prvPro     : TUniDataSetProvider;

    objLock: TLock;

    procedure pAlteraValoresDocumento;
    procedure pCarregaDocumentos;
    function RetornaSQLRegistroPix: String;
    procedure pGravaLogFpg(CDS: TUniClientDataSet; Situacao: String; HoraLog: TTime);

    function  fSelecionaContaCaixa(intSeqCon: Integer; strCodEmp: String): TUniClientDataSet;
    Function  fRetornaValorOrdPgto(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime) : Double;
    function fMarcaDuplicata(strMarDes: String) : Boolean;
    function fLockedByCurrentConnection(strChaLck: String): Boolean;
  public
    { Public declarations }
    dtaDtaRef: TDateTime;
    strCodOpe: String;

    objResumoDeCaixa: TResumoDeCaixa;

    strCodigoCaixa  : String;
  end;


implementation

uses untRcxFormasPagamento, untfuncoesSimples, untMemo, untCadRec;

{$R *.dfm}

procedure TfrmRcxSelDocsFpg.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin

    If fMarcaDuplicata('M') Then
    Begin
      Try
        pAlteraValoresDocumento;
      Finally
        fMarcaDuplicata('D');
      End;
    End;

  End

  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;

end;

procedure TfrmRcxSelDocsFpg.pAlteraValoresDocumento;
Var
  qryGen   : TUniQuery;
  intSeqCon: integer;
  tmHoraLog: TTime;
  cdsAuxA,
  cdsAuxN  : TUniClientDataSet;
  frmRcxFormasPagamento : TfrmRcxFormasPagamento;

  LDocumentoAlterado: Boolean;
begin
  If (qryDocsFpg.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery;

  If fCfgSis('RCXTCC') = '2' Then
  Begin
    qryGen := fCarregaCartoesTransferidos(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                        cdsData.FieldByName('RCX_CODEMP').AsString,
                                        cdsData.FieldByName('CTR_DTABAI').AsDateTime);

    If Not qryGen.IsEmpty Then
    Begin
      fMensagem('','Há cartões transferidos relativos a esse documento!.' + #13 +
                'Para alterar o valor deste documento cancele o sequencial: '+qryGen.FieldByName('MCA_SEQTRF').AsString+' .',['O K']);

      qryGen.Close;
      FreeAndNil(qryGen);
      Exit;
    End;

    qryGen.Close;
    FreeAndNil(qryGen);
    qryGen := fCarregaChequesTransferidos(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                        cdsData.FieldByName('RCX_CODEMP').AsString,
                                        cdsData.FieldByName('CTR_DTABAI').AsDateTime);

    If Not qryGen.IsEmpty Then
    Begin
      fMensagem('','Há cheques transferidos relativos a esse documento!' + #13 +
                  'Para alterar o valor deste documento cancele o sequencial: '+qryGen.FieldByName('CHQ_SEQTRF').AsString+'.',['O K']);
      qryGen.Close;
      FreeAndNil(qryGen);
      Exit;
    End;

    qryGen.Close;
    FreeAndNil(qryGen);

    If ( fRetornaValorOrdPgto(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                              cdsData.FieldByName('RCX_CODEMP').AsString,
                              cdsData.FieldByName('CTR_DTABAI').AsDateTime) > 0) And
       (objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica) Then
    Begin

      qryGen := fCarregaOrdemPgtoTransferidos( cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                               cdsData.FieldByName('RCX_CODEMP').AsString,
                                               cdsData.FieldByName('CTR_DTABAI').AsDateTime );

      If Not qryGen.IsEmpty Then
      Begin
        fMensagem('','Há ordens de pagamentos transferidas relativas a esse documento!' + #13 +
                     'Para alterar o valor deste documento cancele o sequencial: '+qryGen.FieldByName('RCX_SEQCON').AsString+'.',['O K']);
        qryGen.Close;
        FreeAndNil(qryGen);
        Exit;
      End;

    End;

  End;

  intSeqCon := cdsData.FieldByName('RCX_SEQCON').AsInteger;
  tmHoraLog := fTime();

  LDocumentoAlterado := untCadRec.fRetUltimaAlteracaoCadRec(cdsData.FieldByName('CTR_NUMDUP').AsString,
                                                            cdsData.FieldByName('CTR_PARCEL').AsString,
                                                            cdsData.FieldByName('CTR_ESPDOC').AsString,
                                                            cdsData.FieldByName('CTR_CODCLI').AsString,
                                                            cdsData.FieldByName('CTR_CODEMP').AsString,
                                                            cdsData.FieldByName('CTR_SEQBAI').AsInteger) >=  cdsData.FieldByName('HRAFIL').AsDateTime;

  If LDocumentoAlterado Then
  Begin
    fMensagem('ATENÇÃO','Houve alterações no documento selecionado posterior a abertura da tela.' + #13 +
                        'Acesse a Alteração de Formas de Pagamento novamente para atualizar os dados.',['&OK']);

    Self.Close;

    Exit;
  End;

  cdsAuxA := fSelecionaContaCaixa(intSeqCon, VS_strCodEmp);

  Try
    pCriarFormularios(TfrmRcxFormasPagamento, frmRcxFormasPagamento);
    frmRcxFormasPagamento.cdsData := cdsData;
    frmRcxFormasPagamento.strCodCli := cdsData.FieldByName('RCX_CODCLI').AsString;
    frmRcxFormasPagamento.strCodOpe := strCodOpe;
    frmRcxFormasPagamento.strCodigoCaixa := strCodigoCaixa;
    frmRcxFormasPagamento.dtaDataReferencia := dtaDtaRef;
    frmRcxFormasPagamento.RecebidoPorPix := cdsData.FieldByName('RCX_RECPIX').AsString = 'S';

    frmRcxFormasPagamento.PixAvulso := False;
    If cdsData.FieldByName('RCX_RECPIX').AsString = 'S' Then
      frmRcxFormasPagamento.PixAvulso := cdsData.FieldByName('REGISTRO_PIX').AsInteger = 0;

    frmRcxFormasPagamento.ShowModal;
  Except
    On E: Exception Do
    Begin
      objLock.pDestravarTodos;
      pMensagensErro(E.Message, '[frmRcxSelDocsFpg.pAlteraValoresDocumento]');
    End;
  End;
  fStartTransaction;

  If frmRcxFormasPagamento.ModalResult = mrOk Then
  begin
    with cdsAuxA Do
    begin
      First;
      while not Eof Do
      begin
        If intSeqCon = FieldByName('RCX_SEQCON').AsInteger Then
          pGravaLogFpg(cdsAuxA, 'A', tmHoraLog);

        Next;
      end;
    end;

    pCarregaDocumentos;

    cdsAuxN := fSelecionaContaCaixa(intSeqCon, VS_strCodEmp);

    with cdsAuxN Do
    begin
      First;
      While not Eof Do
      begin
        if intSeqCon = FieldByName('RCX_SEQCON').AsInteger Then
          pGravaLogFpg(cdsAuxN, 'N', tmHoraLog);

        Next;
      end;
    end;
    fCommit;
  end
  else
    fRollBack;

  pFreeAndNil(frmRcxFormasPagamento);
  FreeAndNil(qryGen);
  objLock.pDestravarTodos;
end;

Function TfrmRcxSelDocsFpg.fRetornaValorOrdPgto(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime) : Double;
 Var
    qryTotOP: TUniQuery;
    strSQL: String;
begin
  qryTotOP := fCriaQuery;

  strSQL := '';
  result := 0;

  strSQL := strSQL + 'SELECT SUM(RCX_ORDREC) AS TOT_OP FROM CADRCXX ';
  strSQL := strSQL + ' WHERE RCX_SEQCON = :SEQCON ';
  strSQL := strSQL + '   AND RCX_CODEMP = :EMPRCX ';
  strSQL := strSQL + '   AND RCX_DTACAD = :DTACAD ';
  strSQL := strSQL + '   AND RCX_TFCANC = ''N''   ';

  with qryTotOP, SQL Do
  begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('SEQCON').AsInteger  := intSeqCon;
    ParamByName('EMPRCX').AsString   := strEmpRcx;
    ParamByName('DTACAD').AsDateTime := dtaDtaCad;
    Open;
  end;

  If Not qryTotOP.IsEmpty Then
     Result := qryTotOP.FieldByName('TOT_OP').AsFloat;

end;


procedure TfrmRcxSelDocsFpg.pCarregaDocumentos;
  Var
    strSQL: String;
    intRecNo: Integer;
begin

  intRecNo := 0;
  If (qryDocsFpg.Active) Then
    intRecNo := qryDocsFpg.RecNo;

  strSQL := '';
  strSQL := strSQL + 'SELECT X.RCX_SEQCON, X.RCX_PARCEL, X.RCX_NUMDOC, X.RCX_ESPDOC, X.RCX_CODEMP, ';
  strSQL := strSQL + '       X.RCX_CODCLI, X.RCX_VALDOC, X.RCX_VENPRZ, X.RCX_CODFPG, X.RCX_IDECAI, ';
  strSQL := strSQL + '       X.AUTOINCREM, R.CTR_DTABAI, X.RCX_EMPDUP, X.RCX_CODOPE, X.RCX_DINREC AS RCX_DINREC, ';
  strSQL := strSQL + '       X.RCX_CHQAVI AS RCX_CHQAVI, X.RCX_CHQPRE AS RCX_CHQPRE, X.RCX_CARREC AS RCX_CARREC, ';
  strSQL := strSQL + '       X.RCX_VALFIN AS RCX_VALFIN, X.RCX_ORDREC AS RCX_ORDREC, (RCX_VALDOC + RCX_VENPRZ) AS RCX_VALGRD, ';
  strSQL := strSQL + '      (RCX_VALDOC) AS RCX_TOTDOC, CLI_NOMCLI, X.RCX_CODCAX, X.RCX_RECPIX, X.RCX_DTACAD, ';

  strSQL := strSQL + '       R.CTR_NUMDUP,   ';
  strSQL := strSQL + '       R.CTR_PARCEL,   ';
  strSQL := strSQL + '       R.CTR_ESPDOC,   ';
  strSQL := strSQL + '       R.CTR_CODCLI,   ';
  strSQL := strSQL + '       R.CTR_CODEMP,   ';
  strSQL := strSQL + '       R.CTR_SEQBAI,   ';
  strSQL := strSQL + '  CURRENT_TIMESTAMP AS HRAFIL, ';

  strSQL := strSQL + RetornaSQLRegistroPix + ' ';
  strSQL := strSQL + 'FROM CADRCXX X           ';
  strSQL := strSQL + 'LEFT JOIN CADREC R ON    ';
  strSQL := strSQL + '     R.CTR_NUMDUP = X.RCX_NUMDOC AND  ';
  strSQL := strSQL + '     R.CTR_PARCEL = IF(X.RCX_PARCEL = "", "A", X.RCX_PARCEL) AND ';
  strSQL := strSQL + '     R.CTR_SEQBAI = X.RCX_SEQBAI AND  ';
  strSQL := strSQL + '     R.CTR_ESPDOC = X.RCX_ESPDOC AND  ';
  strSQL := strSQL + '     R.CTR_CODCLI = X.RCX_CODCLI      ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON                   ';
  strSQL := strSQL + '     CADCLI.CLI_CODCLI = X.RCX_CODCLI ';
  strSQL := strSQL + 'WHERE                                 ';
  strSQL := strSQL + '      (NOT (R.CTR_DTAREC IS NULL AND CTR_VALORI > 0)) AND ';
  strSQL := strSQL + '      X.RCX_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '      X.RCX_ESPDOC NOT IN ("TF","FC","LC","LD","PG") AND ';
  strSQL := strSQL + '      X.RCX_DTACAD > :DTACAD AND      ';
  strSQL := strSQL + '      X.RCX_SEQCON = R.CTR_SEQCON AND ';
  strSQL := strSQL + '      R.CTR_DTABAI IS NOT NULL        ';
  If Not strCodigoCaixa.IsEmpty Then
  Begin
    strSQL := strSQL + ' AND  X.RCX_LANFEC = "N"            ';
    strSQL := strSQL + ' AND X.RCX_CODCAX = ' + strCodigoCaixa.QuotedString;
  End;

  {*************************}
  {* TRAZ OS ADIANTAMENTOS *}
  {**********************FS*}
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL + 'SELECT X.RCX_SEQCON, X.RCX_PARCEL, X.RCX_NUMDOC, X.RCX_ESPDOC, X.RCX_CODEMP, ';
  strSQL := strSQL + '       X.RCX_CODCLI, X.RCX_VALDOC, X.RCX_VENPRZ, X.RCX_CODFPG, X.RCX_IDECAI, ';
  strSQL := strSQL + '       X.AUTOINCREM, A.ADT_DTALAN AS CTR_DTABAI, X.RCX_EMPDUP, X.RCX_CODOPE, X.RCX_DINREC AS RCX_DINREC, ';
  strSQL := strSQL + '       X.RCX_CHQAVI AS RCX_CHQAVI, X.RCX_CHQPRE AS RCX_CHQPRE, X.RCX_CARREC AS RCX_CARREC, ';
  strSQL := strSQL + '       X.RCX_VALFIN AS RCX_VALFIN, X.RCX_ORDREC AS RCX_ORDREC, (RCX_VALDOC + RCX_VENPRZ) AS RCX_VALGRD, ';
  strSQL := strSQL + '      (RCX_VALDOC) AS RCX_TOTDOC, CLI_NOMCLI, X.RCX_CODCAX, X.RCX_RECPIX, X.RCX_DTACAD, ';

  strSQL := strSQL + '      A.ADT_NUMDOC AS CTR_NUMDUP,      ';
  strSQL := strSQL + '      "A" AS CTR_PARCEL,               ';
  strSQL := strSQL + '      A.ADT_ESPDOC AS CTR_ESPDOC,      ';
  strSQL := strSQL + '      A.ADT_CODCLI AS CTR_CODCLI,      ';
  strSQL := strSQL + '      A.ADT_CODEMP AS CTR_CODEMP,      ';
  strSQL := strSQL + '      0 AS CTR_SEQBAI,                 ';
  strSQL := strSQL + '    CURRENT_TIMESTAMP AS HRAFIL,       ';

  strSQL := strSQL + RetornaSQLRegistroPix + ' ';
  strSQL := strSQL + 'FROM CADRCXX X           ';
  strSQL := strSQL + 'LEFT JOIN ADTCLI A ON    ';
  strSQL := strSQL + '     A.ADT_NUMDOC = X.RCX_NUMDOC AND  ';
  strSQL := strSQL + '     A.ADT_ESPDOC = X.RCX_ESPDOC AND  ';
  strSQL := strSQL + '     A.ADT_CODCLI = X.RCX_CODCLI      ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON                   ';
  strSQL := strSQL + '     CADCLI.CLI_CODCLI = X.RCX_CODCLI ';
  strSQL := strSQL + 'WHERE                                 ';
  strSQL := strSQL + '      A.ADT_ESTORN <> "S" AND    ';
  strSQL := strSQL + '      X.RCX_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '      X.RCX_ESPDOC NOT IN ("TF","FC","LC","LD","PG") AND ';
  strSQL := strSQL + '      X.RCX_DTACAD > :DTACAD AND   ';
  strSQL := strSQL + '      X.RCX_SEQCON = A.ADT_SEQCON  ';
  If Not strCodigoCaixa.IsEmpty Then
  Begin
    strSQL := strSQL + ' AND  X.RCX_LANFEC = "N"          ';
    strSQL := strSQL + ' AND X.RCX_CODCAX = ' + strCodigoCaixa.QuotedString;
  End;

  With qryDocsFpg Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('DTACAD').AsDateTime := IIF(strCodigoCaixa.IsEmpty, dtaDtaRef, dtaDtaRef - 1);
    Open;

    pSetaClient(qryDocsFpg);

    cdsData.Close;
    cdsData.SetProvider(prvPro);
    cdsData.Open;

    dbgDocumentos.DataSource := dtsData;
    dbeCliente.DataSource := dtsData;

    TFloatField(cdsData.FieldByName('RCX_DINREC')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_CARREC')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_CHQAVI')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_CHQPRE')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_VALDOC')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_VENPRZ')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_TOTDOC')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_VALGRD')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_VALFIN')).DisplayFormat := '#,##0.00';
    TFloatField(cdsData.FieldByName('RCX_ORDREC')).DisplayFormat := '#,##0.00';

  End;

  If (qryDocsFpg.Active) Then
    qryDocsFpg.RecNo := intRecNo;

end;

function TfrmRcxSelDocsFpg.fMarcaDuplicata(strMarDes: String): Boolean;
  Var
    strChaLck: String;
    blnErro: Boolean;

    LChaveTravada: String;
begin
  Result := True;

  If fCfgSis('TFPF11', varBoolean) Then
  Begin
    fMensagem('ATENÇÃO!', 'Com a configuração CFG_TFPF11 (Travar, no F11, a forma de pagamento negociada no PD/OR?) ativada, '+#13+
                          'não é possível mudar a forma de pagamento de um documento!', ['&O k']);
    Result := False;
    Exit;
  End;

  strChaLck := 'CADREC' +
               cdsData.FieldByName('CTR_NUMDUP').AsString +
               cdsData.FieldByName('CTR_ESPDOC').AsString +
               cdsData.FieldByName('CTR_CODEMP').AsString +
               cdsData.FieldByName('CTR_CODCLI').AsString;

  blnErro := False;
  LChaveTravada := '';

  If strMarDes = 'M' Then
  Begin

    If Not fLockedByCurrentConnection(strChaLck) And Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;

    strChaLck := strChaLck + cdsData.FieldByName('CTR_PARCEL').AsString;
    If Not fLockedByCurrentConnection(strChaLck) And Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;

    strChaLck := strChaLck + cdsData.FieldByName('CTR_SEQBAI').AsString;
    If Not fLockedByCurrentConnection(strChaLck) And Not objLock.fLock_Unlock(strChaLck, True, False) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;
  End
  Else
  Begin
    strChaLck := strChaLck + cdsData.FieldByName('CTR_PARCEL').AsString + cdsData.FieldByName('CTR_SEQBAI').AsString;
    objLock.fLock_Unlock(strChaLck, False);
  End;

  if blnErro then
  begin
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(LChaveTravada), ['&O k']);
    Result := False;
    Exit;
  end;

end;


procedure TfrmRcxSelDocsFpg.pGravaLogFpg(CDS: TUniClientDataSet; Situacao: String; HoraLog: TTime);
var
  qryLogFpg: TUniQuery;
  strSQL: String;
begin
  qryLogFpg := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO LOGFPG (AUTOINCREM, FPG_SITUAC, FPG_NUMDOC, FPG_PARCEL, FPG_ESPDOC, ';
  strSQL := strSQL + '                    FPG_SEQBAI, FPG_CODEMP, FPG_EMPBAI, FPG_OPEBAI, FPG_DINHEI, ';
  strSQL := strSQL + '                    FPG_CARTAO, FPG_CHEQUE, FPG_CHQPRE, FPG_ORDPAG, FPG_FATURA, ';
  strSQL := strSQL + '                    FPG_FINANC, FPG_VLRTOT, FPG_DTALOG, FPG_HORLOG, FPG_OPELOG, ';
  strSQL := strSQL + '                    FPG_CODCAX)                                                 ';
  strSQL := strSQL + '            VALUES (:AUTINC,    :SITUAC,    :NUMDOC,    :PARCEL,    :ESPDOC, ';
  strSQL := strSQL + '                    :SEQBAI,    :CODEMP,    :EMPBAI,    :OPEBAI,    :DINHEI, ';
  strSQL := strSQL + '                    :CARTAO,    :CHEQUE,    :CHQPRE,    :ORDPAG,    :FATURA, ';
  strSQL := strSQL + '                    :FINANC,    :VLRTOT,    :DTALOG,    :HORLOG,    :OPELOG, ';
  strSQL := strSQL + '                    :CODCAX)                                                 ';

  with qryLogFpg, SQL Do
  begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGFPG', VS_strCodEmp);
    ParamByName('SITUAC').AsString   := Situacao;
    ParamByName('NUMDOC').AsString   := CDS.FieldByName('RCX_NUMDOC').AsString;
    ParamByName('PARCEL').AsString   := CDS.FieldByName('RCX_PARCEL').AsString;
    ParamByName('ESPDOC').AsString   := CDS.FieldByName('RCX_ESPDOC').AsString;
    ParamByName('SEQBAI').AsInteger  := CDS.FieldByName('RCX_SEQCON').AsInteger;
    ParamByName('CODEMP').AsString   := CDS.FieldByName('RCX_EMPDUP').AsString;
    ParamByName('EMPBAI').AsString   := CDS.FieldByName('RCX_CODEMP').AsString;
    ParamByName('OPEBAI').AsString   := CDS.FieldByName('RCX_CODOPE').AsString;
    ParamByName('DINHEI').AsFloat    := CDS.FieldByName('RCX_DINREC').AsFloat;
    ParamByName('CARTAO').AsFloat    := CDS.FieldByName('RCX_CARREC').AsFloat;
    ParamByName('CHEQUE').AsFloat    := CDS.FieldByName('RCX_CHQAVI').AsFloat;
    ParamByName('CHQPRE').AsFloat    := CDS.FieldByName('RCX_CHQPRE').AsFloat;
    ParamByName('ORDPAG').AsFloat    := CDS.FieldByName('RCX_ORDREC').AsFloat;
    ParamByName('FATURA').AsFloat    := CDS.FieldByName('RCX_VENPRZ').AsFloat;
    ParamByName('FINANC').AsFloat    := CDS.FieldByName('RCX_VALFIN').AsFloat;
    ParamByName('VLRTOT').AsFloat    := CDS.FieldByName('RCX_VALGRD').AsFloat;
    ParamByName('DTALOG').AsDateTime := VS_Date;
    ParamByName('HORLOG').AsTime     := HoraLog;
    ParamByName('OPELOG').AsString   := strCodOpe;

    ParamByName('CODCAX').Value := Null;
    If Not CDS.FieldByName('RCX_CODCAX').ASString.IsEmpty Then
      ParamByName('CODCAX').AsString := CDS.FieldByName('RCX_CODCAX').AsString;

    ExecSQL;
  end;
end;

function TfrmRcxSelDocsFpg.RetornaSQLRegistroPix: String;
begin
  Result := ' IF(X.RCX_RECPIX<>"S", 0, ' +
            '    (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
            '     FROM MOVPIX ' +
            '     WHERE MPX_SEQCON=X.RCX_SEQCON ' +
            '       AND MPX_CODEMP=X.RCX_CODEMP ' +
            '       AND MPX_DTAREC=X.RCX_DTACAD ' +
            '    )) AS REGISTRO_PIX ';
end;

procedure TfrmRcxSelDocsFpg.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
  pSetFocus(dbgDocumentos);
end;

function TfrmRcxSelDocsFpg.fSelecionaContaCaixa(intSeqCon: Integer;
  strCodEmp: String): TUniClientDataSet;
Var qryCaixa: TUniQuery;
    prvCaixa: TUniDataSetProvider;
    strSQL  : String;
begin
  strSQL := 'SELECT RCX_NUMDOC, RCX_PARCEL, RCX_ESPDOC, RCX_SEQCON, RCX_EMPDUP, RCX_CODEMP, ';
  strSQL := strSQL + 'RCX_CODOPE, RCX_DINREC, RCX_CARREC, RCX_CHQAVI, RCX_CHQPRE, RCX_ORDREC, ';
  strSQL := strSQL + 'RCX_VENPRZ, RCX_VALFIN, (RCX_VALDOC + RCX_VENPRZ) AS RCX_VALGRD, ';
  strSQL := strSQL + 'RCX_CODCAX ';
  strSQL := strSQL + 'FROM CADRCXX ';
  strSQL := strSQL + 'WHERE RCX_SEQCON=:SEQCON AND RCX_CODEMP=:CODEMP ';

  If Not strCodigoCaixa.IsEmpty Then
  Begin
    strSQL := strSQL + ' AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString;
    strSQL := strSQL + '  AND RCX_DTACAD >= :DTAREF AND RCX_LANFEC="N" ';
  End
  Else
    strSQL := strSQL + '  AND RCX_DTACAD > :DTAREF ';

  strSQL := strSQL + 'ORDER BY RCX_NUMDOC';

  qryCaixa := fCriaQuery;
  prvCaixa := TUniDataSetProvider.Create(Self);
  prvCaixa.DataSet := qryCaixa;

  qryCaixa.SQL.Text := strSQL;
  qryCaixa.ParamByName('SEQCON').AsInteger  := intSeqCon;
  qryCaixa.ParamByName('CODEMP').AsString   := strCodEmp;
  qryCaixa.ParamByName('DTAREF').AsDateTime := dtaDtaRef;
  qryCaixa.Open;

  pSetaClient(qryCaixa);

  Result := TUniClientDataSet.Create(Self);
  Result.SetProvider(prvCaixa);
  Result.Open;
end;

function TfrmRcxSelDocsFpg.fLockedByCurrentConnection(
  strChaLck: String): Boolean;
begin
  Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
            (fGetIPConnectionLock(strChaLck) = VS_IPAddressAsString);
end;

procedure TfrmRcxSelDocsFpg.FormActivate(Sender: TObject);
begin
  inherited;
  blnFecharForm := False;
  If (qryDocsFpg.IsEmpty) Then
  Begin
    blnFecharForm := True;
  End;
end;

procedure TfrmRcxSelDocsFpg.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
  Begin
    Hide;
    fMensagem('', 'Não há documentos nessa data!', ['&Ok']);
    Close;
  End;
end;

procedure TfrmRcxSelDocsFpg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  objLock.pDestravarTodos;
  FreeAndNil(objLock);
end;

procedure TfrmRcxSelDocsFpg.FormCreate(Sender: TObject);
begin
  inherited;

  cdsData := TUniClientDataSet.Create(Self);
  dtsData := fCriaDataSource(cdsData);
  dbgDocumentos.DataSource := dtsData;

  qryDocsFpg := fCriaQuery(Self);

  prvPro     := TUniDataSetProvider.Create(Self);
  prvPro.DataSet := qryDocsFpg;

  strCodigoCaixa := '';
  objLock := TLock.Create;
end;

end.

