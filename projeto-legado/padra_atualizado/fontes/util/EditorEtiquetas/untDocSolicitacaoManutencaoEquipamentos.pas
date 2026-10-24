unit untDocSolicitacaoManutencaoEquipamentos;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient, untImagemBase64, Uni;

type
  TLeDocumentoSolicitacaoManutencaoEquipamentos = Class(TLeDocumento)
  Private

    cdsCapa,
    cdsItens: TZClient;
    SQL: TStringLIst;

    Function fSQLCapa: String;

    Function fSQLItens: String;

    Function fInsereClientCapa: Boolean;
    Function fInsereClientItens: Boolean;

  Public

    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
    Procedure pSetaParametrosCadFor; override;

  protected
    procedure pSetaParametrosCadcli; override;
  End;


implementation

{ TLeDocumentoSolicitacaoManutencaoEquipamentos }

function TLeDocumentoSolicitacaoManutencaoEquipamentos.fInsereClientCapa: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLCapa);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet :=   arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODIGO').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientCapa');
end;

function TLeDocumentoSolicitacaoManutencaoEquipamentos.fInsereClientItens: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLItens);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet :=   arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovdet';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovdet';


  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODSOL').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientItens');
end;

function TLeDocumentoSolicitacaoManutencaoEquipamentos.fMontaClients(
  cdsDadosExternosMovGer, cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := True;

    Result    := Result And fInsereClientItens;
    cdsItens := arrClients[0].cdsDados;

    Result    := Result And fInsereClientCapa;
    cdsCapa := arrClients[1].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fInsereClientEmpresa;

    Result := Result And fInsereClientFornecedor;

    Result := Result And fPreparaImpressaoDocumentos;


    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoSolicitacaoManutencaoEquipamentos.fSQLCapa: String;
begin
  SQL := TStringList.Create;
  Try
    SQL.Add('SELECT       ');
    SQL.Add('  MEI_CODIGO CODIGO, ');
    SQL.Add('  MEI_DTACAD DTACAD, ');
    SQL.Add('  MEI_OPECAD OPECAD, ');
    SQL.Add('  MEI_DEPART DEPART, ');
    SQL.Add('  MEI_PRIORI PRIORI, ');
    SQL.Add('  MEI_STATUS STATUS, ');
    SQL.Add('  MEI_DTAEST DTAEST, ');
    SQL.Add('  MEI_DESMAN DESMAN, ');
    SQL.Add('  MEI_RESTEC RESTEC, ');
    SQL.Add('  MEI_DTAINI DTAINI, ');
    SQL.Add('  MEI_DTAFIM DTAFIM, ');
    SQL.Add('  MEI_MOTIPA MOTIPA, ');
    SQL.Add('  MEI_CODEMP CODEMP, ');
    SQL.Add('  MEI_TIPVIN TIPVIN, ');
    SQL.Add('  MEI_NUMDOC NUMDOC ');
    SQL.Add('FROM MNEQIG   ');
    SQL.Add('  WHERE MEI_CODIGO = :CODIGO');
    SQL.Add('    AND MEI_CODEMP = :CODEMP');
    Result := SQL.Text;
  Finally
    FreeAndNil(SQL);
  End;
end;

function TLeDocumentoSolicitacaoManutencaoEquipamentos.fSQLItens: String;
begin
  SQL := TStringList.Create;
  Try
    SQL.Add('SELECT ');
    SQL.Add('  MEI_CODEQP CODEQP,    ');
    SQL.Add('  CQ.EQU_DESCRI DESCRI, ');
    SQL.Add('  CM.MAR_DESMAR DESMAR, ');
    SQL.Add('  CQ.EQU_CODITE CODITE, ');
    SQL.Add('  CI.ITE_DESITE DESITE  ');
    SQL.Add('FROM MNEQID MQ   ');
    SQL.Add('   INNER JOIN CADEQU CQ ON CQ.EQU_CODIGO = MQ.MEI_CODEQP ');
    SQL.Add('   INNER JOIN CADMAR CM ON CM.MAR_CODMAR = CQ.EQU_CODMAR ');
    SQL.Add('   INNER JOIN CADITE CI ON CI.ITE_CODITE = CQ.EQU_CODITE ');
    SQL.Add('WHERE MEI_CODSOL = :CODSOL ');
    SQL.Add('  AND MEI_CODEMP = :CODEMP');
    Result := SQL.Text;
  Finally
    FreeAndNil(SQL);
  End;
end;

procedure TLeDocumentoSolicitacaoManutencaoEquipamentos.pSetaParametrosCadcli;
begin
  inherited;

end;

procedure TLeDocumentoSolicitacaoManutencaoEquipamentos.pSetaParametrosCadFor;
begin
  inherited;

end;

end.

