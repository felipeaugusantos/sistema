unit untConfigOcultaInfo;

interface

uses
  System.SysUtils, untFuncoesSimples, Uni;

type
  TOcultInfo = class
    private
      FQryConf: TUniQuery;
      FCodEmp: String;
      FOcultStaPed: Boolean;
      FOcultPnlInf: Boolean;
      FOcultFerMun: Boolean;

      procedure pInsereConfiguracao;
      procedure pAlteraConfiguracao(AAutInc: String);
    public
      constructor Create(ACodEmp: String = '');
      destructor Destroy; override;

      procedure pAtualizaConfiguracao;
      procedure pRestauraPadrao;
      procedure pCarregaConfiguracao;

      property OcultStaPed: Boolean read FOcultStaPed write FOcultStaPed;
      property OcultPnlInf: Boolean read FOcultPnlInf write FOcultPnlInf;
      property OcultFerMun: Boolean read FOcultFerMun write FOcultFerMun;
  end;

implementation

{ TOcultInfo }

constructor TOcultInfo.Create(ACodEmp: String);
begin
  FQryConf := fCriaQuery;
  FCodEmp := IIF(fEmptyStr(ACodEmp), VS_strCodEmp, ACodEmp);
  FOcultStaPed := False;
  FOcultPnlInf := False;
  FOcultFerMun := False;
end;

destructor TOcultInfo.Destroy;
begin
  FreeAndNil(FQryConf);
  inherited;
end;

procedure TOcultInfo.pAlteraConfiguracao(AAutInc: String);
begin
  FQryConf.Close;
  FQryConf.SQL.Clear;
  FQryConf.SQL.Add('UPDATE CFGOCU');
  FQryConf.SQL.Add('SET OCU_STAPED = :STAPED,');
  FQryConf.SQL.Add('OCU_PNLINF = :PNLINF, ');
  FQryConf.SQL.Add('OCU_FERMUN = :FERMUN');
  FQryConf.SQL.Add('WHERE AUTOINCREM = :AUTINC');
  FQryConf.ParamByName('STAPED').AsBoolean := IIF(fCfgSis('EXISTA', varBoolean), FOcultStaPed, False);
  FQryConf.ParamByName('PNLINF').AsBoolean := FOcultPnlInf;
  FQryConf.ParamByName('FERMUN').AsBoolean := FOcultFerMun;
  FQryConf.ParamByName('AUTINC').AsString := AAutInc;
  FQryConf.ExecSQL;
end;

procedure TOcultInfo.pAtualizaConfiguracao;
var
  LAutInc: String;
begin
  LAutInc := fCampoTabela('AUTOINCREM', 'CFGOCU', ['OCU_CODEMP'], [FCodEmp]);

  if fEmptyStr(LAutInc) then
    pInsereConfiguracao
  else
    pAlteraConfiguracao(LAutInc);
end;

procedure TOcultInfo.pCarregaConfiguracao;
begin
  FOcultStaPed := False;
  FOcultPnlInf := False;
  FOcultFerMun := False;

  FQryConf.Close;
  FQryConf.SQL.Clear;
  FQryConf.SQL.Add('SELECT OCU_STAPED, OCU_PNLINF, OCU_FERMUN');
  FQryConf.SQL.Add('FROM CFGOCU');
  FQryConf.SQL.Add('WHERE OCU_CODEMP = :CODEMP');
  FQryConf.ParamByName('CODEMP').AsString := FCodEmp;
  FQryConf.Open;

  if FQryConf.IsEmpty then
    Exit;

  FOcultStaPed := IIF(fCfgSis('EXISTA', varBoolean), FQryConf.FieldByName('OCU_STAPED').AsBoolean, False);
  FOcultPnlInf := FQryConf.FieldByName('OCU_PNLINF').AsBoolean;
  FOcultFerMun := FQryConf.FieldByName('OCU_FERMUN').AsBoolean;
end;

procedure TOcultInfo.pInsereConfiguracao;
begin
  FQryConf.Close;
  FQryConf.SQL.Clear;
  FQryConf.SQL.Add('INSERT INTO CFGOCU(AUTOINCREM, OCU_CODEMP, OCU_STAPED, OCU_PNLINF, OCU_FERMUN)');
  FQryConf.SQL.Add('VALUES(:AUTINC, :CODEMP, :STAPED, :PNLINF, :FERMUN)');
  FQryConf.ParamByName('AUTINC').AsString := fRetAutoIncrem('CFGOCU', FCodEmp);
  FQryConf.ParamByName('CODEMP').AsString := FCodEmp;
  FQryConf.ParamByName('STAPED').AsBoolean := IIF(fCfgSis('EXISTA', varBoolean), FOcultStaPed, False);
  FQryConf.ParamByName('PNLINF').AsBoolean := FOcultPnlInf;
  FQryConf.ParamByName('FERMUN').AsBoolean := FOcultFerMun;
  FQryConf.ExecSQL;
end;

procedure TOcultInfo.pRestauraPadrao;
begin
  FQryConf.Close;
  FQryConf.SQL.Clear;
  FQryConf.SQL.Add('UPDATE CFGOCU');
  FQryConf.SQL.Add('SET OCU_STAPED = :STAPED,');
  FQryConf.SQL.Add('OCU_PNLINF = :PNLINF, ');
  FQryConf.SQL.Add('OCU_FERMUN = :FERMUN');
  FQryConf.SQL.Add('WHERE OCU_CODEMP = :CODEMP');
  FQryConf.ParamByName('STAPED').AsBoolean := False;
  FQryConf.ParamByName('PNLINF').AsBoolean := False;
  FQryConf.ParamByName('FERMUN').AsBoolean := False;
  FQryConf.ParamByName('CODEMP').AsString := FCodEmp;
  FQryConf.ExecSQL;
end;

end.
