unit untTDuplicataAgrupamento;

interface

type

  tpAgrupamento = (tpAgrupamentoContaPagar, tpAgrupamentoContaReceber);

  TDuplicataAgrupamentoFiltro = class
  private
    FTipoAgrupamento : tpAgrupamento;
    FCodigoCliente   : String;
    FCodigoFornecedor: String;
    FDuplicata       : String;
    FParcela         : String;
    FCodigoEmpresa   : String;
    FEspecieDocumento: String;
    FSerie_          : String;
  Public
    property CodigoCliente   : String        read FCodigoCliente    write FCodigoCliente   ;
    property CodigoFornecedor: String        read FCodigoFornecedor write FCodigoFornecedor;
    property Duplicata       : String        read FDuplicata        write FDuplicata       ;
    property Parcela         : String        read FParcela          write FParcela         ;
    property CodigoEmpresa   : String        read FCodigoEmpresa    write FCodigoEmpresa   ;
    property EspecieDocumento: String        read FEspecieDocumento write FEspecieDocumento;
    property Serie_          : String        read FSerie_           write FSerie_          ;
    property TipoAgrupamento : tpAgrupamento read FTipoAgrupamento;
    Constructor Create(ATipoAgrupamento : tpAgrupamento);
    procedure pLimparFiltros;
  End;

  TDuplicataAgrupamentoBuilder = class
  public
    class function fgetDuplicataPresenteEmAgrupamento(ADuplicataAgrupamentoFiltro : TDuplicataAgrupamentoFiltro;
      var ANumeroAgrupamento : String) : Boolean; // Aurelius

    class function DuplicataPresenteEmAgrupamento(ADuplicataAgrupamentoFiltro : TDuplicataAgrupamentoFiltro;
      var ANumeroAgrupamento : String) : Boolean; //Unidac

  end;

implementation

uses System.SysUtils, untTDupAgpRepository, untTDupAgrRepository, untFuncoesSimples,
     untTDupAgp, untTDupAgr, System.Generics.Collections, Uni;

{ TDuplicataAgrupamentoFiltro }

constructor TDuplicataAgrupamentoFiltro.Create(ATipoAgrupamento : tpAgrupamento);
begin
  FTipoAgrupamento := ATipoAgrupamento;
  pLimparFiltros
end;

procedure TDuplicataAgrupamentoFiltro.pLimparFiltros;
begin
  CodigoCliente    := '';
  CodigoFornecedor := '';
  Duplicata        := '';
  Parcela          := '';
  CodigoEmpresa    := '';
  EspecieDocumento := '';
  Serie_           := '';
end;

{ TDuplicataAgrupamentoBuilder }

class function TDuplicataAgrupamentoBuilder.DuplicataPresenteEmAgrupamento(ADuplicataAgrupamentoFiltro: TDuplicataAgrupamentoFiltro;
                                                                       Var ANumeroAgrupamento: String): Boolean;
  Var
    strSQL   : String;
    qryGenPag: TUniQuery;

begin
  Result := False;
  Try
    qryGenPag := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTP_NUMAGR  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DUPAGP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If (fEmptyStr(ADuplicataAgrupamentoFiltro.Serie_)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ ';

    Try
      qryGenPag.Close;
      qryGenPag.SQL.Clear;
      qryGenPag.SQL.Add(strSQL);
      qryGenPag.ParamByName('NUMDUP').AsString := ADuplicataAgrupamentoFiltro.Duplicata;
      qryGenPag.ParamByName('PARCEL').AsString := ADuplicataAgrupamentoFiltro.Parcela;
      qryGenPag.ParamByName('CODEMP').AsString := ADuplicataAgrupamentoFiltro.CodigoEmpresa;
      qryGenPag.ParamByName('CODFOR').AsString := ADuplicataAgrupamentoFiltro.CodigoFornecedor;

      If (Not fEmptyStr(ADuplicataAgrupamentoFiltro.Serie_)) Then
        qryGenPag.ParamByName('SERIE_').AsString := ADuplicataAgrupamentoFiltro.Serie_;

      qryGenPag.Open;
      Result := Not qryGenPag.IsEmpty;
      ANumeroAgrupamento := qryGenPag.FieldByName('CTP_NUMAGR').AsString;
      qryGenPag.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TDuplicataAgrupamentoBuilder.DuplicataPresenteEmAgrupamento');
      End;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;

end;

class function TDuplicataAgrupamentoBuilder.fgetDuplicataPresenteEmAgrupamento(ADuplicataAgrupamentoFiltro: TDuplicataAgrupamentoFiltro;
  var ANumeroAgrupamento : String): Boolean;
var SDupAgrRepository     : TDupAgrRepository;
    SDupAgpRepository     : TDupAgpRepository;
    SDuplicataPagarList   : TList<TDupAgp>;
    SDuplicataReceberList : TList<TDupAgr>;
begin
  Result                 := False;
  ANumeroAgrupamento     := '';
  SDuplicataPagarList    := nil;
  SDuplicataReceberList  := nil;

  SDupAgpRepository := TDupAgpRepository.Create;
  SDupAgrRepository := TDupAgrRepository.Create;
  try
    if ADuplicataAgrupamentoFiltro.TipoAgrupamento = tpAgrupamentoContaPagar then
      begin
        SDuplicataPagarList := SDupAgpRepository.fGetDuplicatasAgrupadasPagar(ADuplicataAgrupamentoFiltro.Duplicata,
                                                                   ADuplicataAgrupamentoFiltro.CodigoFornecedor,
                                                                   ADuplicataAgrupamentoFiltro.Parcela,
                                                                   ADuplicataAgrupamentoFiltro.CodigoEmpresa,
                                                                   ADuplicataAgrupamentoFiltro.Serie_);

      end
    else
      begin
        SDuplicataReceberList := SDupAgrRepository.fGetDuplicatasAgrupadasReceber(ADuplicataAgrupamentoFiltro.Duplicata,
                                                                     ADuplicataAgrupamentoFiltro.CodigoCliente,
                                                                     ADuplicataAgrupamentoFiltro.Parcela,
                                                                     ADuplicataAgrupamentoFiltro.CodigoEmpresa,
                                                                     ADuplicataAgrupamentoFiltro.EspecieDocumento);
      end;

    if (Assigned(SDuplicataPagarList) and (SDuplicataPagarList.Count <> 0)) or
       (Assigned(SDuplicataReceberList) and (SDuplicataReceberList.Count <> 0))then
      begin
        Result := True;
        if ADuplicataAgrupamentoFiltro.TipoAgrupamento = tpAgrupamentoContaPagar then
          ANumeroAgrupamento := SDuplicataPagarList.Items[0].NumeroAgrupamento
        else
          ANumeroAgrupamento := SDuplicataReceberList.Items[0].NumeroAgrupamento;
      end;

  finally
    FreeAndNil(SDupAgpRepository);
    FreeAndNil(SDupAgrRepository);
  end;
end;

end.
