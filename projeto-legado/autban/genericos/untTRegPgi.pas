unit untTRegPgi;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ComCtrls, Uni,
     System.StrUtils, System.Variants, untTypesSistema;

Type

  TRequisicaoRegistroAPI = class
    public
      DataRegistro: TDateTime;

      HoraRegistro: TTime;

      Carteira,
      CodigoBanco,
      CodigoEmpresa,
      LinkAPI,
      JsonEnviado,
      JsonRecebido,
      TextoErro,
      DescricaoRequisicao: String;

      CodigoStatusRetorno: Integer;
  End;

  TRegPGI = Class
    private
      class function GetStrValue(AValue: String):Variant;
    public
      class procedure GravarRequisicaoReqistroAPI(ARequisicaoRegistroAPI: TRequisicaoRegistroAPI);
  End;

implementation
Uses untFuncoesSImples;

{ TRegPGI }

Class function TRegPgi.GetStrValue(AValue : String): Variant;
begin
  If fEmptyStr(AValue) Then
    Exit(Null);

  Result := AValue;
end;

class procedure TRegPGI.GravarRequisicaoReqistroAPI(ARequisicaoRegistroAPI: TRequisicaoRegistroAPI);
  Var
    LInserir: TUniQuery;

    LSQL: String;

    LCommitar: Boolean;
begin
  LInserir := fCriaQuery;

  Try
    LCommitar := Not fInTransaction;

    LSQL := '';
    LSQL := LSQL +' INSERT INTO REGPGI (      ';
    LSQL := LSQL +'      AUTOINCREM,          ';
    LSQL := LSQL +'      REG_CARTEI,          ';
    LSQL := LSQL +'      REG_CODBCO,          ';
    LSQL := LSQL +'      REG_CODEMP,          ';
    LSQL := LSQL +'      REG_LNKAPI,          ';
    LSQL := LSQL +'      REG_DTAREG,          ';
    LSQL := LSQL +'      REG_HRAREG,          ';
    LSQL := LSQL +'      REG_JSOENV,          ';
    LSQL := LSQL +'      REG_JSOREC,          ';
    LSQL := LSQL +'      REG_EXCEPT,          ';
    LSQL := LSQL +'      REG_CODOPE,          ';
    LSQL := LSQL +'      REG_DESCRI,          ';
    LSQL := LSQL +'      REG_STATUS           ';

    LSQL := LSQL +'    ) VALUES (             ';

    LSQL := LSQL +'        :AUTOIN,           ';
    LSQL := LSQL +'        :CARTEI,           ';
    LSQL := LSQL +'        :CODBCO,           ';
    LSQL := LSQL +'        :CODEMP,           ';
    LSQL := LSQL +'        :LNKAPI,           ';
    LSQL := LSQL +'        :DTAREG,           ';
    LSQL := LSQL +'        :HRAREG,           ';
    LSQL := LSQL +'        :JSOENV,           ';
    LSQL := LSQL +'        :JSOREC,           ';
    LSQL := LSQL +'        :EXCEPT,           ';
    LSQL := LSQL +'        :CODOPE,           ';
    LSQL := LSQL +'        :DESCRI,           ';
    LSQL := LSQL +'        :STATUS            ';
    LSQL := LSQL +'      )                    ';

    Try
      LInserir.SQL.Text := LSQL;

      LInserir.ParamByName('AUTOIN').AsString := fRetAutoIncrem('REGPGI', VS_strCodEmp);
      LInserir.ParamByName('CARTEI').AsString := ARequisicaoRegistroAPI.Carteira;
      LInserir.ParamByName('CODBCO').AsString := ARequisicaoRegistroAPI.CodigoBanco;
      LInserir.ParamByName('CODEMP').AsString := ARequisicaoRegistroAPI.CodigoEmpresa;
      LInserir.ParamByName('LNKAPI').AsString := ARequisicaoRegistroAPI.LinkAPI;
      LInserir.ParamByName('DTAREG').AsDate   := ARequisicaoRegistroAPI.DataRegistro;
      LInserir.ParamByName('HRAREG').AsTime   := ARequisicaoRegistroAPI.HoraRegistro;
      LInserir.ParamByName('JSOENV').Value    := GetStrValue(ARequisicaoRegistroAPI.JsonEnviado);
      LInserir.ParamByName('JSOREC').Value    := GetStrValue(ARequisicaoRegistroAPI.JsonRecebido);
      LInserir.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      LInserir.ParamByName('EXCEPT').Value    := GetStrValue(ARequisicaoRegistroAPI.TextoErro);
      LInserir.ParamByName('DESCRI').AsString := ARequisicaoRegistroAPI.DescricaoRequisicao;
      LInserir.ParamByName('STATUS').AsInteger:= ARequisicaoRegistroAPI.CodigoStatusRetorno;

      If LCommitar Then
        fStartTransaction;

      LInserir.ExecSQL;

      If LCommitar Then
        fCommit;
    Except
      On E : Exception Do
      BEgin
        If LCommitar Then
          fRollback;

        Raise Exception.Create(E.Message + '[TRegPGI.GravarRequisicaoReqistroAPI]');
      End;
    End;

  Finally
    FreeAndNil(LInserir);
  End;
end;

end.
