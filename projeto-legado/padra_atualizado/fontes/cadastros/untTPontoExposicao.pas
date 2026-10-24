unit untTPontoExposicao;

interface
  uses Uni, untFuncoesSimples, SysUtils;


  Type
    TPontoExposicao = Record
      strCodEmp: String;
      fltOldValue : Double;
  End;

  TPontosExposicoes = array of TPontoExposicao;

  function fLocalizaPontoExposicao(PontosExposicoes: TPontosExposicoes; ACodEmp: String): TPontoExposicao;
  procedure pGravaLogPontoExposicao(qryCommand: TUniQuery; strCodite, strCodOpe, strCodemp: String; fltQtdAnt: Double; fltQtdAtu: Double);
  procedure pAtualizaPontoExposicao(qryCommand: TUniQuery; strCodite, strCodOpe, strCodemp: String; fltQtdAnt: Double; fltQtdAtu: Double; blnGeraLog: Boolean = True);


implementation

function fLocalizaPontoExposicao(PontosExposicoes: TPontosExposicoes; ACodEmp: String): TPontoExposicao;
  var
    PontoExposicao: TPontoExposicao;
Begin
  For PontoExposicao in PontosExposicoes do
  begin
    If PontoExposicao.strCodEmp = ACodEmp Then
    begin
      Result := PontoExposicao;
      Break;
    End;
  End;
End;

procedure pAtualizaPontoExposicao(qryCommand: TUniQuery; strCodite, strCodOpe, strCodemp: String; fltQtdAnt: Double; fltQtdAtu: Double; blnGeraLog: Boolean = True);
  var
    blnCriouQuery: Boolean;
Begin
  blnCriouQuery := False;
  Try
    If Not Assigned(qryCommand) Then
    Begin
      qryCommand := fCriaQuery;
      blnCriouQuery := True
    End;

    qryCommand.SQL.Add('UPDATE ITEGER');
    qryCommand.SQL.Add('       SET ITE_PONEXP = :PONEXP');
    qryCommand.SQL.Add(' WHERE ITE_CODITE = :CODITE');
    qryCommand.SQL.Add('   AND ITE_CODEMP = :CODEMP');

    qryCommand.ParamByName('CODITE').AsString := strCodite;
    qryCommand.ParamByName('CODEMP').AsString := strCodemp;
    qryCommand.ParamByName('PONEXP').AsFloat  := fltQtdAtu;

    qryCommand.ExecSQL;
    If blnGeraLog Then
      pGravaLogPontoExposicao(qryCommand, strCodite, strCodOpe, strCodemp, fltQtdAnt, fltQtdAtu);

  Finally
    If blnCriouQuery then
      FreeAndNil(qryCommand);
  End;
End;

procedure pGravaLogPontoExposicao(qryCommand: TUniQuery; strCodite, strCodOpe, strCodemp: String; fltQtdAnt: Double; fltQtdAtu: Double);
begin
  qryCommand.SQL.Clear;
  qryCommand.SQL.Add('INSERT LOGPEX(');
  qryCommand.SQL.Add('AUTOINCREM,');
  qryCommand.SQL.Add('PEX_LOGDTA,');
  qryCommand.SQL.Add('PEX_LOGHRA,');
  qryCommand.SQL.Add('PEX_LOGOPE,');
  qryCommand.SQL.Add('PEX_CODITE,');
  qryCommand.SQL.Add('PEX_QTDANT,');
  qryCommand.SQL.Add('PEX_QTDATU,');
  qryCommand.SQL.Add('PEX_CODEMP) VALUES (');
  qryCommand.SQL.Add(':AUTOINCREM,');
  qryCommand.SQL.Add(':PEX_LOGDTA,');
  qryCommand.SQL.Add(':PEX_LOGHRA,');
  qryCommand.SQL.Add(':PEX_LOGOPE,');
  qryCommand.SQL.Add(':PEX_CODITE,');
  qryCommand.SQL.Add(':PEX_QTDANT,');
  qryCommand.SQL.Add(':PEX_QTDATU,');
  qryCommand.SQL.Add(':PEX_CODEMP)');

  qryCommand.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGPEX', strCodemp);
  qryCommand.ParamByName('PEX_LOGDTA').AsDate     := fNow();
  qryCommand.ParamByName('PEX_LOGHRA').AsDateTime := fNow();
  qryCommand.ParamByName('PEX_LOGOPE').AsString   := strCodOpe;
  qryCommand.ParamByName('PEX_CODITE').AsString   := strCodite;
  qryCommand.ParamByName('PEX_QTDANT').AsFloat    := fltQtdAnt;
  qryCommand.ParamByName('PEX_QTDATU').AsFloat    := fltQtdAtu;
  qryCommand.ParamByName('PEX_CODEMP').AsString   := strCodemp;

  qryCommand.ExecSQL;
End;



end.
