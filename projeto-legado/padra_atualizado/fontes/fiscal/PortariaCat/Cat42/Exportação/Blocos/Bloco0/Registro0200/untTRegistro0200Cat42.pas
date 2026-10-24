unit untTRegistro0200Cat42;

interface

uses System.Generics.Collections, untTRegistroBaseCat42, untTProduto, untTUtilidadeCat42, Forms, StrUtils, SysUtils;

type
  TRegistro0200 = class(TRegistroBase)
  private
    FListaProdutos: TObjectList<TProduto>;
    FUtilidadeCat42: TUtilidadeCat42;

    function fValidaGTIN(strGTIN: string): Boolean;
    function fPrefixoValido(strPrefixo: string): boolean;
    function fValidaCodBar(strCodBar: string): boolean;
  public
    procedure pGerar; override;

    property listaProdutos: TObjectList<TProduto> read FListaProdutos write FListaProdutos;
  end;

implementation

uses untFuncoes, Uni;

{ TRegistro0200 }

function TRegistro0200.fPrefixoValido(strPrefixo: string): boolean;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT COUNT(*) CNT FROM PREGS1 WHERE :PREFIX BETWEEN GS1_PREINI AND GS1_PREFIN';
      ParamByName('PREFIX').AsString := strPrefixo;
      Open;

      Result := FieldByName('CNT').AsInteger > 0
    end;
  finally
    qryAux.Free;
  end;
end;

function TRegistro0200.fValidaCodBar(strCodBar: string): boolean;
begin
  if (fEmptyStr(strCodBar)) or (Length(strCodBar) < 3) then
    Result := False
  else
  begin
    Result := fPrefixoValido(LeftStr(strCodBar, 3));
    if Result then
      Result := fValidaGTIN(strCodBar);
  end;
end;

function TRegistro0200.fValidaGTIN(strGTIN: string): Boolean;
  Var
    intCnt, intSoma, intResultado, intBase10: Integer;
begin
  //Verifica se todos os caracteres de strGTIN são números
  for intCnt:= 1 to Length(strGTIN) do
  begin
    if not {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}(CharInSet(strGTIN[intCnt], ['0'..'9'])){$ELSE}(strGTIN[intCnt] in ['0'..'9']){$IFEND} Then
    begin
      Result:= False;
      Exit;
    end;
  end;
  //Verifica se strGTIN tem o tamanho necessário
  if Length(strGTIN) in [8,12,13,14] then
  begin
    intSoma:= 0;
    for intCnt:= 1 to (Length(strGTIN) -1) do
    begin
      if Length(strGTIN) = 13 then
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3);
      end
      else
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1);
      end;
    end;
    intBase10:= intSoma;
    //Verifica se intBase10 é múltiplo de 10
    if not (intBase10 mod 10 = 0) then
    begin
      while not (intBase10 mod 10 = 0) do
      begin
        intBase10:= intBase10 + 1;
      end;
    end;
    intResultado:= intBase10 - intSoma;
    //Verifica se o intResultado encontrado é igual ao caractere de controle
    if intResultado = strtoint(strGTIN[Length(strGTIN)]) then
      Result:= True
    else
      Result:= False;
  end
  else
    Result:= False;
end;

procedure TRegistro0200.pGerar;
  var
    strDescricaoProduto: string;
    produto: TProduto;
begin
  inherited;

  abertura.lblOperacao.Caption := 'Gerando registro produtos...';
  abertura.progressoTela.Max := FListaProdutos.Count;
  abertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for produto in FListaProdutos do
  begin
    strDescricaoProduto := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(
                           fRemoveAllChars(fTiraCaracEspeciais(produto.strDescricaoItem, false, true, true, true)), 'º', ''), 'Ç', 'C'), '~', ''), 'Ø', ''), '´', ''), '°', ''), '²', ''), '³', '');

    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '?', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, 'Ñ', 'N');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, 'ñ', 'n');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, 'ç', 'c');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '-', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '–', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, 'ª', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, 'ø', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '¨', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '¹', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '¼', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '½', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '¾', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '"', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '>', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '<', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '&', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '´', '');
    strDescricaoProduto := AnsiReplaceStr(strDescricaoProduto, '`', '');

//'<','>','!','@','#','$','%','¨','&','*','(',')','_','+','=','{',
//'}','[',']','?',';',':',',','|','*','"','~','^','´','`','¨','æ',
//'Æ','ø','£','Ø','ƒ','ª','º','¿','®','½','¼','ß','µ','þ','ý','Ý'

    pInicializaLinha;

    pCampo(strTipoRegistro);                                                                                          //001 Texto fixo contendo "0200"
    pCampo(produto.strCodItem);                                                                                       //002 Código do item
    pCampo(strDescricaoProduto);                                                                                      //003 Descrição do item
    pCampo(IIF(fValidaCodBar(produto.strCodBarra), produto.strCodBarra, 'SEM GTIN'));                                 //004 Representação alfanumérica do código de barras do produto
    pCampo(produto.unidade.strSigla);                                                                                 //005 Unidade de medida utilizada na quantificação de estoques
    pCampo(produto.strCodigoNCM);                                                                                     //006 Código NCM
    pCampo(fFloatToStrVirgula(FUtilidadeCat42.fRetAliquotaICMS(abertura.empresa.strCodigo, produto.strCodItem),5,2)); //007 Alíquota de Icms aplicável ao item nas operações internas
    pCampo(produto.strCodigoCEST, False);                                                                             //008 Código especificador da substituição tributária

    intQuantidadeGerada := intQuantidadeGerada + 1;

    abertura.progressoTela.StepBy(1);
    Application.ProcessMessages;

    pAdicionaLista;
  end;
end;

end.
