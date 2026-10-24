unit untGryncash;

interface

uses
  untFuncoesSimples,
  untFuncFat,
  untCashBackParticipante,
  untGryncashUserCashbackFundsOnStore,
  untGryncashRegisterCashTransaction,
  System.sysUtils,
  untFuncoes,
  Vcl.Controls,
  Data.DB,
  MemDS,
  DBAccess,
  Uni;

type
  TGryncash = class
  private
    fatVenda: TFatVenda;
  public
    constructor Create(fatVenda: TFatVenda); reintroduce;
    function fUserCashBackFundsOnStore(strNomCli, strCliCgc: String; var blnCliGry: Boolean; var fltCshGry: Double; fltTotGer: Double): Boolean;
    function fSalvaCashBack(strCodEmp, strEspDoc, strNumDoc: String; fltCshGry: Double): Boolean;
    function fRegisterCashTransaction: Boolean;
  end;

implementation

{ TGryncash }

constructor TGryncash.Create(fatVenda: TFatVenda);
begin
  Self.fatVenda := fatVenda;
end;

function TGryncash.fSalvaCashBack(strCodEmp, strEspDoc, strNumDoc: String; fltCshGry: Double): Boolean;
var
  qryCshBck: TUniQuery;
begin

  qryCshBck := fCriaQuery;
  try
    try
      qryCshBck.Close;
      qryCshBck.SQL.Text :=
      ' SELECT * FROM '+
      '   CSHBCK '+
      ' WHERE '+
      '   CSH_CODEMP = :CODEMP AND '+
      '   CSH_ESPDOC = :ESPDOC AND '+
      '   CSH_NUMDOC = :NUMDOC ';

      qryCshBck.ParamByName('CODEMP').AsString := strCodEmp;
      qryCshBck.ParamByName('ESPDOC').AsString := strEspDoc;
      qryCshBck.ParamByName('NUMDOC').AsString := strNumDoc;
      qryCshBck.Open;

      if qryCshBck.IsEmpty then
      begin
        qryCshBck.SQL.Clear;
        qryCshBck.Close;
        qryCshBck.SQL.Text :=
        ' INSERT INTO '+
        '   CSHBCK '+
        '   (AUTOINCREM, '+
        '   CSH_CODEMP, '+
        '   CSH_ESPDOC, '+
        '   CSH_NUMDOC, '+
        '   CSH_VALRES, '+
        '   CSH_CSHBCK, '+
        '   CSH_STATUS) '+
        ' VALUES '+
        '  (:AUTOIN, '+
        '   :CODEMP, '+
        '   :ESPDOC, '+
        '   :NUMDOC, '+
        '   :VALRES, '+
        '   :CSHBCK, '+
        '   :STATUS) ';

        qryCshBck.ParamByName('AUTOIN').AsString  := fRetAutoIncrem('CSHBCK', VS_strCodEmp);
        qryCshBck.ParamByName('CODEMP').AsString  := strCodEmp;
        qryCshBck.ParamByName('ESPDOC').AsString  := strEspDoc;
        qryCshBck.ParamByName('NUMDOC').AsString  := strNumDoc;
        qryCshBck.ParamByName('VALRES').AsFloat   := fltCshGry;
        qryCshBck.ParamByName('CSHBCK').AsString  := 'GRYNCASH';
        qryCshBck.ParamByName('STATUS').AsInteger := 0; //0 = AGUARDANDO RESGATE, 1 = RESGATADO, 2 = ACUMULADO
        qryCshBck.ExecSQL;
      end
      else
      begin
        qryCshBck.SQL.Clear;
        qryCshBck.Close;
        qryCshBck.SQL.Text :=
        ' UPDATE '+
        '   CSHBCK '+
        ' SET '+
        '   CSH_VALRES = :VALRES '+
        ' WHERE '+
        '   CSH_CODEMP = :CODEMP AND '+
        '   CSH_ESPDOC = :ESPDOC AND '+
        '   CSH_NUMDOC = :NUMDOC ';

        qryCshBck.ParamByName('VALRES').AsFloat  := fltCshGry;
        qryCshBck.ParamByName('CODEMP').AsString := strCodEmp;
        qryCshBck.ParamByName('ESPDOC').AsString := strEspDoc;
        qryCshBck.ParamByName('NUMDOC').AsString := strNumDoc;
        qryCshBck.ExecSQL;
      end;

      Result := True;

    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fSalvaCashBack]');
      end;
    end;

  finally
    FreeAndNil(qryCshBck);
  end;

