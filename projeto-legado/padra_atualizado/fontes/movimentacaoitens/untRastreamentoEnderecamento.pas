unit untRastreamentoEnderecamento;

interface

uses
  Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants, untZClient, uni, Math,

  untTcdsRastreamentoLote,
  untParametrosRastreamentoEnderecamento;


  type
    TRastreamentoEnderecamento = class
      cdsRastreamentoLote : TCdsRastreamentoLote;
  private
    procedure pAdicionaRegistro(parametros: IParametrosRastreamentoEnderecamento);
  public

    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaRastreamento(parametros : IParametrosRastreamentoEnderecamento);
    procedure pFiltraMOVDET(strAutoincremMOVDET : String);
    procedure pClear;
    procedure pCarregaDados(strAutoincremFATGOR : String);
    procedure pGravaDados;
    procedure pValida(strAutoincremFATGOR: String);

    function fGetQuantidadeInformadaMOVDET(strAutoincremMOVDET: String): integer;
    function fGetQuantidadeRestanteMOVDET(strAutoincremMOVDET: String): integer;
  end;


implementation

{ TRastreamentoEnderecamento }

constructor TRastreamentoEnderecamento.Create;
begin
  inherited;
  cdsRastreamentoLote := TCdsRastreamentoLote.Create(nil);
end;

destructor TRastreamentoEnderecamento.Destroy;
begin
  FreeAndNil(cdsRastreamentoLote);
  inherited;
end;

procedure TRastreamentoEnderecamento.pAdicionaRastreamento(parametros : IParametrosRastreamentoEnderecamento);
begin
  if fEmptyStr(parametros.CodigoFornecedor) then
    raise Exception.CreateHelp('Informe o código do fornecedor.', TParametrosRastreamentoEnderecamento.CODIGO_FORNECEDOR_INDEX);

  if fEmptyStr(parametros.CodigoItem) then
    raise Exception.CreateHelp('Informe o código do produto.', TParametrosRastreamentoEnderecamento.CODIGO_ITEM_INDEX);

  if fEmptyStr(parametros.NumeroLote) then
    raise Exception.CreateHelp('Informe o número do lote.', TParametrosRastreamentoEnderecamento.NUMERO_LOTE_INDEX);

  pAdicionaRegistro(parametros);
  
end;

procedure TRastreamentoEnderecamento.pAdicionaRegistro(parametros : IParametrosRastreamentoEnderecamento);
begin
  cdsRastreamentoLote.Append;
  cdsRastreamentoLote.FieldByName('AUTOINCREM_MOVRAS').AsString := parametros.AutoincremMOVRAS;
  cdsRastreamentoLote.FieldByName('AUTOINCREM_MOVDET').AsString := parametros.AutoincremMOVDET;
  cdsRastreamentoLote.FieldByName('AUTOINCREM_ORDDET').AsString := parametros.AutoincremORDDET;
  cdsRastreamentoLote.FieldByName('AUTOINCREM_LOTRAS').AsString := parametros.AutoincremLOTRAS;
  cdsRastreamentoLote.FieldByName('AUTOINCREM_FATGOR').AsString := parametros.AutoincremFATGOR;
  cdsRastreamentoLote.FieldByName('CODIGO_FORNECEDOR').AsString := parametros.CodigoFornecedor;
  cdsRastreamentoLote.FieldByName('CODIGO_ITEM').AsString := parametros.CodigoItem;
  cdsRastreamentoLote.FieldByName('NUMERO_LOTE').AsString := parametros.NumeroLote;
  cdsRastreamentoLote.FieldByName('QUANTIDADE_ETIQUETAS').AsInteger := parametros.QuantidadeEtiquetas;
  cdsRastreamentoLote.Post;
end;


procedure TRastreamentoEnderecamento.pCarregaDados(strAutoincremFATGOR: String);
var
  qryItens : TUniQuery;
