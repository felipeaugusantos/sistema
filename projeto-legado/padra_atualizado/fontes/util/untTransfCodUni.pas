unit untTransfCodUni;

interface

uses
  SysUtils, StrUtils, Uni, ComCtrls, Forms, DB, Classes;

{*******************************************}
{* ESTE VETOR POSSUI CAMPOS QUE SERÃO      *}
{* UTILIZADOS NO PROCESSO DE TRANSF. DE    *}
{* CÓDIGO DE UNIDADE                       *}
{****************************************IV*}
Type TCamposUnidade = record
       strNomArq: String;
       strDesCam: String;
       strCamCod: String;
End;

Type TTransfCodUni = Class(TComponent)
  private

    FCodUniOri: String;
    FCodUniDes: String;

  public

    qryTmpUni      : TUniQuery;
    lsvArqAlterados: TListView;
    arrUnidades    : Array Of TCamposUnidade;

    property strCodUniOri: String Read FCodUniOri Write FCodUniOri;
    property strCodUniDes: String Read FCodUniDes Write FCodUniDes;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    {*******************************************}
    {* FUNÇÕES                                 *}
    {****************************************RL*}
    function fDeletarUnidade(strUniOri: String): Boolean;
    function fAtualizarCodUnidade(strNomArq, strCampo, strUniOri, strUniDes: String; intOpcao: Integer): Integer;
    function fTransferirCodUnidade: Boolean;

    procedure pPreencheArray;    
  End;

implementation

uses untfuncoesSimples,  untCfgRepositorio;

{ TTransfCodUni }

constructor TTransfCodUni.Create(Owner: TComponent);
begin

  inherited;

  Try

    qryTmpUni := fCriaQuery;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

destructor TTransfCodUni.Destroy;
begin

  FreeAndNil(qryTmpUni);

  inherited;
end;

{*****************************************}
{* ATUALIZAR UNIDADE DE DESTINO          *}
{**************************************IV*}
function TTransfCodUni.fAtualizarCodUnidade(strNomArq, strCampo, strUniOri, strUniDes: String; intOpcao: Integer): Integer;
  Var
    strSQL: String;
    strCFG: String;
begin
  Result := 0;

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
  strSQL := strSQL + '  ' + strCampo + ' = :UNIDES ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ' + strCampo + ' = :UNIORI ';

  If (strNomArq = 'CFGSIS') Then
  Begin
    strCFG := '';

    If Assigned(ProcRetCfgRelacionadaArquivo) then
      strCFG := ProcRetCfgRelacionadaArquivo('CADUNI');

    if not fEmptyStr(strCFG) then
      strSQL := strSQL + ' AND SIS_CODCFG IN (' + strCFG + ')'
    Else
    Begin
      Result := 0;
      Exit;
    End;

  End;


  With qryTmpUni Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('UNIDES').AsString := strUniDes;
    ParamByName('UNIORI').AsString := strUniOri;
    ExecSQL;
    Result := RowsAffected;
    Close;
  End;

end;

{***************************************}
{* DELETAR UNIDADE                     *}
{************************************IV*}
function TTransfCodUni.fDeletarUnidade(strUniOri: String): Boolean;
  Var
    strSQL: String;
begin
  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADUNI WHERE UNI_CODUNI = :UNIORI ';

    With qryTmpUni Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('UNIORI').AsString := strUniOri;
      Open;
      fVerificaIntegridade(Self.Name, 'CADUNI', qryTmpUni, True);
      Close;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CADUNI WHERE UNI_CODUNI = :UNIORI ';

    With qryTmpUni Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('UNIORI').AsString := strUniOri;
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
{* TRANFERIR CÓDIGO DE UNIDADE         *}
{************************************IV*}
function TTransfCodUni.fTransferirCodUnidade: Boolean;
  Var
    intContador    : Integer;
    intContador2   : Integer;
    intTamMat      : Integer;
    intRegAlterados: Integer;
//    strSQL         : String;
begin

  intTamMat   := Length(arrUnidades);
  intContador := 0;

  Try

    While intContador < intTamMat Do
    Begin

      lsvArqAlterados.Items.Add;
      lsvArqAlterados.Items[intContador].Caption := arrUnidades[intContador].strDesCam;
      lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
      Inc(intContador);
      Application.ProcessMessages;

    End;

    intContador := 0;
    fStartTransaction;

    While intContador < intTamMat Do
    Begin

      Application.ProcessMessages;
      intRegAlterados := 0;

      {***************************************}
      {* ATUALIZAR UNIDADE DE DESTINO        *}
      {************************************IV*}
      For intContador2 := 1 To 2 Do
      Begin

        intRegAlterados := intRegAlterados + fAtualizarCodUnidade(arrUnidades[intContador].strNomArq,
                                                                  arrUnidades[intContador].strCamCod,
                                                                  FCodUniOri,
                                                                  FCodUniDes,
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
    {* EXCLUIR UNIDADE DE ORIGEM           *}
    {************************************IV*}

    If fDeletarUnidade(FCodUniOri) Then
    Begin
      pGravarTabelaLog(FCodUniOri, FCodUniDes, 'CADUNI');
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
      pMensagensErro(E.Message, '[pTransferirCodUni]');
    End;
  End;


end;

procedure TTransfCodUni.pPreencheArray;
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
      Add(' TCA_ARQUIV = "CADUNI" ');

      Open;

      intPosicao := 0;
      While Not Eof Do
      Begin

        SetLength(arrUnidades, succ(intPosicao));

        arrUnidades[intPosicao].strNomArq := FieldByName('TCA_ARQREL').AsString;
        arrUnidades[intPosicao].strDesCam := FieldByName('TCA_DESCRI').AsString;
        arrUnidades[intPosicao].strCamCod := FieldByName('TCA_CAMREL').AsString;

        Next;

        inc(intPosicao);

      End;

    End;

  Finally
    FreeAndNil(qryTcoArr);
  End;

end;

end.