end;

function TGryncash.fUserCashBackFundsOnStore(strNomCli, strCliCgc: String; var blnCliGry: Boolean; var fltCshGry: Double; fltTotGer: Double): Boolean;
var
  objUserCashbackFundsOnStore: TUserCashbackFundsOnStore;
  frmCashBackParticipante: TfrmCashBackParticipante;
begin
  Result := True;
  blnCliGry := False;
  try
    objUserCashbackFundsOnStore := TControllerUserCashbackFundsOnStore.fUserCashbackFundsOnStore(strCliCgc); //'19955636840'
    if Assigned(objUserCashbackFundsOnStore) and
      (objUserCashbackFundsOnStore.commonResponse.statusCode = 4001) then
    begin
      blnCliGry := True;
      if (objUserCashbackFundsOnStore.cashBackAccount.funds > 0) then
      begin
        if fPergunta('Cliente com cashback de '+Format('%m', [objUserCashbackFundsOnStore.cashBackAccount.funds])+
                     ' disponível na Gryncash. Deseja utilizá-lo como uma das formas de pagamento?') then
        begin
          Try
            pCriarFormularios(TfrmCashBackParticipante, frmCashBackParticipante);
            frmCashBackParticipante.Caption  := 'GrynCash';
            frmCashBackParticipante.lblNomeParticipante.Caption := strNomCli;
            frmCashBackParticipante.edtCashDisp.Text    := fFloatToStrVirgula(objUserCashbackFundsOnStore.cashBackAccount.funds,12,2);
            frmCashBackParticipante.edtTotGer.Text      := fFloatToStrVirgula(fltTotGer, 12,2);
            frmCashBackParticipante.edtTotRes.Text      := fFloatToStrVirgula(fltTotGer, 12,2);

            frmCashBackParticipante.ShowModal;
            if frmCashBackParticipante.ModalResult = mrOk then
              fltCshGry := fStrToFloat(frmCashBackParticipante.edtCashBack.Text);

            FreeAndNil(frmCashBackParticipante);
          except
            on E: Exception do
            begin
              pMensagensErro(E.Message, '[frmCashBackParticipante]');
            end;
          end;
        end;
      end;
    end;
  finally
    if Assigned(objUserCashbackFundsOnStore) then
      FreeAndNil(objUserCashbackFundsOnStore);
  end;
end;

function TGryncash.fRegisterCashTransaction: Boolean;
var
  objRegisterCashTransaction: TRegisterCashTransaction;
  qryTranID,
  qryCshBck: TUniQuery;