begin
  qryItens := fCriaQuery(nil);
  try    
    qryItens.SQL.Add('SELECT                                                  ');
    qryItens.SQL.Add('  MOVRAS.AUTOINCREM AS AUTOINCREM_MOVRAS,               ');
    qryItens.SQL.Add('  MOVDET.AUTOINCREM AS AUTOINCREM_MOVDET,               ');
    qryItens.SQL.Add('  LOTRAS.AUTOINCREM AS AUTOINCREM_LOTRAS,               ');
    qryItens.SQL.Add('  DET_CODFOR        AS CODIGO_FORNECEDOR,               ');
    qryItens.SQL.Add('  DET_CODITE        AS CODIGO_ITEM,                     ');
    qryItens.SQL.Add('  LOT_NUMLOT        AS NUMERO_LOTE,                     ');
    qryItens.SQL.Add('  MOV_QTDETI        AS QUANTIDADE_ETIQUETAS             ');
    qryItens.SQL.Add('FROM                                                    ');
    qryItens.SQL.Add('  FATGOR                                                ');
    qryItens.SQL.Add('  INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM   ');
    qryItens.SQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM   ');
    qryItens.SQL.Add('  INNER JOIN MOVDET ON MOVDET.AUTOINCREM = FDO_AUTDET   ');
    qryItens.SQL.Add('  INNER JOIN MOVRAS ON MOV_SEQDET = FDO_AUTDET          ');
    qryItens.SQL.Add('  INNER JOIN LOTRAS ON LOTRAS.AUTOINCREM = MOV_SEQLOT   ');    
    qryItens.SQL.Add('WHERE                                                   ');
    qryItens.SQL.Add('  FATGOR.AUTOINCREM = ' + QuotedStr(strAutoincremFATGOR) );
    qryItens.Open;

    cdsRastreamentoLote.EmptyDataSet;
    qryItens.First;
    while not qryItens.eof do
    begin
      pAdicionaRegistro(TParametrosRastreamentoEnderecamento.New()
                          .AutoincremMOVRAS(qryItens.FieldByName('AUTOINCREM_MOVRAS').AsString)
                          .AutoincremMOVDET(qryItens.FieldByName('AUTOINCREM_MOVDET').AsString)
                          .AutoincremLOTRAS(qryItens.FieldByName('AUTOINCREM_LOTRAS').AsString)
                          .AutoincremFATGOR(strAutoincremFATGOR)
                          .CodigoFornecedor(qryItens.FieldByName('CODIGO_FORNECEDOR').AsString)
                          .CodigoItem(qryItens.FieldByName('CODIGO_ITEM').AsString)
                          .NumeroLote(qryItens.FieldByName('NUMERO_LOTE').AsString)
                          .QuantidadeEtiquetas(qryItens.FieldByName('QUANTIDADE_ETIQUETAS').AsInteger));
      qryItens.Next;
    end;

  finally
    FreeAndNil(qryItens);
  end;
end;

procedure TRastreamentoEnderecamento.pValida(strAutoincremFATGOR: String);
var
  qryItens : TUniQuery;
begin
  cdsRastreamentoLote.pSetBackupFilter;
  qryItens := fCriaQuery(nil);
  try
    cdsRastreamentoLote.DisableControls;
    cdsRastreamentoLote.Filtered := False;
    
    qryItens.SQL.Add('SELECT                                                  ');
    qryItens.SQL.Add('  FDO_AUTDET,                                           ');
    qryItens.SQL.Add('  FDO_QTDITE                                            ');
    qryItens.SQL.Add('FROM                                                    ');
    qryItens.SQL.Add('  FATGOR                                                ');
    qryItens.SQL.Add('  INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM   ');
    qryItens.SQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM   ');
    qryItens.SQL.Add('WHERE                                                   ');
    qryItens.SQL.Add('  FATGOR.AUTOINCREM = ' + QuotedStr(strAutoincremFATGOR) );
    qryItens.Open;

    qryItens.First;
    while not qryItens.eof do
    begin
      if not cdsRastreamentoLote.Locate('AUTOINCREM_MOVDET',  qryItens.FieldByName('FDO_AUTDET').AsString, []) then
        raise Exception.Create('É necessário informar ao menos um lote de rastreamento para cada item!');
          
      qryItens.Next;
    end;

  finally
    cdsRastreamentoLote.pVoltaBackupFilter;
    cdsRastreamentoLote.First;
    cdsRastreamentoLote.EnableControls;
    FreeAndNil(qryItens);
  end;
