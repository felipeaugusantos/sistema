{*******************************************}
{* CLASSE TTRANSFCODCID PARA TRANSFERÊNCIA *}
{* DE CÓDIGO DE CIDADE                     *}
{* DATA 16/10/2007                         *}
{* RICARDO DE LIMA                         *}
{****************************************RL*}
unit untTransfCodCid;

interface

uses
  SysUtils, StrUtils, Uni, ComCtrls, Forms, DB, Classes, untTIntegridadeTransferenciaCodigo;

{*******************************************}
{* ESTE VETOR POSSUI CAMPOS QUE SERÃO      *}
{* UTILIZADOS NO PROCESSO DE TRANSF. DE    *}
{* CÓDIGO DE CIDADE                        *}
{****************************************RL*}
Type TCamposCidade = record
       strNomArq: String;
       strDesCam: String;
       strCamCod: String;
End;

Type TTransfCodCid = Class(TComponent)
  private

    FCodCidOri: String;
    FCodCidDes: String;


  public

    qryTmpCid      : TUniQuery;
    lsvArqAlterados: TListView;
    arrCidades     : Array Of TCamposCidade;

    property strCodCidOri: String Read FCodCidOri Write FCodCidOri;
    property strCodCidDes: String Read FCodCidDes Write FCodCidDes;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    {*******************************************}
    {* FUNÇÕES                                 *}
    {****************************************RL*}
    function fDeletarCidade(strCidOri: String): Boolean;
    function fAtualizarCodCidade(strNomArq, strCampo, strCidOri, strCidDes: String; intOpcao: Integer): Integer;
    function fTransferirCodCidade: Boolean;
    procedure pAjustaRegistrosrRetRecDuplicados;
    procedure pAjustaRegistrosrDuplicadosTRISER;

    procedure pPreencheArray;
  End;

implementation

uses untfuncoesSimples,  untCfgRepositorio;

{ TTransfCodCid }

constructor TTransfCodCid.Create(Owner: TComponent);
begin

  inherited;

  Try

    qryTmpCid := fCriaQuery;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

destructor TTransfCodCid.Destroy;
begin

  FreeAndNil(qryTmpCid);

  inherited;
end;

{*****************************************}
{* ATUALIZAR CIDADE DE DESTINO           *}
{**************************************RL*}
function TTransfCodCid.fAtualizarCodCidade(strNomArq, strCampo, strCidOri, strCidDes: String; intOpcao: Integer): Integer;
  Var
    strSQL: String;
    strCFG: String;
begin
  Result := 0;

  {****************************}
  {* OPÇÃO:                   *}
  {*                          *}
  {* 1 -> ARQUIVO             *}
  {* 2 -> ARQUIVO DELETADO    *}
  {*************************RL*}
  If intOpcao = 2 Then
    strNomArq := 'DEL_' + strNomArq;

  If Not fTabelaExiste(strNomArq) Then
    Exit;

  if Not fCampoExiste(strNomArq, strCampo) then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  ' + strNomArq + ' ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  ' + strCampo + ' = :CIDDES ';

  strSQL := strSQL + 'WHERE ';

  {*********************************************}
  {* SE FOR A ATUALIZAÇÃO DO CADCLI, ENTÃO,    *}
  {* MUDA A VAR. strCampo PARA CLI_CODCLI      *}
  {* QUANDO TIVER A OCORRÊNCIA DOS CAMPOS      *}
  {* ABAIXO E ADICIONA A VERIFICAÇÃO SE O      *}
  {* CÓDIGO DOS CAMPOS CLI_CIDENT E CLI_CIDCOB *}
  {* É IGUAL AO CÓDIGO DE ORIGEM               *}
  {******************************************RL*}
  {If (strCampo = 'CLI_CIDENT') Then
  Begin
    strSQL := strSQL + ' CLI_CIDENT = :CIDORI AND ';
    strCampo := 'CLI_CODCID';
  End;

  If (strCampo = 'CLI_CIDCOB') Then
  Begin
    strSQL := strSQL + ' CLI_CIDCOB = :CIDORI AND ';
    strCampo := 'CLI_CODCID';
  End;}

  strSQL := strSQL + '  ' + strCampo + ' = :CIDORI ';

  If (strNomArq = 'CFGSIS') Then
  Begin
    strCFG := '';

    If Assigned(ProcRetCfgRelacionadaArquivo) then
      strCFG := ProcRetCfgRelacionadaArquivo('CADCID');

    if not fEmptyStr(strCFG) then
      strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
    Else
    Begin
      Result := 0;
      Exit;
    End;

  End;


  With qryTmpCid Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CIDDES').AsString := strCidDes;
    ParamByName('CIDORI').AsString := strCidOri;
    ExecSQL;
    Result := RowsAffected;
    Close;
  End;

