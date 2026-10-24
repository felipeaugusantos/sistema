unit untTDadosRegistraLogCat42;

interface

uses Dialogs,
     Uni,
     untFuncoes,
     untTDadosLogCat42,
     System.Generics.Collections,
     System.SysUtils,
     System.Classes;

type
  TDadosRegistraLogCat42 = class
  private

    procedure pCriaTabelaLog;
    procedure pCriaTabelaCatLog(strNomeTabela: string);

    procedure pInserirTabela(strNomeTabela: string; dadosRegistraLogCat42: TDadosLogCat42);
    function fRetornaAutoIncrem(strNomeTabela: string): Integer;

  protected

  public

    procedure pRegistraLogCat42(lstDadosRegistraLogCat42: TObjectList<TDadosLogCat42>);
    procedure pRegistraLogCat42PeriodoDeletado(strMesano, strEmpresa: string);
    procedure pRegistraLogCat42PeriodoGeradoAq(strMesano, strEmpresa: string);

  end;

implementation


{ TuntTDadosLogCat42 }

procedure TDadosRegistraLogCat42.pCriaTabelaLog;
begin
  pCriaTabelaCatLog('CAT_42_HLG');
end;

procedure TDadosRegistraLogCat42.pInserirTabela(strNomeTabela: string; dadosRegistraLogCat42: TDadosLogCat42);
  var
    qryAux: TUniQuery;
begin
  qryAux:= fCriaQuery;
  try
    if strNomeTabela = 'CAT_42_HLG' then
    begin
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' INSERT INTO CAT_42_HLG ( HLG_CODEMP, HLG_USPROC, HLG_DTPROC, HLG_DTINIC, HLG_DTFINA, HLG_HRINIC, HLG_HRFINA, HLG_ORIGEM, HLG_MESANO )'
                  + '                 VALUES ( :HLG_CODEMP, :HLG_USPROC, :HLG_DTPROC, :HLG_DTINIC, :HLG_DTFINA, :HLG_HRINIC, :HLG_HRFINA, :HLG_ORIGEM, :HLG_MESANO )';

        ParamByName('HLG_CODEMP').AsString := dadosRegistraLogCat42.strEmpresaProcessamento;
        ParamByName('HLG_USPROC').AsString := dadosRegistraLogCat42.strUsuarioProcessamento;
        ParamByName('HLG_DTPROC').AsDate := dadosRegistraLogCat42.dteDataProcessamento;
        ParamByName('HLG_DTINIC').AsDate := dadosRegistraLogCat42.dteDataInicial;
        ParamByName('HLG_DTFINA').AsDate := dadosRegistraLogCat42.dteDataFinal;
        ParamByName('HLG_HRINIC').AsTime := dadosRegistraLogCat42.tmeHoraInicial;
        ParamByName('HLG_HRFINA').AsTime := dadosRegistraLogCat42.tmeHoraFinal;
        ParamByName('HLG_ORIGEM').AsString := dadosRegistraLogCat42.strOrigem;
        ParamByName('HLG_MESANO').AsString := FormatDateTime('MM/YYYY', dadosRegistraLogCat42.dteDataInicial);

        try
          ExecSQL;
        except
        end;
      end;
    end;

    if strNomeTabela = 'CAT_42_DLG' then
    begin
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' INSERT INTO CAT_42_DLG ( DLG_HLGAIN, DLG_SEQUEN, DLG_DESCRI, DLG_VALORA )'
                      + '             VALUES ( :DLG_HLGAIN, :DLG_SEQUEN, :DLG_DESCRI, :DLG_VALORA )';

        ParamByName('DLG_HLGAIN').AsInteger := fRetornaAutoIncrem('CAT_42_HLG');
        ParamByName('DLG_SEQUEN').AsInteger := dadosRegistraLogCat42.intOrder;
        ParamByName('DLG_DESCRI').AsString := dadosRegistraLogCat42.strDescr;
        ParamByName('DLG_VALORA').AsString := dadosRegistraLogCat42.strValor;

        try
          ExecSQL;
        except
        end;
      end;
    end;

  finally
    qryAux.Free;
  end;

