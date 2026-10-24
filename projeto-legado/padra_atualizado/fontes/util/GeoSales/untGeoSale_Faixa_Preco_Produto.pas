unit untGeoSale_Faixa_Preco_Produto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Faixa_Preco_Produto = Class(TGeoSale_Base)
  Private
    FPreMax: Double;
    FTabPre: String;
    FPreMin: Double;
    FQtdMin: Double;
    FPreVen: Double;
    FTraDes: String;

    qryAux : TUniQuery;

    function GetPreMax: Double;
    procedure SetPreMin(Value: Double);
    function GetQtdMin: Double;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
    constructor Create(strNomDir : String; strEmpresas : String);Override;
    destructor Destroy; override;
  Published

    [TCampoString]
    [TNomeCampo('SEQUEN')]
    Property CD_SEQUENCIAL     : String Read FTabPre   Write FTabPre;

    [TCampoDouble]
    Property QT_MIN_FAIXA      : Double  Read GetQtdMin Write FQtdMin;

    [TCampoDouble]
    [TNomeCampo('PREVEN')]
    Property VR_PRECO_MINIMO   : Double  Read FPreMin   Write SetPreMin;

    [TCampoDouble]
    [TNomeCampo('PREVEN')]
    Property VR_PRECO_SUGERIDO : Double  Read FPreVen   Write FPreVen;

    [TCampoDouble]
    Property VR_PRECO_MAXIMO   : Double  Read GetPreMax Write FPreMax;

  End;

implementation

{ TGeoSale_Faixa_Preco_Produto }

uses untFuncoesSimples;

constructor TGeoSale_Faixa_Preco_Produto.Create(strNomDir: String; strEmpresas : String);
begin
  inherited Create(strNomDir, strEmpresas);

  FTraDes := VS_strTRADES;
  qryAux  := fCriaQuery(Nil);

end;

destructor TGeoSale_Faixa_Preco_Produto.Destroy;
begin
  FreeAndNil(qryAux);
end;

function TGeoSale_Faixa_Preco_Produto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Faixa_Preco_Produto.TXT';
end;

function TGeoSale_Faixa_Preco_Produto.fGetSql: String;
  Var
    intIndex : Integer;
begin
  Result := '';

  For intIndex := 1 To 7 Do
  Begin
    Result := Result + ' SELECT SQL_NO_CACHE                                        ';
    Result := Result + 'CONCAT('+ intToStr(intIndex) + ', ITE_CODITE, ITE_CODEMP) AS SEQUEN, ';
    Result := Result + ' ITE_PREVE' + intToStr(intIndex) + ' AS PREVEN,             ';
    Result := Result + ' ITE_PREVE1,                                                ';
    Result := Result + ' ITE_PREVE2,                                                ';
    Result := Result + ' ITE_PREVE3,                                                ';
    Result := Result + ' ITE_PREVE4,                                                ';
    Result := Result + ' ITE_PREVE5,                                                ';
    Result := Result + ' ITE_PREVE6,                                                ';
    Result := Result + ' ITE_PREVE7,                                                ';
    Result := Result + ' ITE_PRECUS,                                                ';
    Result := Result + ' ITE_PRECUR,                                                ';
    Result := Result + ' ITE_MARMIN,                                                ';
    Result := Result + ' ITE_DESMAX                                                 ';
    Result := Result + ' FROM ITEGER                                                ';
    Result := Result + ' INNER JOIN CFGSIS ON ITE_CODEMP = SIS_CODEMP               ';
    Result := Result + ' WHERE SIS_CODCFG = "CFG_TABPRC"                            ';
    Result := Result + '   AND LOCATE(SIS_CODEMP,"' + FEmpresas + '") > 0           ';
    Result := Result + '   AND MID(SIS_VALCFG, ' + intToStr(intIndex) + ', 1) = "S" ';

    if intIndex < 7 Then
      Result := Result + ' UNION ALL ';
  End;

end;

function TGeoSale_Faixa_Preco_Produto.GetPreMax: Double;
begin
  Result := 9999999.99;
end;

function TGeoSale_Faixa_Preco_Produto.GetQtdMin: Double;
begin
  Result := 0;
end;

procedure TGeoSale_Faixa_Preco_Produto.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

procedure TGeoSale_Faixa_Preco_Produto.SetPreMin(Value: Double);
  Var
    strCodIte,
    strTabPre : String;
    fltTraFat,
    fltPreTra : Double;

    function fDescontoMaximoItem: Double;
    begin
      If Not fCfgSis('ITETBP', VarBoolean) Then
        Result := qryDados.FieldByName('ITE_DESMAX').AsFloat
      Else
        Result := fCampoTabela('ITE_DESMAX',
                               'ITETBP',
                              ['ITE_CODITE', 'ITE_CODEMP', 'ITE_TABPRE'],
                              [strCodIte, VS_strCodEmp, strTabPre]);
    End;

    function fRetornaVrDesconto(fltValUni, fltDesCon: Double): Double;
    Begin
      Result := fltDesCon;

      If (fCfgSis('TIPDES') = '%') Then
        Result := fFormataFloat((fltValUni * fltDesCon) / 100, 04);
    End;

begin
  fltPreTra    := 0.00;

  If (FTraDes = '1') Then
  Begin

    strTabPre := Copy( FTabPre, 1, 1);
    strCodIte := Copy( FTabPre, 2, fTamCodIte);

    Value := qryDados.FieldByName('ITE_PRE' + fCfgSis('CAMTB' + strTabPre)).AsFloat;

    If (strToInt(strTabPre) = 1) Then
      fltTraFat := fCfgSis('TRAFAT', varDouble)
    Else
      fltTraFat := fCfgSis('TRAFA' + strTabPre, varDouble);

    fltPreTra := Value * fltTraFat;

  End
  Else If (FTraDes = '2') Then
  Begin

    fltPreTra := Value - fRetornaVrDesconto(Value, fDescontoMaximoItem);

  End

  Else If (FTraDes = '3') Then
  Begin
    fltPreTra := fCalculaPrecoVenda(1, qryDados.FieldByName('ITE_PRECUS').AsFloat,
                                       0,
                                       qryDados.FieldByName('ITE_MARMIN').AsFloat,
                                       0,
                                       0,
                                       0,
                                       0)
  End

  Else If (FTraDes = '4') Then
  Begin
    fltPreTra := Value;
  End;


  FPreMin := fltPreTra;
end;

end.
