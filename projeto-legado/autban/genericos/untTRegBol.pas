unit untTRegBol;

interface

uses Classes, SysUtils, Controls, ComCtrls, UniClientDataSet,Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema,
     Data.DB;

Type

  TRequisicaoRegistroBoleto = Class
    LDuplic : String;
    LJsoEnv : String;
    LJsoRec : String;
    LExcept : String;
    LCartei : String;
    LCodBco : String;
    LLocImp : String;
    LLnkApi : String;
    FRequisicao: String;
    FDescricao:String;
  End;

  TRegBol = Class
    public
      Class procedure GravarRequisicaoReqistroBoleto(ARequisicaoRegistroBoleto: TRequisicaoRegistroBoleto);
    private
      Class function GetStrValue(AValue: String):Variant;
  End;


  implementation

uses
  untModulo;

{ TRegBol }

Class function TRegBol.GetStrValue(AValue : String): Variant;
begin
  If fEmptyStr(AValue) Then Result := Null
  Else Result := AValue;
end;

class procedure TRegBol.GravarRequisicaoReqistroBoleto(ARequisicaoRegistroBoleto: TRequisicaoRegistroBoleto);
  Var
    LRegBol : TUniQuery;
    LSql    : String;
    LReqEnv : TStringList;
    LConexao: TCriarConexao;
begin
  Try
    LConexao := TCriarConexao.Create('TRegBol.GravarRequisicaoReqistroBoleto');
    LRegBol := fCriaQuery(Nil,LConexao.objConexao);
    LReqEnv := TStringList.Create;

    fStartTransaction(LConexao.objConexao);
    LSql := '';
    LSql := LSql +' INSERT INTO REGBOL (      ';
    LSql := LSql +'      AUTOINCREM,          ';
    LSql := LSql +'      REG_CARTEI,          ';
    LSql := LSql +'      REG_CODBCO,          ';
    LSql := LSql +'      REG_JSOENV,          ';
    LSql := LSql +'      REG_DUPLIC,          ';
    LSql := LSql +'      REG_CODOPE,          ';
    LSql := LSql +'      REG_DTAREG,          ';
    LSql := LSql +'      REG_HRAREG,          ';
    LSql := LSql +'      REG_EXCEPT,          ';
    LSql := LSql +'      REG_CODEMP,          ';
    LSql := LSql +'      REG_JSOREC,          ';
    LSql := LSql +'      REG_LOCIMP,          ';
    LSql := LSql +'      REG_LNKAPI,          ';
    LSql := LSql +'      REG_DESCRI           ';
    LSql := LSql +'    )                      ';
    LSql := LSql +'    VALUES                 ';
    LSql := LSql +'      (                    ';
    LSql := LSql +'        :AUTOIN,           ';
    LSql := LSql +'        :CARTEI,           ';
    LSql := LSql +'        :CODBCO,           ';
    LSql := LSql +'        :JSOENV,           ';
    LSql := LSql +'        :DUPLIC,           ';
    LSql := LSql +'        :CODOPE,           ';
    LSql := LSql +'        :DTAREG,           ';
    LSql := LSql +'        :HRAREG,           ';
    LSql := LSql +'        :EXCEPT,           ';
    LSql := LSql +'        :CODEMP,           ';
    LSql := LSql +'        :JSOREC,           ';
    LSql := LSql +'        :LOCIMP,           ';
    LSql := LSql +'        :LNKAPI,           ';
    LSql := LSql +'        :DESCRI            ';
    LSql := LSql +'      )                    ';

    Try
      LRegBol.Close;
      LRegBol.Sql.Clear;
      LRegBol.Sql.Add(LSql);

      If fEmptyStr(ARequisicaoRegistroBoleto.FRequisicao) Then
        LReqEnv.LoadFromFile(ARequisicaoRegistroBoleto.LJsoEnv);

      LRegBol.ParamByName('AUTOIN').AsString := fRetAutoIncrem('REGBOL', VS_strCodEmp);
      LRegBol.ParamByName('CARTEI').AsString := ARequisicaoRegistroBoleto.LCartei;
      LRegBol.ParamByName('CODBCO').AsString := ARequisicaoRegistroBoleto.LCodBco;
      LRegBol.ParamByName('DUPLIC').AsString := ARequisicaoRegistroBoleto.LDuplic;
      LRegBol.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      LRegBol.ParamByName('EXCEPT').Value    := TRegBol.GetStrValue(ARequisicaoRegistroBoleto.LExcept);
      LRegBol.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LRegBol.ParamByName('JSOREC').Value    := TRegBol.GetStrValue(ARequisicaoRegistroBoleto.LJsoRec);
      LRegBol.ParamByName('DTAREG').AsDate   := VS_Date;
      LRegBol.ParamByName('HRAREG').AsTime   := fRetHoraServidor;
      LRegBol.ParamByName('LOCIMP').AsString := ARequisicaoRegistroBoleto.LLocImp;
      LRegBol.ParamByName('LNKAPI').AsString := ARequisicaoRegistroBoleto.LLnkApi;
      LRegBol.ParamByName('DESCRI').AsString := ARequisicaoRegistroBoleto.FDescricao;

      If fEmptyStr(ARequisicaoRegistroBoleto.FRequisicao) Then
        LRegBol.ParamByName('JSOENV').AsString := LReqEnv.Text
      Else
        LRegBol.ParamByName('JSOENV').AsString := ARequisicaoRegistroBoleto.FRequisicao;

      LRegBol.ExecSQL;
      fCommit(LConexao.objConexao);
    Except
      On E : Exception Do
      Begin
        fRollBack(LConexao.objConexao);
		    pMensagensErro(E.Message,  '[TRegBol.GravarRequisicaoReqistroBoleto]');
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
    FreeAndNil(LReqEnv);
    FreeAndNil(LConexao);
  End;
end;

end.