end;

{***************************************}
{* DELETAR CIDADE                      *}
{************************************RL*}
function TTransfCodCid.fDeletarCidade(strCidOri: String): Boolean;
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADCID WHERE CID_CODCID = :CIDORI ';

    With qryTmpCid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CIDORI').AsString := strCidOri;
      Open;
      fVerificaIntegridade(Self.Name, 'CADCID', qryTmpCid, True);
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CADCID WHERE CID_CODCID = :CIDORI ';

    With qryTmpCid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CIDORI').AsString := strCidOri;
      ExecSQL;
      Close;
    End;

    Result := True;

  Except
    On E: Exception Do
      Result := False;
  End;

end;

{***************************************}
{* TRANFERIR CÓDIGO DE CIDADE          *}
{************************************RL*}
function TTransfCodCid.fTransferirCodCidade: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
    qryDeleta      : TUniQuery;
//    strSQL         : String;
begin

  intTamMat   := Length(arrCidades);
  intContador := 0;

  Try

    While intContador < intTamMat Do
    Begin

      lsvArqAlterados.Items.Add;
      lsvArqAlterados.Items[intContador].Caption := arrCidades[intContador].strDesCam;
      lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
      Inc(intContador);
      Application.ProcessMessages;

    End;

    intContador := 0;
    fStartTransaction;
    Try
      qryDeleta := fCriaQuery(Self);
      pAjustaRegistrosrRetRecDuplicados;
      pAjustaRegistrosrDuplicadosTRISER;
      With qryDeleta, Sql Do
      Begin
        Add( 'DELETE FROM FERCID WHERE FCI_CODCID = :CIDORI ' );
        ParamByName('CIDORI').AsString := FCodCidOri;
        ExecSQL;

        //deleta as transportadoras que coincidem.
        Clear;
        Add('SELECT * FROM FRETRA WHERE FRE_CODCID = :CIDORI');
        Add('AND FRE_CODTRA IN (SELECT FRE_CODTRA FROM FRETRA WHERE FRE_CODCID = :CIDDES)');
        ParamByName('CIDORI').AsString := FCodCidOri;
        ParamByName('CIDDES').AsString := FCodCidDes;
        Open;
        First;
        While not EOF Do
        Begin
          fVerificaIntegridade(Self.Name, 'FRETRA', qryDeleta, True);
          qryDeleta.Delete;
        End;

      End;
    Finally
      FreeAndNil(qryDeleta);
    End;

    While intContador < intTamMat Do
    Begin

      Application.ProcessMessages;
      intRegAlterados := 0;

      {***************************************}
      {* ATUALIZAR CIDADE DE DESTINO         *}
      {************************************RL*}
      For intContador2 := 1 To 2 Do
      Begin

        intRegAlterados := intRegAlterados + fAtualizarCodCidade(arrCidades[intContador].strNomArq,
                                                                 arrCidades[intContador].strCamCod,
                                                                 FCodCidOri,
                                                                 FCodCidDes,
                                                                 intContador2);

        Application.ProcessMessages;

      End;
      lsvArqAlterados.Items[intContador].Selected := True;
      lsvArqAlterados.Items[intContador].MakeVisible(False);
      lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

      Application.ProcessMessages;
      Inc(intContador);

    End;

    {***************************************}
    {* EXCLUIR CIDADE DE ORIGEM            *}
    {************************************RL*}

    If fDeletarCidade(FCodCidOri) Then
    Begin
      pGravarTabelaLog(FCodCidOri, FCodCidDes, 'CADCID');
      fCommit;
    End
    Else
      fRollBack;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[pTransferirCodCid]');
    End;
  End;

