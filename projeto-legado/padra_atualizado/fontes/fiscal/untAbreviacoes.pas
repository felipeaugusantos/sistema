unit untAbreviacoes;

interface
  uses Uni, Classes, Dialogs, System.SysUtils ;

  Type THabilitarForeignKey = Class
  private
    class function fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
  end;

  procedure pCopiarAbreviacaoPisParaCofins(strCodOrigem: String);
  procedure pCopiarAbreviacaoCofinsParaPis(strCodOrigem: String);
  procedure pCopiarAbreviacao(strOrigem, strDestino, strCodOrigem, strCodDestino: String);
  function fAbreviacaoValida(strTabela, strCodAbf: String): Boolean;
  function fAbreviacaoJaExiste(strTabela, strCodAbf: String): Boolean;


implementation

uses untFuncoesSimples;


procedure pCopiarAbreviacaoPisParaCofins(strCodOrigem: String);
  Var
    strCodAbf: String;
begin
  Repeat
    If Not InputQuery('Digite a nova abreviação', 'Digite a nova abreviação', strCodAbf) Then
    Begin
      Exit;
    End;
    strCodAbf := fStrZero(strCodAbf, 3);
  Until fAbreviacaoValida('COFSAI', strCodAbf);

  pCopiarAbreviacao('PIS', 'COF', strCodOrigem, strCodAbf);
end;

procedure pCopiarAbreviacaoCofinsParaPis(strCodOrigem: String);
  Var
    strCodAbf: String;
begin
  Repeat
    If Not InputQuery('Digite a nova abreviação', 'Digite a nova abreviação', strCodAbf) Then
    Begin
      Exit;
    End;
    strCodAbf := fStrZero(strCodAbf, 3);
  Until fAbreviacaoValida('PISSAI', strCodAbf);

  pCopiarAbreviacao('COF', 'PIS', strCodOrigem, strCodAbf);

end;

procedure pCopiarAbreviacao(strOrigem, strDestino, strCodOrigem, strCodDestino: String);
  Var
    qryAux: TUniQuery;
    qryOrigem: TUniQuery;
    strTabOrigemSai: String;
    strTabDestinoSai: String;
    strTabOrigemEnt: String;
    strTabDestinoEnt: String;
