unit untTCdsVinculosRequisicoes;

interface

uses
  UniClientDataSet, Data.DB, System.SysUtils, System.Classes, System.IOUtils,
  Uni;

type
  TCdsVinculosRequisicoes = Class(TUniClientDataSet)
    private
      class var
       FCdsVinculosRequisicoes: TCdsVinculosRequisicoes;
    private
      FblnCriandoNovaInstancia: Boolean;
      class procedure pAtualizarPedidos(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
    public
      constructor Create(AOwner: TComponent);override;
      destructor Destroy;override;
      procedure pPrepararInstancia;
      class procedure pSalvarClientDataSet(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
      class procedure pCarregarClientDataSet(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
      class function fGetClientDataSet: TUniClientDataSet;
  End;



implementation

uses
  untFuncoesSimples;

{ TCdsVinculosRequisicoes }


constructor TCdsVinculosRequisicoes.Create(AOwner: TComponent);
begin
  if Assigned(FCdsVinculosRequisicoes) then
    Exit;

  inherited Create(AOwner);
  FblnCriandoNovaInstancia := True;
end;

destructor TCdsVinculosRequisicoes.Destroy;
begin
  inherited;
  FCdsVinculosRequisicoes := Nil;

end;

class function TCdsVinculosRequisicoes.fGetClientDataSet: TUniClientDataSet;
begin
  if Not Assigned(FCdsVinculosRequisicoes) then
  begin
    FCdsVinculosRequisicoes := TCdsVinculosRequisicoes.create(Nil);
    FCdsVinculosRequisicoes.pPrepararInstancia;
  end;
  Result :=  FCdsVinculosRequisicoes;
end;

procedure TCdsVinculosRequisicoes.pPrepararInstancia;
begin
  if Not FblnCriandoNovaInstancia then
    Exit;

  Self.AggregatesActive := True;

  Self.FieldDefs.Add('ITE_CODITE', ftString, fTamCodIte);
  Self.FieldDefs.Add('QTDITE', ftFloat);
  Self.FieldDefs.Add('AUTINC', ftString, 20);
  Self.FieldDefs.Add('AUTGER', ftString, 20);
  Self.FieldDefs.Add('NUMPED', ftString, 12);
  Self.FieldDefs.Add('DTAENT', ftDate);
  Self.FieldDefs.Add('DTAPED', ftDate);
  Self.FieldDefs.Add('AVULSA', ftString, 1);
  Self.FieldDefs.Add('PCD_AUTINC', ftString, 20);
  Self.FieldDefs.Add('SEQFDO', ftString, 20);
  Self.FieldDefs.Add('DESITE', ftString, 70);

  Self.CreateDataSet;
  Self.LogChanges := False;

  FblnCriandoNovaInstancia := False;
end;

class procedure TCdsVinculosRequisicoes.pSalvarClientDataSet(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
var
  qryAux: TUniQuery;
  qryDel: TUniQuery;
  strPathCds: String;
  blnEmTransacao : Boolean;
begin
  qryAux := fCriaQuery;
  qryDel := fCriaQuery;
  Try
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM FATVIN WHERE FAT_CODEMP = :CODEMP');
    qryDel.SQL.Add('                     AND FAT_NUMDOC = :NUMDOC');
    qryDel.SQL.Add('                     AND FAT_ESPDOC = :ESPDOC');
    qryDel.SQL.Add('                     AND FAT_CODCLI = :CODCLI;');
    qryDel.ParamByName('NUMDOC').AsString := AStrNumDoc;
    qryDel.ParamByName('ESPDOC').AsString := AStrEspDoc;
    qryDel.ParamByName('CODCLI').AsString := AStrCodCli;
    qryDel.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not FCdsVinculosRequisicoes.IsEmpty) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO FATVIN (AUTOINCREM, ');
      qryAux.SQL.Add('                    FAT_NUMDOC, ');
      qryAux.SQL.Add('                    FAT_ESPDOC, ');
      qryAux.SQL.Add('                    FAT_CODCLI, ');
      qryAux.SQL.Add('                    FAT_CODEMP, ');
      qryAux.SQL.Add('                    FAT_CDSVIN, ');
      qryAux.SQL.Add('                    FAT_DTAVIN, ');
      qryAux.SQL.Add('                    FAT_HRAVIN) ');
      qryAux.SQL.Add('            VALUES (:AUTINC,    ');
      qryAux.SQL.Add('                    :NUMDOC,    ');
      qryAux.SQL.Add('                    :ESPDOC,    ');
      qryAux.SQL.Add('                    :CODCLI,    ');
      qryAux.SQL.Add('                    :CODEMP,    ');
      qryAux.SQL.Add('                    :CDSVIN,    ');
      qryAux.SQL.Add('                    :DTAVIN,    ');
      qryAux.SQL.Add('                    :HRAVIN);   ');

      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('FATVIN', VS_StrCodEmp);
      qryAux.ParamByName('NUMDOC').AsString := AStrNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := AStrEspDoc;
      qryAux.ParamByName('CODCLI').AsString := AStrCodCli;
      qryAux.ParamByName('DTAVIN').AsDate := VS_Date;
      qryAux.ParamByName('HRAVIN').AsDateTime := fTime();
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      strPathCds := ExtractFilePath(ParamStr(0)) + 'vinculos_' + AStrNumDoc + AStrEspDoc +  AStrCodCli +'.xml';
      FCdsVinculosRequisicoes.SaveToFile(strPathCds);
      qryAux.ParamByName('CDSVIN').LoadFromFile(strPathCds, ftBlob);
      TFile.Delete(strPathCds);
    End;

    blnEmTransacao := fInTransaction;
    If (Not blnEmTransacao) Then
      fStartTransaction;

    qryDel.ExecSQL;
    If (Not fEmptyStr(qryAux.SQL.Text)) Then
      qryAux.ExecSQL;

    If (Not blnEmTransacao) Then
      fCommit;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(qryDel);
  End;
end;

class procedure TCdsVinculosRequisicoes.pCarregarClientDataSet(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
var
  qryAux: TUniQuery;
  strPathCds: String;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                    ');
    qryAux.SQL.Add(' FAT_CDSVIN               ');
    qryAux.SQL.Add('FROM                      ');
    qryAux.SQL.Add(' FATVIN                   ');
    qryAux.SQL.Add('WHERE                     ');
    qryAux.SQL.Add(' FAT_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add(' FAT_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add(' FAT_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add(' FAT_ESPDOC = :ESPDOC     ');

    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.ParamByName('CODCLI').AsString := AStrCodCli;
    qryAux.ParamByName('NUMDOC').AsString := AStrNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AStrEspDoc;
    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit;

    strPathCds := ExtractFilePath(ParamStr(0)) + 'params_' + AStrNumDoc + AStrEspDoc +  AStrCodCli + '.xml';
    TBlobField(qryAux.FieldByName('FAT_CDSVIN')).SaveToFile(strPathCds);
    FCdsVinculosRequisicoes.LoadFromFile(strPathCds);
    TFile.Delete(strPathCds);
  Finally
    FreeAndNil(qryAux);
    pAtualizarPedidos(AStrNumDoc, AStrEspDoc, AStrCodCli);
  End;
end;

class procedure TCdsVinculosRequisicoes.pAtualizarPedidos(AStrNumDoc, AStrEspDoc, AStrCodCli: String);
var
  qryCons: TUniQuery;
begin
  qryCons := fCriaQuery;
  Try
    qryCons.SQL.Clear;
    qryCons.SQL.Add('  SELECT                             ');
    qryCons.SQL.Add('    D.AUTOINCREM,                    ');
    qryCons.SQL.Add('    D.RCD_SEQPCD,                    ');
    qryCons.SQL.Add('    D.RCD_QTDITE                     ');
    qryCons.SQL.Add('  FROM                               ');
    qryCons.SQL.Add('    MOVRCD D                         ');
    qryCons.SQL.Add('    INNER JOIN MOVRCG                ');
    qryCons.SQL.Add('       ON D.RCD_CODIGO = RCG_CODIGO  ');
    qryCons.SQL.Add('      AND D.RCD_CODEMP = RCG_CODEMP  ');
    qryCons.SQL.Add('  WHERE RCG_NUMDOC = :NUMDOC         ');
    qryCons.SQL.Add('    AND RCG_ESPDOC = :ESPDOC         ');
    qryCons.SQL.Add('    AND RCG_CODEMP = :CODEMP         ');
    qryCons.SQL.Add('    AND RCG_CODCLI = :CODCLI         ');

    qryCons.ParamByName('NUMDOC').AsString := AStrNumDoc;
    qryCons.ParamByName('ESPDOC').AsString := AStrEspDoc;
    qryCons.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryCons.ParamByName('CODCLI').AsString := AStrCodCli;

    qryCons.Open;
    qryCons.First;
    While Not qryCons.Eof Do
    Begin
      If FCdsVinculosRequisicoes.Locate('PCD_AUTINC', qryCons.FieldByName('AUTOINCREM').AsString, []) Then
      Begin
        FCdsVinculosRequisicoes.Edit;
        FCdsVinculosRequisicoes.FieldByName('AUTINC').AsString := qryCons.FieldByName('RCD_SEQPCD').AsString;
        FCdsVinculosRequisicoes.FieldByName('AVULSA').AsString := IIF(fEmptyStr(FCdsVinculosRequisicoes.FieldByName('AUTINC').AsString), 'S', 'N');
        FCdsVinculosRequisicoes.FieldByName('QTDITE').AsFloat := qryCons.FieldByName('RCD_QTDITE').AsFloat;
        FCdsVinculosRequisicoes.Post;
      End;
      qryCons.Next;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.
