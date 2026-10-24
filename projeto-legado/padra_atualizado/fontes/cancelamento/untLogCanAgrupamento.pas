unit untLogCanAgrupamento;

interface

uses
  UniClientDataSet, untDtoLogCan, System.Classes;

type
  TFiltroLogCanAgrupamento = reference to function(ADataSet: TUniClientDataSet; const APendencia: TDtoLogCan): String;

  TLogCanAgrupamento = class
  public
    class function VerificarPendencias(ADataSet: TUniClientDataSet; AFiltro: TFiltroLogCanAgrupamento; const ATipoFC: String = ''): TStringList;
  end;

implementation

uses
  SysUtils, System.Generics.Collections, untLogCanRepository, untConnection,
  untUnidac, untLogCancelamento;

class function TLogCanAgrupamento.VerificarPendencias(ADataSet: TUniClientDataSet; AFiltro: TFiltroLogCanAgrupamento; const ATipoFC: String = ''): TStringList;
  Var
    objConnection : IConnection;
    objLogCanRepository : TLogCanRepository;
    objListaPendencias : TList<TDtoLogCan>;
    objPendencia : TDtoLogCan;
    cdsAux : TUniClientDataSet;
    strDescricao : String;
    objLogCancelamento : TLogCancelamento;
Begin
  Result := TStringList.Create;
  cdsAux := TUniClientDataSet.Create(nil);
  objLogCancelamento := TLogCancelamento.Create;
  Try
    cdsAux.Data := ADataSet.Data;
    objConnection := TUnidacConnection.Create;
    objLogCanRepository := TLogCanRepository.Create(objConnection);
    Try
      objListaPendencias := objLogCanRepository.PendenciasDeCancelamento(EmptyStr, True, ATipoFC);
      Try
        For objPendencia in objListaPendencias Do
        Begin
          strDescricao := AFiltro(cdsAux, objPendencia);
          If strDescricao <> '' Then
          Begin
            If (Not objLogCancelamento.ValidouIntegridadeDocumentos(objPendencia.strAutInc, '', objPendencia.strCodEmp)) Then
              Result.Add(strDescricao);
          End;
        End;
      Finally
        FreeAndNil(objListaPendencias);
      End;
    Finally
      FreeAndNil(objLogCanRepository);
    End;
  Finally
    FreeAndNil(cdsAux);
    FreeAndNil(objLogCancelamento);
  End;
End;

end.
