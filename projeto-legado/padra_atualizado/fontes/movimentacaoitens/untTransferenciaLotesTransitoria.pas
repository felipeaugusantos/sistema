unit untTransferenciaLotesTransitoria;

interface

uses
  StrUtils, SysUtils, Classes, Forms, DB,
  Uni, Controls, UniClientDataSet,
  Math, ComCtrls, untCadLote, cxProgressBar, untCdsTransferenciaArmazens,
  untTransferenciaArmazens, untIFatReservaSaldo, System.Variants,
  untTFatReprocessarSaldoItem;

Type
  TTransferenciaLotesTransitoria = Class
  Private
    FQryLOTDOR : TUniQuery;
    FCodigoLocalizacaoFisica : String;
    function fTransfereLotesInterna(prgProgresso: TcxProgressBar): Boolean;


  Public
    strAutoincremFATGOR       : String;
    strCodigoLocalSeparacao   : String;

    function fTransfereLotes(strCodigoLocalizacaoFisica: String): Boolean;

    constructor Create();
    destructor Destroy; override;
  end;

implementation

Uses
  untFuncoesSimples, untTypesSistema, untGravando;

{ TTransferenciaLotesTransitoria }

constructor TTransferenciaLotesTransitoria.Create;
begin
  strAutoincremFATGOR       := '';
  strCodigoLocalSeparacao   := '';

  FQryLOTDOR := fCriaQuery(nil);
  FQryLOTDOR.SQL.Add('SELECT                                                      ');
  FQryLOTDOR.SQL.Add('  FDO_NUMDOC,                                               ');
  FQryLOTDOR.SQL.Add('  FDO_ESPDOC,                                               ');
  FQryLOTDOR.SQL.Add('  FDO_CODEMP,                                               ');
  FQryLOTDOR.SQL.Add('  FDO_CODITE,                                               ');
  FQryLOTDOR.SQL.Add('  LOT_DTAVAL,                                               ');
  FQryLOTDOR.SQL.Add('  ITE_CODLSE,                                               ');
  FQryLOTDOR.SQL.Add('  LOTDOR.*                                                  ');
  FQryLOTDOR.SQL.Add('FROM                                                        ');
  FQryLOTDOR.SQL.Add('  FATDOR                                                    ');
  FQryLOTDOR.SQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM       ');
  FQryLOTDOR.SQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM       ');
  FQryLOTDOR.SQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE              ');
  FQryLOTDOR.SQL.Add('                   AND ITE_CODEMP = :CODIGO_EMPRESA_ESTOQUE ');
  FQryLOTDOR.SQL.Add('  INNER JOIN CADLOT ON LOT_CODITE = ITE_CODITE              ');
  FQryLOTDOR.SQL.Add('                   AND LOT_CODEMP = ITE_CODEMP              ');
  FQryLOTDOR.SQL.Add('                   AND LOT_NUMLOT = LDO_NUMLOT              ');
  FQryLOTDOR.SQL.Add('  LEFT JOIN  CADLOC ON LOC_CODLOC = LOT_LOCFIS              ');
  FQryLOTDOR.SQL.Add('                   AND LOC_CODEMP = LOT_CODEMP              ');
  FQryLOTDOR.SQL.Add('  LEFT JOIN CADAMZ  ON AMZ_CODAMZ = LOT_NUMLOT              ');
  FQryLOTDOR.SQL.Add('                   AND AMZ_CODEMP = LOT_CODEMP              ');
  FQryLOTDOR.SQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR                       ');
  FQryLOTDOR.SQL.Add('  AND FDO_QTDSEP > 0                                        ');
  FQryLOTDOR.SQL.Add('  AND IFNULL(LOC_TRANSI, "N") = "N"                         ');
  FQryLOTDOR.SQL.Add('ORDER BY FDO_CODITE, LOTDOR.AUTOINCREM                      ');

  FQryLOTDOR.ParamByName('CODIGO_EMPRESA_ESTOQUE').AsString := VS_strCodEmp;

end;

destructor TTransferenciaLotesTransitoria.Destroy;
begin
  FreeAndNil(FQryLOTDOR);
  inherited;
end;

function TTransferenciaLotesTransitoria.fTransfereLotesInterna(prgProgresso: TcxProgressBar): Boolean;
var
  strNumeroLoteDestino : String;
  cdsLotesTransferencia: TCdsTransferenciaArmazens;
  objTransferenciaArmazens: TTransferenciaArmazens;
  prgProgressBar : TProgressBar;
  qryUpdateLOTDOR : TUniQuery;
  blnTransacaoExterna : boolean;
