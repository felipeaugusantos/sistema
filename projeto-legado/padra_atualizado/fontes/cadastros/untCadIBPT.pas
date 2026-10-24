{*********************************************************}
{* CLASSE PARA O CADASTRO DE ALÍQUOTAS DO IBPT           *}
{*                                                       *}
{* DATA......: 12/06/2013                                *}
{* AUTOR.....: NAYARA CARVALHO SILVA                     *}
{*                                                       *}
{******************************************************NC*}

unit untCadIBPT;

interface

uses Classes, DB, Uni, Faturamento.Connections.Functions;

Type
  TValorAliquotaIBPT = Record
    fltNacional : Double;
    fltImportado : Double;
    fltEstadual : Double;
    fltMunicipal : Double;
  End;

Type TCadIBPT = Class (TComponent)
  Private
    FN_C_M_: String;
    FAlqNac: Double;
    FAlqImp: Double;
    FEstado: String;
    FE_x___: String;
    FAlqEst: Double;
    FAlqMun: Double;
    function getAlqImp: String;
    function getAlqNac: String;
    function getN_C_M_: String;
    procedure setAlqImp(const Value: String);
    procedure setAlqNac(const Value: String);
    procedure setN_C_M_(const Value: String);
    function getAlqEst: String;
    function getAlqMun: String;
    function getE_x___: String;
    function getEstado: String;
    procedure setAlqEst(const Value: String);
    procedure setAlqMun(const Value: String);
    procedure setE_x___(const Value: String);
    procedure setEstado(const Value: String);
    procedure pAfterOpen(Dataset: TDataSet);
  Public
    qryTabela: TUniQuery;

    Property strN_C_M_: String Read getN_C_M_ Write setN_C_M_;
    Property strAlqNac: String Read getAlqNac Write setAlqNac;
    Property strAlqImp: String Read getAlqImp Write setAlqImp;
    Property strEstado: String Read getEstado Write setEstado;
    Property strE_x___: String Read getE_x___ Write setE_x___;
    Property strAlqEst: String Read getAlqEst Write setAlqEst;
    Property strAlqMun: String Read getAlqMun Write setAlqMun;

    Constructor Create(Owner: TComponent); Reintroduce;

    Class function fBuscaAlqIBPT(strNcm: String; strEx: String): TValorAliquotaIBPT;

  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils,
  StrUtils,
  untConstantes,
  Shared.Functions.DataSet, untTypesSistema;

{ TCadIBPT }

constructor TCadIBPT.Create(Owner: TComponent);
begin
  inherited;

  Try
    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADIBP WHERE FALSE');
    qryTabela.Open;

    FN_C_M_ := '';
    FE_x___ := '';
    FEstado := '';
    FAlqNac := 0;
    FAlqImp := 0;
    FAlqEst := 0;
    FAlqMun := 0;

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadIBP!' + #13 + E.Message);

  End;

end;

Class function TCadIBPT.fBuscaAlqIBPT(strNcm: String; strEx: String): TValorAliquotaIBPT;
Var
  strEstado: String;
  ValorAliquotaIBPT: TValorAliquotaIBPT;
  objDadosIBPT: IMyCampoTabela;
begin
  Try
    FillChar(ValorAliquotaIBPT, SizeOf(TValorAliquotaIBPT), 0);

    Result := ValorAliquotaIBPT;

    strEstado := fCadEmp('ESTADO');

    objDadosIBPT := fCampoTabelaArray(['IBP_ESTADO','IBP_ALQNAC','IBP_ALQIMP','IBP_ALQEST','IBP_ALQMUN'],
      'CADIBP', ['IBP_N_C_M_', 'IBP_E_X___', 'IBP_ESTADO'], [strNcm, strEx, strEstado], False);

    If fEmptyStr(objDadosIBPT.FieldByName('IBP_ESTADO')) Then
      objDadosIBPT := fCampoTabelaArray(['IBP_ESTADO','IBP_ALQNAC','IBP_ALQIMP','IBP_ALQEST','IBP_ALQMUN'],
        'CADIBP', ['IBP_N_C_M_', 'IBP_E_X___', 'IBP_ESTADO'], [LeftStr(strNcm,4), strEx, strEstado], False);

    If fEmptyStr(objDadosIBPT.FieldByName('IBP_ESTADO')) Then
      objDadosIBPT := fCampoTabelaArray(['IBP_ESTADO','IBP_ALQNAC','IBP_ALQIMP','IBP_ALQEST','IBP_ALQMUN'],
        'CADIBP', ['IBP_N_C_M_', 'IBP_E_X___', 'IBP_ESTADO'], [LeftStr(strNcm,2), strEx, strEstado], False);

    If Not fEmptyStr(objDadosIBPT.FieldByName('IBP_ESTADO')) Then
    Begin

      ValorAliquotaIBPT.fltNacional  := objDadosIBPT.FieldByName('IBP_ALQNAC');
      ValorAliquotaIBPT.fltImportado := objDadosIBPT.FieldByName('IBP_ALQIMP');
      ValorAliquotaIBPT.fltEstadual  := objDadosIBPT.FieldByName('IBP_ALQEST');
      ValorAliquotaIBPT.fltMunicipal := objDadosIBPT.FieldByName('IBP_ALQMUN');

      Result := ValorAliquotaIBPT;

    End;
  Finally

  End;
