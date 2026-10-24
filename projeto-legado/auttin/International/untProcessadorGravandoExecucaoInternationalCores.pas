unit untProcessadorGravandoExecucaoInternationalCores;

interface

uses
  untAbstractProcessadorGravandoInternational, DB, Classes, SysUtils, untIGravando,  Uni, ADODB,
  Variants;

type
  TProcessadorGravandoExecucaoInternationalCores = class (TAbstractProcessadorGravandoInternational)
  private
    strDesCor,
    strLinha: String;

    intCont: Integer;

    function fRetornaCodigoEmbalagem(strEmbala: String): String;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
  end;

implementation

uses
  untNovaFormulaInternational, untFuncoesSimples;

{ TProcessadorGravandoExecucaoInternationalCores }

function TProcessadorGravandoExecucaoInternationalCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoInternationalCores.fRetornaCodigoEmbalagem(
  strEmbala: String): String;
begin
  If strEmbala = '3,6' Then
    Result := '1'
  Else If strEmbala = '20' Then
    Result := '2'
  Else
    Result := '3';
end;

function TProcessadorGravandoExecucaoInternationalCores.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM INT_CADINT';
end;

procedure TProcessadorGravandoExecucaoInternationalCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'INT_CADINT';
end;

procedure TProcessadorGravandoExecucaoInternationalCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  If ((strDesCor <> qryOrigem.FieldByName('Produto').AsString) Or
      (strLinha <> qryOrigem.FieldByName('No_OB').AsString)) Then
  Begin
    intCont := 1;

    strDesCor := qryOrigem.FieldByName('Produto').AsString;
    strLinha  := qryOrigem.FieldByName('No_OB').AsString;

    qryDestino.Insert;
    qryDestino.FieldByName('INT_DESCOR').AsString := qryOrigem.FieldByName('Produto').AsString;
    qryDestino.FieldByName('INT_CODBAS').AsString := qryOrigem.FieldByName('Base').AsString;
    qryDestino.FieldByName('INT_CODEMB').AsString := fRetornaCodigoEmbalagem(FloatToStr(fFormataFloat(qryOrigem.FieldByName('Vasilhame').AsFloat,2)));
    qryDestino.FieldByName('INT_LINHA_').AsString := qryOrigem.FieldByName('No_OB').AsString;
    qryDestino.FieldByName('INT_CODEMP').AsString := VS_strCodEmp;
    qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INT_CADINT', VS_strCodEmp);
    qryDestino.FieldByName('INT_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('INT_DESCOR').AsString +
                                                            qryDestino.FieldByName('INT_CODBAS').AsString +
                                                            qryDestino.FieldByName('INT_CODEMB').AsString +
                                                            qryDestino.FieldByName('INT_LINHA_').AsString);
  End
  Else
  Begin
    If qryDestino.Locate('INT_DESCOR;INT_LINHA_;INT_CODEMB', VarArrayOf([
             qryOrigem.FieldByName('Produto').AsString,
             qryOrigem.FieldByName('No_OB').AsString,
             fRetornaCodigoEmbalagem(FloatToStr(fFormataFloat(qryOrigem.FieldByName('Vasilhame').AsFloat,2)))]), []) Then
      qryDestino.Edit
    Else
      Exit;
  End;

  If (fFormataFloat(qryOrigem.FieldByName('Volume').AsFloat,2) <= 0) Then
  Begin
    qryDestino.Cancel;
    Exit;
  End;

  qryDestino.FieldByName('INT_FORM' + fStrZero(intCont,2)).AsString := qryOrigem.FieldByName('Corante').AsString;
  qryDestino.FieldByName('INT_QTDC' + fStrZero(intCont,2)).AsString := FloatToStr(fFormataFloat(qryOrigem.FieldByName('Volume').AsFloat,2));

  Inc(intCont);

  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoInternationalCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
            {(qryDestino.Locate('INT_DESCOR;INT_LINHA_;INT_CODEMB', VarArrayOf([
             qryOrigem.FieldByName('Produto').AsString,
             qryOrigem.FieldByName('No_OB').AsString,
             fRetornaCodigoEmbalagem(FloatToStr(fFormataFloat(qryOrigem.FieldByName('Vasilhame').AsFloat,2)))]), []));}
end;

procedure TProcessadorGravandoExecucaoInternationalCores.LimparTabelas;
begin
  TruncateTable('INT_CADINT');
end;

procedure TProcessadorGravandoExecucaoInternationalCores.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o colorante [%s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('Produto').AsString,
    qryOrigem.FieldByName('No_OB').AsString,
    FloatToStr(qryOrigem.FieldByName('Vasilhame').AsFloat),
    E.ClassName,
    E.Message
  ]);
end;

function TProcessadorGravandoExecucaoInternationalCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
  Result := Result + ' SELECT A.Produto,   ';
  Result := Result + '        A.No_OB,     ';
  Result := Result + '        A.Base,      ';
  Result := Result + '        A.Vasilhame, ';
  Result := Result + '        B.Corante,   ';
  Result := Result + '        B.Volume     ';
  Result := Result + '   FROM Production_History A                        ';
  Result := Result + '  INNER JOIN Uso_Corante B ON B.Produto = A.Produto ';
  Result := Result + '                          AND B.No_OB  = A.No_OB    ';
  Result := Result + '  ORDER BY A.Produto, A.No_OB                       ';
end;

end.