end;

procedure TRastreamentoEnderecamento.pClear;
begin
  cdsRastreamentoLote.EmptyDataSet;
  cdsRastreamentoLote.Filter := '';
  cdsRastreamentoLote.Filtered := False;
end;

function TRastreamentoEnderecamento.fGetQuantidadeInformadaMOVDET(strAutoincremMOVDET : String) : integer;
begin
  cdsRastreamentoLote.pSetBackupFilter;
  try
    cdsRastreamentoLote.DisableControls;
    pFiltraMOVDET(strAutoincremMOVDET);

    result := 0;
    cdsRastreamentoLote.first;
    while not cdsRastreamentoLote.Eof do
    begin
      result := result + cdsRastreamentoLote.FieldByName('QUANTIDADE_ETIQUETAS').AsInteger;
      cdsRastreamentoLote.Next;
    end;

  finally
    cdsRastreamentoLote.pVoltaBackupFilter;
    cdsRastreamentoLote.first;
    cdsRastreamentoLote.EnableControls;
  end;
end;

procedure TRastreamentoEnderecamento.pGravaDados;
var
  qryLOTRAS : TUniQuery;
  qryMOVRAS : TUniQuery;
  blnTransacaoExterna : boolean;
begin
  qryLOTRAS := fCriaQuery(nil);
  qryMOVRAS := fCriaQuery(nil);  
  try   
    blnTransacaoExterna := qryLOTRAS.Connection.InTransaction;

    qryLOTRAS.SQL.Add('SELECT                     ');
    qryLOTRAS.SQL.Add('  *                        ');
    qryLOTRAS.SQL.Add('FROM                       ');
    qryLOTRAS.SQL.Add('  LOTRAS                   ');
    qryLOTRAS.SQL.Add('WHERE LOT_NUMLOT = :NUMLOT ');
    qryLOTRAS.SQL.Add('  AND LOT_CODITE = :CODITE ');
    qryLOTRAS.SQL.Add('  AND LOT_CODFOR = :CODFOR ');
    
    qryMOVRAS.SQL.Add('SELECT                     ');
    qryMOVRAS.SQL.Add('  *                        ');
    qryMOVRAS.SQL.Add('FROM                       ');
    qryMOVRAS.SQL.Add('  MOVRAS                   ');
    qryMOVRAS.SQL.Add('WHERE MOV_SEQLOT = :SEQLOT ');
    qryMOVRAS.SQL.Add('  AND MOV_SEQDET = :SEQDET ');
    
    if not blnTransacaoExterna then
      fStartTransaction();

    cdsRastreamentoLote.pSetBackupFilter;
    try
      cdsRastreamentoLote.DisableControls;
      cdsRastreamentoLote.Filtered := False;
      try
        cdsRastreamentoLote.first;
        while not cdsRastreamentoLote.Eof do
        begin

          qryLOTRAS.Close;
          qryLOTRAS.ParamByName('NUMLOT').AsString := cdsRastreamentoLote.FieldByName('NUMERO_LOTE').AsString;
          qryLOTRAS.ParamByName('CODITE').AsString := cdsRastreamentoLote.FieldByName('CODIGO_ITEM').AsString;
          qryLOTRAS.ParamByName('CODFOR').AsString := cdsRastreamentoLote.FieldByName('CODIGO_FORNECEDOR').AsString;
          qryLOTRAS.Open;

          if qryLOTRAS.isEmpty then
          begin
            qryLOTRAS.Append;
            qryLOTRAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTRAS', VS_strCodEmp);
            qryLOTRAS.FieldByName('LOT_NUMLOT').AsString := cdsRastreamentoLote.FieldByName('NUMERO_LOTE').AsString;
            qryLOTRAS.FieldByName('LOT_CODITE').AsString := cdsRastreamentoLote.FieldByName('CODIGO_ITEM').AsString;
            qryLOTRAS.FieldByName('LOT_CODFOR').AsString := cdsRastreamentoLote.FieldByName('CODIGO_FORNECEDOR').AsString;
            qryLOTRAS.Post;
          end;

          qryMOVRAS.Close;
          qryMOVRAS.ParamByName('SEQLOT').AsString := cdsRastreamentoLote.FieldByName('AUTOINCREM_LOTRAS').AsString;
          qryMOVRAS.ParamByName('SEQDET').AsString := cdsRastreamentoLote.FieldByName('AUTOINCREM_MOVDET').AsString;
          qryMOVRAS.Open;

          if qryMOVRAS.isEmpty then
          begin
            qryMOVRAS.Append;
            qryMOVRAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVRAS', VS_strCodEmp);
            qryMOVRAS.FieldByName('MOV_SEQLOT').AsString := qryLOTRAS.FieldByName('AUTOINCREM').AsString;
            qryMOVRAS.FieldByName('MOV_SEQDET').AsString := cdsRastreamentoLote.FieldByName('AUTOINCREM_MOVDET').AsString;
            qryMOVRAS.FieldByName('MOV_SEQEND').AsString := cdsRastreamentoLote.FieldByName('AUTOINCREM_FATGOR').AsString;
          end
          else
            qryMOVRAS.Edit;

          qryMOVRAS.FieldByName('MOV_QTDETI').AsInteger  := cdsRastreamentoLote.FieldByName('QUANTIDADE_ETIQUETAS').AsInteger;
          qryMOVRAS.Post;

          cdsRastreamentoLote.Next;
        end;

        if not blnTransacaoExterna then
          fCommit();

        pClear;
        
      except
    
        if not blnTransacaoExterna then
          fRollBack();
        raise;

      end;
    finally
      cdsRastreamentoLote.pVoltaBackupFilter;
      cdsRastreamentoLote.EnableControls;
    end;
  finally
    FreeAndNil(qryLOTRAS);
    FreeAndNil(qryMOVRAS);
  end;