end;

function TDadosRegistraLogCat42.fRetornaAutoIncrem(strNomeTabela: string): Integer;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      //Header
      Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(AUTOINCREM) AUTOINCREM  ');
      SQL.Add('  FROM ' + strNomeTabela );
      Open;
      Result:= FieldByName('AUTOINCREM').AsInteger;
     end;
  finally
    qryAux.Free;
  end;
end;

procedure TDadosRegistraLogCat42.pCriaTabelaCatLog(strNomeTabela: string);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      //Header
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS ' + strNomeTabela + '(');
      SQL.Add('  AUTOINCREM INT (40) NOT NULL AUTO_INCREMENT,');
      SQL.Add('  HLG_CODEMP CHAR(3) NOT NULL, ');
      SQL.Add('  HLG_USPROC VARCHAR(30) NOT NULL, ');
      SQL.Add('  HLG_DTPROC DATE NOT NULL, ');
      SQL.Add('  HLG_DTINIC DATE NOT NULL, ');
      SQL.Add('  HLG_DTFINA DATE NOT NULL, ');
      SQL.Add('  HLG_HRINIC TIME NOT NULL, ');
      SQL.Add('  HLG_HRFINA TIME NOT NULL, ');
      SQL.Add('  HLG_ORIGEM VARCHAR(100) NOT NULL, ');
      SQL.Add('  HLG_MESANO VARCHAR(7) NOT NULL, ');
      SQL.Add('  HLG_GERADO VARCHAR(1) DEFAULT NULL, ');
      SQL.Add('  HLG_USGERA VARCHAR(30) DEFAULT NULL, ');
      SQL.Add('  HLG_DTGERA DATE DEFAULT NULL, ');
      SQL.Add('  HLG_HRGERA TIME DEFAULT NULL, ');
      SQL.Add('  HLG_DELETA VARCHAR(1) DEFAULT NULL, ');
      SQL.Add('  HLG_USDELE VARCHAR(30) DEFAULT NULL, ');
      SQL.Add('  HLG_DTDELE DATE DEFAULT NULL, ');
      SQL.Add('  HLG_HRDELE TIME DEFAULT NULL, ');
      SQL.Add('  PRIMARY KEY (AUTOINCREM),');
      SQL.Add('  KEY FK_CAT42_HLG (AUTOINCREM, HLG_CODEMP)');
      SQL.Add(') ENGINE = INNODB AUTO_INCREMENT = 0 DEFAULT CHARSET = latin1;');
      ExecSQL;

      //Detail
      Close;
      SQL.Clear;
      strNomeTabela:= 'CAT_42_DLG';
      SQL.Add('CREATE TABLE IF NOT EXISTS ' + strNomeTabela + '(');
      SQL.Add('  AUTOINCREM INT (40) NOT NULL AUTO_INCREMENT,');
      SQL.Add('  DLG_HLGAIN INT(40) NOT NULL, ');
      SQL.Add('  DLG_SEQUEN INT(40) NOT NULL, ');
      SQL.Add('  DLG_DESCRI VARCHAR(200) NOT NULL, ');
      SQL.Add('  DLG_VALORA VARCHAR(1000) NOT NULL, ');
      SQL.Add('  PRIMARY KEY (AUTOINCREM, DLG_HLGAIN),');
      SQL.Add('  KEY FK_CAT_42_DLG (AUTOINCREM, DLG_HLGAIN)');
      SQL.Add(') ENGINE = INNODB AUTO_INCREMENT = 0 DEFAULT CHARSET = latin1;');
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TDadosRegistraLogCat42.pRegistraLogCat42(lstDadosRegistraLogCat42: TObjectList<TDadosLogCat42>);
  var
    blnInserir: Boolean;
    dadosRegistraLogCat42: TDadosLogCat42;
begin
  blnInserir:= True;
  dadosRegistraLogCat42:= TDadosLogCat42.Create;
  try
    pCriaTabelaLog;
    for dadosRegistraLogCat42 in lstDadosRegistraLogCat42 do
    begin
      if blnInserir then
      begin
        pInserirTabela('CAT_42_HLG', dadosRegistraLogCat42);
        blnInserir:= False;
      end;
      pInserirTabela('CAT_42_DLG', dadosRegistraLogCat42);
    end;
  finally
    dadosRegistraLogCat42.Free;
  end;
end;

procedure TDadosRegistraLogCat42.pRegistraLogCat42PeriodoDeletado(strMesano, strEmpresa: string);
  var
    intAutoIncrem: Integer;
    qryAux: TUniQuery;
begin

  if not fTabelaExiste('CAT_42_HLG') then
    Exit;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add( '     MAX(AUTOINCREM) AUTOINCREM ');
      SQL.Add( '   FROM ');
      SQL.Add( '     CAT_42_HLG ');
      SQL.Add( '   WHERE HLG_CODEMP = :CODEMP ');
      SQL.Add( '     AND HLG_MESANO = :MESANO ');
      ParamByName('CODEMP').AsString := strEmpresa;
      ParamByName('MESANO').AsString := strMesAno;
      Open;

      if FieldByName('AUTOINCREM').AsInteger = 0 then
        intAutoIncrem:= -1
      else
        intAutoIncrem:= FieldByName('AUTOINCREM').AsInteger;

      Close;
      SQL.Clear;
      SQL.Add( ' UPDATE ');
      SQL.Add( '   CAT_42_HLG ');
      SQL.Add( ' SET ');
      SQL.Add( '   HLG_DELETA = "S" ');
      SQL.Add( '   , HLG_USDELE = :HLG_USDELE ' );
      SQL.Add( '   , HLG_DTDELE = :HLG_DTDELE ' );
      SQL.Add( '   , HLG_HRDELE = :HLG_HRDELE ' );
      SQL.Add( ' WHERE AUTOINCREM = :AUTOINCREM ');
      ParamByName('HLG_USDELE').AsString := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
      ParamByName('HLG_DTDELE').AsDate := Date();
      ParamByName('HLG_HRDELE').AsTime := fTime();
      ParamByName('AUTOINCREM').AsInteger := intAutoIncrem;
      ExecSQL;
     end;
  finally
    qryAux.Free;
  end;

end;

procedure TDadosRegistraLogCat42.pRegistraLogCat42PeriodoGeradoAq(strMesano, strEmpresa: string);
  var
    intAutoIncrem: Integer;
    qryAux: TUniQuery;
begin

  if not fTabelaExiste('CAT_42_HLG') then
    Exit;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add( '     MAX(AUTOINCREM) AUTOINCREM ');
      SQL.Add( '   FROM ');
      SQL.Add( '     CAT_42_HLG ');
      SQL.Add( '   WHERE HLG_CODEMP = :CODEMP ');
      SQL.Add( '     AND HLG_MESANO = :MESANO ');
      ParamByName('CODEMP').AsString := strEmpresa;
      ParamByName('MESANO').AsString := strMesAno;
      Open;

      if FieldByName('AUTOINCREM').AsInteger = 0 then
        intAutoIncrem:= -1
      else
        intAutoIncrem:= FieldByName('AUTOINCREM').AsInteger;

      Close;
      SQL.Clear;
      SQL.Add( ' UPDATE ');
      SQL.Add( '   CAT_42_HLG ');
      SQL.Add( ' SET ');
      SQL.Add( '   HLG_GERADO = "S" ');
      SQL.Add( '   , HLG_USGERA = :HLG_USGERA ' );
      SQL.Add( '   , HLG_DTGERA = :HLG_DTGERA ' );
      SQL.Add( '   , HLG_HRGERA = :HLG_HRGERA ' );
      SQL.Add( ' WHERE AUTOINCREM = :AUTOINCREM ');
      ParamByName('HLG_USGERA').AsString := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
      ParamByName('HLG_DTGERA').AsDate := Date();
      ParamByName('HLG_HRGERA').AsTime := fTime();
      ParamByName('AUTOINCREM').AsInteger := intAutoIncrem;
      ExecSQL;
     end;
  finally
    qryAux.Free;
  end;

end;

end.
