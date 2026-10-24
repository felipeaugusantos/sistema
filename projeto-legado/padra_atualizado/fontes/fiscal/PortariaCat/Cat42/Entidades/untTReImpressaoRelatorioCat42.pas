unit untTReImpressaoRelatorioCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     UniClientDataSet,
     untTUtilidadeCat42,
     untTypesSistema,
     SysUtils,
     Uni;

type
  TReImpressaoRelatorioCat42 = class
  private
    FAbertura: TDadosAberturaExportacaoCat42;
    FCdsRelatorio: TUniClientDataset;
    FCdsRelContabil: TUniClientDataset;
    FUtilidadeCat42: TUtilidadeCat42;
    FQryAux: TUniQuery;
    FProdutos: string;
    FLinhaGrupo: string;

    procedure pCarregaDados;
  public
    function fReImpressao(arrProduto: TConsultasArray = nil; arrLinhaGrupo: TConsultasArray = nil): boolean;

    constructor create(cdsRelatorio, cdsRelContabil: TUniClientDataset; abertura: TDadosAberturaExportacaoCat42);
    destructor Destroy; override;
  end;

implementation

uses untFuncoes;

constructor TReImpressaoRelatorioCat42.create(cdsRelatorio, cdsRelContabil: TUniClientDataset; abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create;
  FCdsRelatorio := cdsRelatorio;
  FCdsRelContabil := cdsRelContabil;
  FQryAux := fCriaQuery(nil);
  FAbertura := abertura;

  FUtilidadeCat42 := TUtilidadeCat42.Create;
end;

destructor TReImpressaoRelatorioCat42.Destroy;
begin
  FQryAux.Free;
  FUtilidadeCat42.Free;

  inherited;
end;

function TReImpressaoRelatorioCat42.fReImpressao(arrProduto: TConsultasArray = nil; arrLinhaGrupo: TConsultasArray = nil): boolean;
  var
    produto: TConsultas;
    LinhaGrupo: TConsultas;
begin

  FProdutos := '';

  if arrProduto <> nil then
  begin
    for produto in arrProduto do
    begin
      FProdutos := FProdutos + '_' + produto.strCodigo;
    end;
  end;

  FLinhaGrupo := '';

  if arrLinhaGrupo <> nil then
  begin
    for LinhaGrupo in arrLinhaGrupo do
    begin
      FLinhaGrupo := FLinhaGrupo + '_' + LinhaGrupo.strCodigo;
    end;
  end;


  pCarregaDados;

  Result := FCdsRelatorio.RecordCount > 0;
end;

procedure TReImpressaoRelatorioCat42.pCarregaDados;
  var
    strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAT_CAMP01, ';
  strSQL := strSQL + '  CAT_CAMP02, ';
  strSQL := strSQL + '  CAT_CAMP03, ';
  strSQL := strSQL + '  CAT_CAMP04, ';
  strSQL := strSQL + '  CAT_CAMP05, ';
  strSQL := strSQL + '  CAT_CAMP06, ';
  strSQL := strSQL + '  CAT_CAMP07, ';
  strSQL := strSQL + '  CAT_CAMP08, ';
  strSQL := strSQL + '  CAT_CAMP09, ';
  strSQL := strSQL + '  CAT_CAMP10, ';
  strSQL := strSQL + '  CAT_CAMP11, ';
  strSQL := strSQL + '  CAT_CAMP12, ';
  strSQL := strSQL + '  CAT_CAMP13, ';
  strSQL := strSQL + '  CAT_CAMP14, ';
  strSQL := strSQL + '  CAT_CAMP15, ';
  strSQL := strSQL + '  CAT_CAMP16, ';
  strSQL := strSQL + '  CAT_CAMP17, ';
  strSQL := strSQL + '  CAT_CAMP18, ';
  strSQL := strSQL + '  CAT_CAMP19, ';
  strSQL := strSQL + '  CAT_CAMP20, ';
  strSQL := strSQL + '  CAT_CAMP21, ';
  strSQL := strSQL + '  CAT_CAMP22, ';
  strSQL := strSQL + '  CAT_CAMP23, ';
  strSQL := strSQL + '  CAT_CAMP24, ';
  strSQL := strSQL + '  CAT_CAMP25, ';
  strSQL := strSQL + '  CAT_CAMP26, ';
  strSQL := strSQL + '  CAT_CAMP27, ';
  strSQL := strSQL + '  CONCAT(ITE_CODITE, " - ", ITE_DESITE) AS MERCADORIA, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIDADE, ';
  strSQL := strSQL + '  18 AS ALIQUOTA, ';
  strSQL := strSQL + '  ITE_CODITE ';

  if fCampoExiste('CAT_42_DADOS', 'VALORCONTABIL') then
    strSQL := strSQL + '  ,VALORCONTABIL ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CAT_42_DADOS ';

  strSQL := strSQL + '  LEFT JOIN CADITE ';
  strSQL := strSQL + '    ON ITE_CODITE = CAT_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ';
  strSQL := strSQL + '    ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + 'WHERE CAT_MESANO = :MESANO ';
  strSQL := strSQL + '  AND CAT_CODEMP = :CODEMP ';

  If Not fEmptyStr(FProdutos) Then
    strSQL := strSQL + '  AND LOCATE(CAT_CODITE, :CODITE) > 0 ';

  If Not fEmptyStr(FLinhaGrupo) Then
    strSQL := strSQL + '  AND LOCATE(ITE_CODGRU, :CODGRU) <= 0 ';

  with FQryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Text := strSQL;
    ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FAbertura.dtaDataInicial);
    ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
    If Not fEmptyStr(FProdutos) Then
      ParamByName('CODITE').AsString := FProdutos;
    If Not fEmptyStr(FLinhaGrupo) Then
      ParamByName('CODGRU').AsString := FLinhaGrupo;
    Open;

    while not Eof do
    begin
      If (Not fEmptyStr(FieldByName('CAT_CAMP09').AsString)) And
        (FieldByName('VALORCONTABIL').AsFloat > 0) Then
      Begin
        FCdsRelContabil.Open;

        if FCdsRelContabil.Locate('CFOP', FieldByName('CAT_CAMP09').AsString, []) then
          FCdsRelContabil.Edit
        Else FCdsRelContabil.Append;

        FCdsRelContabil.FieldByName('VALORCONTABIL').AsFloat  := FCdsRelContabil.FieldByName('VALORCONTABIL').AsFloat+FieldByName('VALORCONTABIL').AsFloat;
        FCdsRelContabil.FieldByName('ENQUADRAMENTO').AsString := '';
        FCdsRelContabil.FieldByName('CFOP').AsString          := FieldByName('CAT_CAMP09').AsString;
        FCdsRelContabil.Post;
        FCdsRelContabil.Close;
      End;


      //DADOS CABEÇALHO
      FCdsRelatorio.Append;
      FCdsRelatorio.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
      FCdsRelatorio.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
      FCdsRelatorio.FieldByName('MERCADORIA').AsString := FieldByName('MERCADORIA').AsString;
      FCdsRelatorio.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      FCdsRelatorio.FieldByName('UNIDADE').AsString := FieldByName('UNIDADE').AsString;
      FCdsRelatorio.FieldByName('ALIQUOTA').AsFloat := FUtilidadeCat42.fRetAliquotaICMS(FAbertura.empresa.strCodigo, FieldByName('ITE_CODITE').AsString); //Retorna a alíquota do ICMS do produto. Ricardo Lima - 21/06/2016

      //DADOS GERAIS
      FCdsRelatorio.FieldByName('CAMPO01').AsInteger := FieldByName('CAT_CAMP01').AsInteger;
      FCdsRelatorio.FieldByName('CAMPO02').AsString := FieldByName('CAT_CAMP02').AsString;
      FCdsRelatorio.FieldByName('CAMPO03').AsString := FieldByName('CAT_CAMP03').AsString;
      FCdsRelatorio.FieldByName('CAMPO04').AsString := FieldByName('CAT_CAMP04').AsString;
      FCdsRelatorio.FieldByName('CAMPO05').AsString := FieldByName('CAT_CAMP05').AsString;
      FCdsRelatorio.FieldByName('CAMPO06').AsString := FieldByName('CAT_CAMP06').AsString;
      FCdsRelatorio.FieldByName('CAMPO07').AsString := FieldByName('CAT_CAMP07').AsString;
      FCdsRelatorio.FieldByName('CAMPO08').AsString := FieldByName('CAT_CAMP08').AsString;
      FCdsRelatorio.FieldByName('CAMPO09').AsString := FieldByName('CAT_CAMP09').AsString;
      FCdsRelatorio.FieldByName('CAMPO10').AsString := FieldByName('CAT_CAMP10').AsString;
      FCdsRelatorio.FieldByName('CAMPO11').AsFloat := FieldByName('CAT_CAMP11').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO12').AsFloat := FieldByName('CAT_CAMP12').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO13').AsFloat := FieldByName('CAT_CAMP13').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO14').AsFloat := FieldByName('CAT_CAMP14').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO15').AsFloat := FieldByName('CAT_CAMP15').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO16').AsFloat := FieldByName('CAT_CAMP16').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO17').AsFloat := FieldByName('CAT_CAMP17').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO18').AsFloat := FieldByName('CAT_CAMP18').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO19').AsFloat := FieldByName('CAT_CAMP19').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO20').AsFloat := FieldByName('CAT_CAMP20').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO21').AsFloat := FieldByName('CAT_CAMP21').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO22').AsFloat := FieldByName('CAT_CAMP22').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO23').AsFloat := FieldByName('CAT_CAMP23').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO24').AsFloat := FieldByName('CAT_CAMP24').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO25').AsFloat := FieldByName('CAT_CAMP25').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO26').AsFloat := FieldByName('CAT_CAMP26').AsFloat;
      FCdsRelatorio.FieldByName('CAMPO27').AsFloat := FieldByName('CAT_CAMP27').AsFloat;
      FCdsRelatorio.Post;

      Next;
    end;
  end;
end;

end.