begin
  Result := False;

  qryCshBck := fCriaQuery;
  try
    qryCshBck.Close;
    qryCshBck.SQL.Text :=
    ' SELECT * FROM '+
    '   CSHBCK '+
    ' WHERE '+
    '   CSH_CODEMP = :CODEMP AND '+
    '   CSH_ESPDOC = :ESPDOC AND '+
    '   CSH_NUMDOC = :NUMDOC ';

    qryCshBck.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCshBck.ParamByName('ESPDOC').AsString := IIF((not fEmptyStr(fatVenda.strPedExp)),
                                                     'PD',
                                                     IIF((not fEmptyStr(fatVenda.strNumOrc)),
                                                          fatVenda.strEspOrc,
                                                          fatVenda.strEspDoc)
                                                   );

    qryCshBck.ParamByName('NUMDOC').AsString := IIF((not fEmptyStr(fatVenda.strPedExp)),
                                                     fatVenda.strPedExp,
                                                     IIF((not fEmptyStr(fatVenda.strNumOrc)),
                                                          fatVenda.strNumOrc,
                                                          fatVenda.strNumDoc)
                                                   );
    qryCshBck.Open;

    if qryCshBck.isEmpty then
    begin
      Result := True;
      Exit;
    end;

    objRegisterCashTransaction := TControllerRegisterCashTransaction
                                  .fRegisterCashTransaction(fatVenda.strCliCgc,
                                                            fatVenda.fltTotGer,
                                                            qryCshBck.FieldByName('CSH_VALRES').AsFloat);

    if (objRegisterCashTransaction.commonResponse.statusCode = 4002) then
    begin
      qryTranID := fCriaQuery;
      qryTranID.Close;
      qryTranID.SQL.Text :=
      ' UPDATE '+
      '   CSHBCK '+
      ' SET '+
      '   CSH_STATUS = :STATUS, '+
      '   CSH_TRANID = :TRANID '+
      ' WHERE '+
      '   CSH_CODEMP = :CODEMP AND '+
      '   CSH_ESPDOC = :ESPDOC AND '+
      '   CSH_NUMDOC = :NUMDOC ';

      qryTranID.ParamByName('STATUS').AsInteger := IIF(qryCshBck.FieldByName('CSH_VALRES').AsFloat > 0, 1, 2);   //0=AGUARDANDO TRANSACAO, 1 = RESGATADO, 2 = ACUMULADO
      qryTranID.ParamByName('TRANID').AsString  := objRegisterCashTransaction.transactionID.ToString;
      qryTranID.ParamByName('CODEMP').AsString  := VS_strCodEmp;
      qryTranID.ParamByName('ESPDOC').AsString  := IIF((not fEmptyStr(fatVenda.strPedExp)),
                                                       'PD',
                                                       IIF((not fEmptyStr(fatVenda.strNumOrc)),
                                                            fatVenda.strEspOrc,
                                                            fatVenda.strEspDoc)
                                                      );

      qryTranID.ParamByName('NUMDOC').AsString := IIF((not fEmptyStr(fatVenda.strPedExp)),
                                                       fatVenda.strPedExp,
                                                       IIF((not fEmptyStr(fatVenda.strNumOrc)),
                                                            fatVenda.strNumOrc,
                                                            fatVenda.strNumDoc)
                                                     );
      qryTranID.ExecSQL;

      Result := True;
    end;

  finally
    if Assigned(objRegisterCashTransaction) then
      FreeAndNil(objRegisterCashTransaction);

    FreeAndNil(qryTranID);
    FreeAndNil(qryCshBck);
  end;

end;

{class function TGryncash.fUtilizandoCashBack(strCodEmp, strEspDoc, strNumDoc: String; fatVenda: TFatVenda): Boolean;
var
  qryCshBck: TUniQuery;
begin
  Result             := True;

  qryCshBck := fCriaQuery;
  try
    try
      qryCshBck.Close;
      qryCshBck.SQL.Text :=
      ' SELECT * FROM '+
      '   CSHBCK '+
      ' WHERE '+
      '   CSH_CODEMP = :CODEMP AND '+
      '   CSH_ESPDOC = :ESPDOC AND '+
      '   CSH_NUMDOC = :NUMDOC AND '+
      '   CSH_STATUS = 0 ';

      qryCshBck.ParamByName('CODEMP').AsString := strCodEmp;
      qryCshBck.ParamByName('ESPDOC').AsString := strEspDoc;
      qryCshBck.ParamByName('NUMDOC').AsString := strNumDoc;
      qryCshBck.Open;

      if not qryCshBck.IsEmpty then
      begin
        fatVenda.fltCshGry := qryCshBck.FieldByName('CSH_VALRES').AsFloat;
        fatVenda.blnCliGry := True;
        fatVenda.blnSalCsh := False;
      end;

    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fUtilizandoCashBack]');
      end;
    end;

  finally
    FreeAndNil(qryCshBck);
  end;
end; }

end.