begin

  strTabOrigemSai  := strOrigem  + 'SAI';
  strTabDestinoSai := strDestino + 'SAI';
  strTabOrigemEnt  := strOrigem  + 'ENT';
  strTabDestinoEnt := strDestino + 'ENT';

  qryOrigem := fCriaQuery(Nil);

  THabilitarForeignKey.fHabilitarForeignKey(False);

  Try
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM ' + strTabDestinoSai + ' WHERE APC_CODAPC = :CODIGO');
    qryAux.ParamByName('CODIGO').AsString := strCodDestino;
    qryAux.ExecSQL;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM ' + strTabDestinoEnt + ' WHERE APC_CODAPC = :CODIGO');
    qryAux.ParamByName('CODIGO').AsString := strCodDestino;
    qryAux.ExecSQL;

    qryOrigem.SQL.Clear;
    qryOrigem.SQL.Add('SELECT * FROM ' + strTabOrigemSai + ' WHERE APC_CODAPC = :CODIGO');
    qryOrigem.ParamByName('CODIGO').AsString := strCodOrigem;
    qryOrigem.Open;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM ' + strTabDestinoSai + ' WHERE FALSE');
    qryAux.Open;

    While (Not qryOrigem.Eof) Do
    Begin
      qryAux.Append;
      qryAux.FieldByName('APC_CODAPC').AsString := strCodDestino;
      qryAux.FieldByName('APC_DESCRI').AsString := qryOrigem.FieldByName('APC_DESCRI').AsString;
      qryAux.FieldByName('APC_CSTSAI').AsString := qryOrigem.FieldByName('APC_CSTSAI').AsString;
      qryAux.FieldByName('APC_BASSAI').AsFloat  := qryOrigem.FieldByName('APC_BASSAI').AsFloat;
      qryAux.FieldByName('APC_ALQSAI').AsFloat  := qryOrigem.FieldByName('APC_ALQSAI').AsFloat;
      qryAux.FieldByName('APC_CFOSAI').AsString := qryOrigem.FieldByName('APC_CFOSAI').AsString;
      qryAux.FieldByName('APC_MOTISE').AsString := qryOrigem.FieldByName('APC_MOTISE').AsString;
      qryAux.FieldByName('APC_VIGENC').AsDateTime := qryOrigem.FieldByName('APC_VIGENC').AsDateTime;
      qryAux.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strTabDestinoSai, VS_strCodEmp);
      qryAux.Post;

      qryOrigem.Next;
    End;

    qryOrigem.SQL.Clear;
    qryOrigem.SQL.Add('SELECT * FROM ' + strTabOrigemEnt + ' WHERE APC_CODAPC = :CODIGO');
    qryOrigem.ParamByName('CODIGO').AsString := strCodOrigem;
    qryOrigem.Open;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM ' + strTabDestinoEnt + ' WHERE FALSE');
    qryAux.Open;

    While (Not qryOrigem.Eof) Do
    Begin
      qryAux.Append;
      qryAux.FieldByName('APC_CODAPC').AsString := strCodDestino;
      qryAux.FieldByName('APC_DESCRI').AsString := qryOrigem.FieldByName('APC_DESCRI').AsString;
      qryAux.FieldByName('APC_CSTENT').AsString := qryOrigem.FieldByName('APC_CSTENT').AsString;
      qryAux.FieldByName('APC_BASENT').AsFloat  := qryOrigem.FieldByName('APC_BASENT').AsFloat;
      qryAux.FieldByName('APC_ALQENT').AsFloat  := qryOrigem.FieldByName('APC_ALQENT').AsFloat;
      qryAux.FieldByName('APC_CFOENT').AsString := qryOrigem.FieldByName('APC_CFOENT').AsString;
      qryAux.FieldByName('APC_VIGENC').AsDateTime := qryOrigem.FieldByName('APC_VIGENC').AsDateTime;
      qryAux.FieldByName('APC_CODEMP').AsString := VS_strCodEmp;
      qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strTabDestinoEnt, VS_strCodEmp);
      qryAux.Post;

      qryOrigem.Next;
    End;
  Except
    On e: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCopiarAbreviacao]');
    End;
  End;

  THabilitarForeignKey.fHabilitarForeignKey(True);

  FreeAndNil(qryOrigem);
  FreeAndNil(qryAux);
end;

function fAbreviacaoValida(strTabela, strCodAbf: String): Boolean;
begin
  Result := True;
  If (StrToIntDef(strCodAbf, 0) <= 0) Or
     (Length(strCodAbf) <> 3)         Then
  Begin
    pMensagemOk('Informe um código válido.');
    Result := False;
  End
  Else If fAbreviacaoJaExiste(strTabela, strCodAbf) Then
  Begin
    Result := (fMensagem('', 'Já existe uma abreviação com este código. Deseja sobrescrever?',
      ['&Sim', '&Não'], 2) = 1);
  End;
end;


{*******************************************}
{* ESSA FUNÇÃO NÃO DEVE MAIS SER UTILIZADA,*}
{* POIS CAUSA PROBLEMA NA REPLICAÇÃO       *}
{*******************************************}
{* HABILITA DESABILITA VERIFICAÇÃO DE      *}
{* CHAVE ESTRANGEIRA (DESCOBERTO PELO      *}
{* EDUARDO)                                *}
{****************************************MV*}
function fAbreviacaoJaExiste(strTabela, strCodAbf: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM ' + strTabela + ' WHERE APC_CODAPC = :CODIGO');
  qryAux.ParamByName('CODIGO').AsString := strCodAbf;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

class function THabilitarForeignKey.fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    Try

      With qryGenTmp Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add('SET FOREIGN_KEY_CHECKS=' + IIF(blnHabilitar, '1', '0'));
        ExecSQL;
        Close;
        Result := True;

      End;

    Except
      On E: Exception Do
      Begin

        Result := False;
        pMensagensErro(E.Message, '[fHabilitarForeignKey]');

      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;



end.
