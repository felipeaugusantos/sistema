unit RotasPorRegiao.Funcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Uni;

type
  TFuncoesRotas = class
  private
    class function fMontaMensagemFeriados(const qryDados: TUniQuery; strCodReg: String): String; static;
    class function fProsseguirComFeriados(const qryDados: TUniQuery; strCodReg: String): Boolean; static;
    class function fValidaCidadesDaRegiaoComFeriadoCadastrado(strCodReg: String; dtaFeriado: TDate): Boolean;
  public
    class function fValidaFeriadoCidades(strCodReg: String; dtaFeriado: TDate): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TFuncoesRotas }

class function TFuncoesRotas.fValidaCidadesDaRegiaoComFeriadoCadastrado(strCodReg: String; dtaFeriado: TDate): Boolean;
  Var
    qryDados: TUniQuery;
begin
  Result := True;
  qryDados := fCriaQuery;

  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := ' SELECT                           '+
                         '   CID_NOMCID                     '+
                         ' FROM                             '+
                         '   ROTREC                         '+
                         '   INNER JOIN FERCID              '+
                         '     ON FCI_CODCID = REC_CODCID   '+
                         '   INNER JOIN CADCID              '+
                         '     ON CID_CODCID = FCI_CODCID   '+
                         ' WHERE FCI_DTAFER = :DTAFER       '+
                         '   AND REC_CODREG = :CODREG       ';

    qryDados.ParamByName('DTAFER').AsDate   := dtaFeriado;
    qryDados.ParamByName('CODREG').AsString := strCodReg;
    qryDados.Open;

    If (qryDados.IsEmpty) Or (fProsseguirComFeriados(qryDados, strCodReg)) Then
      Exit;

    Result := False;
  Finally
    FreeAndNil(qryDados);
  End;
end;

class function TFuncoesRotas.fProsseguirComFeriados(Const qryDados: TUniQuery; strCodReg: String): Boolean;
  Var
    strMensagem: String;
begin
  strMensagem := fMontaMensagemFeriados(qryDados, strCodReg);
  Result := (fMensagem('ATENÇÃO', strMensagem,['&Sim','&Não']) = 1);
end;

class function TFuncoesRotas.fMontaMensagemFeriados(Const qryDados: TUniQuery; strCodReg: String): String;
  Var
    strRegiao: String;
begin
  Result := '';
  strRegiao := strCodReg + '-' + fRetNomRegiao(strCodReg);
  qryDados.First;

  While (Not qryDados.Eof) Do
  Begin
    If (Not fEmptyStr(Result)) Then
    Begin
      If (qryDados.RecNo = qryDados.RecordCount) Then
        Result := Result + ' e '
      Else
        Result := Result + ', ';
    End;

    Result := Result + qryDados.FieldByName('CID_NOMCID').AsString;
    qryDados.Next;
  End;

  If (qryDados.RecordCount = 1) Then
    Result := 'A data especificada é um feriado na cidade de ' + Result +
              ', registrada na região '+strRegiao+'. Deseja prosseguir?'
  Else
    Result := 'A data especificada é um feriado nas cidades de ' + Result +
              ', registradas na região '+strRegiao+'. Deseja prosseguir?';
end;

class function TFuncoesRotas.fValidaFeriadoCidades(strCodReg: String; dtaFeriado: TDate): Boolean;
begin
  Result := True;

  If (Not fCfgSis('FERREG', varBoolean)) Then
    Exit;

  If (fValidaCidadesDaRegiaoComFeriadoCadastrado(strCodReg, dtaFeriado)) Then
    Exit;

  Result := False;
end;

end.
