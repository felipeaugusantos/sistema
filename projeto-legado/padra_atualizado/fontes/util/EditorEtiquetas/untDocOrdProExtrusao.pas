unit untDocOrdProExtrusao;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni;

Type

  TLeDocumentoPE = Class(TLeDocumento)
  Private
    cdsOrdGer: TZClient;

    Function fSQLMovPEX: String;
    Function fInsereClientMovPEX: Boolean;

  Public
    function fMontaClients(cdsDadosExternosOrdGer: TZClient = nil; cdsDadosExternosOrdExt: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses DB;

{ TLeDocumentoPE }

function TLeDocumentoPE.fInsereClientMovPEX: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLMovPEX);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODORD').AsString := recDocume.strCodOrd;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('DTACAD').AsString := recDocume.strDtaCad;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientMovPEX');
end;

function TLeDocumentoPE.fMontaClients(cdsDadosExternosOrdGer,
  cdsDadosExternosOrdExt: TZClient): Boolean;
begin
  Try
    Result := True;

    Result    := Result And fInsereClientMovPEX;
    cdsOrdGer := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fPreparaImpressaoDocumentos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoPE.fSQLMovPEX: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                           ';
  strSQL := strSQL + '   O.ORD_OPEEXT AS OPEEXT,        ';
  strSQL := strSQL + '   O.ORD_OBSEXT AS OBSEXT,        ';
  strSQL := strSQL + '   O.ORD_HREXIN AS HREXIN,        ';
  strSQL := strSQL + '   O.ORD_HREXFN AS HREXFN,        ';
  strSQL := strSQL + '   O.ORD_ROSCA_ AS ROSCA_,        ';
  strSQL := strSQL + '   O.ORD_VELPIC AS VELPIC,        ';
  strSQL := strSQL + '   E.EXT_NOMTER AS NOMTER,        ';
  strSQL := strSQL + '   E.EXT_EXTS01 AS EXTS01,        ';
  strSQL := strSQL + '   E.EXT_EXTS02 AS EXTS02,        ';
  strSQL := strSQL + '   E.EXT_EXTS03 AS EXTS03         ';
  strSQL := strSQL + ' FROM                             ';
  strSQL := strSQL + '   ORDGER AS O                    ';
  strSQL := strSQL + ' LEFT JOIN ORDEXT AS E            ';
  strSQL := strSQL + '   ON E.EXT_SEQGER = O.AUTOINCREM ';
  strSQL := strSQL + ' WHERE ORD_CODEMP = :CODEMP       ';
  strSQL := strSQL + '   AND ORD_CODORD = :CODORD       ';
  strSQL := strSQL + '   AND ORD_DTACAD = :DTACAD       ';

  Result := strSQL;
end;

end.