begin
  prgProgressBar := TProgressBar.Create(nil);
  qryUpdateLOTDOR := fCriaQuery(nil);
  cdsLotesTransferencia    := TCdsTransferenciaArmazens.Create(nil);
  objTransferenciaArmazens := TTransferenciaArmazens.Create(nil, cdsLotesTransferencia, Nil, prgProgressBar);
  try
    qryUpdateLOTDOR.SQL.Text := 'UPDATE LOTDOR SET LDO_NUMLOT = :NUMERO_LOTE WHERE AUTOINCREM = :AUTOINCREM';

    FQryLOTDOR.Close;
    FQryLOTDOR.ParamByName('AUTOINCREM_FATGOR').AsString  := strAutoincremFATGOR;
    FQryLOTDOR.Open;

    blnTransacaoExterna := fInTransaction();

    if not blnTransacaoExterna then
      fStartTransaction;

    try
      prgProgresso.Properties.Max := FQryLOTDOR.RecordCount;

      FQryLOTDOR.First;
      while not FQryLOTDOR.Eof do
      begin
        if not fEmptyStr(strCodigoLocalSeparacao) and (FQryLOTDOR.FieldByName('ITE_CODLSE').AsString <> strCodigoLocalSeparacao) then
          continue;

        if cdsLotesTransferencia.Locate('CODITE;ARMORI', VarArrayOf([FQryLOTDOR.FieldByName('FDO_CODITE').AsString, FQryLOTDOR.FieldByName('LDO_NUMLOT').AsString]), []) then
        begin
          cdsLotesTransferencia.Edit;
          cdsLotesTransferencia.FieldByName('QTDITE').AsFloat := cdsLotesTransferencia.FieldByName('QTDITE').AsFloat + FQryLOTDOR.FieldByName('LDO_QTDITE').AsFloat;
          cdsLotesTransferencia.FieldByName('QTDTOT').AsFloat := cdsLotesTransferencia.FieldByName('QTDITE').AsFloat;
          cdsLotesTransferencia.Post;
        end
        else
        begin

          strNumeroLoteDestino := TCadLot.fRecuperaOuCriaNUMLOTLocalizacaoItem(FQryLOTDOR.FieldByName('FDO_CODITE').AsString, FCodigoLocalizacaoFisica, FQryLOTDOR.FieldByName('LOT_DTAVAL').AsDateTime);

          cdsLotesTransferencia.Append;
          cdsLotesTransferencia.FieldByName('CODITE').AsString   := FQryLOTDOR.FieldByName('FDO_CODITE').AsString;
          cdsLotesTransferencia.FieldByName('ARMORI').AsString   := FQryLOTDOR.FieldByName('LDO_NUMLOT').AsString;
          cdsLotesTransferencia.FieldByName('ARMDES').AsString   := strNumeroLoteDestino;
          cdsLotesTransferencia.FieldByName('QTDITE').AsFloat    := FQryLOTDOR.FieldByName('LDO_QTDITE').AsFloat;
          cdsLotesTransferencia.Post;

        end;

        qryUpdateLOTDOR.ParamByName('AUTOINCREM').AsString  := FQryLOTDOR.FieldByName('AUTOINCREM').AsString;
        qryUpdateLOTDOR.ParamByName('NUMERO_LOTE').AsString := strNumeroLoteDestino;
        qryUpdateLOTDOR.ExecSQL;

        FQryLOTDOR.Next;

        prgProgresso.Position := FQryLOTDOR.RecNo;
      end;

      if cdsLotesTransferencia.isEmpty then
        Exit(True);


      objTransferenciaArmazens.strSeqOri := strAutoincremFATGOR;
      Result := objTransferenciaArmazens.fGeraTransferencia(True, False);



      //Reprocessar Saldos
      TReprocessarSaldoItem.New
       .AddItensDoDocumento(
         TItensReprocessarDoDocumento.New
           .Documento(FQryLOTDOR.FieldByName('FDO_NUMDOC').AsString)
           .Especie(FQryLOTDOR.FieldByName('FDO_ESPDOC').AsString)
           .Empresa(FQryLOTDOR.FieldByName('FDO_CODEMP').AsString)
         ).NotificarRoboParaReprocessarSaldos();


      FQryLOTDOR.Close;

      if not blnTransacaoExterna then
        Result := Result and fCommit;

    except
      On E : Exception do
      begin
        fRollback;
        Result := False;
        raise E;
      end;
    end;

  finally
    FreeAndNil(qryUpdateLOTDOR);
    FreeAndNil(cdsLotesTransferencia);
    FreeAndNil(objTransferenciaArmazens);
    FreeAndNil(prgProgressBar);
  end;

end;


Function TTransferenciaLotesTransitoria.fTransfereLotes(strCodigoLocalizacaoFisica: String): Boolean;
var
  Form : TfrmGravando;
Begin
  FCodigoLocalizacaoFisica := strCodigoLocalizacaoFisica;

  pCriarFormularios(TfrmGravando, Form);
  try
    Form.lblGravando.Caption := 'Transferindo lotes para localização transitória...';
    Form.fExecutarAcao       := fTransfereLotesInterna;
    Form.ShowModal;
    Result := Form.blnConfirma;
  finally
    pFreeAndNil(Form);
  end;

End;

end.