end;

function TCadIBPT.getAlqEst: String;
begin
  Result := FloatToStrF(FAlqEst,ffNumber,12,2);
end;

function TCadIBPT.getAlqImp: String;
begin
  Result := FloatToStrF(FAlqImp,ffNumber,12,2);
end;

function TCadIBPT.getAlqMun: String;
begin
  Result := FloatToStrF(FAlqMun,ffNumber,12,2);
end;

function TCadIBPT.getAlqNac: String;
begin
  Result := FloatToStrF(FAlqNac,ffNumber,12,2);
end;

function TCadIBPT.getEstado: String;
begin
  Result := FEstado;
end;

function TCadIBPT.getE_x___: String;
begin
  Result := FE_x___;
end;

function TCadIBPT.getN_C_M_: String;
begin
  Result := FN_C_M_;
end;

procedure TCadIBPT.pAfterOpen(Dataset: TDataSet);
begin
  TFloatField(qryTabela.FieldByname('IBP_ALQNAC')).EditFormat   := '#,##0.00';
  TFloatField(qryTabela.FieldByname('IBP_ALQNAC')).DisplayFormat:= '#,##0.00';

  TFloatField(qryTabela.FieldByname('IBP_ALQIMP')).EditFormat   := '#,##0.00';
  TFloatField(qryTabela.FieldByname('IBP_ALQIMP')).DisplayFormat:= '#,##0.00';

  TFloatField(qryTabela.FieldByname('IBP_ALQEST')).EditFormat   := '#,##0.00';
  TFloatField(qryTabela.FieldByname('IBP_ALQEST')).DisplayFormat:= '#,##0.00';

  TFloatField(qryTabela.FieldByname('IBP_ALQMUN')).EditFormat   := '#,##0.00';
  TFloatField(qryTabela.FieldByname('IBP_ALQMUN')).DisplayFormat:= '#,##0.00';
end;

procedure TCadIBPT.setAlqEst(const Value: String);
begin
  If (fEmptyStr(Value)) or (fStrToFloat(Value) < 0) Then
    Raise ExceptionAutCom.Create('Tributação Estadual deve ser maior ou igual a zero!')
  Else
    FAlqEst := fStrToFloat(Value);
end;

procedure TCadIBPT.setAlqImp(const Value: String);
begin
  If (fEmptyStr(Value)) or (fStrToFloat(Value) < 0) Then
    Raise ExceptionAutCom.Create('Tributação Federal para Importados deve ser maior ou igual a zero!')
  Else
    FAlqImp := fStrToFloat(Value);
end;

procedure TCadIBPT.setAlqMun(const Value: String);
begin
  If (fEmptyStr(Value)) or (fStrToFloat(Value) < 0) Then
    Raise ExceptionAutCom.Create('Tributação Municipal deve ser maior ou igual a zero!')
  Else
    FAlqMun := fStrToFloat(Value);
end;

procedure TCadIBPT.setAlqNac(const Value: String);
begin
  If (fEmptyStr(Value)) or (fStrToFloat(Value) < 0) Then
    Raise ExceptionAutCom.Create('Tributação Federal para Nacionais deve ser maior ou igual a zero!')
  Else
    FAlqNac := fStrToFloat(Value);
end;

procedure TCadIBPT.setEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TCadIBPT.setE_x___(const Value: String);
begin
  If (Not fEmptyStr(Value)) Then
    FE_x___ := fStrZero(Value, 3)
  Else
    FE_x___ := '';
end;

procedure TCadIBPT.setN_C_M_(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O NCM deve ser preenchido!')
  Else If Not(Length(Value) in [2,4,8]) Then
    Raise ExceptionAutCom.Create('O NCM deve possuir 2, 4 ou 8 dígitos.')
  Else
    FN_C_M_ := Value;
end;

end.
