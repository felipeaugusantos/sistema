unit untProcessadorGravandoExecucaoAlessiCores;

interface

uses
  untAbstractProcessadorGravandoExecucaoAlessi, Classes, DB,  Variants, SysUtils,
  untIGravando, Uni, Math, untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoExecucaoAlessiCores = class(TAbstractProcessadorGravandoExecucaoAlessi,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    intAuto: Integer;
    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
    function fRetCodUnidade(strEmbalagem: String): String;
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
    constructor Create(); override;
    procedure LimparTabelas; override;
  end;

implementation

uses
  untFuncoesSimples, untDDLFactory;

{ TProcessadorGravandoExecucaoAlessiCores }

constructor TProcessadorGravandoExecucaoAlessiCores.Create;
begin
  inherited Create();
  intAuto := 0;
end;

function TProcessadorGravandoExecucaoAlessiCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoAlessiCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsert('ALE_CADALE');
end;

function TProcessadorGravandoExecucaoAlessiCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [QUARTO$] AS F               ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "QUARTO" ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [GALAO$] AS F                ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "GALÃO"  ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [LATA$] AS F                 ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "LATA"   ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [LATA$] AS F                 ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "LATA"   ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [LATA$] AS F                 ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "LATA"   ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [25KG$] AS F                 ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "25 KG"  ' +
    ' UNION                          ' +
    ' SELECT                         ' +
    '   F.[CODIGO]                   ' +
    '   , F.[COLECAO]                ' +
    '   , F.[PRODUTO]                ' +
    '	, F.[BASE]                   ' +
    '   , F.[CODIGO_FORMULA]         ' +
    '	, F.[NOME_FORMULA]           ' +
    '	, F.[CORANTE_1]              ' +
    '	, F.[ML_1]                   ' +
    '	, F.[CORANTE_2]              ' +
    '	, F.[ML_2]                   ' +
    '	, F.[CORANTE_3]              ' +
    '	, F.[ML_3]                   ' +
    '	, F.[CORANTE_4]              ' +
    '	, F.[ML_4]                   ' +
    '   , B.[EMBALAGEM]              ' +
    ' FROM                           ' +
    '   [5KG$] AS F                  ' +
    '   INNER JOIN [BASES$] AS B     ' +
    '     ON F.PRODUTO = B.[PRODUTO] ' +
    '     AND F.BASE = B.[BASE]      ' +
    ' WHERE B.[EMBALAGEM] = "5 KG"   ';
end;

procedure TProcessadorGravandoExecucaoAlessiCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ALE_CADALE';
end;

function TProcessadorGravandoExecucaoAlessiCores.fRetCodUnidade(strEmbalagem: String): String;
begin
  Result := 'LT';

  if ((strEmbalagem =  'GALAO') Or (strEmbalagem =  '5KG')) Then
    Result := 'GL'
  else
  if ((strEmbalagem =  'LATA') Or (strEmbalagem =  '25KG')) Then
    Result := 'LA'
  else
  if (strEmbalagem =  'QUARTO') Then
    Result := 'QT';
end;

procedure TProcessadorGravandoExecucaoAlessiCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  intCont: Integer;
  intParteInteira: Integer;
  fltParteFracao: Double;
  strMd5 : String;
begin
  qryGrava := TUniQuery(qryDestino);
  qryGrava.SQL.Text := GetSqlDestino;

  qryGrava.ParamByName('AUTOINCREM').AsString := fFormataAutInc(fInc(intAuto), VS_strCodEmp);
  qryGrava.ParamByName('ALE_COLECA').AsString := LimpaTexto(qryOrigem.FieldByName('COLECAO').AsString);
  qryGrava.ParamByName('ALE_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString);
  qryGrava.ParamByName('ALE_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
  qryGrava.ParamByName('ALE_NOMCOR').AsString := LimpaTexto(qryOrigem.FieldByName('CODIGO_FORMULA').AsString);
  qryGrava.ParamByName('ALE_NOMLON').AsString := LimpaTexto(qryOrigem.FieldByName('NOME_FORMULA').AsString);
  qryGrava.ParamByName('ALE_CODEMP').AsString := VS_strCodEmp;
  qryGrava.ParamByName('ALE_EMBALA').AsString := LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString);
  qryGrava.ParamByName('ALE_CODUNI').AsString := fRetCodUnidade(LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString));

  strMd5 := '';

  for intCont := 1 to 4 do
  begin
    if fStrToFloat(qryOrigem.FieldByName('ML_' + IntToStr(intCont)).AsString) <= 0 then
      Break;

    MlParaOnca(qryOrigem.FieldByName('ML_' + IntToStr(intCont)).AsFloat, intParteInteira, fltParteFracao);

    qryGrava.ParamByName('ALE_CODC' + fStrZero(intCont, 2)).AsString  := LimpaTexto(qryOrigem.FieldByName('CORANTE_' + IntToStr(intCont)).AsString);
    qryGrava.ParamByName('ALE_QTOZ' + fStrZero(intCont, 2)).AsInteger := intParteInteira;
    qryGrava.ParamByName('ALE_QSHO' + fStrZero(intCont, 2)).AsFloat   := RoundTo(fltParteFracao,0);

    strMd5 := strMd5 + qryGrava.ParamByName('ALE_CODC' + fStrZero(intCont, 2)).AsString +
      IntToStr(qryGrava.ParamByName('ALE_QTOZ' + fStrZero(intCont, 2)).AsInteger) +
      FloatToStr(qryGrava.ParamByName('ALE_QSHO' + fStrZero(intCont, 2)).AsFloat);
  end;

  qryGrava.ParamByName('ALE_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('ALE_COLECA').AsString +
                                                  qryGrava.ParamByName('ALE_PRODUT').AsString +
                                                  qryGrava.ParamByName('ALE_BASE__').AsString +
                                                  qryGrava.ParamByName('ALE_NOMCOR').AsString +
                                                  qryGrava.ParamByName('ALE_NOMLON').AsString +
                                                  qryGrava.ParamByName('ALE_EMBALA').AsString +
                                                  strMd5 );
  qryGrava.ExecSQL;
end;

function TProcessadorGravandoExecucaoAlessiCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoAlessiCores.LimparTabelas;
begin
  TruncateTable('ALE_CADALE');
end;

procedure TProcessadorGravandoExecucaoAlessiCores.MlParaOnca(fltMl: Double; var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

procedure TProcessadorGravandoExecucaoAlessiCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a cor: [%s - %s - %s - %s - %s - %s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('COLECAO').AsString),
      LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString),
      LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
      LimpaTexto(qryOrigem.FieldByName('CODIGO_FORMULA').AsString),
      LimpaTexto(qryOrigem.FieldByName('NOME_FORMULA').AsString),
      LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString),
      E.ClassName,
      E.Message]);
end;

end.