end;

function TRastreamentoEnderecamento.fGetQuantidadeRestanteMOVDET(strAutoincremMOVDET : String) : integer;
var
  qryMOVDET : TUniQuery;
begin
  Result := 0;
  qryMOVDET := fCriaQuery(nil);
  try
    qryMOVDET.SQL.Add('SELECT                                                                      ');
    qryMOVDET.SQL.Add('  CEIL(DET_QTDITE / IF(IFNULL(TRI_EMBALA ,0) = 0, 1, TRI_EMBALA)) AS QTDITE ');
    qryMOVDET.SQL.Add('FROM                                                                        ');
    qryMOVDET.SQL.Add('  MOVDET                                                                    ');
    qryMOVDET.SQL.Add('  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM                ');
    qryMOVDET.SQL.Add('WHERE MOVDET.AUTOINCREM = ' + QuotedStr(strAutoincremMOVDET)                 );
    qryMOVDET.Open;

    if not qryMOVDET.IsEmpty then
      Result := qryMOVDET.FieldByName('QTDITE').AsInteger - fGetQuantidadeInformadaMOVDET(strAutoincremMOVDET);

  finally
    FreeAndNil(qryMOVDET);
  end;
end;

procedure TRastreamentoEnderecamento.pFiltraMOVDET(strAutoincremMOVDET: String);
begin
  cdsRastreamentoLote.Filtered := False;
  cdsRastreamentoLote.Filter := 'AUTOINCREM_MOVDET = ' + QuotedStr(strAutoincremMOVDET);
  cdsRastreamentoLote.Filtered := True;
end;

end.
