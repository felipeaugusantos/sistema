unit untConsulta;

interface

Uses System.Classes, System.StrUtils, Uni,
  untFuncoes, UniClientDataSet, UniDataSetProvider,
  System.SysUtils,
  untModulo, untClasseIcmsSt,
  {untClasseDifal,} untClasseCfop,
  untClasseFcp,
  untClasseIcmsOrgaoPublico,
  untClasseIPI, untClasseIcmsEfetivo, untClasseSTCustoAquisicao,
  untClassePrecoCusto, untClasseMargemVenda;

  Type
    TConsulta = class
      Public
        Constructor Create(AOpcao : String; ADataInicial, ADataFinal: TDate);

        function fRetornarDados : OleVariant;
      Private
        LOpcao       : String;
        LDataInicial : TDate;
        LDataFinal   : TDate;

        function fRetornarSQL : String;
    end;


implementation


{ TConsulta }

constructor TConsulta.Create(AOpcao: String; ADataInicial, ADataFinal: TDate);
begin
  LOpcao       := AOpcao;
  LDataInicial := ADataInicial;
  LDataFinal   := ADataFinal;
end;

function TConsulta.fRetornarDados : OleVariant;
var
  LQuery: TUniQuery;
  LProvider: TUniDataSetProvider;
  LClient: TUniClientDataSet;
begin
  LQuery    := fCriaQuery(Nil);
  LProvider := TUniDataSetProvider.Create(Nil);
  LClient   := TUniClientDataSet.Create(Nil);

  try
    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Text := fRetornarSQL + ' ' + fRetornarLimiteRegistros;

    LQuery.ParamByName('CODEMP').AsString := frmModulo.FCodEmp;
    LQuery.ParamByName('DTAINI').AsString := FormatDateTime('yyyymmdd', LDataInicial);
    LQuery.ParamByName('DTAFIM').AsString := FormatDateTime('yyyymmdd', LDataFinal);

    LProvider.DataSet := LQuery;
    LClient.SetProvider(LProvider);
    LClient.Open;

    frmModulo.FDataInicio                     := Date;
    frmModulo.FHoraInicio                     := Now;
    frmModulo.FPeriodoInicial                 := LDataInicial;
    frmModulo.FPeriodoFinal                   := LDataFinal;
    frmModulo.Registros(LClient.RecordCount);
    frmModulo.RegistrosProcessados(0);
    frmModulo.RegistrosProcessadosAcerto(0);
    frmModulo.RegistrosProcessadosErro(0);
    frmModulo.RegistrosProcessadosIgnorados(0);
    frmModulo.RegistrosProcessadosDuplicados(0);
    result := LClient.Data;
  finally
    FreeAndNil(LQuery);
    FreeAndNil(LProvider);
    FreeAndNil(LClient);
  end;
end;

function TConsulta.fRetornarSQL: String;
begin
  Case RetonarIndexOpcoesSelecionadas(LOpcao)of
    0: Result := TConsultaIPI.New.fRetornarSQLIpi;
    1: Result := TConsultaIcms.New.fRetornarSQLIcms;
    2: Result := TConsultaIcmsEfetivo.New.fRetornarSQLIcmsEfetivo;
    3: Result := TConsultaFcp.New.fRetornarSQLFcp;
    4: Result := TConsultaCfop.New.fRetornarSQLCfop;
    5: Result := TConsultaPrecoCusto.New.fRetornarSQLPrecoCusto;
    6: Result := TConsultaMargemVenda.New.fRetornarSQLMargemVenda;
  end
end;

end.