end;

procedure TTransfCodCid.pAjustaRegistrosrDuplicadosTRISER;
Var
    qrySQL, qryDelete: TUniQuery;
begin
  qrySQL := fCriaQuery;
  qryDelete := fCriaQuery;

  Try
    qrySQL.Close;
    qrySQL.SQL.Clear;
    qrySQL.SQL.Add('SELECT * FROM TRISER WHERE ');
    qrySQL.SQL.Add('  TSE_CODCID IN ( "' + FCodCidOri + '","'+ FCodCidDes + '" ) ');
    qrySQL.SQL.Add(' GROUP BY TSE_CODSER HAVING COUNT(1) > 1 ');
    qrySQL.Open;

    If (Not qrySQL.IsEmpty) Then
    Begin
      qrySQL.First;
      While (Not qrySQL.Eof) Do
      Begin
        qryDelete.Close;
        qryDelete.SQL.Clear;
        qryDelete.SQL.Add(' SELECT * FROM TRISER WHERE ' );
        qryDelete.SQL.Add(' TSE_CODCID =  "' + FCodCidOri + '" ' );
        qryDelete.SQL.Add(' AND TSE_CODSER =  "' + qrySQL.FieldByName('TSE_CODSER').AsString + '" ' );
        qryDelete.Open;

        If (Not qryDelete.IsEmpty) Then
        Begin
          fVerificaIntegridade(Self.Name, 'TRISER', qryDelete, True);

          qryDelete.Close;
          qryDelete.SQL.Clear;
          qryDelete.SQL.Add('DELETE FROM TRISER WHERE ');
          qryDelete.SQL.Add('  TSE_CODCID = "' + FCodCidOri + '" ');
          qryDelete.SQL.Add(' AND TSE_CODSER =  "' + qrySQL.FieldByName('TSE_CODSER').AsString + '" ' );
          qryDelete.ExecSQL;
        End;

        qrySQL.Next;
      End;
    End;
  Finally
    FreeAndNil(qryDelete);
    FreeAndNil(qryDelete);
  End;

end;

procedure TTransfCodCid.pAjustaRegistrosrRetRecDuplicados;
var qryExec, qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;
  qryExec:= fCriaQuery;
  Try
    qrySelect.SQL.Add('SELECT * FROM ROTREC ORI');
    qrySelect.SQL.Add('WHERE REC_CODCID = "'+FCodCidOri+'"');
    qrySelect.SQL.Add('  AND');
    qrySelect.SQL.Add('  (SELECT');
    qrySelect.SQL.Add('    COUNT(1)');
    qrySelect.SQL.Add('  FROM');
    qrySelect.SQL.Add('    ROTREC AS DES');
    qrySelect.SQL.Add('  WHERE DES.REC_CODCID = "' + FCodCidDes + '"');
    qrySelect.SQL.Add('    AND DES.REC_CODREG = ORI.REC_CODREG');
    qrySelect.SQL.Add('    AND DES.REC_CODEMP = ORI.REC_CODEMP ) > 0 ;');
    qrySelect.Open;

    While not qrySelect.Eof Do
    Begin
      qryExec.Sql.Clear;
      qryExec.SQL.Add('DELETE FROM ROTREC WHERE AUTOINCREM = "' + qrySelect.FieldByName('AUTOINCREM').AsString + '"');
      qryExec.ExecSQL;
      qrySelect.Next;
    End;

   Finally
     FreeAndNil(qrySelect);
     FreeAndNil(qryExec);

   End;
end;

procedure TTransfCodCid.pPreencheArray;
  Var
    intPosicao: Integer;
    qryTcoArr : TUniQuery;
begin
  Try
    qryTcoArr := fCriaQuery();
    With qryTcoArr, SQL Do
    Begin
      Add(' SELECT                ');
      Add(' TCA_ARQREL,           ');
      Add(' TCA_CAMREL,           ');
      Add(' TCA_DESCRI            ');
      Add(' FROM TCOARR           ');
      Add(' WHERE                 ');
      Add(' TCA_ARQUIV = "CADCID" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrCidades, succ(intPosicao));

        arrCidades[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrCidades[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrCidades[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.

